Return-Path: <bpf+bounces-32603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC4910A0D
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 17:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971691C22908
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 15:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688621B013F;
	Thu, 20 Jun 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Som9HEIv"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35991B0100;
	Thu, 20 Jun 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897861; cv=none; b=a/PC/rEJG+vwZMrX5UN2F4JOao6m0s4MRsWiVboqXsMdegrWqH1i6GT+mBSZOxPiw7WO3VOXcaAlKd9slbULl3V8k84GVxIYMqFmS/ZAUp5gJ4coRFUY9FG2q8Ngp/bsVCIFzwVesXERAZYJ+JuI82KthBC+12QtWzFr40Pq9Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897861; c=relaxed/simple;
	bh=IEhC0p9x2snVKydX5aS28QYN4rJYQuxad4mrw0XQSss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JN9zR91O+JtLJIilnX4gKTcNrdV4ZKgGicCIAQY7Q/Owt5SgW+dls9aTS/M0pxLVDY1sb++tnEsuNxb1Qy1y/QOjpebWu2pNsVFBAUDOap4uwrccA9fd2OdMaVbvkKOWFPft+FXR9y+9cKkCsJeB9oJgUlHaQCpvDuUAP278z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Som9HEIv; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1718897857;
	bh=IEhC0p9x2snVKydX5aS28QYN4rJYQuxad4mrw0XQSss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Som9HEIvEH22Z164vOZrX16wXxl1HAP1NeWg7fM+BxLGd59M8XezlXkbBu3R4f6zB
	 Of1eecIYG55CdEMT6FPb+pWOMQprxc8DtN0nXmjx0QW4Vq6KBRLqmO/5TDoX/gH7nm
	 PMdu+ecNIK6TSmIKxmsK4uQemA7RORKFB4alDxlfrVhZKvAeK4o2t9H6wcUUjxAad3
	 9nYzmGpVDbVvgvxRAEIk6DJopUyo4XArnoROTdM1NOiIWRmyrgPTgkC39xpHDM1iIz
	 8kL6z78M5q2k19i4wt5KM94HSQTmLxM7Bs/1Yod+3lVUVtUGAUQs0F3VtvMOUpa4rx
	 TV7HSSukfHm7Q==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4W4l413Jd8z16yl;
	Thu, 20 Jun 2024 11:37:37 -0400 (EDT)
Message-ID: <e4e9a2bc-1776-4b51-aba4-a147795a5de1@efficios.com>
Date: Thu, 20 Jun 2024 11:38:38 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] tracing: Introduce faultable tracepoints
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>
References: <20231120205418.334172-1-mathieu.desnoyers@efficios.com>
 <20231120205418.334172-2-mathieu.desnoyers@efficios.com>
 <20231120172004.7a1c3acc@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20231120172004.7a1c3acc@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-20 17:20, Steven Rostedt wrote:
