Return-Path: <bpf+bounces-56043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E492A905EB
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 16:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3733B9CC6
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAB21ABB7;
	Wed, 16 Apr 2025 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="anyYkwoq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C451FCFF0
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811935; cv=none; b=VOxbDHqd7TyCOxTEl4mf06Pgf/h+BypV0dVr1yX+XgD3YxpjZjUt5qijxowk80UNezwFIv4nFL8V8omu6wK2+EuKhLkq7wwEQfQJzAIpTRb3HHBa+cxz7SfXHR7UNVLcdNrgjprlbHBnas41nzGHj95Du8dMBaAznRBLrgzSrRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811935; c=relaxed/simple;
	bh=fCCDhGivbuEHRQuVN/+Bh8U1ARAoEEuxeOBM5Ahs5oo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GwHUy2KHEkHZJwI4CmvEB0XHxw0pQzlO6InHlUGsTsh9cMZtD3NlrxlnaM3yYnR1x758qNpmxYEOZKMJHgz3x1REikuiul2VkGioo6gOk3n3j/gQ0WT46QO/XRuMco5sgFgYGCeCramhJ2ArAoDTTTI67c5zn6eyOxo1j5EqtHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=anyYkwoq; arc=none smtp.client-ip=128.178.224.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1744811529;
      h=From:To:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=fCCDhGivbuEHRQuVN/+Bh8U1ARAoEEuxeOBM5Ahs5oo=;
      b=anyYkwoqKugA1U0EijbankiPiA5LIe1bHKVsNVs49m8AuHXRbnHb7p+X7Yx3Nq2bH
        c43PSZzXyQo8Xi7FKe/u8FX+QqHLFe++uJbjVisy11BN7q779C3Qtr0X/N2pdLReD
        ji3xBmi4WRoHxHKBaP7L/aZf0VdJ4uKKhiKMPY6/M=
Received: (qmail 47559 invoked by uid 107); 16 Apr 2025 13:52:09 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Wed, 16 Apr 2025 15:52:09 +0200
X-EPFL-Auth: uF5fbAZFBVCgbFaqyfFO9/3Z9du8Em62nbAQCOb3wftJD2wXHLg=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 15:52:09 +0200
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2507.044; Wed, 16 Apr 2025 15:52:09 +0200
From: Tao Lyu <tao.lyu@epfl.ch>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: A summary of usability issues in the current verifier
Thread-Topic: A summary of usability issues in the current verifier
Thread-Index: AQHbrta2R9pFsdf8H0SX+JLfklldsg==
Date: Wed, 16 Apr 2025 13:52:09 +0000
Message-ID: <2eb5612b88b04587af00394606021972@epfl.ch>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


Hi,

I found the following usability issues; kindly write them here to see if th=
e community is willing to solve them.
If yes, I could write patches for them gradually.

1. Inaccurate tracking of arithmetic instruction results.

There are many inaccurate arithmetic computation results.
For example, like below:
r0 should be 0 after `r0 =3D (s16)r3`.
However, due to the inaccurate range track in eBPF at (coerce_reg_to_size_s=
x and set_sext64_default_val),
the lower 16-bit of r0 becomes unknown, leading to false negatives when exi=
t.

