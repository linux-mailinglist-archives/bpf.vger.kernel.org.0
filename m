Return-Path: <bpf+bounces-63112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CAB028F0
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 04:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB035A53C1
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F7413B2A4;
	Sat, 12 Jul 2025 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0xrNGJx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077F17993
	for <bpf@vger.kernel.org>; Sat, 12 Jul 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752286781; cv=none; b=RZdaoK1Nd7yNofyoKdFi/r7TVyJJk6qU1wji4BB1xthtzUgSJ5hQtKLaQHCoyjDZ0meO3Yf8iEIRYL+lpgIuPsRGy3dAuuCmw9S10OIrJDoNulKlq18YSplTYgurFwh2ydlW37qaf0bWz4sw/MCpNNSNOOk2ygMWiPmqEl4Kw5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752286781; c=relaxed/simple;
	bh=63J9KNAHiw/2c/WgOpkyxQLkDgfmYd+h/sbSMf0VU4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPcdGaviR5IPKTb3uhqzyUuPLNeEpqB7XDQFL31E2qepSxIE99nFfd3A1iMg2JKwGnHJwo/oU/Zwrp88C83qmjsFUKVAmvllAu0t/7fxImambWLo3r4JZyggzZvOHqo4dYPaqy2vfQ5RBST62Cfh1F3o/WKv/j3rs1DabeWIiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0xrNGJx; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45348bff79fso32709295e9.2
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 19:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752286778; x=1752891578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uiz+Wjac2zk6sV3PXzlRZmsGBC8DDXKjUcG6BLxmh7c=;
        b=d0xrNGJxz9A6T4Y54wr1yESsSehb6oRlhL5E0azBdiMZ4ArAnJmlbR9g9uj2e/aBwL
         xIWY45HbYSrhG5AT0cQ+WRiBjJo84MMbTu2KEYMERNqMkJVB6SZgK0atdiwXl4+9ChFE
         eQZ8jwBT82VKfEl9kaF+J5IAcofcdF0QiKCKHhi8gTumyy/V6vmob3NWMDQd0+NT7ETN
         pmDwXGGbCkQvlEB5F91y84g4zJtkzKkk0H7jeRlSPQrKAsp1fehnQDnPXrIsFDyCG/BS
         H6PJCTic2qHKAuQpXlu/PmuEYLhkLAT8LITloo32kWStJGffa8OvxjOI75gtQowlxdey
         74vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752286778; x=1752891578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uiz+Wjac2zk6sV3PXzlRZmsGBC8DDXKjUcG6BLxmh7c=;
        b=fL89g8Vk2WtDCZhqjML1AoNGGmF5Hi7lzbeB0XAm2nQgJlWfUMgfQs8aQyJn8blEI+
         8iQUAo/SGMQfhYP3X9fHEoKB0B26EKrdQ4HzAVf3vEcU/Pyr+U+ctCtNa6k6ft49rVyM
         oks0rwHa//r/BxRhtxsFb8W4UNpOv9NhkHqIkSVQfR0gRoRhyOYuHfQszcOXEAUBDHLk
         qAPFSrHPQgggGRihloT10STXJHNZK8JRTAUFkLHwGvJKisph3dfsYXXBmwpGOsSfCElZ
         MnPjFNjQ2/h3kGY1K13AZUFzzSJw2WDI3PvxcrBnWxMLRP3Ou9o3UpnLmPUB31KjatBy
         UEKg==
X-Forwarded-Encrypted: i=1; AJvYcCU2WGfAcHOuzA1onKmtyRgYuj7y7B34jsT+R1x0MQf2J0m9MIilFq81sQrRe6I0vL7DvAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw32R7UM8U5IPimkaX6sijCTWOA18vqM95IoLoYKYno/KU7k7Ao
	RAyih4IYsDEcGDfunnH62xvVlx20/sXZ2zNpwYbLMHCfOBCQ5TKcuZRNQFLh2RB+dbpL8gIRgp0
	0XPYuQlzipD+e3cgvs825stvp3sav0Ac=
X-Gm-Gg: ASbGncvyusssNlJcglB9ExXPzFyHtvdigL3qClJlY7JP6pqT32AkKnKfqic1PIErTHN
	alCPiFovx2I9lKk38mRBdbKxa9Ujt+AnQDTUhRMD8iDsx5z2o6rOoJzCfTw6il+Xniq/neGuN+r
	m4zeMXgj2Yz7FifZNGNSJwUn3ln9b0Vg8EtkwXK3KAV/tc4gZe0SME8VvETNL63WZoaH+tkcDiX
	vEyGmYnLpvZBBli1wupZ3+O/QoLPDgFXqAM
