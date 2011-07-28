require 'net/https'
require 'uri'

module PageSpeed
  class Request
    PAGESPEED_API_URL = 'https://www.googleapis.com/pagespeedonline/v1/runPagespeed'
    
    attr_accessor :url, :api_key
    
    def initialize(url, api_key)
      @url = url =~ /^https?:\/\// ? url : ('http://' + url )
      @api_key = api_key
      @uri = build_request_uri
    end
    
    def pagespeed
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      request = Net::HTTP::Get.new(@uri.request_uri)
      response = http.request(request)
      
      if response.code.to_i == 200
        PageSpeed::Parser.parse(response.body)
      else
        status_error(response)
      end
      
    rescue Exception => e
      puts e.message
      puts e.backtrace.join("\n")
      puts "\033[31mUh oh, didn't work. Maybe the host is down or the url is wrong... or perhaps google is down :("
      exit
    end
    
    def status_error(response)
      puts "#{response.code}"
      exit
    end
    
    private
    
    def build_request_uri
      uri = URI.parse(PAGESPEED_API_URL)
      uri.query = "url=#{@url}&key=#{@api_key}"
      uri
    end
      
  end
end