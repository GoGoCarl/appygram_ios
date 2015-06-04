import Foundation
import Alamofire
import AlamofireObjectMapper

/**
 * <p>Handles delivery of messages and traces, as well as grabs the 
 * topic list.  Is bound to a particular Appygram configuration and 
 * API Key.  Multiples of these can exist in a single application.</p>
 * 
 * @author Carl Scott, <a href="http://solertium.com">Solertium Corporation</a>
 *
 */
public class AppygramMessenger : NSObject {
	
    var afterSend : Array<AppygramEventHandler>
    let config : AppygramConfig
	
    public init(config:AppygramConfig) {
		self.afterSend = Array<AppygramEventHandler>()
		self.config = config
	}
	
	/**
	 * Creates a new AppygramMessage based on your configuration 
	 * settings, setting defaults for fields such as topic, 
	 * platform, and software.  These can then be set manually.
	 * @return
	 */
	public func create() -> AppygramMessage {
        var message : AppygramMessage = AppygramMessage();
        message.topic = config.getTopic()
        message.platform = config.getPlatform()
        message.software = config.getSoftware()
		
		return message;
	}

	/**
	 * Creates a new AppygramTrace based on your configuration 
	 * settings, setting defaults for fields such as topic, 
	 * platform, and software.  These can then be set manually. 
	 * Generates trace information from the supplied exception.
	 * 
     * TODO: support this
     *
     * @return
	 */
    /*public func createTrace(error t : NSError? = nil) -> AppygramTrace {
        var message = AppygramTrace()
        message.topic = config.getTopic()
        message.platform = config.getPlatform()
        message.software = config.getSoftware()
        message.setError(t);
		
		return message;
	}*/
	
	/**
	 * Adds a listener that fires when an Appygram is sent.
	 * @param handler
	 */
    public func addAfterSendHandler(handler : AppygramEventHandler) {
        afterSend.append(handler);
	}
	
	/**
	 * Send an Appygram message.
	 * @param message
	 */
    public func send(message : AppygramMessage) {
        if (!isReady()) {
			return;
        }
		
		if (message.isValid()) {
            let handler = MessageHandler(messenger: self, message: message);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,  0)) {
                handler.run()
            }
		}
	}
	
	/**
	 * Load the list of supported topics for your App from 
	 * Appygram.com
	 * @return
	 */
    public func topics(result : (topics : Array<AppygramTopic>) -> ()) {
        var topics : Array<AppygramTopic> = Array<AppygramTopic>()
		
        if !isReady() {
            result(topics: topics)
        } else {
            let url = config.getUrl() + "/topics/" + config.getKey()
            Alamofire.request(.GET, url, parameters: nil, encoding: .JSON)
                .responseArray { (response: [AppygramTopic]?, error: NSError?) in
                    if let uTopics = response {
                        result(topics: uTopics)
                    } else {
                        result(topics: topics)
                    }
                }
        }
	}
	
	/**
	 * A convenience method for specifically handling 
	 * anonymous exceptions.  Generates a summary based 
	 * on the exception message, and message contents 
	 * containing the stack trace with lines delimited 
	 * by HTML br tags.  If you want a different config 
	 * for your message, pass in an AppygramTrace object 
	 * instead.
	 * @param e
     * 
     * TODO: support
	 */
    /*
    public func traceError(e : NSError) {
        var mTrace : AppygramTrace = createTrace(error: e);
		mTrace.summary = (e.localizedDescription);
		mTrace.message = "TODO: message" //(AppygramMessage.toString(e, "<br/>"));
		
		trace(mTrace)
	}*/
	
	/**
	 * Send an Appygram exception trace.  The AppygramTrace 
	 * must have a trace attached, but a message is not 
	 * required.
	 * @param message
	 */
    /*public func trace(message : AppygramTrace) {
        if (!isReady()) {
			return;
        }
		
		if (message.isValid()) {
            var handler = MessageHandler(messenger: self, message: message)
			handler.endpoint = .Traces
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,  0)) {
                handler.run()
            }
		}
	}*/
	
	public func isReady() -> Bool {
		if (!config.isConfigured()) {
			NSLog(" (!) Appygram not configured");
			return false;
		}
		
		return true;
	}
	
	public func getConfig() -> AppygramConfig {
		return config;
	}
	
    func fireAfterSendEvent(event : AppygramEvent) {
        for handler : AppygramEventHandler in afterSend {
			handler.afterSend(event);
        }
	}

}