X-Google-Smtp-Source: AGHT+IHK1A5wZKfGjQ31k8QtcClWeGZN6HXl0c3a+iM/D3LUG/K8rSyF8bRBt6IW0sDLde25WiRJfSHIr5Not4VEewY=
X-Received: by 2002:a05:6000:22c1:b0:3a4:e6e6:a026 with SMTP id
 ffacd0b85a97d-3b5f2e1b3d4mr4431436f8f.28.1752286777971; Fri, 11 Jul 2025
 19:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com> <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz> <20250711151730.rz_TY1Qq@linutronix.de>
In-Reply-To: <20250711151730.rz_TY1Qq@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Jul 2025 19:19:26 -0700
X-Gm-Features: Ac12FXyW2V7duVfO2RxQqGtBjl5d5azhqldja6Jh7VAngRU8ULFXtL5-v2QSK9I
Message-ID: <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce local_lock_lockdep_start/end()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 8:17=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-07-11 11:55:22 [+0200], Vlastimil Babka wrote:
> > On 7/11/25 09:50, Sebastian Andrzej Siewior wrote:
> > > On 2025-07-08 18:53:00 [-0700], Alexei Starovoitov wrote:
> > >> From: Alexei Starovoitov <ast@kernel.org>
> > >>
> > >> Introduce local_lock_lockdep_start/end() pair to teach lockdep
> > >> about a region of execution where per-cpu local_lock is not taken
> > >> and lockdep should consider such local_lock() as "trylock" to
> > >> avoid multiple false-positives:
> > >> - lockdep doesn't like when the same lock is taken in normal and
> > >>   in NMI context
> > >> - lockdep cannot recognize that local_locks that protect kmalloc
> > >>   buckets are different local_locks and not taken together
> > >>
> > >> This pair of lockdep aid is used by slab in the following way:
> > >>
> > >> if (local_lock_is_locked(&s->cpu_slab->lock))
> > >>    goto out;
> > >> local_lock_lockdep_start(&s->cpu_slab->lock);
> > >> p =3D ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
> > >> local_lock_lockdep_end(&s->cpu_slab->lock);
> > >>
> > >> Where ___slab_alloc() is calling
> > >> local_lock_irqsave(&s->cpu_slab->lock, ...) many times,
> > >> and all of them will not deadlock since this lock is not taken.
> > >
> > > So you prefer this instead of using a trylock variant in ___slab_allo=
c()
> > > which would simply return in case the trylock fails?
> >
> > The code isn't always in a position to "simply return". On !RT I think =
we
> > can at least assume that if we succeeded once, it means we're not a irq=
/nmi
> > interrupting a locked context so we'll succeed the following attempts t=
oo.
> > On RT IIUC the lock might be taken by someone else, so a trylock might =
fail
> > (even if it should also mean we're in a context that can do a non-try l=
ock).
>
> There is this parent check. If the parent check "allows" the allocation
> then on !RT the trylock should always succeed. So the return "empty
> handed" would be there but should not happen kind of thing.

So you're proposing to replace four local_lock_irqsave() in ___slab_alloc()
with if (!local_trylock_irqsave()) return NULL;
and a nasty comment that it shouldn't happen because we did
local_lock_is_locked() in the caller?

But for RT it will pessimize kmalloc_nolock() chances. More below:

> On RT this is different so local_lock_is_locked() will return false but
> the trylock might fail if the lock is acquired by another task.

Exactly and that's what we need to avoid.
Sleeping in rt_spin_lock() is fine here, since the current task
doesn't hold this per-cpu local_lock.
But there is no such lockdep concept.
Hence the need for local_lock_lockdep_start() which is purely
lockdep-aid and doesn't affect locking logic and checks.

> But then with this change we do trylock from lockdep's point of view
> while in reality we do the full locking including possible context
> switch.

correct. In RT it's better to have a full rt_spin_lock.

> That is why I don't like the part where we trick lockdep.

yes. we do trick lockdep. I don't see an alternative.
lockdep doesn't understand this part either:
"inconsistent {INITIAL USE} -> {IN-NMI} usage"
So it has to be tricked regardless.

> If we the parent check we could trylock for !RT and normal lock for RT
> what we actual do.

How would you do a normal rt_spin_lock() ?
lockdep will yell for two reasons in the commit log of this patch.

> If there is no parent check then we could do "normal lock" on both
> sides.

How would ___slab_alloc() know whether there was a parent check or not?

imo keeping local_lock_irqsave() as-is is cleaner,
since if there is no parent check lockdep will rightfully complain.

One can argue that local_lock_is_locked() and local_lock_lockdep_start()
should be paired together and that's what I had in v1, but they're
really different things. local_lock_is_locked() is true run-time
check regardless of lockdep and the other is lockdep specific band-aid.
Keeping them next to each other in __slab_alloc() looks cleaner.
Maybe a bigger comment is necessary.

