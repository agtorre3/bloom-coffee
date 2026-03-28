# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Admin::Drinks", type: :request do
  describe "GET /admin/drinks" do
    context "when not signed in" do
      it "redirects to the login page" do
        get admin_drinks_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when signed in as admin" do
      before { sign_in create(:user, :admin) }

      it "returns success" do
        get admin_drinks_path
        expect(response).to have_http_status(:ok)
      end
    end

    context "when signed in as a non-admin user" do
      before { sign_in create(:user) }

      it "redirects with an authorization error" do
        get admin_drinks_path
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("You are not authorized to access the admin area.")
      end
    end
  end
end
