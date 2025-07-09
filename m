Return-Path: <bpf+bounces-62724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279EAAFDC02
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 02:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8211C24BFE
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45015479B;
	Wed,  9 Jul 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjQMEAoU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A7A935;
	Wed,  9 Jul 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019214; cv=none; b=L0KrnreMQkiOtsrBRtG8kOScUMoSG8rs5hdvWq5K5o0ovJDVtXJm/8tAzBOVuSScVFyhEObDYcgwx4Hc1UV1hqP48uPxwu9gp+tQKOX4coQrCNy+Qv1JRMbQe1v1otrI0GhyqWlE3VFH2FUlthFne74/H8+R0PRP5sGSGqjQc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019214; c=relaxed/simple;
	bh=Xy5KeN75QHkTJnYMZ5EZGWzwYX/bPTaVG0HvZyXkrOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3ao4EYeBg00/Oyy/ePOZ65Hgeb+xRhtApXmArReJEWQ27jJGNGpksBG3ZZjSeFcaJHZBm0HBnz8IAmmuU6cBxIuJf8eI+BHflQeVgii+0UChUDRdLYczi+IMBFh1vpC3mQ2yXzm2CyntaIdwIz1u9mxXFgBEdoEsSiXLdKKLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjQMEAoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0E3C4CEED;
	Wed,  9 Jul 2025 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752019213;
	bh=Xy5KeN75QHkTJnYMZ5EZGWzwYX/bPTaVG0HvZyXkrOU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AjQMEAoUmEMA23Th0ARij+U9s42LFbjk+/rd+cz8+/hG0Eb/k+U4+q69N33gV1JHa
	 eB1OAOi4tXAjxhqgQuLzXr7tYv4R9s5fe5ZagQe7FuRBix6tSshbxP2rDcxB3FHyZO
	 ptyIiAAbE2UH/qb04BekBQe7sZIhSLqqhYpgtzaTR6mkCC+CPaT3ui2K+XihOztRGc
	 FVyT+t/yAC7NVtVg+dkN10esH3ZoJRA6+kGxUdP22hsgA+1GzOr1fCO5rLJYMrLjU0
	 mt6DiokZNMy6El+ZRtC61PLJ1psZfFT85xl4XCis5fsuoZg8uuZw8jNT9W4hMO0fDr
	 8d60jbPFHLQ2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 54593CE08A1; Tue,  8 Jul 2025 17:00:13 -0700 (PDT)
Date: Tue, 8 Jul 2025 17:00:13 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	Qi Xi <xiqi2@huawei.com>, rcu@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH -rcu -next 2/7] rcu: Fix rcu_read_unlock() deadloop due
 to IRQ work
Message-ID: <4249c87e-7ff4-4c09-b4da-ad64ddd38995@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250708142224.3940851-1-joelagnelf@nvidia.com>
 <20250708142224.3940851-2-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708142224.3940851-2-joelagnelf@nvidia.com>

On Tue, Jul 08, 2025 at 10:22:19AM -0400, Joel Fernandes wrote:
> During rcu_read_unlock_special(), if this happens during irq_exit(), we
> can lockup if an IPI is issued. This is because the IPI itself triggers
> the irq_exit() path causing a recursive lock up.
> 
> This is precisely what Xiongfeng found when invoking a BPF program on
> the trace_tick_stop() tracepoint As shown in the trace below. Fix by
> managing the irq_work state correctly.
> 
> irq_exit()
>   __irq_exit_rcu()
>     /* in_hardirq() returns false after this */
>     preempt_count_sub(HARDIRQ_OFFSET)
>     tick_irq_exit()
>       tick_nohz_irq_exit()
> 	    tick_nohz_stop_sched_tick()
> 	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
> 		   __bpf_trace_tick_stop()
> 		      bpf_trace_run2()
> 			    rcu_read_unlock_special()
>                               /* will send a IPI to itself */
> 			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> 
> A simple reproducer can also be obtained by doing the following in
> tick_irq_exit(). It will hang on boot without the patch:
> 
>   static inline void tick_irq_exit(void)
>   {
>  +	rcu_read_lock();
>  +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
>  +	rcu_read_unlock();
>  +
> 
> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
> Tested-by: Qi Xi <xiqi2@huawei.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.h        | 11 ++++++++++-
>  kernel/rcu/tree_plugin.h | 23 +++++++++++++++++++----
>  2 files changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 3830c19cf2f6..f8f612269e6e 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -174,6 +174,15 @@ struct rcu_snap_record {
>  	unsigned long   jiffies;	/* Track jiffies value */
>  };
>  
> +/*
> + * The IRQ work (deferred_qs_iw) is used by RCU to get scheduler's attention.
> + * It can be in one of the following states:
> + * - DEFER_QS_IDLE: An IRQ work was never scheduled.
> + * - DEFER_QS_PENDING: An IRQ work was scheduler but never run.
> + */
> +#define DEFER_QS_IDLE		0
> +#define DEFER_QS_PENDING	1
> +
>  /* Per-CPU data for read-copy update. */
>  struct rcu_data {
>  	/* 1) quiescent-state and grace-period handling : */
> @@ -192,7 +201,7 @@ struct rcu_data {
>  					/*  during and after the last grace */
>  					/* period it is aware of. */
>  	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
> -	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
> +	int defer_qs_iw_pending;	/* Scheduler attention pending? */
>  	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
>  
>  	/* 2) batch handling */
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index dd1c156c1759..fa7b0d854833 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -486,13 +486,16 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  	struct rcu_node *rnp;
>  	union rcu_special special;
>  
> +	rdp = this_cpu_ptr(&rcu_data);
> +	if (rdp->defer_qs_iw_pending == DEFER_QS_PENDING)
> +		rdp->defer_qs_iw_pending = DEFER_QS_IDLE;
> +
>  	/*
>  	 * If RCU core is waiting for this CPU to exit its critical section,
>  	 * report the fact that it has exited.  Because irqs are disabled,
>  	 * t->rcu_read_unlock_special cannot change.
>  	 */
>  	special = t->rcu_read_unlock_special;
> -	rdp = this_cpu_ptr(&rcu_data);
>  	if (!special.s && !rdp->cpu_no_qs.b.exp) {
>  		local_irq_restore(flags);
>  		return;
> @@ -628,7 +631,18 @@ static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
>  
>  	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
>  	local_irq_save(flags);
> -	rdp->defer_qs_iw_pending = false;
> +
> +	/*
> +	 * Requeue the IRQ work on next unlock in following situation:
> +	 * 1. rcu_read_unlock() queues IRQ work (state -> DEFER_QS_PENDING)
> +	 * 2. CPU enters new rcu_read_lock()
> +	 * 3. IRQ work runs but cannot report QS due to rcu_preempt_depth() > 0
> +	 * 4. rcu_read_unlock() does not re-queue work (state still PENDING)
> +	 * 5. Deferred QS reporting does not happen.
> +	 */
> +	if (rcu_preempt_depth() > 0)
> +		WRITE_ONCE(rdp->defer_qs_iw_pending, DEFER_QS_IDLE);
> +
>  	local_irq_restore(flags);
>  }
>  
> @@ -675,7 +689,8 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> +			    expboost && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
> +			    cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
>  				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> @@ -685,7 +700,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  				else
>  					init_irq_work(&rdp->defer_qs_iw,
>  						      rcu_preempt_deferred_qs_handler);
> -				rdp->defer_qs_iw_pending = true;
> +				rdp->defer_qs_iw_pending = DEFER_QS_PENDING;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
>  		}
> -- 
> 2.34.1
> 

