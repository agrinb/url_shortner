class UrlsController < ApplicationController


	def new
		@url = Url.new
	end

  def index
    redirect_to new_url_path
  end

	def create
    ### this should be improved
    domain = "http://domain.com/u/"
    ### 
    @url = Url.new(old_url: url_params['old_url'])
    code = Url.random_code
    @url.code = code
    @url.short_url = domain << code



    respond_to do |format|
     format.html do
        if @url.save
          redirect_to @url, notice: 'url was successfully created.' 
        else
          puts "failed"
          flash['notice'] = 'There was a problem is creating your url:' 
          @errors = @url.errors
          render action: :new
        end
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