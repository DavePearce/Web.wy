package web

import u16,uint from std::integer
import string from js::core
import w3c::dom
import w3c::ajax with XMLHttpRequest, newXMLHttpRequest, DONE
import web::html
import web::app

// ==========================================================
// Aliases
// ==========================================================

public type State<S> is app::State<S,Action<S> >

/**
 * Binds app to I/O Actions
 */
public type App<S> is app::App<S,Action<S> >

/**
 * Binds a dom Node to I/O Actions
 */
public type Node<S> is html::Node<S,Action<S> >

/**
 * Binds a dom Node to I/O Elements
 */
public type Element<S> is html::Element<S,Action<S> >

// ==========================================================
// Event Handlers
// ==========================================================

/**
 * Default event handler which converts one state into another along
 * with zero or more follow-on actions.
 */
public type handler<S> is function(S)->(S,Action<S>[])

/**
 * Handler which consumes some input value along with a given state,
 * producing an updated state along with zero or more follow-on
 * actions.
 */
public type consumer<S,T> is function(S, T)->(S,Action<S>[])

/**
 * Type of methods which consume come value
 */
type meth_t<T> is method(T)

/**
 * Type of methods which consume nothing.
 */
type meth_vt is method()

// ==========================================================
// HTPP Actions
// ==========================================================

/**
 * Provides a standard set of I/O actions.
 */
public type Action<S> is Get<S> |
    Post<S> |
    Alert |
    Timeout<S> |
    Interval<S>

/**
 * Represents an HTTP Get action
 */
public type Get<S> is {
    // Target URL for request
    string url,
    // Handler called on OK
    consumer<S,string> ok,
    // Handler called otherwise
    handler<S> error
}
 
/**
 * Represents an HTTP Post action
 */
public type Post<S> is {
    // Target URL for request
    string url,
    // Payload to be sent
    string payload,
    // Handler called on OK
    consumer<S,string> ok,
    // Handler called otherwise
    handler<S> error
}

/**
 * Process GET action.
 */
method process_request<S>(&State<S> st, Get<S> action):
    // Bind response handlers
    meth_t<string> ok = &(string s -> consume_event(s,st,action.ok))
    meth_t<int> err = &(int i -> process_event(st,action.error))
    // Finally begin GET request
    get(action.url, ok, err)
    
/**
 * Process POST action.
 */
method process_request<S>(&State<S> st, Post<S> action):
    // Bind response handlers
    meth_t<string> ok = &(string s -> consume_event(s,st,action.ok))
    meth_t<int> err = &(int i -> process_event(st,action.error))
    // Finally begin POST request
    post(action.url, action.payload, ok, err)

// ==========================================================
// Timer Actions
// ==========================================================

/**
 * Represents a call to setTimeout()
 */
public type Timeout<S> is {
    // Timeout in ms
    uint timeout,
    // Handler to be called on timeout
    handler<S> handler
}

/**
 * Represents a call to setTimeout()
 */
public type Interval<S> is {
    // Timeout in ms
    uint interval,
    // Handler to be called on timeout
    handler<S> handler
}

/**
 * Construct a timeout action.
 */
public function timeout<S>(uint timeout, handler<S> handler) -> Timeout<S>:
    return {timeout: timeout, handler: handler}

/**
 * Construct an interval action.
 */
public function interval<S>(uint interval, handler<S> handler) -> Interval<S>:
    return {interval: interval, handler: handler}

/**
 * Process alert action.
 */
method process_timeout<S>(&State<S> st, Timeout<S> action):
    meth_vt m = &( -> process_event(st,action.handler))
    dom::setTimeout(m,action.timeout)    

/**
 * Process interval action.
 */
method process_interval<S>(&State<S> st, Interval<S> action):
    meth_vt m = &( -> process_event(st,action.handler))
    dom::setInterval(m,action.interval)    

// ==========================================================
// Other Actions
// ==========================================================

/**
 * Represents a call to alert()
 */
public type Alert is {
    // Alert message
    string message
}

/**
 * Construct an alert message action.
 */
public function alert(string message) -> Alert:
    return {message: message}

/**
 * Process Alert action.
 */
method process_alert<S>(&State<S> st, Alert action):
    dom::alert(action.message)

// ==========================================================
// Action Processor
// ==========================================================

/**
 * Process Input / Output actions.  For example, begin any HTTP
 * requests as necessary.
 */
public method processor<S>(&State<S> st, Action<S> action):
    //
    if action is Get<S>:
        process_request<S>(st,action)
    else if action is Post<S>:
        process_request<S>(st,action)
    else if action is Alert:
        process_alert<S>(st,action)    
    else if action is Timeout<S>:
        process_timeout<S>(st,action)
    else:
        process_interval<S>(st,action)

/**
 * Process a generic event.  This applies the given handler to the
 * current state, producing an updated state and some actions.  The
 * actions are then processed immediately.
 */
method process_event<S>(&State<S> st, handler<S> fn):
    // Update model
    (S m, Action<S>[] as) = fn(st->app.model)
    // Apply model update
    st->app.model = m
    // Process any actions arising
    for i in 0..|as|:
        processor(st, as[i])
    // Done

/**
 * Process a given event which consumes some data.  This applies the
 * given handler to the current state and the data in question,
 * producing an updated state and some actions.  The actions are then
 * processed immediately.
 */
method consume_event<S,T>(T response, &State<S> st, consumer<S,T> fn):
    // Update model
    (S m, Action<S>[] as) = fn(st->app.model,response)
    // Apply model update
    st->app.model = m
    // Process any actions arising
    for i in 0..|as|:
        processor(st, as[i])
    // Done

// ==========================================================
// Low-level AJAX API
// ==========================================================
final int HTTP_OK = 200

method get(string url, method(string) success, method(int) error):
    // Construct a new request
    XMLHttpRequest xhttp = newXMLHttpRequest()
    // Configure an async get request
    xhttp->open("GET",url,true)
    // Configure receipt handler
    xhttp->onreadystatechange = &( -> response_handler(xhttp,success,error))
    // Send the request!
    xhttp->send("")

method post(string url, string data, method(string) success, method(int) error):
    // Construct a new request
    XMLHttpRequest xhttp = newXMLHttpRequest()
    // Configure an async get request
    xhttp->open("POST",url,true)
    // Set content type as JSON
    xhttp->setRequestHeader("Content-Type", "application/json;charset=UTF-8")
    // Configure receipt handler
    xhttp->onreadystatechange = &( -> response_handler(xhttp,success,error))
    // Send the request!
    xhttp->send(data)

method response_handler(XMLHttpRequest xhttp, method(string) success, method(int) error):
    if xhttp->readyState == DONE:
        // Extract status code
        u16 status = xhttp->status
        // Check whether success or failure
        if status == HTTP_OK:
            // success
            success(xhttp->responseText)
        else:
            // Failure
            error(status)
