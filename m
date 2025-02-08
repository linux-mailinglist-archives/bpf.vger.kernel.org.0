Return-Path: <bpf+bounces-50841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEECA2D35E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 04:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E75E16912E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832DE154C12;
	Sat,  8 Feb 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhzlF8ID"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F872913;
	Sat,  8 Feb 2025 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738983917; cv=none; b=s/n6RYghFgmPWKndAUq2PjaFzs42rzeyLcT88NJKSVGwG6QpBVXJxnrn8QmXZXPzkCEtuT8wLjkLNoH0+IiDzQgz/5g+v424sV8YtEkgDqcq6MOZfTyvtP2PywRCmvLUO46EaoduMNk/77M5VPpbYCuxwwVbtmRcmPAHuBUFVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738983917; c=relaxed/simple;
	bh=TzmqDzYGQgVK8cdD4p506whmnqwFluvlLBcALDqDDCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgzpxcN6Yo1+O5F5QUuosRNuktU/3Dpnxor/HdsdHYDn9gMHGouPoXeGOQA20Ss1+qZVXqE3JPfZ0FE62IxLzk6ixq5wwX8nVYffx+zEMHP04Eyiuf3N0Ocf02fIJI0VDyhKo4Q02qNmBuD1IhE3uF5X4RvM99M7nGBZpBZkp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhzlF8ID; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-aaec61d0f65so598568666b.1;
        Fri, 07 Feb 2025 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738983914; x=1739588714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXsoVb49IoYpLimFHVX1TtKxtLgXJzuvc+JHpYXHaWA=;
        b=PhzlF8IDNZonxdmA5sOFnYe9jLjat6/IKDqi8JP2zdONLaRgyry/ufarlKTxN0pmVP
         7IWQ31jU7ja5ATvTvtdY5r7AQ2L43ajRJOe5kT6Shkzu5iD2boB7TYmwRwqhhvCJhsSh
         U3ko1GkfQ9OLYl/40Ca6X+tpM2dZYRy2owwPeifb3JTDtwtPmLWc8glO+h0MBKBk7NEy
         NYzobjqbjJkKlN9+43Tc47E3TBmZTA645YVKcqHUoBpT5yU/dVZtfSsWcoXD5S4QgH0l
         kup5uIGFauXItODpSzJyfaKYNld4+EEpwgc1iJG4847f12or8U+jbg7aOmO1J/HHg4m5
         zhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738983914; x=1739588714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXsoVb49IoYpLimFHVX1TtKxtLgXJzuvc+JHpYXHaWA=;
        b=W9m/j1D7gbAqFkBImILvygixKYLdvQSur2ppJ7YC44AG9i2lfYYAOVNfunxU5sNgx/
         yx6oG3PI9zqk2+DdPrkhi9vrH/xhfTcNbLlXFUuy6esW29yiy/A8Fcue9KHO6wHrp3Ji
         DlD6ijlShVcbBPYs/QyxM/BrkcJUllKEnntgbSEirlRhB0Mrfh0VFpg6lgJlQHhK9Kx3
         IIj/JWTFG1ryn5Zg5OzdkU6WAMx7Cp21GZPbT1mqXmNzbZ+YuQH+ByIonfFZRoZKlzaq
         cUYn7NNldX7CTA3CAUJaQQXB3djsxAmeG35clqX/9DL0J+2wRAMUwmbFW+tzC2Z3xps6
         832A==
X-Forwarded-Encrypted: i=1; AJvYcCX8Ub/OHkzALYwIpVxZwXmlSGRxH52Pm+lvZdN+Lxr1cXPXOcYfizufB6uja3obs6GwVILeaHjMJYKpq/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB1rH4QFQ2KeR8FEPAlr6z5RyrP4QyR8zteoSU4i9XEbfdKJ42
	cO8royVccG7LyuSGwYXnA1zhU/mrXSmUHPxgEoHV1qK0uRuq+A50mFRv2JOpKxEiDKpaeNEE3Co
	Z91mRn9iA1hemymyrje0/Hx7MQTc=
X-Gm-Gg: ASbGncsLmgn8DaTO4knAqsePgTXNO78W80Gv85aw45mSwEYuZsobMu4fSXfsyjsEqDp
	IRtSPcHEztDYp/uLeKhWGFGo23SE/Qe5A5UltXBuSVV9rfaXcEJczDN6yAkFdvSlo+SC1vceCb7
	4=
