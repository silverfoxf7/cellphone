
require 'rubygems'
require 'mechanize'

# Verizon specific:
# Acquires contact data for the user
def GetMostRecentRawCallLogs(phone_number, password)
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

puts("Enter your phone number")
phone_number = gets()
phone_number.strip!
puts("Enter your password")
password = gets()
password.strip!

puts GetMostRecentRawCallLogs(phone_number, password)