> On Mon, 20 Nov 2023 15:54:14 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
>> index 4dc4955f0fbf..67bacfaa8fd0 100644
>> --- a/include/linux/tracepoint-defs.h
>> +++ b/include/linux/tracepoint-defs.h
>> @@ -29,6 +29,19 @@ struct tracepoint_func {
>>   	int prio;
>>   };
>>   
>> +/**
>> + * enum tracepoint_flags - Tracepoint flags
>> + * @TRACEPOINT_MAY_EXIST: Don't return an error if the tracepoint does not
>> + *                        exist upon registration.
>> + * @TRACEPOINT_MAY_FAULT: The tracepoint probe callback will be called with
>> + *                        preemption enabled, and is allowed to take page
>> + *                        faults.
>> + */
>> +enum tracepoint_flags {
>> +	TRACEPOINT_MAY_EXIST = (1 << 0),
>> +	TRACEPOINT_MAY_FAULT = (1 << 1),
>> +};
>> +
>>   struct tracepoint {
>>   	const char *name;		/* Tracepoint name */
>>   	struct static_key key;
>> @@ -39,6 +52,7 @@ struct tracepoint {
>>   	int (*regfunc)(void);
>>   	void (*unregfunc)(void);
>>   	struct tracepoint_func __rcu *funcs;
>> +	unsigned int flags;
> 
> Since faultable and non-faultable events are mutually exclusive, why not
> just allocated them separately? Then you could have the __DO_TRACE() macro
> get passed in whether the event can be faulted or not, by the created trace.

Hi Steven,

Sorry for the delayed reply. We're now resuming work on this series.

We already have may_exit and want to introduce may_fault. I want to
avoid:

- combinatory explosion of the number of tracepoint API functions,
- allocating tracepoints into different sections based on their
   characteristics, which will make it unclear how additional axes
   will later fit into the scheme.
- passing a set of booleans to functions as an API, which I find more
   error prone than explicit flags. I prefer:

   func(..., TRACEPOINT_MAY_FAULT | TRACEPOINT_MAY_EXIST);

   over:

   func(..., true, true);

So technically we could split faultable and non-faultable tracepoints
into different sections, but how would it be an improvement over the
proposed approach ? Note that the registration function checks that
the faultable flag of the probe matches the faultable flag of the
tracepoint, which prevents mixups already.

> 
> 
>>   };
>>   
>>   #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>> index 88c0ba623ee6..8a6b58a2bf3b 100644
>> --- a/include/linux/tracepoint.h
>> +++ b/include/linux/tracepoint.h
>> @@ -18,6 +18,7 @@
>>   #include <linux/types.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/rcupdate.h>
>> +#include <linux/rcupdate_trace.h>
>>   #include <linux/tracepoint-defs.h>
>>   #include <linux/static_call.h>
>>   
>> @@ -41,17 +42,10 @@ extern int
>>   tracepoint_probe_register_prio(struct tracepoint *tp, void *probe, void *data,
>>   			       int prio);
>>   extern int
>> -tracepoint_probe_register_prio_may_exist(struct tracepoint *tp, void *probe, void *data,
>> -					 int prio);
>> +tracepoint_probe_register_prio_flags(struct tracepoint *tp, void *probe, void *data,
>> +			       int prio, unsigned int flags);
>>   extern int
>>   tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data);
>> -static inline int
>> -tracepoint_probe_register_may_exist(struct tracepoint *tp, void *probe,
>> -				    void *data)
>> -{
>> -	return tracepoint_probe_register_prio_may_exist(tp, probe, data,
>> -							TRACEPOINT_DEFAULT_PRIO);
>> -}
>>   extern void
>>   for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
>>   		void *priv);
>> @@ -90,6 +84,7 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
>>   #ifdef CONFIG_TRACEPOINTS
>>   static inline void tracepoint_synchronize_unregister(void)
>>   {
>> +	synchronize_rcu_tasks_trace();
> 
> As Peter mentioned, why not use the srcu below?

This was discussed thoroughly in a separate thread. See

https://lore.kernel.org/lkml/e3721b80-4dfb-4914-acfb-b315b8cc45b8@paulmck-laptop/

> 
>>   	synchronize_srcu(&tracepoint_srcu);
>>   	synchronize_rcu();
>>   }
>> @@ -192,9 +187,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>    * it_func[0] is never NULL because there is at least one element in the array
>>    * when the array itself is non NULL.
>>    */
>> -#define __DO_TRACE(name, args, cond, rcuidle)				\
>> +#define __DO_TRACE(name, args, cond, rcuidle, tp_flags)			\
>>   	do {								\
>>   		int __maybe_unused __idx = 0;				\
>> +		bool mayfault = (tp_flags) & TRACEPOINT_MAY_FAULT;	\
>>   									\
>>   		if (!(cond))						\
>>   			return;						\
>> @@ -202,8 +198,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   		if (WARN_ON_ONCE(RCUIDLE_COND(rcuidle)))		\
>>   			return;						\
>>   									\
>> -		/* keep srcu and sched-rcu usage consistent */		\
>> -		preempt_disable_notrace();				\
>> +		if (mayfault) {						\
>> +			rcu_read_lock_trace();				\
>> +		} else {						\
>> +			/* keep srcu and sched-rcu usage consistent */	\
>> +			preempt_disable_notrace();			\
>> +		}							\
> 
> Change the above comment and have:
> 
> 		if (!mayfault)
> 			preempt_disable_notrace();
> 
> And we can have:
> 
> 		if (rcuidle || mayfault) {
> 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);
> 			if (!mayfault)
> 				ct_irq_enter_irqson();
> 		}

