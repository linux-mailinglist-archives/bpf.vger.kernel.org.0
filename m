Return-Path: <bpf+bounces-78343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC36BD0BAC2
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 18:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5380630F24EA
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14584366DD5;
	Fri,  9 Jan 2026 17:21:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD56366DBE;
	Fri,  9 Jan 2026 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979276; cv=none; b=XS19hFpcsVW42w+25W/tph5vqox1tiVZaLon7Ccxh2597F6APwj9QUFQ5UpFwPeHwUzBwVinGbJr5fga7NEhYCqoTT98RAZEPR+HNze6W6/+/ikU2MzTAo0wIX624qNRUUxzKSOdU2H1DXnektXiO0QkudXTrnJpZchmjPEwgIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979276; c=relaxed/simple;
	bh=DOvoKV7leDATbnVk+etY4lJwTqqv0DlgNSj6Id/Lqa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtaHnDnAaL7WywtcjpFw/hFNcciV2GO1aCtUqo80I/9YLavmgOIZESrINUeSL3PnjgkERPxJrfs0mhg7VXwDuEG4uWqzPPqJC5KxDalzF3+P7Z6ApmPiHkyuul5n62Ijfz2rY6Bat4zjhtfK9cEeCvyxgvXip659I5hpYM6t3eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id EA51C59270;
	Fri,  9 Jan 2026 17:21:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id DF74A35;
	Fri,  9 Jan 2026 17:21:10 +0000 (UTC)
Date: Fri, 9 Jan 2026 12:21:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260109122142.108982d9@gandalf.local.home>
In-Reply-To: <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
References: <20260108220550.2f6638f3@fedora>
	<da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: t6qqcy6bo8z5pbaoxr1a5dqzxt9m634t
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DF74A35
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+KXbAZPFY+TZKHIZAVLOnuYfnIRGWzx2s=
X-HE-Tag: 1767979270-242114
X-HE-Meta: U2FsdGVkX1/HGqsVZMDGmI/VtP4+H+xGj2FZAcKgSHYZD0IpBJy3SxL0JyTI73kvwwqSFptEYb7uHzjGlyeJ0rRXOSU3HaOD+vSH7Ig5tBBEMcsK9S10Db4Sz4Ga74gV67hfj0IpsGmsl9l0CZ4Yh5KqQ4tXHnwe1RPJHINE8CS39RBoywF1lguJtZCbpIFzxnqbbmmIo7cuWerfHI9y/pmPjrHOdN004swCRQsbkdX6GDsJ13ljCOwlCeOKaGO06zNqHsIKNkEDtIBndzXZdVSqUw8etSnNYvLyQJAY0CDEK5lgI4ByIcInrqldmoGRIP+FCUCWjkJiuc2+jmah9otCfN8Z0gUjozITZeysETmtdZt+MLiMQsyc7Z6CwCBtmFIpEjmBTRVR9UHWZdkX0Q==

On Fri, 9 Jan 2026 09:40:17 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2026-01-08 22:05, Steven Rostedt wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>  
> [...]
> 
> I disagree with many elements of the proposed approach.
> 
> On one end we have BPF wanting to hook on arbitrary tracepoints without
> adding significant latency to PREEMPT RT kernels.
> 
> One the other hand, we have high-speed tracers which execute very short
> critical sections to serialize trace data into ring buffers.
> 
> All of those users register to the tracepoint API.
> 
> We also have to consider that migrate disable is *not* cheap at all
> compared to preempt disable.

To be fair, every spin_lock() converted into a mutex in PREEMPT_RT now
calls migrate_disable() instead of preempt_disable(). I'm just saying the
overhead of migrate_disable() in PREEMPT_RT is not limited to tracepoints.

> 
> So I'm wondering why all tracepoint users need to pay the migrate
> disable runtime overhead on preempt RT kernels for the sake of BPF ?

We could argue that it is to keep the same paradigm as non RT. Where
the code expects to stay on the same CPU. This is why we needed to add it
to spin_lock() code. Only a few places in the kernel expect spin_lock() to
pin the current task on the CPU, but because of those few cases, we needed
to make all callers of spin_lock() call migrate disable :-/

> 
> Using SRCU-fast to protect tracepoint callback iteration makes sense
> for preempt-rt, but I'd recommend moving the migrate disable guard
> within the bpf callback code rather than slowing down other tracers
> which execute within a short amount of time. Other tracers can then
> choose to disable preemption rather than migration if that's a better
> fit for their needs.

