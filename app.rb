require File.expand_path('lib/models', File.dirname(__FILE__))
require File.expand_path('lib/helpers', File.dirname(__FILE__))

module DanceMe
	
	class App < Sinatra::Base
		register Sinatra::Namespace
	  
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
			
			get '/sign_up' do
				@user = User.new
				
				erb :'users/sign_up'						
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

					erb :'admin/users/index'
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
