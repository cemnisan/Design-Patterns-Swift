protocol ObservableProtocol {
    var observers: [ObserverProtocol] { get set }
    
    func addObserver(_ observer: ObserverProtocol)
    func removeObserver(_ observer: ObserverProtocol)
    func notifyObservers(_ observers: [ObserverProtocol])
}

protocol ObserverProtocol {
    var id: Int { get set }
    
    func onValueChanged(_ value: Any?)
}

class Observable<T> {
    
    var coinValue: T {
        didSet {
            self.notifyObservers(self.observers)
        }
    }
    
    internal var observers: [ObserverProtocol] = []
    
    init(coinValue: T) {
        self.coinValue = coinValue
    }
    
    deinit {
        observers.removeAll()
    }
}

extension Observable: ObservableProtocol {
    func addObserver(_ observer: ObserverProtocol) {
        guard self.observers.contains(where: { $0.id == observer.id }) == false else { return }
        
        self.observers.append(observer)
    }
    
    func removeObserver(_ observer: ObserverProtocol) {
        guard let index = self.observers.firstIndex(where: { $0.id == observer.id }) else { return }
        
        self.observers.remove(at: index)
    }
    
    func notifyObservers(_ observers: [ObserverProtocol]) {
        observers.forEach({ $0.onValueChanged(coinValue) })
    }
}

class Coins {
    var value: Observable<Double>
    
    init(value: Double) {
        self.value = Observable(coinValue: value)
    }
    
    func updateCoinValue() {
        value.coinValue = value.coinValue + 1
    }
}

class HomeViewModel: ObserverProtocol {
    var id = 1
    
    func onValueChanged(_ value: Any?) {
        print("Home: new coin value: \(value)")
    }
}

class ProfileViewModel: ObserverProtocol {
    var id = 2
    
    func onValueChanged(_ value: Any?) {
        print("Profile: new coin value: \(value)")
    }
}

class BuyCryptoViewModel: ObserverProtocol {
    var id = 3
    
    func onValueChanged(_ value: Any?) {
        print("Buy Crypto: new coin value: \(value)")
    }
}

let coins = Coins(value: 2.3)
let homeViewModel = HomeViewModel()
let profileViewModel = ProfileViewModel()
let buyCryptoViewModel = BuyCryptoViewModel()

coins.value.addObserver(homeViewModel)
coins.value.addObserver(profileViewModel)
coins.value.addObserver(buyCryptoViewModel)

coins.updateCoinValue()

