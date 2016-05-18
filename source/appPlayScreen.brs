Function preShowPlayScreen() As Object
    port=CreateObject("roMessagePort")
    screen = CreateObject("roSpringboardScreen")
    screen.SetDescriptionStyle("Play") 
    screen.SetMessagePort(port)
    return screen
End Function

Function showPlayScreen(screen As Object) As Integer

    print "entered into play screen"
      
    screen.ClearButtons()
    screen.AddButton(1, "Play-Resume")
    screen.SetContent("Play-Resume")
    screen.SetTitle("Play-Resume")
    screen.AddButton(2, "Close")
    screen.SetContent("Close")
    screen.SetTitle("Close")
    screen.SetPosterStyle("rounded-square-generic")
    screen.SetAdDisplayMode("scale-to-fit")
    screen.SetStaticRatingEnabled(false)
    screen.Show()    
    
    while true
        msg = wait(0, screen.GetMessagePort())

        if type(msg) = "roSpringboardScreenEvent" then
            if msg.isScreenClosed()
                print "Screen closed"
                exit while      
            else if msg.isButtonPressed() 
                print "Play ButtonPressed"
                if msg.GetIndex() = 1
					print "press play/resume"
							
					urlstr= urlPrefix() + "/Kitchen/playpause"
	
					restClientGetUserAuth(urlstr, "")

                endif
                if msg.GetIndex() = 2                    
                    screen.Close() 
                endif
            else if msg.isRemoteKeyPressed() then
                print"Remote Key pressed "; msg.GetIndex()            
            end if
        else
            print "Unexpected message class: "; type(msg)
        end if
    end while    
    return 0

End Function


Function restClientGetUserAuth(url As String, param As Object)
	roUrlTransfer = CreateObject("roUrlTransfer")
	port = CreateObject("roMessagePort")
	roUrlTransfer.SetMessagePort(port)
	roUrlTransfer.SetUrl(url)	
	'roUrlTransfer.AddHeader("Content-Type", "message/http")	
    'roUlTransfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    'roUrlTransfer.InitClientCertificates()    
    'roUrlTransfer.AddHeader("X-Roku-Reserved-Dev-Id", param)
    'roUrlTransfer.EnableFreshConnection(true)
	
	print "Posting to " + roUrlTransfer.GetUrl()
	
	if (roUrlTransfer.AsyncGetToString())
        while (true)
            msg = wait(0, port)
            if (type(msg) = "roUrlEvent")
                code = msg.GetResponseCode()
                response = msg.GetFailureReason()
				print "code: "; code
				print "response: "; response
                if (code = 200)
					SetJSONResponseCode("200")               
					return out
                else if (code = 401)
					SetJSONResponseCode("401")
					return out
				else if (code = 400)
					SetJSONResponseCode("400")
					return out
				else if (code = 500)
					SetJSONResponseCode("500")
					return out
				else if (code = -52)
					print "No response returnd"
					return out
				endif
            else if (event = invalid)
                request.AsyncCancel()
            endif
        end while
    endif
End Function

Function SetJSONResponseCode(JSONResponseCode as String)
	print "JSONResponseCode="; JSONResponseCode
End Function