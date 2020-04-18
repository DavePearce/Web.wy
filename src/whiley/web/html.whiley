package web

import to_string from std::ascii
import string from js::core
import w3c::dom

// ==================================================================
// Textual Attributes
// ==================================================================

public type TextAttribute is {
    string key,
    string value
}

// accept
// accept-charset
// accesskey
// action
// align
// alt
// async
// autocomplete
// autofocus
// autoplay
// charset
// checked
// cite
// class
public function class<T>(string text) -> Attribute<T>:
    return { key: "class", value: text }
    
// cols
// colspan
// content
// dattime
// disabled
public function disabled<T>() -> Attribute<T>:
    return { key: "disabled", value: "" }

// download
// for
// form
// formaction
// headers
// height
// hidden
// high
// href
// hreflang
// http-equiv

// id
public function id<T>(string text) -> Attribute<T>:
    return { key: "id", value: text }

// ismap
// kind
// label
// lang
// list
// loop
// low
// max
// maxlength
// media
// method
// min
// multiple
// muted

// name
public function name<T>(string text) -> Attribute<T>:
    return { key: "name", value: text }

// novalidate
// onabort
// onblur
// oncanplay
// oncanplaythrough
// onchange

public function style<T>(string text) -> Attribute<T>:
    return { key: "style", value: text }

public function tabindex<T>(int index) -> Attribute<T>:
    return { key: "tabindex", value: (string) to_string(index) }


// ==================================================================
// Event Attributes
// ==================================================================

public type Event is {    
    int timeStamp   
}

public type MouseEvent is {
    bool altKey,
    int button,
    int buttons,
    int clientX,
    int clientY,
    bool ctrlKey,
    bool metaKey,
    int movementX,
    int movementY,
    int offsetX,
    int offsetY,
    int pageX,
    int pageY,
    int region,
    int screenX,
    int screenY,
    bool shiftKey    
}

public type KeyboardEvent is {
    bool altKey,
    string code,
    bool ctrlKey,
    bool isComposing,
    string key,
    int keyCode,
    int location,
    bool metaKey,
    bool repeat,
    bool shiftKey    
}

// A simple event handler
public type handler<E,T>  is function(E,T)->(T)
// An event handler which supports I/O
public type iohandler<E,T> is function(E,T)->(T,IO<T>[])

/**
 * An adaptor turning regular handlers into I/O handlers.
 */
public function io_adaptor<E,T>(T t) -> (T to, IO<T>[] io):
    // FIXME: use of null here is workaround for bug
    return t,[null]

public type EventAttribute<T> is {
    string event,
    iohandler<Event,T> handler
}

public type MouseEventAttribute<T> is {
    string mouseEvent,
    iohandler<MouseEvent,T> handler
}

public type KeyboardEventAttribute<T> is {
    string keyEvent,
    iohandler<KeyboardEvent,T> handler
}

// onafterprint
// onbeforeprint
// onnbeforeunload
// onchange
public function change<T>(iohandler<MouseEvent,T> handler) -> Attribute<T>:
    return { mouseEvent: "change", handler: handler }

// Workaround for bug
type clickHandler<T> is iohandler<MouseEvent,T>

public function click<T>(handler<MouseEvent,T> handler) -> Attribute<T>:
    // wrap handler as an I/O handler
    clickHandler<T> ioh = &(MouseEvent e, T s -> io_adaptor<MouseEvent,T>(handler(e,s)))
    // Done
    return { mouseEvent: "click", handler: ioh }

public function click<T>(iohandler<MouseEvent,T> handler) -> Attribute<T>:
    return { mouseEvent: "click", handler: handler }

// oncopy
public function dblclick<T>(handler<MouseEvent,T> handler) -> Attribute<T>:
    // wrap handler as an I/O handler
    clickHandler<T> ioh = &(MouseEvent e, T s -> io_adaptor<MouseEvent,T>(handler(e,s)))
    // Done
    return { mouseEvent: "dblclick", handler: ioh }

public function dblclick<T>(iohandler<MouseEvent,T> handler) -> Attribute<T>:
    return { mouseEvent: "dblclick", handler: handler }

// ondrag
// ondragend
// ondragleave
// ondragover
// ondragstart
// ondurationchange
// onemptied
// onended
// onerror
// onfocus
public function focus<T>(iohandler<Event,T> handler) -> Attribute<T>:
    return { event: "focus", handler: handler }

