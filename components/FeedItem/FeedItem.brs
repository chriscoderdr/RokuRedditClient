sub init():
    ? "Init:"
    m.titleLabel = m.top.findNode("titleLabel")
    m.contentLabel = m.top.findNode("contentLabel")
    m.imageView = m.top.findNode("imageView")
    m.postTypes = { self: 0 }
end sub

sub renderContent():
    post = m.top.itemContent
    m.titleLabel.text = post.title
    ' m.contentLabel.text = post.description
    titleHeight = m.titleLabel.boundingRect().height
    if (Right(post.url, 4) = ".jpg") then
        m.imageView.uri = post.url
        m.imageView.height = 1080 - titleHeight
    end if
end sub

function postType(post as object) as integer
    if (post.isSelf) then
        return m.postType.self
    end if
end function

' sub showContent():
'     setupVideo()
'     itemContent = m.top.itemContent
'     m.titleLabel.text = itemContent.title
'     m.contentLabel.text = itemContent.description


'     if (itemContent.SDPosterUrl = invalid or itemContent.SDPosterUrl = "")
'         m.thumbnail.uri = ""
'         m.thumbnail.opacity = 0
'     end if
'     if (itemContent.videoUri = invalid or itemContent.videoUri = "" or itemContent.StreamFormat <> "hls")
'         ' m.videoPlayer.content = ""
'         m.videoPlayer.opacity = 0
'     end if
'     if (itemContent.hasField("SDPosterUrl") and itemContent.SDPosterUrl <> invalid and itemContent.SDPosterUrl <> "" and (not itemContent.hasField("VideoUrl") or not m.top.itemContent.Streamformat = "hls"))
'         print itemContent.SDPosterUrl
'         ' m.loadingIndicator.opacity = 1
'         m.thumbnail.uri = itemContent.SDPosterUrl
'     else
'         m.thumbnail.opacity = 0
'     end if

'     if (itemContent.videoUrl <> invalid and itemContent.videoUrl <> "")
'         setupVideo()
'     end if

'     if ((m.thumbnail.uri = invalid or m.thumbnail.uri = "") and (m.videoPlayer.content = invalid or m.videoPlayer.content.url = ""))
'         m.thumbnail.uri = "https://api.qrserver.com/v1/create-qr-code/?size=1920x1080&data=" + itemContent.url
'         m.thumbnail.opacity = 1
'     end if

'     updateLayout()
' end sub

' sub setupVideo():
'     if (m.top.itemContent.Streamformat = "hls")
'         videoContent = CreateObject("RoSGNode", "ContentNode")
'         videoContent.url = m.top.itemContent.VideoUrl
'         videoContent.streamformat = "hls"
'         m.video = m.top.findNode("videoPlayer")
'         m.video.content = videoContent
'     else
'         m.isYoutubeVideo = true
'     end if
' end sub

' sub showFocus():
'     itemContent = m.top.itemContent
'     print itemContent
'     if (itemContent.videoUrl <> invalid and itemContent.videoUrl <> "" and itemContent.streamFormat = "hls")
'         if (m.top.focusPercent = 1)
'             m.video.setFocus(true)
'             m.video.control = "play"
'         end if
'         if (m.top.focusPercent <> 1 and m.video.status = "playing")
'             m.video.control = "stop"
'         end if
'     end if
' end sub

' sub updateLayout():
'     itemContent = m.top.itemContent
'     if (itemContent.videoUrl <> invalid and itemContent.videoUrl <> "" and itemContent.streamFormat = "hls")
'         m.videoPlayer.opacity = 1
'         m.thumbnail.opacity = 0
'     else
'         m.videoPlayer.opacity = 0
'         m.thumbnail.opacity = 1
'     end if
'     textHeight = m.titleLabel.boundingRect().height + m.contentLabel.boundingRect().height
'     m.videoPlayer.height = 1040 - textHeight
'     m.thumbnail.height = 1040 - textHeight
'     m.loadingIndicator.height = 1040 - textHeight
' end sub

' sub onImageStateChange(event as object)
'     print "loadStatusChange" + event.getData()
'     if (event.getData() = "ready")
'         m.loadingIndicator.opacity = 0
'     end if
'     if (event.getData() = "loading")
'         m.loadingIndicator.opacity = 1
'     end if
' end sub

' sub onVideoPlayerStateChange(event as object)
'     print "onVideoPlayerStateChange" + event.getData()
'     if (event.getData() = "buffering")
'         m.loadingIndicator.opacity = 1
'     else
'         m.loadingIndicator.opacity = 0
'     end if
'     if (event.getData() = "playing")
'         m.videoPlayer.opacity = 1
'     end if
' end sub
