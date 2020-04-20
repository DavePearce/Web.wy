package web

import u16 from std::integer
import string from js::core
import w3c::ajax with XMLHttpRequest, newXMLHttpRequest, DONE
import web::app

// ==========================================================
// Aliases
// ==========================================================

public type State<S> is app::State<S,Action<S> >

/**
 * Binds app to I/O Actions
 */
public type App<S> is app::App<S,Action<S> >

// ==========================================================
// Actions
// ==========================================================

/**
 * Type of response handlers for OK
 */
public type ok_handler<S> is function(S, string)->(S,Action<S>[])

/**
 * Type of response handlers for errors
 */
public type err_handler<S> is function(S)->(S,Action<S>[])

/**
 * Provides a standard set of I/O actions.
 */
public type Action<S> is Get<S> | Post<S>

/**
 * Represents an HTTP Get action
 */
public type Get<S> is {
    // Target URL for request
    string url,
    // Handler called on OK
    ok_handler<S> ok,
    // Handler called otherwise
    err_handler<S> error
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
    ok_handler<S> ok,
    // Handler called otherwise
    err_handler<S> error
}

type m_str is method(string)
type m_int is method(int)

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
    else:
        process_request<S>(st,action)

/**
 * Process GET action.
 */
method process_request<S>(&State<S> st, Get<S> action):
    // Bind response handlers
    m_str ok = &(string s -> process_response(s,st,action.ok))
    m_int err = &(int i -> process_response(i,st,action.error))
    // Finally begin GET request
    get(action.url, ok, err)
    
/**
 * Process POST action.
 */
method process_request<S>(&State<S> st, Post<S> action):
    // Bind response handlers
    m_str ok = &(string s -> process_response(s,st,action.ok))
    m_int err = &(int i -> process_response(i,st,action.error))
    // Finally begin POST request
    post(action.url, action.payload, ok, err)

/**
 * Process successful response.
 */
method process_response<S>(string response, &State<S> st, ok_handler<S> fn):
    // Update model
    (S m, Action<S>[] as) = fn(st->app.model,response)
    // Apply model update
    st->app.model = m
    // Process any actions arising
    for i in 0..|as|:
        processor(st, as[i])
    // Done

/**
 * Process problematic response.
 */
method process_response<S>(int code, &State<S> st, err_handler<S> fn):
    // Update model
    (S m, Action<S>[] as) = fn(st->app.model)
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
