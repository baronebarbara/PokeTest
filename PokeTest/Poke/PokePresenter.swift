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
        
    }
    
    func presentError() {
        
    }
    
    func nextStep(action: PokeAction) {
        
    }
    
}
