Slime.s.send("/slime/app/bells/0to1/gain",0.0);

JCRev r => dac;

function void shake(float f){
Shakers s => r;
        0.9 => s.energy;
        100 => s.objects;
        300 => s.freq;
        0.9 => s.decay;
	7 => s.preset;

0.7 => s.noteOn;
100::ms => now;
0.0 => s.noteOff;
}

shake(0.7);

OscRecv oscin;
10000 => oscin.port;
oscin.listen();

function void OSCinput_shred()
{ 
    oscin.event("/slime/app/bells/0to1/gain , f") @=> OscEvent osc_data; 

    while ( true )
    { 
        osc_data => now; // wait for events to arrive.
<<< "/slime/app/bells/0to1/gain" >>>;
        // grab the next message from the queue. 
        while( osc_data.nextMsg() != 0 )
        { 
        <<< osc_data.getFloat() >>>;
        spork ~ shake(osc_data.getFloat());
	}
    }       
}

spork ~ OSCinput_shred();

1::day => now;
