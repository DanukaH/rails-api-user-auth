# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      # Admin user abilities
      can :manage, :Group
    end
  end
end
