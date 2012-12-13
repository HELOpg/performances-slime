Slime.s.send("/slime/app/blip/freq/0-1", 0.0);
Slime.s.send("/slime/app/blip/lengthms/0-x", 100.);
SawOsc n => Gain g => Envelope e => Envelope ee => dac;

0.1 => n.gain;

250 => float notelength;

OscRecv oscin;
10000 => oscin.port;
oscin.listen();

1. => float fff;
1000::ms => dur d;

function void OSCinput_shred()
{ 
    oscin.event("/slime/app/blip/freq/0-1 , f") @=> OscEvent osc_data; 

    while ( true )
    { 
        osc_data => now; // wait for events to arrive.
	<<< "/slime/app/blip/freq/0-1" >>>;
        // grab the next message from the queue. 
        while( osc_data.nextMsg() != 0 )
        { 
	osc_data.getFloat() => fff;
	fff * 100 + 300 => n.freq;
		0.9 => ee.target;
                1 => ee.keyOn;
                notelength * 1::ms => now;
		0.0 => ee.target;
                0 => ee.keyOn;
		notelength * 1::ms  => now;
	}
    }       
}


function void OSCinputlength_shred()
{ 
    oscin.event("/slime/app/blip/lengthms/0-x , f") @=> OscEvent osc_data;

    while ( true )
    {
        osc_data => now; // wait for events to arrive.
	// grab the next message from the queue.
        while( osc_data.nextMsg() != 0 )
        	{
        		osc_data.getFloat() => notelength;
		}
	}
}

function void wobble()
{	 
	10::ms => e.duration => ee.duration;
	while(1){
		0.9 => e.target;
		1 => e.keyOn;
		10::ms => now;
		0.0 => e.target;
		0 => e.keyOn;
		10::ms => now;
	}
}
spork ~ wobble();

spork ~ OSCinput_shred();

spork ~ OSCinputlength_shred();

1::day => now;
