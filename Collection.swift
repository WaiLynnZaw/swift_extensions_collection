extension Collection {
    func find(predicate: (Self.Generator.Element) throws -> Bool) rethrows -> Self.Generator.Element? {
        return try index(where: predicate).map({self[$0]})
    }
}