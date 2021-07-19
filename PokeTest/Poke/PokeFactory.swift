import UIKit

enum PokeFactory {
    static func make() -> PokeViewController {
        let service: PokeServicing = PokeService()
        let coordinator: PokeCoordinating = PokeCoordinator()
        let presenter: PokePresenting = PokePresenter(coordinator: coordinator)
        let interactor = PokeInteractor(service: service, presenter: presenter)
        let viewController = PokeViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
