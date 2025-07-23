Return-Path: <bpf+bounces-64223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E352CB0FC9B
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 00:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD761AA0CB7
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 22:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B3B26D4EF;
	Wed, 23 Jul 2025 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZA1B2ir"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB21C84D0;
	Wed, 23 Jul 2025 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309073; cv=none; b=AzrGroeFLPzxBtxHOpfnWGHKnEl7e2nG0JOTxGs0S+AsrzaXQJW6Kawg6N1hl0G/QXWsAovpEyVy30KQ0coCJjGRxQ3nvSphIHPS6GFTtN/P/vlnHast9dMhlTQ8nqqN+HHjDFN+trbC3RkBheVCaawpaRf1twOORgNaz9w2MFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309073; c=relaxed/simple;
	bh=nWg3lBnnNQ9i4MO72UJUp2MGs8VTzsxWnlYkK66Ols8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6bh2tr7gXvRNgOVLupZCnICtrTaOSj/gCqka123AmMg+5pYFDt83QsN7k4vHwaQF1LOYQql9s+oAhcbXPKE7pBOGZckaFuTk1jTIM1FkvCBngcTB7UoVfxD4MD8oODn7PoxlyoLWta9n9RiHvZqVZ4+b8ImZ/xjBTkGu9X6N3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZA1B2ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBCCC4CEE7;
	Wed, 23 Jul 2025 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753309072;
	bh=nWg3lBnnNQ9i4MO72UJUp2MGs8VTzsxWnlYkK66Ols8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hZA1B2irUYbtSssLkNho+rE1f9m9yqRCM4OIqu0T/B7NFBH3Ctyt5HlgPSClaG2TU
	 4AGJs9SLwplIzAuTww1rctEgEQI2jMsH87MInitHu4I8jBvZjEQe3WNHgPyZQSxxQ+
	 pdenyneOlKtlBPcoQEpNnFQVBfoJ9dlpCxwMtKoESA9Q1TCCt8GcxgvcWe4z5dc1fm
	 NPPHNvCNLwrpTigLP7i1EwVA+JOjTx3h1conN+OsrWmprgMiU5qnef2HNFkmp0r9Tk
	 ai5tFVf09y3C0THsA2Kb3fjulJO1PfuUIgle5kwA6qZ6vSDdNiW8td5cSWJkV0a5F5
	 G36SRAqvem3Uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0EA81CE127E; Wed, 23 Jul 2025 15:17:52 -0700 (PDT)
Date: Wed, 23 Jul 2025 15:17:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 4/6] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <a09344a7-22dc-48d1-a202-67532507163b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
 <20250723202800.2094614-4-paulmck@kernel.org>
 <020d22f0-a95b-4204-a611-eb3953c33f32@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <020d22f0-a95b-4204-a611-eb3953c33f32@efficios.com>

On Wed, Jul 23, 2025 at 05:40:20PM -0400, Mathieu Desnoyers wrote:
> On 2025-07-23 16:27, Paul E. McKenney wrote:
> > The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
> > to protect invocation of __DO_TRACE_CALL() means that BPF programs
> > attached to tracepoints are non-preemptible.  This is unhelpful in
> > real-time systems, whose users apparently wish to use BPF while also
> > achieving low latencies.  (Who knew?)
> > 
> > One option would be to use preemptible RCU, but this introduces
> > many opportunities for infinite recursion, which many consider to
> > be counterproductive, especially given the relatively small stacks
> > provided by the Linux kernel.  These opportunities could be shut down
> > by sufficiently energetic duplication of code, but this sort of thing
> > is considered impolite in some circles.
> > 
> > Therefore, use the shiny new SRCU-fast API, which provides somewhat faster
> > readers than those of preemptible RCU, at least on my laptop, where
> > task_struct access is more expensive than access to per-CPU variables.
> > And SRCU fast provides way faster readers than does SRCU, courtesy of
> > being able to avoid the read-side use of smp_mb().  Also, it is quite
> > straightforward to create srcu_read_{,un}lock_fast_notrace() functions.
> 
> As-is this will break the tracer callbacks, because some tracers expect
> the tracepoint callback to be called with preemption-off for various
> reasons, including preventing migration.
> 
> We'd need to add preempt off guards in the tracer callbacks that require
> it initially before doing this change.
> 
> I've done something similar for the syscall tracepoints when introducing
> faultable syscall tracepoints:
> 
> 4aadde89d81f tracing/bpf: disable preemption in syscall probe
> 65e7462a16ce tracing/perf: disable preemption in syscall probe
> 13d750c2c03e tracing/ftrace: disable preemption in syscall probe

