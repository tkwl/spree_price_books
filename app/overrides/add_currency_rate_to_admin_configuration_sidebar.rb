

Deface::Override.new(:virtual_path => "spree/admin/shared/sub_menu/_configuration",
                     :name => "currency_rate_admin_menu",
                     :insert_bottom => '#sidebar-product',
                     :text => "<% if Spree.user_class && can?(:admin, Spree::CurrencyRate) %><%= configurations_sidebar_menu_item Spree.t(:currency_rates), spree.admin_currency_rates_path %><% end %>",
                     :disabled => false)