X-Google-Smtp-Source: AGHT+IH8ynq3kX2SXHDaNclM5UaiOBAlcWVm1t3XkbaGQlkH/s3K+JRKmKWgLtG+LKW2WuSR9LMpnrIQ5UKtss3Fd3c=
X-Received: by 2002:a17:907:c04:b0:aaf:74d6:6467 with SMTP id
 a640c23a62f3a-ab789cbe9d5mr626346266b.42.1738983913450; Fri, 07 Feb 2025
 19:05:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206105435.2159977-1-memxor@gmail.com> <20250206105435.2159977-18-memxor@gmail.com>
 <CAADnVQJFRgidWdA72Op762HXg9y1s4CJQB_5rmB9iqCNzGEuWg@mail.gmail.com>
In-Reply-To: <CAADnVQJFRgidWdA72Op762HXg9y1s4CJQB_5rmB9iqCNzGEuWg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 8 Feb 2025 04:04:37 +0100
X-Gm-Features: AWEUYZnsIBx9dn-klfxb-EQ9WKLOzaRhZbxIO6uDw6vw94PBIsvzKyoWXDR1-io
Message-ID: <CAP01T76xXrr9OzJn82S36t++S8wjiaZS5RXEKJ5V7EpD1wqinA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 17/26] rqspinlock: Hardcode cond_acquire loops
 to asm-generic implementation
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>, Dohyun Kim <dohyunkim@google.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Feb 2025 at 02:58, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 6, 2025 at 2:55=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gm=
ail.com> wrote:
> >
> > Currently, for rqspinlock usage, the implementation of
> > smp_cond_load_acquire (and thus, atomic_cond_read_acquire) are
> > susceptible to stalls on arm64, because they do not guarantee that the
> > conditional expression will be repeatedly invoked if the address being
> > loaded from is not written to by other CPUs. When support for
> > event-streams is absent (which unblocks stuck WFE-based loops every
> > ~100us), we may end up being stuck forever.
> >
> > This causes a problem for us, as we need to repeatedly invoke the
> > RES_CHECK_TIMEOUT in the spin loop to break out when the timeout
> > expires.
> >
> > Hardcode the implementation to the asm-generic version in rqspinlock.c
> > until support for smp_cond_load_acquire_timewait [0] lands upstream.
> >
> >   [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.aro=
ra@oracle.com
> >
> > Cc: Ankur Arora <ankur.a.arora@oracle.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  kernel/locking/rqspinlock.c | 41 ++++++++++++++++++++++++++++++++++---
> >  1 file changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/locking/rqspinlock.c b/kernel/locking/rqspinlock.c
> > index 49b4f3c75a3e..b4cceeecf29c 100644
> > --- a/kernel/locking/rqspinlock.c
> > +++ b/kernel/locking/rqspinlock.c
> > @@ -325,6 +325,41 @@ int __lockfunc resilient_tas_spin_lock(rqspinlock_=
t *lock, u64 timeout)
> >   */
> >  static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[_Q_MAX_NODES]);
> >
> > +/*
> > + * Hardcode smp_cond_load_acquire and atomic_cond_read_acquire impleme=
ntations
> > + * to the asm-generic implementation. In rqspinlock code, our conditio=
nal
> > + * expression involves checking the value _and_ additionally a timeout=
. However,
> > + * on arm64, the WFE-based implementation may never spin again if no s=
tores
> > + * occur to the locked byte in the lock word. As such, we may be stuck=
 forever
> > + * if event-stream based unblocking is not available on the platform f=
or WFE
> > + * spin loops (arch_timer_evtstrm_available).
> > + *
> > + * Once support for smp_cond_load_acquire_timewait [0] lands, we can d=
rop this
> > + * workaround.
> > + *
> > + * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.a=
rora@oracle.com
> > + */
>
> It's fine as a workaround for now to avoid being blocked
> on Ankur's set (which will go via different tree too),
> but in v3 pls add an extra patch that demonstrates the final result
> with WFE stuff working as designed without amortizing
> in RES_CHECK_TIMEOUT() macro.
> Guessing RES_CHECK_TIMEOUT will have some ifdef to handle that case?

Yes, or we can pass in the check_timeout expression directly. I'll
make the change in v3.

