Return-Path: <bpf+bounces-17631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87B8106FE
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 01:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F4D1F21014
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D1A50;
	Wed, 13 Dec 2023 00:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw4SI5Gu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4FD99;
	Tue, 12 Dec 2023 16:51:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a22deb95d21so209129766b.3;
        Tue, 12 Dec 2023 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702428682; x=1703033482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Fn4dIieffXe82QLNlOEsFLE86XtEp23WlsGE5l8aYI=;
        b=Kw4SI5GuWzh1VnW5wVYf/f/h4SpCwzEgnJxoY2Gye10ZT4ncQdRApcZkWV7xJbDIIU
         pCtckCO1WTVik5dIp3cP0bQWnVPM9MCZOp14Cnlt1iAJVFJTRwf91Uxxxm7/sVjpU2+F
         TtlkkFK5yqjv2T5FUXc9uFceKpc07/tgZ2d2cUd7kzE4rxgFF4xKuarxh57JtZPL5EGv
         aii9ykIQUc/EtM+Da6lt+MsngvuZy8KKJe4onZP+qeT/l/vdMBW3eExSjuQLFt3/bGWi
         RKrz2vLZxDRKbSnQw2ysjtOJAkLm1zFyXhaTCZzciZbl94RTG1EuIPh7j1in9DUqfEC4
         JqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702428682; x=1703033482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Fn4dIieffXe82QLNlOEsFLE86XtEp23WlsGE5l8aYI=;
        b=H3qQy6l/JecBTv3YuZ8uxI8/dh9DfABx6SaOoM0mkSLF31wryoH7hxoSf95uNwmWLu
         RnkNT0AOHIGoWBLOdVfTze1M94EP/vW1PPiH3uPuLQuEp4TZVYnvsmpf5jJfXw3zMGIL
         OVlk1j1ykt2MjWTo6lnrF7R+vI5aKBfmatczFTu0QQaWuMdQIUdVGHGRjz8KBH5V4Lfx
         /yeXcR96bdBK9BsMsPIJJKqOAl4C9onA6ONUtz/k4fnnfQ3hm2jDpAWtW8z0Qru7RBW+
         p8aa+c4rVyXdc8PWG9MNaNNssRLAm81DG7NRWYUv7WMD6M0K4GhhxIBnyRz03L2u0z1d
         bvsg==
X-Gm-Message-State: AOJu0YwoN8NGTOpVn3YC8Nk5H0WKzOirhPZU87hO8o5Ip0p57VMPkvg4
	2FbsEKppQTW/G3lnoagmdn3z7XKH3+7qgsjvd7KWcZRF4nw=
X-Google-Smtp-Source: AGHT+IHl2jtvOwzlrdeIC6yqzwyXZjjfFHtJ0qILCq6p+swNVxfgwBa8pUXB0GGoYCrPgksc6z/BG/d54SYqGC2AppE=
X-Received: by 2002:a17:906:181:b0:9ff:7164:c20a with SMTP id
 1-20020a170906018100b009ff7164c20amr3347154ejb.21.1702428681549; Tue, 12 Dec
 2023 16:51:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
In-Reply-To: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Dec 2023 16:51:09 -0800
Message-ID: <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
To: Hao Sun <sunhao.th@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 7:31=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrote=
:
>
> Hi,
>
> The verifier incorrectly prunes a path expected to be executed at
> runtime. In the following program, the execution path is:
>     from 6 to 8 (taken) -> from 11 to 15 (taken) -> from 18 to 22
> (taken) -> from 26 to 27 (fall-through) -> from 29 to 30
> (fall-through)
> The verifier prunes the checking path at #26, skipping the actual
> execution path.
>
>    0: (18) r2 =3D 0x1a000000be
>    2: (bf) r5 =3D r1
>    3: (bf) r8 =3D r2
>    4: (bc) w4 =3D w5
>    5: (85) call bpf_get_current_cgroup_id#680112
>    6: (36) if w8 >=3D 0x69 goto pc+1
>    7: (95) exit
>    8: (18) r4 =3D 0x52
>   10: (84) w4 =3D -w4
>   11: (45) if r0 & 0xfffffffe goto pc+3
>   12: (1f) r8 -=3D r4
>   13: (0f) r0 +=3D r0
>   14: (2f) r4 *=3D r4
>   15: (18) r3 =3D 0x1f00000034
>   17: (c4) w4 s>>=3D 29
>   18: (56) if w8 !=3D 0xf goto pc+3
>   19: r3 =3D bswap32 r3
>   20: (18) r2 =3D 0x1c
>   22: (67) r4 <<=3D 2
>   23: (bf) r5 =3D r8
>   24: (18) r2 =3D 0x4
>   26: (7e) if w8 s>=3D w0 goto pc+5
>   27: (4f) r8 |=3D r8
>   28: (0f) r8 +=3D r8
>   29: (d6) if w5 s<=3D 0x1d goto pc+2
>   30: (18) r0 =3D 0x4 ; incorrectly pruned here



