require 'sinatra'
require 'sinatra/contrib/all' if development?

get '/'  do
	erb :home
end
	