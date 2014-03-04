require 'optparse'

module PageSpeed
  class CLI

    class << self
      KEY_PATH = File.join(ENV['HOME'], '.pagespeed_api_key')

      # parse and set the options
      def set_options(args)
        # set default options
        options = {}
        options['strategy'] = 'desktop'

        @opts = OptionParser.new do |opts|
          opts.banner = "Usage: pagespeed [url] [options]"

          opts.separator ''

          opts.on( '-s', '--strategy [STRATEGY]', 'The strategy to use when analyzing the page. Valid values are \'desktop\' and \'mobile\'.') do |s|
            if s == nil
              print_usage_and_exit!
            end
            options['strategy'] = s
          end

          opts.on('-v', '--version', 'Show the pagespeed version and exit') do
            puts "pagespeed v#{PageSpeed::VERSION}"
            exit
          end

          opts.on( '-h', '--help', 'Display this help' ) do
            puts opts
            exit
          end

        end

        @opts.parse!(args)
        options
      end

      # print out the options banner and exit
      def print_usage_and_exit!
        puts @opts
        exit
      end

      # get the api key from ~/.pagespeed_api_key
      # if we can't find it, show a user how to get one
      def get_api_key
        if File.exist?(KEY_PATH)
          File.read(KEY_PATH).gsub(/\s/, '')
        else
          instructions = <<-INSTRUCTIONS
          \033[31mLooks like you don't have an API key\033[0m
            - visit the Google APIs Console. here: `https://code.google.com/apis/console'
            - in the Services pane, activate the Page Speed Online API
            - go to the API Access pane. The key is in the section titled "Simple API Access."
            - paste the key into a file at ~/.pagespeed_api_key or add it with the pagespeed command: `pagespeed add-key YOUR_KEY'
          INSTRUCTIONS
          puts instructions.gsub(/^\s{10}/, '')
          exit
        end
      end

      # save the api key at ~/.pagespeed_api_key
      def save_api_key(key)
        File.open(KEY_PATH, 'w') { |f| f.write(key) }
      end

      # parse the options and make the pagespeed request
      def run!(argv)
        opts = set_options(argv)

        if argv.size == 1
          api_key = get_api_key
          request = PageSpeed::Request.new(argv[0], api_key, opts['strategy'])
          request.pagespeed
        elsif argv.size == 2 && argv[0] == 'add-key'
          save_api_key(argv[1])
        else
          print_usage_and_exit!
        end
      end

    end
  end
end