>   32: (95) exit
>
> -------- Verifier Log --------
> func#0 @0
> 0: R1=3Dctx() R10=3Dfp0
> 0: (18) r2 =3D 0x1a000000be             ; R2_w=3D0x1a000000be
> 2: (bf) r5 =3D r1                       ; R1=3Dctx() R5_w=3Dctx()
> 3: (bf) r8 =3D r2                       ; R2_w=3D0x1a000000be R8_w=3D0x1a=
000000be
> 4: (bc) w4 =3D w5                       ;
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfffffff=
f))
> R5_w=3Dctx()
> 5: (85) call bpf_get_current_cgroup_id#80     ; R0_w=3Dscalar()
> 6: (36) if w8 >=3D 0x69 goto pc+1
> mark_precise: frame0: last_idx 6 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=3Dr8 stack=3D before 5: (85) call
> bpf_get_current_cgroup_id#80
> mark_precise: frame0: regs=3Dr8 stack=3D before 4: (bc) w4 =3D w5
> mark_precise: frame0: regs=3Dr8 stack=3D before 3: (bf) r8 =3D r2
> mark_precise: frame0: regs=3Dr2 stack=3D before 2: (bf) r5 =3D r1
> mark_precise: frame0: regs=3Dr2 stack=3D before 0: (18) r2 =3D 0x1a000000=
be
> 6: R8_w=3D0x1a000000be
> 8: (18) r4 =3D 0x52                     ; R4_w=3D82
> 10: (84) w4 =3D -w4                     ; R4=3Dscalar()
> 11: (45) if r0 & 0xfffffffe goto pc+3         ;
> R0=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=
=3D(0x0; 0x1))
> 12: (1f) r8 -=3D r4                     ; R4=3Dscalar() R8_w=3Dscalar()
> 13: (0f) r0 +=3D r0                     ;
> R0_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var_off=
=3D(0x0;
> 0x3))
> 14: (2f) r4 *=3D r4                     ; R4_w=3Dscalar()
> 15: (18) r3 =3D 0x1f00000034            ; R3_w=3D0x1f00000034
> 17: (c4) w4 s>>=3D 29                   ;
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,va=
r_off=3D(0x0;
> 0xffffffff))
> 18: (56) if w8 !=3D 0xf goto pc+3       ;
> R8_w=3Dscalar(smin=3D0x800000000000000f,smax=3D0x7fffffff0000000f,umin=3D=
smin32=3Dumin32=3D15,umax=3D0xffffffff0000000f,smax32=3Dumax32=3D15,var_off=
=3D(0xf;
> 0xffffffff00000000))
> 19: (d7) r3 =3D bswap32 r3              ; R3_w=3Dscalar()
> 20: (18) r2 =3D 0x1c                    ; R2=3D28
> 22: (67) r4 <<=3D 2                     ;
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0x3fffffffc,smax32=3D0x7ffffffc,umax=
32=3D0xfffffffc,var_off=3D(0x0;
> 0x3fffffffc))
> 23: (bf) r5 =3D r8                      ;
> R5_w=3Dscalar(id=3D1,smin=3D0x800000000000000f,smax=3D0x7fffffff0000000f,=
umin=3Dsmin32=3Dumin32=3D15,umax=3D0xffffffff0000000f,smax32=3Dumax32=3D15,=
var_off=3D(0xf;
> 0xffffffff00000000))
> R8=3Dscalar(id=3D1,smin=3D0x800000000000000f,smax=3D0x7fffffff0000000f,um=
in=3Dsmin32=3Dumin32=3D15,umax=3D0xffffffff0000000f,smax32=3Dumax32=3D15,va=
r_off=3D(0xf;
> 0xffffffff00000000))
> 24: (18) r2 =3D 0x4                     ; R2_w=3D4
> 26: (7e) if w8 s>=3D w0 goto pc+5

