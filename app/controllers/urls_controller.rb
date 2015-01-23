class UrlsController < ApplicationController

	def new
		@url = Url.new
	end

	def create
    @domain = "http://ss.cc/u/"
    @url = Url.new(old_url: url_params['old_url'])
    @url.short_url = @domain << Url.random_code
    # @url = Url.create(old_url: old_url, short_url: short)


    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, notice: 'url was successfully created.' }
        # format.json { render :show, status: :created, location: @url }
      else
        format.html { render :new, notice: 'There was a problem is creating your url' }
        # format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
	end

  def show
    @url = Url.find(params[:id])
  end

  private
  def url_params
      params.require(:url).permit(:old_url)
  end

end