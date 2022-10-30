//
//  ContentView.swift
//  SampleProject
//
//  Created by Ajaaypranav R K on 29/10/22.
//

import SwiftUI
import AlertToast

struct ProductListView: View {
   @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.model.products,id: \.id) { data in
                        ProductRow(product: data)
                            .environmentObject(viewModel)
                    }
                }
            }.navigationBarItems(trailing: NavigationLink {
                CartView().environmentObject(viewModel)
            }label: {
                Image(systemName: "cart.fill")
            })
                .navigationBarTitle("Product List", displayMode: .inline)
                .onAppear(perform: onAppear)
        }.customToastDialog(isShowToast: $viewModel.showToast, toastMessage: $viewModel.toastMessage)
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
        
    }
}

extension ProductListView {
    func onAppear() {
        viewModel.getDataModel()
    }
}