so here w8=3D15 and w0=3D[0,2], always taken, right?

> mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
> mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D 0x4
> mark_precise: frame0: regs=3Dr5,r8 stack=3D before 23: (bf) r5 =3D r8
> mark_precise: frame0: regs=3Dr8 stack=3D before 22: (67) r4 <<=3D 2
> mark_precise: frame0: parent state regs=3Dr8 stack=3D:
> R0_rw=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var_of=
f=3D(0x0;
> 0x3)) R2_w=3D28 R3_w=3Dscalar()
> R4_rw=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,v=
ar_off=3D(0x0;
> 0xffffffff)) R8_rw=3DPscalar(smin=3D0x800000000000000f,smax=3D0x7fffffff0=
000000f,umin=3Dsmin32=3Dumin32=3D15,umax=3D0xffffffff0000000f,smax32=3Dumax=
32=3D15,var_off=3D(0xf;
> 0xffffffff00000000)) R10=3Dfp0
> mark_precise: frame0: last_idx 20 first_idx 11 subseq_idx 22
> mark_precise: frame0: regs=3Dr8 stack=3D before 20: (18) r2 =3D 0x1c
> mark_precise: frame0: regs=3Dr8 stack=3D before 19: (d7) r3 =3D bswap32 r=
3
> mark_precise: frame0: regs=3Dr8 stack=3D before 18: (56) if w8 !=3D 0xf g=
oto pc+3
> mark_precise: frame0: regs=3Dr8 stack=3D before 17: (c4) w4 s>>=3D 29
> mark_precise: frame0: regs=3Dr8 stack=3D before 15: (18) r3 =3D 0x1f00000=
034
> mark_precise: frame0: regs=3Dr8 stack=3D before 14: (2f) r4 *=3D r4
> mark_precise: frame0: regs=3Dr8 stack=3D before 13: (0f) r0 +=3D r0
> mark_precise: frame0: regs=3Dr8 stack=3D before 12: (1f) r8 -=3D r4
> mark_precise: frame0: regs=3Dr4,r8 stack=3D before 11: (45) if r0 &
> 0xfffffffe goto pc+3
> mark_precise: frame0: parent state regs=3Dr4,r8 stack=3D:  R0_rw=3Dscalar=
()
> R4_rw=3DPscalar() R8_rw=3DP0x1a000000be R10=3Dfp0
> mark_precise: frame0: last_idx 10 first_idx 0 subseq_idx 11
> mark_precise: frame0: regs=3Dr4,r8 stack=3D before 10: (84) w4 =3D -w4
> mark_precise: frame0: regs=3Dr4,r8 stack=3D before 8: (18) r4 =3D 0x52
> mark_precise: frame0: regs=3Dr8 stack=3D before 6: (36) if w8 >=3D 0x69 g=
oto pc+1
> mark_precise: frame0: regs=3Dr8 stack=3D before 5: (85) call
> bpf_get_current_cgroup_id#80
> mark_precise: frame0: regs=3Dr8 stack=3D before 4: (bc) w4 =3D w5
> mark_precise: frame0: regs=3Dr8 stack=3D before 3: (bf) r8 =3D r2
> mark_precise: frame0: regs=3Dr2 stack=3D before 2: (bf) r5 =3D r1
> mark_precise: frame0: regs=3Dr2 stack=3D before 0: (18) r2 =3D 0x1a000000=
be
> mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
> mark_precise: frame0: regs=3Dr0 stack=3D before 24: (18) r2 =3D 0x4
> mark_precise: frame0: regs=3Dr0 stack=3D before 23: (bf) r5 =3D r8
> mark_precise: frame0: regs=3Dr0 stack=3D before 22: (67) r4 <<=3D 2
> mark_precise: frame0: parent state regs=3Dr0 stack=3D:
> R0_rw=3DPscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var_o=
ff=3D(0x0;
> 0x3)) R2_w=3D28 R3_w=3Dscalar()
> R4_rw=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,v=
ar_off=3D(0x0;
> 0xffffffff)) R8_rw=3DPscalar(smin=3D0x800000000000000f,smax=3D0x7fffffff0=
000000f,umin=3Dsmin32=3Dumin32=3D15,umax=3D0xffffffff0000000f,smax32=3Dumax=
32=3D15,var_off=3D(0xf;
> 0xffffffff00000000)) R10=3Dfp0
> mark_precise: frame0: last_idx 20 first_idx 11 subseq_idx 22
> mark_precise: frame0: regs=3Dr0 stack=3D before 20: (18) r2 =3D 0x1c
> mark_precise: frame0: regs=3Dr0 stack=3D before 19: (d7) r3 =3D bswap32 r=
3
> mark_precise: frame0: regs=3Dr0 stack=3D before 18: (56) if w8 !=3D 0xf g=
oto pc+3
> mark_precise: frame0: regs=3Dr0 stack=3D before 17: (c4) w4 s>>=3D 29
> mark_precise: frame0: regs=3Dr0 stack=3D before 15: (18) r3 =3D 0x1f00000=
034
> mark_precise: frame0: regs=3Dr0 stack=3D before 14: (2f) r4 *=3D r4
> mark_precise: frame0: regs=3Dr0 stack=3D before 13: (0f) r0 +=3D r0
> mark_precise: frame0: regs=3Dr0 stack=3D before 12: (1f) r8 -=3D r4
> mark_precise: frame0: regs=3Dr0 stack=3D before 11: (45) if r0 &
> 0xfffffffe goto pc+3
> mark_precise: frame0: parent state regs=3Dr0 stack=3D:  R0_rw=3DPscalar()
> R4_rw=3DPscalar() R8_rw=3DP0x1a000000be R10=3Dfp0
> mark_precise: frame0: last_idx 10 first_idx 0 subseq_idx 11
> mark_precise: frame0: regs=3Dr0 stack=3D before 10: (84) w4 =3D -w4
> mark_precise: frame0: regs=3Dr0 stack=3D before 8: (18) r4 =3D 0x52
> mark_precise: frame0: regs=3Dr0 stack=3D before 6: (36) if w8 >=3D 0x69 g=
oto pc+1
> mark_precise: frame0: regs=3Dr0 stack=3D before 5: (85) call
> bpf_get_current_cgroup_id#80
> 26: R0=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var_o=
ff=3D(0x0;
> 0x3)) R8=3Dscalar(id=3D1,smin=3D0x800000000000000f,smax=3D0x7fffffff00000=
00f,umin=3Dsmin32=3Dumin32=3D15,umax=3D0xffffffff0000000f,smax32=3Dumax32=
=3D15,var_off=3D(0xf;
> 0xffffffff00000000))
> 32: (95) exit
>
> from 18 to 22: R0_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Duma=
x32=3D2,var_off=3D(0x0;
> 0x3)) R3_w=3D0x1f00000034
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,va=
r_off=3D(0x0;
> 0xffffffff)) R8_w=3Dscalar() R10=3Dfp0
> 22: R0_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var=
_off=3D(0x0;
> 0x3)) R3_w=3D0x1f00000034
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,va=
r_off=3D(0x0;
> 0xffffffff)) R8_w=3Dscalar() R10=3Dfp0
> 22: (67) r4 <<=3D 2                     ;
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0x3fffffffc,smax32=3D0x7ffffffc,umax=
32=3D0xfffffffc,var_off=3D(0x0;
> 0x3fffffffc))
> 23: (bf) r5 =3D r8                      ; R5_w=3Dscalar(id=3D2) R8_w=3Dsc=
alar(id=3D2)
> 24: (18) r2 =3D 0x4                     ; R2=3D4
> 26: (7e) if w8 s>=3D w0 goto pc+5       ;
> R0=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var_off=
=3D(0x0; 0x3))
> R8=3Dscalar(id=3D2,smax32=3D1)

