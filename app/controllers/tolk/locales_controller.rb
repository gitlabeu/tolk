module Tolk
  class LocalesController < Tolk::ApplicationController
    before_filter :find_locale, :only => [:show, :all, :update, :updated]
    before_filter :ensure_no_primary_locale, :only => [:all, :update, :show, :updated]

    def index
      @locales = Tolk::Locale.secondary_locales
    end
  
    def show
      @locales = Tolk::Locale.secondary_locales
      respond_to do |format|
        format.html do
          @phrases = @locale.phrases_without_translation(params[:page])
        end
        format.atom { @phrases = @locale.phrases_without_translation(params[:page], :per_page => 50) }
        format.yml { render :text => @locale.to_hash.ya2yaml(:syck_compatible => true) }
      end
    end

    def update
      # 
      # what a hack
      #
      trans = []
      params[:translations] ||= []

      params[:translations].each do |t|
        if t[:id].present?
          if t[:text].present?
            trans << t
          else
            Tolk::Translation.find(t[:id]).destroy
          end
        else
          Tolk::Translation.create(t)
        end
      end
      # 
      # end of what a hack
      #

      @locale.translations_attributes = trans
      @locale.save
      redirect_to request.referrer
    end

    def all
      @phrases = @locale.phrases_with_translation(params[:page])
    end

    def updated
      @phrases = @locale.phrases_with_updated_translation(params[:page])
      render :all
    end

    def create
      Tolk::Locale.create!(params[:tolk_locale])
      redirect_to :action => :index
    end

    private

    def find_locale
      @locale = Tolk::Locale.find_by_name!(params[:id])
    end
  end
end
