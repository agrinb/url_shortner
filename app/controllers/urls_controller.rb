class UrlsController < ApplicationController


	def new
		@url = Url.new
    @leaderboard = Visit.group('url_id', 'old_url').order('count_id desc').count('id')
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
          redirect_to @url, notice: 'Url was successfully created.' 
        else
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
      visit = Visit.create(ip: request.remote_ip, url_id: dest_url.id, old_url: dest_url.old_url)
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