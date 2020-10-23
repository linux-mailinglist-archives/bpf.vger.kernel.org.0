Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5D72978B4
	for <lists+bpf@lfdr.de>; Fri, 23 Oct 2020 23:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755379AbgJWVOD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Oct 2020 17:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbgJWVOC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Oct 2020 17:14:02 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81463C0613CE
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 14:14:02 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id w5so1491054qvn.12
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2020 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ys6/dFrrFsL4y4l24br+6PAG0LG5Fz1UTTpuLLI1IQI=;
        b=UnYwEt3/jcBFWx32q0vM2GdSbPWRUqKH40bFKLaNXWYy5Bgv4z7oNlHXg+IPp3/tCO
         g9wW27o9LQEvQEeyv+Iz+OSlvtKABvTwX+y6G96hrZLeVin4qe3uGaaxfa5W3LcW0N7Z
         l4qH63fuFxIUIoKGLPts8TZiMOGLF0zzBhLpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ys6/dFrrFsL4y4l24br+6PAG0LG5Fz1UTTpuLLI1IQI=;
        b=lGlAFLkd/nKnIiw4vztuGFwRvkVyhqgZYF2G07DeVHv/W3q6L8ma4hTGjSzQpkyc8N
         N/Xte4QtS08q3XGXdGO2/cIE+mMe35SCt/wpsMJT6eFBFuzFnZBRifPZr6RRd1V8G2q9
         V+qPIBMNCkTUGTqHZjm3FCuw9vLdgvlvLGM7Pj4jwpKaZ9bl5Cd68BuiI5qXxh3fULBP
         joNKW7CL9eH4RJx8ErfuDEqKArTA+dSvpKn9PCChqv31El/yPZEdd9ch++i+blR71z0P
         mMfn1yORwjWO1kskJszDtPq5P/8kcHv30rXkfBja3tTCK2QCriYGNr6ma5xuk5e0ZK0E
         +KQQ==
X-Gm-Message-State: AOAM532Hu4Hz2VRn3XJyLvW51Tncza9DNyMuTiM3blhHyTz97sWhuLeD
        Wdg6cEklTprzKYARdAxB705cZw==
X-Google-Smtp-Source: ABdhPJxiksRYZtfifj3tQW8PBUDe5uHDGKXZzd8w6St1uHL5kKb7yJTd+9nNcXWUMd9rstul2fxoKQ==
X-Received: by 2002:a0c:f706:: with SMTP id w6mr1151288qvn.48.1603487640781;
        Fri, 23 Oct 2020 14:14:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x91sm1743727qte.69.2020.10.23.14.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 14:14:00 -0700 (PDT)
Date:   Fri, 23 Oct 2020 17:13:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michael Jeanson <mjeanson@efficios.com>
Cc:     linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] tracing: use sched-RCU instead of SRCU for
 rcuidle tracepoints
Message-ID: <20201023211359.GC3563800@google.com>
References: <20201023195352.26269-1-mjeanson@efficios.com>
 <20201023195352.26269-7-mjeanson@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023195352.26269-7-mjeanson@efficios.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 23, 2020 at 03:53:52PM -0400, Michael Jeanson wrote:
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Considering that tracer callbacks expect RCU to be watching (for
> instance, perf uses rcu_read_lock), we need rcuidle tracepoints to issue
> rcu_irq_{enter,exit}_irqson around calls to the callbacks. So there is
> no point in using SRCU anymore given that rcuidle tracepoints need to
> ensure RCU is watching. Therefore, simply use sched-RCU like normal
> tracepoints for rcuidle tracepoints.

High level question:

IIRC, doing this increases overhead for general tracing that does not use
perf, for 'rcuidle' tracepoints such as the preempt/irq enable/disable
tracepoints. I remember adding SRCU because of this reason.

Can the 'rcuidle' information not be pushed down further, such that perf does
it because it requires RCU to be watching, so that it does not effect, say,
trace events?

