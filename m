Return-Path: <bpf+bounces-63365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C61AB06836
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 23:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C213ACEE9
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E702BEC51;
	Tue, 15 Jul 2025 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR253a64"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3999926FD91
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752613214; cv=none; b=sl/PHeaBq2RQdCKXAAH7QvKodf/EFlg7eshBAa5S7IVG8QD5XZK38latGKc2wFgF2/SP4dsvlkY7QkxWc7YIrKPWHwkkpeqvf0/hmlou14rEy/ZUI+kaMSFseexvAxOtlI2uIJvOS1sr5nDV8PnX7C8MvRNOwhX+4uCJJPPL1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752613214; c=relaxed/simple;
	bh=R1FumUX/NtnHTjVMmu+X7K1CXVjGPI7XapRXdJM3QAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9xos4KqxVWAKfPcFkU2FoOfcnhvhZSQDlEXxPSUKNQ35PaprWGojjsvq6sgERyElwTDuIAO9RWUoX63/W0tcsvGjcbieFiGVS5sNLpUQTKHukWIE3OuxlWqgTuApIJO00aaTrOVPkQEPsEzTJrGXa8HoCR10BuMu8r1ep/Mew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR253a64; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3134c67a173so6099143a91.1
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752613212; x=1753218012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xqbmHHNSEa4JpvA3O2cZtNvMFvd8/F8HQFJvzgbhv/Q=;
        b=AR253a64/fwlX25231JFK5lPMzikZWqHVqMlC4v46NXN85ZnelQApY1KOHXXqdr36M
         js4aiV+mm4Z0mBjtVCW19xH1MHY+OWsg6oDz/OIRz7+iecABUp340s0zMXvY4STDlP7S
         4iTcDj+3I5ty4vyPkk7uYXP/mkIRB8wh5BESOTsOAUH3sKQMWNX1iMHcDmlEbnQEs49x
         Rbm+JvW9EzBl6yxNaWgtp25RvhAi0QSkeJpd1PQUA/u3lg7DUNzyBO7/hN5QCB8hlnWj
         8ccw/hU5XPeE3IsiItaWq/Er/cdcWlIjs+AHuhwqwU9SJhJVwZbo+rBgGuB3Z+HbJoxS
         6pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752613212; x=1753218012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqbmHHNSEa4JpvA3O2cZtNvMFvd8/F8HQFJvzgbhv/Q=;
        b=hd1iSWJEC1og7VOgtPyokksoFzJkv7OcHk5nuiH5jc2O1HSU8JMNrd8Xnysu4pGAqL
         qXuKfbMIkvAgWcxvzwmWA0V1H+4HTL8aXMhamF+ylev/yQ5oJDLEPZagU1uz8W6i+Nq8
         hPHoHogZA7iUeHmSvtKQzPu3na27oP5+TaxDrMpvTAurY9aEiOuHRqxhuN0GBHTr43Nn
         ingbS4jQBVB/mmDswGkZzERl2QJBi78244Lmzys0eQ7EOXOmINFlm8c9kjiyuAd5OB8d
         jdlCcmpCuBhtQ0ifgzaZRwQfG6j81XjDMI0E3JdZbnwQT2s7qq2I99c19+OqqNn6hJ28
         NGng==
X-Forwarded-Encrypted: i=1; AJvYcCUSsCesDdnM4u/byZOuaWMd9NYAsE8HY0YKoZ4u67Nb+w3YKz2i1PyZJ31LcIJpxasrI3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0o3wYe3AWY7Mk4ZOUMO9j65FcrHjz0OCEzUbYXxz6udfOTGMT
	3rqXVNceUY+ZaZl6AdtVjGjOz29SW+1g+rhFfNXIpcpygBuLKRx7Rg7/
X-Gm-Gg: ASbGncvetVvTGb1sObFRinsdk9T4Ur5zN1eiH28FUDUqLr3MuuEgmLmLtYeLqKcTSO6
	akqxg3V8ZHa2jepX9uC8K6+COn3AVEp6dJknEKUF3epbd7Y97CTqiTDJ3TuCBd5Ci0E9qfmCkd+
	WQcnhGc0XM9puSv32WlKUR6nF21avvTThZ3KM61hQ8n8Gsy6rNwyBABTp4zurZ5FiYX11sJXSPe
	hcYH+EdCsdUxgKK9X5AQidnRaVPaHPEyZUaXL9VRYqLlaX6Q+fLPzKEe3ACe3elsgxIr1ztfQXv
	sTu+onE0F5PUlYpuij8m92IwmJNsJ3Ire0QzDs/louTn1VHyPTYKZL6KFWaYfumDrjI7kIGpeIj
	HhO5ORacfe6hUuY24GCQMrj3kt0wyy3Y=
X-Google-Smtp-Source: AGHT+IFQ9fKQ1sqqST03sgxe97fgQIm400AotSUeIJgcrQWBKs4Dyb5+kWPd8crbeHNMNaVSrKe1Yw==
X-Received: by 2002:a17:90b:2252:b0:312:1508:fb4e with SMTP id 98e67ed59e1d1-31c9f45e1bamr150315a91.17.1752613212067;
        Tue, 15 Jul 2025 14:00:12 -0700 (PDT)
