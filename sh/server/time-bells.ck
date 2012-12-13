Slime.s.send("/slime/time/beat/int",0.0);

JCRev r => dac;

function void shake(float f){
Shakers s => r;
        0.9 => s.energy;
        100 => s.objects;
        300 => s.freq;
        0.6 => s.decay;
	7 => s.preset;

0.7 => s.noteOn;
100::ms => now;
0.0 => s.noteOff;
}

shake(0.7);

OscRecv oscin;
10000 => oscin.port;
oscin.listen();

1 => int beat;

function void OSCinput_shred()
{ 
    oscin.event("/slime/time/beat/int , i") @=> OscEvent osc_data; 

    while ( true )
    { 
        osc_data => now; // wait for events to arrive.
<<< "/slime/time/beat/int" >>>;
        // grab the next message from the queue. 
        while( osc_data.nextMsg() != 0 )
        { 
	osc_data.getInt() => beat;        
	<<< osc_data.getInt() >>>;
	<<< beat >>>;
	if (beat == 1){ 
        	spork ~ shake(0.7);
		}
	if (beat == 3){ 
           spork ~ shake(0.2);
	   }
	}
    }       
}

spork ~ OSCinput_shred();

1::day => now;
