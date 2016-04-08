require_relative('./bank_state.rb')

File.open("./out/part1_output.txt", "w") do |file|

for i in 1..Dir["./resources/*"].count do
  arr = IO.readlines("./resources/example#{i}.txt")
  puts("Read file: example#{i}")
  bank = BankState.new(arr)
  truth = bank.isSafe
  file.syswrite("File: Example#{i}\n")
  if(truth)
    file.syswrite("Safe State.\n")
    file.syswrite("Safe sequence: \n")
    bank.getSequence().each do |process|
      file.syswrite("#{process}\n")
    end
  end # end if
end # end for loop

end # close file
