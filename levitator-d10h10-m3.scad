include <levitator.scad>

magnet_h=10;
magnet_d=10;

screw=3; // M3 screw
use_screws=0; // 0-disable screws, 1-enable screws
screw_plastic=2.2; // plastic hole dia
screw_plastic_tight=screw_plastic*0.82; // tight
// echo(screw_plastic_tight);
screw_plastic_loose=screw_plastic*1.1;
screw_plastic_head=screw_plastic*2.2;
screw_plastic_transition=1.5; // cone for easier printing
screw_plastic_under=3; // not counting transition

clr_magnet_d=0.5; // diameter clearance
clr_magnet_h=0.2; // length clearance
clr_screw_hole=0.2; // hole bit bigger
clr_screw_step=1; // screw spacing clearance

tube_wall=1.5; // wall thickness
tube_len=120; // tube length (120 works)


screw_step=magnet_h+screw+clr_screw_step;

// screw_step=2*screw;

cylinder_faces=32;

holder_depth=15;
// holder_width=72; // should be calculated from magnet_last and screw size
holder_height=14;
holder_thinner=0.5; // factor that makes middle bar thinner
magnet_first=[25,20]; // tail,head
magnet_last=magnet_first; // tail,head
magnet_n=[1,1]; // tail,head
// magnet_step=5; // obsolete
magnet_height=holder_height/2;
holder_clearance=use_screws > 0.5 ? 0.3 : 0;

// head

head_len=15;
inlet_h=5;
head_inlet_clr=0.1; // head inlet clearance
head_transition=0.5; // easier printing
tiph=-2; // from tip to cutoff inside cone
head_tip=4; // tip diameter

// tail

tail_inlet_clr=0.15; // inlet clearance
wings=4;
wing_h1=7; // straignt height of the wing
wing_h2=25; // total wing height
wing_width=10;
wing_thick=tube_wall/2; // thickness
tail_transition=2;
holder_bar_h=4;

// stopper
stop_d=magnet_d-2*clr_magnet_d; // small d
stop_h=1.5;

levitation_h=37;

// moon artwork
moon_d1=80;
moon_d2=78;
moon_crescent=10;
moon_thick=8;
moon_angle=9;
moon_clr_screw_hole=0.2; // hole bit bigger

if(0)
  head();
if(0)
  rocket_tube();
if(0)
  tail();
if(0)
  printable_holders();
if(0)
  moon();

// cross section
if(1)
    // translate([0,0,55])
difference()
{
    // magnet_holder();
    // head();
    // tail();
    full_assembly();
    if(1)
    translate([100,0,0])
    cube([200,tube_len,magnet_d*2],center=true);
}

