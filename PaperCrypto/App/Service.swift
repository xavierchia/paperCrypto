// Service.swift
import RxSwift
import Alamofire

protocol ServiceProtocol {
    func fetchCryptoMarketList(currency: Currencies) -> Observable<CryptoMarketList?>
    func fetchCryptoDetail(id: String) -> Observable<CryptoDetailModel?>
    func fetchCustomCryptoMarketList(ids: String, currency: Currency) -> Observable<CustomCryptoMarketModel?>
}

final class Service {
    static let shared = Service()
}

extension Service: ServiceProtocol {
    func fetchCryptoMarketList(currency: Currencies) -> Observable<CryptoMarketList?> {
        let url = CryptoEndPoint.fetchAllList.url
        let parameters: Parameters = [
            "vs_currency": Currency.usd
        ]
        
        return NetworkManager.shared.sendRequest(
            type: CryptoMarketList.self,
            url: url,
            method: .get,
            parameters: parameters
        )
        .map { Optional($0) }
    }
    
    func fetchCryptoDetail(id: String) -> Observable<CryptoDetailModel?> {
        let url = CryptoEndPoint.fetchCryptoDetail.url + id
        
        return NetworkManager.shared.sendRequest(
            type: CryptoDetailModel.self,
            url: url,
            method: .get
        )
        .map { Optional($0) }
    }
    
    func fetchCustomCryptoMarketList(
        ids: String,
        currency: Currency
    ) -> Observable<CustomCryptoMarketModel?> {
        let url = CryptoEndPoint.fetchCustomList.url
        let parameters: Parameters = [
            "ids": ids,
            "vs_currency": currency
        ]
        
        return NetworkManager.shared.sendRequest(
            type: CustomCryptoMarketModel.self,
            url: url,
            method: .get,
            parameters: parameters
        )
        .map { Optional($0) }
    }
}
