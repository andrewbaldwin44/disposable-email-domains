BLOCKLIST_CONTENT = File.readlines('disposable_email_blocklist.conf', chomp: true).to_set.freeze

def disposable_email?(email)
  domain_parts = email.split('@')[1].split('.')

  (0...domain_parts.length - 1).each do |i|
    if BLOCKLIST_CONTENT.include?(domain_parts[i..-1].join('.'))
      puts ("Not permanent")
      return false
    end
  end
  puts("Permanent")
  true
end

disposable_email?("test@test.omega.alpha.10dk.email")
