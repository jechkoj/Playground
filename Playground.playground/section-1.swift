/**
 Compares two numbers lhs and rhs.

 :param: lhs numerical value.
 :param: rhs numerical value.

 :returns: 1 whether lhs > rhs, -1 whether lhs < rhs; otherwise 0.
*/
infix operator <=>:ComparisonPrecedence

func <=> <T: Comparable> (lhs: T, rhs: T) -> Int {
    if lhs > rhs {
        return 1
    } else if lhs < rhs {
        return -1
    }
    
    return 0
}

3 <=> 4
0 <=> -5
0 <=> 0


/**
 Finds the minimal and maximal element in a sequence type.
 More efficient than calling min and max separately on a sequence.
 
 :returns: Tuple containing the mininal and tha maximal element of the sequence
*/
extension Sequence where Iterator.Element : Comparable {
    public func minMaxElement() -> (Self.Iterator.Element, Self.Iterator.Element)? {
        var it = self.makeIterator()
        guard var min = it.next() else { return nil }
        var max = min
        
        while let first = it.next() {
            if let second = it.next() {
                if first > second {
                    if max < first {
                        max = first
                    }
                    
                    if min > second {
                        min = second
                    }
                } else {
                    if max < second {
                        max = second
                    }
                    
                    if min > first {
                        min = first
                    }
                }
            } else {
                if max < first {
                    max = first
                }
                
                if min > first {
                    min = first
                }
            }
        }
        
        return (min, max)
    }
    
}

[1, 2, 4, 67].minMaxElement()
