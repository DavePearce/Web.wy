package web

import u16,uint from std::integer
import string from js::core
import w3c::dom
import w3c::ajax with XMLHttpRequest, newXMLHttpRequest, DONE
import web::html
import web::app with State

// ==========================================================
// Application Bundle
// ==========================================================

public type App<S> is {
    // Current application state
    S model,
    // View transformer
    function view(S)->html::Node<S>
}

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
 * Handler for querying dom elements.
 */
public type query<S,T> is method(S)->T

/**
 * Type of methods which consume some value
 */
type meth_t<T> is method(T)

/**
 * Type of methods which consume nothing.
 */
type meth_vt is method()

// ==========================================================
// Action
// ==========================================================

/**
 * An external action is something which occurs entirely outside the
 * appliction model, and may (or may not) feed back into it.  For
 * example, generating an alert message or making an HTTP request are
 * external actions.  Actions can be both synchronouse and
 * asynchronous, with the latter resulting in delayed feedback into
 * the model.
 */
public type Action<S> is {
    // Apply a given action to the current state, producing zero or
    // more follow-on actions.    
    method(&State<S>)->(Action<S>[]) apply
}

/**
 * Process Input / Output actions.  For example, begin any HTTP
 * requests as necessary.
 */
public method processor<S>(&State<S> st, Action<S> action):
    //
    Action<S>[] actions = action.apply(st)
    // Process any actions arising
    for i in 0..|actions|:
        processor(st, actions[i])

// ==========================================================
// Standard Actions
// ==========================================================

/**
 * Represents a call to window->alert(), resulting in an alert
 * message being triggered outside of the application model.
 */
public function alert<S>(string message) -> Action<S>:
    return Action{apply: &(&State<S> st -> st->window->alert(message))}

/**
 * Call a method on the current window without producing any thing to
 * feed the result back into the model.
 */
public function call<S>(method(dom::Window) call) -> Action<S>:
    return Action{apply: &(&State<S> st -> call(st->window))}

/**
 * Represents an asynchronous GET request to a given URL.
 */
public function get<S>(string url, consumer<S,string> ok, handler<S> error) -> Action<S>:
    return Action{apply: &(&State<S> st -> apply_get(st,url,ok,error))}

/**
 * Represents a call to window->setInterval(), resulting in a timeout
 * being registered for the given handler.
 */
public function interval<S>(uint timeout, handler<S> handler) -> Action<S>:
    return Action{apply: &(&State<S> st -> apply_interval(st,timeout,handler))}

/**
 * Represents an asynchronous POST request to a given URL.
 */
public function post<S>(string url, string payload, consumer<S,string> ok, handler<S> error) -> Action<S>:
    return Action{apply: &(&State<S> st -> apply_post(st,url,payload,ok,error))}

/**
 * Represents a call to window->setTimeout(), resulting in a timeout
 * being registered for the given handler.
 */
public function timeout<S>(uint timeout, handler<S> handler) -> Action<S>:
    return Action{apply: &(&State<S> st -> apply_timeout(st,timeout,handler))}

/**
 * Query an external DOM element, and feed the result back into the
 * model.  More specifically, the DOM element is looked up in the
 * current window using the given id, and passed to the query.  This
 * produces some kind of result which is fed back into the model
 * synchronously via a consumer.
 */
public function query<S,T>(string id, query<dom::Element,T> query, consumer<S,T> consumer) -> Action<S>:
    return Action{apply: &(&State<S> st -> apply_query(st,id,query,consumer))}

/**
 * Query the current window, and feed the result back into the model.
 * More specifically, the enclosing Window is passed to the query
 * method.  This produces some kind of result which is fed back into
 * the model synchronously via a consumer.
 */
public function query<S,T>(query<dom::Window,T> query, consumer<S,T> consumer) -> Action<S>:
    return Action{apply: &(&State<S> st -> apply_query(st,query,consumer))}

// ==========================================================
// Helpers
// ==========================================================

/**
 * Action an asynchronous GET request using the low-level AJAX API.
 * Depending on the outcome, one of the two handlers will be called.
 */
method apply_get<S>(&State<S> st, string url, consumer<S,string> ok, handler<S> error) -> Action<S>[]:
     meth_t<string> mok = &(string s -> consume_event(s,st,ok))
     meth_t<int> merr = &(int i -> process_event(st,error))
     // Finally begin GET request
     begin_get(url, mok, merr)
     // Done
     return []

/**
 * Action a call to window->setInterval().
 */
method apply_interval<S>(&State<S> st, uint interval, handler<S> handler) -> Action<S>[]:
    // Construct method handler
    meth_vt m = &( -> process_event(st,handler))
    // Register timeout handler
    st->window->setInterval(m,interval)
    // Done
    return []

/**
 * Action an asynchronous POST request using the low-level AJAX API.
 * Depending on the outcome, one of the two handlers will be called.
 */
method apply_post<S>(&State<S> st, string url, string payload, consumer<S,string> ok, handler<S> error) -> Action<S>[]:
     meth_t<string> mok = &(string s -> consume_event(s,st,ok))
     meth_t<int> merr = &(int i -> process_event(st,error))
     // Finally begin POST request
     begin_post(url, payload, mok, merr)
     // Done
     return []

/**
 * Action a call to window->setTimeout().
 */
method apply_timeout<S>(&State<S> st, uint timeout, handler<S> handler) -> Action<S>[]:
    // Construct method handler
    meth_vt m = &( -> process_event(st,handler))
    // Register timeout handler
    st->window->setTimeout(m,timeout)
    // Done
    return []

/**
 * Action a synchronous query on a given DOM element.  Since this is a
 * synchronous event, no need to refresh display as this is already
 * scheduled once action processing is complete.
 */
method apply_query<S,T>(&State<S> st, string id, query<dom::Element,T> query, consumer<S,T> consumer) -> Action<S>[]:
    // Find element to be queried
    dom::Element e = st->window->document->getElementById(id)
    // Perform query, producing some kind of response
    T response = query(e)
    // Feed response back into model
    (S m, Action<S>[] as) = consumer(st->app.model,response)
    // Apply model update
    st->app.model = m
    // Done.
    return as

/**
 * Action a synchronous query on the current window.  Since this is a
 * synchronous event, no need to refresh display as this is already
 * scheduled once action processing is complete.
 */
method apply_query<S,T>(&State<S> st, query<dom::Window,T> query, consumer<S,T> consumer) -> Action<S>[]:
    // Perform query, producing some kind of response
    T response = query(st->window)
    // Feed response back into model
    (S m, Action<S>[] as) = consumer(st->app.model,response)
    // Apply model update
    st->app.model = m
    // Done.
    return as

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
    // Refresh display
    app::refresh(st)

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
    // Refresh display
    app::refresh(st)

// ==========================================================
// Low-level AJAX API
// ==========================================================
final int HTTP_OK = 200

method begin_get(string url, method(string) success, method(int) error):
    // Construct a new request
    XMLHttpRequest xhttp = newXMLHttpRequest()
    // Configure an async get request
    xhttp->open("GET",url,true)
    // Configure receipt handler
    xhttp->onreadystatechange = &( -> response_handler(xhttp,success,error))
    // Send the request!
    xhttp->send("")

/**
 * Action an asynchronous POST request using the low-level AJAX API.
 * Depending on the outcome, one of the two handlers will be called.
 */
method begin_post(string url, string data, method(string) success, method(int) error):
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

/**
 * Handle response from either a GET or POST query.
 */
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
