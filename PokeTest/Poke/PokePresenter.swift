import Foundation

protocol PokePresenting: AnyObject {
    var viewController: PokeDisplaying? { get set }
    func displaySomething()
    func didNextStep(action: PokeAction)
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
    func displaySomething() {
        viewController?.displaySomething()
    }
    
    func didNextStep(action: PokeAction) {
        coordinator.perform(action: action)
    }
}
