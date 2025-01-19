//
//  CryptoServiceEndPoints.swift
//  CryptoVault-UIKit
//
//  Created by Cuma on 30/05/2023.
//

import Foundation

enum CryptoEndPoint {
    case fetchAllList
    case fetchCryptoDetail
    case fetchCustomList

    var baseUrl: String {
        return "https://api.coingecko.com/"
    }

    var path: String {
        return "api/v3/"
    }
    
    var url: String {
        return baseUrl + path + serviceUrl
    }

    var serviceUrl: String {
        switch self {
        case .fetchAllList:
            return "coins/markets"
        case .fetchCryptoDetail:
            return "coins/"
        case .fetchCustomList:
            return "coins/markets"
        }
    }
}
