class UsersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!, :only => [:edit, :update, :destroy]
  require 'rubygems'

  def show
    @user = User.find(params[:id])
    
    
  end #show controller

end  #the entire Users_controller
