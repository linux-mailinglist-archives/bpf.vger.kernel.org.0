Return-Path: <bpf+bounces-69523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E906B98FFD
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B84189A470
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 08:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8992D0C68;
	Wed, 24 Sep 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAGmJOCD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941F2C3761;
	Wed, 24 Sep 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704193; cv=none; b=U4Btj7dZFLw2HW/4lWBkgmdlvhnpZFyGlrb9NAztQMcROlj9VWYHlOGTTZ+8orXn9tIUr/mzPEM0pJqqmMC26V+MYDPCD7p586j0wPx8C8WFY4tV17Pj3Xh8OYta/4XKO4GI2EbKGdFSDzq+/6RrZChPKS3nLRiSGYrZNGUrAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704193; c=relaxed/simple;
	bh=3ZbL2WmRTiICYRfqU3jXkrRRZ+LZSsqkDbqoxEOd6ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ave3S1LW/sllvNhp1jpZ1Xe74ygrEjLHjE8c0XQG+KR6zcB5LvgIX+oNDpsIgQMrhDQFFzylzXa/t5oCeT6yIc3SCEMox3/DLBzG7A2E7fDJqCJMwdJktRO6B7L+xETr6dRoD/uvSS05WnLIOfvn5UQl9K0w+6/p/QLv8gSJLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAGmJOCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B890C4CEE7;
	Wed, 24 Sep 2025 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758704192;
	bh=3ZbL2WmRTiICYRfqU3jXkrRRZ+LZSsqkDbqoxEOd6ds=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qAGmJOCD7KFyC/d0tm3P/J34mh86wSKHS8BBqrCh1a5x2HnEimuPQ1u7wpuWugz+g
	 gTIOptJhM8JEZyzr45CUhbPnaOtk2zQCUL8EOLdbrx6toHxV45U1Io5cXEo+khp31u
	 +csn3KD+LbNDN2MT5Kko0DENFnlzioQnuIeL7vobN1KrAlcyI6UwaYdSGZTTTPyZXS
	 tBeveJzGYp8t81nUOBSOJWWLJaNKOgVXFncIKSRh6BWkJ+1/yJdX6x8KcUiOugiXfn
	 iwtRLnpr0B5ZASyMdV6JfWpg6m7rn2Ui6T/J1lfrBjkSnExtKOjvnqokfaLtmBpvDv
	 /6G3ovdDmVSTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A1AE1CE0B73; Wed, 24 Sep 2025 01:56:28 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:56:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 23/34] srcu: Create an srcu_expedite_current() function
Message-ID: <eea8f144-70bf-4444-969b-bdd263bddf48@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
 <20250923142036.112290-23-paulmck@kernel.org>
 <91810f6e76fb2e97b0519c9442f1877e1de223fa@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91810f6e76fb2e97b0519c9442f1877e1de223fa@linux.dev>

