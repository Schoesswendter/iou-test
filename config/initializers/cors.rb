# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'
      resource '/*', headers: :any, methods: %i(get post put patch delete options head)
    end
   
    allow do
      origins '*', 'localhost:3000', '127.0.0.1:3000', 'https://vigilant-mcnulty-c96704.netlify.com/'
      resource '/api/v1/*',
        headers: :any,methods: %i(get post put patch delete options head)
    end
  end