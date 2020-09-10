Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F41265146
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 22:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgIJUue (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 16:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgIJUUz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 16:20:55 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39D2221E2;
        Thu, 10 Sep 2020 20:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599769255;
        bh=SfAmhvlfMQYT+jzOFWGoEAQ9AA14MQ9NYDdfLyXdGdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dgAf6k13tA2TgklDD0y3Tcg+HxUT81BD3jOCafAWbbCTboWDIH1o5agVzwuFpqwUa
         uuJCx26loMLLjm5578Cl4/TV/HJVeddio08DZSLEwepjHv1SBgsZCwA0p0z+Z/tHYF
         pl1nb0/NZq8Ef204JxWMZfxuXZz7pLbhHrvsFEEA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        jolsa@redhat.com, bpf@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 2/4] rcu-tasks: Use more aggressive polling for RCU Tasks Trace
Date:   Thu, 10 Sep 2020 13:20:50 -0700
Message-Id: <20200910202052.5073-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200910201956.GA24190@paulmck-ThinkPad-P72>
References: <20200910201956.GA24190@paulmck-ThinkPad-P72>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The RCU Tasks Trace grace periods are too slow, as in 40x slower than
those of RCU Tasks.  This is due to my having assumed a one-second grace
period was OK, and thus not having optimized any further.  This commit
provides the first step in this optimization process, namely by allowing
the task_list scan backoff interval to be specified on a per-flavor basis,
and then speeding up the scans for RCU Tasks Trace.  However, kernels
built with CONFIG_TASKS_TRACE_RCU_READ_MB=y continue to use the old slower
backoff, consistent with that Kconfig option's goal of reducing IPIs.

Link: https://lore.kernel.org/bpf/CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com/
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 978508e..ad8c4f3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -28,6 +28,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
  * @gp_state: Grace period's most recent state transition (debugging).
+ * @init_fract: Initial backoff sleep interval.
  * @gp_jiffies: Time of last @gp_state transition.
  * @gp_start: Most recent grace-period start in jiffies.
  * @n_gps: Number of grace periods completed since boot.
@@ -48,6 +49,7 @@ struct rcu_tasks {
 	struct wait_queue_head cbs_wq;
 	raw_spinlock_t cbs_lock;
 	int gp_state;
+	int init_fract;
 	unsigned long gp_jiffies;
 	unsigned long gp_start;
 	unsigned long n_gps;
@@ -329,8 +331,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
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
@@ -553,6 +557,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
 static int __init rcu_spawn_tasks_kthread(void)
 {
+	rcu_tasks.init_fract = 10;
 	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
 	rcu_tasks.pertask_func = rcu_tasks_pertask;
 	rcu_tasks.postscan_func = rcu_tasks_postscan;
@@ -1163,6 +1168,13 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
 
 static int __init rcu_spawn_tasks_trace_kthread(void)
 {
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
+		rcu_tasks_trace.init_fract = 10;
+	} else {
+		rcu_tasks_trace.init_fract = HZ / 5;
+		if (rcu_tasks_trace.init_fract <= 0)
+			rcu_tasks_trace.init_fract = 1;
+	}
 	rcu_tasks_trace.pregp_func = rcu_tasks_trace_pregp_step;
 	rcu_tasks_trace.pertask_func = rcu_tasks_trace_pertask;
 	rcu_tasks_trace.postscan_func = rcu_tasks_trace_postscan;
-- 
2.9.5

