Return-Path: <bpf+bounces-49425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41D8A18998
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E015F3A9B93
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63447433C8;
	Wed, 22 Jan 2025 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBhWpg//"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7D4C9F
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737509764; cv=none; b=W5WWoWOJqcWa29o4NNFw4cckZIBO1bnvNQoYddjdGcm7fDwVX/NgArpTtcc0J5ORHtOUXhc+sWIUriSRNhX0ubOlBbnSVCFKJWFRIzBsyKGnh5wWyeG+/PqRXjKE0/U17y49we5ugk64m7zyzRumn78sq1KhU+WFmrwhmY8+jFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737509764; c=relaxed/simple;
	bh=JYKP5SPX2b5CaXe/E8b0pokEEwIMwXpSf+Hh9cRhMys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+gwl3mOdkzGuD874a4Oa2aTb5wH88mdScQv0NzrOUntk3jx8FZSOgRCWU63GWh1Cy+yomqSM/kp8lNRJ3JWnvpPeAnUNfV/Phx5YCWL12K6RdpbaibUyDjrKgHF4gAFOiYjUfm8UHuAhrffwIhx3HOOMHOAYYoefZS7+jliDYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBhWpg//; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso3590198f8f.3
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 17:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737509762; x=1738114562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NmVTNWFZ0Ug9mBpMXC6A4fuKCaG+c/4rmDBJiKkudM=;
        b=LBhWpg//1vvi6ARQYAX8yYZNqgp/l2UPUcXa8JP7hqAcJy/nJeuqiN8hSeDFR8oXmn
         ecHA3o9n1cnHJCntSLZRs9Uudut1htcQ0R47dXPOolFrT4k7Bbr2xiWtwWbQ3c74x3gt
         nPybWt2aUP49WePgOaNG5V1q9BFks1mpncsfH7NErQ1PfL7dLcps322JX194P+aYklqZ
         3G6aZODyN2TJJ4C9hCys0DQu2DmX2997E7MNv3zTHZmY4xVH1+PGmy5/OI7ENzZ3VakQ
         AAF9V0gb1PTGHNxUjGB0pxsvVKIPKZfiTrqSARAQwQs92mlWO9BDk1ZN/aJBD+7cg+aL
         7Shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737509762; x=1738114562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NmVTNWFZ0Ug9mBpMXC6A4fuKCaG+c/4rmDBJiKkudM=;
        b=HYRx8lGGZ2WcxZswJJd65Z+ZcHUeCyVErrNpSNknuc+fHmez9XaRFfSruNXYd+zkD1
         HDB1tV8piuMvHLesCjWilWBHSr5McORVEPF5wyoDr079FOVoVxZaegzhxVLUZ4cKYb5S
         hmbVvKjuctDRUNfrQqmDg4XFwgp/JndXxNefogkDg1PLlO1DRefi6FgJaI/MPR+mu1Jo
         6f2GTCL5yDeVSk3VDIhFgHeV31n+zp2cb344hKfH5z0Ku9oivTBH2iMQ2TYivRZtpPj3
         kvsT7FX+7azFaZsPg6j4/fcds7O3PpXu7C0P0SEp9JY1XqS0OfWqiOaT+oWnUQCdxwhS
         F5gg==
X-Forwarded-Encrypted: i=1; AJvYcCUYF/4QnW6ZknMUjLoFO2L0sbGqmW+S62LXG5S3etmig6ugoo/JcPJrRhCfQede9uUzqkY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62gTvPIO1W2BoGpFIRpVA3uqkXcNztASwwD3QbljcMl5yx7jr
	/rEJdi8A+E0TR5UM/YOlEf+eMda+n0Ma1z3hAS8wY5J/Twzr9zMVo/qDnaZW60FdplxFzTmL4X5
	CJNP77GLIig+VxVq7qH3NMpz6N90=
X-Gm-Gg: ASbGncvahAc9ydWWoYZEJjbxoAJ7Vopb0mZ+j15I+O454N3WG6t8U6l3UPwZtFGzE3T
	7Jer+Ix2tWA4Do+RjD2ZtGzHiLS6OQoVhMLwtXMCgoSpZNNv08pf/+Nnnz57yXOk/2wHyMpF+I6
	YZfssVpyA=
X-Google-Smtp-Source: AGHT+IFszq65fJ+7rS3NhgoURr9LHxDIYQr1gw7YJyxnjtFCBeoEDGvtVyolNHHNK51My1NUfB+w9S0tAfyLb1FT0WE=
X-Received: by 2002:a05:6000:18a8:b0:385:f69a:7e5f with SMTP id
 ffacd0b85a97d-38bf57a9a86mr22252811f8f.38.1737509761328; Tue, 21 Jan 2025
 17:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-4-alexei.starovoitov@gmail.com> <20250117203315.FWviQT38@linutronix.de>
 <cec11348-a55f-40b4-9011-0e83113ade63@suse.cz> <20250121164300.NOAtoArV@linutronix.de>
