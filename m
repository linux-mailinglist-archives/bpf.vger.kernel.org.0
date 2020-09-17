Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5302D26E725
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIQVIG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Sep 2020 17:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgIQVHt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Sep 2020 17:07:49 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 308FF23119;
        Thu, 17 Sep 2020 21:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600376868;
        bh=EN8Ux1f40Gwbt7c8BI9OtZebo/fiQdq5Hs8XaO02MuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cjTVrzbiHcMU0NRDwB8lKpc4C1KnlRFzTH0WWPIu8J4X7Dw9TNhSP52oISLdri4bi
         XnUZcCQgsaEigeNhQg18LgFMw93qAcqTgQo8Gc0GJcOB3WaMdK/xlVJUI9DVspib5b
         ynLuxvmhvLtH/Kg/Zdb7IqE4TUMaEEkbEqMjxGcE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        sfr@canb.auug.org.au, "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, bpf@vger.kernel.org
Subject: [PATCH tip/core/rcu 5/8] rcu-tasks: Shorten per-grace-period sleep for RCU Tasks Trace
Date:   Thu, 17 Sep 2020 14:07:41 -0700
Message-Id: <20200917210744.2995-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200917210652.GA31242@paulmck-ThinkPad-P72>
References: <20200917210652.GA31242@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The various RCU tasks flavors currently wait 100 milliseconds between each
grace period in order to prevent CPU-bound loops and to favor efficiency
over latency.  However, RCU Tasks Trace needs to have a grace-period
latency of roughly 25 milliseconds, which is completely infeasible given
the 100-millisecond per-grace-period sleep.  This commit therefore reduces
this sleep duration to 5 milliseconds (or one jiffy, whichever is longer)
in kernels built with CONFIG_TASKS_TRACE_RCU_READ_MB=y.

Link: https://lore.kernel.org/bpf/CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com/
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2b4df23..a0eaed5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -28,6 +28,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
  * @gp_state: Grace period's most recent state transition (debugging).
+ * @gp_sleep: Per-grace-period sleep to prevent CPU-bound looping.
  * @init_fract: Initial backoff sleep interval.
  * @gp_jiffies: Time of last @gp_state transition.
  * @gp_start: Most recent grace-period start in jiffies.
@@ -49,6 +50,7 @@ struct rcu_tasks {
 	struct wait_queue_head cbs_wq;
 	raw_spinlock_t cbs_lock;
 	int gp_state;
+	int gp_sleep;
 	int init_fract;
 	unsigned long gp_jiffies;
 	unsigned long gp_start;
@@ -233,7 +235,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			cond_resched();
 		}
 		/* Paranoid sleep to keep this from entering a tight loop */
-		schedule_timeout_idle(HZ/10);
+		schedule_timeout_idle(rtp->gp_sleep);
 
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 	}
@@ -557,6 +559,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
 static int __init rcu_spawn_tasks_kthread(void)
 {
+	rcu_tasks.gp_sleep = HZ / 10;
 	rcu_tasks.init_fract = 10;
 	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
 	rcu_tasks.pertask_func = rcu_tasks_pertask;
@@ -690,6 +693,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
 
 static int __init rcu_spawn_tasks_rude_kthread(void)
 {
+	rcu_tasks_rude.gp_sleep = HZ / 10;
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
 	return 0;
 }
@@ -1170,8 +1174,12 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
 static int __init rcu_spawn_tasks_trace_kthread(void)
 {
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
+		rcu_tasks_trace.gp_sleep = HZ / 10;
 		rcu_tasks_trace.init_fract = 10;
 	} else {
+		rcu_tasks_trace.gp_sleep = HZ / 200;
+		if (rcu_tasks_trace.gp_sleep <= 0)
+			rcu_tasks_trace.gp_sleep = 1;
 		rcu_tasks_trace.init_fract = HZ / 5;
 		if (rcu_tasks_trace.init_fract <= 0)
 			rcu_tasks_trace.init_fract = 1;
-- 
2.9.5