This is a discussion with the BPF folks.

> 
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 3690221ba3d8..a2704c35eda8 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -222,6 +222,26 @@ static inline unsigned int tracing_gen_ctx_dec(void)
> >   	return trace_ctx;
> >   }
> >   
> > +/*
> > + * When PREEMPT_RT is enabled, trace events are called with disabled
> > + * migration. The trace events need to know if the tracepoint disabled
> > + * migration or not so that what is recorded to the ring buffer shows
> > + * the state of when the trace event triggered, and not the state caused
> > + * by the trace event.
> > + */
> > +#ifdef CONFIG_PREEMPT_RT
> > +static inline unsigned int tracing_gen_ctx_dec_cond(void)
> > +{
> > +	unsigned int trace_ctx;
> > +
> > +	trace_ctx = tracing_gen_ctx_dec();
> > +	/* The migration counter starts at bit 4 */
> > +	return trace_ctx - (1 << 4);  
> 
> We should turn this hardcoded "4" value into an enum label or a
> define. That define should be exposed by tracepoint.h. We should
> not hardcode expectations about the implementation of distinct APIs
> across the tracing subsystem.

This is exposed to user space already, so that 4 will never change. And
this is specifically for "trace events" which are what are attached to
tracepoints. No other tracepoint caller needs to know about this "4". This
value goes into the common_preempt_count of the event. libtraceevent
already parses this.

I have no problem making this an enum (or define) and using it here and
where it is set in trace.c:tracing_gen_ctx_irq_test(). But it belongs in
trace_event.h not tracepoint.h.

I can call it TRACE_MIGRATION_SHIFT

#define TRACE_MIGRATION_SHIFT	4

> 
> [...]
> 
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -100,6 +100,25 @@ void for_each_tracepoint_in_module(struct module *mod,
> >   }
> >   #endif /* CONFIG_MODULES */
> >   
> > +/*
> > + * BPF programs can attach to the tracepoint callbacks. But if the
> > + * callbacks are called with preemption disabled, the BPF programs
> > + * can cause quite a bit of latency. When PREEMPT_RT is enabled,
> > + * instead of disabling preemption, use srcu_fast_notrace() for
> > + * synchronization. As BPF programs that are attached to tracepoints
> > + * expect to stay on the same CPU, also disable migration.
> > + */
> > +#ifdef CONFIG_PREEMPT_RT
> > +extern struct srcu_struct tracepoint_srcu;
> > +# define tracepoint_sync() synchronize_srcu(&tracepoint_srcu);
> > +# define tracepoint_guard()				\
> > +	guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> > +	guard(migrate)()
> > +#else
> > +# define tracepoint_sync() synchronize_rcu();
> > +# define tracepoint_guard() guard(preempt_notrace)()
> > +#endif  
> 
> Doing migrate disable on PREEMPT RT for BPF vs preempt disable in other
> tracers should come in a separate preparation patch. It belongs to the
> tracers, not to tracepoints.

That's fair.

> 
> [...]
> 				\
> > diff --git a/include/trace/perf.h b/include/trace/perf.h
> > index a1754b73a8f5..348ad1d9b556 100644
> > --- a/include/trace/perf.h
> > +++ b/include/trace/perf.h
> > @@ -71,6 +71,7 @@ perf_trace_##call(void *__data, proto)					\
> >   	u64 __count __attribute__((unused));				\
> >   	struct task_struct *__task __attribute__((unused));		\
> >   									\
> > +	guard(preempt_notrace)();					\
> >   	do_perf_trace_##call(__data, args);				\
> >   }
> >   
> > @@ -85,9 +86,8 @@ perf_trace_##call(void *__data, proto)					\
> >   	struct task_struct *__task __attribute__((unused));		\
> >   									\
> >   	might_fault();							\
> > -	preempt_disable_notrace();					\
> > +	guard(preempt_notrace)();					\
> >   	do_perf_trace_##call(__data, args);				\
> > -	preempt_enable_notrace();	  
> 
> Move this to a perf-specific preparation patch.				\

Sure.

