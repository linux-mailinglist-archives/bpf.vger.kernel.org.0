Return-Path: <bpf+bounces-73875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F4C3CB8A
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758A56255C6
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A510234D900;
	Thu,  6 Nov 2025 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqFSQvja"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580534D91A;
	Thu,  6 Nov 2025 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448493; cv=none; b=olpfMR7GBzhBLq5jsDFD/MbWFUZcictRgIGpqrymufBNCMeZG0KosEmUZXcx4Ln1utuuLDJ95zhIke4+nr6vUTfJGTcWdFMPTvl7Lzdto6XDpMcd3Qnzp60VfiMIiFAanhxoRqHwHUCy4nM9T5cWS1u3n82YDrDhljw6UBZ/7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448493; c=relaxed/simple;
	bh=yfaJSHebfVwzdrRkWXmQxdKIIl7/9T60fI3AZf8nxW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahmzZZngyfflA4CGgFTfcHI5GZvyUqB5RIuSJvBrJQulEhHyFHlKVn4ShgQcDvFp75kaLPAejIEgcs5aGkpP5QiuVjcQW9V1LYcpO1cYD9xL61VixmMTqPg9vnK8b2MiuPNtxHioOkFaUpsKAR27CD509aZ2ktcXR/hTLzP4zmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqFSQvja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DCFC116C6;
	Thu,  6 Nov 2025 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762448491;
	bh=yfaJSHebfVwzdrRkWXmQxdKIIl7/9T60fI3AZf8nxW0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rqFSQvjaCqMSfyESMEXO7pvnz1qAXs0j7XIxeaRh3U2NXT2fo0zdvkerWixk63jFi
	 Y4I2pq01xgHt5fEhIYLlfJS/O6c7CmI81tll8PZk2CNc2vgufCOAG6o0e6xl/+rAw/
	 psAD39EVclJu1AWgx+XzZuFhlwji7HllBwR72YzfaWoPbKDv94IoudDqG2rHZs0+QJ
	 R4f2KgF+A4VXMYzbNqgsE7op8Jte1db5rpfZ+ughRONINGXP8LsXz2JlcOtMf+maD2
	 7CGzzlj6UFLvOp9M0wBnRPTRh1mGOhEnyUoL3HJVXpJM6YVJB94MyHN9Eqo5dDjCDa
	 SKemTfGWdlfHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 29701CE0B24; Thu,  6 Nov 2025 09:01:30 -0800 (PST)
Date: Thu, 6 Nov 2025 09:01:30 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 10/16] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <522b01cf-0cb6-4766-9102-2d08a3983d8a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-10-paulmck@kernel.org>
 <20251106110230.08e877ff@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106110230.08e877ff@batman.local.home>

On Thu, Nov 06, 2025 at 11:02:30AM -0500, Steven Rostedt wrote:
> On Wed,  5 Nov 2025 12:32:10 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > The current commit can be thought of as an approximate revert of that
> > commit, with some compensating additions of preemption disabling pointed
> > out by Steven Rostedt (thank you, Steven!).  This preemption disabling
> 
> > uses guard(preempt_notrace)(), and while in the area a couple of other
> > use cases were also converted to guards.
> 
> Actually, please don't do any conversions. That code is unrelated to
> this work and I may be touching it. I don't need unneeded conflicts.

OK, thank you for letting me know.  Should I set up for the merge window
after this coming one (of course applying your feedback below), or will
you be making this safe for PREEMPT_RT as part of your work?

If I don't hear otherwise, I will assume the former, though I would be
quite happy with the latter.  ;-).

							Thanx, Paul

