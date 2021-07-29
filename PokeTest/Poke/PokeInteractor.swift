import Foundation

protocol PokeInteracting: AnyObject {
    func fetch()
    func open()
}

final class PokeInteractor {
    private let service: PokeServicing
    private let presenter: PokePresenting
    private let featureFlag: Bool
    let url = URL(string: "https://pokeapi.co/api/v2/pokemon/charmander")

    init(service: PokeServicing, presenter: PokePresenting, featureFlag: Bool) {
        self.service = service
        self.presenter = presenter
        self.featureFlag = featureFlag
    }
}

// MARK: - PokeInteracting
extension PokeInteractor: PokeInteracting {
    func fetch() {
        guard let url = url, featureFlag else {
            presenter.presentError()
            return
        }
        
        service.fetch(model: Pokemon.self, url: url) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.presenter.present(pokemon: pokemon)
            case .failure:
                self?.presenter.presentError()
            }
        }
    }
    
    func open() {
        if featureFlag {
            presenter.nextStep(action: .open(featureFlag: featureFlag))
        } else {
            presenter.nextStep(action: .close)
        }
    }
}
