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
//    @IBOutlet weak var myBrowser: UIWebView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myWebView: UIWebView!
    
    var vm : ViewModel = ViewModel()
    private var resultUrl : NSURL!
    private var returnKey : Bool = false
    
    private var url : NSURL!
    private var result : MutableProperty<String> = MutableProperty("")
    
    lazy var dynamicProperty: DynamicProperty! = DynamicProperty(object: self.myLabel, keyPath: "text")
    
    
    var cocoaAction : CocoaAction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
//        myBrowser.delegate = self
        
        self.urlField.delegate = self
        self.myWebView.delegate = self
        
//        let a  = urlField.rac_textSignal()
//            .toSignalProducer()
//            .flatMapError{
//                error in return SignalProducer<AnyObject?, NoError>.empty
//            }
//            .filter({ value -> Bool in
//                return self.returnKey
//            })
//            .map {
//                text in
//                text as! String
//            }
//        vm.urlText <~ a
        

//        a.startWithNext { (results) in
//            print("text is \(results)")
//        }

//        vm.action2.values.observeNext { value in
//            print("next")
//            self.myLabel.text = "aaa"
//        }
        
//        vm.action2.events.observeNext { _ in
//            print("aaa")
//        }
        
        vm.action2.values.observeNext { value in
            print("aaaa")
            self.myLabel.text = "sasa"
            
            self.myWebView.loadRequest(NSURLRequest(URL: value))
        }

        
        cocoaAction = CocoaAction(vm.action2, input: self.urlField.text!)
//        cocoaAction = CocoaAction(vm.action2, input: "")
        
//        urlField.addTarget(vm.action2.unsafeCocoaAction, action: CocoaAction.selector, forControlEvents: .EditingDidEndOnExit)
  
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
//        textField.resignFirstResponder()
        returnKey = true
        return true
    }
}

