require 'nokogiri' 
require 'open-uri'  
require 'json' 
require "google_drive"
require "googleauth"

class Spreadsheet

def save_as_spreadsheet
	session = GoogleDrive::Session.from_config("config.json") 
	ws = session.spreadsheet_by_key("1zKXHxtF52AL8ZlZaBsvERz8QtQtDiQy6FdJC_Kn0UOg").worksheets[0]
	i = 2
	mairie.each { |k, v|
		ws[i, 1] = k
		ws[i, 2] = v
		i += 1
	}		
	ws.save
end

def perform	
	save_as_spreadsheet
end

end