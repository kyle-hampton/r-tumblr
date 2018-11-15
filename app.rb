require 'sinatra'
require 'sinatra/activerecord'
require "./models"
set :database, "sqlite3:second.sqlite3"
set :sessions, true #this save the data from the server to the cookies in the browser




def userCollection
  @user = User.find(params[:id])
end

def blogCollection
  @blog = Blog.find(params[:id])
end

################################################################################
            ######## get method #######
get '/' do
  @blogs = Blog.all
  erb :home
end
################################################################################
              ######## get method #######
get '/new-post' do

  erb :newpost
end

              ######## post method #######
post '/blog_input' do

  title = params[:title]
  content = params[:content]

  Blog.create(title: title, content: content, user_id: params[:user_id])

  redirect '/'
end

################################################################################
get '/currentBlog/:id' do

  blogCollection
  erb :current
end

get '/currentBlog/:id/edit' do

  blogCollection
  erb :edit
end

################################################################################
post '/update/:id' do   ######## update method #######
  blogCollection

    if @blog.update(title: params[:title], content: params[:content])
      redirect '/'
    else
      erb '/currentBlog/<%= @blog.id %>/edit'
    end
end


post '/destroy/:id' do   ######## delete method #######

  blogCollection

  if @blog.destroy
    redirect '/'
  end

end

################################################################################
get '/signup' do

  erb :signup
end

post '/signup' do     ######## signup method #######
  username = params[:username]
  password = params[:password]
  first_name = params[:first_name]
  last_name = params[:last_name]
  email = params[:email]
  birthday = params[:birthday]
  user = User.new(username: username, password: password, first_name: first_name, last_name: last_name, email: email, birthday: birthday)
    if user.save
      redirect "/"
    else
      erb :home
    end
end

################################################################################
get '/login' do

  erb :login
end

post '/login' do     ######## login method #######
  user = User.where(username: params[:username], password: params[:password]).first
  # puts user.id
  if user.password == params[:password]
    session[:user_id] = user.id
    redirect "/user/#{user.id}"
  else
    erb :home
  end
end

################################################################################


post '/logout' do
    session[:user_id] = nil

  redirect '/'
end

################################################################################
get '/user/:id' do


  @user = User.find(params[:id])
  @blogs = Blog.all

  erb :user
end
################################################################################
get '/account/:id' do

  @user = User.find(params[:id])
  erb :account
end

################################################################################
get '/deleteAccount' do

  erb :deleteAccount
end

post '/deleteAccount/:id' do

  @user = User.find(params[:id])

  if @user.destroy
  redirect '/'
  end
end




################################################################################
