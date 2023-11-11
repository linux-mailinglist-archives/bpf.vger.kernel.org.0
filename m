Return-Path: <bpf+bounces-14829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806647E8879
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF6228132D
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B305399;
	Sat, 11 Nov 2023 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzeTD368"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF951860
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:49:25 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409746BB;
	Fri, 10 Nov 2023 18:49:12 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so2746256b3a.2;
        Fri, 10 Nov 2023 18:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670952; x=1700275752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3voCMUr9Jl2A3ihfyp8mNTtRIUw0nwNYbxiZLrsazC4=;
        b=BzeTD368ojS6B4b/Rz5Vszl3HDNDn5PVA5k3jnF75ARMehChMkplNh0ImiIx51+q/7
         8DnNHvk8p5ASQviJMCTBCg8kMYrHRICr5pQ1hnwafDUvFq7ZNHp1Ikf0hpzSpNa7BXRa
         DmjRExT6RY/TGxP0Psht/5bgOVtar3YagS2Mmkr9eEmmatpEKEkCQTCjxVB3E7kxW0dJ
         N627BVt7mifGQ/qBsKWrA0cbjWQpMzO1IwE1hY9oM951xgUipv1LWZjGgIIOa5TZHxDX
         eb8f7yhX6b2JQ2tBLeYOofYTI1eoevssDxtLLTp76OYIzV7I9e9F3MMDZ2W2kMkMaowP
         inaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670952; x=1700275752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3voCMUr9Jl2A3ihfyp8mNTtRIUw0nwNYbxiZLrsazC4=;
        b=axGegGBwwHTbdfKdhStVGrbT+SigmFvW02eFENS6n6eEuysaK2h7oIpZ/SfcFod4Qy
         mIP6OXjad6znUabN5yX5z9jUXZR4S6YaUuMWbm2ZfBqH7yurwPfamG0VDv2qMr/RVqa8
         bIHbjz7S2CsX+plow+bEJG1DhDQ5YMaTN3Pz1wXu5zpYPNKWi8NNvT6T+UG50v+DPCwG
         dTB6o94hbmGYqTuY4Bs+PJBq529r3/3jsnzNOk1gtxBk/vNQQo309sql1U0dTd2OYr/v
         bfRy4/OX0AtHbUzQ2LMi8YSKg2mFqPpCgvCCrvlBki6TuzDxXO48fcyRfh8NHkpVwPud
         NdlQ==
X-Gm-Message-State: AOJu0YwD0CaRFBj83AYb0n/BFT0xN4Y8exQlyN5PmkBD7UJtKC+Ek4Np
	3M/1TTaHrBWZWuwXw4L/XpU=
X-Google-Smtp-Source: AGHT+IHf1ljKUL15hO1UPlVcx9AdqslRK9173O5x0w77M4xKB+Yiii6ukhykUdBvf26Ok512Gto9fw==
X-Received: by 2002:a05:6a00:1bc4:b0:6c6:1648:5ac1 with SMTP id o4-20020a056a001bc400b006c616485ac1mr286223pfw.27.1699670952066;
        Fri, 10 Nov 2023 18:49:12 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id 24-20020aa79258000000b006879493aca0sm402076pfp.26.2023.11.10.18.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:11 -0800 (PST)
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
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/36] sched: Add @reason to sched_class->rq_{on|off}line()
Date: Fri, 10 Nov 2023 16:47:35 -1000
Message-ID: <20231111024835.2164816-10-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 971026d6e28f..9894d11bdb88 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9547,7 +9547,7 @@ static inline void balance_hotplug_wait(void)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-void set_rq_online(struct rq *rq)
+void set_rq_online(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (!rq->online) {
 		const struct sched_class *class;
@@ -9557,12 +9557,12 @@ void set_rq_online(struct rq *rq)
 
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
@@ -9570,7 +9570,7 @@ void set_rq_offline(struct rq *rq)
 		update_rq_clock(rq);
 		for_each_class(class) {
 			if (class->rq_offline)
-				class->rq_offline(rq);
+				class->rq_offline(rq, reason);
 		}
 
 		cpumask_clear_cpu(rq->cpu, rq->rd->online);
@@ -9666,7 +9666,7 @@ int sched_cpu_activate(unsigned int cpu)
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_online(rq);
+		set_rq_online(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
@@ -9710,7 +9710,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
+		set_rq_offline(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b28114478b82..e00704ddd963 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2483,7 +2483,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 }
 
 /* Assumes rq->lock is held */
-static void rq_online_dl(struct rq *rq)
+static void rq_online_dl(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->dl.overloaded)
 		dl_set_overload(rq);
@@ -2494,7 +2494,7 @@ static void rq_online_dl(struct rq *rq)
 }
 
 /* Assumes rq->lock is held */
-static void rq_offline_dl(struct rq *rq)
+static void rq_offline_dl(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->dl.overloaded)
 		dl_clear_overload(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8ec0c040e9e8..bd9ff4fa77b8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12291,14 +12291,14 @@ void trigger_load_balance(struct rq *rq)
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
index 6aaf0a3d6081..c5511ce079a7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2435,7 +2435,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 }
 
 /* Assumes rq->lock is held */
-static void rq_online_rt(struct rq *rq)
+static void rq_online_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_set_overload(rq);
@@ -2446,7 +2446,7 @@ static void rq_online_rt(struct rq *rq)
 }
 
 /* Assumes rq->lock is held */
-static void rq_offline_rt(struct rq *rq)
+static void rq_offline_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_clear_overload(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c5c237031189..d02ea254aa87 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2229,6 +2229,11 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+enum rq_onoff_reason {
+	RQ_ONOFF_HOTPLUG,		/* CPU is going on/offline */
+	RQ_ONOFF_TOPOLOGY,		/* sched domain topology update */
+};
+
 struct affinity_context {
 	const struct cpumask *new_mask;
 	struct cpumask *user_mask;
@@ -2265,8 +2270,8 @@ struct sched_class {
 
 	void (*set_cpus_allowed)(struct task_struct *p, struct affinity_context *ctx);
 
-	void (*rq_online)(struct rq *rq);
-	void (*rq_offline)(struct rq *rq);
+	void (*rq_online)(struct rq *rq, enum rq_onoff_reason reason);
+	void (*rq_offline)(struct rq *rq, enum rq_onoff_reason reason);
 
 	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
 #endif
@@ -2810,8 +2815,8 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	raw_spin_rq_unlock(rq1);
 }
 
-extern void set_rq_online (struct rq *rq);
-extern void set_rq_offline(struct rq *rq);
+extern void set_rq_online (struct rq *rq, enum rq_onoff_reason reason);
+extern void set_rq_offline(struct rq *rq, enum rq_onoff_reason reason);
 extern bool sched_smp_initialized;
 
 #else /* CONFIG_SMP */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391e7416..7798063b3a38 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -497,7 +497,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 		old_rd = rq->rd;
 
 		if (cpumask_test_cpu(rq->cpu, old_rd->online))
-			set_rq_offline(rq);
+			set_rq_offline(rq, RQ_ONOFF_TOPOLOGY);
 
 		cpumask_clear_cpu(rq->cpu, old_rd->span);
 
@@ -515,7 +515,7 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 
 	cpumask_set_cpu(rq->cpu, rd->span);
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
-		set_rq_online(rq);
+		set_rq_online(rq, RQ_ONOFF_TOPOLOGY);
 
 	rq_unlock_irqrestore(rq, &rf);
 
-- 
2.42.0