thanks,

 - Joel

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Michael Jeanson <mjeanson@efficios.com>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: bpf@vger.kernel.org
> ---
>  include/linux/tracepoint.h | 33 +++++++--------------------------
>  kernel/tracepoint.c        | 25 +++++++++----------------
>  2 files changed, 16 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 0386b54cbcbb..1414b11f864b 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -13,7 +13,6 @@
>   */
>  
>  #include <linux/smp.h>
> -#include <linux/srcu.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> @@ -33,8 +32,6 @@ struct trace_eval_map {
>  
>  #define TRACEPOINT_DEFAULT_PRIO	10
>  
> -extern struct srcu_struct tracepoint_srcu;
> -
>  extern int
>  tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
>  extern int
> @@ -86,7 +83,6 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
>  static inline void tracepoint_synchronize_unregister(void)
>  {
>  	synchronize_rcu_tasks_trace();
> -	synchronize_srcu(&tracepoint_srcu);
>  	synchronize_rcu();
>  }
>  #else
> @@ -175,25 +171,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		if (!(cond))						\
>  			return;						\
>  									\
> -		/* srcu can't be used from NMI */			\
> -		WARN_ON_ONCE(rcuidle && in_nmi());			\
> -									\
> -		if (maysleep) {						\
> -			might_sleep();					\
> +		might_sleep_if(maysleep);				\
> +		if (rcuidle)						\
> +			rcu_irq_enter_irqson();				\
> +		if (maysleep)						\
>  			rcu_read_lock_trace();				\
> -		} else {						\
> -			/* keep srcu and sched-rcu usage consistent */	\
> +		else							\
>  			preempt_disable_notrace();			\
> -		}							\
> -									\
> -		/*							\
> -		 * For rcuidle callers, use srcu since sched-rcu	\
> -		 * doesn't work from the idle path.			\
> -		 */							\
> -		if (rcuidle) {						\
> -			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> -			rcu_irq_enter_irqson();				\
> -		}							\
>  									\
>  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
>  									\
> @@ -205,15 +189,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
>  									\
> -		if (rcuidle) {						\
> -			rcu_irq_exit_irqson();				\
> -			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> -		}							\
> -									\
>  		if (maysleep)						\
>  			rcu_read_unlock_trace();			\
>  		else							\
>  			preempt_enable_notrace();			\
> +		if (rcuidle)						\
> +			rcu_irq_exit_irqson();				\
>  	} while (0)
>  
>  #ifndef MODULE
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 8d8e41c5d8a5..68b4e50798b1 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -18,9 +18,6 @@
>  extern tracepoint_ptr_t __start___tracepoints_ptrs[];
>  extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
>  
> -DEFINE_SRCU(tracepoint_srcu);
> -EXPORT_SYMBOL_GPL(tracepoint_srcu);
> -
>  /* Set to 1 to enable tracepoint debug output */
>  static const int tracepoint_debug;
>  
> @@ -65,14 +62,9 @@ static void rcu_tasks_trace_free_old_probes(struct rcu_head *head)
>  	kfree(container_of(head, struct tp_probes, rcu));
>  }
>  
> -static void srcu_free_old_probes(struct rcu_head *head)
> -{
> -	call_rcu_tasks_trace(head, rcu_tasks_trace_free_old_probes);
> -}
> -
>  static void rcu_free_old_probes(struct rcu_head *head)
>  {
> -	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> +	call_rcu_tasks_trace(head, rcu_tasks_trace_free_old_probes);
>  }
>  
>  static __init int release_early_probes(void)
> @@ -90,7 +82,7 @@ static __init int release_early_probes(void)
>  	return 0;
>  }
>  
> -/* SRCU and Tasks Trace RCU are initialized at core_initcall */
> +/* Tasks Trace RCU is initialized at core_initcall */
>  postcore_initcall(release_early_probes);
>  
>  static inline void release_probes(struct tracepoint_func *old)
> @@ -100,9 +92,8 @@ static inline void release_probes(struct tracepoint_func *old)
>  			struct tp_probes, probes[0]);
>  
>  		/*
> -		 * We can't free probes if SRCU and Tasks Trace RCU are not
> -		 * initialized yet. Postpone the freeing till after both are
> -		 * initialized.
> +		 * We can't free probes if Tasks Trace RCU is not initialized yet.
> +		 * Postpone the freeing till after Tasks Trace RCU is initialized.
>  		 */
>  		if (unlikely(!ok_to_free_tracepoints)) {
>  			tp_probes->rcu.next = early_probes;
> @@ -111,9 +102,11 @@ static inline void release_probes(struct tracepoint_func *old)
>  		}
>  
>  		/*
> -		 * Tracepoint probes are protected by sched RCU, SRCU and
> -		 * Tasks Trace RCU by chaining the callbacks we cover all three
> -		 * cases and wait for all three grace periods.
> +		 * Tracepoint probes are protected by both sched RCU and
> +		 * Tasks Trace RCU, by calling the Tasks Trace RCU callback in
> +		 * the sched RCU callback we cover both cases. So let us chain
> +		 * the Tasks Trace RCU and sched RCU callbacks to wait for both
> +		 * grace periods.
>  		 */
>  		call_rcu(&tp_probes->rcu, rcu_free_old_probes);
>  	}
> -- 
> 2.25.1
> 
