' ********** Copyright 2016 Roku Corp.  All Rights Reserved. ********** 

sub init()
    m.itemcursor = m.top.findNode("itemcursor")
    m.titleLabel = m.top.findNode("titleLabel")
    m.contentLabel = m.top.findNode("contentLabel")
    m.thumbnail = m.top.findNode("thumbnail")
    m.videoPlayer = m.top.findNode("videoPlayer")
    m.isYoutubeVideo = false
end sub

sub showContent():
    setupVideo()
    itemContent = m.top.itemContent
    m.titleLabel.text = itemContent.title
    m.contentLabel.text = itemContent.description
    if (itemContent.hasField("SDPosterUrl"))
        m.thumbnail.uri = itemContent.SDPosterUrl
    end if
    if (itemContent.hasField("VideoUrl"))
        setupVideo()
    end if
    updateLayout()
end sub

sub setupVideo():
    if (m.top.itemContent.Streamformat = "hls")
        videoContent = CreateObject("RoSGNode", "ContentNode")
        videoContent.url = m.top.itemContent.VideoUrl
        videoContent.streamformat = "hls"
        m.video = m.top.findNode("videoPlayer")
        m.video.content = videoContent
'    m.video.control = "play"
    else
        m.isYoutubeVideo = true
    end if
end sub

sub showFocus():
    itemContent = m.top.itemContent
    if (itemContent.hasField("VideoUrl") and itemContent.streamFormat = "hls")
        if (m.top.focusPercent = 1)
            m.video.setFocus(true)
            m.video.control = "play"
        else
            m.video.control = "stop"
        end if
    end if
'    m.top.setFocus(true)
'    m.itemcursor.opacity = m.top.focusPercent
end sub

sub updateLayout():
    itemContent = m.top.itemContent
    if (itemContent.hasField("VideoUrl") and itemContent.streamFormat = "hls")
        m.videoPlayer.opacity = 1
        m.thumbnail.opacity = 0
    else
        m.videoPlayer.opacity = 0
        m.thumbnail.opacity = 1
    end if
    contentLabelTranslation = m.titleLabel.boundingRect().height
    if (not m.top.itemContent.hasField("SDPosterUrl"))
        contentLabelTranslation += m.thumbnail.boundingRect().height
    end if
    m.contentLabel.translation = [0, contentLabelTranslation + 20]
    m.thumbnail.translation = [0, m.titleLabel.boundingRect().height + 20]
    m.videoPlayer.translation = [0, m.titleLabel.boundingRect().height + 20]
end sub
