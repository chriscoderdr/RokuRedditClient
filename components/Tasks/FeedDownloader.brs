sub init()
    m.top.functionName = "fetch"
end sub

sub fetch()
    listContent = CreateObject("RoSGNode", "FeedContent")
    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt") ' or another appropriate certificate
    request.InitClientCertificates()
    request.SetUrl("https://www.reddit.com/r/videos/.json")
    response = request.GetToString()
    json = ParseJson(response)
    feed = CreateObject("roArray", 10, true)
    for each postData in json.data.children
        post = {
            title: postData.data.title,
            selfText: postData.data.selfText,
            thumbnail: postData.data.thumbnail,
            isVideo: postData.data.is_video,
        }
        itemContent = listContent.createChild("FeedContent")
        itemContent.setField("title", post.title)
        itemContent.setField("description", post.selfText)
        if (post.thumbnail <> "self" and post.thumbnail <> "default" and post.thumbnail <> "image")
            itemContent.setField("SDPosterUrl", post.thumbnail)
        end if
        if (post.isVideo)
            itemContent.setField("videoUrl", postData.data.secure_media.reddit_video.hls_url)
            itemContent.setField("streamformat", "hls")
        end if
        if (postData.data.media <> invalid and postData.data.media.type = "youtube.com")
            itemContent.setField("videoUrl", postData.data.url)
            itemContent.setField("streamFormat", "youtube")
        end if
    end for
    m.top.content = listContent
end sub