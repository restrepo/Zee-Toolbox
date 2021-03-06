* vert_cha5_hia5.F
* form factors for {MNE1, MNE1} -> {0, 0}
* generated by FormCalc 25 Oct 2014 23:21

	subroutine vert_cha5_hia5
	implicit none

#include "vars.h"

	double complex dup1163

	dup1163 = MTR057(cha5,cha5,hia5) - MTR058(cha5,cha5,hia5)

        Cloop(1) = Cloop(1) + 
     -   (-(1/(16.D0*Pi**2)*((-Abb5 + Abb7)*dup1163*AAABR(1896)*
     -           B0(S,chaMass(cha5)**2,chaMass(cha5)**2)*chaMass(cha5)*
     -           MTR111(1,1,hia5))) + 
     -      1/(4.D0*Pi**2)*((-Abb5 + Abb7)*dup1163*AAABR(1896)*
     -         chaMass(cha5)*Cval(cc00,iint16(cha5))*
     -         MTR111(1,1,hia5)) - 
     -      1/(4.D0*Pi**2)*((-AbbSum30 + AbbSum31)*dup1163*
     -         AAABR(1896)*chaMass(cha5)*Cval(cc12,iint16(cha5))*
     -         MTR111(1,1,hia5)) + 
     -      Cval(cc0,iint16(cha5))*
     -       (-(1/(16.D0*Pi**2)*
     -            ((-Abb5 + Abb7)*dup1163*MNE1**2*AAABR(1896)*
     -              chaMass(cha5)*MTR111(1,1,hia5))) - 
     -         1/(32.D0*Pi**2)*
     -          ((Abb5 - Abb7)*dup1163*(2*MNE1**2 - S)*AAABR(1896)*
     -            chaMass(cha5)*MTR111(1,1,hia5)) + 
     -         1/(16.D0*Pi**2)*
     -          ((-AbbSum21 + AbbSum29)*AAABR(1896)*chaMass(cha5)*
     -            MTR057(cha5,cha5,hia5)*MTR111(1,1,hia5)) - 
     -         1/(16.D0*Pi**2)*
     -          ((-AbbSum20 + AbbSum28)*AAABR(1896)*chaMass(cha5)*
     -            MTR058(cha5,cha5,hia5)*MTR111(1,1,hia5))))/
     -    (S - hiaMass(hia5)**2+(0D0,1D0)*hiaMass(hia5)*hiaW(hia5))

#ifdef DEBUG
	DEB 'vert_cha5_hia5: Cloop(1) =', Cloop(1)
#endif

	end

