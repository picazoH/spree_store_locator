module Spree
  module Admin
    class StoresController < Spree::Admin::BaseController
      before_filter :find_store, only: [:edit, :update, :destroy]

      def index
        load_stores
        @store  = Spree::Store.new
      end

      def create
        @store = Spree::Store.new store_params

        if @store.save
          redirect_to admin_stores_path
        else
          load_stores
          flash[:error] = 'There was an error.'

          render :index
        end
      end

      def update
        @store.update_attributes store_params

        redirect_to admin_stores_path
      end

      def destroy
        store = find_store
        store.destroy
        redirect_to admin_stores_path
      end

      private

      def load_stores
        per_page = params[:per_page] || 20
        @stores = Spree::Store.state_ordered.page(params[:page]).per(per_page)
      end

      def find_store
        @store = Spree::Store.find_by_id(params[:id])
      end

      def store_params
        {
          :address1 => params[:store][:address1],
          :address2 => params[:store][:adress2],
          :city => params[:store][:city],
          :country => params[:store][:country],
          :name => params[:store][:name],
          :phone => params[:store][:phone],
          :state => params[:store][:state],
          :website => params[:store][:website],
          :zip => params[:store][:zip]
        }
      end
    end
  end
end

