class Messenger
  def initialize(session)
    @session = session
  end

  def search_results(map)
    locations_list_prefix + locations_list(map)
  end

  def locations_list_prefix
    I18n.t('results_intro')
  end

  def locations_list(map)
    locations.map.with_index do |location, i|
      "##{i + 1}: #{location.name}#{rating_for(location,map)}"
    end.join(', ')
  end

  def categories
    I18n.t('choose_category', list: categories_list)
  end

  def categories_list
    localized_cats.map.with_index { |cat, i| "##{i + 1}: #{cat}" }.join(', ')
  end

  def localized_cats
    I18n.t('categories')
  end

  def cat_array
    Rails.application.secrets.categories
  end
    
  def locations
    @locations ||= Ohanakapa.search(
      'search',
      location: @session[:zip],
      keyword: search_term,
      kind: 'Human Services',
      page: 1,
      per_page: 5)
  end

  def search_term
    if @session[:cats] =~ /\A([1-9]|1[0-1])\z/
      return cat_array[@session[:cats].to_i - 1]
    end
    @session[:cats]
  end

  def location
    locations[@session[:location].to_i - 1]
  end

  def location_details
    "#{name_and_short_desc} | #{phone} | #{address}. #{I18n.t('to_rate')}"
  end

  def name_and_short_desc
    "#{location.name}: #{location.short_desc}"
  end

  def rating_for(location, map)
    if (map[location.name][1] == 0)
      "No Ratings"
    else
      num = map[location.name][0]
      "##{num} Stars"
    end
  end

  def phone
    "#{I18n.t('phone')}: #{location.phones.first.number}"
  end

  def address
    "#{I18n.t('address')}: #{street_address}"
  end

  def street_address
    return "#{address_1}, #{city}, #{state_province} #{zip}" if address_2.blank?
    "#{address_1}, #{address_2}, #{city}, #{state_province} #{zip}"
  end

  def address_1
    location.address.address_1
  end

  def address_2
    location.address.address_2
  end

  def city
    location.address.city
  end

  def state_province
    location.address.state_province
  end

  def zip
    location.address.postal_code
  end
end
