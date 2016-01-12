class Weapon

  attr_reader :name, :damage, :bot

  def initialize(name, damage=nil)
    @name = name
    @damage = damage
    @bot = nil
  end

  def bot=(battlebot)
    @bot=battlebot
  end

end