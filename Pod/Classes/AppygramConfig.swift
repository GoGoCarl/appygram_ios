import Foundation

/**
 * <p>Set initial properties for sending appygrams.  You must provide your 
 * API Key.  Other properties that you can set are:</p>
 * 
 * <ul>
 * <li>Topic: Provide a default topic for Appygram Messages without one. The 
 * default is null, which sends to all your topics.</li>
 * <li>URL: Set the endpoint for your Appygrams.  This is already defaulted 
 * to the currently supported Appygram endpoint, which may be updated in the 
 * future.</li>
 * <li>Platform and Software: Provide details on your specific implementation 
 * to go along with each Appygram sent by the calling code.</li>
 * </ul>
 * 
 * <p>Additionally, you can set run configuration options:</p>
 * 
 * <ul>
 * <li>Log to Console: Print errors about Appygram configuration or sending 
 * Appygrams to the console, in addition to the AppygramLogger log.  Defaults 
 * to false.</li>
 * <li>Allow Threads: Threading can be turned off by setting allowThreads to 
 * false. By default, it's on, meaning that Appygrams will be sent in the 
 * background.</li>
 * </ul>
 * 
 * <p>This information can be set via Properties files using the following keys:</p>
 * 
 * <ul>
 * <li>com.appygram.java.key -- the API key (required)</li>
 * <li>com.appygram.java.topic -- the default topic</li>
 * <li>com.appygram.java.url -- the hostname of the Appygram endpoint</li>
 * <li>com.appygram.java.platform -- your application platform</li>
 * <li>com.appygram.java.software -- your application software</li>
 * <li>com.appygram.java.console -- true to log to console</li>
 * <li>com.appygram.java.thread -- true to allow threads</li>
 * </ul>
 * 
 * @author Carl Scott, <a href="http://solertium.com">Solertium Corporation</a>
 *
 */
public class AppygramConfig : NSObject {
	
    let APPYGRAM_DEFAULT_URL : String = "http://arecibo.appygram.com";
	
	/*
	 * Leaving this null tells Appygram to send to all topics
	 */
    let APPYGRAM_DEFAULT_TOPIC : String? = nil;

    var url : String
    public var key, topic, platform, software: String?
	
    public init(api_key key : String, url : String? = nil) {
		self.key = key
        if let uUrl = url {
            self.url = uUrl
        } else {
            self.url = self.APPYGRAM_DEFAULT_URL
        }
	}
	
    public init(config properties: Dictionary<String, String>) {
		let base = "com.appygram.java."
		
		self.key = properties[(base + "key")]
        if let uUrl = properties[base + "url"] {
            self.url = uUrl
        } else {
            self.url = APPYGRAM_DEFAULT_URL
        }
        
        if let uTopic = properties[base + "topic"] {
            self.topic = uTopic
        } else {
            self.topic = APPYGRAM_DEFAULT_TOPIC
        }
        
		self.platform = properties[(base + "platform")]
		self.software = properties[(base + "software")]
	}
	
	public func isConfigured() -> Bool {
		return !(isUnset(url) || isUnset(key))
	}

	public func getUrl() -> String {
		return url
	}

	public func getKey() -> String {
		return key!
	}

    public func setToken(key: String) {
		self.key = key
	}

	public func getTopic() -> String? {
		return topic
	}
	
	public func getPlatform() -> String? {
		return platform
	}
	
	public func getSoftware() -> String? {
		return software
	}
	
    private func isUnset(value: String?) -> Bool {
        if value == nil {
            return true
        } else {
            return value!.isEmpty
        }
	}

}