> > ---
> >  include/linux/tracepoint.h   | 45 ++++++++++++++++++++++--------------
> >  include/trace/perf.h         |  4 ++--
> >  include/trace/trace_events.h |  4 ++--
> >  kernel/tracepoint.c          | 21 ++++++++++++++++-
> >  4 files changed, 52 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 826ce3f8e1f8..9f8b19cd303a 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -33,6 +33,8 @@ struct trace_eval_map {
> >  
> >  #define TRACEPOINT_DEFAULT_PRIO	10
> >  
> > +extern struct srcu_struct tracepoint_srcu;
> > +
> >  extern int
> >  tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> >  extern int
> > @@ -115,7 +117,10 @@ void for_each_tracepoint_in_module(struct module *mod,
> >  static inline void tracepoint_synchronize_unregister(void)
> >  {
> >  	synchronize_rcu_tasks_trace();
> > -	synchronize_rcu();
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +		synchronize_srcu(&tracepoint_srcu);
> > +	else
> > +		synchronize_rcu();
> >  }
> 
> Instead of using the IS_ENABLED(CONFIG_PREEMPT_RT) I think it would be
> somewhat cleaner to add macros (all of this is untested):
> 
> #ifdef CONFIG_PREEMPT_RT
> extern struct srcu_struct tracepoint_srcu;
> # define tracepoint_sync() synchronizes_srcu(&tracepoint_srcu)
> # define tracepoint_guard() \
>      guard(srcu_fast_notrace)(&tracepoint_srcu); \
>      guard(migrate)()
> #else
> # define tracepoint_sync() synchronize_rcu();
> # define tracepoint_guard() guard(preempt_notrace)
> #endif
> 
> And then the above can be:
> 
> static inline void tracepoint_synchronize_unregister(void)
> {
>  	synchronize_rcu_tasks_trace();
> 	tracepoint_sync();
> }
> 
> and the below:
> 
> 	static inline void __do_trace_##name(proto)			\
> 	{								\
> 		if (cond) {						\
> 			tracepoint_guard();				\
> 			__DO_TRACE_CALL(name, TP_ARGS(args));		\
> 		}							\
> 	}								\
> 
> And not have to duplicate all that code.
> 
> >  static inline bool tracepoint_is_faultable(struct tracepoint *tp)
> >  {
> > @@ -266,23 +271,29 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  		return static_branch_unlikely(&__tracepoint_##name.key);\
> >  	}
> >  
> > -#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
> > +#define __DECLARE_TRACE(name, proto, args, cond, data_proto)			\
> >  	__DECLARE_TRACE_COMMON(name, PARAMS(proto), PARAMS(args), PARAMS(data_proto)) \
> > -	static inline void __do_trace_##name(proto)			\
> > -	{								\
> > -		if (cond) {						\
> > -			guard(preempt_notrace)();			\
> > -			__DO_TRACE_CALL(name, TP_ARGS(args));		\
> > -		}							\
> > -	}								\
> > -	static inline void trace_##name(proto)				\
> > -	{								\
> > -		if (static_branch_unlikely(&__tracepoint_##name.key))	\
> > -			__do_trace_##name(args);			\
> > -		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> > -			WARN_ONCE(!rcu_is_watching(),			\
> > -				  "RCU not watching for tracepoint");	\
> > -		}							\
> > +	static inline void __do_trace_##name(proto)				\
> > +	{									\
> > +		if (cond) {							\
> > +			if (IS_ENABLED(CONFIG_PREEMPT_RT) && preemptible()) {	\
> > +				guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> > +				guard(migrate)();				\
> > +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> > +			} else {						\
> > +				guard(preempt_notrace)();			\
> > +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> > +			}							\
> > +		}								\
> > +	}									\
> > +	static inline void trace_##name(proto)					\
> > +	{									\
> > +		if (static_branch_unlikely(&__tracepoint_##name.key))		\
> > +			__do_trace_##name(args);				\
> > +		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {			\
> > +			WARN_ONCE(!rcu_is_watching(),				\
> > +				  "RCU not watching for tracepoint");		\
> > +		}								\
> >  	
> >  
> 
> >  /*
> > diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
> > index 4f22136fd465..fbc07d353be6 100644
> > --- a/include/trace/trace_events.h
> > +++ b/include/trace/trace_events.h
> > @@ -436,6 +436,7 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
> >  static notrace void							\
> >  trace_event_raw_event_##call(void *__data, proto)			\
> >  {									\
> > +	guard(preempt_notrace)();					\
> 
> Note, the tracepoint code expects that there's only one level of
> preemption done, as it records the preempt_count and needs to subtract
> what tracing added. Just calling preempt_notrace here if it had already
> disabled preemption will break that code.
> 
> It should only disable preemption if it hasn't already done that (when
> PREEMPT_RT is enabled).
> 
> >  	do_trace_event_raw_event_##call(__data, args);			\
> >  }
> >  
> > @@ -447,9 +448,8 @@ static notrace void							\
> >  trace_event_raw_event_##call(void *__data, proto)			\
> >  {									\
> >  	might_fault();							\
> > -	preempt_disable_notrace();					\
> > +	guard(preempt_notrace)();					\
> >  	do_trace_event_raw_event_##call(__data, args);			\
> > -	preempt_enable_notrace();					\
> 
> I may be modifying the above, so I would leave it alone.
> 
> Thanks,
> 
> -- Steve
> 

