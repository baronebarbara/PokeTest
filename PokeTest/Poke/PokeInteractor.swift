import Foundation

protocol PokeInteracting: AnyObject {
    func fetch()
    func open()
}

final class PokeInteractor {
    private let service: PokeServicing
    private let presenter: PokePresenting
    private let featureFlag: Bool

    init(service: PokeServicing, presenter: PokePresenting, featureFlag: Bool) {
        self.service = service
        self.presenter = presenter
        self.featureFlag = featureFlag
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
        if featureFlag {
            presenter.nextStep(action: .open(featureFlag: featureFlag))
        } else {
            presenter.nextStep(action: .close)
        }
    }
}
