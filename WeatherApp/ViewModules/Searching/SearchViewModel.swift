//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by Guglielmo Chimera on 13/06/22.
//

import Foundation

class SearchViewModel {
    
    var searchResultList: [SearchResultModel]?
     
    
    func performSearch(byCityName: String, limit: Int? = nil) -> [SearchResultModel] {
        print("searching \(byCityName)....")
     
        // Make Api call
        WeatherRequest.shared.dataRequest(with: "\(OpenweatherAPI.baseURL)\(OpenweatherAPI.path)?\(OpenweatherAPI.query.q)=\(byCityName)&limit=\(limit ?? 15)&appid=\(OpenweatherAPI.apiKey)", objectType: [SearchResultModel].self)
        { result in
        switch result {
        case .success(let object):
            print(object.first?.country ?? "null")
            self.searchResultList = object
        case .failure(let error):
            print(error)
        }
        }
        
        // Populate searchResultList variable
        
        return []
        
    }
    
    
    
    
    
}
