require_relative('bank_state.rb')

class Banker
  def initialize(state)
    @state = state
    raise "Initial state is unsafe. Abort." if !state.isSafe() end
  end

  def request_resources(customer_id, request)
    puts("Customer #{id} requests #{request}. No logic yet.")
    return true
  end

  def release_resources(customer_id, release)
    puts("Customer #{id} wants to release #{release}. No logic yet.")
    return true
  end

end
