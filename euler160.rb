# Problem:
#
# For any N, let f(N) be the last five digits before the trailing zeroes in N!.
# For example,
#
# 9! = 362880 so f(9)=36288
# 10! = 3628800 so f(10)=36288
# 20! = 2432902008176640000 so f(20)=17664
#
# Find f(1,000,000,000,000)

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

def last_five_fact (n)
  fact = 1
  (1..n).each do |num|
    fact *= (zeroshift(num))
    fact = zeroshift(fact) % 100000000
    # assume we run this accurately up to n = 100mil, the modulus operator will speed up everything under 100mil
  end
  fact % 100000
end

def zeroshift (num)
  return if num == 0
  while (num % 10 == 0)
    num /= 10
  end
  num
end

def method1 ()
  # testing out last_five_fact will show a pattern. For n > 10^5 && n%10000 == 0, last_five_fact(n) == last_five_fact(5n), so let's use that to solve 1 trillion
  n = 1000000000000
  while ((n/5 > 100000) && n/5%10000 == 0) && n % 5 == 0
    n /= 5
  end
  last_five_fact(n) # now that n is the smallest number that shares the last 5 digits before trailing 0s with 1 trillion, we can find its last_five_fact
end


# Let's say we never find the pattern.

def method2 (n)

  # n! repeats if we remove all numbers that % 5 == 0, so all multiples of 5. Then we have lff_nofives(n) * lff_onlyfives(n)
  # lff_nofives(n) reamins the same after n > 100000 and n % 100000 == 0. This is because lff_nofives(n) = 09376 for those numbers and 09376^n always has 09376 as the last 5 digits before trailing zeros
  # lff_nofives (n) * lff_onlyfives(n)

  # final
 (lff_nofives2(n) * lff_onlyfives4(n))% 100000
end

#no fives last five factorial v1

def lff_nofives1 (n)
  fact = 1.0
  (1..n).each do |num|
    # fact *= num unless (num%5 == 0)
    if (num % 5 != 0)
      fact *= (num)
    end
    fact = fact % 100000 #will never have a trailing zero because multiples of 5 has been removed
  end
  fact
end

#only fives last five factorial v1

def lff_onlyfives1 (n)
  fact = 1.0
  f = n/5 # f = number of fives rounded down
  (1..f).each do |num|
    fact *= (5 * num)
    fact = zeroshift(fact)
  end
  fact
end

# lff_onlyfives1(n) becomes huge, what if we can simplify it?

def lff_onlyfives2 (n)
  fact = 1.0
  f = n/5
  fact = zeroshift(last_five_fact(f) * exp(5, f)) # f! * 5^f, pull out all the 5s
end

# lff_onlyfives2 looks better but doesn't help much. What if we pulled out 2^f from lff_nofives and multiplied
# that to llf_onlyfives2? Then we would have zeroshift(2^f * 5^f * last_five_fact(f)), which is == zeroshift(last_five_fact(f))

def lff_nofives2 (n)
  fact = 1.0
  return 9376 if n % 100000 == 0
  (1..n).each do |num|
    # fact *= num unless (num%5 == 0)
    if (num% 5 == 0) # divide by 2 at every 5 to compensate for the multiplications at 5
      fact /= 2
    elsif (num % 5 != 0)
      fact *= (num)
    end
    fact = fact % 100000 #will never have a trailing zero because multiples of 5 has been removed
  end
  fact
end

def lff_onlyfives3 (n)
  fact = 1.0
  f = n/5
  fact = zeroshift(last_five_fact(f))
end

# Ok that works for small n, what if n is huge. lff_onlyfives(3) still needs to run last_five_fact(f) where f = n/5
# let's split up last_five_fact(f) again into lff_nofives(f) and lff_onlyfives(f)

def lff_onlyfives4 (n)
  fact = 1.0
  f = n/5
  if (f % 100000 == 0 && f >= 100000)
    fact = zeroshift((lff_nofives2(f) * lff_onlyfives4(f))%100000)
  else
    fact = zeroshift(last_five_fact(f)%100000)
  end
end

# Now lff_onlyfives can be very small, but lff_nofives2 still has to run through at least n times... except
# lff_nofives2 (n) for (n >= 100000 && n % 100000 == 0) is always 09376 and the last five digits before trailing zeros of 09376 ^ n = 09376
# this simplifies all n with those constraints to 09376 * lff_onlyfives(m) where m is the last number to fulfill lff_nofives(m) = 09376.
# Since 09376 = lff_nofives(m), last_five_fact(n) = lff_nofives(m) * lff_onlyfives(m) = last_five_fact(m) which explains the pattern in method1!
# m in the case of 1 trillion, is 12.8 million since lff_nofives(m/5) where m/5 = 2.56mil is no longer 09376 because m/5 % 100000 != 0
