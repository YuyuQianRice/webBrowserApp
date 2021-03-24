//
//  ViewController.swift
//  toyWebBrowser
//
//  Created by Yuyu Qian on 3/23/21.
//

import UIKit
import WebKit

protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: Info)
}

class ViewController: UIViewController, WKNavigationDelegate, UIWebViewDelegate {

    var webViewURLObserver: NSKeyValueObservation?
    
    var currentURL: String?
    
    var index = 0
    
    weak var delegate: DataEnteredDelegate? = nil
    @IBAction func goTOTabs(_ sender: Any) {
//        self.parent?.navigationController?.popViewController(animated: true)
//        let rootc = navigationController?.viewControllers.first as! TabCollectionViewController
//        rootc.currentURL = self.currentURL ?? "https://www.google.com"
        
        delegate?.userDidEnterInformation(info: Info(url: self.currentURL ?? "https://www.google.com", index: self.index) )
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var url: UISearchBar!
    
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBAction func back(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
        
    @IBAction func forward(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func pause(_ sender: Any) {
        webView.stopLoading()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var url: URL
        useUrl(currentURL ?? "")
        print("My index \(self.index)")
//        let request = URLRequest(url: url!)
        
//        webView.load(request)
        
        webView.addSubview(ActInd)
        ActInd.startAnimating()
        
        
        webView.navigationDelegate = self
//        self.url.delegate = self
        ActInd.hidesWhenStopped = true
        webView.allowsBackForwardNavigationGestures = true
        self.url.text = webView.url?.absoluteString
        self.currentURL = webView.url?.absoluteString
//        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        webViewURLObserver = webView.observe(\.url, options: .new) {_,_ in
            self.url.text = self.webView.url?.absoluteString
            self.currentURL = self.webView.url?.absoluteString
        }
    }
    
//    override class func didChangeValue(forKey key: String, withSetMutation mutationKind: NSKeyValueSetMutationKind, using objects: Set<AnyHashable>) {
//        self.url.text = webView.url?.absoluteString
//    }
//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
//        self.url.text = self.webView.url?.absoluteString
//        return true;
//
//    }
    
//    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if let key = change?[NSKeyValueChangeKey.newKey]{
//            self.url.text = webView.url?.absoluteString
//        }
//    }
    override func viewDidAppear(_ animated: Bool) {
        self.url.text = webView.url?.absoluteString
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ActInd.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        ActInd.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        ActInd.startAnimating()
    }
    
    
}



extension ViewController: UISearchBarDelegate {
    func loadUrl(_ urlStr: String) {
        
        guard let url = URL(string: urlStr) else { return }
        
       let urlRequest = URLRequest(url: url)
        print(urlStr)
        self.url.text = urlRequest.url?.absoluteString
        currentURL = urlRequest.url?.absoluteString
       webView.load(urlRequest)
    }
    
    func searchTextOnGoogle(_ text: String) {
        let textComponents = text.components(separatedBy: " ")

        let searchString = textComponents.joined(separator: "+")

        guard let url = URL(string: "https://www.google.com/search?q=" + searchString) else { return }

        let urlRequest = URLRequest(url: url)
        self.url.text = urlRequest.url?.absoluteString
        currentURL = urlRequest.url?.absoluteString
        webView.load(urlRequest)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        url.text = url.text?.lowercased()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        url.resignFirstResponder()
        
        let urlText = url.text
        var urlString = ""
        if urlText != "" {
            urlString = urlText!.lowercased() ?? ""
        }
        
//        let url = URL(string: "https://\(urlString!)")
//        let request = URLRequest(url: url!)
//        webView.load(request)
        if  urlString.hasPrefix("http://") || urlString.hasPrefix("https://") {
            loadUrl(urlString)
        } else if (urlString.hasPrefix("www.") && urlString.hasSuffix(".com")){
            loadUrl("https://\(urlString)")
        } else if (urlString.hasSuffix(".com")) {
            loadUrl("https://www.\(urlString)")
        } else {
            searchTextOnGoogle(urlString)
        }
    }
    
    func useUrl (_ urlString:String) {
        if  urlString.hasPrefix("http://") || urlString.hasPrefix("https://") {
            loadUrl(urlString)
        } else if (urlString.hasPrefix("www.") && urlString.hasSuffix(".com")){
            loadUrl("https://\(urlString)")
        } else if (urlString.hasSuffix(".com")) {
            loadUrl("https://www.\(urlString)")
        } else {
            searchTextOnGoogle(urlString)
        }
    }
    
}

