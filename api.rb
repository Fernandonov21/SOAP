# api.rb
require 'grape'
require 'grape-swagger'
require 'savon'  # Asegúrate de que esta línea esté aquí

class SoapApi < Grape::API
  format :json
  prefix :api

  add_swagger_documentation(
    api_version: 'v1',
    base_path: '/api',
    hide_documentation_path: true,
    mount_path: '/swagger_doc'
  )

  desc 'Returns a greeting message'
  params do
    requires :name, type: String, desc: 'Name of the user'
  end
  get :greeting do
    name = params[:name]
    # Aquí realizamos la llamada SOAP con Savon
    client = Savon.client(wsdl: 'http://www.dneonline.com/calculator.asmx?WSDL')
    response = client.call(:add, message: { 'intA' => 5, 'intB' => 10 })
    
    # Accedemos al resultado de la operación SOAP
    sum_result = response.body[:add_response][:add_result]
    
    { greeting: "Hello, #{name}! The sum is #{sum_result}" }
  end
end
