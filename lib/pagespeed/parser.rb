require 'json'

module PageSpeed
  class Parser
    class << self

      # parse the response and print it real pretty
      def parse(result)
        result = JSON.parse(result)
        code   = result['responseCode']
        total_score = result['score']
        strategy = result['request']['strategy']

        fail(code, result['title']) unless code == 200

        result['formattedResults']['ruleResults'].each do |name, rule|
          score = rule['ruleScore']
          colorize(score)
          puts " #{pad_score(score)} - #{rule['localizedRuleName']}"
        end

        colorize(total_score)
        puts " \nTotal Score: #{total_score}/100 (#{strategy})"
        decolorize
      end

      private

      # fail with the appropriate code/message
      def fail(code, title)
        puts "\033[31m#{title}\033[0m"
        exit
      end

      # pad the score to make it extra readable
      def pad_score(score)
        score = score.to_s

        case score.length
        when 3
          score
        when 2
          ' ' + score
        when 1
          '  ' + score
        end
      end

      # colorize the good the bad and the ugly
      def colorize(score)
        case score.to_i
        when 90..100
          print "\033[32m"
        when 70..89
          print "\033[33m"
        else
          print "\033[31m"
        end
      end

      # reset colors
      def decolorize
        print "\033[0m"
      end

    end
  end
end
