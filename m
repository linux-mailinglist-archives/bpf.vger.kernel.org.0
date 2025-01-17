Return-Path: <bpf+bounces-49141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4D4A146ED
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 01:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA316AA11
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 00:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B0223BE;
	Fri, 17 Jan 2025 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyJ/8BLa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7524C1362;
	Fri, 17 Jan 2025 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737072431; cv=none; b=qTYIg+UsVQmzpD8nmJsDFj3IXa4pcnwbb8f5myvI63r4FdzRWd86aCT3nV4kc+FIrPuSCkBgUG/kDq2kJTYZVZimXRbOIx1yM2pDFFPCIVdpbmXh37B3dVxjCOrWeX/PQDL284SN20imk4uxfDnMj/+rxTwZfVhMkB/WBeOk4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737072431; c=relaxed/simple;
	bh=u8qwLJkR77hvkpoUSlPZrcYFHV7eN0YSX9VBpsSvHEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niuKm62TszJfK92+hsYRq5jzbH0HKe7tdMHUIaz/a3ni2QYYsRwDEEIbQhAkf0YbEYpjOWVD/O+5GVP6Cdkl3gcrtVSE1RR+FKDgnnFKFQ6Mm87+iQPt4NzeIvj7J9wI9lAxDJaFnrroHsB+skt6LG5Y72SL4bvqmN2gp1OeFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyJ/8BLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BB2C4CED6;
	Fri, 17 Jan 2025 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737072431;
	bh=u8qwLJkR77hvkpoUSlPZrcYFHV7eN0YSX9VBpsSvHEE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dyJ/8BLa6HH6Wgyd3oSnobZTv1WiYi8Sv3un8h8DMNjUuSpuuxqHLEPlnl4YBRhKh
	 5SPoIPp7TEvH7tlxHbeO3/3Wx8l/YaqagN2pgTmKinLX/H1+8ctTRh9JQ5Ov9Vkg1u
	 wnh0FYpp0IZH55R5dOTSMMOWQZy/jG5v8GOks/HBnpQmEfCGa7tG2EqmXxlpdu1iRt
	 DkF9wNbkpibPsGaU6ABs7qz85UAokjHjafKcXf3rkfACQifd1LnszykKM69c3NLme+
	 GtLikmpmfthOosaiTTeNvpHXzIPaYy/aGIZxou1Au9x8s9Jyugx3qOrE7KM5UnvM6q
	 m8AZZX9Rrv6ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9864CCE12BE; Thu, 16 Jan 2025 16:07:10 -0800 (PST)
Date: Thu, 16 Jan 2025 16:07:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH rcu 13/17] srcu: Add SRCU-fast readers
Message-ID: <bd0c32d3-3a99-4358-aae7-b4b2b1c24b5c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <826c8527-d6ba-46c5-bb89-4625750cbeed@paulmck-laptop>
 <20250116202112.3783327-13-paulmck@kernel.org>
 <CAEf4BzYqAVuX1nP20qVaY8_CnDom699vzAjm7ZLaMx+oz8vceQ@mail.gmail.com>
 <5dc925b6-2faf-4788-9c8c-9387d04417ee@paulmck-laptop>
 <CAEf4BzZhJU+Q3qVyhqKjSRtGt=+3VY=N14ZOqqxYmCOQPnKnWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZhJU+Q3qVyhqKjSRtGt=+3VY=N14ZOqqxYmCOQPnKnWw@mail.gmail.com>

