require 'nokogiri'

module Esendex
  class MessageInformationResult
    attr_reader :parts, :character_set, :available_characters_in_last_part

    def initialize(parts, character_set=nil, available_characters_in_last_part=nil)
      @parts = parts
      @character_set = character_set
      @available_characters_in_last_part = available_characters_in_last_part
    end

    def self.from_xml(source)
      doc = Nokogiri::XML source
      parts = doc.at_xpath('//api:parts', 'api' => Esendex::API_NAMESPACE).content.to_i
      character_set = doc.at_xpath('//api:characterset', 'api' => Esendex::API_NAMESPACE).content
      available_characters_in_last_part = doc.at_xpath('//api:availablecharactersinlastpart', 'api' => Esendex::API_NAMESPACE).content.to_i
      MessageInformationResult.new parts, character_set, available_characters_in_last_part
    end

    def to_s
      parts
    end
  end
end
