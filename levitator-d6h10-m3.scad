include <levitator.scad>

magnet_h=10;
magnet_d=6;

screw=3; // M3 screw
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
tube_len=80; // tube length


screw_step=magnet_h+screw+clr_screw_step;

// screw_step=2*screw;

cylinder_faces=32;

holder_depth=15;
holder_width=60;
holder_height=14;
magnet_step=5;
magnet_height=holder_height/2;
holder_clearance=0.3;

// head
head_len=12;
inlet_h=4;
head_inlet_clr=0.1; // head inlet clearance
head_transition=0.5; // easier printing
tiph=-2; // from tip to cutoff inside cone
head_tip=3; // tip diameter

// tail
inlet_clr=0.15; // inlet clearance
wings=4;
wing_h1=4; // straignt height of the wing
wing_h2=15; // total wing height
wing_width=6;
wing_thick=tube_wall/2; // thickness
tail_transition=2;
holder_bar_h=4;

// stopper
stop_d=magnet_d-2*clr_magnet_d; // small d
stop_h=1.5;

levitation_h=26;

// moon artwork
moon_d1=2*levitation_h;
moon_d2=moon_d1;
moon_crescent=6;
moon_thick=7;
moon_angle=9;

if(0)
  head();
if(0)
  rocket_tube();
if(0)
  tail();
if(0)
  magnet_holder(upper=1,lower=0);
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
    translate([magnet_d,0,0])
    cube([magnet_d*2,tube_len,magnet_d*2],center=true);
}

