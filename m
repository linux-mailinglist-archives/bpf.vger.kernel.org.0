Return-Path: <bpf+bounces-33900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041FA927A5D
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 17:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8C1282428
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA01B14E8;
	Thu,  4 Jul 2024 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugN+kavz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461EA1AE866;
	Thu,  4 Jul 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720107890; cv=none; b=fB3WEdNlXn3bGLyXWlmBzu+rSm5tC+Ww6nvLvH2vrVn74Z+g/2zR9UsMeqdmBrCSlSkukr9b3pBQ/sbhiCWqYXgGT9IQ4UqHgvjzAMxrvmWpwyWyR/FKLwBFtacMNWIeCu4dtKGGOsV4Dmszl/Hq97E/kl+uUzHDA5cJDPIZXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720107890; c=relaxed/simple;
	bh=tpyUtxcgW3ECY6s2+L1VPkTLXK0XnBDUhBtrXkk14WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rheCoghX06ra5hkK/jf24QhHqHv6WoP4VrZsHFswaKpGLVZ5WeMDXlzAaiSviYXRSfvK9mPxOpecBeaPFj0Do+zWlP2LyB9kL2XYEIs4fY3ytLZEbuAo6qoA4BXeDnKGUka9qkSm5lkpGzB7Bvko52VAzr0JFn6W7Ds4n0mtWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugN+kavz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2543C3277B;
	Thu,  4 Jul 2024 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720107889;
	bh=tpyUtxcgW3ECY6s2+L1VPkTLXK0XnBDUhBtrXkk14WE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ugN+kavzId2My/1kdFQkjNsDnoQJtm2GAzK9CHBZY8MtSWUsLmIRaskBfRDdBSKWZ
	 FLYzIApE1TBxb8StcfE44xR9ysIY0+RGNkAY2IR6eswh19L+wPT5TKREuPfl5LtCte
	 81C6iDsdPWBsaiaALLwt+fQDzK/Opt+2r/zgth9sH5pViOyeNodLFkzWFdGEMJp2Jz
	 2PhL1kSY1dbdsAxiR7+xWhyguowD6LmxWVVjSq6QlybMw7d9cPCa7lNvNmiChs2Kry
	 Ayu9Il0qAF34f0dbx5gANKJUKsoAS72l6X4Wq3+ppONCzGK87WmGVF2njXK4K2Ga61
	 gFphW/pM085Mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6284CCE09D9; Thu,  4 Jul 2024 08:44:49 -0700 (PDT)
Date: Thu, 4 Jul 2024 08:44:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, oleg@redhat.com, mingo@redhat.com,
	bpf@vger.kernel.org, jolsa@kernel.org, clm@meta.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <2d3676e7-6b79-4b99-911f-a5cc0c061406@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240701223935.3783951-1-andrii@kernel.org>
 <CAEf4BzaZhi+_MZ0M4Pz-1qmej6rrJeLO9x1+nR5QH9pnQXzwdw@mail.gmail.com>
 <20240704091559.GS11386@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704091559.GS11386@noisy.programming.kicks-ass.net>

On Thu, Jul 04, 2024 at 11:15:59AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 03, 2024 at 02:33:06PM -0700, Andrii Nakryiko wrote:
> 
> > 2. More tactically, RCU protection seems like the best way forward. We
> > got hung up on SRCU vs RCU Tasks Trace. Thanks to Paul, we also
> > clarified that RCU Tasks Trace has nothing to do with Tasks Rude
> > flavor (whatever that is, I have no idea).
> > 
> > Now, RCU Tasks Trace were specifically designed for least overhead
> > hotpath (reader side) performance, at the expense of slowing down much
> > rarer writers. My microbenchmarking does show at least 5% difference.
> > Both flavors can handle sleepable uprobes waiting for page faults.
> > Tasks Trace flavor is already used for tracing in the BPF realm,
> > including for sleepable uprobes and works well. It's not going away.
> 
> I need to look into this new RCU flavour and why it exists -- for
> example, why can't SRCU be improved to gain the same benefits. This is
> what we've always done, improve SRCU.

Well, it is all software.  And I certainly pushed SRCU hard.  If I recall
correctly, it took them a year to convince me that they needed something
more than SRCU could reasonably be convinced to do.

