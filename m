Return-Path: <bpf+bounces-34267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D811092C268
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 19:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4235BB225C0
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE267F476;
	Tue,  9 Jul 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoSBtgn0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137BD3D967
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545828; cv=none; b=B6NeGdk/26uqIKCs+2a9PZsO6LPRf/WokQXtY8ZFDeCyJNJizQRYTJJ4/GMUPbL+ed+A8a7myZ7RML5lY0Uc8e9Sl93OpM8M/KI5MrmXWhk1uiMwMVOmLK8Cybu/X9bE5nhf5ZxGmP6/YgZh8mO1GkWVqlRAM8sY6MNCEVzInF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545828; c=relaxed/simple;
	bh=P2o/B73pQIX2wMqZWcRU89na+K3KnNy0MszXBE0/8Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfQ/5YCc3G6Txny1b+FodFR8ICPVWCVXPrA2m2yOCBYCcqYmg5WTW2YcrjUr1OrkT0eKAIRIYoBZHnFyv/CZ3CeOLa+lwNKBkHvuHGVSVvB6upNw8jsafm8TdWkyZTVEsuATjAV+EREV22qLSGF6+E4Kkvq4XotT1QCiLCbvp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoSBtgn0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so20517905e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720545824; x=1721150624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMhFDIMoobMJjH86/iQBSe8PTSHc8594RLrCGe48VTQ=;
        b=PoSBtgn02okABlOQ0kBL8n1oiZx9/kBpn9/RWDfn4JRtpsZFkPb8+/UJt346qu7s+P
         mXvMg0knG/xyYtjeYvVbpfB8QxvYKp24pG+6ntacKg3x5vOeyAqzzoeCquQ+UHxsbDGJ
         XDfFdCyhsPbMdr//IWbd7qN1/r7q/hVO31BmUiztlWve0dBM/oIXf7tjGFiLuZUbpkEA
         fyWBPT4UHCv8NK6Bhlx0WAz2TGX3DhzSKWAcx+8xFba7mKgHFcpGRZ9NPSkx7IH7UN4b
         Nld4ZhPwMsLaM8ZocPJ40rX+W2vaci9bA/YktTPepODaWA0l59bOZIivzsc0qDLZOvAi
         gL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720545824; x=1721150624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMhFDIMoobMJjH86/iQBSe8PTSHc8594RLrCGe48VTQ=;
        b=pZrywQnNf/RgKxgMVR+Fwqt5/XFhITy+XG1ss5+aLwhlEKQYEM9Lv/mYe+BfJYtuCe
         1AU6EFfckffpYmsZws+UIixKDU92G+wX6MfbCwtDQSDOHqKwiYLKcAoqpA6SkcrIwA85
         i8U1UJ+kyRC/aFkfcvxnjOYzdFeQCiCIpoUuqEEfDl96FQMiJetCkeuc4EM0XLI1wMaM
         /j88NjBqiY/8YjoJb6vT2EBbGOhvE3LBgiVVdusziEKMI03wNdfe3w4Lg2lFnernOFn4
         gTjKwG5jIYWbhGF3lkzC203LiqiCVwAzl+YWkm2ZDzmPlAJUdeH2CEUypMvavKxhKM7e
         +xVw==
X-Forwarded-Encrypted: i=1; AJvYcCXhvhLwO/hsIbLJXurJWPpsm96XCJmoqVZfWHcmDiGtOoOqpMimLdB9uCfNRuSDiNyB5g1tXpiB5qN2WSI2G7X9oMBK
X-Gm-Message-State: AOJu0YxzekCIoAqphAG317L3z2GfYjK9e/ag+eOj5gj3jhQvBehLyZMC
	VeCeSIl6Sfhi9MZi8Al9vWvw7bweoeBFqc0vbXhAJJLiwmQescnQDq+aXkVbqi0u0onYSdXc8MR
	iGqziM5f/BjqXO/c771V2T8ZctVE=
