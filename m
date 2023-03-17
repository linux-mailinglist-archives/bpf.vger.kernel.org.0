Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081BB6BF449
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCQVgW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCQVgL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945C14AD34;
        Fri, 17 Mar 2023 14:35:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so10569536pjt.2;
        Fri, 17 Mar 2023 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWw2v1UnTVnbdS72T7wGx5fNyybAmUxe9bUw37LCRvo=;
        b=Agw5iz0eFlCMtSGY5mRtsHN6rrRxdhNbZnER8AKAoat/O5xaHjX7SL3c7GZ3qItUsL
         hKON97uP+aKGWt92sQDNkmCOwFR8wv2wZhO0Ktu3Sh4A8hHGoJlxnGYWXYZ56LTFmfiA
         LYq1c1+/Qous0sUaovLvwojE/SPl1jgbceikPlt1UYOawglhpTlW4SBNL0Ar7TfIIEI4
         Qj0WmyY9QbrBY/dTd1N7FtbcrYl9hG4BM8FQJ32sEhqzqwAfRDS88DZke5fqsLtmqaAV
         5TNVeHqUlE8j29hQaGSMr8xR4zkIEN2/t0RDYS9sHR8Wc0LWq6cWKdDY+1RFdJqyk83+
         IODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWw2v1UnTVnbdS72T7wGx5fNyybAmUxe9bUw37LCRvo=;
        b=fvoJTAs1grpzOVprgPTyizQGWP8SQZxcxfJHsbyAMGhQ8Pbrc7rrR8jV1Q3Kkqxg7q
         TVbwMpyViGlWtCNvDT4JnV+v/rsoCWWUMaS5N6ye+Bdb/iRyXlmwzfod3a4ug2y+Ro0g
         vNFGYSHA+LJwXzXhABMWtIT8dLToXE71UnX57Vg3cMwx/dJRIMLDs1ASUB+1S9roIEvw
         IaSwT/SzBBof7t8xZ/uTxNdVQTO/H6nNfJfrsa6lGhmw04feFXYUJT/PjqJ/DSD6kCkY
         4CHQpb/Vn6jTZk6NA7FUaV0iIt/I7gi9z6170VJE3UR59BzTFZGjXu6qTrN2aZqV0sNv
         iECA==
X-Gm-Message-State: AO0yUKV+BZcFl/cnkwNypEDvIgKXeYT5t4p4FvEGgi4yf4MWfGoA6ykV
        9qh4Ghry2uIbjZb3IC+0mf8=
X-Google-Smtp-Source: AK7set94O+oaHyjhIU7+YxEozCc8PCEm3AqV/gZy35nCSnqfd8vw+u819uDUEAXPXUcSEztLpr4W+g==
X-Received: by 2002:a17:90b:4f90:b0:23b:4bf6:bbfa with SMTP id qe16-20020a17090b4f9000b0023b4bf6bbfamr10391873pjb.11.1679088841085;
        Fri, 17 Mar 2023 14:34:01 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090a15d700b00233b5d6b4b5sm5326472pjd.16.2023.03.17.14.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:00 -0700 (PDT)
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
Subject: [PATCH 10/32] sched: Add @reason to sched_class->rq_{on|off}line()
Date:   Fri, 17 Mar 2023 11:33:11 -1000
Message-Id: <20230317213333.2174969-11-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index 59136fafa94c..aa63371aa84c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9428,7 +9428,7 @@ static inline void balance_hotplug_wait(void)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-void set_rq_online(struct rq *rq)
+void set_rq_online(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (!rq->online) {
 		const struct sched_class *class;
@@ -9438,19 +9438,19 @@ void set_rq_online(struct rq *rq)
 
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
@@ -9546,7 +9546,7 @@ int sched_cpu_activate(unsigned int cpu)
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_online(rq);
+		set_rq_online(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
@@ -9591,7 +9591,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	if (rq->rd) {
 		update_rq_clock(rq);
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
+		set_rq_offline(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 71b24371a6f7..a7bb573c4c82 100644
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
index 681ab0dd0bc1..28204472a3f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11805,14 +11805,14 @@ void trigger_load_balance(struct rq *rq)
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
index 0a11f44adee5..2b4c769438a1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2473,7 +2473,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 }
 
 /* Assumes rq->lock is held */
-static void rq_online_rt(struct rq *rq)
+static void rq_online_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_set_overload(rq);
@@ -2484,7 +2484,7 @@ static void rq_online_rt(struct rq *rq)
 }
 
 /* Assumes rq->lock is held */
-static void rq_offline_rt(struct rq *rq)
+static void rq_offline_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_clear_overload(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 67f7f1149630..958613dd8290 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2183,6 +2183,11 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+enum rq_onoff_reason {
+	RQ_ONOFF_HOTPLUG,		/* CPU is going on/offline */
+	RQ_ONOFF_TOPOLOGY,		/* sched domain topology update */
+};
+
 struct affinity_context {
 	const struct cpumask *new_mask;
 	struct cpumask *user_mask;
@@ -2219,8 +2224,8 @@ struct sched_class {
 
 	void (*set_cpus_allowed)(struct task_struct *p, struct affinity_context *ctx);
 
-	void (*rq_online)(struct rq *rq);
-	void (*rq_offline)(struct rq *rq);
+	void (*rq_online)(struct rq *rq, enum rq_onoff_reason reason);
+	void (*rq_offline)(struct rq *rq, enum rq_onoff_reason reason);
 
 	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
 #endif
@@ -2787,8 +2792,8 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	raw_spin_rq_unlock(rq1);
 }
 
-extern void set_rq_online (struct rq *rq);
-extern void set_rq_offline(struct rq *rq);
+extern void set_rq_online (struct rq *rq, enum rq_onoff_reason reason);
+extern void set_rq_offline(struct rq *rq, enum rq_onoff_reason reason);
 extern bool sched_smp_initialized;
 
 #else /* CONFIG_SMP */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 051aaf65c749..155c4e7e0f08 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -495,7 +495,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 		old_rd = rq->rd;
 
 		if (cpumask_test_cpu(rq->cpu, old_rd->online))
-			set_rq_offline(rq);
+			set_rq_offline(rq, RQ_ONOFF_TOPOLOGY);
 
 		cpumask_clear_cpu(rq->cpu, old_rd->span);
 
@@ -513,7 +513,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 
 	cpumask_set_cpu(rq->cpu, rd->span);
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
-		set_rq_online(rq);
+		set_rq_online(rq, RQ_ONOFF_TOPOLOGY);
 
 	raw_spin_rq_unlock_irqrestore(rq, flags);
 
-- 
2.39.2

