// NetworkManager.swift
import RxSwift
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func sendRequest<T: Codable>(
        type: T.Type,
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil) -> Observable<T> {
        
        return Observable.create { observer in
            let request = AF.request(url,
                method: method,
                parameters: parameters,
                encoding: URLEncoding.default)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(data)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
