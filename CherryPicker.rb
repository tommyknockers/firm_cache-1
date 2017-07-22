#!/usr/bin/ruby
# gem install nokogiri  -v '1.6.7.2' -- --with-xml2-include=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/usr/include/libxml2 --use-system-libraries 
# 
require 'nokogiri'

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
#puts config_sig[480..-24]

doc = Nokogiri::XML(config_sig[480..-24])

#<?xml version="1.0" encoding="utf-8"?>
#<dji>
#    <device id="wm100">
#        <firmware formal="01.00.0400">
#            <release version="01.00.0400" antirollback="0" antirollback_ext="cn:2" enforce="0" enforce_ext="cn:2" enforce_time="2017-06-28T16:00:00+00:00" from="2017/06/16" expire="2018/06/16">
#                <module id="0801" version="00.00.06.59" type="" group="ac" size="65930624" md5="43e1b6665074007c1eeccdb7e8d3ec82">wm100_0801_v00.00.06.59_20170614.pro.fw.sig</module>
#                <module id="1200" version="01.09.00.00" type="" group="ac" size="20768" md5="277d7dd372906f1533206c47a29084cd">wm100_1200_v01.09.00.00_20170428.pro.fw.sig</module>
#                <module id="1201" version="01.09.00.00" type="" group="ac" size="20768" md5="6170a30864186a9430d00269f34ae3f9">wm100_1201_v01.09.00.00_20170428.pro.fw.sig</module>
#                <module id="1202" version="01.09.00.00" type="" group="ac" size="20768" md5="63cb1cd05d4a3ddb5c75c3dbc3f4c06c">wm100_1202_v01.09.00.00_20170428.pro.fw.sig</module>
#                <module id="1203" version="01.09.00.00" type="" group="ac" size="20768" md5="3033d05d839ce0acd0f70c7c3fed9f1d">wm100_1203_v01.09.00.00_20170428.pro.fw.sig</module>
#                <module id="0305" version="34.11.00.21" type="" group="ac" size="55072" md5="ae7b12a944e67add75cd2c4d3d24624d">wm100_0305_v34.11.00.21_20161010.pro.fw.sig</module>
#                <module id="0306" version="03.02.37.20" type="" group="ac" size="1569824" md5="65f55c9eb416e57ba5f1904fd5b91e4c">wm100_0306_v03.02.37.20_20170615.pro.fw.sig</module>
#                <module id="0400" version="01.00.01.20" type="" group="ac" size="94016" md5="f1f48c74462e2e05adfc64f079c977dc">wm100_0400_v01.00.01.20_20170531.pro.fw.sig</module>
#                <module id="0802" version="00.04.11.38" type="" group="ac" size="5751296" md5="cb46b63b80b8921aa9776fdd4061846c">wm100_0802_v00.04.11.38_20170613.pro.fw.sig</module>
#                <module id="0805" version="01.01.01.38" type="" group="ac" size="20173280" md5="704a09ba9107094be6f6a155b3915ff0">wm100_0805_v01.01.01.38_20170615.pro.fw.sig</module>
#                <module id="0905" version="01.00.01.04" type="" group="ac" size="2939360" md5="b320c1d99b2329ce95ff55040df71576">wm100_0905_v01.00.01.04_20170602.pro.fw.sig</module>
#                <module id="1100" version="01.00.00.60" type="" group="ac" size="82688" md5="d6556a93beb45fc6927cda157af72e1d">wm100_1100_v01.00.00.60_20170502.pro.fw.sig</module>
#            </release>
#        </firmware>
#    </device>
#</dji>

doc.xpath('/dji/device/firmware/release/module').each do  |firmware_element|
    puts firmware_element
#    puts firmware_element.attr('version')

end


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


