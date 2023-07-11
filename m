Return-Path: <bpf+bounces-4672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449BC74E32C
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED44728156D
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424541C2D;
	Tue, 11 Jul 2023 01:14:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5B1C01
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:14:46 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E069410F0;
	Mon, 10 Jul 2023 18:14:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso2636417a12.1;
        Mon, 10 Jul 2023 18:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038074; x=1691630074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxTghYXIUVgCfX7zS71KCGFDSOWy9JhF0NIt/sZHyhQ=;
        b=Zp/wYoJO8rZ+ucLU8iNRgYfb/E0Gv98TW4MR1qz37VcwbEpS55o3yjvEhaPQlvplQ4
         h42K8zR1fdl2g0tngrZv9CluzZiJK2VPxNpu9iOQOlpQISzIGpS1XMWV6PsJ4HcWLIPU
         9R+Pk7liWeour2WJYGjZDsQ2Key8sJHyZAw/pdrAXU0Q+PV72SP5gSQ9fhF6I97maV9n
         +I0vN+8aAQQLHhpDHlhUX8ke1BZKUQFSQ3tAoQvlMKNCodNyR62oN/Pa/2QyT2/iS5FV
         6HeTpCp7jM8svbREbK0ZomdBrSkxVbgmp7+dGo9GypqvK6Ffi/ZFlmziNF7ersZT4EC5
         5/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038074; x=1691630074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CxTghYXIUVgCfX7zS71KCGFDSOWy9JhF0NIt/sZHyhQ=;
        b=Tr5e3v4qEmpYFALJeksHPnk+QSX38S3BMMVgl3Y53p1SScU70YLi0u1E/KwLHYX/NM
         K4vcy4oeDdf48OVDZXnZd4AfzyhHxMHwNQ3uD3Y1L0LuBLvR+Pc4BL1+ctTdQU28rHAZ
         RTHv/jK1oqGkfeQyQNHS6c2AWYUm6+ZKNtf1N42Jkl1BLy7JBO3A/sKi+5qTjJLw8WRL
         NB6Et3e5LIxCvAvt3Qet3/uX89HOcyVJtb4ZtvAv2nSzLtKCOk//zUlw7P8W/OTk45GH
         qw/E5m1KUR2lFDwddN3FApxo6mRM/hiBYJ6npP9JpYT5BGpkjdz0rW7xUIwIMihXe/Vr
         +vKA==
X-Gm-Message-State: ABy/qLZ+XQTAPXKKwYXq2Us3hSOTwEmB10mUkByLaxVUhvJ3azlcj7HE
	ponGGypP9N69KqQHzMSKghg=
X-Google-Smtp-Source: APBJJlG/sXTRGNg+87dNQcpRozis5awpwQhE9VJhR3c1riM4DJJJqZjzcdcOrMzGtWpoWuNcSqdU4Q==
X-Received: by 2002:a05:6a21:78a8:b0:12b:93d4:4964 with SMTP id bf40-20020a056a2178a800b0012b93d44964mr14699783pzc.30.1689038074051;
        Mon, 10 Jul 2023 18:14:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id g13-20020a62e30d000000b0064398fe3451sm368116pfh.217.2023.07.10.18.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/34] sched: Add @reason to sched_class->rq_{on|off}line()
Date: Mon, 10 Jul 2023 15:13:27 -1000
Message-ID: <20230711011412.100319-10-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index f7e7a25a0fdf..297740c4a5bc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9547,7 +9547,7 @@ static inline void balance_hotplug_wait(void)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-void set_rq_online(struct rq *rq)
+void set_rq_online(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (!rq->online) {
 		const struct sched_class *class;
@@ -9557,19 +9557,19 @@ void set_rq_online(struct rq *rq)
 
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
@@ -9665,7 +9665,7 @@ int sched_cpu_activate(unsigned int cpu)
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_online(rq);
+		set_rq_online(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
@@ -9710,7 +9710,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	if (rq->rd) {
 		update_rq_clock(rq);
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
+		set_rq_offline(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5a9a4b81c972..56b5fc9b0530 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2519,7 +2519,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 }
 
 /* Assumes rq->lock is held */
-static void rq_online_dl(struct rq *rq)
+static void rq_online_dl(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->dl.overloaded)
 		dl_set_overload(rq);
@@ -2530,7 +2530,7 @@ static void rq_online_dl(struct rq *rq)
 }
 
 /* Assumes rq->lock is held */
-static void rq_offline_dl(struct rq *rq)
+static void rq_offline_dl(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->dl.overloaded)
 		dl_clear_overload(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c0818324a9cd..9838c82230e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11909,14 +11909,14 @@ void trigger_load_balance(struct rq *rq)
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
index 00e0e5074115..5c15d017f762 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2477,7 +2477,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 }
 
 /* Assumes rq->lock is held */
-static void rq_online_rt(struct rq *rq)
+static void rq_online_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_set_overload(rq);
@@ -2488,7 +2488,7 @@ static void rq_online_rt(struct rq *rq)
 }
 
 /* Assumes rq->lock is held */
-static void rq_offline_rt(struct rq *rq)
+static void rq_offline_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_clear_overload(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index eddc3775cc92..cd11bf9de7f9 100644
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
@@ -2750,8 +2755,8 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	raw_spin_rq_unlock(rq1);
 }
 
-extern void set_rq_online (struct rq *rq);
-extern void set_rq_offline(struct rq *rq);
+extern void set_rq_online (struct rq *rq, enum rq_onoff_reason reason);
+extern void set_rq_offline(struct rq *rq, enum rq_onoff_reason reason);
 extern bool sched_smp_initialized;
 
 #else /* CONFIG_SMP */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6682535e37c8..e9a1d61eb186 100644
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
2.41.0


