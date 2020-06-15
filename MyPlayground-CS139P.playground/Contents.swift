import UIKit

var str = "Hello, playground"
print(str)

protocol Greatness {
    func isGraterThan(other: Self) -> Bool
}
//will not handle empty list / array
//will retrurn largest # in array
extension Array where Element: Greatness & Comparable {
    var greatest: Element? {
//        //This following way is how to do it in a recursive fashion yourself
//        var Maximum = self[0]
//        //go over the entire array to compare
//        for element in self {
//            if element.isGraterThan(other: Maximum) {
//                Maximum = element
//            }
//        }
//        return Maximum
        // This way is how you do with via the Comparable Protocol and built in max() method
        return max()
    
    }
    
}

extension Int: Greatness {
    func isGraterThan(other: Int) -> Bool {
        self > other
    }
}

var numArray: Array = [0,23,211,234,32,12]
let too = numArray.greatest

