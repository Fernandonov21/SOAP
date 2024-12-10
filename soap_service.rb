require 'savon'

class SoapService
  def self.get_greeting(name)
    client = Savon.client(wsdl: 'http://www.dneonline.com/calculator.asmx?WSDL')
    response = client.call(:add, message: { 'intA' => 5, 'intB' => 10 })
    "Hello, #{name}! The sum is #{response.body[:add_result]}"
  end
end
