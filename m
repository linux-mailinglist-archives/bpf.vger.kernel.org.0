Return-Path: <bpf+bounces-53176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CA1A4DB38
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 11:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F86116DC0F
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 10:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2341FCFE7;
	Tue,  4 Mar 2025 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tW+jbDjU"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983111FCF44;
	Tue,  4 Mar 2025 10:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085219; cv=none; b=lOvmrTUeNYsDi7008wKLdOyjUxKpoaGCUenclptWM/mGeg5INQU++eobOqACHJjPd6R4zL3M+/FHkIrx5za3ot40pmqWYdxqX/0kXTs+WPY8WdGZAC4edIvM2/4nudDL3UdEd9BB90E4G1P6rCtvgMgmuLwICN4RxN4uy7k5HE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085219; c=relaxed/simple;
	bh=7jQ3dQAi9pd4+Bn/dBzYuI41dTi0MxA8Jyonuvuf5tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+OEx2mWUNw+ePSJEyzTBm0b6k6iWQfhskjlLYKqRZWYwRgwRKlhqe/aJHj+gMvfRgm3SEDwlosW8VkJmpF1i1r0Pxbjq4BC1cIDpDZIIoVLNlzac/K3NFVfSDLflQ87idfCYx7bY4/vT5UpwscAD77m+UAUrEQiYMW4G5uLZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tW+jbDjU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KbAI/iH5DKxzN8gIq1gQHZTRsqPNT6OpyGMhNKEz1DY=; b=tW+jbDjU4AcxV7pyEf4qm6bDIW
	Q1FMvUVSqnHCdtFlK1bxd60JOVp/Uf27liCsuzYJ5Bl4AU1pIZb9bT4vh7JEvwJK98dSQCy9UW3NX
	0N/oRLtJavJGqpTJPV5GBAHkN2Ctt8kce3D8hVtYYKNGPRNtHnaGhb0kw8D+jshXECNNq5bfohQcE
	iVkulzPzWB5goOjLAkV7Utp0PAQ4SS3bhcCMqjuFtasHdSkeACGLF0r8Uf7zP/o5nqUo5inYBQxAQ
	IGKJdPkSOg5jH5esdXa1e65LSLMvd/upvrmwN9tKJBbnNOsAnmdHZLNPvwbz83ngSL9lOSu1pRs9w
	ydfDb6ug==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tpPnV-00000000gmm-0pxx;
	Tue, 04 Mar 2025 10:46:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6B25930049D; Tue,  4 Mar 2025 11:46:48 +0100 (CET)
Date: Tue, 4 Mar 2025 11:46:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v2 00/26] Resilient Queued Spin Lock
Message-ID: <20250304104648.GD11590@noisy.programming.kicks-ass.net>
References: <20250206105435.2159977-1-memxor@gmail.com>
 <20250210093840.GE10324@noisy.programming.kicks-ass.net>
 <20250210104931.GE31462@noisy.programming.kicks-ass.net>
 <CAADnVQ+3wu0WB2pXs4cccxfkbTb3TK8Z+act5egytiON+qN9tA@mail.gmail.com>
 <20250211104352.GC29593@noisy.programming.kicks-ass.net>
 <CAADnVQJ=81PE19JWeNjq6aNOy+GM-wo6n7WU9StX1b6kevqCUw@mail.gmail.com>
 <20250213095918.GB28068@noisy.programming.kicks-ass.net>
 <CAADnVQJJbi-52mP6BivyAudWSk95f1mgGQXWnjD-H37b7_AtLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJJbi-52mP6BivyAudWSk95f1mgGQXWnjD-H37b7_AtLw@mail.gmail.com>


new posting reminded me we had this thread...

On Thu, Feb 13, 2025 at 06:37:05PM -0800, Alexei Starovoitov wrote:

> > > When bpf prog does bpf_rcu_read_lock() the verifier makes sure
> > > that all execution paths from there on have bpf_rcu_read_unlock()
> > > before program reaches the exit.
> > > Same thing with locks.
> >
> > Ah, okay, this wasn't stated anywhere. This is rather crucial
> > information.
> 
> This is kinda verifier 101. I don't think it needs to be in the log.

Right, but I didn't take that class. I'm BPF n00b. Meanwhile you're
asking me to review this :-/

> > OK; how is the user supposed to handle locking two hash buckets? Does
> > the BPF prog create some global lock to serialize the multi bucket case?
> 
> Not following.
> Are you talking about patch 19 where we convert per-bucket
> raw_spinlock_t in bpf hashmap to rqspinlock_t ?

I'm not sure -- see the BPF n00b thing, I don't know how this is
supposed to be used.

Like really; I have absolutely 0 clues.

Anyway; the situation I was thinking of was something along the lines
of: you need data from 2 buckets, so you need to lock 2 buckets, but
since hash-table, there is no sane order, so you need a 3rd lock to
impose order.

But also, see below, you've illustrated this exact case with q1,q2.

