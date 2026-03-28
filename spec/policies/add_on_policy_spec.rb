# frozen_string_literal: true

require "rails_helper"

RSpec.describe AddOnPolicy do
  subject(:policy) { described_class.new(user, :add_on) }

  context "when the user is an admin" do
    let(:user) { build(:user, :admin) }

    it { expect(policy.index?).to be true }
    it { expect(policy.show?).to be true }
    it { expect(policy.create?).to be true }
    it { expect(policy.update?).to be true }
    it { expect(policy.destroy?).to be true }
  end

  context "when the user is a regular user" do
    let(:user) { build(:user) }

    it { expect(policy.index?).to be false }
    it { expect(policy.show?).to be false }
    it { expect(policy.create?).to be false }
    it { expect(policy.update?).to be false }
    it { expect(policy.destroy?).to be false }
  end
end
