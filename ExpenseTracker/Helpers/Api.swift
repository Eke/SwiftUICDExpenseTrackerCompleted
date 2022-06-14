//
//  Api.swift
//  ExpenseTracker
//
//  Created by Erekle Meskhi on 14.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation

class ApiClient {
    static func getCurrencyRate() async throws -> CurrencyRate {
        let payload: [String: Any] = [
            "amount": 1.0,
            "to_currency": "EUR",
            "from_currency": "USD"
        ]
        
        let jsonPayload = try JSONSerialization.data(withJSONObject: payload)

        guard let url = URL(string: "https://elementsofdesign.api.stdlib.com/aavia-currency-converter@dev/") else {
            throw NSError(domain: "", code: -1, userInfo:nil)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        dump(String(data: jsonPayload, encoding: .utf8))
        request.httpBody = jsonPayload
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return try await withUnsafeThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { (data, resp, err) in
                let json = String(data: data!, encoding: .utf8)
                if let error = err {
                    continuation.resume(throwing: error)
                    return
                }

                do {
                    let item = try JSONDecoder().decode(CurrencyRate.self, from: data!)
                    dump(item)
                    continuation.resume(returning: item)
                } catch {
                    dump(error)
                    continuation.resume(throwing: error)
                }
            }
            .resume()
        }
    }
}
