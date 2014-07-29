class Ability
  include CanCan::Ability

  def initalize(user)
    user ||=User.new
    if user.role? :admin
        can :manage, :all
    else
        can :read, :all
    end
    end



end