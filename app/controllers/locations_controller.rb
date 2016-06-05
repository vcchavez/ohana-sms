require 'priority_queue'

class LocationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  @@hm = Hash.new(Array.new(2,0))

  include TwilioRequestValidator

  before_action :set_locale

  def reply
    session[:counter] ||= 0

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message ConversationTracker.new(params[:Body], session).message(hm)
    end

    session[:counter] += 1
    render xml: twiml.text
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
