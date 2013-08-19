module ContactsHelper

  def pagination(contacts)
    current_page = (params[:page] || 1).to_i
    prev_page = link_to("< prev", url_for(page: current_page - 1)).html_safe
    next_page = link_to("next >", url_for(page: current_page + 1)).html_safe
    "#{prev_page if prev_page_exists?} -- #{next_page if next_page_exists?(contacts)}".html_safe
  end

  private

  def prev_page_exists?
    params[:page] && params[:page].to_i >1
  end

  def next_page_exists?(contacts)
    contacts.size >= ContactsAPI::PER_PAGE
  end

end
