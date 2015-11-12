# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

def iter_sums_three_five (n)
  sum = 0

  (1...n).each do |num|
    if num % 3 == 0 || num % 5 == 0
      sum += num
    end
  end
  sum
end

# Above was iterative brute force, at O(n) time. Below using arithmetic sums results in O(1) time.

def sums_three_five (n)

  sum = 0
  #find sum of all 3s
  # 3 to 999 = 3 * (1 .. n/3) = 3 * 333/2 * (1 + 333)
  last_three = (n/3)
  sum +=  3 * ((last_three) * (1 + last_three))/2

  #find sum of all 5s
  # 1..200
  last_five = (n/5)
  last_five -= 1 if n % 5 == 0 # -1 because n is not included
  sum += 5 * ((last_five) * (1+last_five))/2

  #subtract intersection of 5s and 3s
  last_fifteen = (n/15)
  sum -= 15 * ((last_fifteen) * (1+last_fifteen))/2

end
