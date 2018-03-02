json.extract! reservation, :id, :license_no, :email, :start_time, :end_time, :status, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
