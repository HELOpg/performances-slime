Slime.s.send("/slime/app/woosh/length", 0.0);

Noise n => Envelope e => dac;

0.1 => n.gain;

OscRecv oscin;
10000 => oscin.port;
oscin.listen();

1 => int length;
1::ms => dur d;

function void OSCinput_shred()
{ 
    oscin.event("/slime/app/woosh/length , i") @=> OscEvent osc_data; 

    while ( true )
    { 
        osc_data => now; // wait for events to arrive.
	<<< "/slime/app/woosh/length" >>>;
        // grab the next message from the queue. 
        while( osc_data.nextMsg() != 0 )
        { 
	osc_data.getInt() => length;        
	
	length * 1::ms => d;
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








