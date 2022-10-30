//
//  AddProductRw.swift
//  SampleProject
//
//  Created by Ajaaypranav R K on 30/10/22.
//

import SwiftUI

struct AddProductRow: View {
    @State var product : Product
    @EnvironmentObject var viewModel: ViewModel
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
                HStack {
                    Text(product.title)
                          .font(.system(size: 14))
                          .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "trash.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(.red)
                        .padding()
                        .onTapGesture {
                            viewModel.removeCart(product: product)
                        }
                }
               
                HStack {
                    Text("$\(product.price)")
                         .font(.system(size: 16))
                         .fontWeight(.medium)
                         .padding(.bottom)
                    Spacer()
                    
                    HStack(spacing:0) {
                        Button {
                            if product.qty != 0 {
                                product.qty -= 1
                                updateData()
                            }
                        }label: {
                             Text("-")
                                .fontWeight(.bold)
                                .padding(10)
                                .font(.system(size: 14))
                                .cornerRadius(5)
                                
                                
                        }.frame(alignment: .bottom)
                        
                        Text("\(product.qty)")
                            .padding(10)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .background(.blue)
                        
                            
                        
                        Button {
                            product.qty +=  1
                            updateData()
                        }label: {
                             Text("+")
                                .fontWeight(.bold)
                                .padding(10)
                                .font(.system(size: 14))
                                .cornerRadius(5)
                                
                        }.frame(alignment: .bottom)
                    }.overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .padding(.trailing)
                   
                }
            }
            Spacer()
            
        }
    }
}

struct AddProductRw_Previews: PreviewProvider {
    static var previews: some View {
        AddProductRow(product: Product(id: 1, title: "iPhone 9", productDescription: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 94, brand: "Apple", category: "smartphones", thumbnail: "https://dummyjson.com/image/i/products/1/thumbnail.jpg", images: []))
            .environmentObject(ViewModel())
    }
}


extension AddProductRow {
    func updateData() {
        viewModel.updateQty(product: product)
    }
    
   
}
