class PortfoliosController < ApplicationController
	layout "portfolio"
	def index
		@portfolio_items = Portfolio.all
	end

	def angular
		@angular_portfolios = Portfolio.angular
	end

	def new 
		@portfolio_item = Portfolio.new
		3.times {@portfolio_item.technologies.build}
	end

	def show
		@portfolio_item = Portfolio.find(params[:id])
	end

	def create
	    @portfolio_item = Portfolio.new(portfolio_params)	

	    respond_to do |format|
	      if @portfolio_item.save
	        format.html { redirect_to portfolios_path, notice: "Your portfolio item is now live" }
	        format.json { render :show, status: :created, location: @portfolio_item }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	        format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
	      end
	    end
  	end

  	def edit
  		@portfolio_item = Portfolio.find(params[:id])
  	end

  	def update
  		@portfolio_item = Portfolio.find(params[:id])

	    respond_to do |format|
	      if @portfolio_item.update(portfolio_params)
	        format.html { redirect_to portfolios_path, notice: "portfolio_item was successfully updated." }
	        format.json { render :show, status: :ok, location: @portfolio_item }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	        format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
	      end
	    end
  	end

  	def destroy
  		@portfolio_item = Portfolio.find(params[:id])
  		@portfolio_item.destroy!

	    respond_to do |format|
	      format.html { redirect_to portfolios_path, status: :see_other, notice: "Blog was successfully destroyed." }
	    end
  	end

  	private 

  	def portfolio_params
  		params.require(:portfolio).permit(
		    :title,
		    :subtitle,
		    :body,
		    technologies_attributes: [
		    	:id, 
		    	:name
		    ]
	  	)
  	end
end
