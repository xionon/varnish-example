json.array!(@slow_things) do |slow_thing|
  json.extract! slow_thing, :id, :name
  json.url slow_thing_url(slow_thing, format: :json)
end
