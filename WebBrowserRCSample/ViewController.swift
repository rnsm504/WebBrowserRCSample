//
//  ViewController.swift
//  WebBrowserRCSample
//
//  Created by Masanori Kuze on 2016/05/18.
//  Copyright © 2016年 Masanori Kuze. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class ViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {

    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var myWebView: UIWebView!
    
    var vm : ViewModel = ViewModel()
    
    var cocoaAction : CocoaAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.urlField.delegate = self
        self.myWebView.delegate = self
        
        vm.action!.values.observeNext { value in
            print(value.absoluteString)
            self.myWebView.loadRequest(NSURLRequest(URL: value))
        }
        
        
        let a = self.urlField.rac_signalForControlEvents(.EditingDidEndOnExit)
            .toSignalProducer()
            .flatMapError{
                error in return SignalProducer<AnyObject?, NoError>.empty
            }
            .map { value -> String in
                 self.urlField.text!
        }
        vm.urlText <~ a
        
        cocoaAction = CocoaAction(vm.action, input: self.urlField.text!)
        urlField.addTarget(cocoaAction, action: CocoaAction.selector, forControlEvents: .EditingDidEndOnExit)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        print("finished")
    }

    func webViewDidStartLoad(webView: UIWebView) {
        print("start")
    }
    
}

