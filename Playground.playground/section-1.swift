/**
Compares two numbers lhs and rhs.

:param: lhs numerical value.
:param: rhs numerical value.

:returns: 1 whether lhs > rhs, -1 whether lhs < rhs; otherwise 0.
*/
infix operator <=> {
    precedence 0
    associativity none
}

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
