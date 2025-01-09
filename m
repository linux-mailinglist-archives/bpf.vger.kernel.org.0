Return-Path: <bpf+bounces-48349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9AFA06C54
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 04:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F983A73A3
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A8C13C809;
	Thu,  9 Jan 2025 03:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExcvM8rf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC882AE8C;
	Thu,  9 Jan 2025 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736393852; cv=none; b=Cj+WnncZ6Br6n0FvPNljpW32Tz3P2gBvZJN98s4YWM0ilPtLxQ/0VxemQVZFtiPvJ7JWqZNivChBaLJtauXr8kcFpl35CumAx/z3Geq5r4Mfp4lJ0sRexKOCvJKUihWlhJ63A5o3aq1nYJju8oALHK5lQDayfan5RA3w8VUK0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736393852; c=relaxed/simple;
	bh=ZXdCdsJNkgU89wUk5U+HQM0933ywLJ5SapFOJ1Lx2Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMX4LVNrF/JdstodblASxNs4JZDnju/xf1z2oEVQsXH7XKKSzy4grdDKoPtDYVe3sCzjRTS1ndW2waijO92mk/B93tkMAZHJYavsXJBjVYWJgVJ+n4ytooY2lZWKShFbHNXf+xRP3Ykj+mL+nr2AyVMrnPLNpw416hHe7jCizvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExcvM8rf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso5129955e9.0;
        Wed, 08 Jan 2025 19:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736393849; x=1736998649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ORU6Xkm3nKacvlYo6nv7Q0Jr6/5KLUa/C5xz25p9M0=;
        b=ExcvM8rfRbgwnd4YX01H0v9bVuYGN0N4V2mZxlcCZuRFKZvbylwvLNYRJ/Zi9dyW3m
         PsAAb8h0Pj3O7TpED/UbycrGB6TV6WszTspxUi59Nr3tm6WrviVKqkmZ4yFghvFgmrtn
         Vl9ERThU7UrqGpUXwLfmgksrwdl82lJkYJOLsTmfj1s0KA3x/wQWDbCoX3H03kDEzY+o
         A4t71ne9Pig60Vzbuk+ZNDFCvbSi4n0AytfNP5mQdNugNMTZ6LvJsWmEJWTFaUHprvnC
         AU8xdTz+fhjwxWIW8RFOGJ4jStG+3jcQ/i/ZX0xD7Q0/5oR93zRw3t1bVxVelqr3lTa3
         2jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736393849; x=1736998649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ORU6Xkm3nKacvlYo6nv7Q0Jr6/5KLUa/C5xz25p9M0=;
        b=BktNsQ54oYwl1t3QuPyXKidINdMeNgeELFVZC7cFiv3UrT+31ocAiHPPeICOPEoBLa
         /EoESuCsaXgWLFnNRctCIpqVK3hQ7QH6Bx5fUhy71RNPZ60MujxB2sSV6IVWL7B7LbE7
         pu0lyzO14OueOnsijI/lxVKDM6SkHJpr1tCctstyeMPXQgz8au0BygmWUyCK44aElTJP
         Vprxbr9/JVVi76kU5V1V4twmlqTkUfezum29/QmI7Y0WfM/jUA6nAXD8TkcFVBablPih
         eqQiElkr1xg+KBA0z/1xyaUfbaf1R/8YbE5RxhCNeXB/e8nQQvpcbxQ9zpfzwxX2AXNu
         Icqg==
X-Forwarded-Encrypted: i=1; AJvYcCUsqD3kgc3UvNUqx7o6oeNpduvw3+ufftAGv8Fho1cnm1FhQ2VNFQNLohWbMVxiscKrfKbm6Se02LG+SqUs@vger.kernel.org, AJvYcCVUx5PpjPz8lZ8by4x8b+wzTeVW9cptn8JRLxEhT6+kkV2q4mHsmZ646b290FEd3Y5YqCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK6A6uLCfcce6tbARGUt03h2A3IWXkN++Xe+BYnXszRAz0higQ
	ikOfeU28a10IdByxO6+AUw3OWMfUIb0uURx2SaNvLssD0B7g7diJZZej6T7Mm5DMHLoMuFqoyBf
	SDfVFj0GPqG9pibDN9vanGnieTik=
X-Gm-Gg: ASbGncstyG7uJaWMchS1LyA9tO35C5ESVC4dt0wV6facMPKy9LN7akA9omaYPmzb03L
	NDmdT7YPyfV20wKzyVh306v6EvCN9e/3n3ewdkDbXb4V4iNRv7OSCFFHLvHxtsTKcO55OHg==
