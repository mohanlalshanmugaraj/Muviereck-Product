//
//  Extension.swift
//  SampleProject
//
//  Created by Ajaaypranav R K on 31/10/22.
//

import Foundation
import SwiftUI
import AlertToast




extension View {
    func customToastDialog(isShowToast:Binding<Bool>, toastMessage:Binding<String>)   -> some View {
        modifier(ToastDialogModitier(isShowToast: isShowToast, toastMessage: toastMessage))
    }
    
    
    func convertToScrollView<Content : View>(@ViewBuilder content: @escaping () -> Content) -> UIScrollView {
        let scrollView = UIScrollView()
        
        let hostingController = UIHostingController(rootView: content()).view!
        hostingController.translatesAutoresizingMaskIntoConstraints = false
        
        let constrains = [
            hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.widthAnchor.constraint(equalToConstant: screenBounds.width)
        ]
        scrollView.addSubview(hostingController)
        scrollView.addConstraints(constrains)
        scrollView.layoutIfNeeded()
        
        return scrollView
    }
    
    func exportPDF<Content : View>(@ViewBuilder content: @escaping () -> Content,complection : @escaping(Bool,URL?)->()) {
     
        
        let documentDirecory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let outputFileUrl = documentDirecory.appendingPathComponent("Project\(UUID().uuidString).pdf")
        let pdfView = convertToScrollView {
            content()
        }
        let size = pdfView.contentSize
        pdfView.tag = 1009
        pdfView.frame = CGRect(x: 0, y: safeArea.top, width: size.width, height: size.height)
        getRootController().view.insertSubview(pdfView, at: 0)
        let reader = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        do {
            try reader.writePDF(to: outputFileUrl, withActions: { context in
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            complection(true,outputFileUrl)
        }catch {
            complection(false,nil)
            print(error)
        }
        
        
        getRootController().view.subviews.forEach { view in
            if view.tag == 1009 {
                print("removed")
                view.removeFromSuperview()
            }
        }
        
        
        
    }
    
    func getRootController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
    
    var screenBounds : CGRect {
        return UIScreen.main.bounds
    }
    
    var safeArea : UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let root = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return root
    }
}

extension Double {
    
    func getFormatedString() -> String {
        
        return String(format: "%.2f", self)
    }
    
    func getFormatedString(digits:Int) -> String {
        
        return String(format: "%.\(digits)f", self)
    }
    
}

struct ToastDialogModitier : ViewModifier {
    @Binding var isShowToast :Bool
    @Binding var toastMessage :String
    func body(content : Content) -> some View {
        content.toast(isPresenting: $isShowToast , duration: 2, tapToDismiss: true, alert: {
            AlertToast(displayMode: .banner(.pop), type: .regular, title: toastMessage)
        }, onTap: {
        }, completion: {
            toastMessage = ""
        })
    }
}

