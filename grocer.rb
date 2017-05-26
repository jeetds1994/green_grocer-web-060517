def consolidate_cart(cart)
  # code here
  updated_cart = {}

  cart.each do |key|
    key.each do |item, details|
      if updated_cart.include?(item)
        updated_cart[item][:count] += 1
      else
        updated_cart[item] = details
        updated_cart[item][:count] = 1
      end
    end
  end
  updated_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    itemInCart = cart[coupon[:item]]
    for i in 0...coupons.length
      if cart.include?(coupon[:item])
        if itemInCart[:count] - coupon[:num] >= 0
          cart["#{coupon[:item]} W/COUPON"] = {}
          cart["#{coupon[:item]} W/COUPON"][:price] = coupon[:cost]
          cart["#{coupon[:item]} W/COUPON"][:clearance] = itemInCart[:clearance]
          cart["#{coupon[:item]} W/COUPON"][:count] = i + 1
          cart[coupon[:item]][:count] = cart[coupon[:item]][:count] - coupon[:num]
        end
      end
    end

  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, details|
    if details[:clearance] == true
      cart[item][:price] = (cart[item][:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  updatedCart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  number = 0

  updatedCart.each do |x, y|
    total = 0
    total = updatedCart[x][:price] * updatedCart[x][:count]
    number = number + total
  end

  if number > 100
    number *= 0.9
  end
  number
end
