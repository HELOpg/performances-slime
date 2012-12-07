
public class SlimeBells{

JCRev r => dac;

       function void shake(float f){
       Shakers s => r;
       0.9 => s.energy;
       100 => s.objects;
       300 => s.freq;
       0.7 => s.decay;
       7 => s.preset;
       f => s.noteOn;
       100::ms => now;
       0.0 => s.noteOff;
       }

       function void rev(float f){
       f => r.mix;
       }

       function string info()
       {
	return "This is SlimeBells functions -> shake(velocity as float 0-1), rev(reverb mix as float 0-1)";
       }
}