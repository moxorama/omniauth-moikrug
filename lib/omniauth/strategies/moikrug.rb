require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class MoiKrug < OmniAuth::Strategies::OAuth2
      option :name, "moikrug"

      option :client_options, {
        site: 'https://api.moikrug.ru/v1/integrations',
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
      uid{ raw_info['login'] }

      info do
        {
          first_name:   raw_info['first_name'],
          last_name:    raw_info['last_name'],
          middle_name:  raw_info['middle_name'],
          email:        raw_info['email'],
          image:        raw_info['avatar'],
          birthday:     raw_info['birthday']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('users/me').parsed
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'moikrug', 'MoiKrug'
