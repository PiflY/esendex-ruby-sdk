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
      # @account_reference = account_reference
      @body = body
    end
    
    def xml_node
      doc = Nokogiri::XML'<messages xmlns="http://api.esendex.com/ns/"><messages/>'
      doc['xmlns'] = "http://api.esendex.com/ns/"

      # account_reference = Nokogiri::XML::Node.new 'accountreference', doc
      # account_reference.content = "EX0207458"
      # doc.root.add_child(account_reference)

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