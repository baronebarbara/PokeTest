import UIKit

protocol PokeDisplaying: AnyObject {
    func displaySomething()
}

final class PokeViewController: UIViewController {
    private let interactor: PokeInteracting
    
    init(interactor: PokeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PokeDisplaying
extension PokeViewController: PokeDisplaying {
    func displaySomething() { }
}