we didn't prune here, assuming w8 < w0, so w8=3Dw5 is at most 1 (because
r0 is [0, 2])

> 27: (4f) r8 |=3D r8                     ; R8_w=3Dscalar()

here r5 and r8 are disassociated

> 28: (0f) r8 +=3D r8                     ; R8_w=3Dscalar()
> 29: (d6) if w5 s<=3D 0x1d goto pc+2

w5 is at most 1 (signed), so this is always true, so we just to exit,
30: is still never visited

> mark_precise: frame0: last_idx 29 first_idx 26 subseq_idx -1
> mark_precise: frame0: regs=3Dr5 stack=3D before 28: (0f) r8 +=3D r8
> mark_precise: frame0: regs=3Dr5 stack=3D before 27: (4f) r8 |=3D r8
> mark_precise: frame0: regs=3Dr5 stack=3D before 26: (7e) if w8 s>=3D w0 g=
oto pc+5
> mark_precise: frame0: parent state regs=3Dr5 stack=3D:
> R0_rw=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var_of=
f=3D(0x0;
> 0x3)) R2_w=3D4 R3_w=3D0x1f00000034
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0x3fffffffc,smax32=3D0x7ffffffc,umax=
32=3D0xfffffffc,var_off=3D(0x0;
> 0x3fffffffc)) R5_rw=3DPscalar(id=3D2) R8_rw=3Dscalar(id=3D2) R10=3Dfp0
> mark_precise: frame0: last_idx 24 first_idx 11 subseq_idx 26
> mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D 0x4
> mark_precise: frame0: regs=3Dr5,r8 stack=3D before 23: (bf) r5 =3D r8
> mark_precise: frame0: regs=3Dr8 stack=3D before 22: (67) r4 <<=3D 2
> mark_precise: frame0: regs=3Dr8 stack=3D before 18: (56) if w8 !=3D 0xf g=
oto pc+3
> mark_precise: frame0: regs=3Dr8 stack=3D before 17: (c4) w4 s>>=3D 29
> mark_precise: frame0: regs=3Dr8 stack=3D before 15: (18) r3 =3D 0x1f00000=
034
> mark_precise: frame0: regs=3Dr8 stack=3D before 14: (2f) r4 *=3D r4
> mark_precise: frame0: regs=3Dr8 stack=3D before 13: (0f) r0 +=3D r0
> mark_precise: frame0: regs=3Dr8 stack=3D before 12: (1f) r8 -=3D r4
> mark_precise: frame0: regs=3Dr4,r8 stack=3D before 11: (45) if r0 &
> 0xfffffffe goto pc+3
> mark_precise: frame0: parent state regs=3D stack=3D:  R0_rw=3DPscalar()
> R4_rw=3DPscalar() R8_rw=3DP0x1a000000be R10=3Dfp0
> 29: R5=3Dscalar(id=3D2,smax32=3D1)
> 32: (95) exit
>
> from 26 to 32: R0=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax3=
2=3D2,var_off=3D(0x0;
> 0x3)) R2=3D4 R3=3D0x1f00000034
> R4=3Dscalar(smin=3D0,smax=3Dumax=3D0x3fffffffc,smax32=3D0x7ffffffc,umax32=
=3D0xfffffffc,var_off=3D(0x0;
> 0x3fffffffc)) R5=3Dscalar(id=3D2,smax=3D0x7fffffff7fffffff,umax=3D0xfffff=
fff7fffffff,smin32=3D0,umax32=3D0x7fffffff,var_off=3D(0x0;
> 0xffffffff7fffffff))
> R8=3Dscalar(id=3D2,smax=3D0x7fffffff7fffffff,umax=3D0xffffffff7fffffff,sm=
in32=3D0,umax32=3D0x7fffffff,var_off=3D(0x0;
> 0xffffffff7fffffff)) R10=3Dfp0
> 32: R0=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var_o=
ff=3D(0x0;
> 0x3)) R2=3D4 R3=3D0x1f00000034
> R4=3Dscalar(smin=3D0,smax=3Dumax=3D0x3fffffffc,smax32=3D0x7ffffffc,umax32=
=3D0xfffffffc,var_off=3D(0x0;
> 0x3fffffffc)) R5=3Dscalar(id=3D2,smax=3D0x7fffffff7fffffff,umax=3D0xfffff=
fff7fffffff,smin32=3D0,umax32=3D0x7fffffff,var_off=3D(0x0;
> 0xffffffff7fffffff))
> R8=3Dscalar(id=3D2,smax=3D0x7fffffff7fffffff,umax=3D0xffffffff7fffffff,sm=
in32=3D0,umax32=3D0x7fffffff,var_off=3D(0x0;
> 0xffffffff7fffffff)) R10=3Dfp0
> 32: (95) exit

