Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7334567F2ED
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjA1AR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjA1ARi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:17:38 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750986E8C;
        Fri, 27 Jan 2023 16:17:11 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k13so6628405plg.0;
        Fri, 27 Jan 2023 16:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl4nTEcWT/EGt93/xB46mljQZl+Kfpo6bPKOqUFVnUs=;
        b=Wua+ST9qq6Cqyei+11te6FyZRDXjo5UT/RIR1Rcxx7zCNHjCwC1mZ65ZSRNi+h/zn0
         8aDUYErsynJLoGb26hgy0tMd6+LvXFBe048ECF8/c5DL+JqCYK+eAVvyue83UtzqJ9Tx
         Mk/4UrBWLDYMQZKcIbvFYmg8w17P008cmiaO85YW6yhXnddFpd8EZEdVpJbJHxxRTSaN
         NwdhY4/21e97ysr15kYII9kABWwA9H/u7ly1v+Wt6ga4rx/f2s6CMCO0FEka4KHxWs2V
         PW8X3bfQPLFiigpZe2sCIljxv3PpLlXa1oMklE5i6i1L8vKirIf1yTh0WzFpSmqo+NZ3
         l/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dl4nTEcWT/EGt93/xB46mljQZl+Kfpo6bPKOqUFVnUs=;
        b=dD5asuT881+gv1SU9YkDNODKtNGjQunCrVNjy5H9QaYVjoH+BTHpNdF9SBBTs0FmT9
         O8chIW+11+IjfOgma+lEGMuGxDNT1BmtGR/jqfHtOXtQ/Kxp4VlE4BRXuNEFSI35quou
         a2O/xabudELWv78RZL9QopfvptdMS35RTyEJXmysLF5FgY+O8KVpIwj7+BhhShPqcG+G
         PqqY7nz5SSjusmkSxHICb0+XiKQg5Fp8Qb8IQg+g8qO+yjpi6AiByB4s239WJo5DuQF5
         /bgmtz8EyiDBBqfUXcB84QmwF8AVxtAPbuo1rq7wPRqxNzeZLlTqrGEYY4m3e4t2KjUO
         m6mQ==
X-Gm-Message-State: AO0yUKXXUnnfFauPOqlPA/6CIWZJ9hiNgQ55WpdJACD6EU4gTbIjBPmE
        XsI1MFx7nlPyVSwN2CdookM=
X-Google-Smtp-Source: AK7set9h615/DPijuRyydm9F5Rv37JrFWXN0i7SXx+orPogX0j5VbRdQi01tLv229SG1SJWqzEDZCg==
X-Received: by 2002:a17:902:db04:b0:196:5640:b081 with SMTP id m4-20020a170902db0400b001965640b081mr5283694plx.7.1674865030438;
        Fri, 27 Jan 2023 16:17:10 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b00186acb14c4asm3423593plb.67.2023.01.27.16.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/30] sched: Add @reason to sched_class->rq_{on|off}line()
Date:   Fri, 27 Jan 2023 14:16:19 -1000
Message-Id: <20230128001639.3510083-11-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

->rq_{on|off}line are called either during CPU hotplug or cpuset partition
updates. A planned BPF extensible sched_class wants to tell the BPF
scheduler progs about CPU hotplug events in a way that's synchronized with
rq state changes.

As the BPF scheduler progs aren't necessarily affected by cpuset partition
updates, we need a way to distinguish the two types of events. Let's add an
argument to tell them apart.

v2: Patch description updated to detail the expected use.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c     | 12 ++++++------
 kernel/sched/deadline.c |  4 ++--
 kernel/sched/fair.c     |  4 ++--
 kernel/sched/rt.c       |  4 ++--
 kernel/sched/sched.h    | 13 +++++++++----
 kernel/sched/topology.c |  4 ++--
 6 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 729de63ee6ec..6447f10ecd44 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9355,7 +9355,7 @@ static inline void balance_hotplug_wait(void)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-void set_rq_online(struct rq *rq)
+void set_rq_online(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (!rq->online) {
 		const struct sched_class *class;
@@ -9365,19 +9365,19 @@ void set_rq_online(struct rq *rq)
 
 		for_each_class(class) {
 			if (class->rq_online)
-				class->rq_online(rq);
+				class->rq_online(rq, reason);
 		}
 	}
 }
 
