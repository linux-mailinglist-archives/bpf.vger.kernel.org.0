Return-Path: <bpf+bounces-68606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44C5B8006B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8FA326FA3
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 02:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A5131BCB3;
	Wed, 17 Sep 2025 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OejWsqPU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821552F6198
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075576; cv=none; b=MeWuZmHy4aRcLESqdFEP83cLN5kDKhjL7c0RUMZ7q7jECZ6XXktzMfEXgOdzj2xLK1mDYE1azUoJdRzJ2BPELUH16qDCDObM1LwRtni0YUaXx1WjPZ8e3+eiwaLewG5FL2XDrZhqa91Hf0a1f4ZbtPToGausNvZxVirGGghSCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075576; c=relaxed/simple;
	bh=xakUHcSxG51TK974GMK75WErogVEb5onzGCuYJsOLTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2ogLlhapxQ4W5QosofKlK6gbdzFSpSVDxYHq3UVjlBBhLUXVenW7T7JwuTk2zb5EQBsBis870dF5UNrKAyw4JulcMp0dFW6zF6RBQ8Ww2d7KUvF4S388syOZ/Mv4UtzosX2Wheba15vHmVEShsx5cTR7vJej/uu0ZKZO20Sw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OejWsqPU; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-62f261a128cso5360502a12.2
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 19:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758075573; x=1758680373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xakUHcSxG51TK974GMK75WErogVEb5onzGCuYJsOLTw=;
        b=OejWsqPUyQkOy7/IdoOdz2R2yFREaQjEG2grDOM4T7e5On9bHESf3+aNoAK3x7h1c3
         NOWqCRCedko6qICuSFKIIjjVxv7aArOPo2m3o2sNIC+d1WIvBt6v4fsOhe8KRQ6h1ifQ
         GxHTwsULx2hmf1zpYzYPtgwxiTbb7DJS2rAQBdoHVu8YzJmr3Q4S6IKUbXGgrhJQ4L26
         EtvesUhSt1I+p+PAQrhNAYxDMn7dbfnBA0i1IjrJ9b4CBXkWOlIUXwn/rLfvTJGFQ1tb
         l25A/GUYMnStTqTEek+618Rj/PDMAodj+bNWsu3AeNuG5UlT1cwo/dVMJAdQ5wctaKHt
         L2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758075573; x=1758680373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xakUHcSxG51TK974GMK75WErogVEb5onzGCuYJsOLTw=;
        b=Pp94+eQtyEJdkcpl4t2dTswsOAj9c1WYOGB2ggCEDFh4SS9MKDfRgvxLkWIArQHpn7
         xXhWLyKBQqj6jyKgkQB/RCKgNZ5FpoqmZW6lUw/CGIPz4wSw+4U92X8Vou6Kc1psnIwg
         iulyatwN+nHlVeEBwloEQ1ZVh6IizqZz6LPnY3Kep54qqtuZyz1BSitDC2BjSxnGWpbf
         0sdXmcxZ245g3BzAo4f2iR771CdEcRKnLq2yRimnxwgwlMi9Nm6sM2dJQrhE883dk56n
         js8OxYn4o4izI883pgcKAqdWZFw6OyFRQU5aM7E/N3rJ15df4aReYQ33hlm3KPcaOCMJ
         VaMw==
X-Forwarded-Encrypted: i=1; AJvYcCU960XX/rl7NGhQykTHOfVkLp47jib8/ayqlt+pDzXXT+emjOdz09JG9dEr7pp4bAXTERg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Ea8l3BA2ht6itYeA/8XkaK3GCyeq2TvV+ts2ECl7QGqNjqw3
	uW6C3n7+Lp/EaDeg3WiYeJRJmipXnhkOdqorY6sVyR6djYEC8c5W5lZCIfY7PG6tAqBYhb5pRfL
	fy+von+XqWIzvzsdVaCbIw/PvGfgVnwU=
X-Gm-Gg: ASbGncvxzE96lh+yXfO7B4FDTOFqKP/qcCq8CRJZn+4w+nlpcTwTy16tmWtwvm6soHS
	a5b4oCVmZr4CDIsdz/3wCTw8aW6aThoMQeUu9eAKMn4+A7JUjULGs9zHX6Q6NCruI1XZpkdG58S
	yvUKUOTKchvM8ivygqLS3N3i1I1O9SUlRgMVwYNA7MbT/Bc2aANUlazZINoELVx5A4FZ8ncbWkJ
	pofcEC3Cg==
