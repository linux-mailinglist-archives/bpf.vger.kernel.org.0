Return-Path: <bpf+bounces-79245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFBD317E2
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA72A30CD051
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCD123A98E;
	Fri, 16 Jan 2026 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHgwBM8/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C623ABA7
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568492; cv=none; b=aJBGvjpVTKwAHsn2TsTUKRO1vFkxFt6NCrFt+YcXsi2eu6WnnJfc2XDCyLVw90SXplxp2x+sDy6tfNElnxLA60AmV6kWuGaceJrKfwRO8fJFirzr34bJM1xi7jkuGHzFUp2sTH4RGcRxESx/99l1DwMK/hqGEXErjhRyLhS88BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568492; c=relaxed/simple;
	bh=XRjTUxYNDK1QUYfn1nXeV/KrPUZvcNIOBx8vo0NwT5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY6cO9IP5iWZFYanpun5tx5lWwmFoV1lcn0cR1MvZfc9RzukXCpRJ+kng/V13hGkvfyEJ4KHB2a3Zjiod6J/KkwlVmWOiJC4Hf94HEkyBwmn2evQ8BaFQVZ2HLcWzCg2cisv3fiXB8epl1WTO49/PrpqfPac8Crg2He0naScqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHgwBM8/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso4050331a12.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 05:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768568489; x=1769173289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xVOtXrAQ8qdzGSmcNavafMKsEpUAoDPiro8kRUhgdw=;
        b=aHgwBM8/ZPZAqG7IDOsk7ppYFYJkK/5IPl3xTu5HOqcBLU/Jdh3BhmBq+gLbsYeikf
         4JQonkjcPsFBPtfRkycRxqw/jNDEnJ/ftSrtt9J7FYzCCRZmD/SJk7YRFyQ8Z4jQNiaz
         ch0CUNHkQ64d36lciF9DpXjaOAUOIUlXvP68fnSpaQG/pjpUTScCcYYqnKcxcS95IEds
         a5j+SVXDlvGi+VgakYtjVzDvqks5fk+XRSBR0p8f8ke+rOvwT+LQtVqLTniKXXspYAvB
         1swTGwu2UKP5aKkZhqDkaqoa+qyWvNt0n/UBMZ0T3hr7pv+Xi9PAWq8UFfbTHE0Uj+I9
         uXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768568489; x=1769173289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xVOtXrAQ8qdzGSmcNavafMKsEpUAoDPiro8kRUhgdw=;
        b=kE2uD4s1u0FEi7cWrUUUELfYt2o7/nVOWMCaHYzje92iqQkvjP5rAd4l+tCYQzjpzm
         AU551/DrgO3p9oqZLD2IJSV3UZtVf0eJV2v7kflQFiBrWW5jSZ9x/ES+Wjbm+JDNShAx
         1Iff/kHiITlirjLpExXPAVHCpZJITLERAWk8xYWcWBuIIS7Lk8sjGiZB1nOE7g3aI+xA
         AuWj0cUts4mjWqzalxi07wcIcf5kFfkFole5y6zTDFa/6S3gdyGzCDywKyOpUqf6rhGM
         JgyIU4JVgFwl2FMEKcAuct11mApoHA7KyqrrdnCHq8BPoucUF/jkn+GEujCc5N0i3/WR
         jY6g==
X-Forwarded-Encrypted: i=1; AJvYcCXtb3MvL2tUJmnjCRXvsNdMWQnPDICfUoEKzSRcy0wOcfJxQYtHzB7fkzHbLOzMBTKNgHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzeZk4AlMoRy0n26LI9lWOJ+SubjV0cwByZKLsWujzVtxGrGaU
	/9ZveEnDlbxAgMhr74QKlwxdFmbrgXo4oSq/Na/Cj+vFOgXzmedSBKRMD0Avc3LlAh9mK97TfP1
	/o9FLDiFQc36mrzfFuyDTEsGJjoeajZo=
