//
//  KAWebViewController.swift
//  KAWebViewController
//
//  Very basic swift version of KAWWebView, currently only works with Xcode 6 beta.
//  Created by Kyle Adams on 04-06-14.
//  Copyright (c) 2014 Kyle Adams. All rights reserved.
//

import UIKit

class KAWebViewController: UIViewController, UIWebViewDelegate {
    
    let webView = UIWebView()
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh,target: nil, action: "reloadPage")
    let backButton = UIBarButtonItem(image: UIImage(named: "KAWBack"), style: .Plain, target: nil, action: "goBack")
    let forwardButton = UIBarButtonItem(image: UIImage(named: "KAWForward"), style: .Plain, target: nil, action: "goForward")
    let actionButton = UIBarButtonItem(barButtonSystemItem: .Action, target: nil, action: "showActionMenu")
    let stopButton = UIBarButtonItem(barButtonSystemItem: .Stop, target: nil, action: "stopLoading")
    let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    
    var url: NSURL? {
    didSet {
        loadWebView()
    }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadToolBarItems()
        navigationController.toolbarHidden = false
        webView.delegate = self
        webView.scalesPageToFit = true
        view = webView
        
        updateUI()
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController.toolbarHidden = navigationController.toolbarHidden ? false : true
    }
    
    func updateUI() {
        setToolBarItemsForState(webView.loading)
        
        backButton.enabled = webView.canGoBack ? true : false
        forwardButton.enabled = webView.canGoForward ? true : false
        
        if navigationController.toolbarHidden {
            navigationController.toolbarHidden = false
        }
    }
    
    func setToolBarItemsForState(loading: Bool) {
        
        if loading {
            //set toolbar items when loading
            println("WebView loading!")
            toolbarItems = [backButton, space, forwardButton, space, stopButton, space, actionButton]
        } else {
            //set toolbar items when not loading
            println("WebView is not loading")
            toolbarItems = [backButton, space, forwardButton, space, refreshButton, space, actionButton]
        }
    }
    
    func loadToolBarItems() {
        refreshButton.target = self
        backButton.target = self
        forwardButton.target = self
        actionButton.target = self
        stopButton.target = self
    }
    
    func loadWebView() {
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    func reloadPage() {
        webView.reload()
    }
    
    func stopLoading() {
        webView.stopLoading()
        updateUI()
    }
    
    func showActionMenu() {
        let avc = UIActivityViewController(activityItems: [webView.request.URL], applicationActivities: nil)
        self.presentViewController(avc, animated: false, completion: nil)
    }
    
    func webViewDidStartLoad(_: UIWebView!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        updateUI()
    }
    
    func webViewDidFinishLoad(_:UIWebView!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        updateUI()
    }
    
    func webView(_: UIWebView!, didFailLoadWithError error: NSError!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        updateUI()
    }
}
