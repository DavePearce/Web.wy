package web

import w3c::dom
import web::html with MouseEvent, handler

public type App<S,A> is {
    // Current application state
    S model,
    // View transformer
    function(S)->html::Node<S,A> view,
    // Action processor
    method(S,A[])->(S) processor
}

type State<S,A> is {
    // Registered Application
    App<S,A> app,
    // DOM node app attached to
    dom::Node root,
    // Processor for actions
    null|html::ActionProcessor<S,A> processor,    
    // Current DOM tree (if any)
    null|dom::Node tree,
    // DOM access (needed for creationg)
    dom::Document document
}

function State<S,A>(App<S,A> app, dom::Node root, dom::Document doc) -> State<S,A>:
    return {
        app: app,
        root: root,
        processor: null,
        tree: null,
        document: doc        
    }

/**
 * Event loop for an app.
 */
public export method run<S,A>(App<S,A> app, dom::Node root, dom::Document doc):
    // Construct state object
    &State<S,A> state = new State(app,root,doc)
    // Construct action processor
    state->processor = create_action_processor(state)
    // Construct Initial Display
    refresh(state)

/**
 * Construct an appropriate action processor.
 */
method create_action_processor<S,A>(&State<S,A> st) -> html::ActionProcessor<S,A>:
    return {
        // Construct processor for mouse events
        mouse: &(html::MouseEvent e, html::handler<html::MouseEvent,S,A> h -> process_event(e,h,st)),
        // Construct processor for keyboard events
        keyboard: &(html::KeyboardEvent e, html::handler<html::KeyboardEvent,S,A> h -> process_event(e,h,st)),
        // Construct processor for other events
        other: &(html::Event e, html::handler<html::Event,S,A> h -> process_event(e,h,st))
    }

/**
 * Process an incoming event using a registered event handler on a
 * given application state.
 */
method process_event<E,S,A>(E e, handler<E,S,A> h, &State<S,A> st):
    // Apply event handler to produce action
    (S model, A[] actions) = h(e,st->app.model)
    // Process prending actions
    model = st->app.processor(model,actions)
    // Update application model
    st->app.model = model
    // Refresh display
    refresh(st)

/**
 * Refresh the current display.
 */
method refresh<S,A>(&State<S,A> st):
    html::ActionProcessor<S,A> p = unwrap(st->processor)
    //
    dom::Node|null old = st->tree
    // Construct intial view
    html::Node<S,A> init = st->app.view(st->app.model)    
    // Reinitialise DOM tree
    dom::Node tree = html::to_dom(init,p,st->document)
    // Add or update tree
    if old is null:
        st->root->appendChild(tree)
    else:
        st->root->replaceChild(tree,old)
    // Assign tree
    st->tree = tree

function unwrap<S,A>(null|html::ActionProcessor<S,A> p) -> html::ActionProcessor<S,A>:
    if p is null:
        return unwrap(p)
    else:
        return p