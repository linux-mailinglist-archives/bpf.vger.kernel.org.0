Return-Path: <bpf+bounces-34146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3792ABC3
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F9C282AB3
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3AF14F9C9;
	Mon,  8 Jul 2024 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEn7Zlek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED5A29
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476674; cv=none; b=MgWmxCeAf90UpElwSR7Q/npvk/oP1IhRCZjbbnUSVw1Rtxsazpiwxhq044Rvdh8IOutDBcxToBBTJvKSY7zg9mWxOJ2mXyEwT2Fkrx925IlYwroFgy8pU9Tx0itt0r89rvQnme3aqt6tzDMFDrB8Ajt3gjyJ8twIlD+hRIOt+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476674; c=relaxed/simple;
	bh=O3cuxcjRbgjlm3N0ADE2qDtXtG7bSKdH1HQ6JAFEyJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sizG+IZI175QRO5toJXRBMfRvYMFnNygGvrGv8Gv4m20w5+cB/+JBEGkP0/DZRpiimWhkKYZW2jsYOK9kJeXNuVTMzZS8oRsUFemsX11APebKeqJjyF7YdqKxMn6EvzOHkU16/IM6hxhrQDQmYWLt6C6I2qcuJfPc4RISPdL7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEn7Zlek; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso3000501b3a.3
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720476672; x=1721081472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkSpqWNqTfwMtrf66UztaDozAxVIQVkRNi0Dxcbd0iA=;
        b=SEn7ZlekHCAXJSRpCdYK/JkldaU3ctvQWtMrSCApgpuWZDkVrZv9qagdIiEe5bl13x
         LRxw4ZL7RFsDMuKuAx0OpmiKkO/q20pe2TOtDzvMSIIUXK4bCbm8HncEIFpgEKvoFpYj
         jUhXYVH0hs6RnK7DPEPHyXfDkelyHPU8kD6NqRPvHpHFCbX2udZUEb5aS28mCPeTBuMd
         E+BFVLlcNV1qHjjhwuYuU09E3S3q7LANfw9yq+DdgBnd5c2hXZkhrBEYTKzK3/aPllsI
         C6YbCKmWGHflYqz8P2K6DHSvlEkHXvvt+yws5x3UgpqKvXw9CiTTT3hQe/C3Kvlw661g
         /Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476672; x=1721081472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkSpqWNqTfwMtrf66UztaDozAxVIQVkRNi0Dxcbd0iA=;
        b=OgxzBFul6WAwnLggGwMl2p0+57X1IV9h4QWHcMgIQTu1Dlc5O1yqeaxvblkl8G/N89
         vAlafuMSxPcP/nnPjbciPaVEQbZbf6CEmcph1wg3nkxMWGgf22OWKN4eVgsvjBjKzkTJ
         2JuSaV/qj6YBXd04INguiDrkhdtSIiNEpTtEgYq5JT9FBkycx3qJXocLq+u7wzh4VUi5
         LCxvpf4Kj+0p2t1aQe2L4vac7VqRpm5Cc9+EQdQ+EjRfqc4tTsUxuBDgGxRizEAgCnIw
         Idba+it9uAO55ZuhhOToQsxhT4u6WWeOF/SRE/FBAo4IONLFpKbP0whkzatUdn1zlCI+
         x+fA==
X-Forwarded-Encrypted: i=1; AJvYcCXG78UmDTZ21RvQdrn9dG9TXvBDSf1TQHxqgRq+iVBAZK7cOEuve6uLD+E6PitgCfPU8SRQZyselXu3rOlji8VW8Gqx
X-Gm-Message-State: AOJu0YyET+TtVzd034I9dj/+QnoVr8YMp1je4oyFzEYECPKbXMbGQf9U
	lGIi3hVOjj6lzGo+kq1Z/mmBjNBy16thYg0zamWDxZ7va5QM0tcv6OCpohcI381bfAePr9wLy2e
	mySHvpS+hC+Do11DGxF0velnVgm5kNjyD
X-Google-Smtp-Source: AGHT+IEktY9sNNJjtm+G+iiH238fRAQGVpMwwtUc6ehaVhawrYsxU/ufj2Nl1q+GxnTQv2J2UKVFBm6NZlo+e00CfgI=
X-Received: by 2002:a05:6a00:3cc6:b0:70b:24f4:dd37 with SMTP id
 d2e1a72fcca58-70b4361b034mr1184725b3a.32.1720476672476; Mon, 08 Jul 2024
 15:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708154634.283426-1-yonghong.song@linux.dev>
 <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com>
 <234f2c8e-b4f5-4cda-86b9-651b5b9bc915@linux.dev> <CAADnVQJTgxhpKJDLVb9FY+Zuu7NNuTzEq9Cy4zFJ2=DDHSCFng@mail.gmail.com>
 <0e6db29edc9121d21fb25fe2b239c9d1cd8d6f58.camel@gmail.com>
