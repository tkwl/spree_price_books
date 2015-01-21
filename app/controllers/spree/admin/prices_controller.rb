module Spree
  module Admin
    class PricesController < Spree::Admin::BaseController
      def update
        params[:variant].each_pair do |id, amount_hash|
          next if amount_hash[:amount].blank?
          variant_price(id).update_attributes(amount: amount_hash[:amount])
        end if params[:variant]

        redirect_to return_path
      end

      def index
         @product = Product.friendly.find(params[:product_id])
      end

	
def create
params[:id] = params[:product_id]
params[:vp].each do |variant_id, prices|
variant = Spree::Variant.find(variant_id)
next unless variant
supported_currencies.each do |currency|
price = variant.price_in(currency.iso_code)
if price.nil?
 flash[:error] = 'Does not have a price book for '+currency#Spree.t('notice.prices_saved')
 redirect_to admin_product_path(:id=>params[:product_id])
 return
end
price.price = (prices[currency.iso_code].blank? ? nil : prices[currency.iso_code].to_money)
price.save! if price.new_record? && price.price || !price.new_record? && price.changed?
end
end
flash[:success] = Spree.t('notice.prices_saved')
redirect_to admin_product_path(:id=>params[:product_id])
end

      protected

      def variant_price(variant_id)
        current_price_book = Spree::PriceBook.find(params[:price_book_id])
        Spree::Price.where(
          variant_id: variant_id,
          price_book_id: current_price_book.id,
          currency: current_price_book.currency
        ).first_or_create
      end

      def return_path
        if !!session[:return_to_price_book]
          session.delete(:return_to_price_book)
          admin_price_book_path(params[:price_book_id])
        else
          session[:current_price_book_id] = params[:price_book_id]
          variant_prices_admin_product_path(params[:product_id])
        end
      end
    end
  end
end
