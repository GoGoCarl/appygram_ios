import Foundation
import ObjectMapper

/**
 * <p>Represents an Appygram message.  The message parameter is required, 
 * the rest are optional.  If you need more fields, you can supply them 
 * via the app_json HashMap.</p>
 * 
 * <p>All data is serialized to JSON when sending to Appygram.</p>
 * 
 * <p>This class can be extended for ease of development.</p>
 * 
 * @author Carl Scott, <a href="http://solertium.com">Solertium Corporation</a>
 *
 */
public class AppygramMessage : NSObject, Mappable {
	
	public var name, email, phone, topic, message, platform, software, summary, api_key: String?
    public var app_json : String?
    
    public required init?(_ map : Map) {
        super.init()
        mapping(map)
    }
    
    public override init() {
        super.init()
    }
    
    public func mapping(map: Map) {
        name      <- map["name"]
        email     <- map["email"]
        phone     <- map["phone"]
        topic     <- map["topic"]
        message   <- map["message"]
        platform  <- map["platform"]
        software  <- map["software"]
        summary   <- map["summary"]
        api_key   <- map["api_key"]
        app_json  <- map["app_json"]
    }
	
	public func getName() -> String? {
		return name
	}

	public func getEmail() -> String? {
		return email
	}

	public func getPhone() -> String? {
		return phone
    }

	public func getTopic() -> String? {
		return topic
	}

	public func getMessage() -> String? {
		return message
	}

	public func getPlatform() -> String? {
		return platform
	}

	public func getSoftware() -> String? {
		return software
	}

	public func getSummary() -> String? {
		return summary
	}

    public func getAppJSON() -> Dictionary<String, AnyObject>? {
        if let uJSON = app_json {
            return JSONParseDictionary(uJSON)
        } else {
            return Dictionary<String, AnyObject>()
        }
	}

    public func setAppJSON(appJson : Dictionary<String, AnyObject>) {
        self.app_json = JSONStringify(appJson)
	}
	
	public func isValid() -> Bool {
        return message != nil && !(message!).isEmpty
    }

    public func toJSON(token : String, _ topic : String?) -> String {
		self.api_key = token
        if let uTopic = topic {
            if self.topic == nil || self.topic!.isEmpty {
                self.topic = uTopic
            }
        }
		
        return Mapper().toJSONString(self, prettyPrint: true)!
	}
	
    public override var description : String {
        return toJSON("[unset]", self.topic)
	}
	
    func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    func JSONParseDictionary(jsonString: String) -> [String: AnyObject] {
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            if let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: nil)  as? [String: AnyObject] {
                return dictionary
            }
        }
        return [String: AnyObject]()
    }

	/**
	 * Simple convenience method for printing exceptions.
	 * @param e the exception
	 * @param lineBreakRule use \n for plain text, <br/> for html
	 * @return
	 */
    /*static func toString(e:NSException, lineBreakRule:String) -> String {
		TODO, if exceptions become a standard thing
	}*/
	
}