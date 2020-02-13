class ContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.attached?
    record.errors.add(attribute, :invalid_content_type, options) unless valid_content_type?(value.blob)
  end

  def valid_content_type?(blob)
    ['image/jpeg', 'image/jpg', 'image/png'].include?(blob.content_type)
  end
end
