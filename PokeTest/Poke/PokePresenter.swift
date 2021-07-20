import Foundation

protocol PokePresenting: AnyObject {
    var viewController: PokeDisplaying? { get set }
    func present(pokemon: Pokemon)
    func presentError()
    func nextStep(action: PokeAction)
}

final class PokePresenter {
private let coordinator: PokeCoordinating
    weak var viewController: PokeDisplaying?

    init(coordinator: PokeCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - PokePresenting
extension PokePresenter: PokePresenting {
    func present(pokemon: Pokemon) {
        viewController?.display(abilities: pokemon.abilities.description)
    }
    
    func presentError() {
        viewController?.displayError()
    }
    
    func nextStep(action: PokeAction) {
        coordinator.perform(action: action)
    }
}
