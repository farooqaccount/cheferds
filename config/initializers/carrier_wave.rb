# if Rails.env.production?
#   CarrierWave.configure do |config|
#     config.fog_credentials = {
#       :provider => 'AWS',
#       :aws_access_key_id => ENV['S3_ACCESS_KEY'],
#       :aws_secret_access_key => ENV['S3_SECRET_KEY']
#     }
    
#     config_fog_directory = ENV['S3_BUCKET']
    
#   end
# end

if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :aws
    config.aws_bucket = ENV.fetch('S3_BUCKET')
    config.aws_acl = :public_read
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365
    
    config.aws_credentials = {
      access_key_id:     ENV.fetch('S3_ACCESS_KEY'),
      secret_access_key: ENV.fetch('S3_SECRET_KEY'),
    #  region:            ENV.fetch('S3_REGION') # Required
    }
    
  end
end









