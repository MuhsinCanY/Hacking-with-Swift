//
//  ViewController.swift
//  ProjectFour
//
//  Created by Muhsin Can Yılmaz on 25.08.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView : UIProgressView!
    var websites = ["www.hackingwithswift.com","google.com"]
    var selectedWebsite : String?

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadFunc))
        let goBack = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBackFunc))
        let goForward = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(goForwardFunc))
        
        toolbarItems = [progressButton, goBack, goForward, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        if let website = selectedWebsite {
            let url = URL(string: "https://" + website)!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
        
    }
    
    @objc func reloadFunc() {
        webView.reload()
    }
    
    @objc func goBackFunc(){
        webView.goBack()
    }
    
    @objc func goForwardFunc(){
        webView.goForward()
    }
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page...", message: "", preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Close", style: .cancel))
        //tells iOS where it should make the action sheet be anchored. Below code
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action : UIAlertAction){
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else {return}
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
   
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                    
                }
            }
        }
        decisionHandler(.cancel)
        let alert = UIAlertController(title: "Wrong", message: "It's banned", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel))
        present(alert, animated: true)
        
    }
    
}

