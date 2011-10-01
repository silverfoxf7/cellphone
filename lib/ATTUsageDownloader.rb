
require 'rubygems'
require 'mechanize'
#TODO this is not done yet





# AT&T specific:
# Acquires contact data for the user
def ATTGetMostRecentRawCallLogs(phone_number, password)
    agent = Mechanize.new
    page = agent.get 'https://www.att.com/olam/loginAction.olamexecute'
    login_form = page.form_with(:id => 'login')
    login_form.userid = phone_number
    login_form.password = password
    page = agent.submit login_form
    
    page = agent.get "https://ebillpay.verizonwireless.com/vzw/accountholder/unbilledusage/UnbilledVoice.action"
    page = agent.page.link_with(:text => 'Download to SpreadSheet').click
    return page.content
end

puts("Enter your phone number")
phone_number = gets()
phone_number.strip!
puts("Enter your password")
password = gets()
password.strip!

puts GetMostRecentRawCallLogs(phone_number, password)