Received: from ast-mac ([2620:10d:c090:500::6:249f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe6bd903sm12587927a12.49.2025.07.15.14.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 14:00:11 -0700 (PDT)
Date: Tue, 15 Jul 2025 14:00:05 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Harry Yoo <harry.yoo@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
Message-ID: <ndv7wt2duysiiqgjtgiegoakf4yg7ksq6skycvj4c62rzym5ob@bjcrssx45f46>
References: <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
 <20250711151730.rz_TY1Qq@linutronix.de>
 <CAADnVQKF=U+Go44fpDYOoZp+3e0xrLYXE4yYLm82H819WqnpnA@mail.gmail.com>
 <20250714110639.uOaKJEfL@linutronix.de>
 <CAADnVQLORq64ezK+gaU=Q2F2KyCYOBZiVE0aaJuqK=xfUwMFiw@mail.gmail.com>
 <d556c4fb-ddc2-4bf0-9510-5c682cd717f5@suse.cz>
 <CAADnVQK3B4ToOOuWOWQdvHO-1as3X2YMGkj45vYQ0Nxoe55Nsw@mail.gmail.com>
 <6835614d-c316-4ecf-ae2b-52687a66ae7c@suse.cz>
 <mb6gbhm7f6xflrtzkjjz4rsapudg55ushyzqqo2uw7intdqmcc@4ess725k2gjj>
 <d5379c97-1954-4352-820d-87b610d597ba@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5379c97-1954-4352-820d-87b610d597ba@suse.cz>

On Tue, Jul 15, 2025 at 07:48:39PM +0200, Vlastimil Babka wrote:
> On 7/15/25 19:29, Alexei Starovoitov wrote:
> > On Tue, Jul 15, 2025 at 08:56:21AM +0200, Vlastimil Babka wrote:
> >> > the addresses of the locks are different and they're different
> >> > kmalloc buckets, but lockdep cannot understand this without
> >> > explicit local_lock_lockdep_start().
> >> > The same thing I'm trying to explain in the commit log.
> >> 
> >> Thanks for the explanation and sorry for being so dense.
> >> Maybe lockdep's lock classes can be used here somehow instead of having to
> >> teach lockdep completely new tricks, but I don't know enough about those to
> >> know for sure.
> > 
> > I tried that with a separate lock_key for each local_trylock_t
> > and it's sort-of kinda works for 16 cpus, but doesn't scale
> > when number of cpus is large.
> > There is no good way to pick LOCKDEP_BITS.
> > 
> > It can be made optional on PREEMP_RT only
> > and used for kmalloc buckets only that kmalloc_nolock() is using,
> > but still feels less clean than
> > local_lock_lockdep_start/end()
> > since it makes lockdep work harder.
> > 
> > Better ideas?
> 
> I was thinking something like a class for normal context and a different
> class for kmalloc_nolock() context (determined by allow_spinning) but it's
> quite vague as I don't understand lockdep enough.

lockdep is not context sensitive. Any lock can either 'lock' or 'trylock'.
One cannot tell lockdep to use different class when lock is 'lock'ed
from a different context (like special gfpflags),
but good news... Turned out lockdep understand LD_LOCK_PERCPU which was
added specifically for local_lock.
So no need to register lock_key for each cpu.
The following diff addresses false positive on PREEMPT_RT.
This is definitely cleaner than local_lock_lockdep_start/end() trickery.
I'm thinking to wrap it with ifdef CONFIG_PREEMPT_RT and add to respin.
As long as we stick to local_trylock_irqsave() for !PREEMPT_RT
and local_lock_irqsave() for PREEMPT_RT all cases should be covered.

For !PREEMP_RT there will be no issue with
"inconsistent {INITIAL USE} -> {IN-NMI} usage."
case, since we will be doing local_trylock_irqsave().
And for PREEMPT_RT there is no NMI or hardirq in this path.

Meaning that what you were suggesting earlier:
> if (unlikely(!local_trylock_irqsave(&s->cpu_slab->lock, *flags))
>        local_lock_irqsave(&s->cpu_slab->lock, *flags);
isn't an option.
For !RT we can only use local_trylock_irqsave() without fallback
otherwise we will be back to square one re: lockdep falsepositives.

So I'll be going with Sebastian's approach:
+       if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !allow_spin)
+               BUG_ON(!local_trylock_irqsave(&s->cpu_slab->lock, *flags));
+       else
+               local_lock_irqsave(&s->cpu_slab->lock, *flags);

From a51dd40cadc5fbe0a2dfa9d8fb493cdc14ab2e9f Mon Sep 17 00:00:00 2001
From: Alexei Starovoitov <ast@kernel.org>
Date: Tue, 15 Jul 2025 10:16:42 -0700
Subject: [PATCH v2] lockdep

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/slab.h | 1 +
 mm/slub.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 65f4616b41de..165737accb20 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -262,6 +262,7 @@ struct kmem_cache_order_objects {
 struct kmem_cache {
 #ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
+	struct lock_class_key lock_key;
 #endif
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
diff --git a/mm/slub.c b/mm/slub.c
index 2f30b85fbf68..ca7f6a3d5db4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3080,9 +3080,13 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 	int cpu;
 	struct kmem_cache_cpu *c;
 
+	if (!init_section_contains(s, 1))
+		/* register lockdep key for non-boot kmem caches */
+		lockdep_register_key(&s->lock_key);
 	for_each_possible_cpu(cpu) {
 		c = per_cpu_ptr(s->cpu_slab, cpu);
 		local_trylock_init(&c->lock);
+		lockdep_set_class(&c->lock, &s->lock_key);
 		c->tid = init_tid(cpu);
 	}
 }
@@ -5953,6 +5957,7 @@ void __kmem_cache_release(struct kmem_cache *s)
 {
 	cache_random_seq_destroy(s);
 #ifndef CONFIG_SLUB_TINY
+	lockdep_unregister_key(&s->lock_key);
 	free_percpu(s->cpu_slab);
 #endif
 	free_kmem_cache_nodes(s);
-- 
2.47.1


