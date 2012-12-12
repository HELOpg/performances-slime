

public class slimeoscin{

Slime.s.send("/slime/time/beat/int",0.0);

OscRecv oscin;
10000 => oscin.port;
oscin.listen();

string ns;

function void OSCinput_shred(function fun)
{ 
  oscin.event("ns , i") @=> OscEvent osc_data; 
  while ( true )
  { 
	osc_data => now; // wait for events to arrive.
       	//grab the next message from the queue. 
        while( osc_data.nextMsg() != 0 )
               { 
		osc_data.getInt();        
		}
  }       
}

}