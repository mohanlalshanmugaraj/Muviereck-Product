//
//  Product.swift
//  SampleProject
//
//  Created by Ajaaypranav R K on 30/10/22.
//

import Foundation
import UIKit

class Product : ObservableObject {
    var id : Int = 0
    var qty : Int = 0
    var title : String = ""
    var productDescription : String = ""
    var price : Int = 0
    var discountPercentage : Double = 0.00
    var rating : Double = 0.00
    var stock : Int = 0
    var brand : String = ""
    var category : String = ""
    var thumbnail : String = ""
    var images : [String] = []
    
    init(id:Int , title : String , productDescription:String,price:Int,discountPercentage:Double,rating:Double,stock:Int,brand:String,category:String,thumbnail:String,images:[String]) {
        self.id = id
        self.qty = 0
        self.title = title
        self.productDescription = productDescription
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
    
    init(responseData : [String:Any]) {
        self.id = responseData["id"] as? Int ?? 0
        self.title = responseData["title"] as? String ?? ""
        self.productDescription = responseData["productDescription"] as? String ?? ""
        self.price = responseData["price"] as? Int ?? 0
        self.discountPercentage = responseData["discountPercentage"] as? Double ?? 0.00
        self.rating = responseData["rating"] as? Double ?? 0.00
        self.stock = responseData["stock"] as? Int ?? 0
        self.brand = responseData["brand"] as? String ?? ""
        self.category = responseData["category"] as? String ?? ""
        self.thumbnail = responseData["thumbnail"] as? String ?? ""
        self.images = responseData["images"] as? [String] ?? []
    }
    
    static func getData(data : [[String:Any]]) -> [Product] {
        var temp : [Product] = []
        for datum in data {
            temp.append(Product(responseData: datum))
        }
        
        return temp
    }
    
}
