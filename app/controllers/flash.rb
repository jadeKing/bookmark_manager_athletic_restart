post '/set-flash' do
  # set flash notice
  flash[:notice] = 'Thanks for signing up!'
  # get flash notice
  flash[:notice]
  # set flash entry for current request
  flash.now[:notice] = 'Thanks for signing up!'
end
