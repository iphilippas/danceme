module DanceMe
	
	module Helpers
		
		def link_to(text, url, opts={})
    	attributes = ""
    	opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    	"<a href=\"#{url}\" #{attributes}>#{text}</a>"
  	end
		
		def is_signed_in?
			return !!session[:user]
		end

		def current_user
			User.find(session[:user])
		end
	end

end