On Thu, Jan 16, 2025 at 02:57:25PM -0800, Andrii Nakryiko wrote:
> On Thu, Jan 16, 2025 at 2:54 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Jan 16, 2025 at 01:52:53PM -0800, Andrii Nakryiko wrote:
> > > On Thu, Jan 16, 2025 at 12:21 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > This commit adds srcu_read_{,un}lock_fast(), which is similar
> > > > to srcu_read_{,un}lock_lite(), but avoids the array-indexing and
> > > > pointer-following overhead.  On a microbenchmark featuring tight
> > > > loops around empty readers, this results in about a 20% speedup
> > > > compared to RCU Tasks Trace on my x86 laptop.
> > > >
> > > > Please note that SRCU-fast has drawbacks compared to RCU Tasks
> > > > Trace, including:
> > > >
> > > > o       Lack of CPU stall warnings.
> > > > o       SRCU-fast readers permitted only where rcu_is_watching().
> > > > o       A pointer-sized return value from srcu_read_lock_fast() must
> > > >         be passed to the corresponding srcu_read_unlock_fast().
> > > > o       In the absence of readers, a synchronize_srcu() having _fast()
> > > >         readers will incur the latency of at least two normal RCU grace
> > > >         periods.
> > > > o       RCU Tasks Trace priority boosting could be easily added.
> > > >         Boosting SRCU readers is more difficult.
> > > >
> > > > SRCU-fast also has a drawback compared to SRCU-lite, namely that the
> > > > return value from srcu_read_lock_fast()-fast is a 64-bit pointer and
> > > > that from srcu_read_lock_lite() is only a 32-bit int.
> > > >
> > > > [ paulmck: Apply feedback from Akira Yokosawa. ]
> > > >
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Kent Overstreet <kent.overstreet@linux.dev>
> > > > Cc: <bpf@vger.kernel.org>
> > > > ---
> > > >  include/linux/srcu.h     | 47 ++++++++++++++++++++++++++++++++++++++--
> > > >  include/linux/srcutiny.h | 22 +++++++++++++++++++
> > > >  include/linux/srcutree.h | 38 ++++++++++++++++++++++++++++++++
> > > >  3 files changed, 105 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > > > index 2bd0e24e9b554..63bddc3014238 100644
> > > > --- a/include/linux/srcu.h
> > > > +++ b/include/linux/srcu.h
> > > > @@ -47,9 +47,10 @@ int init_srcu_struct(struct srcu_struct *ssp);
> > > >  #define SRCU_READ_FLAVOR_NORMAL        0x1             // srcu_read_lock().
> > > >  #define SRCU_READ_FLAVOR_NMI   0x2             // srcu_read_lock_nmisafe().
> > > >  #define SRCU_READ_FLAVOR_LITE  0x4             // srcu_read_lock_lite().
> > > > +#define SRCU_READ_FLAVOR_FAST  0x8             // srcu_read_lock_fast().
> > > >  #define SRCU_READ_FLAVOR_ALL   (SRCU_READ_FLAVOR_NORMAL | SRCU_READ_FLAVOR_NMI | \
> > > > -                               SRCU_READ_FLAVOR_LITE) // All of the above.
> > > > -#define SRCU_READ_FLAVOR_SLOWGP        SRCU_READ_FLAVOR_LITE
> > > > +                               SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST) // All of the above.
> > > > +#define SRCU_READ_FLAVOR_SLOWGP        (SRCU_READ_FLAVOR_LITE | SRCU_READ_FLAVOR_FAST)
> > > >                                                 // Flavors requiring synchronize_rcu()
> > > >                                                 // instead of smp_mb().
> > > >  void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
> > > > @@ -253,6 +254,33 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
> > > >         return retval;
> > > >  }
> > > >
> > > > +/**
> > > > + * srcu_read_lock_fast - register a new reader for an SRCU-protected structure.
> > > > + * @ssp: srcu_struct in which to register the new reader.
> > > > + *
> > > > + * Enter an SRCU read-side critical section, but for a light-weight
> > > > + * smp_mb()-free reader.  See srcu_read_lock() for more information.
> > > > + *
> > > > + * If srcu_read_lock_fast() is ever used on an srcu_struct structure,
> > > > + * then none of the other flavors may be used, whether before, during,
> > > > + * or after.  Note that grace-period auto-expediting is disabled for _fast
> > > > + * srcu_struct structures because auto-expedited grace periods invoke
> > > > + * synchronize_rcu_expedited(), IPIs and all.
> > > > + *
> > > > + * Note that srcu_read_lock_fast() can be invoked only from those contexts
> > > > + * where RCU is watching, that is, from contexts where it would be legal
> > > > + * to invoke rcu_read_lock().  Otherwise, lockdep will complain.
> > > > + */
> > > > +static inline struct srcu_ctr __percpu *srcu_read_lock_fast(struct srcu_struct *ssp) __acquires(ssp)
> > > > +{
> > > > +       struct srcu_ctr __percpu *retval;
> > > > +
> > > > +       srcu_check_read_flavor_force(ssp, SRCU_READ_FLAVOR_FAST);
> > > > +       retval = __srcu_read_lock_fast(ssp);
> > > > +       rcu_try_lock_acquire(&ssp->dep_map);
> > > > +       return retval;
> > > > +}
> > > > +
> > > >  /**
> > > >   * srcu_read_lock_lite - register a new reader for an SRCU-protected structure.
> > > >   * @ssp: srcu_struct in which to register the new reader.
> > > > @@ -356,6 +384,21 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
> > > >         __srcu_read_unlock(ssp, idx);
> > > >  }
> > > >
> > > > +/**
> > > > + * srcu_read_unlock_fast - unregister a old reader from an SRCU-protected structure.
> > > > + * @ssp: srcu_struct in which to unregister the old reader.
> > > > + * @scp: return value from corresponding srcu_read_lock_fast().
> > > > + *
> > > > + * Exit a light-weight SRCU read-side critical section.
> > > > + */
> > > > +static inline void srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> > > > +       __releases(ssp)
> > > > +{
> > > > +       srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_FAST);
> > > > +       srcu_lock_release(&ssp->dep_map);
> > > > +       __srcu_read_unlock_fast(ssp, scp);
> > > > +}
> > > > +
> > > >  /**
> > > >   * srcu_read_unlock_lite - unregister a old reader from an SRCU-protected structure.
> > > >   * @ssp: srcu_struct in which to unregister the old reader.
> > > > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > > > index 07a0c4489ea2f..380260317d98b 100644
> > > > --- a/include/linux/srcutiny.h
> > > > +++ b/include/linux/srcutiny.h
> > > > @@ -71,6 +71,28 @@ static inline int __srcu_read_lock(struct srcu_struct *ssp)
> > > >         return idx;
> > > >  }
> > > >
> > > > +struct srcu_ctr;
> > > > +
> > > > +static inline bool __srcu_ptr_to_ctr(struct srcu_struct *ssp, struct srcu_ctr __percpu *scpp)
> > > > +{
> > > > +       return (int)(intptr_t)(struct srcu_ctr __force __kernel *)scpp;
> > > > +}
> > > > +
> > > > +static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ssp, int idx)
> > > > +{
> > > > +       return (struct srcu_ctr __percpu *)(intptr_t)idx;
> > > > +}
> > > > +
> > > > +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
> > > > +{
> > > > +       return __srcu_ctr_to_ptr(ssp, __srcu_read_lock(ssp));
> > > > +}
> > > > +
> > > > +static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> > > > +{
> > > > +       __srcu_read_unlock(ssp, __srcu_ptr_to_ctr(ssp, scp));
> > > > +}
> > > > +
> > > >  #define __srcu_read_lock_lite __srcu_read_lock
> > > >  #define __srcu_read_unlock_lite __srcu_read_unlock
> > > >
> > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > index ef3065c0cadcd..bdc467efce3a2 100644
> > > > --- a/include/linux/srcutree.h
> > > > +++ b/include/linux/srcutree.h
> > > > @@ -226,6 +226,44 @@ static inline struct srcu_ctr __percpu *__srcu_ctr_to_ptr(struct srcu_struct *ss
> > > >         return &ssp->sda->srcu_ctrs[idx];
> > > >  }
> > > >
> > > > +/*
> > > > + * Counts the new reader in the appropriate per-CPU element of the
> > > > + * srcu_struct.  Returns a pointer that must be passed to the matching
> > > > + * srcu_read_unlock_fast().
> > > > + *
> > > > + * Note that this_cpu_inc() is an RCU read-side critical section either
> > > > + * because it disables interrupts, because it is a single instruction,
> > > > + * or because it is a read-modify-write atomic operation, depending on
> > > > + * the whims of the architecture.
> > > > + */
> > > > +static inline struct srcu_ctr __percpu *__srcu_read_lock_fast(struct srcu_struct *ssp)
> > > > +{
> > > > +       struct srcu_ctr __percpu *scp = READ_ONCE(ssp->srcu_ctrp);
> > > > +
> > > > +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_lock_fast().");
> > > > +       this_cpu_inc(scp->srcu_locks.counter); /* Y */
> > > > +       barrier(); /* Avoid leaking the critical section. */
> > > > +       return scp;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Removes the count for the old reader from the appropriate
> > > > + * per-CPU element of the srcu_struct.  Note that this may well be a
> > > > + * different CPU than that which was incremented by the corresponding
> > > > + * srcu_read_lock_fast(), but it must be within the same task.
> > >
> > > hm... why the "same task" restriction? With uretprobes we take
> > > srcu_read_lock under a traced task, but we can "release" this lock
> > > from timer interrupt, which could be in the context of any task.
> >
> > A kneejerk reaction on my part?  ;-)
> >
> > But the good news is that this restriction is easy for me to relax.
> > I adjust the comments and remove the rcu_try_lock_acquire()
> > from srcu_read_lock_fast() and the srcu_lock_release() from
> > srcu_read_unlock_fast().
> >
> > But in that case, I should rename this to srcu_down_read_fast() and
> > srcu_up_read_fast() or similar, as these names would clearly indicate
> > that they can be used cross-task.  (And from interrupt handlers, but
> > not from NMI handlers.)
> >
> > Also, srcu_read_lock() and srcu_read_unlock() have srcu_lock_acquire() and
> > srcu_lock_release() calls, so I am surprised that lockdep didn't complain
> > when you invoked srcu_read_lock() from task context and srcu_read_unlock()
> > from a timer interrupt.
> 
> That's because I'm using __srcu_read_lock and __srcu_read_unlock ;)
> See this part in kernel/events/uprobes.c:
> 
> /* __srcu_read_lock() because SRCU lock survives switch to user space */
> srcu_idx = __srcu_read_lock(&uretprobes_srcu);

