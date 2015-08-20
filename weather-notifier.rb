require 'json'
require 'open-uri'
require 'slack/incoming/webhooks'

uri = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=400010'

res     = JSON.load(open(uri).read)
title   = res['title']
link    = res['link']
weather = res['forecasts'].first

slack = Slack::Incoming::Webhooks.new ENV['WEBHOOK_URL']
slack.post "<#{link}|#{weather['date']}の#{title}>は「#{weather['telop']}」です。"
