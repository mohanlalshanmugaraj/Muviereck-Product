//
//  MWSViewModel.swift
//  SampleProject
//
//  Created by Ajaaypranav R K on 29/10/22.
//

import Foundation
import SwiftUI

//https://dummyjson.com/products/search?q=phone

class ViewModel : ObservableObject {
    @Published var pdfUrl : URL?
    @Published var showShareSheet : Bool = false
    @Published var showToast = false
    @Published var toastMessage = ""
    @Published var model : Model = Model()
    @Published var cartProducts : [Product] = []
    
    
    func showToastMessage(_ msg : String) {
        toastMessage = msg
        showToast = true
    }
    
    func addCart(product : Product) {
        self.cartProducts.append(product)
        self.showToastMessage("product Added \(product.title)")
    }
    
    func removeCart(product : Product) {
        if let row = self.cartProducts.firstIndex(where: {$0.id == product.id}) {
            cartProducts.remove(at: row)
            self.showToastMessage("product removed \(product.title)")
        }
    }
    
    func updateQty(product : Product) {
        if let row = self.cartProducts.firstIndex(where: {$0.id == product.id}) {
              cartProducts[row] = product
        }
    }
    
    func getDataModel () {
        let url = URL(string: "https://dummyjson.com/products/search?q=phone")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {  data, response, error in
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: [])
                print(jsonResponse)
                let newValue = jsonResponse as? [String:Any] ?? [:]
                
                DispatchQueue.main.async {
                    self.model = Model(responseData: newValue)
                }
            }
            catch  {
                print("Error: \(error)")
            }
        }
        
        task.resume()
    }
}
