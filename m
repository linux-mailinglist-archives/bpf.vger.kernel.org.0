Return-Path: <bpf+bounces-60151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A50AD3615
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 14:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CF47A3D59
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39B290DB6;
	Tue, 10 Jun 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4augsdW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB4428EA45;
	Tue, 10 Jun 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558207; cv=none; b=tqjgcKJgXMbVBjEfH/lyXvDoUJkXcjYoAZjWo5egV/8X8uAU0nGuZsQqbquR9LyBCBPzfrATdoMD0BIgB8g3CWT9Kn92ZHQHOP8H8sBj7MriKG8VXv3dS5PDPxNuSS7lgcomz+Mi9uVrrZYKMtFbbAvLAu7mBh5vhKfNHTPc7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558207; c=relaxed/simple;
	bh=oc//4EYy1ffqYnSH/0jpWmK1cIoIKuNwXMQerwUzNjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2U/vlCYcyWkqbSSgGNC3C/BT+XZOD0QYQNMLAhnEHmfuQyY4t+ZQqCJXsvHxu7lzpS9KxoMnf3JCl7OVy5m2eUr9hTyiLwSu25jA+12fL7YAEZI6PepUbIUEZhk9w56dkPE3gdJ2dly4zKIxW2EnkMEG0Z20x/NpbUtgbEa6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4augsdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A8FC4CEF1;
	Tue, 10 Jun 2025 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749558207;
	bh=oc//4EYy1ffqYnSH/0jpWmK1cIoIKuNwXMQerwUzNjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4augsdWAzQGzGe5ecGB3QeaSvaCP6tGpt8U/v5vLjwmzThp1+OGVjnRBmvsmSqEN
	 d/LIbVnFCnuxy1hOopR79rvNVEiuQBFviXZLAhz6h5sVbDgmbsdBqdAJdXsJDB6C0r
	 VySvsGyhnwGnP06404JRXfQG9k4yhiarAhVmDx/Rurn9fEGII66kXUemxxolChqlpm
	 W7eSN5OHY4V0k/nBXLKmwqWyl2nXdDY997AnO5yYl60LwLNhUflwOBVZlxU9/N9nY8
	 6VDf96/oZufcNXUfsKXPWbeBZOS+zYSzSBYUhiqHCWiLCE91LIQbAxnImUDBuywjPN
	 v9rbVfGygNUlQ==
Date: Tue, 10 Jun 2025 14:23:24 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, rcu@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu: Fix lockup when RCU reader used while IRQ
 exiting
Message-ID: <aEgjvGkYB0RoQFvg@localhost.localdomain>
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
 <20250609180125.2988129-2-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609180125.2988129-2-joelagnelf@nvidia.com>

Le Mon, Jun 09, 2025 at 02:01:24PM -0400, Joel Fernandes a écrit :
> During rcu_read_unlock_special(), if this happens during irq_exit(), we
> can lockup if an IPI is issued. This is because the IPI itself triggers
> the irq_exit() path causing a recursive lock up.
> 
> This is precisely what Xiongfeng found when invoking a BPF program on
> the trace_tick_stop() tracepoint As shown in the trace below. Fix by
> using context-tracking to tell us if we're still in an IRQ.
> context-tracking keeps track of the IRQ until after the tracepoint, so
> it cures the issues.
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
> While at it, add some comments to this code.
> 
> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Just a few remarks:

> ---
>  kernel/rcu/tree_plugin.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3c0bbbbb686f..53d8b3415776 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -653,6 +653,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  		struct rcu_node *rnp = rdp->mynode;
>  
> +		// In cases where the RCU-reader is boosted, we'd attempt deboost sooner than
> +		// later to prevent inducing latency to other RT tasks. Also, expedited GPs
> +		// should not be delayed too much. Track both these needs in expboost.
>  		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
>  			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
>  			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> @@ -670,10 +673,15 @@ static void rcu_read_unlock_special(struct task_struct *t)
>  			// Also if no expediting and no possible deboosting,
>  			// slow is OK.  Plus nohz_full CPUs eventually get
>  			// tick enabled.
> +			//
> +			// Also prevent doing this if context-tracking thinks
> +			// we're handling an IRQ (including when we're exiting
> +			// one -- required to prevent self-IPI deadloops).
>  			set_tsk_need_resched(current);
>  			set_preempt_need_resched();
>  			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
> -			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
> +			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu) &&
> +			    !ct_in_irq()) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
>  				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
> --

Looking at the irq work handling here:

