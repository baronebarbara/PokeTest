import Foundation

enum APIError: Error {
    case decodeError
    case nilData
    case serverError(error: Error)
    case responseNotConverted
    case code(status: StatusCode)
}

enum StatusCode: Equatable {
    case informational
    case success
    case redirection
    case clientError
    case serverError
    case undefined
    
    static func getType(code: Int) -> Self {
        switch code {
        case 100..<200:
            return .informational
        case 200..<300:
            return .success
        case 300..<400:
            return .redirection
        case 400..<500:
            return .clientError
        case 500..<600:
            return .serverError
        default:
            return .undefined
        }
    }
}

protocol PokeServicing {
    func fetch<T: Decodable>(model: T.Type, url: URL, completion: @escaping (Result<T, APIError>) -> Void)
}

final class PokeService {
    private let session: URLSession
    private let queue: DispatchQueue
    
    init(session: URLSession = URLSession.shared, queue: DispatchQueue = DispatchQueue.main) {
        self.session = session
        self.queue = queue
    }
}


// MARK: - PokeServicing
extension PokeService: PokeServicing {
    func fetch<T: Decodable>(model: T.Type, url: URL, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error: error)))
                return
            }
            guard let responseConverted = response as? HTTPURLResponse else {
                completion(.failure(.responseNotConverted))
                return
            }
            guard responseConverted.statusCode == 200 else {
                let status = StatusCode.getType(code: responseConverted.statusCode)
                completion(.failure(.code(status: status)))
                return
            }
            guard let data = data else {
                completion(.failure(.nilData))
                return
            }
            let decode = JSONDecoder()
            decode.keyDecodingStrategy = .convertFromSnakeCase
            self.queue.async {
                do {
                    let decoded = try decode.decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.decodeError))
                }
            }
        }
        task.resume()
    }
}
