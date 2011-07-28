module PageSpeed
  class Parser
    class << self
      
      def parse(json)
        json['formattedResults']['ruleResults'].each do |name, value|
          puts " - #{value['localizedRuleName']} #{value['ruleScore']}"
        end
      end
      
    end
  end
end