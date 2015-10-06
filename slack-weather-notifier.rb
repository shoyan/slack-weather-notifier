require 'json'
require 'open-uri'
require 'slack/incoming/webhooks'

uri = 'http://weather.livedoor.com/forecast/webservice/json/v1?city=400010'

res     = JSON.load(open(uri).read)
title   = res['title']
text    = res['description']['text']
link    = res['link']
weather = res['forecasts'].first

attachments = [{
  title: title,
  title_link: link,
  text: text,
  image_url: weather['image']['url'],
  color: "#7CD197"
}]

slack = Slack::Incoming::Webhooks.new ENV['WEBHOOK_URL']
slack.post "#{weather['date']}の#{title}は「#{weather['telop']}」です。", attachments: attachments