// onhashchange
// oninput
// onkeydown
public function keydown<T>(iohandler<KeyboardEvent,T> handler) -> Attribute<T>:
    return { keyEvent: "keydown", handler: handler }

// onkeypress
public function keypress<T>(iohandler<KeyboardEvent,T> handler) -> Attribute<T>:
    return { keyEvent: "keypress", handler: handler }

// onkeyup
public function keyup<T>(iohandler<KeyboardEvent,T> handler) -> Attribute<T>:
    return { keyEvent: "keyup", handler: handler }

// onload
// onloadeddata
// onloadedmetadata
// onloadstart
// onmessage

// onmousedown
public function mousedown<T>(iohandler<MouseEvent,T> handler) -> Attribute<T>:
    return { mouseEvent: "mousedown", handler: handler }

// onmousemove
public function mousemove<T>(iohandler<MouseEvent,T> handler) -> Attribute<T>:
    return { mouseEvent: "mousemove", handler: handler }

// onmouseout
// onmouseover
public function mouseover<T>(iohandler<MouseEvent,T> handler) -> Attribute<T>:
    return { mouseEvent: "mouseover", handler: handler }

// onmouseup
// onmousewheel
// onoffline
// ononline
// onpagehide
// onpageshow
// onpopstate
// onresize
// onstorage
// onunload

// ==================================================================
// Attributes
// ==================================================================

public type Attribute<T> is TextAttribute |
                            EventAttribute<T> |
                            MouseEventAttribute<T> |
                            KeyboardEventAttribute<T>

// ==================================================================
// Requests
// ==================================================================

public type GET<T> is {
    // Target URL for request
    string url,
    // Handler called when OK
    function(T,null|string)->(T,IO<T>[]) okHandler,
    // Handler called on ERROR
    function(T)->(T,IO<T>[]) errHandler
}

public type POST<T> is {
    // Target URL for request
    string URL,
    // Payload to be sent
    string payload,
    // Handler called when OK
    function(T)->(T,IO<T>[]) okHandler,
    // Handler called on ERROR
    function(T)->(T,IO<T>[]) errHandler    
}

public type IO<T> is null | GET<T> | POST<T>

// ==================================================================
// Node
// ==================================================================

public type Element<T> is {
    string name,
    Attribute<T>[] attributes,
    Node<T>[] children    
}

public type Node<T> is  Element<T> | string

public function element<T>(string tag, Node<T> child) -> Node<T>:
    return element<T>(tag, [id<T>("");0], [child])

public function element<T>(string tag, Node<T>[] children) -> Node<T>:
    return element<T>(tag, [id<T>("");0], children)