> >   }
> >   
> >   /*
> > diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> > index 4f22136fd465..6fb58387e9f1 100644
> > --- a/include/trace/trace_events.h
> > +++ b/include/trace/trace_events.h
> > @@ -429,6 +429,22 @@ do_trace_event_raw_event_##call(void *__data, proto)			\
> >   	trace_event_buffer_commit(&fbuffer);				\
> >   }
> >   
> > +/*
> > + * When PREEMPT_RT is enabled, the tracepoint does not disable preemption
> > + * but instead disables migration. The callbacks for the trace events
> > + * need to have a consistent state so that it can reflect the proper
> > + * preempt_disabled counter.  
> 
> Having those defines within trace_events.h is poking holes within any
> hope of abstraction we can have from the tracepoint.h API. This adds
> strong coupling between tracepoint and trace_event.h.

OK, I see you are worried about the coupling between the behavior of
tracepoint.h and trace_event.h.

> 
> Rather than hardcoding preempt counter expectations across tracepoint
> and trace-events, we should expose a #define in tracepoint.h which
> will make the preempt counter nesting level available to other
> parts of the kernel such as trace_events.h. This way we keep everything
> in one place and we don't add cross-references about subtle preempt
> counter nesting level details.

OK, so how do we pass this information from tracepoint.h to the users? I
hate to add another field to task_struct for this.

> 
> > + */
> > +#ifdef CONFIG_PREEMPT_RT
> > +/* disable preemption for RT so that the counters still match */
> > +# define trace_event_guard() guard(preempt_notrace)()
> > +/* Have syscalls up the migrate disable counter to emulate non-syscalls */
> > +# define trace_syscall_event_guard() guard(migrate)()
> > +#else
> > +# define trace_event_guard()
> > +# define trace_syscall_event_guard()
> > +#endif  
> This should be moved to separate tracer-specific prep patches.
> 
> [...]
> 
> > + * The @trace_file is the desrciptor with information about the status  
> 
> descriptor

Oops.

> 
> [...]
> 
> > + *
> > + * Returns a pointer to the data on the ring buffer or NULL if the
> > + *   event was not reserved (event was filtered, too big, or the buffer
> > + *   simply was disabled for write).  
> 
> odd spaces here.

You mean the indentation?  I could add it more and also a colon:

 * Returns: A pointer to the data on the ring buffer or NULL if the
 *          event was not reserved (event was filtered, too big, or the
 *          buffer simply was disabled for write).  

Would that work better?

> 
> [...]
> 
> >   
> > +#ifdef CONFIG_PREEMPT_RT
> > +static void srcu_free_old_probes(struct rcu_head *head)
> > +{
> > +	kfree(container_of(head, struct tp_probes, rcu));
> > +}
> > +
> > +static void rcu_free_old_probes(struct rcu_head *head)
> > +{
> > +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> > +}
> > +#else
> >   static void rcu_free_old_probes(struct rcu_head *head)
> >   {
> >   	kfree(container_of(head, struct tp_probes, rcu));
> >   }
> > +#endif
> >   
> >   static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
> >   {
> > @@ -112,6 +149,13 @@ static inline void release_probes(struct tracepoint *tp, struct tracepoint_func
> >   		struct tp_probes *tp_probes = container_of(old,
> >   			struct tp_probes, probes[0]);
> >   
> > +		/*
> > +		 * Tracepoint probes are protected by either RCU or
> > +		 * Tasks Trace RCU and also by SRCU.  By calling the SRCU  
> 
> I'm confused.
> 
> My understanding is that in !RT we have:
> 
> - RCU (!tracepoint_is_faultable(tp))
> - RCU tasks trace (tracepoint_is_faultable(tp))
> 
> And for RT:
> 
> - SRCU-fast (!tracepoint_is_faultable(tp))
> - RCU tasks trace (tracepoint_is_faultable(tp))
> 
> So I don't understand this comment, and also I don't understand why we
> need to chain the callbacks rather than just call the appropriate
> call_rcu based on the tracepoint "is_faultable" state.
> 
> What am I missing ?

Ah, you are right. I think this was the result of trying different ways of
synchronization. The non-faultable version should be wrapped to either call
normal RCU synchronization or SRCU synchronization.

I can send a new version, or do we want to wait if the BPF folks have a
better idea about the "migrate disable" issue?

Thanks for the review.

-- Steve


> 
> > +		 * callback in the [Tasks Trace] RCU callback we cover
> > +		 * both cases. So let us chain the SRCU and [Tasks Trace]
> > +		 * RCU callbacks to wait for both grace periods.
> > +		 */
> >   		if (tracepoint_is_faultable(tp))
> >   			call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
> >   		else  
> 
> Thanks,
> 
> Mathieu
> 


