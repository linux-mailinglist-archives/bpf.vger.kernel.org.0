Return-Path: <bpf+bounces-34147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6EB92ABC8
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937792829FB
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507B014F9CF;
	Mon,  8 Jul 2024 22:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzQC83D7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CFD5674E
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 22:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476742; cv=none; b=dL5614oY6VMQFxK5c1GoFKW+4GHal91HIqt6u+Va24JMRjRYektef7k20Uum4JJODL9WHHV1Nxf3+hIhqfWmHGR+9E0poMunCvfXpQtv3LQB7nVhCgcGpD4Aeuyi7OPkUPz5uuSFPFnT4zv9tntheYo7dL776rUv5JK34VYXqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476742; c=relaxed/simple;
	bh=kPE/2VkXuULTwhBSpdzzzcEPSHGWqS05A6IGfRQ7QVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7fkwJ8lrrYQXFltbue+ZVgaWf9f3dEzq2FkrVVO+Eg00rf7J3l0bYjvzd34yMtynfvdSY9sTzSI2k8m+BD62TiyON/a+v448xXkK61gJ64lk8tpCDZpHebkVDv3dEwSiRwoFZ+iia9YEqBp7jx2vtvBWAFWpqACvAWZz3A66Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzQC83D7; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b0e9ee7bcso2577093b3a.1
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720476741; x=1721081541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdj78OBP1jaEiV46krN1TwP+cQukr7nTaEdKMkbVjtI=;
        b=TzQC83D7YN6EMfk9H3hMhQiQN9rTv7BRgkjPC3gba6GKq+GiQ7dGPA2PzcipwMfBqF
         zEJNgR433PJ5rjr1e7BU52MkUPbQcs96cIK6QFhTM6nSYmO2nL/dmAYUSoA6dFdYA02a
         EAa2T3f3Lyno2D8mYsaWfBGdqPSV9SIPB5icNm0F3R53qlOnsvUY9Ow4TS7VC/M5VaoV
         BOjLxpLmYTeBEu39OQK0eBvHz3vNRUnGI8Q7uuUfCU7DNK20gfUsxxG8CNHuJEkHV8Nb
         rnHyH26pdp4r1CScsHz72UTqKG+eo6I27japlR8GP9TWNf382g1+kb43LkMnMkJ7HQuM
         UqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476741; x=1721081541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdj78OBP1jaEiV46krN1TwP+cQukr7nTaEdKMkbVjtI=;
        b=c7nHYuXFewbpKfVCIMgj3Jon3KrqLxme0eF35gtwaPVe8xF+aQSWpz51yNvxg9atZY
         d+UegTf2OykAcUDl1iSCdWb3G7+cyDrimX6/ljW7A07d6Gkw88wmuf5sf3edhgn4iPWA
         zfM9tCfCDYvOMXiH1CavwkV2sb4tqrJTrP20YzZBTULvHXoB4zTw+qpjMmwyiWkT3Vi1
         zFXIBDVGwtOprjXwVVjcW6e6NpaYvxVXDXz86Hc3JxhK+BOtNFxU+aXDMXoeB1VZYfDn
         jUx56GfqrC7dGC9a/MkyTl3cxVtN7yuSORq9o7PudB2g9QcjMvuEiKc7HwtSlcRJR/D2
         GxJg==
X-Forwarded-Encrypted: i=1; AJvYcCWvDWEwfG1lE/D3Gl6mRGM1i0I93I7rmYH+dPALG+ONDHEB9t6n5mIHz9I753lQ2i1Ac5gxhwVhRIqpUMxy64y5pfV4
X-Gm-Message-State: AOJu0YyvX8u3/8ML6nNchAku5bNQuFHNBL1aOs7DveR+/OnkeHQW5LHW
	pdnXqyNgcrlkzIG06CHcd0jjmFpZ4PsOjmDxkFDdI60aYtWp/KF7oF+tvn2T+TRetC44Pp2XXx3
	4BUbzKE/yCl+NiV3vPsa18MjuUIU=
X-Google-Smtp-Source: AGHT+IFFf9BWm8RUJU1h6kTv8ObRNuSLV4GsEJa7oo6SU35591+uHu9jnhVN4UIy57wFgSTqDSSQx57TY0hdZunaPoA=
X-Received: by 2002:a05:6a00:a83:b0:706:62b6:cbd3 with SMTP id
 d2e1a72fcca58-70b435e9143mr1354409b3a.26.1720476740791; Mon, 08 Jul 2024
 15:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708154634.283426-1-yonghong.song@linux.dev>
 <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com>
 <234f2c8e-b4f5-4cda-86b9-651b5b9bc915@linux.dev> <CAADnVQJTgxhpKJDLVb9FY+Zuu7NNuTzEq9Cy4zFJ2=DDHSCFng@mail.gmail.com>
 <0e6db29edc9121d21fb25fe2b239c9d1cd8d6f58.camel@gmail.com> <CAEf4BzZac9SXdNHT3SwzAF4OGddj1KKpMNNQRwW_Rf5o+Jakbg@mail.gmail.com>
