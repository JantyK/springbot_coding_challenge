require 'rails_helper'

  RSpec.describe Review, type: :model do
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:restaurant_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_inclusion_of(:rating).in_range(1..5) }
    it { should_not allow_value(0).for(:rating) }
    it { should_not allow_value(6).for(:rating) }
end
