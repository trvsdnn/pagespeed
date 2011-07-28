require 'optparse'

module PageSpeed
  class CLI
    
    class << self
    
      BANNER = <<-USAGE
      Usage:
        pagespeed google.com

      Description:
        pagespeed pulls in results for a given website from the google pagespeed api
              
      USAGE
      
      # parse and set the options
      def set_options
        @opts = OptionParser.new do |opts|
          opts.banner = BANNER.gsub(/^\s{4}/, '')

          opts.separator ''

          opts.on('-v', '--version', 'Show the pagespeed version and exit') do
            puts "dsync v#{PageSpeed::VERSION}"
            exit
          end

          opts.on( '-h', '--help', 'Display this help' ) do
            puts opts
            exit
          end
        end

        @opts.parse!
      end
    
      # print out the options banner and exit
      def print_usage_and_exit!
        puts @opts
        exit
      end
      
      # get the api key from ~/.pagespeed_api_key
      # if we can't find it, show a user how to get one
      def get_api_key
        key_path = File.join(ENV['HOME'], '.pagespeed_api_key')
        
        if File.exist?(key_path)
          File.read(kay_path)
        else
          puts <<-INSTRUCTIONS
          \033[31mLooks like you don't have an API key\033[0m
            - to acquire a key, visit the Google APIs Console. here: `https://code.google.com/apis/console'
            - in the Services pane, activate the Page Speed Online API
            - go to the API Access pane. The key is in the section titled "Simple API Access."
            - paste the key into a file at ~/.pagespeed_api_key or add it with the pagespeed command: `pagespeed add-key YOUR_KEY'
          INSTRUCTIONS
          exit
        end
      end
      
      # parse the options and make the pagespeed request
      def run!(argv)
        set_options
        
        if argv.size == 1
          PageSpeed::Request.pagespeed(argv[0])
        else
          print_usage_and_exit!
        end
        
      end
      
    end 
  end
end
