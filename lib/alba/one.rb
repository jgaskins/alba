require_relative 'association'

module Alba
  # Representing one association
  class One < Association
    # Recursively converts an object into a Hash
    #
    # @param target [Object] the object having an association method
    # @param included [Hash] determines what associations to be serialized. If not set, it serializes all associations.
    # @param params [Hash] user-given Hash for arbitrary data
    # @return [Hash]
    def to_hash(target, included: nil, params: {})
      @object = target.public_send(@name)
      @object = @condition.call(object, params) if @condition
      return if @object.nil?

      @resource = constantize(@resource)
      @resource.new(object, params: params).to_hash(included: included)
    end
  end
end
