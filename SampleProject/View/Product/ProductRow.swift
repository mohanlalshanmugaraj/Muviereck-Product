//
//  ProductRow.swift
//  SampleProject
//
//  Created by Ajaaypranav R K on 30/10/22.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var product : Product
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: product.thumbnail),
                content: { image in
                    image .resizable()
                        .resizable()
                        .scaleEffect()
                        .cornerRadius(7)
                        .frame(width: 68, height: 68)
                        .padding(.all, 5)
                },
                placeholder: {
                    ProgressView()
                        .frame(width: 68, height: 68)
                }
            )
            VStack(alignment: .leading,spacing: 5){
                Text(product.title)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                HStack {
                    Text("$\(product.price)")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                    Spacer()
                    
                    Button {
                        if !isAdded {
                            viewModel.addCart(product: product)
                        }else {
                            viewModel.showToastMessage("Product Already Added")
                        }
                        
                    }label: {
                        Text(isAdded ? "Added" : "Add Cart")
                            .padding(10)
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                            .background(isAdded ? .green : .blue)
                            .cornerRadius(5)
                            .padding(.trailing)
                    }.frame(alignment: .bottom)
                }
            }
            Spacer()
        }
        
    }
    
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product(id: 1, title: "iPhone 9", productDescription: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://dummyjson.com/image/i/products/1/thumbnail.jpg", images: []))
            .environmentObject(ViewModel())
    }
}


extension ProductRow {
    
    var isAdded : Bool {
        if let _ = viewModel.cartProducts.firstIndex(where: {$0.id == product.id}) {
            return true
        }else {
            return false
        }
    }
    
}

