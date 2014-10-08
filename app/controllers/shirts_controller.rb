# shirts_controller.rb

class ShirtsController < ApplicationController
	before_action :load_shirt, only: [:edit, :show, :update, :destroy]

	def index
		@shirts = Shirt.search_for(params[:q])
	end

	def show
		# @shirt = Shirt.find(params[:id])
	end

	def new
		@shirt = Shirt.new
	end

	def create
		@shirt = Shirt.new(params)
		if @shirt.save
			#success
			redirect_to @shirt
		else
			render 'new'
		end
	end

	def edit
		# @shirt = Shirt.find(params[:id])
	end

	def update
		# @shirt = Shirt.find(params[:id])
		if @shirt.update(safe_params)
			redirect_to @shirt
		else
			render 'edit'
		end
	end

	def destroy
		# @shirt = Shirt.find(params[:id])                                                                          
		@shirt.destroy
	end

	private

		def load_shirt
			@shirt = Shirt.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			flash[:notice] = "Shirt #{params[:id]} not found"
			redirect_to root_path
		end

		def safe_params
			params.require(:shirt).permit(:name, :description, :image)
		end
end