public function element<T>(string tag, Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return element<T>(tag, attributes, [child])

public function element<T>(string tag, Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return { name: tag, attributes: attributes, children: children }

// ==================================================================
// Basic
// ==================================================================


// h1
public function h1<T>(Node<T> child) -> Node<T>:
    return h1<T>([id<T>("");0], [child])

public function h1<T>(Node<T>[] children) -> Node<T>:
    return h1<T>([id<T>("");0], children)

public function h1<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return h1<T>(attributes, [child])

public function h1<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("h1",attributes,children)

// h2
public function h2<T>(Node<T> child) -> Node<T>:
    return h2<T>([id<T>("");0], [child])

public function h2<T>(Node<T>[] children) -> Node<T>:
    return h2<T>([id<T>("");0], children)
    
public function h2<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return h2<T>(attributes, [child])

public function h2<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("h2",attributes,children)

// h3
public function h3<T>(Node<T> child) -> Node<T>:
    return h3<T>([id<T>("");0], [child])

public function h3<T>(Node<T>[] children) -> Node<T>:
    return h3<T>([id<T>("");0], children)

public function h3<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return h3<T>(attributes, [child])

public function h3<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("h3",attributes,children)

// h4
public function h4<T>(Node<T> child) -> Node<T>:
    return h4<T>([id<T>("");0], [child])

public function h4<T>(Node<T>[] children) -> Node<T>:
    return h4<T>([id<T>("");0], children)

public function h4<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return h4<T>(attributes, [child])

public function h4<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("h4",attributes,children)

// h5
public function h5<T>(Node<T> child) -> Node<T>:
    return h5<T>([id<T>("");0], [child])

public function h5<T>(Node<T>[] children) -> Node<T>:
    return h5<T>([id<T>("");0], children)

public function h5<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return h5<T>(attributes, [child])

public function h5<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("h5",attributes,children)

// h6
public function h6<T>(Node<T> child) -> Node<T>:
    return h6<T>([id<T>("");0], [child])

public function h6<T>(Node<T>[] children) -> Node<T>:
    return h6<T>([id<T>("");0], children)

public function h6<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return h6<T>(attributes, [child])

public function h6<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("h6",attributes,children)

// p
public function p<T>(Node<T> child) -> Node<T>:
    return p<T>([id<T>("");0],[child])

public function p<T>(Node<T>[] children) -> Node<T>:
    return p<T>([id<T>("");0],children)

public function p<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return p<T>(attributes,[child])

public function p<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("p",attributes,children)

// br
public function br<T>() -> Node<T>:
    return br<T>([id<T>("");0])

public function br<T>(Attribute<T>[] attributes) -> Node<T>:
    return element("br", attributes, ["";0])

// hr
public function hr<T>() -> Node<T>:
    return hr<T>([id<T>("");0])

public function hr<T>(Attribute<T>[] attributes) -> Node<T>:
    return element("hr", attributes, ["";0])

// ==================================================================
// Formatting
// ==================================================================

// abbr
public function abbr<T>(Node<T> child) -> Node<T>:
    return abbr<T>([id<T>("");0], [child])

public function abbr<T>(Node<T>[] children) -> Node<T>:
    return abbr<T>([id<T>("");0], children)

public function abbr<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return abbr<T>(attributes, [child])

public function abbr<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("abbr",attributes,children)

// address
public function address<T>(Node<T> child) -> Node<T>:
    return address<T>([id<T>("");0], [child])

public function address<T>(Node<T>[] children) -> Node<T>:
    return address<T>([id<T>("");0], children)

public function address<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return address<T>(attributes, [child])

public function address<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("address",attributes,children)

// b
public function b<T>(Node<T> child) -> Node<T>:
    return b<T>([id<T>("");0], [child])

public function b<T>(Node<T>[] children) -> Node<T>:
    return b<T>([id<T>("");0], children)

public function b<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return b<T>(attributes, [child])

public function b<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("b",attributes,children)

// blockquote
public function blockquote<T>(Node<T> child) -> Node<T>:
    return blockquote<T>([id<T>("");0], [child])

public function blockquote<T>(Node<T>[] children) -> Node<T>:
    return blockquote<T>([id<T>("");0], children)

public function blockquote<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return blockquote<T>(attributes, [child])

public function blockquote<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("blockquote",attributes,children)

// bdi
// bdo
// big

// center
public function center<T>(Node<T> child) -> Node<T>:
    return center<T>([id<T>("");0], [child])

public function center<T>(Node<T>[] children) -> Node<T>:
    return center<T>([id<T>("");0], children)

public function center<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return center<T>(attributes, [child])

public function center<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("center",attributes,children)

// cite
public function cite<T>(Node<T> child) -> Node<T>:
    return cite<T>([id<T>("");0], [child])

public function cite<T>(Node<T>[] children) -> Node<T>:
    return cite<T>([id<T>("");0], children)

public function cite<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return cite<T>(attributes, [child])

public function cite<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("cite",attributes,children)

// code
public function code<T>(Node<T> child) -> Node<T>:
    return code<T>([id<T>("");0], [child])

public function code<T>(Node<T>[] children) -> Node<T>:
    return code<T>([id<T>("");0], children)

public function code<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return code<T>(attributes, [child])

public function code<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("code",attributes,children)

// del
// dfn

// em
public function em<T>(Node<T> child) -> Node<T>:
    return em<T>([id<T>("");0], [child])

public function em<T>(Node<T>[] children) -> Node<T>:
    return em<T>([id<T>("");0], children)

public function em<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return em<T>(attributes, [child])

public function em<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("em",attributes,children)

// font
public function font<T>(Node<T> child) -> Node<T>:
    return font<T>([id<T>("");0], [child])

public function font<T>(Node<T>[] children) -> Node<T>:
    return font<T>([id<T>("");0], children)

public function font<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return font<T>(attributes, [child])

public function font<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("font",attributes,children)

// i
public function i<T>(Node<T> child) -> Node<T>:
    return i<T>([id<T>("");0], [child])

public function i<T>(Node<T>[] children) -> Node<T>:
    return i<T>([id<T>("");0], children)

public function i<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return i<T>(attributes, [child])

public function i<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("i",attributes,children)

// ins
// kbd
// mark
// meter
// pre
public function pre<T>(Node<T> child) -> Node<T>:
    return pre<T>([id<T>("");0], [child])

public function pre<T>(Node<T>[] children) -> Node<T>:
    return pre<T>([id<T>("");0], children)

public function pre<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return pre<T>(attributes, [child])

public function pre<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("pre",attributes,children)

// progress

// q
public function q<T>(Node<T> child) -> Node<T>:
    return q<T>([id<T>("");0], [child])

public function q<T>(Node<T>[] children) -> Node<T>:
    return q<T>([id<T>("");0], children)

public function q<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return q<T>(attributes, [child])

public function q<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("q",attributes,children)

// rp
// rt
// ruby
// s
public function s<T>(Node<T> child) -> Node<T>:
    return s<T>([id<T>("");0], [child])

public function s<T>(Node<T>[] children) -> Node<T>:
    return s<T>([id<T>("");0], children)

public function s<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return s<T>(attributes, [child])

public function s<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("s",attributes,children)

// samp

// small
public function small<T>(Node<T> child) -> Node<T>:
    return small<T>([id<T>("");0], [child])

public function small<T>(Node<T>[] children) -> Node<T>:
    return small<T>([id<T>("");0], children)

public function small<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return small<T>(attributes, [child])

public function small<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("small",attributes,children)

// strike
public function strike<T>(Node<T> child) -> Node<T>:
    return strike<T>([id<T>("");0], [child])

public function strike<T>(Node<T>[] children) -> Node<T>:
    return strike<T>([id<T>("");0], children)

public function strike<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return strike<T>(attributes, [child])

public function strike<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("strike",attributes,children)

// strong
public function strong<T>(Node<T> child) -> Node<T>:
    return strong<T>([id<T>("");0], [child])

public function strong<T>(Node<T>[] children) -> Node<T>:
    return strong<T>([id<T>("");0], children)

public function strong<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return strong<T>(attributes, [child])

public function strong<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("strong",attributes,children)

// sub
public function sub<T>(Node<T> child) -> Node<T>:
    return sub<T>([id<T>("");0], [child])

public function sub<T>(Node<T>[] children) -> Node<T>:
    return sub<T>([id<T>("");0], children)

public function sub<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return sub<T>(attributes, [child])

public function sub<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("sub",attributes,children)

// sup
public function sup<T>(Node<T> child) -> Node<T>:
    return sup<T>([id<T>("");0], [child])

public function sup<T>(Node<T>[] children) -> Node<T>:
    return sup<T>([id<T>("");0], children)

public function sup<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return sup<T>(attributes, [child])

public function sup<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("sup",attributes,children)

// template
// time
// tt

// u
public function u<T>(Node<T> child) -> Node<T>:
    return u<T>([id<T>("");0], [child])

public function u<T>(Node<T>[] children) -> Node<T>:
    return u<T>([id<T>("");0], children)

public function u<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return u<T>(attributes, [child])

public function u<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("u",attributes,children)

// var
// wbr

// ==================================================================
// Form Tags
// ==================================================================

// form
public function form<T>(Node<T> child) -> Node<T>:
    return form<T>([id<T>("");0], [child])

public function form<T>(Node<T>[] children) -> Node<T>:
    return form<T>([id<T>("");0], children)

public function form<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return form<T>(attributes, [child])

public function form<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("form",attributes,children)

// input
public function input<T>(Node<T> child) -> Node<T>:
    return input<T>([id<T>("");0], [child])

public function input<T>(Node<T>[] children) -> Node<T>:
    return input<T>([id<T>("");0], children)

public function input<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return input<T>(attributes, [child])

public function input<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("input",attributes,children)

// textarea
public function textarea<T>(Node<T> child) -> Node<T>:
    return textarea<T>([id<T>("");0], [child])

public function textarea<T>(Node<T>[] children) -> Node<T>:
    return textarea<T>([id<T>("");0], children)

public function textarea<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return textarea<T>(attributes, [child])

public function textarea<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("textarea",attributes,children)

// button
public function button<T>(Node<T> child) -> Node<T>:
    return button<T>([id<T>("");0], [child])

public function button<T>(Node<T>[] children) -> Node<T>:
    return button<T>([id<T>("");0], children)

public function button<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return button<T>(attributes, [child])

public function button<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("button",attributes,children)

// select
public function select<T>(Node<T> child) -> Node<T>:
    return select<T>([id<T>("");0], [child])

public function select<T>(Node<T>[] children) -> Node<T>:
    return select<T>([id<T>("");0], children)

public function select<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return select<T>(attributes, [child])

public function select<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("select",attributes,children)

// optgroup
public function optgroup<T>(Node<T> child) -> Node<T>:
    return optgroup<T>([id<T>("");0], [child])

public function optgroup<T>(Node<T>[] children) -> Node<T>:
    return optgroup<T>([id<T>("");0], children)

public function optgroup<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return optgroup<T>(attributes, [child])

public function optgroup<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("optgroup",attributes,children)

// option
public function option<T>(Node<T> child) -> Node<T>:
    return option<T>([id<T>("");0], [child])

public function option<T>(Node<T>[] children) -> Node<T>:
    return option<T>([id<T>("");0], children)

public function option<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return option<T>(attributes, [child])

public function option<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("option",attributes,children)

// label
public function label<T>(Node<T> child) -> Node<T>:
    return label<T>([id<T>("");0], [child])

public function label<T>(Node<T>[] children) -> Node<T>:
    return label<T>([id<T>("");0], children)

public function label<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return label<T>(attributes, [child])

public function label<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("label",attributes,children)

// fieldset
public function fieldset<T>(Node<T> child) -> Node<T>:
    return fieldset<T>([id<T>("");0], [child])

public function fieldset<T>(Node<T>[] children) -> Node<T>:
    return fieldset<T>([id<T>("");0], children)

public function fieldset<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return fieldset<T>(attributes, [child])

public function fieldset<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("fieldset",attributes,children)

// legend
public function legend<T>(Node<T> child) -> Node<T>:
    return legend<T>([id<T>("");0], [child])

public function legend<T>(Node<T>[] children) -> Node<T>:
    return legend<T>([id<T>("");0], children)

public function legend<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return legend<T>(attributes, [child])

public function legend<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("legend",attributes,children)

// datalist
public function datalist<T>(Node<T> child) -> Node<T>:
    return datalist<T>([id<T>("");0], [child])

public function datalist<T>(Node<T>[] children) -> Node<T>:
    return datalist<T>([id<T>("");0], children)

public function datalist<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return datalist<T>(attributes, [child])

public function datalist<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("datalist",attributes,children)

// output
public function output<T>(Node<T> child) -> Node<T>:
    return output<T>([id<T>("");0], [child])

public function output<T>(Node<T>[] children) -> Node<T>:
    return output<T>([id<T>("");0], children)

public function output<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return output<T>(attributes, [child])

public function output<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("output",attributes,children)


// ==================================================================
// Frames
// ==================================================================

// frame
// frameset
// noframes

public function iframe<T>(Node<T> child) -> Node<T>:
    return iframe<T>([id<T>("");0], [child])

public function iframe<T>(Node<T>[] children) -> Node<T>:
    return iframe<T>([id<T>("");0], children)

public function iframe<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return iframe<T>(attributes, [child])

public function iframe<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("iframe",attributes,children)

// ==================================================================
// Images
// ==================================================================

// img
public function img<T>(Node<T> child) -> Node<T>:
    return img<T>([id<T>("");0], [child])

public function img<T>(Node<T>[] children) -> Node<T>:
    return img<T>([id<T>("");0], children)

public function img<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return img<T>(attributes, [child])

public function img<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("img",attributes,children)

// map
public function map<T>(Node<T> child) -> Node<T>:
    return map<T>([id<T>("");0], [child])

public function map<T>(Node<T>[] children) -> Node<T>:
    return map<T>([id<T>("");0], children)

public function map<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return map<T>(attributes, [child])

public function map<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("map",attributes,children)

// area
public function area<T>(Node<T> child) -> Node<T>:
    return area<T>([id<T>("");0], [child])

public function area<T>(Node<T>[] children) -> Node<T>:
    return area<T>([id<T>("");0], children)

public function area<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return area<T>(attributes, [child])

public function area<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("area",attributes,children)

// canvas
public function canvas<T>(Node<T> child) -> Node<T>:
    return canvas<T>([id<T>("");0], [child])

public function canvas<T>(Node<T>[] children) -> Node<T>:
    return canvas<T>([id<T>("");0], children)

public function canvas<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return canvas<T>(attributes, [child])

public function canvas<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("canvas",attributes,children)

// figcaption
public function figcaption<T>(Node<T> child) -> Node<T>:
    return figcaption<T>([id<T>("");0], [child])

public function figcaption<T>(Node<T>[] children) -> Node<T>:
    return figcaption<T>([id<T>("");0], children)

public function figcaption<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return figcaption<T>(attributes, [child])

public function figcaption<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("figcaption",attributes,children)

// figure
public function figure<T>(Node<T> child) -> Node<T>:
    return figure<T>([id<T>("");0], [child])

public function figure<T>(Node<T>[] children) -> Node<T>:
    return figure<T>([id<T>("");0], children)

public function figure<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return figure<T>(attributes, [child])

public function figure<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("figure",attributes,children)

// picture
public function picture<T>(Node<T> child) -> Node<T>:
    return picture<T>([id<T>("");0], [child])

public function picture<T>(Node<T>[] children) -> Node<T>:
    return picture<T>([id<T>("");0], children)

public function picture<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return picture<T>(attributes, [child])

public function picture<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("picture",attributes,children)

// svg
public function svg<T>(Node<T> child) -> Node<T>:
    return svg<T>([id<T>("");0], [child])

public function svg<T>(Node<T>[] children) -> Node<T>:
    return svg<T>([id<T>("");0], children)

public function svg<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return svg<T>(attributes, [child])

public function svg<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("svg",attributes,children)

// ==================================================================
// Links
// ==================================================================

// a
public function a<T>(Node<T> child) -> Node<T>:
    return a<T>([id<T>("");0], [child])

public function a<T>(Node<T>[] children) -> Node<T>:
    return a<T>([id<T>("");0], children)

public function a<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return a<T>(attributes, [child])

public function a<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("a",attributes,children)

// link
public function link<T>(Node<T> child) -> Node<T>:
    return link<T>([id<T>("");0], [child])

public function link<T>(Node<T>[] children) -> Node<T>:
    return link<T>([id<T>("");0], children)

public function link<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return link<T>(attributes, [child])

public function link<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("link",attributes,children)

// nav
public function nav<T>(Node<T> child) -> Node<T>:
    return nav<T>([id<T>("");0], [child])

public function nav<T>(Node<T>[] children) -> Node<T>:
    return nav<T>([id<T>("");0], children)

public function nav<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return nav<T>(attributes, [child])

public function nav<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("nav",attributes,children)

// ==================================================================
// Lists
// ==================================================================

// ul
public function ul<T>(Node<T> child) -> Node<T>:
    return ul<T>([id<T>("");0], [child])

public function ul<T>(Node<T>[] children) -> Node<T>:
    return ul<T>([id<T>("");0], children)

public function ul<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return ul<T>(attributes, [child])

public function ul<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("ul",attributes,children)

// ol
public function ol<T>(Node<T> child) -> Node<T>:
    return ol<T>([id<T>("");0], [child])

public function ol<T>(Node<T>[] children) -> Node<T>:
    return ol<T>([id<T>("");0], children)

public function ol<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return ol<T>(attributes, [child])

public function ol<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("ol",attributes,children)

// li
public function li<T>(Node<T> child) -> Node<T>:
    return li<T>([id<T>("");0], [child])

public function li<T>(Node<T>[] children) -> Node<T>:
    return li<T>([id<T>("");0], children)

public function li<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return li<T>(attributes, [child])

public function li<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("li",attributes,children)

// dl
public function dl<T>(Node<T> child) -> Node<T>:
    return dl<T>([id<T>("");0], [child])

public function dl<T>(Node<T>[] children) -> Node<T>:
    return dl<T>([id<T>("");0], children)

public function dl<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return dl<T>(attributes, [child])

public function dl<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("dl",attributes,children)

// dt
public function dtr<T>(Node<T> child) -> Node<T>:
    return dtr<T>([id<T>("");0], [child])

public function dtr<T>(Node<T>[] children) -> Node<T>:
    return dtr<T>([id<T>("");0], children)

public function dtr<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return dtr<T>(attributes, [child])

public function dtr<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("dtr",attributes,children)

// dd
public function dd<T>(Node<T> child) -> Node<T>:
    return dd<T>([id<T>("");0], [child])

public function dd<T>(Node<T>[] children) -> Node<T>:
    return dd<T>([id<T>("");0], children)

public function dd<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return dd<T>(attributes, [child])

public function dd<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("dd",attributes,children)

// ==================================================================
// Tables
// ==================================================================

// table
public function table<T>(Node<T> child) -> Node<T>:
    return table<T>([id<T>("");0], [child])

public function table<T>(Node<T>[] children) -> Node<T>:
    return table<T>([id<T>("");0], children)

public function table<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return table<T>(attributes, [child])

public function table<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("table",attributes,children)

// caption
public function caption<T>(Node<T> child) -> Node<T>:
    return caption<T>([id<T>("");0], [child])

public function caption<T>(Node<T>[] children) -> Node<T>:
    return caption<T>([id<T>("");0], children)

public function caption<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return caption<T>(attributes, [child])

public function caption<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("caption",attributes,children)

// th
public function th<T>(Node<T> child) -> Node<T>:
    return th<T>([id<T>("");0], [child])

public function th<T>(Node<T>[] children) -> Node<T>:
    return th<T>([id<T>("");0], children)

public function th<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return th<T>(attributes, [child])

public function th<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("th",attributes,children)

// tr
public function tr<T>(Node<T> child) -> Node<T>:
    return tr<T>([id<T>("");0], [child])

public function tr<T>(Node<T>[] children) -> Node<T>:
    return tr<T>([id<T>("");0], children)

public function tr<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return tr<T>(attributes, [child])

public function tr<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("tr",attributes,children)

// td
public function td<T>(Node<T> child) -> Node<T>:
    return td<T>([id<T>("");0], [child])

public function td<T>(Node<T>[] children) -> Node<T>:
    return td<T>([id<T>("");0], children)

public function td<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return td<T>(attributes, [child])

public function td<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("td",attributes,children)

// thead
public function thead<T>(Node<T> child) -> Node<T>:
    return thead<T>([id<T>("");0], [child])

public function thead<T>(Node<T>[] children) -> Node<T>:
    return thead<T>([id<T>("");0], children)

public function thead<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return thead<T>(attributes, [child])

public function thead<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("thead",attributes,children)

// tbody
public function tbody<T>(Node<T> child) -> Node<T>:
    return tbody<T>([id<T>("");0], [child])

public function tbody<T>(Node<T>[] children) -> Node<T>:
    return tbody<T>([id<T>("");0], children)

public function tbody<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return tbody<T>(attributes, [child])

public function tbody<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("tbody",attributes,children)

// tfoot
public function tfoot<T>(Node<T> child) -> Node<T>:
    return tfoot<T>([id<T>("");0], [child])

public function tfoot<T>(Node<T>[] children) -> Node<T>:
    return tfoot<T>([id<T>("");0], children)

public function tfoot<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return tfoot<T>(attributes, [child])

public function tfoot<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("tfoot",attributes,children)

// col
public function col<T>(Node<T> child) -> Node<T>:
    return col<T>([id<T>("");0], [child])

public function col<T>(Node<T>[] children) -> Node<T>:
    return col<T>([id<T>("");0], children)

public function col<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return col<T>(attributes, [child])

public function col<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("col",attributes,children)

// colgroup
public function colgroup<T>(Node<T> child) -> Node<T>:
    return colgroup<T>([id<T>("");0], [child])

public function colgroup<T>(Node<T>[] children) -> Node<T>:
    return colgroup<T>([id<T>("");0], children)

public function colgroup<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return colgroup<T>(attributes, [child])

public function colgroup<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("colgroup",attributes,children)

// ==================================================================
// Style and Semantics
// ==================================================================

// style

// div
public function div<T>(Node<T> child) -> Node<T>:
    return div<T>([id<T>("");0],[child])

public function div<T>(Node<T>[] children) -> Node<T>:
    return div<T>([id<T>("");0],children)

public function div<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return div<T>(attributes,[child])

public function div<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("div",attributes,children)

// span
public function span<T>(Node<T> child) -> Node<T>:
    return span<T>([id<T>("");0],[child])

public function span<T>(Node<T>[] children) -> Node<T>:
    return span<T>([id<T>("");0],children)

public function span<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return span<T>(attributes,[child])

public function span<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("span",attributes,children)

// header
public function header<T>(Node<T> child) -> Node<T>:
    return header<T>([id<T>("");0],[child])

public function header<T>(Node<T>[] children) -> Node<T>:
    return header<T>([id<T>("");0],children)

public function header<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return header<T>(attributes,[child])

public function header<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("header",attributes,children)

// footer
public function footer<T>(Node<T> child) -> Node<T>:
    return footer<T>([id<T>("");0],[child])

public function footer<T>(Node<T>[] children) -> Node<T>:
    return footer<T>([id<T>("");0],children)

public function footer<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return footer<T>(attributes,[child])

public function footer<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("footer",attributes,children)

// main
public function main<T>(Node<T> child) -> Node<T>:
    return main<T>([id<T>("");0],[child])

public function main<T>(Node<T>[] children) -> Node<T>:
    return main<T>([id<T>("");0],children)

public function main<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return main<T>(attributes,[child])

public function main<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("main",attributes,children)

// section
public function section<T>(Node<T> child) -> Node<T>:
    return section<T>([id<T>("");0],[child])

public function section<T>(Node<T>[] children) -> Node<T>:
    return section<T>([id<T>("");0],children)

public function section<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return section<T>(attributes,[child])

public function section<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("section",attributes,children)

// article
public function article<T>(Node<T> child) -> Node<T>:
    return article<T>([id<T>("");0],[child])

public function article<T>(Node<T>[] children) -> Node<T>:
    return article<T>([id<T>("");0],children)

public function article<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return article<T>(attributes,[child])

public function article<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("article",attributes,children)

// aside
public function aside<T>(Node<T> child) -> Node<T>:
    return aside<T>([id<T>("");0],[child])

public function aside<T>(Node<T>[] children) -> Node<T>:
    return aside<T>([id<T>("");0],children)

public function aside<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return aside<T>(attributes,[child])

public function aside<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("aside",attributes,children)

// details
public function details<T>(Node<T> child) -> Node<T>:
    return details<T>([id<T>("");0],[child])

public function details<T>(Node<T>[] children) -> Node<T>:
    return details<T>([id<T>("");0],children)

public function details<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return details<T>(attributes,[child])

public function details<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("details",attributes,children)

// dialog
public function dialog<T>(Node<T> child) -> Node<T>:
    return dialog<T>([id<T>("");0],[child])

public function dialog<T>(Node<T>[] children) -> Node<T>:
    return dialog<T>([id<T>("");0],children)

public function dialog<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return dialog<T>(attributes,[child])

public function dialog<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("dialog",attributes,children)

// summary
public function summary<T>(Node<T> child) -> Node<T>:
    return summary<T>([id<T>("");0],[child])

public function summary<T>(Node<T>[] children) -> Node<T>:
    return summary<T>([id<T>("");0],children)

public function summary<T>(Attribute<T>[] attributes, Node<T> child) -> Node<T>:
    return summary<T>(attributes,[child])

public function summary<T>(Attribute<T>[] attributes, Node<T>[] children) -> Node<T>:
    return element("summary",attributes,children)

// ========================================================
// To HTML
// ========================================================

/**
 * Convert an HTML model into concrete DOM nodes using a given
 * Document to construct new items.
 */ 
public method to_dom<T>(Node<T> node, dom::Document doc) -> (dom::Node r):
    if node is string:
        // Construct a text node
        return doc->createTextNode(node)
    else:
        dom::Element element = doc->createElement(node.name)
        // Recursively construct children
        for i in 0..|node.children|:
            // Construct child element
            dom::Node child = to_dom<T>(node.children[i],doc)
            // Append to this element
            element->appendChild(child)
        //
        // FIXME: handle attributess
        //
        return element
            