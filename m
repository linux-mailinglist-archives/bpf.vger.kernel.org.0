Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD526E71B
	for <lists+bpf@lfdr.de>; Thu, 17 Sep 2020 23:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIQVHt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Sep 2020 17:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbgIQVHs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Sep 2020 17:07:48 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E137A221EC;
        Thu, 17 Sep 2020 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600376868;
        bh=ouGhB+1a+6geKlPYWPlPWaRZ75l/NwH3LH++H6Rzi2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaGePX23YySwwnRttUY3XbOQ5SYNm4v3aayZmCxMJUmNAspRIu9UqUXA1fxRxF9w1
         IUlLwtXfTx/O8iWQzPDorrqDScG+V3k0PPth7S+jxYKaZDBqhNdYPMxoWk6xZVNQKT
         JM5Omj86OIrYr0zCPVNOkpJTW7UeB68D39yjSx68=
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
Subject: [PATCH tip/core/rcu 4/8] rcu-tasks: Selectively enable more RCU Tasks Trace IPIs
Date:   Thu, 17 Sep 2020 14:07:40 -0700
Message-Id: <20200917210744.2995-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200917210652.GA31242@paulmck-ThinkPad-P72>
References: <20200917210652.GA31242@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Many workloads are quite sensitive to IPIs, and such workloads should
build kernels with CONFIG_TASKS_TRACE_RCU_READ_MB=y to prevent RCU
Tasks Trace from using them under normal conditions.  However, other
workloads are quite happy to permit more IPIs if doing so makes BPF
program updates go faster.  This commit therefore sets the default
value for the rcupdate.rcu_task_ipi_delay kernel parameter to zero for
kernels that have been built with CONFIG_TASKS_TRACE_RCU_READ_MB=n,
while retaining the old default of (HZ / 10) for kernels that have
indicated an aversion to IPIs via CONFIG_TASKS_TRACE_RCU_READ_MB=y.

Link: https://lore.kernel.org/bpf/CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com/
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ad8c4f3..2b4df23 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -83,7 +83,7 @@ static struct rcu_tasks rt_name =					\
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
 /* Avoid IPIing CPUs early in the grace period. */
-#define RCU_TASK_IPI_DELAY (HZ / 2)
+#define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
 static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
 module_param(rcu_task_ipi_delay, int, 0644);
 
@@ -916,7 +916,8 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 
 	// If currently running, send an IPI, either way, add to list.
 	trc_add_holdout(t, bhp);
-	if (task_curr(t) && time_after(jiffies, rcu_tasks_trace.gp_start + rcu_task_ipi_delay)) {
+	if (task_curr(t) &&
+	    time_after(jiffies + 1, rcu_tasks_trace.gp_start + rcu_task_ipi_delay)) {
 		// The task is currently running, so try IPIing it.
 		cpu = task_cpu(t);
 
-- 
2.9.5

