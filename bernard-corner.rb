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
        puts "County Name: #{name}\n\nTax: #{tax}%"
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


    def markUp_details
        puts "MarkUp: #{markUp}%"
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

    def markUp_factor
        markUp/100.0
    end
end

class ProductController

    def self.calculate_profit(product_details, quantity)
        profit = 0
        product_details.each do |productMarkupByCounty|
            profit = profit + productMarkupByCounty.total_profit_by_quantity(quantity)
        end
        profit
    end
end

# Data Setup
product = Product.new('Headphones', 'JWT', 30)

county1 = County.new('Miami-Dade', 6)
county2 = County.new('Broward', 7)
county3 = County.new('Palm Beach', 8)

productMarkupCounty1 = ProductMarkup.new(product, county1, 25)
productMarkupCounty2 = ProductMarkup.new(product, county2, 30)
productMarkupCounty3 = ProductMarkup.new(product, county3, 30)

puts product.product_details
puts "------------------------------------"
puts county1.county_details
puts productMarkupCounty1.markUp_details
puts "------------------------------------"
puts county2.county_details
puts productMarkupCounty2.markUp_details
puts "------------------------------------"
puts county3.county_details
puts productMarkupCounty3.markUp_details

productDetails = [productMarkupCounty1, productMarkupCounty2, productMarkupCounty3]
quantity = 100

# Fetch - Profit

total_profit = ProductController.calculate_profit(productDetails, quantity)

puts "------------------------------------"
puts "Total Profit: $#{total_profit}"

=begin

### Output

Product Name: Headphones
Brand Name: JWT
Cost Price: 30$

County Name: Miami-Dade
Tax: 6%

County Name: Broward
Tax: 7%

County Name: Palm Beach
Tax: 8%

Total Profit: $1740.0
=end