The big problem is that they need to be able to hook a simple BPF program
(for example, count the number of calls with given argument values) on
a fastpath function on a system running in production without causing
the automation to decide that this system is too slow, thus whacking it
over the head.  Any appreciable overhead is a no-go in this use case.
It is not just that the srcu_read_lock() function's smp_mb() call would
disqualify SRCU, its other added overhead would as well.  Plus this needs
RCU Tasks Trace CPU stall warnings to catch abuse, and SRCU doesn't
impose any limits on readers (how long to set the stall time?) and
doesn't track tasks.

> > Now, you keep pushing for SRCU instead of RCU Tasks Trace, but I
> > haven't seen a single argument why. Please provide that, or let's
> > stick to RCU Tasks Trace, because uprobe's use case is an ideal case
> > of what Tasks Trace flavor was designed for.
> 
> Because I actually know SRCU, and because it provides a local scope.
> It isolates the unregister waiters from other random users. I'm not
> going to use this funky new flavour until I truly understand it.

It is only a few hundred lines of code on top of the infrastructure
that also supports RCU Tasks and RCU Tasks Rude.  If you understand
SRCU and preemptible RCU, there will be nothing exotic there, and it is
simpler than Tree SRCU, to say nothing of preemptible RCU.  I would be
more than happy to take you through it if you would like, but not before
this coming Monday.

> Also, we actually want two scopes here, there is no reason for the
> consumer unreg to wait for the retprobe stuff.

I don't know that the performance requirements for userspace retprobes are
as severe as for function-call probes -- on that, I must defer to Andrii.
To your two-scopes point, it is quite possible that SRCU could be used
for userspace retprobes and RCU Tasks Trace for the others.  It certainly
seems to me that SRCU would be better than explicit reference counting,
but I could be missing something.  (Memory footprint, perhaps?  Though
maybe a single srcu_struct could be shared among all userspace retprobes.
Given the time-bounded reads, maybe stall warnings aren't needed,
give or take things like interrupts, preemption, and vCPU preemption.
Plus it is not like it would be hard to figure out which read-side code
region was at fault when the synchronize_srcu() took too long.)

							Thanx, Paul

> > 3. Regardless of RCU flavor, due to RCU protection, we have to add
> > batched register/unregister APIs, so we can amortize sync_rcu cost
> > during deregistration. Can we please agree on that as well? This is
> > the main goal of this patch set and I'd like to land it before working
> > further on changing and improving the rest of the locking schema.
> 
> See my patch here:
> 
>   https://lkml.kernel.org/r/20240704084524.GC28838@noisy.programming.kicks-ass.net
> 
> I don't think it needs to be more complicated than that.
> 
> > I won't be happy about it, but just to move things forward, I can drop
> > a) custom refcounting and/or b) percpu RW semaphore. Both are
> > beneficial but not essential for batched APIs work. But if you force
> > me to do that, please state clearly your reasons/arguments.
> 
> The reason I'm pushing RCU here is because AFAICT uprobes doesn't
> actually need the stronger serialisation that rwlock (any flavour)
> provide. It is a prime candidate for RCU, and I think you'll find plenty
> papers / articles (by both Paul and others) that show that RCU scales
> better.
> 
> As a bonus, you avoid that horrific write side cost that per-cpu rwsem
> has.
> 
> The reason I'm not keen on that refcount thing was initially because I
> did not understand the justification for it, but worse, once I did read
> your justification, your very own numbers convinced me that the refcount
> is fundamentally problematic, in any way shape or form.
> 
> > No one had yet pointed out why refcounting is broken 
> 
> Your very own numbers point out that refcounting is a problem here. 
> 
> > and why percpu RW semaphore is bad. 
> 
> Literature and history show us that RCU -- where possible -- is
> always better than any reader-writer locking scheme.
> 
> > 4. Another tactical thing, but an important one. Refcounting schema
> > for uprobes. I've replied already, but I think refcounting is
> > unavoidable for uretprobes,
> 
> I think we can fix that, I replied here:
> 
>   https://lkml.kernel.org/r/20240704083152.GQ11386@noisy.programming.kicks-ass.net
> 
> > and current refcounting schema is
> > problematic for batched APIs due to race between finding uprobe and
> > there still being a possibility we'd need to undo all that and retry
> > again.
> 
> Right, I've not looked too deeply at that, because I've not seen a
> reason to actually change that. I can go think about it if you want, but
> meh.

