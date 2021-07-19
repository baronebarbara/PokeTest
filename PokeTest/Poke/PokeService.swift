import Foundation

enum APIError: Error {
    case genericError
}

protocol PokeServicing {
    func fetch(completion: @escaping(Result<Pokemon, APIError>) -> Void)
}

final class PokeService {
}


// MARK: - PokeServicing
extension PokeService: PokeServicing {
    func fetch(completion: @escaping (Result<Pokemon, APIError>) -> Void) {
        
    }
    
}
