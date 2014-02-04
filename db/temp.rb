require 'yaml'
config = YAML.load_file('config/config.yml')

f = File.open('/Users/mkanof/Code/madison_live/db/temp.txt', 'a')

config.each do |line|
  date = line[0].sub('d_', '').sub('_', '-').sub('_', '-')
  code = line[1]

  if code == 'F'
    description = 'Finals'
  elsif code == 'P'
    description = 'Planning'
  elsif code == 'W'
    description = 'Weekend'
  elsif code == 'H'
    description = 'Holiday'
  end

  f.puts "schedule = Schedule.new({:date => '#{date}', :code => '#{code}', :description => '#{description}'})"

  if code == 'A'
    f.puts "schedule.schedule_segments << ScheduleSegment.new({:title => 'Period 1', :position => 1 })"
    f.puts "schedule.schedule_segments << ScheduleSegment.new({:title => 'Period 3', :position => 2 })"
    f.puts "schedule.schedule_segments << ScheduleSegment.new({:title => 'Period 5', :position => 3 })"
    f.puts "schedule.schedule_segments << ScheduleSegment.new({:title => 'Period 7', :position => 4 })"
  elsif code == 'B'
    f.puts "schedule.schedule_segments << ScheduleSegment.new({:title => 'Period 2', :position => 1 })"
    f.puts "schedule.schedule_segments << ScheduleSegment.new({:title => 'Period 4', :position => 2 })"
    f.puts "schedule.schedule_segments << ScheduleSegment.new({:title => 'Period 6', :position => 3 })"
    f.puts "schedule.schedule_segments << ScheduleSegment.new({:title => 'Period 8', :position => 4 })"
  end

  f.puts "schedule.save"

end