here we also skipped 30:, and w8 was in [0,0x7fffffff] range, r0 is
[0,2], but it's precision doesn't matter as we didn't do any pruning

NOTE this one.

>
> from 11 to 15: R0=3Dscalar() R4=3Dscalar() R8=3D0x1a000000be R10=3Dfp0
> 15: R0=3Dscalar() R4=3Dscalar() R8=3D0x1a000000be R10=3Dfp0
> 15: (18) r3 =3D 0x1f00000034            ; R3_w=3D0x1f00000034
> 17: (c4) w4 s>>=3D 29                   ;
> R4=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,var_=
off=3D(0x0;
> 0xffffffff))
> 18: (56) if w8 !=3D 0xf goto pc+3

known true, always taken

> mark_precise: frame0: last_idx 18 first_idx 18 subseq_idx -1
> mark_precise: frame0: parent state regs=3Dr8 stack=3D:  R0=3Dscalar()
> R3_w=3D0x1f00000034
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,va=
r_off=3D(0x0;
> 0xffffffff)) R8_r=3DP0x1a000000be R10=3Dfp0
> mark_precise: frame0: last_idx 17 first_idx 11 subseq_idx 18
> mark_precise: frame0: regs=3Dr8 stack=3D before 17: (c4) w4 s>>=3D 29
> mark_precise: frame0: regs=3Dr8 stack=3D before 15: (18) r3 =3D 0x1f00000=
034
> mark_precise: frame0: regs=3Dr8 stack=3D before 11: (45) if r0 &
> 0xfffffffe goto pc+3
> mark_precise: frame0: parent state regs=3D stack=3D:  R0_rw=3DPscalar()
> R4_rw=3DPscalar() R8_rw=3DP0x1a000000be R10=3Dfp0
> 18: R8=3D0x1a000000be
> 22: (67) r4 <<=3D 2                     ;
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0x3fffffffc,smax32=3D0x7ffffffc,umax=
32=3D0xfffffffc,var_off=3D(0x0;
> 0x3fffffffc))
> 23: (bf) r5 =3D r8                      ; R5_w=3D0x1a000000be R8=3D0x1a00=
0000be
> 24: (18) r2 =3D 0x4
> frame 0: propagating r5
> mark_precise: frame0: last_idx 26 first_idx 18 subseq_idx -1
> mark_precise: frame0: regs=3Dr5 stack=3D before 24: (18) r2 =3D 0x4
> mark_precise: frame0: regs=3Dr5 stack=3D before 23: (bf) r5 =3D r8
> mark_precise: frame0: regs=3Dr8 stack=3D before 22: (67) r4 <<=3D 2
> mark_precise: frame0: regs=3Dr8 stack=3D before 18: (56) if w8 !=3D 0xf g=
oto pc+3
> mark_precise: frame0: parent state regs=3D stack=3D:  R0_r=3Dscalar()
> R3_w=3D0x1f00000034
> R4_rw=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,v=
ar_off=3D(0x0;
> 0xffffffff)) R8_r=3DP0x1a000000be R10=3Dfp0
> 26: safe

