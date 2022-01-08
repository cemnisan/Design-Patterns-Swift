import UIKit

// Protocol
protocol ISortedStrategy {
    func sorted<T:Comparable>(_ data: [T]) -> [T]
}

// Context
class SortedContext {
    private var strategy: ISortedStrategy
    
    init(strategy: ISortedStrategy) {
        self.strategy = strategy
    }
    
    func businessLogic() {
        let result = strategy.sorted([204,29,4,10,3,14,1])
        print(result)
    }
}

// Concrete
class SomeClassA: ISortedStrategy {
    func sorted<T>(_ data: [T]) -> [T] where T: Comparable {
        return data.sorted()
    }
}

class SomeClassB: ISortedStrategy {
    func sorted<T>(_ data: [T]) -> [T] where T: Comparable {
        return data.sorted(by: >)
    }
}

let contextA = SortedContext(strategy: SomeClassA())
let contextB = SortedContext(strategy: SomeClassB())

contextA.businessLogic()
contextB.businessLogic()

// Protocol
protocol ICryptStrategy {
    func encrypt(_ text: String) -> String
    func decrypt(_ text: String) -> String
}

// Context
class CryptContext {
    private var cryptStrategy: ICryptStrategy
    
    init(cryptStrategy: ICryptStrategy) {
        self.cryptStrategy = cryptStrategy
    }
    
    func encryptText() {
        let result = cryptStrategy.encrypt("")
        print(result)
    }
    
    func decryptText() {
        let result = cryptStrategy.decrypt("")
        print(result)
    }
}

// Concrete
class MessageReversal: ICryptStrategy {
    func encrypt(_ text: String) -> String {
        
        return "encrypt with messageReversal"
    }
    
    func decrypt(_ text: String) -> String {
        
        return "decrypt with messageReversal"
    }
}

class RouteTransposition: ICryptStrategy {
    func encrypt(_ text: String) -> String {
        
        return "encrypt with routeTransposition"
    }
    
    func decrypt(_ text: String) -> String {
        
        return "decrypt with routeTransposition"
    }
}

class ColumnarTransposition: ICryptStrategy {
    func encrypt(_ text: String) -> String {
        
        return "encrypt with columnarTransposition"
    }
    
    func decrypt(_ text: String) -> String {
        
        return "decrypt with columnarTransposition"
    }
}

let reversalContext = CryptContext(cryptStrategy: MessageReversal())
let routeContext = CryptContext(cryptStrategy: RouteTransposition())
let columnarContext = CryptContext(cryptStrategy: ColumnarTransposition())

reversalContext.encryptText()
reversalContext.decryptText()

routeContext.encryptText()
routeContext.decryptText()

columnarContext.encryptText()
columnarContext.decryptText()