X-Google-Smtp-Source: AGHT+IHZDyMYnh1embxurwQKHPvtQw5r5k0pL37qvf6xM+ZyWor6G47sMCGSkqpADClUXoxMyuueNjTaPbhAAq+D7FE=
X-Received: by 2002:a05:6402:51cc:b0:62e:e5b3:6388 with SMTP id
 4fb4d7f45d1cf-62f84234682mr761291a12.19.1758075572845; Tue, 16 Sep 2025
 19:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915024731.1494251-1-memxor@gmail.com> <20250915024731.1494251-3-memxor@gmail.com>
 <aMeuunTYM8c6jp1m@gpd4> <CAP01T74DSRE96FYRCMLghkFJdNPgi-PhoOycQ2fXyYhUF5ngBw@mail.gmail.com>
 <aMfIMOF17vFVrfTt@gpd4> <CAADnVQLpYMMhPjxJ1R1GMQ_+yMuZjZxS6XOPR-ntJHHweK8N1Q@mail.gmail.com>
In-Reply-To: <CAADnVQLpYMMhPjxJ1R1GMQ_+yMuZjZxS6XOPR-ntJHHweK8N1Q@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 17 Sep 2025 04:18:56 +0200
X-Gm-Features: AS18NWCa0U7avsf2goKlCjDJqvPQ-cYN-zMzRV212HTK6AX2LPsIK_wWCudRzC8
Message-ID: <CAP01T76Cri_MuY5-ioFa7hJW2J_f-R=cr0AjNt7sEpVg4=Tb-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Add support for KF_RET_RCU flag
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrea Righi <arighi@nvidia.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sept 2025 at 19:55, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 15, 2025 at 1:03=E2=80=AFAM Andrea Righi <arighi@nvidia.com> =
wrote:
> >
> > On Mon, Sep 15, 2025 at 09:13:15AM +0200, Kumar Kartikeya Dwivedi wrote=
:
> > > On Mon, 15 Sept 2025 at 08:14, Andrea Righi <arighi@nvidia.com> wrote=
:
> > > >
> > > > Hi Kumar,
> > > >
> > > > thanks for looking at this! Comment below.
> > > >
> > > > On Mon, Sep 15, 2025 at 02:47:30AM +0000, Kumar Kartikeya Dwivedi w=
rote:
> > > > > Add a kfunc annotation 'KF_RET_RCU' to signal that the return typ=
e must
> > > > > be marked MEM_RCU, to return objects that are RCU protected. Natu=
rally,
> > > > > this must imply that the kfunc is invoked in an RCU critical sect=
ion,
> > > > > and thus the presence of this flag implies the presence of the
> > > > > KF_RCU_PROTECTED flag. Upcoming kfunc scx_bpf_cpu_curr() [0] will=
 be
> > > > > made to make use of this flag.
> > > >
> > > > I'm not sure we actually need two separate annotations, I can't thi=
nk of a
> > > > case where KF_RCU_PROTECTED would be useful without also having KF_=
RET_RCU.
> > > >
> > > > What I mean is: if the kfunc is only meant to be called inside an R=
CU
> > > > critical section, but doesn't return an RCU-protected pointer, then=
 we can
> > > > simply add rcu_read_lock/unlock() internally in the kfunc. And for =
kfuncs
> > > > that take RCU-protected arguments we already have KF_RCU.
> > > >
> > > > So it seems sufficient to have a single annotation that implements =
the
> > > > semantic "this kfunc returns an RCU-protected pointer".
> > >
> > > Yeah, that seems reasonable in general, but we already have iterator
> > > APIs (bpf_iter_task_{new,next,destroy}()) that collectively require
> > > RCU CS to be open throughout the three calls. That's why I just
> > > cleaned up the internal logic for KF_RCU_PROTECTED and made KF_RET_RC=
U
> > > as what you're suggesting (i.e., fold KF_RCU_PROTECTED into it), whic=
h
> > > I assume will be most useful for the majority of kfuncs that are not
> > > iterators.
> >
> > Right, my suggestion was to fold the KF_RET_RCU semantics into
> > KF_RCU_PROTECTED, even if the kfunc doesn't return anything (assuming i=
t's
> > possible). Then annotate both iterators and kfuncs that require RCU as
> > KF_RCU_PROTECTED. This should handle both, right?
>
> +1 to this suggestion.
> I think we can extend KF_RCU_PROTECTED semantics to mean
> that the returned pointer is only usable in RCU CS.

Ok, I'll drop KF_RET_RCU and use KF_RCU_PROTECTED to imply it in v2.