and here we basically need to evaluate

if w8 s>=3D w0 goto pc+5

w8 is precisely known to be 0x000000be, while w0 is unknown. Now go
back to "NOTE this one" mark above. w8 is inside [0, 0xffffffff]
range, right? And w0 is unknown, while up in "NOTE this one" w0 didn't
matter, so it stayed imprecise. This is a match. It seems correct.


> processed 38 insns (limit 1000000) max_states_per_insn 1 total_states
> 4 peak_states 4 mark_read 2
>
> -------- End of Verifier Log --------
>
> When the verifier backtracks from #29, I expected w0 at #26 (if w8 s>=3D
> w0 goto pc+5) to be marked as precise since R8 and R5 share the same
> id:

r0 is marked precise at 26:

mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1
mark_precise: frame0: regs=3Dr0 stack=3D before 24: (18) r2 =3D 0x4
mark_precise: frame0: regs=3Dr0 stack=3D before 23: (bf) r5 =3D r8
mark_precise: frame0: regs=3Dr0 stack=3D before 22: (67) r4 <<=3D 2
mark_precise: frame0: parent state regs=3Dr0 stack=3D:
R0_rw=3DPscalar(smin=3Dsmin32=3D0,sm
ax=3Dumax=3Dsmax32=3Dumax32=3D2,var_off=3D(0x0;
0x3)) R2_w=3D28 R3_w=3Dscalar()
R4_rw=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,var=
_off=3D(0x0;
0xffffffff)) R8_rw=3DPscalar(smin=3D0x800000000000000f,smax=3D0x7fffffff000=
0000f,umin=3Dsmin32=3Dumin32=3D15,umax=3D0xffffffff0000000f,smax32=3Dumax32=
=3D15,var_off=3D(0xf;
0xffffffff00000000)) R10=3Dfp0

