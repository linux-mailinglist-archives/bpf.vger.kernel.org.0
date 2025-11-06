Return-Path: <bpf+bounces-73867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798AC3C3A6
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 17:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E6418C6A6C
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458C345CB9;
	Thu,  6 Nov 2025 16:02:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8B3314CB;
	Thu,  6 Nov 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444963; cv=none; b=Npud1A8PzTLDa3l0DjSvtX+rEML4E0ZatGSYJyuwgkSM1fS16/RA6TSAEVUSMY30hd9F3wcvJXVNOgK3gjC55Owu+VZI1Ti1AGFJ2gCOe89iuDMHlU80AXkaFQfBzMRmzrFCWus9OwKnq51yjgpbDNjI4d99fq9yYfi6qFFEuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444963; c=relaxed/simple;
	bh=H+shqCH+Wu91YwAHohrcMFif/PuJQzNKSWZc3R7gQDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFfbl1Vddo38SldNbaSxEN1UMXRuUybeMxSZqMs+uMHhjBJqsOQq+k+B/4bzaQUeAbJpKvRGLs2hYLoOOErClEF6/XCBFYsQLyxsYiRccrIV18ovnjnEzTJHRQ+oDK6ZmHm02jYAkoQ8Nfov3dCx5l6ixmU+z8sFhnSbpEdgKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 505681401AC;
	Thu,  6 Nov 2025 16:02:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 63B0520018;
	Thu,  6 Nov 2025 16:02:31 +0000 (UTC)
Date: Thu, 6 Nov 2025 11:02:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org
Subject: Re: [PATCH v2 10/16] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251106110230.08e877ff@batman.local.home>
In-Reply-To: <20251105203216.2701005-10-paulmck@kernel.org>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
	<20251105203216.2701005-10-paulmck@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fmkt714m1m4c6ehxka6831mtzforau8e
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 63B0520018
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19iaTKyFCI0tGtmoCLTDsC8g5M4bk6js8o=
X-HE-Tag: 1762444951-168403
X-HE-Meta: U2FsdGVkX1+3moqzzczi8f0rQKt2e3epFUYYRV6jSfaWDCASsq5r4G1RK7MJifKYHjovT+JyKwH8ChPK+7RU67eNBv6Bu8r4z8pgIl9HuANgMN2IBsIoIXsUwZ6WbWDcYZ4/s1SP36ppyeKkTiib4tOzIwA5z5RJ34eoGuRyeqGHY7prfSdShDK+mqGrA0zEJ+LoKS/lcZbAogkHGOXWAg8EsRWy2SifDVUS+ZZo3qAJLQNe49McGcUjZtVRR5SGinnFib8xTQUrTw4mcJbLTqzy/3iBE2eNxlUIEW2HXSGj6E0lIs3OFPgcjRLzZyU0wzHt4TnaMEClDCnG6M6z3eUh531J3eu/

On Wed,  5 Nov 2025 12:32:10 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> The current commit can be thought of as an approximate revert of that
> commit, with some compensating additions of preemption disabling pointed
> out by Steven Rostedt (thank you, Steven!).  This preemption disabling

> uses guard(preempt_notrace)(), and while in the area a couple of other
> use cases were also converted to guards.

Actually, please don't do any conversions. That code is unrelated to
this work and I may be touching it. I don't need unneeded conflicts.

