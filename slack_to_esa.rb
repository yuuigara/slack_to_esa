require 'rubygems'
require 'bundler/setup'
require 'active_support/core_ext/time/calculations'
require 'uri'
require 'open-uri'
require 'dotenv'
require 'json'
require 'net/http'
require 'esa'
require 'pry'

Dotenv.load

base_url = 'https://slack.com/api/channels.history'
token = ENV['SLACK_TOKEN']
channel = ENV['SLACK_CHANNEL']
yesterday = Time.now.yesterday
start_at = yesterday.beginning_of_day.to_i
end_at = yesterday.end_of_day.to_i

params = { token: token, channel: channel, oldest: start_at, latest: end_at, count: 1000 }
url = "#{base_url}?#{URI.encode_www_form(params)}"

messages = []
results_json = open(url).read
results = JSON.parse(results_json)
results['messages'].each do |result|
  messages.push(result['text'])
end

client = Esa::Client.new(access_token: ENV['ESA_TOKEN'], current_team: ENV['ESA_TEAM'])
params = {
  name: ENV['ESA_TITLE'],
  body_md: messages.join("\n"),
  category: "#{ENV['ESA_CATEGORY']}/#{yesterday.year}/#{yesterday.month}/#{yesterday.day}",
  wip: 'false'
}
client.create_post(params)
