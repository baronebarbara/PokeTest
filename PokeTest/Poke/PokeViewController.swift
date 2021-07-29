import UIKit

protocol PokeDisplaying: AnyObject {
    func display(abilities: String)
    func displayError()
}

final class PokeViewController: UIViewController {
    private let interactor: PokeInteracting
    
    init(interactor: PokeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetch()
    }
    
    required init?(coder: NSCoder) { nil }
}

// MARK: - PokeDisplaying
extension PokeViewController: PokeDisplaying {
    func display(abilities: String) {
        
    }
    
    func displayError() {
        
    }
}
