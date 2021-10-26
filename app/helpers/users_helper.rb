module UsersHelper
  def users_submit_button_text
    @user.persisted? ? 'Update account' : 'Sign up'
  end
end
