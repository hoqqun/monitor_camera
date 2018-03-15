require 'sinatra'

def make_picture_paths

  path = "public/picture"

  dir = Dir.open(path)

  # ディレクトリ名のソート降順
  dir_list = dir.entries
  dir_list.delete('.')
  dir_list.delete('..')
  dir_list.sort! {|a, b| (-1) * (a <=> b) }

  picture_paths = []

  dir_list.each do |dir_name|

    pictures_dir = Dir.open(path + '/' + dir_name)
    pictures_dir_list = pictures_dir.entries
    pictures_dir_list.delete('.')
    pictures_dir_list.delete('..')
    pictures_dir_list.sort!

    picture_paths << [dir_name,pictures_dir_list]

  end
   picture_paths
end


get '/' do
  
  @picture_path = make_picture_paths
  erb :index
end

get '/show/:timestamp' do
  paths = make_picture_paths
  @detail = nil
  paths.each do |path|
    if path[0] == params['timestamp']
      @detail = path
      break
    end
  end

  @detail
  print @detail
  erb:show
end