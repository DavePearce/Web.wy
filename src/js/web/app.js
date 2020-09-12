/**
 * Initial a dom element with the necessary dictionary for event
 * listeners.  This essentially guarantees that every time we
 * encounter a DOM element created from this library it will have this
 * dictionary available.  The purpose of the dictionary is to record
 * listeners that have been set so that they can be cleared again in
 * the future.
 */
function web$app$initEventListeners(element) {
    element.wy$events = {};
}

/**
 * Set the listener for a given event on a DOM element such that it
 * can be subsequently cleared.  If a listener for that event already
 * exists, then it is removed.  Thus, at most one listener for any
 * event can exist.  
 */
function web$app$setEventListener(element,event,listener) {
    // Extract old listener
    var old = element.wy$events[event];
    // Remove old listener (if applicable)    
    if(old) {
	// Remove listener from DOM element
	element.removeEventListener(event,old);
    }
    // Record new listener for future reference
    element.wy$events[event] = listener;
    // Add new listener to DOM element
    element.addEventListener(event,listener);
}

/**
 * Clear the listener for a given event on a DOM element.  A listener
 * must have been previously added, otherwise this will be stuck.
 */
function web$app$clearEventListener(element,event) {
    // Extract old listener
    var old = element.wy$events[event];
    // Remove old listener (if applicable)
    if(old) {
	// Remove listener from DOM element
	element.removeEventListener(event,old);
	element.wy$events[event] = null;	
    }    
}
