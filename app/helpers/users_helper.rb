module UsersHelper
  def users_submit_button_text
    @user.persisted? ? 'Update account' : 'Sign up'
  end

  def gravatar_for(user, size: 80, css_class: '')
    email = user.email
    hash = Digest::MD5.hexdigest(email)
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag gravatar_url, alt: user.username, class: css_class
  end


end
