require_relative('./bank_state.rb')

# TODO: execution completes, but is incorrect. Safe sequences don't make sense.

File.open("./out/part1_output.txt", "w") do |file|

for i in 1..Dir["./resources/*"].count do
  arr = IO.readlines("./resources/example#{i}.txt")
  puts("Read file: example#{i}")
  begin
    bank = BankState.new(arr)
    truth = bank.isSafe
  rescue RuntimeError => e
    puts("Error reading state array from file.")
    puts(e.message)
  end
  file.syswrite("File: Example#{i}\n")
  if(truth)
    file.syswrite("Safe State.\n")
    file.syswrite("Safe sequence: \n")
    bank.getSequence().each do |process|
      file.syswrite("Process#{process}\n")
  end
  file.syswrite("\n")
  end # end if
  puts("Completed file #{i}.")
end # end for loop

end # close file