X-Google-Smtp-Source: AGHT+IEauhNcG9GFO/0Pd979d1LEguv/Em2HieQo/6cswJX08nIPSBn7T4pIn8gmUkTHl1pIvyuFeHQZXBIvOCUy/3c=
X-Received: by 2002:a05:6000:460b:b0:385:dffb:4d56 with SMTP id
 ffacd0b85a97d-38a87317e45mr4165626f8f.53.1736393848922; Wed, 08 Jan 2025
 19:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107140004.2732830-1-memxor@gmail.com> <20250107140004.2732830-13-memxor@gmail.com>
 <2eaf52fb-b7d4-4024-a671-02d5375fca22@redhat.com> <CAP01T74UX4VKNKmeooiCKsw7G6qkhohSFTXP0r=DZ1AuaEetAw@mail.gmail.com>
 <dfbaf200-7c87-41b2-ab87-906cbdf3e0d7@redhat.com> <CAADnVQJdPNOOXzQvTTx_i4yYYAoOKe=u7yHJiRHSt8O13vp6VA@mail.gmail.com>
 <7f1c3db7-a958-4bb5-b552-a20fb5b60a2e@redhat.com>
In-Reply-To: <7f1c3db7-a958-4bb5-b552-a20fb5b60a2e@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Jan 2025 19:37:18 -0800
X-Gm-Features: AbW1kvYmgRCJ_j0zvu3Q-eAILl6ho_DWWS5FuoOHF6eTNJrMC_4x6PE-x76lspE
Message-ID: <CAADnVQ+_eBZo5yTWpEd2pdv-dd3x=KEbqU=8awbyW3=9wm9nUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 12/22] rqspinlock: Add basic support for CONFIG_PARAVIRT
To: Waiman Long <llong@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 6:58=E2=80=AFPM Waiman Long <llong@redhat.com> wrote=
:
>
>
> On 1/8/25 9:42 PM, Alexei Starovoitov wrote:
> > On Wed, Jan 8, 2025 at 4:48=E2=80=AFPM Waiman Long <llong@redhat.com> w=
rote:
> >> Is the intention to only replace raw_spinlock_t by rqspinlock but neve=
r
> >> spinlock_t?
> > Correct. We brainstormed whether we can introduce resilient mutex
> > for sleepable context, but it's way out of scope and PI
> > considerations are too complex to think through.
> > rqspinlock is a spinning lock, so it's a replacement for raw_spin_lock
> > and really only for bpf use cases.
> Thank for the confirmation. I think we should document the fact that
> rqspinlock is a replacement for raw_spin_lock only in the rqspinlock.c
> file to prevent possible abuse in the future.

Agreed.

> >
> > We considered placing rqspinlock.c in kernel/bpf/ directory
> > to discourage any other use beyond bpf,
> > but decided to keep in kernel/locking/ only because
> > it's using mcs_spinlock.h and qspinlock_stat.h
> > and doing #include "../locking/mcs_spinlock.h"
> > is kinda ugly.
> >
> > Patch 16 does:
> > +++ b/kernel/locking/Makefile
> > @@ -24,6 +24,9 @@  obj-$(CONFIG_SMP) +=3D spinlock.o
> >   obj-$(CONFIG_LOCK_SPIN_ON_OWNER) +=3D osq_lock.o
> >   obj-$(CONFIG_PROVE_LOCKING) +=3D spinlock.o
> >   obj-$(CONFIG_QUEUED_SPINLOCKS) +=3D qspinlock.o
> > +ifeq ($(CONFIG_BPF_SYSCALL),y)
> > +obj-$(CONFIG_QUEUED_SPINLOCKS) +=3D rqspinlock.o
> > +endif
> >
> > so that should give enough of a hint that it's for bpf usage.
> >
> >> As for the locking semantics allowed by the BPF verifier, is it possib=
le
> >> to enforce the strict locking rules for PREEMPT_RT kernel and use the
> >> relaxed semantics for non-PREEMPT_RT kernel. We don't want the loading
> >> of an arbitrary BPF program to break the latency guarantee of a
> >> PREEMPT_RT kernel.
> > Not really.
> > root can load silly bpf progs that take significant
> > amount time without abusing spinlocks.
> > Like 100k integer divides or a sequence of thousands of calls to map_up=
date.
> > Long runtime of broken progs is a known issue.
> > We're working on a runtime termination check/watchdog that
> > will detect long running progs and will terminate them.
> > Safe termination is tricky, as you can imagine.
>
> Right.
>
> In that case, we just have to warn users that they can load BPF prog at
> their own risk and PREEMPT_RT kernel may break its latency guarantee.

Let's not open this can of worms.
There will be a proper watchdog eventually.
If we start to warn, when do we warn? On any bpf program loaded?
How about classic BPF ? tcpdump and seccomp ? They are limited
to 4k instructions, but folks can abuse that too.

