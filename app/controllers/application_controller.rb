
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do 
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do 
    erb :new
  end

  get "/articles/:id" do 
    @article = Article.find(params[:id])
    erb :show
  end

  post "/articles" do 
    @new_article = Article.new(params)
    @new_article.save
    redirect "/articles/#{@new_article.id}"
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :update
  end

  patch "/articles/:id" do 
    puts params
    Article.update(params[:id], title: params[:title], content: params[:content])
    redirect "articles/#{params[:id]}"
  end

  delete '/articles/:id' do 
    Article.destroy(params[:id])
    redirect to "/articles"
  end
end