>
> 29: (d6) if w5 s<=3D 0x1d goto pc+2
> mark_precise: frame0: last_idx 29 first_idx 26 subseq_idx -1
> mark_precise: frame0: regs=3Dr5 stack=3D before 28: (0f) r8 +=3D r8
> mark_precise: frame0: regs=3Dr5 stack=3D before 27: (4f) r8 |=3D r8
> mark_precise: frame0: regs=3Dr5 stack=3D before 26: (7e) if w8 s>=3D w0 g=
oto pc+5
> mark_precise: frame0: parent state regs=3Dr5 stack=3D:
> R0_rw=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,var_of=
f=3D(0x0;
> 0x3)) R2_w=3D4 R3_w=3D0x1f00000034
> R4_w=3Dscalar(smin=3D0,smax=3Dumax=3D0x3fffffffc,smax32=3D0x7ffffffc,umax=
32=3D0xfffffffc,var_off=3D(0x0;
> 0x3fffffffc)) R5_rw=3DPscalar(id=3D2) R8_rw=3Dscalar(id=3D2) R10=3Dfp0
> mark_precise: frame0: last_idx 24 first_idx 11 subseq_idx 26
> mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D 0x4
> mark_precise: frame0: regs=3Dr5,r8 stack=3D before 23: (bf) r5 =3D r8
> mark_precise: frame0: regs=3Dr8 stack=3D before 22: (67) r4 <<=3D 2
> mark_precise: frame0: regs=3Dr8 stack=3D before 18: (56) if w8 !=3D 0xf g=
oto pc+3
> mark_precise: frame0: regs=3Dr8 stack=3D before 17: (c4) w4 s>>=3D 29
> mark_precise: frame0: regs=3Dr8 stack=3D before 15: (18) r3 =3D 0x1f00000=
034
> mark_precise: frame0: regs=3Dr8 stack=3D before 14: (2f) r4 *=3D r4
> mark_precise: frame0: regs=3Dr8 stack=3D before 13: (0f) r0 +=3D r0
> mark_precise: frame0: regs=3Dr8 stack=3D before 12: (1f) r8 -=3D r4
> mark_precise: frame0: regs=3Dr4,r8 stack=3D before 11: (45) if r0 &
> 0xfffffffe goto pc+3
> mark_precise: frame0: parent state regs=3D stack=3D:  R0_rw=3DPscalar()
> R4_rw=3DPscalar() R8_rw=3DP0x1a000000be R10=3Dfp0
> 29: R5=3Dscalar(id=3D2,smax32=3D1)
>
> However, seems it's not, so the next time when the verifier checks
> #26, R0 is incorrectly ignored.
> We have mark_precise_scalar_ids(), but it's called before calculating
> the mask once.

I'm not following the remark about mark_precise_scalar_ids(). That
works fine, but has nothing to do with r0. mark_precise_scalar_ids()
identifies that r8 and r5 are linked together, and you can see from
the log that we mark both r5 and r8 as precise.

> I investigated for quite a while, but mark_chain_pricision() is really
> hard to follow.
>
> Here is a reduced C repro, maybe someone else can shed some light on this=
.
> C repro: https://pastebin.com/raw/chrshhGQ

So you claim is that

30: (18) r0 =3D 0x4 ; incorrectly pruned here


Can you please show a detailed code patch in which we do reach 30
actually? I might have missed it, but so far it look like verifier is
doing everything right.

>
> Thanks
> Hao

