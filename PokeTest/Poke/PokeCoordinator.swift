import UIKit

enum PokeAction {
}

protocol PokeCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func perform(action: PokeAction)
}

final class PokeCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - PokeCoordinating
extension PokeCoordinator: PokeCoordinating {
    func perform(action: PokeAction) {
    }
}
