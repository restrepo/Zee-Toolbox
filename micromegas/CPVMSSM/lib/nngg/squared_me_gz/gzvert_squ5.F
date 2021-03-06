* gzvert_squ5.F
* form factors for {MNE1, MNE1} -> {0, MZ}
* generated by FormCalc 12 Apr 2013 17:41

	subroutine gzvert_squ5
	implicit none

#include "gzvars.h"

	double complex dup1528, dup1529, dup1530

        dup1528 = -(MTR051(squ5)*MTR079(squ5)) + 
     -   MTR046(squ5)*MTR082(squ5)

        dup1529 = -(MTR051(squ5)*MTR255(squ5)) + 
     -   MTR046(squ5)*MTR265(squ5)

        dup1530 = MTR082(squ5)*
     -    (-(MTR191(1,1)*MTR255(squ5)) - MTR192(1,1)*MTR255(squ5))+
     -     MTR079(squ5)*MTR191(1,1)*MTR265(squ5) + 
     -   MTR079(squ5)*MTR192(1,1)*MTR265(squ5)

        Cloop(1) = Cloop(1) + 
     -   (-(1/(144.D0*Pi**2)*
     -         (AbbSum72*dup1530*MNE1*B1(S,squMass(squ5)**2,sqvMass(squ5)**2))) + 
     -      B0(S,squMass(squ5)**2,sqvMass(squ5)**2)*
     -       (-(1/(288.D0*Pi**2)*(AbbSum72*dup1530*MNE1)) + 
     -         cI/(96.D0*Pi**2)*(Abb5*dup1529*MTR181(1,1)) + 
     -         cI/(96.D0*Pi**2)*(Abb7*dup1529*MTR182(1,1))) + 
     -      (Cval(cc00,iint60(squ5)) + Cval(cc00,iint61(squ5)))*
     -       (-(cI/(48.D0*Pi**2)*(Abb5*dup1528*EE*MTR181(1,1))) - 
     -         cI/(48.D0*Pi**2)*(Abb7*dup1528*EE*MTR182(1,1))) + 
     -      (Cval(cc12,iint60(squ5)) + Cval(cc12,iint61(squ5)))*
     -       (cI/(48.D0*Pi**2)*(AbbSum30*dup1528*EE*MTR181(1,1)) + 
     -         cI/(48.D0*Pi**2)*(AbbSum31*dup1528*EE*MTR182(1,1))) + 
     -      Cval(cc00,iint59(squ5))*
     -       (1/(12.D0*Pi**2)*
     -          (Abb5*EE*MTR045(squ5)*MTR078(squ5)*MTR181(1,1)) + 
     -         1/(12.D0*Pi**2)*
     -          (Abb7*EE*MTR045(squ5)*MTR078(squ5)*MTR182(1,1))) + 
     -      Cval(cc12,iint59(squ5))*
     -       (-(1/(12.D0*Pi**2)*
     -            (AbbSum30*EE*MTR045(squ5)*MTR078(squ5)*
     -              MTR181(1,1))) - 
     -         1/(12.D0*Pi**2)*
     -          (AbbSum31*EE*MTR045(squ5)*MTR078(squ5)*MTR182(1,1))
     -         ) + 1/(144.D0*Pi**2)*
     -       (AbbSum72*MNE1*B1(S,squMass(squ5)**2,squMass(squ5)**2)*MTR078(squ5)*
     -         (MTR191(1,1) + MTR192(1,1))*MTR251(squ5)) + 
     -      B0(S,squMass(squ5)**2,squMass(squ5)**2)*
     -       (-(1/(48.D0*Pi**2)*
     -            (Abb5*MTR045(squ5)*MTR181(1,1)*MTR251(squ5))) - 
     -         1/(48.D0*Pi**2)*
     -          (Abb7*MTR045(squ5)*MTR182(1,1)*MTR251(squ5)) + 
     -         AbbSum72*MNE1*
     -          (1/(288.D0*Pi**2)*MTR191(1,1) + 
     -            1/(288.D0*Pi**2)*MTR192(1,1))*MTR078(squ5)*
     -          MTR251(squ5)))/(-MZ2 + S)

#ifdef DEBUG
	DEB 'vert_squ5: Cloop(1) =', Cloop(1)
#endif

	end

