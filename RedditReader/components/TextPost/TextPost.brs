sub init()
    m.textLabel = m.top.findNode("textLabel")
    m.textLabel.setFocus(true)
end sub

sub render()
    post = m.top.post
    m.textLabel.text = post.description
    m.textLabel.setFocus(true)
end sub