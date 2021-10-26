module PagesHelper
  def flash_message_class(key)
    key == 'alert' ? 'danger' : 'success'
  end
end
