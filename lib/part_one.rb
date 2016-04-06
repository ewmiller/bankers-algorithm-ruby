require_relative('./bank_state.rb')

for i in 1..Dir["./resources/*"].count do
  arr = IO.readlines("./resources/example#{i}.txt")
  puts("Read file: example#{i}")
  bank = BankState.new(arr)
  puts(bank.isSafe())
end
