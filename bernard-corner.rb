class Product
    def initialize(product_name, brand_name, cost_price)
        @name = product_name
        @brand = brand_name
        @cost_price = cost_price
    end

    # setter and getter
    attr_accessor :name, :brand, :cost_price

    def product_details
        puts "Product Name: #{name}\nBrand Name: #{brand}\nCost Price: #{cost_price}$"
    end
end

class County
    def initialize(county_name, tax)
        @name = county_name
        @tax = tax
    end
    
    # setter and getter
    attr_accessor :name, :tax

    # instance method
    def county_details
        puts "County Name: #{name}\nTax: #{tax}%"
    end

    def tax_factor
       tax/100.0 
    end
end


class ProductMarkup
    def initialize(product, county, markUp)
        @product = product
        @county = county
        @markUp = markUp
    end
    # setter and getter (only markUp)
    attr_reader :product, :county
    attr_accessor :markUp


    def markUp_factor
        markUp/100.0
    end

    def product_markup_price
        product.cost_price * (1 + markUp_factor)
    end

    # assumption the store is paying the tax difference to the government 
    # hence substraction
    def product_selling_price_after_tax
       product_markup_price * (1 - county.tax_factor) 
    end

    def profit
        product_selling_price_after_tax - product.cost_price
    end
    
    def total_profit_by_quantity(qty)
        (profit * qty).round(2)
    end
    
    def profit_on_product_by_county(qty)
        total_cost_price = product.cost_price * qty
        puts "\nTotal Cost Price of #{product.name} in county #{county.name}: #{total_cost_price}"

        product_markup_price = product.cost_price * (1 + (markUp/100.0))
        puts "Total Markup Price of #{product.name} in county #{county.name}: #{product_markup_price}"

        total_selling_price = (product_markup_price * qty) * (1 - (county.tax/100.0))
        puts "Tax in county: #{(county.tax/100.0)}"

        puts "Total Selling Price after Tax of #{product.name} in county #{county.name}: #{total_selling_price}"

        (total_selling_price - total_cost_price).round(5)
    end
end

# class ProductSale

#     def initialize(product_with_markup)
#         @product_details = product_with_markup
#     end

#     def product_markup_price
#         detail.cost_price * (1 + (markUp/100.0).round(2))
#     end

#     def total_price_with_tax_by_quantity
#         (product_markup_price * qty) * (1 + (county.tax/100.0).round(2))
#     end
 
#     def self.profit_on_product_by_county(product_details, qty)
#         puts product_details
#         total_cost_price = product_details.product.cost_price * qty
#         product_markup_price = product_details.product.cost_price * (1 + (product_details.markUp/100.0).round(2))
#         total_selling_price = (product_markup_price * qty) * (1 + (product_details.county.tax/100.0).round(2))
#         total_selling_price - total_cost_price
#     end
# end


product = Product.new('Headphones', 'JWT', 30)
county1 = County.new('Miami-Dade', 6)
county2 = County.new('Broward', 7)
county3 = County.new('Palm Beach', 8)
productMarkupCounty1 = ProductMarkup.new(product, county1, 25)
productMarkupCounty2 = ProductMarkup.new(product, county2, 30)
productMarkupCounty3 = ProductMarkup.new(product, county3, 30)

# profit_by_county1 = ProductSale.profit_on_product_by_county(productMarkupCounty1, 100)
# profit_by_county2 = ProductSale.profit_on_product_by_county(productMarkupCounty2, 100)
# profit_by_county3 = ProductSale.profit_on_product_by_county(productMarkupCounty3, 100)

profit_by_county1 = productMarkupCounty1.profit_on_product_by_county(100)
profit_by_county2 = productMarkupCounty2.profit_on_product_by_county(100)
profit_by_county3 = productMarkupCounty3.profit_on_product_by_county(100)

profit_by_county1_method2 = productMarkupCounty1.total_profit_by_quantity(100)
profit_by_county2_method2 = productMarkupCounty2.total_profit_by_quantity(100)
profit_by_county3_method2 = productMarkupCounty3.total_profit_by_quantity(100)

total_profit = profit_by_county1 + profit_by_county2 + profit_by_county3

puts product.product_details
puts county1.county_details
puts county2.county_details
puts county3.county_details

puts "County1 Profit: $#{profit_by_county1}"
puts "County2 Profit: $#{profit_by_county2}"
puts "County3 Profit: $#{profit_by_county3}"

puts "County1 Profit Method 2: $#{profit_by_county1_method2}"
puts "County2 Profit Method 2: $#{profit_by_county2_method2}"
puts "County3 Profit Method 2: $#{profit_by_county3_method2}"


puts "Total Profit: $#{total_profit}"

=begin

# Output

sandeepnunna at Sandeeps-MacBook-Pro in [BernardCorner]
 (main) $ ruby bernard-corner.rb 

Total Cost Price of Headphones in county Miami-Dade: 3000
Total Markup Price of Headphones in county Miami-Dade: 37.5
Tax in county: 0.06
Total Selling Price after Tax of Headphones in county Miami-Dade: 3525.0

Total Cost Price of Headphones in county Broward: 3000
Total Markup Price of Headphones in county Broward: 39.0
Tax in county: 0.07
Total Selling Price after Tax of Headphones in county Broward: 3626.9999999999995

Total Cost Price of Headphones in county Palm Beach: 3000
Total Markup Price of Headphones in county Palm Beach: 39.0
Tax in county: 0.08
Total Selling Price after Tax of Headphones in county Palm Beach: 3588.0
Product Name: Headphones
Brand Name: JWT
Cost Price: 30$

County Name: Miami-Dade
Tax: 6%

County Name: Broward
Tax: 7%

County Name: Palm Beach
Tax: 8%

County1 Profit: $525.0
County2 Profit: $627.0
County3 Profit: $588.0
County1 Profit Method 2: $525.0
County2 Profit Method 2: $627.0
County3 Profit Method 2: $588.0
Total Profit: $1740.0

=end