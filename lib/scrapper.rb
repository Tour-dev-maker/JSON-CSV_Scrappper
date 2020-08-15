require 'nokogiri'
require 'pry'
require 'open-uri'
require 'json'
require 'csv'
class Scrapper


def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{townhall_url}"))
  array_of_emails = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text

  array_urls = townhall_url[5..-6] #je recupere encore une fois mon array de urls pour faire le hash juste apres
  #si je n appelle pas mon array d urls, dans mon resultat apparaitra seulement un array d emails (quand j appelle array_final)
 { array_urls => array_of_emails } #je cree mon hash , ainsi ma clef (url)vient s'ajouter a ma valeur(email) 

end

def get_townhall_urls 
  page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
  array_url_name = page.xpath("//a[@class='lientxt']/@href")

  array_final = []
  array_url_name.each do |link_of_url|
    
  array_final << get_townhall_email(link_of_url.text) #array_final est maintenant compose du resultat obtenu par le lancement en boucle de la deuxieme methode.
end
  return array_final #mes hashs ont ete associes a mon premier array des url. 

 end

def save_as_JSON(array_final) #permet d envoyer nos donnes dans le fichier Json
  File.open("db/email.json", "w") do |f|
   f.write(array_final.to_json)
  end
end

def save_as_CSV(array_final)
  CSV.open("db/email.csv","wb") do |csv|
    array_final.each do |h|
      h.each do |h|
     csv << h
      end
    end
  end
end

def perform 
 array_final = get_townhall_urls
 save_as_JSON(array_final)
 save_as_CSV(array_final)
end

end

