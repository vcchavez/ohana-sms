class ConversationTracker
  def initialize(body, session)
    @body = body
    @session = session
    restart if @body =~ /\Areset\z/i
  end

  def restart
    @session[:counter] = 0
    @session[:step_2] = false
    @session[:step_3] = false
    @session[:step_4] = false
    @session[:step_5] = false
  end

  def enable_second_step
    @session[:step_2] = true
    @session[:zip] = @body
  end

  def first_step_message
    return process_valid_zip if @body =~ /\A\d{5}\z/
    I18n.t('intro')
  end

  def process_valid_zip
    enable_second_step
    Messenger.new(nil).categories
  end

  def second_step_message(map)
    @session[:cats] = @body
    return apologize_and_restart if no_results?
    enable_third_step
    Messenger.new(@session).search_results(map)
  end

  def no_results?
    Messenger.new(@session).locations.blank?
  end

  def apologize_and_restart
    restart
    I18n.t('no_results_found')
  end

  def enable_third_step
    @session[:step_2] = false
    @session[:step_5] = false
    @session[:step_3] = true
  end

  def third_step_message
    return process_location_details if @body =~ /\A[1-5]\z/
    if @body =~ /\A[0]\z/ 
      enable_fourth_step
      return fourth_step_message
    elsif @body =~ /ty\z|thanks!?\z|thank you!*\z/i
      return "#{I18n.t('you_are_welcome')} #{I18n.t('choose_location')}"
    end
    I18n.t('choose_location')
  end

  def process_location_details
    @session[:location] = @body
    Messenger.new(@session).location_details
  end

  def enable_fourth_step
    @session[:step_3] = false
    @session[:step_5] = false
    @session[:step_4] = true
  end

  def fourth_step_message
    enable_fifth_step
    return "#{I18n.t('give_rating')}"
  end

  def enable_fifth_step
    @session[:step_4] = false
    @session[:step_5] = true
  end

  def fifth_step_message(map)
    if @body =~ /\A[1-5]\z/ 
      rate_location(map)
      enable_third_step
      return "Thanks! #{I18n.t('choose_location')}"
    else
      return enable_fourth_step
    end
  end

  def rate_location(map)
    loc = @session[:location].name
    curr_rate = map[loc][0]
    num_raters = map[loc][1] + 1
    map[loc] = [curr_rate+Integer(@body)/num_raters, num_raters]
  end

  def first_step?
    @session[:counter] == 0 || (!second_step? && !third_step? && !fourth_step? && !fifth_step?)
  end

  def second_step?
    @session[:step_2] == true
  end

  def third_step?
    @session[:step_3] == true
  end

  def fourth_step?
    @session[:step_4] == true
  end

  def fifth_step?
    @session[:step_5] == true
  end

  def message(map)
    return first_step_message if first_step?
    return second_step_message(map) if second_step?
    return third_step_message if third_step?
    return fourth_step_message if fourth_step?
    return fifth_step_message(map) if fifth_step?
  end
end
