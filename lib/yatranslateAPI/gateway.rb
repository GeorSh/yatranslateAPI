require './errors'
require 'json'
require 'httpclient'
require 'uri'

module YatranslateAPI
  class Gateway

    def initialize
      @client = HTTPClient.new
      @error = YatranslateAPI::Errors.new
      @base_url = "https://translate.yandex.net/api/v1.5/tr.json/"
      @body = {
        "Host": "translate.yandex.net",
        "Accept": "*/*",
        "Content-Length": "17",
        "Content-Type": "application/x-www-form-urlencoded"
    }
    end

    def generate_request(method, params = {})
      @url = @base_url + method + hash_to_param(params)
    end

    def send_request
      uri = URI.escape(@url)
      res = @client.post(uri, @body)
      @error.status_check(res)
    end

    private

    def hash_to_param(hash)
      hash.to_a.map { |x| "#{x[0]}=#{x[1]}" }.join("&")
    end
  end
end