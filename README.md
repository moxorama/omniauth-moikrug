
This gem contains the MoiKrug strategy for OmniAuth.

### Before You Begin

You should have already installed OmniAuth into your app; if not, read the OmniAuth README to get started.

Now sign in into the MoiKrug account  and create an application here - https://moikrug.ru/profile/applications. Take note of your API Key and API Secret (not the Access Token and Access Token Secret) because that is what your web application will use to authenticate against the MoiKrug API. Make sure to set a callback URL or else you may get authentication errors. (It doesn't matter what it is, just that it is set.)

### Using This Strategy

First start by adding this gem to your Gemfile:

```
gem 'omniauth-twitter', :github => 'moxorama/omniauth-moikrug'
```


Next, tell OmniAuth about this provider. For a Rails app, your config/initializers/omniauth.rb file should look like this:

```
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :moikrug, "API_KEY", "API_SECRET"
end
```
