def last_five_fact(n, i)
#f(1000000, 1) = 12544
#f(100000, 1) = 62496
  fact = 1.0
  (i..n).each do |num|
    fact *= (zeroshift(num) % 1000000)
    fact = zeroshift(fact)
    fact = fact % 1000000
  end

  fact % 100000
end

def last_five_fact2(n, i)
  fact = 1.0
  (i..n).each do |num|
    # fact *= num unless (num%5 == 0)
    if (zeroshift(num) % 5 == 0) #half on both digits ending in 5 and 10
      fact /= 2
    elsif (num % 5 != 0)
      fact *= (num)
    end
    fact = fact % 100000
  end
  fact
end

def last_five_fact3(n, i)
  i = i/5 + 1
  n = div_by_5(n)
  fact = 1.0
  five = 0
  (i..n).each do |num|
    if num.odd?
      fact *= num
    else
      fact *= num * 2
    end
    fact = zeroshift(fact)
    fact = fact % 100000
  end

  fact
end

def exp(base, exp)

    return 1 if exp == 0
    return base if exp == 1

    if (exp.even?)
      temp = exp(base, exp/2)
      temp * temp
    else
      temp = exp(base, (exp - 1)/2)
      base * temp * temp
    end

end

def last_five_exp(base, exp)

  exp(base,exp) % 100000

end

def div_by_5(n)
  return n/5 if n > 100
  five = 0
  (1..n).each do |num|
    five +=1 if num %5 == 0
  end
  five
end

def zeroshift (num)
  return if num == 0
  while (num % 10 == 0)
    num /= 10
  end
  num
end

puts "last_five_fact(10, 1) == last_five_fact2(10,1) * last_five_fact3(10,1), #{last_five_fact(10, 1) == last_five_fact2(10,1) * last_five_fact3(10,1)}"
a = 20
puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
a = 50
puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
a = 90
puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
a = 100
puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
#  a = 1000
# puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
#  a = 5000
# puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
# a = 10000
# puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
# a = 15000
# puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
# a = 20000
# puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
# a = 100000
# puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
# a = 1000000
# puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
# a = 2000000
# puts "last_five_fact(#{a}, 1) == last_five_fact2(#{a},1) * last_five_fact3(#{a},1), #{last_five_fact(a, 1) == (last_five_fact2(a,1) * last_five_fact3(a,1))%100000}"
