require 'spec_helper'

describe 'Recipe pages' do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe 'recipe creation' do
    before { visit root_path }

    describe 'with invalid information' do
      it 'should not create a recipe' do
        expect { click_button 'Plaats recept' }.not_to change(Recipe, :count)
      end

      describe 'error messages' do
        before { click_button 'Plaats recept' }
        it { should have_content('error') }
      end
    end

    describe 'with valid information' do
      #TODO: add name field also.
      before do
        fill_in 'recipe_name', with: 'Lorem ipsum'
        fill_in 'recipe_content', with: 'Lorem ipsum'
      end
      it 'should create a recipe' do
        expect { click_button 'Plaats recept' }.to change(Recipe, :count).by(1)
      end
    end
  end

  describe 'recipe destruction' do
    before { FactoryGirl.create(:recipe, user: user) }

    describe 'as correct user' do
      before { visit root_path }

      it 'should delete a recipe' do
        expect { click_link 'delete' }.to change(Recipe, :count).by(-1)
      end
    end
  end

end