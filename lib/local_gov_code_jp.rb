require "local_gov_code_jp/version"
require "json"

module LocalGovCodeJp
  Prefecture = Struct.new('Prefecture', :type, :code, :name, :kana, :cities) do
    def self.find(code); PREFECTURES_HASH[code]; end
    def self.all; PREFECTURES; end
  end
  City = Struct.new('City', :type, :code, :name, :kana, :pref_code, :wards) do
    def self.find(code); CITIES_HASH[code]; end
    def self.all; CITIES; end
    def prefecture_code; pref_code; end
    def prefecture; Prefecture.find(pref_code); end
  end
  Ward = Struct.new('Ward', :type, :code, :name, :kana, :city_code) do
    def self.find(code); WARDS_HASH[code]; end
    def self.all; WARDS; end
    def city; City.find(city_code); end
    def prefecture; city.prefecture; end
  end

  # initialize
  PREFECTURES = JSON.parse(File.read('./data/prefectures.json')).map { |o| Prefecture.new(o['type'], o['code'], o['name'], o['kana'], []) }.freeze
  CITIES = JSON.parse(File.read('./data/cities.json')).map { |o| City.new(o['type'], o['code'], o['name'], o['kana'], o['pref_code'], []) }.freeze
  WARDS = JSON.parse(File.read('./data/wards.json')).map { |o| Ward.new(o['type'], o['code'], o['name'], o['kana'], o['city_code']) }.freeze
  PREFECTURES_HASH = PREFECTURES.each_with_object({}) { |o, hash| hash[o.code] = o }
  CITIES_HASH = CITIES.each_with_object({}) { |o, hash| hash[o.code] = o }
  WARDS_HASH = WARDS.each_with_object({}) { |o, hash| hash[o.code] = o }

  WARDS.each { |ward| ward.city.wards << ward }
  CITIES.each { |city| city.prefecture.cities << city }
  PREFECTURES.each { |prefecture| prefecture.freeze; prefecture.cities.freeze }
  CITIES.each { |city| city.freeze; city.wards.freeze }
  WARDS.each { |ward| ward.freeze }
end
