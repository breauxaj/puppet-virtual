require 'facter'
Facter.add("esx_version") do
  confine :kernel => %w{Linux}
  setcode do
    output = %x{dmidecode | grep -A4 "BIOS Information" | awk '/Address/ { print $2 }'}.chomp
    case output
    when /0xEA2E0/
      "4"
    when /0xE72C0/
      "5"
    when /0xEA0C0/
      "5"
    else
      "5"
    end
  end
end
