package web

import std::math
import string from js::core
import w3c::dom
import web::html with MouseEvent, handler
import web::io
import web::diff

/** 
 * Represents the DOM rendering of a specific html tree.  That is,
 * the DOM tree generated from the view of a specific model state.
 */
public type Rendering<S> is {
    // Model state
    html::Node<S> model,
    // Rendered view
    dom::Node view
}

/**
 * Internal state of the application.  This includes all necessary
 * information to update the current rendering in response to I/O
 * events.
 */
public type State<S> is {
    // Registered Application
    io::App<S> app,
    // DOM node app attached to
    dom::Node root,
    // Current rendering (if any)
    null|Rendering<S> rendering,
    // DOM access (needed for creating, etc)
    dom::Window window
}

/**
 * Event loop for an app.
 */
public export method run<S>(io::App<S> app, dom::Node root, dom::Window win):
    // Construct state object
    &State<S> state = new State{app:app,root:root,rendering:null,window:win}
    // Construct Initial Display
    refresh(state)

/**
 * Refresh the current display.
 */
public method refresh<S>(&State<S> st):
    // Extract current rendering (if any)
    null|Rendering<S> current = st->rendering
    // Transform model into (functional) HTML
    html::Node<S> m = st->app.view(st->app.model)
    // Representings new rendering
    dom::Node t
    // Create or Update?
    if current is null:
        // Create fresh DOM tree
        t = to_dom(m,st)
        // Add tree
        st->root->appendChild(t)
    else:
        // Determine difference between model states
        diff::NodeOperation<S> update = diff::create(current.model,m)
        // Update existing DOM tree
        t = update_dom(current.view,update,st)
        // Replace old DOM tree (if necessary)
        replace_child(st->root,current.view,t)
    // Save rendering
    st->rendering = {model: m, view: t}

/**
 * Convert an HTML model into concrete DOM nodes using a given
 * Document to construct new items, and processor for actions arising.
 */ 
method to_dom<S>(html::Node<S> node, &State<S> st) -> (dom::Node r):
    if node is string:
        // Construct a text node
        return st->window->document->createTextNode(node)
    else:
        dom::Element element = st->window->document->createElement(node.name)
        // Initialise listener storage
        initEventListeners(element)
        // Recursively construct children
        for i in 0..|node.children|:
            // Construct child element
            dom::Node child = to_dom<S>(node.children[i],st)
            // Append to this element
            element->appendChild(child)
        // Recursively configure attributes
        for j in 0..|node.attributes|:
            html::Attribute<S> attr = node.attributes[j]
            // Dispatch on attribute type
            set_attribute(element,attr,st)
            // Done
        return element

/**
 * update an existing DOM tree to reflect a new model.
 */
method update_dom<S>(dom::Node tree, diff::NodeOperation<S> op, &State<S> st) -> (dom::Node r):
    if op is null:
        return tree
    else if op is diff::Replace<S>:
        // Replace entire subtree
        return to_dom(op.node,st)
    else if tree->hasChildNodes():
        // Update existing children
        update_children(tree,op.children,st)
    // Append / Remove children                
    resize_children(tree,op.children,st)
    // Apply / Undo attributes
    update_attributes<S>(tree,op.attributes,st)
    // Done
    return tree

method update_children<S>(dom::Node tree, diff::NodeOperation<S>[] operations, &State<S> st):
    dom::Node[] children = tree->childNodes
    int size = math::min(|children|,|operations|)
    // Update children
    for i in 0..size:
        dom::Node ithChild = children[i]
        diff::NodeOperation<S> ithOp = operations[i]
        if !(ithOp is null):
            // Recursively update child
            dom::Node t = update_dom(ithChild,ithOp,st)
            // Replace existing child with updated child
            replace_child(tree,ithChild,t)

method resize_children<S>(dom::Node tree, diff::NodeOperation<S>[] operations, &State<S> st):
    int size
    // Determine current size
    if tree->hasChildNodes():
        size = |tree->childNodes|
    else:
        size = 0
    // Determine direction of movement
    if size <= |operations|:
        // Appending children
        for i in size..|operations|:
            diff::NodeOperation<S> ith = operations[i]
            // Only action replacements
            if ith is diff::Replace<S>:
                // Construct child from scratch
                dom::Node t = to_dom(ith.node,st)
                // Append child
                tree->appendChild(t)
        // Done
    else:
        // Removing children
        while size > |operations|:
            tree->removeChild(tree->lastChild)
            size = size - 1
        // Done

method replace_child(dom::Node tree, dom::Node oldChild, dom::Node newChild):
    if oldChild != newChild:
        tree->replaceChild(newChild,oldChild)

