class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    tall_enough, enough_tickets = requirements
    if tall_enough && enough_tickets
      start_up_ride
    elsif !tall_enough && enough_tickets
      "Sorry. " + not_tall_enough
    elsif tall_enough && !enough_tickets
      "Sorry. " + not_enough_tickets
    else
      "Sorry. " + not_enough_tickets + " " + not_tall_enough
    end
  end

  def requirements
    tall_enough = false
    enough_tickets = false
    tall_enough = true if self.user.height >= self.attraction.min_height
    enough_tickets = true if self.user.tickets >= self.attraction.tickets
    return [tall_enough, enough_tickets]
  end

  def start_up_ride
    take_tickets = self.user.tickets - self.attraction.tickets
    nauseate =  self.user.nausea + self.attraction.nausea_rating
    make_happy = self.user.happiness + self.attraction.happiness_rating
    self.user.update(:tickets => take_tickets, :nausea => nauseate, :happiness => make_happy)
    "Thanks for riding the #{self.attraction.name}!"
  end

  def not_tall_enough
    "You are not tall enough to ride the #{self.attraction.name}."
  end

  def not_enough_tickets
    "You do not have enough tickets to ride the #{self.attraction.name}."
  end
end
