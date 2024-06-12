public func optionalEquals<A, B>(_ a: A?, _ b: B?, _ eq: (A, B) -> Bool) -> Bool {
    switch (a, b) {
    case (.some(let a), .some(let b)):
        return eq(a, b)
    default:
        return false
    }
}