> ---
>  include/linux/tracepoint.h   | 45 ++++++++++++++++++++++--------------
>  include/trace/perf.h         |  4 ++--
>  include/trace/trace_events.h |  4 ++--
>  kernel/tracepoint.c          | 21 ++++++++++++++++-
>  4 files changed, 52 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 826ce3f8e1f8..9f8b19cd303a 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -33,6 +33,8 @@ struct trace_eval_map {
>  
>  #define TRACEPOINT_DEFAULT_PRIO	10
>  
> +extern struct srcu_struct tracepoint_srcu;
> +
>  extern int
>  tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
>  extern int
> @@ -115,7 +117,10 @@ void for_each_tracepoint_in_module(struct module *mod,
>  static inline void tracepoint_synchronize_unregister(void)
>  {
>  	synchronize_rcu_tasks_trace();
> -	synchronize_rcu();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		synchronize_srcu(&tracepoint_srcu);
> +	else
> +		synchronize_rcu();
>  }

Instead of using the IS_ENABLED(CONFIG_PREEMPT_RT) I think it would be
somewhat cleaner to add macros (all of this is untested):

#ifdef CONFIG_PREEMPT_RT
extern struct srcu_struct tracepoint_srcu;
# define tracepoint_sync() synchronizes_srcu(&tracepoint_srcu)
# define tracepoint_guard() \
     guard(srcu_fast_notrace)(&tracepoint_srcu); \
     guard(migrate)()
#else
# define tracepoint_sync() synchronize_rcu();
# define tracepoint_guard() guard(preempt_notrace)
#endif

And then the above can be:

static inline void tracepoint_synchronize_unregister(void)
{
 	synchronize_rcu_tasks_trace();
	tracepoint_sync();
}

and the below:

	static inline void __do_trace_##name(proto)			\
	{								\
		if (cond) {						\
			tracepoint_guard();				\
			__DO_TRACE_CALL(name, TP_ARGS(args));		\
		}							\
	}								\

And not have to duplicate all that code.

>  static inline bool tracepoint_is_faultable(struct tracepoint *tp)
>  {
> @@ -266,23 +271,29 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		return static_branch_unlikely(&__tracepoint_##name.key);\
>  	}
>  
> -#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
> +#define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
>  	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
> -	static inline void __do_trace_##name(proto)			\
> -	{								\
> -		if (cond) {						\
> -			guard(preempt_notrace)();			\
> -			__DO_TRACE_CALL(name, TP_ARGS(args));		\
> -		}							\
> -	}								\
> -	static inline void trace_##name(proto)				\
> -	{								\
> -		if (static_branch_unlikely(&__tracepoint_##name.key))	\
> -			__do_trace_##name(args);			\
> -		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> -			WARN_ONCE(!rcu_is_watching(),			\
> -				  "RCU not watching for tracepoint");	\
> -		}							\
> +	static inline void __do_trace_##name(proto)				\
> +	{									\
> +		if (cond) {							\
> +			if (IS_ENABLED(CONFIG_PREEMPT_RT) && preemptible()) {	\
> +				guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> +				guard(migrate)();				\
> +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> +			} else {						\
> +				guard(preempt_notrace)();			\
> +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> +			}							\
> +		}								\
> +	}									\
> +	static inline void trace_##name(proto)					\
> +	{									\
> +		if (static_branch_unlikely(&__tracepoint_##name.key))		\
> +			__do_trace_##name(args);				\
> +		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {			\
> +			WARN_ONCE(!rcu_is_watching(),				\
> +				  "RCU not watching for tracepoint");		\
> +		}								\
>  	
>  

>  /*
> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> index 4f22136fd465..fbc07d353be6 100644
> --- a/include/trace/trace_events.h
> +++ b/include/trace/trace_events.h
> @@ -436,6 +436,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
>  static notrace void							\
>  trace_event_raw_event_##call(void *__data, proto)			\
>  {									\
> +	guard(preempt_notrace)();					\

Note, the tracepoint code expects that there's only one level of
preemption done, as it records the preempt_count and needs to subtract
what tracing added. Just calling preempt_notrace here if it had already
disabled preemption will break that code.

It should only disable preemption if it hasn't already done that (when
PREEMPT_RT is enabled).

>  	do_trace_event_raw_event_##call(__data, args);			\
>  }
>  
> @@ -447,9 +448,8 @@ static notrace void							\
>  trace_event_raw_event_##call(void *__data, proto)			\
>  {									\
>  	might_fault();							\
> -	preempt_disable_notrace();					\
> +	guard(preempt_notrace)();					\
>  	do_trace_event_raw_event_##call(__data, args);			\
> -	preempt_enable_notrace();					\

I may be modifying the above, so I would leave it alone.

Thanks,

-- Steve


