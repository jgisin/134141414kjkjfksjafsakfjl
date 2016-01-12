require_relative './weapon.rb'

class BattleBot
  attr_reader :name, :health, :enemies, :weapon

  def initialize(name, health = 100, enemies=[], weapon=nil)
    @name = name
    @health = health
    @enemies = enemies
    @weapon = weapon
    @dead = false
  end

  def dead?
    @health > 0 ? @dead = false : @dead = true
      return @dead
  end

  def has_weapon?
    if @weapon
      true
    else
      false
    end
  end

  def pick_up(weapon)
    if @weapon == nil
      if weapon.is_a? Weapon
        @weapon = weapon
        @weapon.bot = self
      else
        raise ArgumentError
      end
    else
      nil
    end
  end

  def drop_weapon
    @weapon.bot=nil
    @weapon = nil
  end

  def take_damage(damage)
    if (damage.is_a? Fixnum)
      if (@health >= damage)
        @health -= damage
      end
    else
      raise ArgumentError
    end
  end

  def heal
    if !@dead && @health <= 90
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
    if bot.class != BattleBot
      raise ArgumentError
    end
    unless enemies.include?(bot)
      enemies << bot
      self.defend_against(bot)
    end
   # self.take_damage(@weapon.damage)

  end

  def defend_against(bot)
    self.has_weapon?
    self.dead?
  end

  def self.count

  end


end