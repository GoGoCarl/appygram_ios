/**
 * <p>Main class used for configuring and accessing AppygramMessengers.</p>
 * 
 * <p>Usage:</p>
 * 
 * <p>1a) Call Appygram.configure, passing at least an API Key to configure the 
 * Global AppygramMessenger.  This can be called statically via 
 * Appygram.Global.  You can set other optional properties as desired.  
 * This must be called first before sending any Appygrams.</p>
 * 
 * <p>1b) Call Appygram.instance, passing at least an API Key to configure an 
 * instance of AppygramMessenger.  This is useful when using multiple API 
 * Keys in the same application, or in application contexts where static 
 * objects are not ideal.  You only need to call this method once, and use 
 * the returned AppygramMessenger object from there.<p>
 * 
 * <p>2) Grab your AppygramMessenger object from either Appyggram.instance or 
 * Appygram.Global.</p>
 * 
 * <p>3) Call AppygramMessenger.create to generate an AppygramMessage object.</p>
 * 
 * <p>4) Set properties such as name, email, message, summary and more on your 
 * AppygramMessage.  You must supply the message property at a minimum.</p>
 * 
 * <p>5) Call AppygramMessenger.send, passing your message.</p>
 * 
 * @author Carl Scott, <a href="http://solertium.com">Solertium Corporation</a>
 *
 */
public class Appygram : NSObject {
	
	/**
	 * The Global AppygramMessenger, set up using the 
	 * Appygram.configure method.  This can be called 
	 * statically for convenience.
	 */
    static var _Global : AppygramMessenger? = nil;
	
	/**
	 * Configure the Global AppygramMessenger. Returns 
	 * the messenger created, which can be retrieved again 
	 * via Appygram.Global 
	 * 
	 * @param config
	 * @return
	 */
    public static func configure(config:AppygramConfig) -> AppygramMessenger {
		_Global = instance(config);
		//AppygramLogger.configure(config);
		
		return _Global!
	}
    
    public static func Global() -> AppygramMessenger {
        return _Global!
    }
	
	/**
	 * Create a single, re-usable instance of AppygramMessenger. 
	 * This should be used if you anticipate needing multiple 
	 * instances of AppygramMessenger (typically when dealing with 
	 * application contexts not suited for static reference, or 
	 * with multiple API Key).  If you do not have either of these 
	 * cases, you should use Appygram.configure, then Appygram.Global
	 * @param config
	 * @return
	 */
    public static func instance(config:AppygramConfig) -> AppygramMessenger {
        return AppygramMessenger(config: config);
	}

}
