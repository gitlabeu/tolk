module Tolk
  class SearchesController < Tolk::ApplicationController
    before_filter :find_locale
  
    def show
      @phrases = @locale.search_phrases(params[:q], params[:scope].to_sym, params[:page])
      @other_locales = Tolk::Locale.secondary_locales.select {|l| l != @locale}
    end

    private

    def find_locale
      @locale = Tolk::Locale.find_by_name!(params[:locale])
    end
  end
end
