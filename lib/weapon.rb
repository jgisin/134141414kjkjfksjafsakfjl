class Weapon

  attr_reader :name, :damage, :bot

  def initialize(name, damage=0)
    raise ArgumentError if name.class != String
    @name = name
    raise ArgumentError if damage.class != Fixnum
    @damage = damage
    @bot = nil
  end

  def bot=(battlebot = nil)
    unless battlebot == nil
      raise ArgumentError if battlebot.class != BattleBot
    end
    @bot=battlebot
  end

  def picked_up?
    !!@bot
  end



end