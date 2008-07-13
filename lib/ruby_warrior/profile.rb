require 'base64'

module RubyWarrior
  class Profile
    attr_accessor :score, :abilities
    attr_reader :warrior_name, :level_number
    
    def initialize(tower_path, warrior_name)
      @tower_path = tower_path
      @warrior_name = warrior_name
      @score = 0
      @abilities = []
      @level_number = 0
    end
    
    def encode
      Base64.encode64(Marshal.dump(self))
    end
    
    def self.decode(str)
      Marshal.load(Base64.decode64(str))
    end
    
    def self.load(path)
      decode(File.read(path))
    end
    
    def to_s
      [warrior_name, File.basename(@tower_path), "level #{level_number}", "score #{score}"].join(' - ')
    end
    
    def tower
      Tower.new(@tower_path)
    end
    
    def current_level
      tower.build_level(level_number, self)
    end
    
    def next_level
      tower.build_level(level_number+1, self)
    end
  end
end
