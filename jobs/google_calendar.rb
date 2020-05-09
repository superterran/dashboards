require 'date'
require 'icalendar'
require 'dotenv'
Dotenv.load

ical_url = ENV['ICALURL']
uri = URI ical_url

SCHEDULER.every '5m', :first_in => 4 do |job|
  result = Net::HTTP.get uri
  calendars = Icalendar::Calendar.parse(result)
  calendar = calendars.first

  events = calendar.events.map do |event|
    {
      start: event.dtstart,
      end: event.dtend,
      summary: event.summary
    }
  end.select { |event| event[:start].strftime("%Y-%m-%d %H:%M") > DateTime.now.strftime("%Y-%m-%d %H:%M") }

  events = events.sort { |a, b| a[:start] <=> b[:start] }

  events = events[0..5]

  send_event('google_calendar', { events: events })
end
