import Foundation
import UIKit

enum PokeAction: Equatable {
    case open(featureFlag: Bool)
    case close
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
        switch action {
        case .open(let featureFlag):
            if featureFlag {
                viewController?.present(PokeDescriptionViewController(), animated: true)
            } else {
                viewController?.dismiss(animated: true)
            }
        case .close:
            viewController?.dismiss(animated: true)
        }
    }
}
