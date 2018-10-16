require_relative 'controllers/menu_controller'

menu = MenuController.new

system "clear"

puts "Welcome to AddressBook!"

menu.main_menu    #call main_menu to display the menu
