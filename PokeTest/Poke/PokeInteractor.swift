import Foundation

protocol PokeInteracting: AnyObject {
    func fetch()
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
    func fetch() {
        guard featureFlag else {
            presenter.presentError()
            return
        }
        
        service.fetch { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.presenter.present(pokemon: pokemon)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    func open() {
        
    }
}
