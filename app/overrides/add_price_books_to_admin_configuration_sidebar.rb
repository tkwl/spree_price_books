Deface::Override.new(:virtual_path => "spree/admin/shared/sub_menu/_configuration",
                                          :name => "price_books_admin_sub_menu",
                                          :insert_bottom => '[data-hook="admin_product_sub_tabs"]',
                                          :text => "mytext",
                                          :disabled => false)

