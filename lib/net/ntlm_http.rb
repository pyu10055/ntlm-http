#
# = net/ntlm_http.rb
#
# extra stuff to make nltm auth usage as easy as basic for Net::HTTP
# classes
#
require 'net/ntlm'
require 'net/http'

module Net  #:nodoc:

  module HTTPHeader
    # could also try an automatic authentication. sends as basic first, then
    # resends if required, or whatever.
    # seems kind of messy exposing this stuff here.

    def auth_data
      @auth_data
    end

    # can set wait - don't authenticate unless challenged. useful when reusing
    # the connection (otherwise you handshake for each request). wait should
    # probably become the default, allowing the type of authentication to be
    # driven by a server challenge.
    def ntlm_auth user, password, wait=false
      @auth_data = [:ntlm, user, password]
      self['Authorization'] = 'NTLM ' + Net::NTLM::Message::Type1.new.encode64 unless wait
    end
  end

  # here we override the default Net::HTTP#request method, in order to hide the
  # necessary handshaking. maybe a more generic scheme for hooking into this
  # could be useful, for other auth types

  # because of the handshaking i have to rewind body stream. maybe body stream
  # shouldn't be sent when authenticating??
  class HTTPRequest
    def reuse
      if body_stream
        begin   body_stream.rewind
        rescue; raise "error rewinding body stream for authentication"
        end
      end
    end
  end

  class HTTP
    alias old_request :request
    private :old_request

    def request req, body=nil, &block
      resp = data = auth_data = nil
      old_request req, body do |resp|
        wwwauth = resp.header['www-authenticate'].split(",").collect{|x| x.strip} rescue ""
        unless Net::HTTPUnauthorized === resp and auth_data = req.auth_data and
            auth_data[0] == :ntlm and (wwwauth == 'NTLM' || wwwauth.is_a?(Array) && wwwauth.include?('NTLM')) ||
            data = resp['www-authenticate'][/^NTLM (.*)/, 1]
          data = false
          yield resp if block_given?
        end
      end
      return resp if data == false
      # not really sure if i'm supposed to just rewrite the request like this?
      # and the body? what about redirects? the resp.content is just the text error message
      # what about post data?
      req.reuse
      unless data
        # first stage handshake. respond to challenge
        #				puts "* authenticating (0) ..."
        # this time wait is true.
        req.ntlm_auth(*auth_data[1..2])
        request req, body, &block
      else
        #				puts "* authenticating (1) ..."
        challenge = Net::NTLM::Message.decode64 data
        # challenge.target_name could be provided back as a prompt.
        # maybe if password is unspecified, a callback can be used to provide
        # a user prompt.
        domain,dummy,userid = auth_data[1].rpartition('\\')
        resp = challenge.response({:domain=>domain, :user => userid, :password => auth_data[2]}, {:ntlmv2 => true})
        req['Authorization'] = 'NTLM ' + resp.encode64
        old_request(req, body) { |resp| yield resp if block_given? }
        resp
      end
    end
  end
end
