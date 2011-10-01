class UsersController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!, :only => [:edit, :update, :destroy]
  require 'rubygems'
  require 'mechanize'
  require 'csv'
      
  def show
    @user = User.find(params[:id])
    phone_number = "5704990445"
    password = "hamilton1"
        
    text = getmostrecentrawcalllogs(phone_number, password)
    
    my_file = File.new("#{RAILS_ROOT}/tmp_parse_me.csv", "w") 
    my_file.puts text
    my_file.close
    
    parse(my_file, @user)
    
  end #show controller

  def parse(file_text, user)
    array = []
    record = {}
    CSV.foreach file_text, :col_sep => "\t" do |row|
      if row[0] == "Date"
    	  puts "DO NOTHING -- THIS IS THE HEADER"
      else
      	unless row[0].blank?
      	  date = DateTime.strptime("#{row[0]}", "%m/%d/%Y").to_date
          puts date_time = (date.to_s + " " + row[1].to_s).to_datetime
    	    record = user.phoners.build(:when => date_time, :phone => row[2], :minutes => row[3], :destination => row[4])
    
        	if record.save
        		puts "Record SAVED"
        	else
        		puts "Record SKIPPED"
        		puts record.errors
        	end
    	
        end
      end
    end
  end

  # Verizon specific:
  # Acquires contact data for the user
  def getmostrecentrawcalllogs(phone_number, password)
      agent = Mechanize.new
      page = agent.get 'https://login.verizonwireless.com/amserver/UI/Login'
      login_form = page.form_with(:id => 'loginForm')
      login_form.IDToken1 = phone_number
      login_form.IDToken2 = password
      page = agent.submit login_form
      page = agent.get "https://ebillpay.verizonwireless.com/vzw/accountholder/unbilledusage/UnbilledVoice.action"
      page = agent.page.link_with(:text => 'Download to SpreadSheet').click
      return page.content
  end

end  #the entire Users_controller
