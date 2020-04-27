package web

import string from js::core
import w3c::dom
import web::html with MouseEvent, handler

public type App<S,A> is {
    // Current application state
    S model,
    // View transformer
    function view(S)->html::Node<S,A>,
    // Action processor
    method process(&State<S,A>,A)
}

public type State<S,A> is {
    // Registered Application
    App<S,A> app,
    // DOM node app attached to
    dom::Node root,
    // Current DOM tree (if any)
    null|dom::Node tree,
    // DOM access (needed for creationg)
    dom::Document document
}

/**
 * Event loop for an app.
 */
public export method run<S,A>(App<S,A> app, dom::Node root, dom::Document doc):
    // Construct state object
    &State<S,A> state = new State{app:app,root:root,tree:null,document:doc}
    // Construct Initial Display
    refresh(state)

/**
 * Refresh the current display.
 */
method refresh<S,A>(&State<S,A> st):
    dom::Node|null old = st->tree
    // Transform model into (functional) HTML
    html::Node<S,A> init = st->app.view(st->app.model)    
    // Reinitialise DOM tree
    dom::Node tree = to_dom(init,st)
    // Add or update tree
    if old is null:
        st->root->appendChild(tree)
    else:
        st->root->replaceChild(tree,old)
    // Assign tree
    st->tree = tree

/**
 * Convert an HTML model into concrete DOM nodes using a given
 * Document to construct new items, and processor for actions arising.
 */ 
method to_dom<S,A>(html::Node<S,A> node, &State<S,A> st) -> (dom::Node r):
    if node is string:
        // Construct a text node
        return st->document->createTextNode(node)
    else:
        dom::Element element = st->document->createElement(node.name)
        // Recursively construct children
        for i in 0..|node.children|:
            // Construct child element
            dom::Node child = to_dom<S,A>(node.children[i],st)
            // Append to this element
            element->appendChild(child)
        // Recursively configure attributes
        for j in 0..|node.attributes|:
            html::Attribute<S,A> attr = node.attributes[j]
            // Dispatch on attribute type
            if attr is html::TextAttribute:
                element->setAttribute(attr.key,attr.value)                
            else if attr is html::MouseEventAttribute<S,A>:
                // Extract registered mouse handler
                html::handler<html::MouseEvent,S,A> handler = attr.handler
                // Add mouse event listener
                element->addEventListener(attr.mouseEvent,&(dom::MouseEvent e -> process_mouse_event(e,handler,st)))
            else if attr is html::KeyboardEventAttribute<S,A>:
                // Extract registered keyboard handler            
                html::handler<html::KeyboardEvent,S,A> handler = attr.handler
                // Add key event listener                
                element->addEventListener(attr.keyEvent,&(dom::KeyboardEvent e -> process_keyboard_event(e,handler,st)))
            else:
                // Extract registered event handler            
                html::handler<html::Event,S,A> handler = attr.handler
                // Add event listener
                element->addEventListener(attr.event,&(dom::Event e -> process_other_event(e,handler,st)))
            // Done
        return element

/**
 * Simple wrapper for processing mouse events which converts between
 * dom and html event.s
 */
method process_mouse_event<S,A>(dom::MouseEvent e, html::handler<html::MouseEvent,S,A> h, &State<S,A> st):
    process_event(html::to_mouse_event(e),h,st)

/**
 * Simple wrapper for processing keyboard events which converts between
 * dom and html event.s
 */
method process_keyboard_event<S,A>(dom::KeyboardEvent e, html::handler<html::KeyboardEvent,S,A> h, &State<S,A> st):
    process_event(html::to_key_event(e),h,st)

/**
 * Simple wrapper for processing other events which converts between
 * dom and html event.s
 */
method process_other_event<S,A>(dom::Event e, html::handler<html::Event,S,A> h, &State<S,A> st):
    process_event(html::to_event(e),h,st)

/**
 * Process an incoming event using a registered event handler on a
 * given application state.
 */
method process_event<E,S,A>(E e, html::handler<E,S,A> h, &State<S,A> st):
    // Apply event handler to produce action
    (S model, A[] actions) = h(e,st->app.model)
    // Update application model
    st->app.model = model    
    // Process pending actions
    for i in 0..|actions|:
        st->app.process(st,actions[i])
    // Refresh display
    refresh(st)