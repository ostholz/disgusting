json.array!(@noises) do |noise|
  json.extract! noise, :id
  json.url noise_url(noise, format: :json)
end