method update_attributes<S>(dom::Node tree, diff::AttributeOperation<S>[] operations, &State<S> st):
    if tree->nodeType == dom::ELEMENT_NODE:
        // Enforce that tree is Element
        assert tree is dom::Element
        // Undo everything
        for i in 0..|operations|:
            diff::AttributeOperation<S> ith = operations[i]
            if ith is null || ith.before is null:
                skip
            else:
                clear_attribute(tree,ith.before,st)
        // Apply everything
        for i in 0..|operations|:
            diff::AttributeOperation<S> ith = operations[i]
            if ith is null || ith.after is null:
                skip
            else:
                set_attribute(tree,ith.after,st)
    // Done

/**
 * Set a given attribute on a specific element.  Exactly how this is
 * done depends on the attribute in question.
 */
method set_attribute<S>(dom::Element element, html::Attribute<S> attr, &State<S> st):
    // Dispatch on attribute type
    if attr is html::TextAttribute:
        element->setAttribute(attr.key,attr.value)                
    else if attr is html::MouseEventAttribute<S>:
        // Extract registered mouse handler
        html::handler<html::MouseEvent,S> handler = attr.handler
        // Construct key event listener        
        dom::EventListener listener = &(dom::MouseEvent e -> process_mouse_event(e,handler,st))
        // Add mouse event listener
        setEventListener(element,attr.mouseEvent,listener)
    else if attr is html::KeyboardEventAttribute<S>:
        // Extract registered keyboard handler            
        html::handler<html::KeyboardEvent,S> handler = attr.handler
        // Construct key event listener        
        dom::EventListener listener = &(dom::KeyboardEvent e -> process_keyboard_event(e,handler,st))
        // Add key event listener                
        setEventListener(element,attr.keyEvent,listener)
    else:
        // Extract registered event handler            
        html::handler<html::Event,S> handler = attr.handler
        // Construct event listener
        dom::EventListener listener = &(dom::Event e -> process_other_event(e,handler,st))
        // Add event listener
        setEventListener(element,attr.event,listener)

/**
 * Clear a give attribute from a specific Element.
 */
method clear_attribute<S>(dom::Element element, html::Attribute<S> attr, &State<S> st):
    // Dispatch on attribute type
    if attr is html::TextAttribute:
        element->removeAttribute(attr.key)                
    else if attr is html::MouseEventAttribute<S>:
        // Clear mouse event listener
        clearEventListener(element,attr.mouseEvent)
    else if attr is html::KeyboardEventAttribute<S>:
        // Clear key event listener                
        clearEventListener(element,attr.keyEvent)
    else:
        // Clear event listener
        clearEventListener(element,attr.event)

/**
 * Simple wrapper for processing mouse events which converts between
 * dom and html events.
 */
method process_mouse_event<S>(dom::MouseEvent e, html::handler<html::MouseEvent,S> h, &State<S> st):
    process_event(html::to_mouse_event(e),h,st)

/**
 * Simple wrapper for processing keyboard events which converts between
 * dom and html event.s
 */
method process_keyboard_event<S>(dom::KeyboardEvent e, html::handler<html::KeyboardEvent,S> h, &State<S> st):
    process_event(html::to_key_event(e),h,st)

/**
 * Simple wrapper for processing other events which converts between
 * dom and html event.s
 */
method process_other_event<S>(dom::Event e, html::handler<html::Event,S> h, &State<S> st):
    process_event(html::to_event(e),h,st)

/**
 * Process an incoming event using a registered event handler on a
 * given application state.
 */
method process_event<E,S>(E e, html::handler<E,S> h, &State<S> st):
    // Apply event handler to produce action
    (S model, io::Action<S>[] actions) = h(e,st->app.model)
    // Update application model
    st->app.model = model    
    // Process pending actions
    for i in 0..|actions|:
        io::processor(st,actions[i])
    // Refresh display
    refresh(st)

/**
 * Initial a dom element with the necessary dictionary for event
 * listeners.  This essentially guarantees that every time we
 * encounter a DOM element created from this library it will have this
 * dictionary available.  The purpose of the dictionary is to record
 * listeners that have been set so that they can be cleared again in
 * the future.
 */
export native method initEventListeners(dom::Element element)

/**
 * Set the listener for a given event on a DOM element such that it
 * can be subsequently cleared.  If a listener for that event already
 * exists, then it is removed.  Thus, at most one listener for any
 * event can exist.  
 */
export native method setEventListener<E,S>(dom::Element element, string event, dom::EventListener listener)

/**
 * Clear the listener for a given event on a DOM element.  A listener
 * must have been previously added, otherwise this will be stuck.
 */
export native method clearEventListener<E,S>(dom::Element element, string event)
    