X-Google-Smtp-Source: AGHT+IHd7Glo7i06A84Phl3Bjl48GloR5kQhNjHJ32mu+h0g+sIqYbtY7/NwLS3CEqszV/NWGA9oibfCru12ywsmERI=
X-Received: by 2002:a05:600c:55ce:b0:426:59fe:ac2d with SMTP id
 5b1f17b1804b1-426708f1fc2mr19891835e9.32.1720545824268; Tue, 09 Jul 2024
 10:23:44 -0700 (PDT)
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
 <CAADnVQKMVwtX+=h72Xj0t_ijiUQPVv6_6iKBmx4k1P3cO=AS8g@mail.gmail.com> <CAEf4BzZrZ=XBsNJzXRFdZQSkQyASKWzXbPwubOBbVD6=743Sfw@mail.gmail.com>
In-Reply-To: <CAEf4BzZrZ=XBsNJzXRFdZQSkQyASKWzXbPwubOBbVD6=743Sfw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 9 Jul 2024 10:23:32 -0700
Message-ID: <CAADnVQ+p7yV7Kstqjx4W0NMPBuQiFy7HSM-w9SycS4Gow9t_Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 9:49=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jul 8, 2024 at 7:09=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 8, 2024 at 2:31=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> > >
> > > On Mon, 2024-07-08 at 13:18 -0700, Alexei Starovoitov wrote:
> > >
> > > [...]
> > >
> > > > > the 32bit_sign_ext will indicate the register r1 is from 32bit si=
gn extension, so once w1 range is refined, the upper 32bit can be recalcula=
ted.
> > > > >
> > > > > Can we avoid 32bit_sign_exit in the above? Let us say we have
> > > > >    r1 =3D ...;  R1_w=3Dscalar(smin=3D0xffffffff80000000,smax=3D0x=
7fffffff), R6_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D=
32,var_off=3D(0x0; 0x3f))
> > > > >    if w1 < w6 goto pc+4
> > > > > where r1 achieves is trange through other means than 32bit sign e=
xtension e.g.
> > > > >    call bpf_get_prandom_u32;
> > > > >    r1 =3D r0;
> > > > >    r1 <<=3D 32;
> > > > >    call bpf_get_prandom_u32;
> > > > >    r1 |=3D r0;  /* r1 is 64bit random number */
> > > > >    r2 =3D 0xffffffff80000000 ll;
> > > > >    if r1 s< r2 goto end;
> > > > >    if r1 s> 0x7fffFFFF goto end; /* after this r1 range (smin=3D0=
xffffffff80000000,smax=3D0x7fffffff) */
> > > > >    if w1 < w6 goto end;
> > > > >    ...  <=3D=3D=3D w1 range [0,31]
> > > > >         <=3D=3D=3D but if we have upper bit as 0xffffffff........=
, then the range will be
> > > > >         <=3D=3D=3D [0xffffffff0000001f, 0xffffffff00000000] and t=
his range is not possible compared to original r1 range.
> > > >
> > > > Just rephrasing for myself...
> > > > Because smin=3D0xffffffff80000000 if upper 32-bit =3D=3D 0xffffFFFF
> > > > then lower 32-bit has to be negative.
> > > > and because we're doing unsigned compare w1 < w6
> > > > and w6 is less than 80000000
> > > > we can conclude that upper bits are zero.
> > > > right?
> > >
> > > Sorry, could you please explain this a bit more.
> > > The w1 < w6 comparison only infers information about sub-registers.
> > > So the range for the full register r1 would still have 0xffffFFFF
> > > for upper bits =3D> r1 +=3D r2 would fail.
> > > What do I miss?
> >
> > Not sure how to rephrase the above differently...
> > Because smin=3D0xffffffff80000000...
> > so full reg cannot be 0xffffFFFF0...123
> > so when lower 32-bit are compared with unsigned and range of rhs
> > is less than 8000000 it means that the upper 32-bit of full reg are zer=
o.
>
> yep, I think that makes sense. This has to be a special case when the
> upper 32 bits are either all zeroes or ones, right?

yes. exactly.

