#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
ActiveRecord::Schema.define do

  create_table :globalize_products, :force => true do |t|
    t.column :code, :string
    t.column :manufacturer_id, :integer
    t.column :name, :string
    t.column :description, :string
    t.column :specs, :string
  end

  add_index :globalize_products, :code, :unique
  add_index :globalize_products, :manufacturer_id

  create_table :globalize_manufacturers, :force => true do |t|
    t.column :code, :string
    t.column :name, :string
  end

  add_index :globalize_manufacturers, :code, :unique

  create_table :globalize_categories, :force => true do |t|
    t.column :code, :string
    t.column :name, :string
  end

  add_index :globalize_categories, :code, :unique

  create_table :globalize_categories_products, :id => false, :force => true do |t|
    t.column :category_id, :integer
    t.column :product_id, :integer
  end

  add_index :globalize_categories_products, :category_id
  add_index :globalize_categories_products, :product_id

  create_table :globalize_countries, :force => true do |t|
    t.column :code,               :string, :limit => 2
    t.column :english_name,       :string
    t.column :date_format,        :string
    t.column :currency_format,    :string
    t.column :currency_code,      :string, :limit => 3
    t.column :thousands_sep,      :string, :limit => 1
    t.column :decimal_sep,        :string, :limit => 1
    t.column :currency_decimal_sep,        :string, :limit => 1
    t.column :number_grouping_scheme,      :string
  end
  add_index :globalize_countries, :code

  create_table :globalize_translations, :force => true do |t|
    t.column :type,           :string
    t.column :tr_key,         :string
    t.column :table_name,     :string
    t.column :item_id,        :integer
    t.column :facet,          :string
    t.column :language_id,    :integer
    t.column :pluralization_index,    :integer
    t.column :text,           :text
  end

  add_index :globalize_translations, [ :tr_key, :language_id ]
  add_index :globalize_translations, [ :table_name, :item_id, :language_id ]

  create_table :globalize_languages, :force => true do |t|
    t.column :iso_639_1, :string, :limit => 2
    t.column :iso_639_2, :string, :limit => 3
    t.column :iso_639_3, :string, :limit => 3
    t.column :rfc_3066,  :string
    t.column :english_name, :string
    t.column :english_name_locale, :string
    t.column :english_name_modifier, :string
    t.column :native_name, :string
    t.column :native_name_locale, :string
    t.column :native_name_modifier, :string
    t.column :macro_language, :boolean
    t.column :direction, :string
    t.column :pluralization, :string
    t.column :scope, :string, :limit => 1
  end

  add_index :globalize_languages, :iso_639_1 
  add_index :globalize_languages, :iso_639_2
  add_index :globalize_languages, :iso_639_3
  add_index :globalize_languages, :rfc_3066

end