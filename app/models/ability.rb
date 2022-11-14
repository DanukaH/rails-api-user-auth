# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      # Admin user abilities
      #can :manage, :all
      can [:create, :update], Group
    else
      can [:update], User, id: user.id
    end
  end
end
