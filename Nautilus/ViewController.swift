//
//  ViewController.swift
//  Nautilus
//
//  Created by Matt Smollinger on 1/17/15.
//  Copyright (c) 2015 Matt Smollinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSNetServiceBrowserDelegate, NSNetServiceDelegate {

    var serviceBrowser: NSNetServiceBrowser?
    var netService: NSNetService?
    let octoPrintServiceType = "_octoprint._tcp."

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.serviceBrowser = NSNetServiceBrowser();
        self.serviceBrowser?.delegate = self;
        self.serviceBrowser?.searchForServicesOfType(self.octoPrintServiceType, inDomain: "local.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - NSNetServiceBrowser Delegate
// FIXME: Abstract this before shipping
    func netServiceBrowserWillSearch(aNetServiceBrowser: NSNetServiceBrowser) {
        println("Beginning Search")
    }

    func netServiceBrowserDidStopSearch(aNetServiceBrowser: NSNetServiceBrowser) {
        println("Did stop search");
    }

    func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didNotSearch errorDict: [NSObject : AnyObject]) {
        println("Did Not Search with error \(errorDict)");
    }

    func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        println("Found domain \(domainString)")
    }

    func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didFindService aNetService: NSNetService, moreComing: Bool) {
        println("Found service \(aNetService)")
        if (aNetService.type == self.octoPrintServiceType){
            self.netService = aNetService;
            aNetService.delegate = self;
            aNetService.resolveWithTimeout(5.0)
        }
    }

    func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didRemoveDomain domainString: String, moreComing: Bool) {
        println("Removed domain \(domainString)")
    }

    func netServiceBrowser(aNetServiceBrowser: NSNetServiceBrowser, didRemoveService aNetService: NSNetService, moreComing: Bool) {
        println("Removed service \(aNetService)")
    }

// MARK: - NSNetService Delegate
// FIXME: Abstract this before shipping
    func netService(sender: NSNetService, didNotResolve errorDict: [NSObject : AnyObject]) {
        println("Service \(sender) did not resolve with error \(errorDict)")
    }

    func netServiceDidResolveAddress(sender: NSNetService) {
        println("Resolved net service \(sender)")
    }
}