X-Gm-Gg: AY/fxX69HouH7XEIKuf849WmkWqUygJYALRQB8GGOKiUDUi3yjMz1vIH/4EQ7YfHNIg
	nrxQygQz9Mh78fB2DaENyLjcnqsH+n3YSb1teCwTeF3NMAz55g1j41Sq++JC2Sx+0laEgNfMxxq
	twT39UzWApF2lSRqQuTybr8aLsMjVqW+SjpeU+fISACnRzD1AcIGSx90kEGjzXCSgNHY2HNYZPS
	vJKFurGN/d0U0vx0uOgJEQ54IWxR0xjyoHpb/0i2xO89fDPeAN+RZ0phZN2kl83fmnrlK4=
X-Received: by 2002:a17:907:7201:b0:b72:70ad:b8f0 with SMTP id
 a640c23a62f3a-b8793244100mr266080766b.36.1768568485527; Fri, 16 Jan 2026
 05:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115151143.1344724-1-puranjay@kernel.org> <20260115151143.1344724-2-puranjay@kernel.org>
 <CAADnVQJLQ4hQTEKVPntpRe6=qsXQffno65OJjAG-H+Vw0i1Tzw@mail.gmail.com>
In-Reply-To: <CAADnVQJLQ4hQTEKVPntpRe6=qsXQffno65OJjAG-H+Vw0i1Tzw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 16 Jan 2026 14:01:14 +0100
X-Gm-Features: AZwV_QjWiW0OHJzA4CaqL71sNNi9WUBBljZ_B0PuZY8xOIgq22691s6KZ6r6sWc
Message-ID: <CANk7y0gSAyEhfkwKo7o5GoTUdxAHsi=RfsJdYpukOxaqikmtPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Preserve id of register in sync_linked_regs()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 4:09=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 15, 2026 at 7:11=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> > sync_linked_regs() copies the id of known_reg to reg when propagating
> > bounds of known_reg to reg using the off of known_reg, but when
> > known_reg was linked to reg like:
> >
> > known_reg =3D reg         ; both known_reg and reg get same id
> > known_reg +=3D 4          ; known_reg gets off =3D 4, and its id gets B=
PF_ADD_CONST
> >
> > now when a call to sync_linked_regs() happens, let's say with the follo=
wing:
> >
> > if known_reg >=3D 10 goto pc+2
> >
> > known_reg's new bounds are propagated to reg but now reg gets
> > BPF_ADD_CONST from the copy.
> >
> > This means if another link to reg is created like:
> >
> > another_reg =3D reg       ; another_reg should get the id of reg but
> >                           assign_scalar_id_before_mov() sees
> >                           BPF_ADD_CONST on reg and assigns a new id to =
it.
> >
> > As reg has a new id now, known_reg's link to reg is broken. If we find
> > new bounds for known_reg, they will not be propagated to reg.
> >
> > This can be seen in the selftest added in the next commit:
> >
> > 0: (85) call bpf_get_prandom_u32#7    ; R0=3Dscalar()
> > 1: (57) r0 &=3D 255                     ; R0=3Dscalar(smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff))
> > 2: (bf) r1 =3D r0                       ; R0=3Dscalar(id=3D1,smin=3Dsmi=
n32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff)) R1=3Dsca=
lar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D=
(0x0; 0xff))
> > 3: (07) r1 +=3D 4                       ; R1=3Dscalar(id=3D1+4,smin=3Du=
min=3Dsmin32=3Dumin32=3D4,smax=3Dumax=3Dsmax32=3Dumax32=3D259,var_off=3D(0x=
0; 0x1ff))
> > 4: (a5) if r1 < 0xa goto pc+4         ; R1=3Dscalar(id=3D1+4,smin=3Dumi=
n=3Dsmin32=3Dumin32=3D10,smax=3Dumax=3Dsmax32=3Dumax32=3D259,var_off=3D(0x0=
; 0x1ff))
> > 5: (bf) r2 =3D r0                       ; R0=3Dscalar(id=3D2,smin=3Dumi=
n=3Dsmin32=3Dumin32=3D6,smax=3Dumax=3Dsmax32=3Dumax32=3D255) R2=3Dscalar(id=
=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D6,smax=3Dumax=3Dsmax32=3Dumax32=3D255)
> > 6: (a5) if r1 < 0xe goto pc+2         ; R1=3Dscalar(id=3D1+4,smin=3Dumi=
n=3Dsmin32=3Dumin32=3D14,smax=3Dumax=3Dsmax32=3Dumax32=3D259,var_off=3D(0x0=
; 0x1ff))
> > 7: (35) if r0 >=3D 0xa goto pc+1        ; R0=3Dscalar(id=3D2,smin=3Dumi=
n=3Dsmin32=3Dumin32=3D6,smax=3Dumax=3Dsmax32=3Dumax32=3D9,var_off=3D(0x0; 0=
xf))
> > 8: (37) r0 /=3D 0
> > div by zero
> >
> > When 4 is verified, r1's bounds are propagated to r0 but r0 also gets
> > BPF_ADD_CONST (bug).
> > When 5 is verified, r0 gets a new id (2) and its link with r1 is broken=
.
> >
> > After 6 we know r1 has bounds [14, 259] and therefore r0 should have
> > bounds [10, 255], therefore the branch at 7 is always taken. But becaus=
e
> > r0's id was changed to 2, r1's new bounds are not propagated to r0.
> > The verifier still thinks r0 has bounds [6, 255] before 7 and execution
> > can reach div by zero.
> >
> > Fix this by preserving id in sync_linked_regs() like off and subreg_def=
.
> >
> > Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7a375f608263..9de0ec0c3ed9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16871,6 +16871,7 @@ static void sync_linked_regs(struct bpf_verifie=
r_state *vstate, struct bpf_reg_s
> >                 } else {
> >                         s32 saved_subreg_def =3D reg->subreg_def;
> >                         s32 saved_off =3D reg->off;
> > +                       u32 saved_id =3D reg->id;
> >
> >                         fake_reg.type =3D SCALAR_VALUE;
> >                         __mark_reg_known(&fake_reg, (s32)reg->off - (s3=
2)known_reg->off);
> > @@ -16878,10 +16879,11 @@ static void sync_linked_regs(struct bpf_verif=
ier_state *vstate, struct bpf_reg_s
> >                         /* reg =3D known_reg; reg +=3D delta */
> >                         copy_register_state(reg, known_reg);
> >                         /*
> > -                        * Must preserve off, id and add_const flag,
> > +                        * Must preserve off, id and subreg_def flag,
> >                          * otherwise another sync_linked_regs() will be=
 incorrect.
> >                          */
> >                         reg->off =3D saved_off;
> > +                       reg->id =3D saved_id;
>
> What is the veristat difference for meta/scx ?
>
> I don't trust CI at the moment:
>
> 026-01-16T01:26:34.7163235Z Failed to open 'c-scheds_lib_sdt_task.bpf.o':=
 -2
> 2026-01-16T01:26:34.7240161Z Failed to open
> 'c-scheds_scheds_c_scx_sdt.bpf.o': -2
> 2026-01-16T01:26:34.7298286Z Failed to open
> 'rust-scheds_scx_arena-9355999175dda454_out_arena.bpf.o': -2
> 2026-01-16T01:26:34.7353438Z Failed to open
> 'rust-scheds_scx_arena-9355999175dda454_out_atq.bpf.o': -2
> 2026-01-16T01:26:34.7414081Z Failed to open
> 'rust-scheds_scx_arena-9355999175dda454_out_bitmap.bpf.o': -2
> ...
>
> 2026-01-16T01:27:52.3087135Z # No changes in verification performance
>
> something fishy.


I don't see any change in veristat output:

../../../veristat/src/veristat -C -e file,prog,states,insns -f
"insns_pct>0" fb_before.csv fb_after.csv
File  Program  States (A)  States (B)  States (DIFF)  Insns (A)  Insns
(B)  Insns (DIFF)
----  -------  ----------  ----------  -------------  ---------
---------  ------------


../../../veristat/src/veristat -C -e file,prog,states,insns -f
"insns_pct>0" scx_before.csv scx_after.csv
File  Program  States (A)  States (B)  States (DIFF)  Insns (A)  Insns
(B)  Insns (DIFF)
----  -------  ----------  ----------  -------------  ---------
---------  ------------