In-Reply-To: <0e6db29edc9121d21fb25fe2b239c9d1cd8d6f58.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 15:11:00 -0700
Message-ID: <CAEf4BzZac9SXdNHT3SwzAF4OGddj1KKpMNNQRwW_Rf5o+Jakbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-07-08 at 13:18 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > > the 32bit_sign_ext will indicate the register r1 is from 32bit sign e=
xtension, so once w1 range is refined, the upper 32bit can be recalculated.
> > >
> > > Can we avoid 32bit_sign_exit in the above? Let us say we have
> > >    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fff=
ffff), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,v=
ar_off=3D(0x0; 0x3f))
> > >    if w1 < w6 goto pc+4
> > > where r1 achieves is trange through other means than 32bit sign exten=
sion e.g.
> > >    call bpf_get_prandom_u32;
> > >    r1 =3D r0;
> > >    r1 <<=3D 32;
> > >    call bpf_get_prandom_u32;
> > >    r1 |=3D r0;  /* r1 is 64bit random number */
> > >    r2 =3D 0xffffffff80000000 ll;
> > >    if r1 s< r2 goto end;
> > >    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=3D0xfff=
fffff80000000,smax=3D0x7fffffff) */
> > >    if w1 < w6 goto end;
> > >    ...  <=3D=3D=3D w1 range [0,31]
> > >         <=3D=3D=3D but if we have upper bit as 0xffffffff........, th=
en the range will be
> > >         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000] and this =
range is not possible compared to original r1 range.
> >
> > Just rephrasing for myself...
> > Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xffffFFFF
> > then lower 32-bit has to be negative.
> > and because we're doing unsigned compare w1 < w6
> > and w6 is less than 80000000
> > we can conclude that upper bits are zero.
> > right?
>
> Sorry, could you please explain this a bit more.

Yep, also curious.

But meanwhile, I'm intending to update bpf_for() to something like
below to avoid this code generation pattern:

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 305c62817dd3..86dc854a713b 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -394,7 +394,18 @@ extern void bpf_iter_num_destroy(struct
bpf_iter_num *it) __weak __ksym;
                /* iteration step */
                         \
                int *___t =3D bpf_iter_num_next(&___it);
                         \
                /* termination and bounds check */
                         \
-               (___t && ((i) =3D *___t, (i) >=3D (start) && (i) <
(end)));                         \
+               (___t && ({
                         \
+                       __label__ l_false;
                         \
+                       _Bool ok =3D 0;
                         \
+                       (i) =3D *___t;
                         \
+                       asm volatile goto ("
                         \
+                               if %[_i] s< %[_start] goto
%l[l_false];                         \
+                               if %[_i] s>=3D %[_end] goto %l[l_false];
                         \
+                       " :: [_i]"r"(i), [_start]"ri"(start),
[_end]"ri"(end) :: l_false);      \
+                       ok =3D 1;
                         \
+               l_false:
                         \
+                       ok;
                         \
+               }));
                         \
        });
                         \
 )
 #endif /* bpf_for */

This produces this code for cpuv4:

    1294:       85 10 00 00 ff ff ff ff call -0x1
    1295:       15 00 10 00 00 00 00 00 if r0 =3D=3D 0x0 goto +0x10 <LBB34_=
4>
    1296:       61 01 00 00 00 00 00 00 r1 =3D *(u32 *)(r0 + 0x0)
    1297:       c5 01 0e 00 00 00 00 00 if r1 s< 0x0 goto +0xe <LBB34_4>
    1298:       7d 71 0d 00 00 00 00 00 if r1 s>=3D r7 goto +0xd <LBB34_4>
    1299:       bf 11 20 00 00 00 00 00 r1 =3D (s32)r1

> The w1 < w6 comparison only infers information about sub-registers.
> So the range for the full register r1 would still have 0xffffFFFF
> for upper bits =3D> r1 +=3D r2 would fail.
> What do I miss?
>
> The non-cpuv4 version of the program does non-sign-extended load:
>
> 14: (61) r1 =3D *(u32 *)(r0 +0)   ; R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2=
,sz=3D4)
>                                   R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0x=
ffffffff,var_off=3D(0x0; 0xffffffff))
> 15: (ae) if w1 < w6 goto pc+4   ; R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0x=
ffffffff,var_off=3D(0x0; 0xffffffff))
>                                   R6=3Dscalar(id=3D1,smin=3Dsmin32=3D0,sm=
ax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f))
>
> Tbh, it looks like LLVM deleted some info that could not be recovered
> in this instance.
>
> >
> > >         <=3D=3D=3D so the only possible way for upper 32bit range is =
0.
> > > end:
> > >
> > > Therefore, looks like we do not need 32bit_sign_exit. Just from
> > > R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)
> > > with refined range in true path of 'if w1 < w6 goto ...',
> > > we can further refine w1 range properly.
> >
> > yep. looks like it.
> > We can hard code this special logic for this specific smin/smax pair,
> > but the gut feel is that we can generalize it further.
> >
>

