class UrlsController < ApplicationController

	def new
		@url = Url.new
	end

	def create
    @domain = "http://domain.com/u/"
    @url = Url.new(old_url: url_params['old_url'])
    code = Url.random_code
    @url.code = code
    @url.short_url = @domain << code
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

  def redirect_url
    rcode = params[:code]
    dest_url = Url.find_by(code: rcode)
    unless dest_url == nil
      redirect_to dest_url.old_url
    else 
      render "/public/sorry.html"
    end
  end


  private
  def url_params
      params.require(:url).permit(:old_url)
  end

end