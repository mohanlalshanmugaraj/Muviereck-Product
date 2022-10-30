//
//  CartView.swift
//  SampleProject
//
//  Created by Ajaaypranav R K on 30/10/22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: ViewModel
   
    var body: some View {
        VStack {
            ForEach(viewModel.cartProducts,id: \.id) { item in
                AddProductRow(product: item)
                    .environmentObject(viewModel)
            }
        
            Spacer()
        }.customToastDialog(isShowToast: $viewModel.showToast, toastMessage: $viewModel.toastMessage)
        
        .sheet(isPresented: $viewModel.showShareSheet){
            viewModel.pdfUrl = nil
        } content: {
            if let pdf = viewModel.pdfUrl {
                ShareSheet(urls: [pdf])
            }
        }
        
        
        .navigationBarTitle("Cart List")
            .navigationBarItems(trailing: Image(systemName: "square.and.arrow.up.circle.fill")
                                    .foregroundColor(.blue).onTapGesture {
                exportPDF {
                    InvoiceView()
                        .environmentObject(viewModel)
                   // self.environmentObject(viewModel)
                }complection: { flag, url in
                    if let url = url,flag {
                        print(url)
                        viewModel.pdfUrl = url
                        viewModel.showShareSheet.toggle()
                    }else {
                        print("error")
                    }
                }
            })
        
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(ViewModel())
    }
}


struct ShareSheet : UIViewControllerRepresentable {
    var urls : [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
