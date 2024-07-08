Return-Path: <bpf+bounces-34144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DE692AB46
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 23:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D80E1C219CF
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3F13D2BB;
	Mon,  8 Jul 2024 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwnzlRN+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF51EB44
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474316; cv=none; b=M9eyDcRr0qqEbWFXjOXWs8Zn7QnQYru57zH1Ls3rIIfzV3Il6Kb5f5d6d99jp0zGBlXMo80VKpRFRt35wwXaiEAEeWjhrpSEMZ069fYa6Icff2DU9NBEIjYmCEQ44CfKRBlhCoVS5NX/VI+9d+JHepvRbIMeIjGPP+xTt5g+qLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474316; c=relaxed/simple;
	bh=f7EBzZa80iN2i0JYg9LPivJ45OhayxN5BTW4PXKTItU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C3yfMFyXZfLprF/N9YOH4Zd7/a4gQs6+ZnGglG0CUM9+XLWAOV8W+p7X0LoOxdAk1lMllfXqxZalXm9yUUK00E10/+kjIfKyME//XQpywRgVw/KFiYsdL3Bdfu6gpItzqlvRVL7Jd95kk9HRgvKERNPCoPkqOdA7Fmaj3jcKX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwnzlRN+; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7fa6f6e45a7so103874339f.1
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 14:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720474314; x=1721079114; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EjUX9ZUX0G+s5b4/bte5aoQ9N+EpLEP2wmPmcAh3vDg=;
        b=PwnzlRN+HCWB/uZ6Lad8Hvnm7kM2iY1vmJwlGP5QTBu9WJTAi11MJALlhqxNtWS8xp
         Am9TFgs9SlsobjZYB1CMtqOAlwcAB+TpUAjg5xCtq0Q6uJ2exhqTjDjo9oxNJloCmaGo
         X/P08NeyAtF9ThkYpAQEG9F5tui/MiIpTuTCC2DHQ2H1Fl6jhI9r1gd+IqAyou8fp9V3
         uxZsCwaQlDEb7z1Jl+/C2f/BSYqQq/J0293L6ma58O39lQ7i1arMwAzkPGkD2fywzCPC
         vmG5rbnVSiR5gYPi7atBMid1AGV5KeThnKxeha72xYN6N5R9YfdZkTQmEVBVcEGyTFjA
         YOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720474314; x=1721079114;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjUX9ZUX0G+s5b4/bte5aoQ9N+EpLEP2wmPmcAh3vDg=;
        b=tYX0aRHRWxuuuxhPcs5jbGGRe3QO3OmscBkA/+85atCuVAySKqpiMd5hR5PmCZpLag
         ad/8qiPkBM640ja3P5e9ZE+smWdBXGhRikyBJWrAiVjHOAWdXE4P3q9hM0dt0ILPg1C1
         PB2xFpYT9ZCQXyJaBFp7w9HlgxcAS4lhCmMLUAeztohft8lbzcuPh8P0y73qIAQTdI0K
         TwWCwW3Kh0GgUi5wlV/mcQZ7FpS4Tni77qnLinQedkcs49mZWhgnNVPzSMDP+3GyGe5X
         dOUOSIJFbdFeNeNvPjB7wrB8HvCHXq2EDzHqd8rrqlk09qW0fZ9YdBC/I94aBUAZUSLI
         KVyw==
X-Gm-Message-State: AOJu0YzKRgBj4+jiV/3eoUzfgbGmjlNla36GLArsn/jOdOP8nP3xFi7I
	CCiwaud7M4CSBkl+fqtqNw4K3VSgt0uR0FqXMZd3ZJSSRjKO+yVD
X-Google-Smtp-Source: AGHT+IHpeNqOT+FIlraOHCaipQxzSLQECyS84sxxRaThOa28MTg3OaT5Xrw2SP34AOsS12vtki5tNA==
X-Received: by 2002:a05:6602:122b:b0:7f6:1fcc:25c5 with SMTP id ca18e2360f4ac-80004173acamr97642739f.19.1720474313683;
        Mon, 08 Jul 2024 14:31:53 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c25a2sm350512b3a.73.2024.07.08.14.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 14:31:53 -0700 (PDT)
