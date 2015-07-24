class PingController < ApplicationController
  def index
    if ENV['PINGER_KEY'].present?
      if params[:key] != ENV['PINGER_KEY']
        if ENV['REDIRECT_URL'].present?
          redirect_to ENV['REDIRECT_URL'] and return
        else
          render json: { error: 'invalid key' }, status: 401 and return
        end
      end
    end

    status = {}
    http_status = 200

    PingURL.urls.each do |url|
      uri = URI(url)
      req = Net::HTTP::Get.new(uri.path.present? ? uri.path : '/')
      res = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https', verify_mode: OpenSSL::SSL::VERIFY_NONE) do |https|
        https.request(req)
      end
      code = res.code.to_i

      http_status = code if code < http_status

      status[url] = code
    end

    render json: status, status: http_status
  end
end