In-Reply-To: <CAEf4BzZac9SXdNHT3SwzAF4OGddj1KKpMNNQRwW_Rf5o+Jakbg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 15:12:08 -0700
Message-ID: <CAEf4BzZ3iTi1KGU6toCaKrzjQvP5SrJiB5LK0sSOTdctB_93+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 3:11=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 8, 2024 at 2:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Mon, 2024-07-08 at 13:18 -0700, Alexei Starovoitov wrote:
> >
> > [...]
> >
> > > > the 32bit_sign_ext will indicate the register r1 is from 32bit sign=
 extension, so once w1 range is refined, the upper 32bit can be recalculate=
d.
> > > >
> > > > Can we avoid 32bit_sign_exit in the above? Let us say we have
> > > >    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7f=
ffffff), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32=
,var_off=3D(0x0; 0x3f))
> > > >    if w1 < w6 goto pc+4
> > > > where r1 achieves is trange through other means than 32bit sign ext=
ension e.g.
> > > >    call bpf_get_prandom_u32;
> > > >    r1 =3D r0;
> > > >    r1 <<=3D 32;
> > > >    call bpf_get_prandom_u32;
> > > >    r1 |=3D r0;  /* r1 is 64bit random number */
> > > >    r2 =3D 0xffffffff80000000 ll;
> > > >    if r1 s< r2 goto end;
> > > >    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=3D0xf=
fffffff80000000,smax=3D0x7fffffff) */
> > > >    if w1 < w6 goto end;
> > > >    ...  <=3D=3D=3D w1 range [0,31]
> > > >         <=3D=3D=3D but if we have upper bit as 0xffffffff........, =
then the range will be
> > > >         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000] and thi=
s range is not possible compared to original r1 range.
> > >
> > > Just rephrasing for myself...
> > > Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xffffFFFF
> > > then lower 32-bit has to be negative.
> > > and because we're doing unsigned compare w1 < w6
> > > and w6 is less than 80000000
> > > we can conclude that upper bits are zero.
> > > right?
> >
> > Sorry, could you please explain this a bit more.
>
> Yep, also curious.
>
> But meanwhile, I'm intending to update bpf_for() to something like
> below to avoid this code generation pattern:
>

Well, thank you, Gmail, for messed up formatting. See [0] for properly
formatted diff.

  [0] https://gist.github.com/anakryiko/08a4374259469803af4ea2185296b0cb

>
> This produces this code for cpuv4:
>
>     1294:       85 10 00 00 ff ff ff ff call -0x1
>     1295:       15 00 10 00 00 00 00 00 if r0 =3D=3D 0x0 goto +0x10 <LBB3=
4_4>
>     1296:       61 01 00 00 00 00 00 00 r1 =3D *(u32 *)(r0 + 0x0)
>     1297:       c5 01 0e 00 00 00 00 00 if r1 s< 0x0 goto +0xe <LBB34_4>
>     1298:       7d 71 0d 00 00 00 00 00 if r1 s>=3D r7 goto +0xd <LBB34_4=
>
>     1299:       bf 11 20 00 00 00 00 00 r1 =3D (s32)r1
>
> > The w1 < w6 comparison only infers information about sub-registers.
> > So the range for the full register r1 would still have 0xffffFFFF
> > for upper bits =3D> r1 +=3D r2 would fail.
> > What do I miss?
> >
> > The non-cpuv4 version of the program does non-sign-extended load:
> >
> > 14: (61) r1 =3D *(u32 *)(r0 +0)   ; R0=3Drdonly_mem(id=3D3,ref_obj_id=
=3D2,sz=3D4)
> >                                   R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D=
0xffffffff,var_off=3D(0x0; 0xffffffff))
> > 15: (ae) if w1 < w6 goto pc+4   ; R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D=
0xffffffff,var_off=3D(0x0; 0xffffffff))
> >                                   R6=3Dscalar(id=3D1,smin=3Dsmin32=3D0,=
smax=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f))
> >
> > Tbh, it looks like LLVM deleted some info that could not be recovered
> > in this instance.
> >
> > >
> > > >         <=3D=3D=3D so the only possible way for upper 32bit range i=
s 0.
> > > > end:
> > > >
> > > > Therefore, looks like we do not need 32bit_sign_exit. Just from
> > > > R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)
> > > > with refined range in true path of 'if w1 < w6 goto ...',
> > > > we can further refine w1 range properly.
> > >
> > > yep. looks like it.
> > > We can hard code this special logic for this specific smin/smax pair,
> > > but the gut feel is that we can generalize it further.
> > >
> >

