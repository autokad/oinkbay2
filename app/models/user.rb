class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:recoverable,
         :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :firstname, :lastname, :username, :email, :password, :password_confirmation, :remember_me, :provider, :uid
  # attr_accessible :title, :body

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
		user = User.where(:provider => auth.provider, :uid => auth.uid).first
		unless user
			user = User.create(username:auth.extra.raw_info.username,
				firstname: auth.extra.raw_info.first_name,
				lastname: auth.extra.raw_info.last_name,
				provider:auth.provider,
				uid:auth.uid,
				email:auth.info.email,
				password:Devise.friendly_token[0,20]
			)
		end
		user
	end
	
  has_many :pins, dependent: :destroy

  validates_presence_of :username
  validates_uniqueness_of :username
  
  #for voting
  make_voter
end
