require 'nokogiri'

#<messages>
#  <message>
#    <body>$BODY</body>
#    <characterset>Auto</characterset>
#  </message>
#</messages>

module Esendex
  class MessageInformation
    attr_accessor :account_reference, :body
    
    def initialize(body)
      @body = body
    end
    
    def xml_node
      doc = Nokogiri::XML'<messages xmlns="http://api.esendex.com/ns/"><messages/>'

      subdoc = Nokogiri::XML::Node.new 'message', doc

      body = Nokogiri::XML::Node.new 'body', doc
      body.content = @body

      subdoc << body

      characterset = Nokogiri::XML::Node.new 'characterset', doc
      characterset.content = "Auto"

      subdoc << characterset

      doc.root.add_child(subdoc)
      
      doc.root
    end
    
    def to_s
      xml_node.to_s
    end
  end
end