extension Array {
    func unique<T:Hashable>(by: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
    func removeDuplicates() -> [Int] {
        var result = [Int]()
        
        for value in self {
            if !result.contains(value as! Int) {
                result.append(value as! Int)
            }
        }
        
        return result
    }
}