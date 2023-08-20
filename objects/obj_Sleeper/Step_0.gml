if(isGoingToSleep == false && isSleeping == false && isDragging == false)
if(--generateDestPosCd <= 0) {
	MyCheckAndGenerateDestPos();
}

if(myPathDestX != undefined && myPathDestY != undefined) {
	if(floor(x) == floor(myPathDestX) && floor(y) == floor(myPathDestY)) {
		MyPathStop();
		
		if(isGoingToSleep) {
			isGoingToSleep = false;
			MySleepOnBed(sleepBedIns);
		}
	}
}
