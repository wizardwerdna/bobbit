class PagesController < ApplicationController

  def index
    @pages = ::Pages::All[].pages
  end

  def show
    @page = ::Pages::Get[name: params[:id]].page
    raise ActiveRecord::RecordNotFound if @page == ::Repository::NoRecord
    redirect_to @page.locator 
  end

  def update
    locator = params[:locator] + dot_format_or_empty_string 
    ::Pages::Set[name: params[:id], locator: locator]
    redirect_to root_url 
  end

  private

  def dot_format_or_empty_string 
    if params[:format].present?
      '.' + params[:format]
    else 
      ''
    end
  end
end