* What is the point of ->defer_qs_iw_pending ? If the irq work is already
  queued, it won't be requeued because the irq work code already prevent from
  that.

* CONFIG_PREEMPT_RT && !CONFIG_RCU_STRICT_GRACE_PERIOD would queue a lazy irq
  work but still raise a hardirq to wake up softirq to handle it. It's pointless
  because there is nothing to execute in softirq, all we care about is the
  hardirq.
  Also since the work is empty it might as well be executed in hard irq, that
  shouldn't induce more latency in RT.

* Empty hard irq work raised to trigger something on irq exit also exist
  elsewhere (see nohz_full_kick_func()). Would it make sense to have that
  implemented in irq_work.c instead and trigger that through a simple
  irq_work_kick()?

And then this would look like (only built-tested):

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 136f2980cba3..4149ed516524 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -57,6 +57,9 @@ static inline bool irq_work_is_hard(struct irq_work *work)
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
 
+bool irq_work_kick(void);
+bool irq_work_kick_on(int cpu);
+
 void irq_work_tick(void);
 void irq_work_sync(struct irq_work *work);
 
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 73f7e1fd4ab4..383a3e9050d9 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -181,6 +181,22 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 #endif /* CONFIG_SMP */
 }
 
+static void kick_func(struct irq_work *work)
+{
+}
+
+static DEFINE_PER_CPU(struct irq_work, kick_work) = IRQ_WORK_INIT_HARD(kick_func);
+
+bool irq_work_kick(void)
+{
+	return irq_work_queue(this_cpu_ptr(&kick_work));
+}
+
+bool irq_work_kick_on(int cpu)
+{
+	return irq_work_queue_on(per_cpu_ptr(&kick_work, cpu), cpu);
+}
+
 bool irq_work_needs_cpu(void)
 {
 	struct llist_head *raised, *lazy;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a9a811d9d7a3..b33888071e41 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -191,7 +191,6 @@ struct rcu_data {
 					/*  during and after the last grace */
 					/* period it is aware of. */
 	struct irq_work defer_qs_iw;	/* Obtain later scheduler attention. */
-	bool defer_qs_iw_pending;	/* Scheduler attention pending? */
 	struct work_struct strict_work;	/* Schedule readers for strict GPs. */
 
 	/* 2) batch handling */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3c0bbbbb686f..0c7b7c220b46 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -619,17 +619,6 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
-/*
- * Minimal handler to give the scheduler a chance to re-evaluate.
- */
-static void rcu_preempt_deferred_qs_handler(struct irq_work *iwp)
-{
-	struct rcu_data *rdp;
-
-	rdp = container_of(iwp, struct rcu_data, defer_qs_iw);
-	rdp->defer_qs_iw_pending = false;
-}
-
 /*
  * Handle special cases during rcu_read_unlock(), such as needing to
  * notify RCU core processing or task having blocked during the RCU
@@ -673,18 +662,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
+			    expboost && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
-				    IS_ENABLED(CONFIG_PREEMPT_RT))
-					rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(
-								rcu_preempt_deferred_qs_handler);
-				else
-					init_irq_work(&rdp->defer_qs_iw,
-						      rcu_preempt_deferred_qs_handler);
-				rdp->defer_qs_iw_pending = true;
-				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
+				irq_work_kick();
 			}
 		}
 		local_irq_restore(flags);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c527b421c865..84170656334d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -377,14 +377,6 @@ static bool can_stop_full_tick(int cpu, struct tick_sched *ts)
 	return true;
 }
 
-static void nohz_full_kick_func(struct irq_work *work)
-{
-	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
-}
-
-static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
-	IRQ_WORK_INIT_HARD(nohz_full_kick_func);
-
 /*
  * Kick this CPU if it's full dynticks in order to force it to
  * re-evaluate its dependency on the tick and restart it if necessary.
@@ -396,7 +388,7 @@ static void tick_nohz_full_kick(void)
 	if (!tick_nohz_full_cpu(smp_processor_id()))
 		return;
 
-	irq_work_queue(this_cpu_ptr(&nohz_full_kick_work));
+	irq_work_kick();
 }
 
 /*
@@ -408,7 +400,7 @@ void tick_nohz_full_kick_cpu(int cpu)
 	if (!tick_nohz_full_cpu(cpu))
 		return;
 
-	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
+	irq_work_kick_on(cpu);
 }
 
 static void tick_nohz_kick_task(struct task_struct *tsk)

  
  
-- 
Frederic Weisbecker
SUSE Labs

