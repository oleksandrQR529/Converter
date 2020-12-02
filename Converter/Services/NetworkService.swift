//
//  NetworkService.swift
//  Converter
//
//  Created by Саша Дранчук on 01.12.2020.
//

import Foundation

typealias OnApiSuccess = ([Currency]) -> Void
typealias OnApiError = (String) -> Void

class NetworkService {
    static let instance = NetworkService()
    
    let session = URLSession(configuration: .default)
    
    func getCurrensies(dataUrl urlString: String, onSuccess: @escaping OnApiSuccess, onError: @escaping OnApiError) {
        
        guard let url = URL(string: urlString) else {
            onError("Invalid url")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            self.connectToURl(error: error, response: response, data: data) { (currency) in
                onSuccess(currency)
            } onError: { (errorMessage) in
                onError(errorMessage)
            }
            
        }
        task.resume()
    }
    
    
    private func connectToURl(error: Error?, response: URLResponse? , data: Data? , onSuccess: @escaping OnApiSuccess, onError: @escaping OnApiError) {
        
        DispatchQueue.main.async {
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                onError("Invalid data from response")
                return
            }
            
            do{
                let items = try JSONDecoder().decode([Currency].self, from: data)
                onSuccess(items)
            }catch{
                onError(error.localizedDescription)
            }
        }
    }
    
}
