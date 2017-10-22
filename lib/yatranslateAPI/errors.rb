require 'json'
require 'httpclient'

module YatranslateAPI
  class Errors
    
    def status_check(status)
      if status.status != 200
        print_error(status)
        status.status
      else
        JSON.parse(status.content)
      end
    end

    def print_error(status)
      puts JSON.parse(status.content)['message']
    end
  end
end