In-Reply-To: <20250121164300.NOAtoArV@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Jan 2025 17:35:49 -0800
X-Gm-Features: AbW1kvbjdqpT1juDtk7qTauH_OlyPGpTK_MxGrXTAs6HUeGK88JjH2vlCWZZ13k
Message-ID: <CAADnVQ+dfOrOy=658nMYZOD2JVsC5BbL1x0045jzhfUUmvzO-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] locking/local_lock: Introduce local_trylock_irqsave()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 8:43=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-01-21 16:59:40 [+0100], Vlastimil Babka wrote:
> > I don't think it would work, or am I missing something? The goal is to
> > allow the operation (alloc, free) to opportunistically succeed in e.g.
> > nmi context, but only if we didn't interrupt anything that holds the
> > lock. Otherwise we must allow for failure - hence trylock.
> > (a possible extension that I mentioned is to also stop doing irqsave to
> > avoid its overhead and thus also operations from an irq context would b=
e
> > oportunistic)
> > But if we detect the "trylock must fail" cases only using lockdep, we'l=
l
> > deadlock without lockdep. So e.g. the "active" flag has to be there?
>
> You are right. I noticed that myself but didn't get to reply=E2=80=A6
>
> > So yes this goes beyond the original purpose of local_lock. Do you thin=
k
> > it should be a different lock type then, which would mean the other
> > users of current local_lock that don't want the opportunistic nesting
> > via trylock, would not inflict the "active" flag overhead?
> >
> > AFAICS the RT implementation of local_lock could then be shared for bot=
h
> > of these types, but I might be missing some nuance there.
>
> I was thinking about this over the weekend and this implementation
> extends the data structure by 4 bytes and has this mandatory read/ write
> on every lock/ unlock operation. This is what makes it a bit different
> than the original.
>
> If the local_lock_t is replaced with spinlock_t then the data structure
> is still extended by four bytes (assuming no lockdep) and we have a
> mandatory read/ write operation. The whole thing still does not work on
> PREEMPT_RT but it isn't much different from what we have now. This is
> kind of my favorite. This could be further optimized to avoid the atomic
> operation given it is always local per-CPU memory. Maybe a
> local_spinlock_t :)

I think the concern of people with pitchforks is overblown.
These are the only users of local_lock_t:

drivers/block/zram/zcomp.h:     local_lock_t lock;
drivers/char/random.c:  local_lock_t lock;
drivers/connector/cn_proc.c:    local_lock_t lock;
drivers/md/raid5.h:     local_lock_t    lock;
kernel/softirq.c:       local_lock_t    lock;
mm/memcontrol.c:        local_lock_t stock_lock;
mm/mlock.c:     local_lock_t lock;
mm/slub.c:      local_lock_t lock;
mm/swap.c:      local_lock_t lock;
mm/swap.c:      local_lock_t lock_irq;
mm/zsmalloc.c:  local_lock_t lock;
net/bridge/br_netfilter_hooks.c:        local_lock_t bh_lock;
net/core/skbuff.c:      local_lock_t bh_lock;
net/ipv4/tcp_sigpool.c: local_lock_t bh_lock;

Networking is the one that really cares about performance
and there 'int active' adds 4 bytes, but no run-time overhead,
since it's using local_lock_nested_bh() that doesn't touch 'active'.

memcontrol.c and slub.c are those that need these new trylock
logic with 'active' field to protect from NMI on !RT.
They will change to new local_trylock_t anyway.

What's left is not perf critical. Single WRITE_ONCE in lock
and another WRITE_ONCE in unlock is really in the noise.

Hence I went with a simple approach you see in this patch.
I can go with new local_trylock_t and _Generic() trick.
The patch will look like this:

diff --git a/include/linux/local_lock_internal.h
b/include/linux/local_lock_internal.h
index 8dd71fbbb6d2..ed4623e0c71a 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -15,6 +15,14 @@ typedef struct {
 #endif
 } local_lock_t;

+typedef struct {
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+       struct lockdep_map      dep_map;
+       struct task_struct      *owner;
+#endif
+       int active;
+} local_trylock_t;

 #define __local_lock_irqsave(lock, flags)                      \
        do {                                                    \
+               local_lock_t *l;                                \
                local_irq_save(flags);                          \
-               local_lock_acquire(this_cpu_ptr(lock));         \
+               l =3D (local_lock_t *)this_cpu_ptr(lock);         \
+               _Generic((lock),                                \
+                       local_trylock_t *:                      \
+                       ({                                      \
+                       lockdep_assert(((local_trylock_t *)l)->active =3D=
=3D 0); \
+                        WRITE_ONCE(((local_trylock_t *)l)->active, 1); \
+                       }),                                     \
+                       default:(void)0);                       \
+               local_lock_acquire(l);                          \
        } while (0)

+
+#define __local_trylock_irqsave(lock, flags)                   \
+       ({                                                      \
+               local_trylock_t *l;                             \
+               local_irq_save(flags);                          \
+               l =3D this_cpu_ptr(lock);                         \
+               if (READ_ONCE(l->active) =3D=3D 1) {                \
+                       local_irq_restore(flags);               \
+                       l =3D NULL;                               \
+               } else {                                        \
+                       WRITE_ONCE(l->active, 1);               \
+                       local_trylock_acquire((local_lock_t *)l);
         \
+               }                                               \
+               !!l;                                            \
+       })

and use new local_trylock_t where necessary.
Like:
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7b3503d12aaf..8fe141e93a0b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1722,7 +1722,7 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *me=
mcg)
 }

 struct memcg_stock_pcp {
-       local_lock_t stock_lock;
+       local_trylock_t stock_lock;

All lines where stock_lock is used will stay as-is.
So no code churn.
Above _Generic() isn't pretty, but not horrible either.
I guess that's a decent trade off.
Better ideas?