func#0 @0
0: R1=3Dctx() R10=3Dfp0
0: (b7) r6 =3D -657948387=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ; R6_w=
=3D0xffffffffd8c8811d
1: (94) w6 s%=3D 16=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ; R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0x=
ffffffff))
2: (18) r8 =3D 0xff11000279981800=A0=A0=A0=A0=A0=A0 ; R8_w=3Dmap_ptr(ks=3D4=
,vs=3D8)
4: (18) r9 =3D 0x19556057=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ; R9_w=
=3D0x19556057
6: (bf) r3 =3D r10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ; R3_w=3Dfp0 R10=3Dfp0
7: (bf) r3 =3D r6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ; R3_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D0xffffffff,var_off=
=3D(0x0; 0xffffffff)) R6_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D0xfffffff=
f,var_off=3D(0x0; 0xffffffff))
8: (67) r3 <<=3D 38=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ; R3_w=3Dscalar(smax=3D0x7fffffc000000000,umax=3D0xffffffc000000000,=
smin32=3D0,smax32=3Dumax32=3D0,var_off=3D(0x0; 0xffffffc000000000))
9: (bf) r0 =3D r6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ; R0_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D0xffffffff,var_off=
=3D(0x0; 0xffffffff)) R6_w=3Dscalar(id=3D1,smin=3D0,smax=3Dumax=3D0xfffffff=
f,var_off=3D(0x0; 0xffffffff))
10: (bc) w0 =3D (s16)w3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ; R=
0_w=3D0 R3_w=3Dscalar(smax=3D0x7fffffc000000000,umax=3D0xffffffc000000000,s=
min32=3D0,smax32=3Dumax32=3D0,var_off=3D(0x0; 0xffffffc000000000))
11: (bf) r0 =3D (s16)r3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ; R=
0_w=3Dscalar(smin=3Dsmin32=3D-32768,smax=3Dsmax32=3D32767) R3_w=3Dscalar(sm=
ax=3D0x7fffffc000000000,umax=3D0xffffffc000000000,smin32=3D0,smax32=3Dumax3=
2=3D0,var_off=3D(0x0; 0xffffffc000000000))


2. Unnecessary atomic instructions operating on private memory (e.g, stack)=
.

Since atomic instructions are only useful on the shared memory,
it is unnecessary to allow them on the private memory like stack,
which was discussed long time ago in this commit:
https://github.com/torvalds/linux/commit/ca36960211eb228bcbc7aaebfa0d027368=
a94c60

Moreover, allowing atomic instruction also introduce another usability bugs=
,
which was reported here: https://lore.kernel.org/bpf/20231020172941.155388-=
1-tao.lyu@epfl.ch/


3. Inconsistent constraints on instructions involving pointer type transiti=
ons.

Most bitwise instructions, such as and and xor are disallowed on pointers,
but negation and bitwise swap are allowed.
Moreover, negation and bitwise swap are permitted in atomic instructions,
such as atomic_and and atomic_xor.


4. Coarse-grained pointer comparison.

Pointers pointing to the same memory region can infer more pointer range in=
formation.=20
For example, comparing two stack pointers (one with a constant range, while=
 the other with a variable range) can help infer the variable range,
as shown in the code below.

11: R0=3Dmap_value(map=3Darray_map3,ks=3D4,vs=3D8) R9=3Dctx() R10=3Dfp0 fp-=
8=3Dmmmmmmmm
11: (61) r6 =3D *(u32 *)(r0 +0)=A0=A0=A0=A0=A0=A0=A0=A0 ; R0=3Dmap_value(ma=
p=3Darray_map3,ks=3D4,vs=3D8) R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffff=
ff,var_off=3D(0x0; 0xffffffff))
12: (bf) r1 =3D r10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ; R1_w=3Dfp0 R10=3Dfp0
13: (0f) r1 +=3D r6
mark_precise: frame0: last_idx 13 first_idx 11 subseq_idx -1
mark_precise: frame0: regs=3Dr6 stack=3D before 12: (bf) r1 =3D r10
mark_precise: frame0: regs=3Dr6 stack=3D before 11: (61) r6 =3D *(u32 *)(r0=
 +0)
14: R1_w=3Dfp(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)=
) R6_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xfffffff=
f))
14: (bf) r2 =3D r10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ; R2_w=3Dfp0 R10=3Dfp0
15: (07) r2 +=3D -512=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 ; R2_w=3Dfp-512
16: (ad) if r1 < r2 goto pc+2=A0=A0=A0=A0=A0=A0=A0=A0 ; R1_w=3Dfp(smin=3D0,=
smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R2_w=3Dfp-512
17: (3d) if r1 >=3D r10 goto pc+1=A0=A0=A0=A0=A0=A0 ; R1_w=3Dfp(smin=3D0,sm=
ax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R10=3Dfp0
18: (71) r3 =3D *(u8 *)(r1 +0)
invalid unbounded variable-offset read from stack R1=

