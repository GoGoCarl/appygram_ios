import ObjectMapper

/**
 * <p>Represents a topic set up on Appygram.com.  The ID 
 * and display name are available to the caller.</p>
 * 
 * @author Carl Scott, <a href="http://solertium.com">Solertium Corporation</a>
 *
 */
public class AppygramTopic : NSObject, Mappable {
	
    var id, name: String?
    
    public required init?(_ map: Map) {
        super.init()
        mapping(map)
    }
	
    public init(id: String, name: String) {
		self.id = id as String
		self.name = name as String
	}
	
	public func getId() -> String {
		return id!
	}
	
	public func getName() -> String {
		return name!
	}
	
    public func mapping(map: Map) {
        self.id    <- map["id"]
        self.name  <- map["name"]
    }
    
    public override var description : String {
        return "Topic #\(self.id!): \(self.name!)"
    }

}
