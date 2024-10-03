Return-Path: <bpf+bounces-40878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1098F9DD
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 00:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E221F22386
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 22:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C208A1CC8AB;
	Thu,  3 Oct 2024 22:28:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EB0824BD;
	Thu,  3 Oct 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994522; cv=none; b=ikPP0IXFi1M+HW39W49156lVTdO19ETynP9QsS8xb3nBUlB1+DLBoRZMsiuLZj8c65ApWGmHAQRvMsn7aGpogvRTwVZMQa7ZFeUV/cKTI1IUh8nN86dpmsbb/HIhqvjc5ercgi/LDFvddox+QLrxqaj19x+sTbB6PJoyxS/RcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994522; c=relaxed/simple;
	bh=vQ+Gtq2rZ0DxAhxXGoKR2qzo/BAO0lltv5yXC5hj17o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnG1OS9aiu9+5Bg5OhkspSvL+WLMM8Gwd3JBsAK/6+7pzaL3nj61S4bUpjmxGtuFo2JEGf6lafjzkMk40/c8GzVEHBjKNvHynDLbN+IuV0SIMgQrPzZpOxs7UDmpRPu5Y0qFUWmlbw4BAmW+yNi9reRudG6Ol1DYgsEOQHxuxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26477C4CEC5;
	Thu,  3 Oct 2024 22:28:40 +0000 (UTC)
Date: Thu, 3 Oct 2024 18:29:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, Joel
 Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [PATCH v1 5/8] tracing: Allow system call tracepoints to handle
 page faults
Message-ID: <20241003182934.0a027919@gandalf.local.home>
In-Reply-To: <20241003151638.1608537-6-mathieu.desnoyers@efficios.com>
References: <20241003151638.1608537-1-mathieu.desnoyers@efficios.com>
	<20241003151638.1608537-6-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 11:16:35 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Use Tasks Trace RCU to protect iteration of system call enter/exit
> tracepoint probes to allow those probes to handle page faults.
> 
> In preparation for this change, all tracers registering to system call
> enter/exit tracepoints should expect those to be called with preemption
> enabled.
> 
> This allows tracers to fault-in userspace system call arguments such as
> path strings within their probe callbacks.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: bpf@vger.kernel.org
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  include/linux/tracepoint.h | 25 +++++++++++++++++--------
>  init/Kconfig               |  1 +
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 666499b9f3be..6faf34e5efc9 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -17,6 +17,7 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/rcupdate.h>
> +#include <linux/rcupdate_trace.h>
>  #include <linux/tracepoint-defs.h>
>  #include <linux/static_call.h>
>  
> @@ -109,6 +110,7 @@ void for_each_tracepoint_in_module(struct module *mod,
>  #ifdef CONFIG_TRACEPOINTS
>  static inline void tracepoint_synchronize_unregister(void)
>  {
> +	synchronize_rcu_tasks_trace();
>  	synchronize_srcu(&tracepoint_srcu);
>  	synchronize_rcu();
>  }
> @@ -211,7 +213,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>   * it_func[0] is never NULL because there is at least one element in the array
>   * when the array itself is non NULL.
>   */
> -#define __DO_TRACE(name, args, cond, rcuidle)				\
> +#define __DO_TRACE(name, args, cond, rcuidle, syscall)			\
>  	do {								\
>  		int __maybe_unused __idx = 0;				\
>  									\
> @@ -222,8 +224,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  			      "Bad RCU usage for tracepoint"))		\
>  			return;						\
>  									\
> -		/* keep srcu and sched-rcu usage consistent */		\
> -		preempt_disable_notrace();				\
> +		if (syscall) {						\
> +			rcu_read_lock_trace();				\
> +		} else {						\
> +			/* keep srcu and sched-rcu usage consistent */	\
> +			preempt_disable_notrace();			\
> +		}							\
>  									\

I'm thinking we just use rcu_read_lock_trace() and get rid of the
preempt_disable and srcu locks for all tracepoints. Oh crap! I should get
rid of srcu locking too, as it was only needed for the rcuidle code :-p

-- Steve


>  		/*							\
>  		 * For rcuidle callers, use srcu since sched-rcu	\
> @@ -241,7 +247,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
>  		}							\
>  									\
> -		preempt_enable_notrace();				\
> +		if (syscall)						\
> +			rcu_read_unlock_trace();			\
> +		else							\
> +			preempt_enable_notrace();			\
>  	} while (0)
>  
>  #ifndef MODULE
> @@ -251,7 +260,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (static_key_false(&__tracepoint_##name.key))		\
>  			__DO_TRACE(name,				\
>  				TP_ARGS(args),				\
> -				TP_CONDITION(cond), 1);			\
> +				TP_CONDITION(cond), 1, 0);		\
>  	}
>  #else
>  #define __DECLARE_TRACE_RCU(name, proto, args, cond)
> @@ -284,7 +293,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (static_key_false(&__tracepoint_##name.key))		\
>  			__DO_TRACE(name,				\
>  				TP_ARGS(args),				\
> -				TP_CONDITION(cond), 0);			\
> +				TP_CONDITION(cond), 0, 0);		\
>  		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
>  			WARN_ONCE(!rcu_is_watching(),			\
>  				  "RCU not watching for tracepoint");	\
> @@ -295,7 +304,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (static_key_false(&__tracepoint_##name.key))		\
>  			__DO_TRACE(name,				\
>  				TP_ARGS(args),				\
> -				TP_CONDITION(cond), 1);			\
> +				TP_CONDITION(cond), 1, 0);		\
>  	}								\
>  	static inline int						\
>  	register_trace_##name(void (*probe)(data_proto), void *data)	\
> @@ -330,7 +339,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (static_key_false(&__tracepoint_##name.key))		\
>  			__DO_TRACE(name,				\
>  				TP_ARGS(args),				\
> -				TP_CONDITION(cond), 0);			\
> +				TP_CONDITION(cond), 0, 1);		\
>  		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
>  			WARN_ONCE(!rcu_is_watching(),			\
>  				  "RCU not watching for tracepoint");	\
> diff --git a/init/Kconfig b/init/Kconfig
> index fbd0cb06a50a..eedd0064fb36 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1984,6 +1984,7 @@ config BINDGEN_VERSION_TEXT
>  #
>  config TRACEPOINTS
>  	bool
> +	select TASKS_TRACE_RCU
>  
>  source "kernel/Kconfig.kexec"
>  


