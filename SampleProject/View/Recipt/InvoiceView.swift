//
//  InvoiceView.swift
//  SampleProject
//
//  Created by Ajaaypranav R K on 30/10/22.
//

import SwiftUI

struct InvoiceView: View {
    @EnvironmentObject var viewModel : ViewModel
    
    var totalAmount : String {
        var temp : Int = 0
        for product in viewModel.cartProducts  {
            let tp = product.price * product.qty
            temp += tp
        }
        return "\(temp)"
    }
    var body: some View {
        VStack (alignment:.leading,spacing: 0){
           Text("Order Details")
                .font(.title)
                .frame(maxWidth:.infinity,alignment: .center)
                .padding()
            Divider()
                .frame(minHeight:2)
                .background(.black)
            
            HStack {
                Divider()
                    .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
                
                Text("Name")
                    .frame(width: screenBounds.width / 5)

                Divider()
                    .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
                
                Text("Price")
                    .frame(width: screenBounds.width / 5)
                Divider() .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
                Text("Qty")
                
                    .frame(width: screenBounds.width / 5)
                Divider() .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
                Text("Amount")
        
                    .frame(width: screenBounds.width / 5)
                Divider() .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
            }.background(.gray)
                .frame(maxWidth:.infinity,alignment: .center)
            
            
            ForEach(viewModel.cartProducts,id: \.id) { item in
                InvoiceRow(product: item)
            }
            HStack {
                Text("Total Amount")
                     .frame(maxWidth:.infinity,alignment:.trailing)
                Text(totalAmount)
            }.padding()
          
            Spacer()
        }
    }
}

struct InvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceView()
    }
}

struct InvoiceRow: View {
    @State var product : Product
    
    var totalPrice : String {
        return "\(product.price *  product.qty)"
    }
    
    var body: some View {
        VStack (spacing:0){
            Divider()
                .frame(minHeight:2)
                .background(.black)
            
            HStack {
                Divider()
                    .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
                
                Text(product.title)
                    .frame(height:50)
                    .frame(width: screenBounds.width / 5)
                
                Divider()
                    .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
                
                Text("\(product.price)")
                    .frame(width: screenBounds.width / 5)
                Divider() .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
                Text("\(product.qty)")
                
                    .frame(width: screenBounds.width / 5)
                Divider() .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
                Text(totalPrice)
                
                    .frame(width: screenBounds.width / 5)
                Divider() .frame(height:50)
                    .frame(minWidth:2)
                    .background(.black)
            }
            //.padding([.leading,.trailing])
            .frame(maxWidth:.infinity,alignment: .center)
            
            Divider()
                .frame(minHeight:2)
                .background(.black)
        }
    }
}
