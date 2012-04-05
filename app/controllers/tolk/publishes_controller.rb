module Tolk
  class PublishesController < Tolk::ApplicationController
    def create
      `rake tolk:dump_all`
      `pkill -HUP unicorn_rails`
      flash[:success] = 'Published!'
      redirect_to :back
    end
  end
end
