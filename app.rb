require File.expand_path('lib/models', File.dirname(__FILE__))
require File.expand_path('lib/helpers', File.dirname(__FILE__))

module DanceMe
	
	class App < Sinatra::Base
		register Sinatra::Namespace
		register Sinatra::AssetPack		

		set :root, File.dirname(__FILE__) # You must set app root


		assets do
			
			serve '/css', from: 'assets/stylesheets'
		 	serve '/js', from: 'assets/javascripts'	
			serve '/images', from: 'assets/images'
			
			css :admin, 'css/admin.css', [
				'/css/foundation.css',
				'/css/normalize.css',
				'/css/admin-core.css'
			]
			
			css :application, 'css/application.css', [
				'/css/foundation.css',
				'/css/normalize.css',
				'/css/front-core.css'
			]

			js :admin, 'js/admin.js', [
				'/js/jquery.js',
				'/js/foundation.js',
				'/js/admin-core.js'
			]

			js_compression  :uglify
  		css_compression :sass
		end
		
		configure do
			enable :sessions
			Mongoid.load!(File.expand_path('mongoid.yml', File.dirname(__FILE__))) # Mongo connection
		end
		
		helpers DanceMe::Helpers	
			
		namespace '/users' do
				
			get do
			end
			
			post do
				user = User.new(params[:user])
      	
				if user.save
        	session[:user] = user._id
					redirect '/'
      	else
        	"Error saving doc"
      	end
			end
			
			get '/sign_in' do
				@user = User.new

				erb :'/users/sign_in'
			end
	
			get '/sign_up' do
				@user = User.new
				
				erb :'users/sign_up'						
			end

			get '/authenticate' do
			
			end
			
			get '/:id' do
				@user = User.find(params[:id])
				erb :'users/profile'
			end

		end
				
		namespace '/admin' do
			get '/' do
				'hello'
			end

			namespace '/users' do
				get '/' do
					@users = User.all

					admin_layout :'admin/users/index'
				end
				
			end

			namespace '/articles' do
				get  do
					@articles = Article.all

					erb :'admin/articles/index'
				end
			
				post do
					article = Article.new(params['article'])

					if article.save
						redirect '/admin/articles/' + article._id
					else
						skkata
					end
				end

				get '/new' do
					@article = Article.new
					@url = '/admin/articles'

					erb :'/admin/articles/form'
				end
			end
			
			get '/articles/:id' do
				@article = Article.find(params[:id])

				erb :'/admin/articles/show'
			end
		end
	end
end
