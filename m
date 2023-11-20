Return-Path: <bpf+bounces-15420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E82E7F2020
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AB51C215A0
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 22:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588AD39861;
	Mon, 20 Nov 2023 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268E34541
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 22:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA470C433C9;
	Mon, 20 Nov 2023 22:19:49 +0000 (UTC)
Date: Mon, 20 Nov 2023 17:20:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song
 <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, Joel Fernandes
 <joel@joelfernandes.org>
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
Message-ID: <20231120172004.7a1c3acc@gandalf.local.home>
In-Reply-To: <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
	<20231120205418.334172-2-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 15:54:14 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index 4dc4955f0fbf..67bacfaa8fd0 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -29,6 +29,19 @@ struct tracepoint_func {
>  	int prio;
>  };
>  
> +/**
> + * enum tracepoint_flags - Tracepoint flags
> + * @TRACEPOINT_MAY_EXIST: Don't return an error if the tracepoint does not
> + *                        exist upon registration.
> + * @TRACEPOINT_MAY_FAULT: The tracepoint probe callback will be called with
> + *                        preemption enabled, and is allowed to take page
> + *                        faults.
> + */
> +enum tracepoint_flags {
> +	TRACEPOINT_MAY_EXIST = (1 << 0),
> +	TRACEPOINT_MAY_FAULT = (1 << 1),
> +};
> +
>  struct tracepoint {
>  	const char *name;		/* Tracepoint name */
>  	struct static_key key;
> @@ -39,6 +52,7 @@ struct tracepoint {
>  	int (*regfunc)(void);
>  	void (*unregfunc)(void);
>  	struct tracepoint_func __rcu *funcs;
> +	unsigned int flags;

Since faultable and non-faultable events are mutually exclusive, why not
just allocated them separately? Then you could have the __DO_TRACE() macro
get passed in whether the event can be faulted or not, by the created trace.


>  };
>  
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 88c0ba623ee6..8a6b58a2bf3b 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -18,6 +18,7 @@
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
>  #include <linux/rcupdate.h>
> +#include <linux/rcupdate_trace.h>
>  #include <linux/tracepoint-defs.h>
>  #include <linux/static_call.h>
>  
> @@ -41,17 +42,10 @@ extern int
>  tracepoint_probe_register_prio(struct tracepoint *tp, void *probe, void *data,
>  			       int prio);
>  extern int
> -tracepoint_probe_register_prio_may_exist(struct tracepoint *tp, void *probe, void *data,
> -					 int prio);
> +tracepoint_probe_register_prio_flags(struct tracepoint *tp, void *probe, void *data,
> +			       int prio, unsigned int flags);
>  extern int
>  tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data);
> -static inline int
> -tracepoint_probe_register_may_exist(struct tracepoint *tp, void *probe,
> -				    void *data)
> -{
> -	return tracepoint_probe_register_prio_may_exist(tp, probe, data,
> -							TRACEPOINT_DEFAULT_PRIO);
> -}
>  extern void
>  for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
>  		void *priv);
> @@ -90,6 +84,7 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
>  #ifdef CONFIG_TRACEPOINTS
>  static inline void tracepoint_synchronize_unregister(void)
>  {
> +	synchronize_rcu_tasks_trace();

As Peter mentioned, why not use the srcu below?

>  	synchronize_srcu(&tracepoint_srcu);
>  	synchronize_rcu();
>  }
> @@ -192,9 +187,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>   * it_func[0] is never NULL because there is at least one element in the array
>   * when the array itself is non NULL.
>   */
> -#define __DO_TRACE(name, args, cond, rcuidle)				\
> +#define __DO_TRACE(name, args, cond, rcuidle, tp_flags)			\
>  	do {								\
>  		int __maybe_unused __idx = 0;				\
> +		bool mayfault = (tp_flags) & TRACEPOINT_MAY_FAULT;	\
>  									\
>  		if (!(cond))						\
>  			return;						\
> @@ -202,8 +198,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
>  			return;						\
>  									\
> -		/* keep srcu and sched-rcu usage consistent */		\
> -		preempt_disable_notrace();				\
> +		if (mayfault) {						\
> +			rcu_read_lock_trace();				\
> +		} else {						\
> +			/* keep srcu and sched-rcu usage consistent */	\
> +			preempt_disable_notrace();			\
> +		}							\

Change the above comment and have:

		if (!mayfault)
			preempt_disable_notrace();

And we can have:

		if (rcuidle || mayfault) {
			__idx = srcu_read_lock_notrace(&tracepoint_srcu);
			if (!mayfault)
				ct_irq_enter_irqson();
		}

>  									\
>  		/*							\
>  		 * For rcuidle callers, use srcu since sched-rcu	\
> @@ -221,20 +221,23 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
>  		}							\
>  									\
> -		preempt_enable_notrace();				\
> +		if (mayfault)						\
> +			rcu_read_unlock_trace();			\
> +		else							\
> +			preempt_enable_notrace();			\
>  	} while (0)
>  
>  #ifndef MODULE
> -#define __DECLARE_TRACE_RCU(name, proto, args, cond)			\
> +#define __DECLARE_TRACE_RCU(name, proto, args, cond, tp_flags)		\
>  	static inline void trace_##name##_rcuidle(proto)		\
>  	{								\
>  		if (static_key_false(&__tracepoint_##name.key))		\
>  			__DO_TRACE(name,				\
>  				TP_ARGS(args),				\
> -				TP_CONDITION(cond), 1);			\
> +				TP_CONDITION(cond), 1, tp_flags);	\
>  	}
>  #else
> -#define __DECLARE_TRACE_RCU(name, proto, args, cond)
> +#define __DECLARE_TRACE_RCU(name, proto, args, cond, tp_flags)
>  #endif
>  
>  /*
> @@ -248,7 +251,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>   * site if it is not watching, as it will need to be active when the
>   * tracepoint is enabled.
>   */
> -#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
> +#define __DECLARE_TRACE(name, proto, args, cond, data_proto, tp_flags)	\

Instead of adding "tp_flags" just pass the "mayfault" boolean in.

>  	extern int __traceiter_##name(data_proto);			\
>  	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
>  	extern struct tracepoint __tracepoint_##name;			\
> @@ -257,13 +260,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (static_key_false(&__tracepoint_##name.key))		\
>  			__DO_TRACE(name,				\
>  				TP_ARGS(args),				\
> -				TP_CONDITION(cond), 0);			\
> +				TP_CONDITION(cond), 0, tp_flags);	\
>  		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
>  			WARN_ON_ONCE(!rcu_is_watching());		\
>  		}							\
> +		if ((tp_flags) & TRACEPOINT_MAY_FAULT)			\
> +			might_fault();					\
>  	}								\
>  	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
> -			    PARAMS(cond))				\
> +			    PARAMS(cond), tp_flags)			\
>  	static inline int						\
>  	register_trace_##name(void (*probe)(data_proto), void *data)	\
>  	{								\
> @@ -278,6 +283,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  					      (void *)probe, data, prio); \
>  	}								\
>  	static inline int						\
> +	register_trace_prio_flags_##name(void (*probe)(data_proto), void *data, \
> +				   int prio, unsigned int flags)	\
> +	{								\
> +		return tracepoint_probe_register_prio_flags(&__tracepoint_##name, \
> +					      (void *)probe, data, prio, flags); \
> +	}								\
> +	static inline int						\
>  	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
>  	{								\
>  		return tracepoint_probe_unregister(&__tracepoint_##name,\
> @@ -298,7 +310,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>   * structures, so we create an array of pointers that will be used for iteration
>   * on the tracepoints.
>   */
> -#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
> +#define DEFINE_TRACE_FN_FLAGS(_name, _reg, _unreg, proto, args, tp_flags) \

Instead of passing in flags, I'm thinking that the faultable tracepoints
need to go into its own section, and possibly have a
register_trace_mayfault_##event() to make it highly distinguishable from
events that don't expect to fault.

Since everything is made by macros, it's not hard to keep all the above
code, and wrap it in other macros so that the faultable and non-faultable
tracepoints share most of the code.

But as tracepoints live in __section("__tracepoints"), I'm thinking we may
want __section("__tracepoints_mayfault") to keep them separate.

Thoughts?

-- Steve


>  	static const char __tpstrtab_##_name[]				\
>  	__section("__tracepoints_strings") = #_name;			\
>  	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
> @@ -314,7 +326,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		.probestub = &__probestub_##_name,			\
>  		.regfunc = _reg,					\
>  		.unregfunc = _unreg,					\
> -		.funcs = NULL };					\
> +		.funcs = NULL,						\
> +		.flags = (tp_flags),					\
> +	};								\
>  	__TRACEPOINT_ENTRY(_name);					\
>  	int __traceiter_##_name(void *__data, proto)			\
>  	{								\
> @@ -337,8 +351,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	}								\
>  	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
>  
> +#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
> +	DEFINE_TRACE_FN_FLAGS(_name, _reg, _unreg, PARAMS(proto), PARAMS(args), 0)
> +
>  #define DEFINE_TRACE(name, proto, args)		\
> -	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
> +	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args))
>  
>  #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
>  	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
> @@ -351,7 +368,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  
>  
>  #else /* !TRACEPOINTS_ENABLED */
> -#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
> +#define __DECLARE_TRACE(name, proto, args, cond, data_proto, tp_flags)	\
>  	static inline void trace_##name(proto)				\
>  	{ }								\
>  	static inline void trace_##name##_rcuidle(proto)		\
> @@ -363,6 +380,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		return -ENOSYS;						\
>  	}								\
>  	static inline int						\
> +	register_trace_prio_##name(void (*probe)(data_proto),		\
> +			      void *data, int prio)			\
> +	{								\
> +		return -ENOSYS;						\
> +	}								\
> +	static inline int						\
> +	register_trace_prio_flags_##name(void (*probe)(data_proto),	\
> +			      void *data, int prio, unsigned int flags)	\
> +	{								\
> +		return -ENOSYS;						\
> +	}								\
> +	static inline int						\
>  	unregister_trace_##name(void (*probe)(data_proto),		\
>  				void *data)				\
>  	{								\
> @@ -377,6 +406,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		return false;						\
>  	}
>  