Not needed if we keep rcu_read_lock_trace() which exists for this purpose.

> 
>>   									\
>>   		/*							\
>>   		 * For rcuidle callers, use srcu since sched-rcu	\
>> @@ -221,20 +221,23 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
>>   		}							\
>>   									\
>> -		preempt_enable_notrace();				\
>> +		if (mayfault)						\
>> +			rcu_read_unlock_trace();			\
>> +		else							\
>> +			preempt_enable_notrace();			\
>>   	} while (0)
>>   
>>   #ifndef MODULE
>> -#define __DECLARE_TRACE_RCU(name, proto, args, cond)			\
>> +#define __DECLARE_TRACE_RCU(name, proto, args, cond, tp_flags)		\
>>   	static inline void trace_##name##_rcuidle(proto)		\
>>   	{								\
>>   		if (static_key_false(&__tracepoint_##name.key))		\
>>   			__DO_TRACE(name,				\
>>   				TP_ARGS(args),				\
>> -				TP_CONDITION(cond), 1);			\
>> +				TP_CONDITION(cond), 1, tp_flags);	\
>>   	}
>>   #else
>> -#define __DECLARE_TRACE_RCU(name, proto, args, cond)
>> +#define __DECLARE_TRACE_RCU(name, proto, args, cond, tp_flags)
>>   #endif
>>   
>>   /*
>> @@ -248,7 +251,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>    * site if it is not watching, as it will need to be active when the
>>    * tracepoint is enabled.
>>    */
>> -#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
>> +#define __DECLARE_TRACE(name, proto, args, cond, data_proto, tp_flags)	\
> 
> Instead of adding "tp_flags" just pass the "mayfault" boolean in.

As explained above, I want to avoid combinatory explosion of the number
of API functions with ..._may_exist_may_fault_may_xxx_may_yyy(). I also
want to avoid the pattern where we need as many booleans, e.g.:

   ...(..., bool may_exist, bool may_fault, bool may_xxx, bool may_yyy)

which then looks like a maze of (... true, false, true, false) in the
caller macros. This is error prone and tricky to review.

The solution I propose to this problem is introducing the tp_flags.
In the case of __DECLARE_TRACE, the tp_flags are only used for their
TRACEPOINT_MAY_FAULT bit, but it keeps things consistent everywhere:
at tracepoint declaration, registration and use.

Note that ((tp_flags) & TRACEPOINT_MAY_FAULT) evaluates to a constant,
so there is no performance overhead involved.

I would favor keeping the tp_flags to keep everything consistent.

