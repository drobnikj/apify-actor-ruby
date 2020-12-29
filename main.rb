require "nokogiri"
require "faraday"
require "json"
require "faraday_middleware"

APIFY_CLIENT = Faraday.new(
  url: "#{ENV['APIFY_API_BASE_URL']}v2",
  params: { token: ENV['APIFY_TOKEN'] },
  )
APIFY_CLIENT.use(FaradayMiddleware::FollowRedirects)

DEFAULT_STORE_ID = ENV['APIFY_DEFAULT_KEY_VALUE_STORE_ID']

def main
  # Gets input from default actor key-value store
  input = JSON.parse(APIFY_CLIENT.get("key-value-stores/#{DEFAULT_STORE_ID}/records/INPUT").body)

  # Scrapes URL based on input
  html = Faraday.get(input['url'])
  doc = Nokogiri::HTML(html.body)
  titleNode = doc.css('title').first

  # Saves output into default actor key-value store
  record = { 'title' => titleNode.content }
  APIFY_CLIENT.put("key-value-stores/#{DEFAULT_STORE_ID}/records/OUTPUT", record.to_json, { 'Content-Type' => 'application/json' })
end

main