-void set_rq_offline(struct rq *rq)
+void set_rq_offline(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->online) {
 		const struct sched_class *class;
 
 		for_each_class(class) {
 			if (class->rq_offline)
-				class->rq_offline(rq);
+				class->rq_offline(rq, reason);
 		}
 
 		cpumask_clear_cpu(rq->cpu, rq->rd->online);
@@ -9473,7 +9473,7 @@ int sched_cpu_activate(unsigned int cpu)
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_online(rq);
+		set_rq_online(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
@@ -9518,7 +9518,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	if (rq->rd) {
 		update_rq_clock(rq);
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
+		set_rq_offline(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0d97d54276cc..f264814e0513 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2518,7 +2518,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 }
 
 /* Assumes rq->lock is held */
-static void rq_online_dl(struct rq *rq)
+static void rq_online_dl(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->dl.overloaded)
 		dl_set_overload(rq);
@@ -2529,7 +2529,7 @@ static void rq_online_dl(struct rq *rq)
 }
 
 /* Assumes rq->lock is held */
-static void rq_offline_dl(struct rq *rq)
+static void rq_offline_dl(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->dl.overloaded)
 		dl_clear_overload(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fbedf99ed953..b4db8943ed8b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11673,14 +11673,14 @@ void trigger_load_balance(struct rq *rq)
 	nohz_balancer_kick(rq);
 }
 
-static void rq_online_fair(struct rq *rq)
+static void rq_online_fair(struct rq *rq, enum rq_onoff_reason reason)
 {
 	update_sysctl();
 
 	update_runtime_enabled(rq);
 }
 
-static void rq_offline_fair(struct rq *rq)
+static void rq_offline_fair(struct rq *rq, enum rq_onoff_reason reason)
 {
 	update_sysctl();
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..0fb7ee087669 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2470,7 +2470,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 }
 
 /* Assumes rq->lock is held */
-static void rq_online_rt(struct rq *rq)
+static void rq_online_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_set_overload(rq);
@@ -2481,7 +2481,7 @@ static void rq_online_rt(struct rq *rq)
 }
 
 /* Assumes rq->lock is held */
-static void rq_offline_rt(struct rq *rq)
+static void rq_offline_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_clear_overload(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index dd567eb7881a..cc1163b15aa0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2180,6 +2180,11 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+enum rq_onoff_reason {
+	RQ_ONOFF_HOTPLUG,		/* CPU is going on/offline */
+	RQ_ONOFF_TOPOLOGY,		/* sched domain topology update */
+};
+
 struct affinity_context {
 	const struct cpumask *new_mask;
 	struct cpumask *user_mask;
@@ -2216,8 +2221,8 @@ struct sched_class {
 
 	void (*set_cpus_allowed)(struct task_struct *p, struct affinity_context *ctx);
 
-	void (*rq_online)(struct rq *rq);
-	void (*rq_offline)(struct rq *rq);
+	void (*rq_online)(struct rq *rq, enum rq_onoff_reason reason);
+	void (*rq_offline)(struct rq *rq, enum rq_onoff_reason reason);
 
 	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
 #endif
@@ -2782,8 +2787,8 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	raw_spin_rq_unlock(rq1);
 }
 
-extern void set_rq_online (struct rq *rq);
-extern void set_rq_offline(struct rq *rq);
+extern void set_rq_online (struct rq *rq, enum rq_onoff_reason reason);
+extern void set_rq_offline(struct rq *rq, enum rq_onoff_reason reason);
 extern bool sched_smp_initialized;
 
 #else /* CONFIG_SMP */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..0e859bea1cb6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -493,7 +493,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 		old_rd = rq->rd;
 
 		if (cpumask_test_cpu(rq->cpu, old_rd->online))
-			set_rq_offline(rq);
+			set_rq_offline(rq, RQ_ONOFF_TOPOLOGY);
 
 		cpumask_clear_cpu(rq->cpu, old_rd->span);
 
@@ -511,7 +511,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 
 	cpumask_set_cpu(rq->cpu, rd->span);
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
-		set_rq_online(rq);
+		set_rq_online(rq, RQ_ONOFF_TOPOLOGY);
 
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 
-- 
2.39.1