> 
>>   	extern int __traceiter_##name(data_proto);			\
>>   	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
>>   	extern struct tracepoint __tracepoint_##name;			\
>> @@ -257,13 +260,15 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   		if (static_key_false(&__tracepoint_##name.key))		\
>>   			__DO_TRACE(name,				\
>>   				TP_ARGS(args),				\
>> -				TP_CONDITION(cond), 0);			\
>> +				TP_CONDITION(cond), 0, tp_flags);	\
>>   		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
>>   			WARN_ON_ONCE(!rcu_is_watching());		\
>>   		}							\
>> +		if ((tp_flags) & TRACEPOINT_MAY_FAULT)			\
>> +			might_fault();					\
>>   	}								\
>>   	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
>> -			    PARAMS(cond))				\
>> +			    PARAMS(cond), tp_flags)			\
>>   	static inline int						\
>>   	register_trace_##name(void (*probe)(data_proto), void *data)	\
>>   	{								\
>> @@ -278,6 +283,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   					      (void *)probe, data, prio); \
>>   	}								\
>>   	static inline int						\
>> +	register_trace_prio_flags_##name(void (*probe)(data_proto), void *data, \
>> +				   int prio, unsigned int flags)	\
>> +	{								\
>> +		return tracepoint_probe_register_prio_flags(&__tracepoint_##name, \
>> +					      (void *)probe, data, prio, flags); \
>> +	}								\
>> +	static inline int						\
>>   	unregister_trace_##name(void (*probe)(data_proto), void *data)	\
>>   	{								\
>>   		return tracepoint_probe_unregister(&__tracepoint_##name,\
>> @@ -298,7 +310,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>    * structures, so we create an array of pointers that will be used for iteration
>>    * on the tracepoints.
>>    */
>> -#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
>> +#define DEFINE_TRACE_FN_FLAGS(_name, _reg, _unreg, proto, args, tp_flags) \
> 
> Instead of passing in flags, I'm thinking that the faultable tracepoints
> need to go into its own section, and possibly have a
> register_trace_mayfault_##event() to make it highly distinguishable from
> events that don't expect to fault.

Registering a probe over a tracepoint with may_fault bit mismatch is
already rejected.

I'm concerned about multiplying the number of API functions. It may look fine
just now to add "just one more" axis and have ...may_fault_may_exist_prio(),
but I already find it has reached its limits. This is why I favor the flags.

As for placing the faultable tracepoints into their own section, what is
the benefit in doing that ?

> 
> Since everything is made by macros, it's not hard to keep all the above
> code, and wrap it in other macros so that the faultable and non-faultable
> tracepoints share most of the code.
> 
> But as tracepoints live in __section("__tracepoints"), I'm thinking we may
> want __section("__tracepoints_mayfault") to keep them separate.

We could do that, but I'm not sure what we'd gain, and it would certainly
make things awkward when other mutually exclusive "may_..." axes need to
be added in the future.

Thanks,

Mathieu


> 
> Thoughts?
> 
> -- Steve
> 
> 
>>   	static const char __tpstrtab_##_name[]				\
>>   	__section("__tracepoints_strings") = #_name;			\
>>   	extern struct static_call_key STATIC_CALL_KEY(tp_func_##_name);	\
>> @@ -314,7 +326,9 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   		.probestub = &__probestub_##_name,			\
>>   		.regfunc = _reg,					\
>>   		.unregfunc = _unreg,					\
>> -		.funcs = NULL };					\
>> +		.funcs = NULL,						\
>> +		.flags = (tp_flags),					\
>> +	};								\
>>   	__TRACEPOINT_ENTRY(_name);					\
>>   	int __traceiter_##_name(void *__data, proto)			\
>>   	{								\
>> @@ -337,8 +351,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   	}								\
>>   	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
>>   
>> +#define DEFINE_TRACE_FN(_name, _reg, _unreg, proto, args)		\
>> +	DEFINE_TRACE_FN_FLAGS(_name, _reg, _unreg, PARAMS(proto), PARAMS(args), 0)
>> +
>>   #define DEFINE_TRACE(name, proto, args)		\
>> -	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
>> +	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args))
>>   
>>   #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
>>   	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
>> @@ -351,7 +368,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   
>>   
>>   #else /* !TRACEPOINTS_ENABLED */
>> -#define __DECLARE_TRACE(name, proto, args, cond, data_proto)		\
>> +#define __DECLARE_TRACE(name, proto, args, cond, data_proto, tp_flags)	\
>>   	static inline void trace_##name(proto)				\
>>   	{ }								\
>>   	static inline void trace_##name##_rcuidle(proto)		\
>> @@ -363,6 +380,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   		return -ENOSYS;						\
>>   	}								\
>>   	static inline int						\
>> +	register_trace_prio_##name(void (*probe)(data_proto),		\
>> +			      void *data, int prio)			\
>> +	{								\
>> +		return -ENOSYS;						\
>> +	}								\
>> +	static inline int						\
>> +	register_trace_prio_flags_##name(void (*probe)(data_proto),	\
>> +			      void *data, int prio, unsigned int flags)	\
>> +	{								\
>> +		return -ENOSYS;						\
>> +	}								\
>> +	static inline int						\
>>   	unregister_trace_##name(void (*probe)(data_proto),		\
>>   				void *data)				\
>>   	{								\
>> @@ -377,6 +406,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>>   		return false;						\
>>   	}
>>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


