Return-Path: <bpf+bounces-69521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14552B98F37
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5332A24E1
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C8296BB2;
	Wed, 24 Sep 2025 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no0ksgjT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F92290D81;
	Wed, 24 Sep 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703453; cv=none; b=Vwv3guVSHOhL5mNaxk9rFOyhH38Tgtc9RplIZNwQTuz6CSMKt3zUQG+RRQF23ZgILzPNQbAgcSSqIs2fuM+vEMHZhUKixHMAhHjxNdHLTXAuvOiRHwqOEQR0D84l6DdMWfdUD2cy2VeL844RIHoPOCP2p0Pm7KKhnAyWtoMmiNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703453; c=relaxed/simple;
	bh=7jz7CVzbmny4juN26yg07gL4GH/p+J8RpWH7vznEVcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKtgRD8hJVQuDsSB597YOcf+Jahc/pypK7nyS3savh7UxlhVoWdudThI877pHx3gvRdmhaANaEFkPm6ovQoVb91bw0H1r8vAsU4LmmJufBc0fh7wPkY3QC27Tq4H4i95CdCJTHZJ6F1TKigeI3jY3eC+BE2nmZZVHT5gdr/DTQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no0ksgjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04069C113CF;
	Wed, 24 Sep 2025 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758703453;
	bh=7jz7CVzbmny4juN26yg07gL4GH/p+J8RpWH7vznEVcs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=no0ksgjTG3FQK08TmBLXJe/PH4muOwkKQKFB5wc9nX2SGXZKyHEIm7JsP36UIKntU
	 /LadNAGmnB5Ju4GcsBJMKzF1KAu2QKFH2BYq1jIaSajqazGzr96mSjDKZxiVePURKt
	 el7I0v8oiJ06a5tQ6DmHi2IesHh301eg8N1zHLMy9uJyUhiNI7n25DwKZYyoh4dTqg
	 4FClQoOYSWhxHnFS3v650PtWEDol93t4uHnvncWfERK+E7bSIXpycI5aC515Q2ZSAz
	 2wHPHlGBCVnP9sK2x6Xcxjb6V+6pUZnn2+fraFqbaCnrIy+Yo5ZGWofFJNbK9wzeCB
	 nzMHWfvuVyyUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 61CECCE0B73; Wed, 24 Sep 2025 01:44:09 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:44:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 15/34] rcu: Add noinstr-fast
 rcu_read_{,un}lock_tasks_trace() APIs
Message-ID: <d341688c-fa19-4dab-88cb-3a45838cc2f1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
 <20250923142036.112290-15-paulmck@kernel.org>
 <20250923173216.GU3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923173216.GU3245006@noisy.programming.kicks-ass.net>

On Tue, Sep 23, 2025 at 07:32:16PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 23, 2025 at 07:20:17AM -0700, Paul E. McKenney wrote:
> > When expressing RCU Tasks Trace in terms of SRCU-fast, it was
> > necessary to keep a nesting count and per-CPU srcu_ctr structure
> > pointer in the task_struct structure, which is slow to access.
> > But an alternative is to instead make rcu_read_lock_tasks_trace() and
> > rcu_read_unlock_tasks_trace(), which match the underlying SRCU-fast
> > semantics, avoiding the task_struct accesses.
> > 
> > When all callers have switched to the new API, the previous
> > rcu_read_lock_trace() and rcu_read_unlock_trace() APIs will be removed.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  include/linux/rcupdate_trace.h | 37 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
> > index 0bd47f12ecd17b..b87151e6b23881 100644
> > --- a/include/linux/rcupdate_trace.h
> > +++ b/include/linux/rcupdate_trace.h
> > @@ -34,6 +34,43 @@ static inline int rcu_read_lock_trace_held(void)
> >  
> >  #ifdef CONFIG_TASKS_TRACE_RCU
> >  
> > +/**
> > + * rcu_read_lock_tasks_trace - mark beginning of RCU-trace read-side critical section
> > + *
> > + * When synchronize_rcu_tasks_trace() is invoked by one task, then that
> > + * task is guaranteed to block until all other tasks exit their read-side
> > + * critical sections.  Similarly, if call_rcu_trace() is invoked on one
> > + * task while other tasks are within RCU read-side critical sections,
> > + * invocation of the corresponding RCU callback is deferred until after
> > + * the all the other tasks exit their critical sections.
> > + *
> > + * For more details, please see the documentation for srcu_read_lock_fast().
> > + */
> > +static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
> > +{
> > +	struct srcu_ctr __percpu *ret = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > +
> > +	if (IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR))
> > +		smp_mb();
> 
> I am somewhat confused by the relation between noinstr and smp_mb()
> here. Subject mentions is, but Changelog is awfully silent again.

Thank you for looking this over!

To Alexei's point, this commit should be merged with 18/34.

> Furthermore I note that this is a positive while unlock is a negative
> relation between the two. Which adds even more confusion.

You are right, at most one of these two conditions can be correct.  ;-)

I believe that the one above needs a "!".

The point of this is that architectures that set ARCH_WANTS_NO_INSTR
have promised that any point in the entry/exit code that RCU is not
watching has been marked noinstr.  For those architectures, SRCU-fast
can rely on the fact that the key updates in __srcu_read_lock_fast()
and __srcu_read_unlock_fast() are either interrrupt-disabled regions or
atomic operations, depending on the architecture.  This means that
the synchronize_rcu{,_expedited}() calls in the SRCU-fast grace-period
code will be properly ordered with those accesses.

But for !ARCH_WANTS_NO_INSTR architectures, it is possible to attach
various forms of tracing to entry/exit code that RCU is not watching,
which means that those synchronize_rcu{,_expedited}() calls won't have
the needed ordering properties.  So we use smp_mb() on the read side
to force the needed ordering.

Does that help, or am I missing the point of your question?

							Thanx, Paul

> > +	return ret;
> > +}
> > +
> > +/**
> > + * rcu_read_unlock_tasks_trace - mark end of RCU-trace read-side critical section
> > + * @scp: return value from corresponding rcu_read_lock_tasks_trace().
> > + *
> > + * Pairs with the preceding call to rcu_read_lock_tasks_trace() that
> > + * returned the value passed in via scp.
> > + *
> > + * For more details, please see the documentation for rcu_read_unlock().
> > + */
> > +static inline void rcu_read_unlock_tasks_trace(struct srcu_ctr __percpu *scp)
> > +{
> > +	if (!IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR))
> > +		smp_mb();
> > +	srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
> > +}
> > +
> >  /**
> >   * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
> >   *
> > -- 
> > 2.40.1
> > 

