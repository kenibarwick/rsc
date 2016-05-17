'*************************************************************
'** Roku Sonos Channel 
'** by The Mobile Guy
'*************************************************************

sub Main()
    
	print "starting app"
	screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

	screen=preShowPlayScreen()
    if screen=invalid then
        print "unexpected error in preShowPlayScreen"
        return
    end if

    'set to go, time to get started
    showPlayScreen(screen)
	
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