I clearly should have read that code more carefully!  ;-)

This happens to work for srcu_read_lock() and srcu_read_lock_nmisafe(),
but invoking __srcu_read_lock_lite() or __srcu_read_lock_fast() would fail
(rarely!) with too-short grace periods.

So thank you for catching this!  I will adjust the name and semantics.

                                                        Thanx, Paul

> > > > + *
> > > > + * Note that this_cpu_inc() is an RCU read-side critical section either
> > > > + * because it disables interrupts, because it is a single instruction,
> > > > + * or because it is a read-modify-write atomic operation, depending on
> > > > + * the whims of the architecture.
> > > > + */
> > > > +static inline void __srcu_read_unlock_fast(struct srcu_struct *ssp, struct srcu_ctr __percpu *scp)
> > > > +{
> > > > +       barrier();  /* Avoid leaking the critical section. */
> > > > +       this_cpu_inc(scp->srcu_unlocks.counter);  /* Z */
> > > > +       RCU_LOCKDEP_WARN(!rcu_is_watching(), "RCU must be watching srcu_read_unlock_fast().");
> > > > +}
> > > > +
> > > >  /*
> > > >   * Counts the new reader in the appropriate per-CPU element of the
> > > >   * srcu_struct.  Returns an index that must be passed to the matching
> > > > --
> > > > 2.40.1
> > > >