On Wed, Sep 24, 2025 at 12:10:22AM +0000, Zqiang wrote:
> > 
> > This commit creates an srcu_expedite_current() function that expedites
> > the current (and possibly the next) SRCU grace period for the specified
> > srcu_struct structure. This functionality will be inherited by RCU
> > Tasks Trace courtesy of its mapping to SRCU fast.
> > 
> > If the current SRCU grace period is already waiting, that wait will
> > complete before the expediting takes effect. If there is no SRCU grace
> > period in flight, this function might well create one.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >  include/linux/srcutiny.h | 1 +
> >  include/linux/srcutree.h | 8 ++++++
> >  kernel/rcu/srcutree.c | 58 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 67 insertions(+)
> > 
> > diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
> > index 00e5f05288d5e7..941e8210479607 100644
> > --- a/include/linux/srcutiny.h
> > +++ b/include/linux/srcutiny.h
> > @@ -104,6 +104,7 @@ static inline void srcu_barrier(struct srcu_struct *ssp)
> >  synchronize_srcu(ssp);
> >  }
> >  
> > +static inline void srcu_expedite_current(struct srcu_struct *ssp) { }
> >  #define srcu_check_read_flavor(ssp, read_flavor) do { } while (0)
> >  #define srcu_check_read_flavor_force(ssp, read_flavor) do { } while (0)
> >  
> > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > index 1adc58d2ab6425..4a5d1c0e7db361 100644
> > --- a/include/linux/srcutree.h
> > +++ b/include/linux/srcutree.h
> > @@ -42,6 +42,8 @@ struct srcu_data {
> >  struct timer_list delay_work; /* Delay for CB invoking */
> >  struct work_struct work; /* Context for CB invoking. */
> >  struct rcu_head srcu_barrier_head; /* For srcu_barrier() use. */
> > + struct rcu_head srcu_ec_head; /* For srcu_expedite_current() use. */
> > + int srcu_ec_state; /* State for srcu_expedite_current(). */
> >  struct srcu_node *mynode; /* Leaf srcu_node. */
> >  unsigned long grpmask; /* Mask for leaf srcu_node */
> >  /* ->srcu_data_have_cbs[]. */
> > @@ -135,6 +137,11 @@ struct srcu_struct {
> >  #define SRCU_STATE_SCAN1 1
> >  #define SRCU_STATE_SCAN2 2
> >  
> > +/* Values for srcu_expedite_current() state (->srcu_ec_state). */
> > +#define SRCU_EC_IDLE 0
> > +#define SRCU_EC_PENDING 1
> > +#define SRCU_EC_REPOST 2
> > +
> >  /*
> >  * Values for initializing gp sequence fields. Higher values allow wrap arounds to
> >  * occur earlier.
> > @@ -220,6 +227,7 @@ struct srcu_struct {
> >  int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
> >  void synchronize_srcu_expedited(struct srcu_struct *ssp);
> >  void srcu_barrier(struct srcu_struct *ssp);
> > +void srcu_expedite_current(struct srcu_struct *ssp);
> >  void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
> >  
> >  // Converts a per-CPU pointer to an ->srcu_ctrs[] array element to that
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 1ff94b76d91f15..f2f11492e6936e 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -1688,6 +1688,64 @@ void srcu_barrier(struct srcu_struct *ssp)
> >  }
> >  EXPORT_SYMBOL_GPL(srcu_barrier);
> >  
> > +/* Callback for srcu_expedite_current() usage. */
> > +static void srcu_expedite_current_cb(struct rcu_head *rhp)
> > +{
> > + unsigned long flags;
> > + bool needcb = false;
> > + struct srcu_data *sdp = container_of(rhp, struct srcu_data, srcu_ec_head);
> > +
> > + spin_lock_irqsave_sdp_contention(sdp, &flags);
> > + if (sdp->srcu_ec_state == SRCU_EC_IDLE) {
> > + WARN_ON_ONCE(1);
> > + } else if (sdp->srcu_ec_state == SRCU_EC_PENDING) {
> > + sdp->srcu_ec_state = SRCU_EC_IDLE;
> > + } else {
> > + WARN_ON_ONCE(sdp->srcu_ec_state != SRCU_EC_REPOST);
> > + sdp->srcu_ec_state = SRCU_EC_PENDING;
> > + needcb = true;
> > + }
> > + spin_unlock_irqrestore_rcu_node(sdp, flags);
> > + // If needed, requeue ourselves as an expedited SRCU callback.
> > + if (needcb)
> > + __call_srcu(sdp->ssp, &sdp->srcu_ec_head, srcu_expedite_current_cb, false);
> > +}
> > +
> > +/**
> > + * srcu_expedite_current - Expedite the current SRCU grace period
> > + * @ssp: srcu_struct to expedite.
> > + *
> > + * Cause the current SRCU grace period to become expedited. The grace
> > + * period following the current one might also be expedited. If there is
> > + * no current grace period, one might be created. If the current grace
> > + * period is currently sleeping, that sleep will complete before expediting
> > + * will take effect.
> > + */
> > +void srcu_expedite_current(struct srcu_struct *ssp)
> > +{
> > + unsigned long flags;
> > + bool needcb = false;
> > + struct srcu_data *sdp;
> > +
> > + preempt_disable();
> > + sdp = this_cpu_ptr(ssp->sda);
> > + spin_lock_irqsave_sdp_contention(sdp, &flags);
> 
> For PREEMPT_RT kernels, a locking warnings may occur here.

As in the above "preempt_disable()" needs to be "migrate_disable()",
correct?

One could argue that preempt_disable() is faster and that it works fine
in !PREEMPT_RT kernels, but srcu_expedite_current() should not be called
all that frequently and is relatively high overhead anyway.

Or did you have some other fix in mind?

> > + if (sdp->srcu_ec_state == SRCU_EC_IDLE) {
> > + sdp->srcu_ec_state = SRCU_EC_PENDING;
> > + needcb = true;
> > + } else if (sdp->srcu_ec_state == SRCU_EC_PENDING) {
> > + sdp->srcu_ec_state = SRCU_EC_REPOST;
> > + } else {
> > + WARN_ON_ONCE(sdp->srcu_ec_state != SRCU_EC_REPOST);
> > + }
> > + spin_unlock_irqrestore_rcu_node(sdp, flags);
> > + // If needed, queue an expedited SRCU callback.
> > + if (needcb)
> > + __call_srcu(ssp, &sdp->srcu_ec_head, srcu_expedite_current_cb, false);
> 
> The locking warnings may also occur in the __call_srcu().

And use of migrate_disable() fixes things here, correct?

							Thanx, Paul

> Thanks
> Zqiang
> 
> > + preempt_enable();
> > +}
> > +EXPORT_SYMBOL_GPL(srcu_expedite_current);
> > +
> >  /**
> >  * srcu_batches_completed - return batches completed.
> >  * @ssp: srcu_struct on which to report batch completion.
> > -- 
> > 2.40.1
> >

