map '/' do
  def fibonacci(n)
    return n if (0..1).include?(n)
    fibonacci(n - 1) + fibonacci(n - 2)
  end

  fib = proc do |env|
    match = env['PATH_INFO'].match(/\/(\d*)/)[1]

    if match.length > 0
      now = Time.now
      body = fibonacci(match.to_i).to_s
      [200, { "Content-Type" => "text/html" }, ["#{body}"]]
    elsif match = env['PATH_INFO'] =~ /^\/crash/
      exit! 99
    else
      [200, { "Content-Type" => "text/html" }, ["Enter a number to calculate the fibonacci number for, ie. (/10 ==> 55) or /crash to kill self"]]
    end
  end
  run fib
end
