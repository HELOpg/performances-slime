adc => Gain g => blackhole; 

SawOsc s => JCRev j => Gain gg => Gain gate => dac;

600 => s.freq;

0.0 => gate.gain;

function void re()
{
while(1)
{
g.last() * 0.8 => gg.gain;
1::samp => now;
}
}

spork ~ re();


Slime.s.send("/slime/app/feature1/1tox/length",0.0);

OscRecv oscin;
10000 => oscin.port;
oscin.listen();

function void OSCinput_shred()
{ 
    oscin.event("/slime/app/feature1/1tox/length , f") @=> OscEvent osc_data; 

    while ( true )
    { 
        osc_data => now; // wait for events to arrive.
<<< "/slime/app/feature1/1tox/length" >>>;
        // grab the next message from the queue. 
        while( osc_data.nextMsg() != 0 )
        {
	0.9 => gate.gain;
	osc_data.getFloat() * 1::ms => now;
	0.0 => gate.gain;
	}
    }       
}

spork ~ OSCinput_shred();

1::day => now;
