class PagesController < ApplicationController
  def home
    render html: 'Home!'
  end

  def about
    render html: 'Created by Esteban Saldarriaga Alzate'
  end
end