Message-ID: <0e6db29edc9121d21fb25fe2b239c9d1cd8d6f58.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround
 iters/iter_arr_with_actual_elem_count failure when -mcpu=cpuv4
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>,  Martin KaFai Lau <martin.lau@kernel.org>
Date: Mon, 08 Jul 2024 14:31:48 -0700
In-Reply-To: <CAADnVQJTgxhpKJDLVb9FY+Zuu7NNuTzEq9Cy4zFJ2=DDHSCFng@mail.gmail.com>
References: <20240708154634.283426-1-yonghong.song@linux.dev>
	 <CAADnVQL4YenuuaAjpW0T7mHv=LEk4xZHS2W=OF6QJsUPL700ZQ@mail.gmail.com>
	 <234f2c8e-b4f5-4cda-86b9-651b5b9bc915@linux.dev>
	 <CAADnVQJTgxhpKJDLVb9FY+Zuu7NNuTzEq9Cy4zFJ2=DDHSCFng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 13:18 -0700, Alexei Starovoitov wrote:

[...]

> > the 32bit_sign_ext will indicate the register r1 is from 32bit sign ext=
ension, so once w1 range is refined, the upper 32bit can be recalculated.
> >=20
> > Can we avoid 32bit_sign_exit in the above? Let us say we have
> >    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffff=
ff), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D32,var=
_off=3D(0x0; 0x3f))
> >    if w1 < w6 goto pc+4
> > where r1 achieves is trange through other means than 32bit sign extensi=
on e.g.
> >    call bpf_get_prandom_u32;
> >    r1 =3D r0;
> >    r1 <<=3D 32;
> >    call bpf_get_prandom_u32;
> >    r1 |=3D r0;  /* r1 is 64bit random number */
> >    r2 =3D 0xffffffff80000000 ll;
> >    if r1 s< r2 goto end;
> >    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=3D0xfffff=
fff80000000,smax=3D0x7fffffff) */
> >    if w1 < w6 goto end;
> >    ...  <=3D=3D=3D w1 range [0,31]
> >         <=3D=3D=3D but if we have upper bit as 0xffffffff........, then=
 the range will be
> >         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000] and this ra=
nge is not possible compared to original r1 range.
>=20
> Just rephrasing for myself...
> Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xffffFFFF
> then lower 32-bit has to be negative.
> and because we're doing unsigned compare w1 < w6
> and w6 is less than 80000000
> we can conclude that upper bits are zero.
> right?

Sorry, could you please explain this a bit more.
The w1 < w6 comparison only infers information about sub-registers.
So the range for the full register r1 would still have 0xffffFFFF
for upper bits =3D> r1 +=3D r2 would fail.
What do I miss?

The non-cpuv4 version of the program does non-sign-extended load:

14: (61) r1 =3D *(u32 *)(r0 +0)   ; R0=3Drdonly_mem(id=3D3,ref_obj_id=3D2,s=
z=3D4)
                                  R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xff=
ffffff,var_off=3D(0x0; 0xffffffff))
15: (ae) if w1 < w6 goto pc+4   ; R1_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xff=
ffffff,var_off=3D(0x0; 0xffffffff))
                                  R6=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=
=3Dumax=3Dsmax32=3Dumax32=3D32,var_off=3D(0x0; 0x3f))

Tbh, it looks like LLVM deleted some info that could not be recovered
in this instance.

>=20
> >         <=3D=3D=3D so the only possible way for upper 32bit range is 0.
> > end:
> >=20
> > Therefore, looks like we do not need 32bit_sign_exit. Just from
> > R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x7fffffff)
> > with refined range in true path of 'if w1 < w6 goto ...',
> > we can further refine w1 range properly.
>=20
> yep. looks like it.
> We can hard code this special logic for this specific smin/smax pair,
> but the gut feel is that we can generalize it further.
>=20


