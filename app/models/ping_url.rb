module PingURL
  class << self
    def urls
      return @urls if @urls

      @urls = []
      100.times do |i|
        n = i + 1

        url = ENV["PING_URL_#{n}"]

        @urls << url if url.present?
      end

      @urls
    end
  end
end
