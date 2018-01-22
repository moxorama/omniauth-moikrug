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

      uid { raw_info['id'].to_s }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {:raw_info => raw_info, :all_emails => emails}
      end

      def raw_info
        access_token.options[:mode] = :query
        @raw_info ||= access_token.get('user').parsed
      end

      def email
        (email_access_allowed?) ? primary_email : raw_info['email']
      end

      def primary_email
        primary = emails.find{ |i| i['primary'] && i['verified'] }
        primary && primary['email'] || nil
      end

      # The new /user/emails API - http://developer.github.com/v3/users/emails/#future-response
      def emails
        return [] unless email_access_allowed?

        p access_token
        access_token.options[:mode] = :query
        #@emails ||= access_token.get('user/emails', :headers => { 'Accept' => 'application/vnd.github.v3' }).parsed
      end

      def email_access_allowed?
        return false unless options['scope']
        email_scopes = ['user', 'user:email']
        scopes = options['scope'].split(',')
        (scopes & email_scopes).any?
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'moikrug', 'MoiKrug'
