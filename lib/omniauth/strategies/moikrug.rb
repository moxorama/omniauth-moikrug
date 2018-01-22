require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MoiKrug < OmniAuth::Strategies::OAuth2
      option :name, "moikrug"

      option :client_options, {
        site: 'https://moikrug.ru/integrations/oauth',
        authorize_url: 'https://moikrug.ru/integrations/oauth/authorize',
        token_url: 'https://moikrug.ru/integrations/oauth/token'
      }



      def request_phase
        super
      end

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get(' /v1/integrations/users/me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'moikrug', 'MoiKrug'
