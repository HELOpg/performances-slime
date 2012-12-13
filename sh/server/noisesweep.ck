Slime.s.send("/slime/app/woosh/fire/0-1", 0.0);

Noise n => Gain g => Envelope e => dac;

0.3 => n.gain;

OscRecv oscin;
10000 => oscin.port;
oscin.listen();

1. => float fff;
1000::ms => dur d;

function void OSCinput_shred()
{ 
    oscin.event("/slime/app/woosh/fire , f") @=> OscEvent osc_data; 

    while ( true )
    { 
        osc_data => now; // wait for events to arrive.
	<<< "/slime/app/woosh/fire" >>>;
        // grab the next message from the queue. 
        while( osc_data.nextMsg() != 0 )
        { 
	osc_data.getFloat() => fff;
	fff => g.gain;        
	//<<< length >>>;
	//length * 1::ms => d;
	d => e.duration;
	0.9 => e.target;
	1 => e.keyOn;
	d => now;
	0.0 => e.target;
	0 => e.keyOn;
	d => now;
	10::ms => now;
	}
    }       
}

spork ~ OSCinput_shred();

1::day => now;








