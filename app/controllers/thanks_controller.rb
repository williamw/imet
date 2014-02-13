class ThanksController < ApplicationController
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def acknowledgements
    respond_to do |format|
      format.html # acknowledgements.html.erb
    end
  end
end