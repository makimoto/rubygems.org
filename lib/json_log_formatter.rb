class JSONLogFormatter < ::Logger::Formatter
  def call(severity, time, progname, msg)
    if msg.is_a?(Hash)
      msg = msg.with_indifferent_access
      if msg["@timestamp"].nil?
        msg.merge!({
          "@timestamp": time,
          severity: severity,
          progname: progname,
        })
      end
      msg.to_json + "\n"
    else
      {
        "@timestamp": time,
        severity: severity,
        progname: progname,
        message: msg
      }.to_json + "\n"
    end
  end
end
