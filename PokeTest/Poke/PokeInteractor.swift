import Foundation

protocol PokeInteracting: AnyObject {
    func fetch(text: String?)
    func open()
}

final class PokeInteractor {
    private let service: PokeServicing
    private let presenter: PokePresenting
    
    var featureFlag: Bool = true

    init(service: PokeServicing, presenter: PokePresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - PokeInteracting
extension PokeInteractor: PokeInteracting {
    func fetch(text: String?) {
        
    }
    
    func open() {
        
    }
    
   
}
