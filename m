Return-Path: <bpf+bounces-34188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2992AE06
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 04:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D96B1F21F16
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C72374D1;
	Tue,  9 Jul 2024 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q93DuGaP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4EA4204B
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720490985; cv=none; b=BYaSSP8FGvKE79+NWDxoCVOgjA1LoPxmbNQ3Mpn7YTvok2y6IenaVCG0ADNdFqmbraAXLYaVLMJlj/i2CBAWEA3wY/TsSUgLn5iysXS0zbQ1AVpcOsCDyrokUeoGpR0SD/2xlj4qVtU8w5gPHNq4Wh66EA6E4mCFHeM2JAnKwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720490985; c=relaxed/simple;
	bh=fWCY2a2tXFl3KBIC+lxmPi2xs4qK84qzG1jmX2+ARvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tiq8L5ER6kG2cdl4zRb0ZRL3m2n7Kmu+Gp+hdyPVjDIhAW2mTcXqPDsHJo8SbL+K+HFHd9khIkxwl7H9h4qwVLbXz43Psywtg90sSrKIZ3twZt0cMZ2YsYeswh5xpL6pLrKcN5smDw5CB9khZm4vP2otNk+1NoiebTLUI6EkK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q93DuGaP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3678fbf4a91so2379145f8f.1
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 19:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720490982; x=1721095782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8QWcdaSz7uKR9RkLtcWIn88z7W5bKpr2Ysv9Kcy3OU=;
        b=Q93DuGaPyp6DdKshch15467sM3MWciS8YMOQDrJ/VA7KokQ0TsUwHJE9VIesYp+UYZ
         oX2UboYnq/9InN9rb76s+TFKqzi1myAbqNud7l9HfJgmpiQ3viSmP87tNEU3lIYQYm33
         iGXv90vVYLYdcgWgrroyj3eQn5/pXLZkqYF6NDZ8USfYPXFvjxkAni0cqQDtPSnvSynl
         Zt5PzCBreW2I0ADUCEF0oLdvBeGRYVBSY3YJXuaCKZOyr6B7d23LDd/82Y+PxZzuS+zY
         VNg1cotgwzw06lAMMTyUFMJ6aEY5v3vw8u7rzq/SE91DAj50reww/C2f3s6WMVjpEodZ
         FWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720490982; x=1721095782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8QWcdaSz7uKR9RkLtcWIn88z7W5bKpr2Ysv9Kcy3OU=;
        b=qZS/4A1yv54q40oZeOh4gL6bJdfy9Erv1kK5ZTY/+Ft1+X8fGuW6T82ruMj5wxLGER
         YQAP//vToODeIsY/Aq0K17oS8dCLznGHQotXSsyR69wRNpUzLYfO6oycgjzVdjW6L2t2
         1lG9pnHIaSeRBhgTqanopSkFsr5cYPs6IW6v1zxlOc7C0rLVX+EW6UDqkWKtv17HUfTU
         Nikf6ojqg1tOrGoq7g+d3iSBd8/nN4kodJcZNqY2iVR1WjlolCaLmMUPDQhTSX8n931B
         fnNSGkSpcWIjMrvRi41UlzYP8QNNor+ifGf4n6gqa23udmYL9dBS5JhfiZymRJfngEIl
         STzw==
X-Forwarded-Encrypted: i=1; AJvYcCWaCOVAaXqfNFJHQ3Qwlx1QmW4Dtg9ZFLKKwif6fVdrhdzmGCrC2dO9Jy0UCZeBg5lzlFqmWZSi9hexrXKgD95eLwIh
X-Gm-Message-State: AOJu0YzCAgoPnZwWR0vOKg2u7meq0ja6wNwDrmRkQwvdibLgbHgjUVIF
	L0qHNn7q2Z9qWauEvVmjl2VFTZP4qa61iac6VE7Ymizz+6JI4f4hwhMqaXpVatF9Jx+Z9S/QNbG
	c3EADT9vVx5o/Zbu+6IKWOhp2ao2iezqbz4g=
X-Google-Smtp-Source: AGHT+IHFfJFkATNLhDyGA4w/XqCa8IziWZuBNMNKII3hlgpeBI9TfzDWFR6lyIER2v/YOW5LpzohpuncO+Sj36/6ebg=
X-Received: by 2002:a5d:4108:0:b0:367:8ff0:e022 with SMTP id
 ffacd0b85a97d-367cead9274mr750321f8f.63.1720490981691; Mon, 08 Jul 2024
 19:09:41 -0700 (PDT)
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
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Jul 2024 19:09:30 -0700
Message-ID: <CAADnVQKMVwtX+=h72Xj0t_ijiUQPVv6_6iKBmx4k1P3cO=AS8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Workaround iters/iter_arr_with_actual_elem_count
 failure when -mcpu=cpuv4
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
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
> The w1 < w6 comparison only infers information about sub-registers.
> So the range for the full register r1 would still have 0xffffFFFF
> for upper bits =3D> r1 +=3D r2 would fail.
> What do I miss?

Not sure how to rephrase the above differently...
Because smin=3D0xffffffff80000000...
so full reg cannot be 0xffffFFFF0...123
so when lower 32-bit are compared with unsigned and range of rhs
is less than 8000000 it means that the upper 32-bit of full reg are zero.

