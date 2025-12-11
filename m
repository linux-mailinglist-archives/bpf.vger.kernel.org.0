Return-Path: <bpf+bounces-76488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D354DCB725C
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 21:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD2B2302CB95
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366BA319879;
	Thu, 11 Dec 2025 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ5a6Sr6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BC1F95C;
	Thu, 11 Dec 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765484612; cv=none; b=axFwfD9ryH9uf1GtIqxPIMtfotBGVWxAEiOkQ7mQdx3TG7gUXxrFSuq8zmQ45eqlhhuRDVGa0cLNJ/PuWTtOgmNi3zMQrAxvoBdnxkta5+po9gDfT/+5YeQ3JONFUrQsyVvKiNhPRPXG/j4vBSPgTUQHb9DtsggIilosiD6XShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765484612; c=relaxed/simple;
	bh=a9CpIc1TZhxaaogDxMwtDG/+e76K6NWH78uZmJ8d2P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejuEiwOLTRZzbWJKBDxZUBWQR9ZCyyBI5BZV5jr1QAcjwvn/CwE5dd399oFUN953NgqbMXnCkmrzjaw8VDf2ke8P+Hfdpg9vk/vYXM7LpM+Hz/ogYzmeaVkqG2RuQ2qvfayhURiGBH1ci46ogajfX/jlLv0inpCGlgELukp+zyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ5a6Sr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F0DC4CEF7;
	Thu, 11 Dec 2025 20:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765484612;
	bh=a9CpIc1TZhxaaogDxMwtDG/+e76K6NWH78uZmJ8d2P0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dQ5a6Sr6LDPylUWiFRq5l0aqDePmqUA7PephJis05vIUNq/Ot/nDuDUnBdJJcauHB
	 yEa6P1UuPXLwfX1VQqe2d/jmZlW00FtfUvK18dGlDMZAW5lL2jHSf6UzzLqAKwcmDL
	 t8uAFW0KFuIHMGIFDcrIOsH5zPGONXDubeWdBPtWPTypZarGAx0PY26gAwoiN/lOAf
	 bzRlFrWNsFJCAUY2i6+qWIcGDHCIE6e2SDnRDw3B9KJMWHU5bZ98gnxXio5DDE5wvO
	 fFoJok5EjsJ1XKx4AweUw3hOYUz0dRhVnVk/NM9MtDl6uTnsZS6bwH6sZ3dzDvrqxX
	 CGUUYBlVvA0pw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C4FB9CE0C54; Thu, 11 Dec 2025 12:23:29 -0800 (PST)
Date: Thu, 11 Dec 2025 12:23:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steve Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <febd477b-c111-4d5e-be89-cae3685853f5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e2fe3162-4b7b-44d6-91ff-f439b3dce706@paulmck-laptop>
 <B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B5D08899-9C23-4FA3-B988-3BB3E8E6D908@nvidia.com>

On Thu, Dec 11, 2025 at 08:02:15PM +0000, Joel Fernandes wrote:
> 
> 
> > On Dec 8, 2025, at 1:20 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿The current use of guard(preempt_notrace)() within __DECLARE_TRACE()
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
> > readers than those of preemptible RCU, at least on Paul E. McKenney's
> > laptop, where task_struct access is more expensive than access to per-CPU
> > variables.  And SRCU-fast provides way faster readers than does SRCU,
> > courtesy of being able to avoid the read-side use of smp_mb().  Also,
> > it is quite straightforward to create srcu_read_{,un}lock_fast_notrace()
> > functions.
> > 
> > While in the area, SRCU now supports early boot call_srcu().  Therefore,
> > remove the checks that used to avoid such use from rcu_free_old_probes()
> > before this commit was applied:
> > 
> > e53244e2c893 ("tracepoint: Remove SRCU protection")
> > 
> > The current commit can be thought of as an approximate revert of that
> > commit, with some compensating additions of preemption disabling.
> > This preemption disabling uses guard(preempt_notrace)().
> > 
> > However, Yonghong Song points out that BPF assumes that non-sleepable
> > BPF programs will remain on the same CPU, which means that migration
> > must be disabled whenever preemption remains enabled.  In addition,
> > non-RT kernels have performance expectations that would be violated by
> > allowing the BPF programs to be preempted.
> > 
> > Therefore, continue to disable preemption in non-RT kernels, and protect
> > the BPF program with both SRCU and migration disabling for RT kernels,
> > and even then only if preemption is not already disabled.
> 
> Hi Paul,
> 
> Is there a reason to not make non-RT also benefit from SRCU fast and trace points for BPF? Can be a follow up patch though if needed.

Because in some cases the non-RT benefit is suspected to be negative
due to increasing the probability of preemption in awkward places.

> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