> Only one bucket lock is held at a time by map update code,
> but due to reentrance and crazy kprobes in the wrong places
> two bucket locks of a single map can be held on the same cpu.
> 
> bpf_prog_A -> bpf_map_update -> res_spin_lock(bucket_A)
>   -> kprobe or tracepoint
>     -> bpf_prob_B -> bpf_map_update -> res_spin_lock(bucket_B)
> 
> and that's why we currently have:
> if (__this_cpu_inc_return(*(htab->map_locked[hash])) ...
>     return -EBUSY;
> 
> .. workaround to prevent the most obvious AA deadlock,
> but it's not enough.
> People were able to hit ABBA.

Right, you can create arbitrary lock chain with this; chain length is
limited by nesting-depth*nr-cpus or somesuch.

> > Anyway, I wonder. Since the verifier tracks all this, it can determine
> > lock order for the prog. Can't it do what lockdep does and maintain lock
> > order graph of all loaded BPF programs?
> >
> > This is load-time overhead, rather than runtime.
> 
> I wish it was possible. Locks are dynamic. They protect
> dynamically allocated objects, so the order cannot be statically
> verified. We pushed the limit of static analysis a lot.
> Maybe too much.
> For example,
> the verifier can statically validate the following code:
>         struct node_data *n, *m, *o;
>         struct bpf_rb_node *res, *res2;
> 
>         // here we allocate an object of type known to the verifier
>         n = bpf_obj_new(typeof(*n));
>         if (!n)
>                 return 1;
>         n->key = 41;
>         n->data = 42;
> 
>         // here the verifier knows that glock spin_lock
>         // protect rbtree groot
>         bpf_spin_lock(&glock);
> 
>         // here it checks that the lock is held and type of
>         // objects in rbtree matches the type of 'n'
>         bpf_rbtree_add(&groot, &n->node, less);
>         bpf_spin_unlock(&glock);
> 
> and all kinds of other more complex stuff,
> but it is not enough to cover necessary algorithms.
> 
> Here is an example from real code that shows
> why we cannot verify two held locks:
> 
> struct bpf_vqueue {
>         struct bpf_spin_lock lock;
>         int credit;
>         unsigned long long lasttime;
>         unsigned int rate;
> };
> 
> struct {
>         __uint(type, BPF_MAP_TYPE_HASH);
>         __uint(max_entries, ...);
>         __type(key, int);
>         __type(value, struct bpf_vqueue);
> } vqueue SEC(".maps");
> 
>         q = bpf_map_lookup_elem(&vqueue, &key);
>         if (!q)
>                 goto err;
>         curtime = bpf_ktime_get_ns();
>         bpf_spin_lock(&q->lock);
>         q->lasttime = curtime;
>         q->credit -= ...;
>         credit = q->credit;
>         bpf_spin_unlock(&q->lock);
> 
> the above is safe, but if there are two lookups:
> 
> q1 = bpf_map_lookup_elem(&vqueue, &key1);
> q2 = bpf_map_lookup_elem(&vqueue, &key2);
> 
> both will point to two different locks,
> and since the key is dynamic there is no way to know
> the order of q1->lock vs q2->lock.

I still feel like I'm missing things, but while they are two dynamic
locks, they are both locks of vqueue object. What lockdep does is
classify locks by initialization site (by default). Same can be done
here, classify per dynamic object.

So verifier can know the above is invalid. Both locks are same class, so
treat as A-A order (trivial case is where q1 and q2 are in fact the same
object since the keys hash the same).

Now, going back to 3rd lock, if instead you write it like:

  bpf_spin_lock(&glock);
  q1 = bpf_map_lookup_elem(&vqueue, &key1);
  q2 = bpf_map_lookup_elem(&vqueue, &key2);
  ...
  bpf_spin_unlock(&glock);

then (assuming q1 != q2) things are fine, since glock will serialize
everybody taking two vqueue locks.

And the above program snippet seems to imply maps are global state, so
you can keep lock graph of maps, such that:

  bpf_map_lookup_elem(&map-A, &key-A);
  bpf_map_lookup_elem(&map-B, &key-B);

vs

  bpf_map_lookup_elem(&map-B, &key-B);
  bpf_map_lookup_elem(&map-A, &key-A);

trips AB-BA

> So we allow only one lock at a time with
> bare minimal operations while holding the lock,
> but it's not enough to do any meaningful work.

Yes, I can see that being a problem.

> The top feature request is to allow calls
> while holding locks (currently they're disallowed,
> like above bpf_ktime_get_ns() cannot be done
> while holding the lock)

So bpf_ktime_get_ns() is a trivial example; it it always safe to call,
you can simply whitelist it.

> and allow grabbing more than one lock.
> That's what res_spin_lock() is achieving.

I am not at all sure how res_spin_lock is helping with the q1,q2 thing.
That will trivially result in lock cycles.

And you said any program that would trigger deadlock is invalid.
Therefore the q1,q2 example from above is still invalid and
res_spin_lock has not helped.

> Having said all that I think the discussion is diverging into
> all-thing-bpf instead of focusing on res_spin_lock.

I disagree, all of this is needed to understand res_spin_lock.

From the above, I'm not yet convinced you cannot extend the verifier
with something lockdep like.

> Just to make it clear... there is a patch 18:
> 
>  F: kernel/bpf/
>  F: kernel/trace/bpf_trace.c
>  F: lib/buildid.c
> +F: arch/*/include/asm/rqspinlock.h
> +F: include/asm-generic/rqspinlock.h
> +F: kernel/locking/rqspinlock.c
>  F: lib/test_bpf.c
>  F: net/bpf/
> 
> that adds maintainer entries to BPF scope.
> 
> We're not asking locking experts to maintain this new res_spin_lock.
> It's not a generic kernel infra.
> It will only be used by bpf infra and by bpf progs.
> We will maintain it and we will fix whatever bugs
> we introduce.

While that is appreciated, the whole kernel is subject to the worst case
behaviour of this thing. As such, I feel I need to care.


