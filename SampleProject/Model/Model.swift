//
//  MWSModel.swift
//  SampleProject
//
//  Created by Ajaaypranav R K on 29/10/22.
//

import Foundation

class Model : ObservableObject{
    var products : [Product] = []
    var total : Int = 0
    var skip : Int = 0
    var limit : Int = 0
    
    init() {
        products = []
    }
    
    init(responseData : [String:Any]) {
        self.products = Product.getData(data: responseData["products"] as? [[String:Any]] ?? [])
        self.total = responseData["total"] as? Int ?? 0
        self.skip = responseData["skip"] as? Int ?? 0
        self.limit = responseData["limit"] as? Int ?? 0
   
    }
    
    func getData(data : [[String:Any]]) -> [Model] {
        var temp : [Model] = []
        for datum in data {
            temp.append(Model(responseData: datum))
        }
        return temp
  }
}



