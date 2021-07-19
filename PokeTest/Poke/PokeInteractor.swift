import Foundation

protocol PokeInteracting: AnyObject {
    func doSomething()
}

final class PokeInteractor {
    private let service: PokeServicing
    private let presenter: PokePresenting

    init(service: PokeServicing, presenter: PokePresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - PokeInteracting
extension PokeInteractor: PokeInteracting {
    func doSomething() {
        presenter.displaySomething()
    }
}
