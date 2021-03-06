require "rubygems"
require "sinatra"
require "haml"
require "mongo_mapper"

require "models/book"
require "models/user"
require "models/comment"

# MongoMapper settings
MongoMapper.connection = Mongo::Connection.new('localhost')
MongoMapper.database = 'book_review'

get '/' do
	haml :index, {}, :books => Book.all(:order => 'title'), :users => User.all(:order => 'name'), :action => '/comments'
end

get '/books' do
	haml :book, {}, :books => Book.all(:order => 'title'), :action => '/books'
end

post '/books' do
	Book.create(params[:post])
	redirect '/books'
end

post '/comments' do
	user = User.find(params[:post][:user])

	b = Book.find(params[:post][:book])
	b.comments << Comment.new(:content => params[:post][:content], :created_date => Time.now, :user => user)
	b.save

	redirect '/'
end

get '/users' do
	haml :user, {}, :users => User.all(:order => 'name'), :action => '/users'
end

post '/users' do
	User.create(params[:post])
	redirect '/users'
end
