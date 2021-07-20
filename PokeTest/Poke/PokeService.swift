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
        let session = URLSession.shared
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/charmander") else { return }
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decode = JSONDecoder()
            decode.keyDecodingStrategy = .convertFromSnakeCase
            DispatchQueue.main.async {
                do {
                    let decoded = try decode.decode(Pokemon.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.genericError))
                }
            }
        }
        task.resume()
    }
}
