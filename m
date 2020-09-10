Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D24263C6D
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 07:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgIJF1h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 01:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgIJF12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 01:27:28 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C4F4207FB;
        Thu, 10 Sep 2020 05:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599715647;
        bh=erFhDMycYCGQ037M8ZtaBkLaYZMbCqZeRBzkCZPDlf0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XvAMzn42Yvzfb3+uD/wbYnbilKf+1w6mdlIsb+an+IdnJhvBeuFzX+8JAoDjIARwm
         Bdk2t7Ryh6RminZlk7kxEXPl+EY5fQBkHRnaB4JKXh9NCLX6keV3tZUkSjBLgP+sEg
         QhLISDZPXSdHOT5l3P8pqjhiEKs8x0YieLzaZoYk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 38D9A3522619; Wed,  9 Sep 2020 22:27:27 -0700 (PDT)
Date:   Wed, 9 Sep 2020 22:27:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: slow sync rcu_tasks_trace
Message-ID: <20200910052727.GA4351@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
 <20200909173512.GI29330@paulmck-ThinkPad-P72>
 <20200909180418.hlivoaekhkchlidw@ast-mbp.dhcp.thefacebook.com>
 <20200909193900.GK29330@paulmck-ThinkPad-P72>
 <20200909194828.urz6islrqajifukj@ast-mbp.dhcp.thefacebook.com>
 <20200909210447.GL29330@paulmck-ThinkPad-P72>
 <20200909212212.GA21795@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909212212.GA21795@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 02:22:12PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 09, 2020 at 02:04:47PM -0700, Paul E. McKenney wrote:
> > On Wed, Sep 09, 2020 at 12:48:28PM -0700, Alexei Starovoitov wrote:
> > > On Wed, Sep 09, 2020 at 12:39:00PM -0700, Paul E. McKenney wrote:

[ . . . ]

> > > > My plan is to try the following:
> > > > 
> > > > 1.	Parameterize the backoff sequence so that RCU Tasks Trace
> > > > 	uses faster rechecking than does RCU Tasks.  Experiment as
> > > > 	needed to arrive at a good backoff value.
> > > > 
> > > > 2.	If the tasks-list scan turns out to be a tighter bottleneck 
> > > > 	than the backoff waits, look into parallelizing this scan.
> > > > 	(This seems unlikely, but the fact remains that RCU Tasks
> > > > 	Trace must do a bit more work per task than RCU Tasks.)
> > > > 
> > > > 3.	If these two approaches, still don't get the update-side
> > > > 	latency where it needs to be, improvise.
> > > > 
> > > > The exact path into mainline will of course depend on how far down this
> > > > list I must go, but first to get a solution.
> > > 
> > > I think there is a case of 4. Nothing is inside rcu_trace critical section.
> > > I would expect single ipi would confirm that.
> > 
> > Unless the task moves, yes.  So a single IPI should suffice in the
> > common case.
> 
> And what I am doing now is checking code paths.

And the following diff from a set of three patches gets my average
RCU Tasks Trace grace-period latencies down to about 20 milliseconds,
almost a 50x improvement from earlier today.

These are still quite rough and not yet suited for production use, but
I will be testing.  If that goes well, I hope to send a more polished
set of patches by end of day tomorrow, Pacific Time.  But if you get a
chance to test them, I would value any feedback that you might have.

These patches do not require hand-tuning, they instead adjust the
behavior according to CONFIG_TASKS_TRACE_RCU_READ_MB, which in turn
adjusts according to CONFIG_PREEMPT_RT.  So you should get the desired
latency reductions "out of the box", again, without tuning.

							Thanx, Paul

-----------------------------------------------------------------------

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 978508e..a0eaed5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -28,6 +28,8 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
  * @gp_state: Grace period's most recent state transition (debugging).
+ * @gp_sleep: Per-grace-period sleep to prevent CPU-bound looping.
+ * @init_fract: Initial backoff sleep interval.
  * @gp_jiffies: Time of last @gp_state transition.
  * @gp_start: Most recent grace-period start in jiffies.
  * @n_gps: Number of grace periods completed since boot.
@@ -48,6 +50,8 @@ struct rcu_tasks {
 	struct wait_queue_head cbs_wq;
 	raw_spinlock_t cbs_lock;
 	int gp_state;
+	int gp_sleep;
+	int init_fract;
 	unsigned long gp_jiffies;
 	unsigned long gp_start;
 	unsigned long n_gps;
@@ -81,7 +85,7 @@ static struct rcu_tasks rt_name =					\
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
 /* Avoid IPIing CPUs early in the grace period. */
-#define RCU_TASK_IPI_DELAY (HZ / 2)
+#define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
 static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
 module_param(rcu_task_ipi_delay, int, 0644);
 
@@ -231,7 +235,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			cond_resched();
 		}
 		/* Paranoid sleep to keep this from entering a tight loop */
-		schedule_timeout_idle(HZ/10);
+		schedule_timeout_idle(rtp->gp_sleep);
 
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 	}
@@ -329,8 +333,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	 */
 	lastreport = jiffies;
 
-	/* Start off with HZ/10 wait and slowly back off to 1 HZ wait. */
-	fract = 10;
+	// Start off with initial wait and slowly back off to 1 HZ wait.
+	fract = rtp->init_fract;
+	if (fract > HZ)
+		fract = HZ;
 
 	for (;;) {
 		bool firstreport;
@@ -553,6 +559,8 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
 static int __init rcu_spawn_tasks_kthread(void)
 {
+	rcu_tasks.gp_sleep = HZ / 10;
+	rcu_tasks.init_fract = 10;
 	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
 	rcu_tasks.pertask_func = rcu_tasks_pertask;
 	rcu_tasks.postscan_func = rcu_tasks_postscan;
@@ -685,6 +693,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
 
 static int __init rcu_spawn_tasks_rude_kthread(void)
 {
+	rcu_tasks_rude.gp_sleep = HZ / 10;
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
 	return 0;
 }
@@ -911,7 +920,8 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 
 	// If currently running, send an IPI, either way, add to list.
 	trc_add_holdout(t, bhp);
-	if (task_curr(t) && time_after(jiffies, rcu_tasks_trace.gp_start + rcu_task_ipi_delay)) {
+	if (task_curr(t) &&
+	    time_after(jiffies + 1, rcu_tasks_trace.gp_start + rcu_task_ipi_delay)) {
 		// The task is currently running, so try IPIing it.
 		cpu = task_cpu(t);
 
@@ -1163,6 +1173,17 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
 
 static int __init rcu_spawn_tasks_trace_kthread(void)
 {
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
+		rcu_tasks_trace.gp_sleep = HZ / 10;
+		rcu_tasks_trace.init_fract = 10;
+	} else {
+		rcu_tasks_trace.gp_sleep = HZ / 200;
+		if (rcu_tasks_trace.gp_sleep <= 0)
+			rcu_tasks_trace.gp_sleep = 1;
+		rcu_tasks_trace.init_fract = HZ / 5;
+		if (rcu_tasks_trace.init_fract <= 0)
+			rcu_tasks_trace.init_fract = 1;
+	}
 	rcu_tasks_trace.pregp_func = rcu_tasks_trace_pregp_step;
 	rcu_tasks_trace.pertask_func = rcu_tasks_trace_pertask;
 	rcu_tasks_trace.postscan_func = rcu_tasks_trace_postscan;
