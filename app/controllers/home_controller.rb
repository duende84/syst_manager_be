class HomeController < ApplicationController
  def index
    puts "HomeController::index >> current_user: #{current_user}"
    @servers = current_user.servers
  end
end
