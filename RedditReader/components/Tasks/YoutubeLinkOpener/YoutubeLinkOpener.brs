sub init()
    m.top.functionName = "openYoutube"
end sub

sub openYoutube()
    videoId = m.top.getField("videoId")
    appID = 837
    ipAddrs = CreateObject("roDeviceInfo").GetIPAddrs()
    IP = ipAddrs.Items()[0].value
    if ipAddrs.eth0 <> invalid
        url = "http://" + IP + ":8060/launch/837?contentID=" + videoId
    else
        url = "http://" + IP + ":8060/launch/837?contentID=" + videoId
    end if

    request = CreateObject("roUrlTransfer")
    port = CreateObject("roMessagePort")
    request.SetMessagePort(port)
    request.SetCertificatesFile("common:/certs/ca-bundle.crt") ' or another appropriate certificate
    request.InitClientCertificates()
    request.SetUrl(url)
    ? url
    ? request.PostFromString("")
    ? request.GetFailureReason()
    urlEvent = request.head()
end sub