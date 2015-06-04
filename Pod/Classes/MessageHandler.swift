import Foundation
import Alamofire

/**
 * <p>Handles delivery of Appygram messages.  Not intended for 
 * public consumption.</p>
 * 
 * @author Carl Scott, <a href="http://solertium.com">Solertium Corporation</a>
 *
 */
class MessageHandler : NSObject {
	
    enum AppygramEndpoint : String {
        case Appygrams = "appygrams"
        case Traces = "traces"
	}
	
    let messenger : AppygramMessenger
    let message : AppygramMessage
	
    var endpoint : AppygramEndpoint
	
    init(messenger : AppygramMessenger, message : AppygramMessage) {
		self.messenger = messenger
		self.message = message
		
		self.endpoint = AppygramEndpoint.Appygrams
	}
	
	func run() {
        let settings : AppygramConfig = messenger.getConfig();
        
        var url = settings.getUrl() + "/" + endpoint.rawValue;
        var json = message.toJSON(settings.getKey(), settings.getTopic())
        
        var session = NSURLSession.sharedSession()
        var err: NSError?
        
        var request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "POST"
        request.HTTPBody = (json as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        Alamofire.request(request)
            .validate()
            .responseString { (_, response, value, error) in
                var event = AppygramEvent(self.message)
                
                if (response!.statusCode >= 200 && response!.statusCode <= 299) {
                    if let uValue = value {
                        event.response = uValue
                    }
                    event.isSuccess = true
                    self.messenger.fireAfterSendEvent(event)
                } else {
                    event.response = "HTTP Error Code \(response!.statusCode)"
                    event.isSuccess = false
                    self.messenger.fireAfterSendEvent(event)
                }
            }
    }

}