Thank you, and I will let Steven collect this one.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> 
> 
> 
> > 
> > [ paulmck: Apply kernel test robot and Yonghong Song feedback. ]
> > [ paulmck: Remove trace_syscalls.h changes per Steven Rostedt. ]
> > 
> > Link: https://lore.kernel.org/all/20250613152218.1924093-1-bigeasy@linutronix.de/
> > Signed-off-by: Steve Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: <bpf@vger.kernel.org>
> > 
> > ---
> > 
> > include/linux/trace_events.h |   20 ++++++++++++++++++++
> > include/linux/tracepoint.h   |   25 ++++++++++++++++++++++---
> > include/trace/perf.h         |    4 ++--
> > include/trace/trace_events.h |   21 +++++++++++++++++++--
> > kernel/trace/trace_events.c  |    8 +-------
> > kernel/tracepoint.c          |   33 +++++++++++++++++++++++++++++++++
> > 6 files changed, 97 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index 3690221ba3d80..c38988778f525 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -222,6 +222,26 @@ static inline unsigned int tracing_gen_ctx_dec(void)
> >    return trace_ctx;
> > }
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
> > +    unsigned int trace_ctx;
> > +
> > +    trace_ctx = tracing_gen_ctx_dec();
> > +    /* The migration counter starts at bit 4 */
> > +    return trace_ctx - (1 << 4);
> > +}
> > +#else
> > +# define tracing_gen_ctx_dec_cond() tracing_gen_ctx_dec()
> > +#endif
> > +
> > struct trace_event_file;
> > 
> > struct ring_buffer_event *
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 8a56f3278b1b9..0563c7d9fcb22 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -100,6 +100,25 @@ void for_each_tracepoint_in_module(struct module *mod,
> > }
> > #endif /* CONFIG_MODULES */
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
> > +# define tracepoint_guard()                \
> > +    guard(srcu_fast_notrace)(&tracepoint_srcu);    \
> > +    guard(migrate)()
> > +#else
> > +# define tracepoint_sync() synchronize_rcu();
> > +# define tracepoint_guard() guard(preempt_notrace)()
> > +#endif
> > +
> > /*
> >  * tracepoint_synchronize_unregister must be called between the last tracepoint
> >  * probe unregistration and the end of module exit to make sure there is no
> > @@ -115,7 +134,7 @@ void for_each_tracepoint_in_module(struct module *mod,
> > static inline void tracepoint_synchronize_unregister(void)
> > {
> >    synchronize_rcu_tasks_trace();
> > -    synchronize_rcu();
> > +    tracepoint_sync();
> > }
> > static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> > {
> > @@ -275,13 +294,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >        return static_branch_unlikely(&__tracepoint_##name.key);\
> >    }
> > 
> > -#define __DECLARE_TRACE(name, proto, args, cond, data_proto)        \
> > +#define __DECLARE_TRACE(name, proto, args, cond, data_proto)            \
> >    __DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
> >    static inline void __do_trace_##name(proto)            \
> >    {                                \
> >        TRACEPOINT_CHECK(name)                    \
> >        if (cond) {                        \
> > -            guard(preempt_notrace)();            \
> > +            tracepoint_guard();                \
> >            __DO_TRACE_CALL(name, TP_ARGS(args));        \
> >        }                            \
> >    }                                \
> > diff --git a/include/trace/perf.h b/include/trace/perf.h
> > index a1754b73a8f55..348ad1d9b5566 100644
> > --- a/include/trace/perf.h
> > +++ b/include/trace/perf.h
> > @@ -71,6 +71,7 @@ perf_trace_##call(void *__data, proto)                    \
> >    u64 __count __attribute__((unused));                \
> >    struct task_struct *__task __attribute__((unused));        \
> >                                    \
> > +    guard(preempt_notrace)();                    \
> >    do_perf_trace_##call(__data, args);                \
> > }
> > 
> > @@ -85,9 +86,8 @@ perf_trace_##call(void *__data, proto)                    \
> >    struct task_struct *__task __attribute__((unused));        \
> >                                    \
> >    might_fault();                            \
> > -    preempt_disable_notrace();                    \
> > +    guard(preempt_notrace)();                    \
> >    do_perf_trace_##call(__data, args);                \
> > -    preempt_enable_notrace();                    \
> > }
> > 
> > /*
> > diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> > index 4f22136fd4656..6fb58387e9f15 100644
> > --- a/include/trace/trace_events.h
> > +++ b/include/trace/trace_events.h
> > @@ -429,6 +429,22 @@ do_trace_event_raw_event_##call(void *__data, proto)            \
> >    trace_event_buffer_commit(&fbuffer);                \
> > }
> > 
> > +/*
> > + * When PREEMPT_RT is enabled, the tracepoint does not disable preemption
> > + * but instead disables migration. The callbacks for the trace events
> > + * need to have a consistent state so that it can reflect the proper
> > + * preempt_disabled counter.
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
> > +
> > #undef DECLARE_EVENT_CLASS
> > #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)    \
> > __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
> > @@ -436,6 +452,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
> > static notrace void                            \
> > trace_event_raw_event_##call(void *__data, proto)            \
> > {                                    \
> > +    trace_event_guard();                        \
> >    do_trace_event_raw_event_##call(__data, args);            \
> > }
> > 
> > @@ -447,9 +464,9 @@ static notrace void                            \
> > trace_event_raw_event_##call(void *__data, proto)            \
> > {                                    \
> >    might_fault();                            \
> > -    preempt_disable_notrace();                    \
> > +    trace_syscall_event_guard();                    \
> > +    guard(preempt_notrace)();                    \
> >    do_trace_event_raw_event_##call(__data, args);            \
> > -    preempt_enable_notrace();                    \
> > }
> > 
> > /*
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index b16a5a1580401..2d8fd140eaf9e 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -659,13 +659,7 @@ void *trace_event_buffer_reserve(struct trace_event_buffer *fbuffer,
> >        trace_event_ignore_this_pid(trace_file))
> >        return NULL;
> > 
> > -    /*
> > -     * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
> > -     * preemption (adding one to the preempt_count). Since we are
> > -     * interested in the preempt_count at the time the tracepoint was
> > -     * hit, we need to subtract one to offset the increment.
> > -     */
> > -    fbuffer->trace_ctx = tracing_gen_ctx_dec();
> > +    fbuffer->trace_ctx = tracing_gen_ctx_dec_cond();
> >    fbuffer->trace_file = trace_file;
> > 
> >    fbuffer->event =
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 62719d2941c90..6a6bcf86bfbed 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -25,6 +25,12 @@ enum tp_func_state {
> > extern tracepoint_ptr_t __start___tracepoints_ptrs[];
> > extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
> > 
> > +/* In PREEMPT_RT, SRCU is used to protect the tracepoint callbacks */
> > +#ifdef CONFIG_PREEMPT_RT
> > +DEFINE_SRCU_FAST(tracepoint_srcu);
> > +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> > +#endif
> > +
> > enum tp_transition_sync {
> >    TP_TRANSITION_SYNC_1_0_1,
> >    TP_TRANSITION_SYNC_N_2_1,
> > @@ -34,6 +40,7 @@ enum tp_transition_sync {
> > 
> > struct tp_transition_snapshot {
> >    unsigned long rcu;
> > +    unsigned long srcu_gp;
> >    bool ongoing;
> > };
> > 
> > @@ -46,6 +53,9 @@ static void tp_rcu_get_state(enum tp_transition_sync sync)
> > 
> >    /* Keep the latest get_state snapshot. */
> >    snapshot->rcu = get_state_synchronize_rcu();
> > +#ifdef CONFIG_PREEMPT_RT
> > +    snapshot->srcu_gp = start_poll_synchronize_srcu(&tracepoint_srcu);
> > +#endif
> >    snapshot->ongoing = true;
> > }
> > 
> > @@ -56,6 +66,10 @@ static void tp_rcu_cond_sync(enum tp_transition_sync sync)
> >    if (!snapshot->ongoing)
> >        return;
> >    cond_synchronize_rcu(snapshot->rcu);
> > +#ifdef CONFIG_PREEMPT_RT
> > +    if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu_gp))
> > +        synchronize_srcu(&tracepoint_srcu);
> > +#endif
> >    snapshot->ongoing = false;
> > }
> > 
> > @@ -101,10 +115,22 @@ static inline void *allocate_probes(int count)
> >    return p == NULL ? NULL : p->probes;
> > }
> > 
> > +#ifdef CONFIG_PREEMPT_RT
> > +static void srcu_free_old_probes(struct rcu_head *head)
> > +{
> > +    kfree(container_of(head, struct tp_probes, rcu));
> > +}
> > +
> > +static void rcu_free_old_probes(struct rcu_head *head)
> > +{
> > +    call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> > +}
> > +#else
> > static void rcu_free_old_probes(struct rcu_head *head)
> > {
> >    kfree(container_of(head, struct tp_probes, rcu));
> > }
> > +#endif
> > 
> > static inline void release_probes(struct tracepoint *tp, struct tracepoint_func *old)
> > {
> > @@ -112,6 +138,13 @@ static inline void release_probes(struct tracepoint *tp, struct tracepoint_func
> >        struct tp_probes *tp_probes = container_of(old,
> >            struct tp_probes, probes[0]);
> > 
> > +        /*
> > +         * Tracepoint probes are protected by either RCU or
> > +         * Tasks Trace RCU and also by SRCU.  By calling the SRCU
> > +         * callback in the [Tasks Trace] RCU callback we cover
> > +         * both cases. So let us chain the SRCU and [Tasks Trace]
> > +         * RCU callbacks to wait for both grace periods.
> > +         */
> >        if (tracepoint_is_faultable(tp))
> >            call_rcu_tasks_trace(&tp_probes->rcu, rcu_free_old_probes);
> >        else