Thank you, Mathieu!

I believe that Steve provided me with the essentials for perf and ftrace,
but please check:  f808f53d4e4f ("squash! tracing: Guard __DECLARE_TRACE()
use of __DO_TRACE_CALL() with SRCU-fast").

On BPF, given that a major point of this exercise is that BPF programs be
preemptible, if we do need additional disabling of preemption, presumably
there would also need to be countervailing enabling somewhere on the
BPF side?

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > While in the area, SRCU now supports early boot call_srcu().  Therefore,
> > remove the checks that used to avoid such use from rcu_free_old_probes()
> > before this commit was applied:
> > 
> > e53244e2c893 ("tracepoint: Remove SRCU protection")
> > 
> > The current commit can be thought of as an approximate revert of that
> > commit.
> > 
> > Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: <bpf@vger.kernel.org>
> > ---
> >   include/linux/tracepoint.h |  6 ++++--
> >   kernel/tracepoint.c        | 21 ++++++++++++++++++++-
> >   2 files changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 826ce3f8e1f85..a22c1ab88560b 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -33,6 +33,8 @@ struct trace_eval_map {
> >   #define TRACEPOINT_DEFAULT_PRIO	10
> > +extern struct srcu_struct tracepoint_srcu;
> > +
> >   extern int
> >   tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> >   extern int
> > @@ -115,7 +117,7 @@ void for_each_tracepoint_in_module(struct module *mod,
> >   static inline void tracepoint_synchronize_unregister(void)
> >   {
> >   	synchronize_rcu_tasks_trace();
> > -	synchronize_rcu();
> > +	synchronize_srcu(&tracepoint_srcu);
> >   }
> >   static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> >   {
> > @@ -271,7 +273,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >   	static inline void __do_trace_##name(proto)			\
> >   	{								\
> >   		if (cond) {						\
> > -			guard(preempt_notrace)();			\
> > +			guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> >   			__DO_TRACE_CALL(name, TP_ARGS(args));		\
> >   		}							\
> >   	}								\
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 62719d2941c90..e19973015cbd7 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -25,6 +25,9 @@ enum tp_func_state {
> >   extern tracepoint_ptr_t __start___tracepoints_ptrs[];
> >   extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
> > +DEFINE_SRCU(tracepoint_srcu);
> > +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> > +
> >   enum tp_transition_sync {
> >   	TP_TRANSITION_SYNC_1_0_1,
> >   	TP_TRANSITION_SYNC_N_2_1,
> > @@ -34,6 +37,7 @@ enum tp_transition_sync {
> >   struct tp_transition_snapshot {
> >   	unsigned long rcu;
> > +	unsigned long srcu_gp;
> >   	bool ongoing;
> >   };
> > @@ -46,6 +50,7 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
> >   	/* Keep the latest get_state snapshot. */
> >   	snapshot->rcu = get_state_synchronize_rcu();
> > +	snapshot->srcu_gp = start_poll_synchronize_srcu(&tracepoint_srcu);
> >   	snapshot->ongoing = true;
> >   }
> > @@ -56,6 +61,8 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
> >   	if (!snapshot->ongoing)
> >   		return;
> >   	cond_synchronize_rcu(snapshot->rcu);
> > +	if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu_gp))
> > +		synchronize_srcu(&tracepoint_srcu);
> >   	snapshot->ongoing = false;
> >   }
> > @@ -101,17 +108,29 @@ static inline void *allocate_probes(int count)
> >   	return p == NULL ? NULL : p->probes;
> >   }
> > -static void rcu_free_old_probes(struct rcu_head *head)
> > +static void srcu_free_old_probes(struct rcu_head *head)
> >   {
> >   	kfree(container_of(head, struct tp_probes, rcu));
> >   }
> > +static void rcu_free_old_probes(struct rcu_head *head)
> > +{
> > +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> > +}
> > +
> >   static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
> >   {
> >   	if (old) {
> >   		struct tp_probes *tp_probes = container_of(old,
> >   			struct tp_probes, probes[0]);
> > +		/*
> > +		 * Tracepoint probes are protected by either RCU or
> > +		 * Tasks Trace RCU and also by SRCU.  By calling the SRCU
> > +		 * callback in the [Tasks Trace] RCU callback we cover
> > +		 * both cases. So let us chain the SRCU and [Tasks Trace]
> > +		 * RCU callbacks to wait for both grace periods.
> > +		 */
> >   		if (tracepoint_is_faultable(tp))
> >   			call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
> >   		else
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

