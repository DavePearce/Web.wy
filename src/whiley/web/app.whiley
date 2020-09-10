package web

import std::math
import string from js::core
import w3c::dom
import web::html with MouseEvent, handler
import web::diff

public type App<S,A> is {
    // Current application state
    S model,
    // View transformer
    function view(S)->html::Node<S,A>,
    // Action processor
    method process(&State<S,A>,A)
}

public type Rendering<S,A> is {
    // Model state
    html::Node<S,A> model,
    // Rendered view
    dom::Node view
}

public type State<S,A> is {
    // Registered Application
    App<S,A> app,
    // DOM node app attached to
    dom::Node root,
    // Current rendering (if any)
    null|Rendering<S,A> rendering,
    // DOM access (needed for creating)
    dom::Document document
}

/**
 * Event loop for an app.
 */
public export method run<S,A>(App<S,A> app, dom::Node root, dom::Document doc):
    // Construct state object
    &State<S,A> state = new State{app:app,root:root,rendering:null,document:doc}
    // Construct Initial Display
    refresh(state)

/**
 * Refresh the current display.
 */
method refresh<S,A>(&State<S,A> st):
    // Extract current rendering (if any)
    null|Rendering<S,A> current = st->rendering
    // Transform model into (functional) HTML
    html::Node<S,A> m = st->app.view(st->app.model)
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
        diff::NodeOperation<S,A> update = diff::create(current.model,m)
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
            set_attribute(element,attr,st)
            // Done
        return element

/**
 * update an existing DOM tree to reflect a new model.
 */
method update_dom<S,A>(dom::Node tree, diff::NodeOperation<S,A> op, &State<S,A> st) -> (dom::Node r):
    if op is null:
        return tree
    else if op is diff::Replace<S,A>:
        // Replace entire subtree
        return to_dom(op.node,st)
    else if tree->hasChildNodes():
        // Update existing children
        update_children(tree,op.children,st)
    // Append / Remove children                
    resize_children(tree,op.children,st)
    // Apply / Undo attributes
    update_attributes<S,A>(tree,op.attributes,st)
    // Done
    return tree

method update_children<S,A>(dom::Node tree, diff::NodeOperation<S,A>[] operations, &State<S,A> st):
    dom::Node[] children = tree->childNodes
    int size = math::min(|children|,|operations|)
    // Update children
    for i in 0..size:
        dom::Node ithChild = children[i]
        diff::NodeOperation<S,A> ithOp = operations[i]
        if !(ithOp is null):
            // Recursively update child
            dom::Node t = update_dom(ithChild,ithOp,st)
            // Replace existing child with updated child
            replace_child(tree,ithChild,t)

method resize_children<S,A>(dom::Node tree, diff::NodeOperation<S,A>[] operations, &State<S,A> st):
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
            diff::NodeOperation<S,A> ith = operations[i]
            // Only action replacements
            if ith is diff::Replace<S,A>:
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

method update_attributes<S,A>(dom::Node tree, diff::AttributeOperation<S,A>[] operations, &State<S,A> st):
    if tree->nodeType == dom::ELEMENT_NODE:
        // Enforce that tree is Element
        assert tree is dom::Element
        // Undo everything
        for i in 0..|operations|:
            diff::AttributeOperation<S,A> ith = operations[i]
            if ith is null || ith.before is null:
                skip
            else:
                clear_attribute(tree,ith.before,st)
        // Apply everything
        for i in 0..|operations|:
            diff::AttributeOperation<S,A> ith = operations[i]
            if ith is null || ith.after is null:
                skip
            else:
                set_attribute(tree,ith.after,st)
    // Done

/**
 * Set a given attribute on a specific element.  Exactly how this is
 * done depends on the attribute in question.
 */
method set_attribute<S,A>(dom::Element element, html::Attribute<S,A> attr, &State<S,A> st):
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

/**
 * Clear a give attribute from a specific Element.
 */
method clear_attribute<S,A>(dom::Element element, html::Attribute<S,A> attr, &State<S,A> st):
    skip // for now

/**
 * Simple wrapper for processing mouse events which converts between
 * dom and html events.
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