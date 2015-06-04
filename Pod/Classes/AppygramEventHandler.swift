/**
 * <p>Handles the AppygramEvent once an Appygram is sent.</p>
 * 
 * @author Carl Scott, <a href="http://solertium.com">Solertium Corporation</a>
 *
 */
public protocol AppygramEventHandler {
	
	/**
	 * Called after an Appygram is sent.
	 * @param event the Appygram event information
	 */
    func afterSend(event: AppygramEvent)

}
