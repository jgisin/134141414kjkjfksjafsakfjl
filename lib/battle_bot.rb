require_relative './weapon.rb'

class BattleBot

  @@count = 0

  attr_reader :name, :health, :enemies, :weapon

  def initialize(name, health = 100, enemies=[], weapon=nil)
    @name = name
    @health = health
    @enemies = enemies
    @weapon = weapon
    @dead = false
    @@count += 1
  end

  def dead?
    @dead
  end

  def has_weapon?
    if @weapon
      true
    else
      false
    end
  end

  def pick_up(weapon)
    raise ArgumentError if weapon.class != Weapon
    raise ArgumentError if weapon.bot
    if @weapon == nil
      @weapon = weapon
      @weapon.bot = self
      return @weapon
    else
      nil
    end
  end

  def drop_weapon
    @weapon.bot=nil
    @weapon = nil
  end

  def take_damage(damage)
    raise ArgumentError unless damage.is_a? Fixnum
      if (@health >= damage)
        @health -= damage
      else
        @health = 0
        @dead = true
        @@count -= 1
      end
  end

  def heal
    if @dead == false && @health <= 90
      @health += 10

    end
  end

  def attack(bot)

    if bot === self || (bot.class != BattleBot) || @weapon == nil
      raise ArgumentError
    end

    bot.receive_attack_from(self)

  end

  def receive_attack_from(bot)
    raise ArgumentError if bot.class != BattleBot
    raise ArgumentError if bot == self
    raise ArgumentError unless bot.weapon

    unless enemies.include?(bot)
      enemies << bot
      self.defend_against(bot)
    end
    self.take_damage(bot.weapon.damage)

  end

  def defend_against(bot)
    if self.dead? == false && self.has_weapon?
      self.attack(bot)
    end

  end

  def self.count
    @@count
  end


end