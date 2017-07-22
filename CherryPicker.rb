#!/usr/bin/ruby
# model numbers

models = Hash.new()
models['wm100'] =    'Spark'
models['wm220'] =    'Mavic'
models['wm220_gl'] = 'Goggles' 
models['GL200A'] =   'GL200A' # Mavic Controller
models['wm330'] =    'P4'
models['wm331'] =    'P4P'
models['wm620'] =    'Inspire2'
name = ""
firmware = ""
cfg = ""

if ARGV[0] == nil
    # Use for-loop on keys.
    for key in models.keys()
        puts "#{key} -> #{models[key]}"
    end

    puts "Enter your drone: "
    name = gets.chomp
    puts "Using drone type: #{name}"
else
    puts "Using drone type: #{ARGV[0]}"
    name = ARGV[0]
end

puts "Name is: #{name}"

if ARGV[1] == nil
    puts "Available firmware versions:"
    Dir.glob("V*/*.cfg.sig") {|file|
        if file.include?(models[name])
            puts "- #{file.split('_')[0]}"
        end
    }
    puts "Enter desired firmware: "
    firmware = gets.chomp
    puts "Using firmware: #{firmware}"
else
    puts "Using firmware: #{ARGV[1]}"
    firmware = ARGV[1]
end

# This should only be one file
Dir.glob("#{firmware}_#{models[name]}_dji_system/*.cfg.sig") {|file| 
    cfg = "#{file}"
}

puts "Using config file: #{cfg}"

# Seek in 480 bytes and look for XML header 
# 000001e0: 3c3f 786d 6c20 7665 7273 696f 6e3d 2231  <?xml version="1
config_sig = File.read("#{cfg}")
puts config_sig[480..-24]

#puts "---------------------------------------------------"
#Dir.glob("*.fw.sig") {|file|
#    if file.include?(name)
#        puts file
#    end
#} 


# type
#"ca02"
#"cd01"
#"cd02"
#"cd03"
#"gb01"
#"gb02"
#"ln01"
#"ln02"

# group
#"ac"
#"gl"
#"rc"

# module id
#"0100"
#"0101"
#"0104"
#"0106"
#"0305"
#"0306"
#"0400"
#"0401"
#"0402"
#"0404"
#"0500"
#"0501"
#"0600"
#"0601"
#"0603"
#"0801"
#"0802"
#"0803"
#"0804"
#"0805"
#"0900"
#"0905"
#"0907"
#"1100"
#"1101"
#"1200"
#"1201"
#"1202"
#"1203"
#"1301"
#"1407"
#"2801"
#"2803"
#"2807"


