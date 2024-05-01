Return-Path: <bpf+bounces-28339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CAE8B8C8C
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369CE283536
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D7012F5A7;
	Wed,  1 May 2024 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2dONXVn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E8C130E26;
	Wed,  1 May 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576416; cv=none; b=Ws8POKMeHr8jRj+abyeq29udgQ5Ai8NbDt810aTzpVE+Y3VRz9EYr6sGu3yUe4M1z2bZxv2jPl3odlLlojHkON5+tdcQIKLT/H8fpnq6LPUdqXzwGWAjWu041Y7Ki1MPMHk1Ljkd7v15X1Z4SyemGwJTBZF5MhnUSEUo0BvXb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576416; c=relaxed/simple;
	bh=Oq87g67GCGStGDVeIyUo3bWV71vCw1fl3T2B6oBFcwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGPieBhSWdWGt9Bhtv6j7ExR5UWf1aKGlZ2eq0e9jeh+ZeU0Lkn7YZpj4MEHImC6h35GKCXx7PFVdrQew3yRpwaSlzRnMm3zwFpt4xRVMZtrbRS2ryGs69JhspbPvXF3EVw/XwOjq9mX9DZ9vRO8wb9PvmyaVWVS9adJhZwl7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2dONXVn; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4925598a12.2;
        Wed, 01 May 2024 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576414; x=1715181214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDNAT/kHF5gec+qhYsHCKIcwgrbw46YxZbI7N/jB1Ok=;
        b=l2dONXVndOQ16FQfC2LFH8ATUaH1hYKByjiVpJX8rriGxuh+raWoHrarbElfGnfX2S
         oRM5aj1vQH3cjfcVEAKBwpJ8k2gP2dAKw3gUscR/o28c+AnKIrmPSkCSgCAD4fGz0ZJ4
         KPslMbyn2SPquZa7Vkpai5mN4teNxgtq12fAbDwSEMCwUywsYhCu0TEw/sEY4SBmqifY
         sfR5fyDpDK2aGr5utwFZtJCiCy042jjIyJZ+289ZCKOZ1jdHeT12kCyw2zf9CuQ91m2S
         xvAoPlLRf7dtNpeS91Yjut7/GEyfUtLdaUMaFdzkHsUKMJaed58h4RPPlxQ+K8L0JeYQ
         fQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576414; x=1715181214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDNAT/kHF5gec+qhYsHCKIcwgrbw46YxZbI7N/jB1Ok=;
        b=ngna8aNYyCQP0/4UvYJlOAshuw+mdR+0B37suTFVD6mtO0vq0kDoA+Ou7X0xYB9lVZ
         p5z5dJc+9VULhD2vyDO8/MlZAmaaLFLYo0ldmYJE7FsNaOvoeHj0o5uAtOaWmucghv3+
         WB48/OmV9w0fyrl+cksta7jSSh37iyBphDDDVXyIkBjk4wrVBSVOIKdsUGCQbbIEvqv3
         vdKChMBqCfCaDrSik6hr52RkmpZxknqxwWeI9rWy0YxbWBbmW9ix5jAMMGu52xqkHTHx
         9RC8Dzu6k7IOyR+7pCgsFs9kJ2+l16nxaDgvxuOACRVlNSjEdXBpvEIV3I8VeA0YHKUT
         7QfA==
X-Forwarded-Encrypted: i=1; AJvYcCXzwim/a6oLwHFHzVWvwQTE3xbZruKYgbMlRykIT2nl99OT2v4cq6KWqIRz0+ADPhxxCz8KKrQqlBQrGDH8cUKNp4e/
X-Gm-Message-State: AOJu0YwLOT1iDb3crEMubwCvfuTvU4Sjfp5tTtNiC4efZJN18i9rSu11
	AYLQ1v/kYAMXudT7N6RuC815a0T1t3wDsNlX99NdtIe5qbfjp21+
X-Google-Smtp-Source: AGHT+IGLJElPH88+HyT1S744nn8nSse2luaIsH+YecHTw6prNRYijKVqcJJDa6aOPzfJcGSY2wEVzg==
X-Received: by 2002:a05:6a20:438f:b0:1a9:b207:d228 with SMTP id i15-20020a056a20438f00b001a9b207d228mr4185976pzl.38.1714576414261;
        Wed, 01 May 2024 08:13:34 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id m4-20020aa78a04000000b006f3e3d9b4f2sm8748721pfa.4.2024.05.01.08.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:33 -0700 (PDT)
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
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/39] sched: Add @reason to sched_class->rq_{on|off}line()
Date: Wed,  1 May 2024 05:09:44 -1000
Message-ID: <20240501151312.635565-10-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
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
index e48af9fbbd71..90b505fbb488 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9593,7 +9593,7 @@ static inline void balance_hotplug_wait(void)
 
 #endif /* CONFIG_HOTPLUG_CPU */
 
-void set_rq_online(struct rq *rq)
+void set_rq_online(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (!rq->online) {
 		const struct sched_class *class;
@@ -9603,12 +9603,12 @@ void set_rq_online(struct rq *rq)
 
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
@@ -9616,7 +9616,7 @@ void set_rq_offline(struct rq *rq)
 		update_rq_clock(rq);
 		for_each_class(class) {
 			if (class->rq_offline)
-				class->rq_offline(rq);
+				class->rq_offline(rq, reason);
 		}
 
 		cpumask_clear_cpu(rq->cpu, rq->rd->online);
@@ -9712,7 +9712,7 @@ int sched_cpu_activate(unsigned int cpu)
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_online(rq);
+		set_rq_online(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
@@ -9756,7 +9756,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
+		set_rq_offline(rq, RQ_ONOFF_HOTPLUG);
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a04a436af8cc..010d1dc5f918 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2607,7 +2607,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 }
 
 /* Assumes rq->lock is held */
-static void rq_online_dl(struct rq *rq)
+static void rq_online_dl(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->dl.overloaded)
 		dl_set_overload(rq);
@@ -2618,7 +2618,7 @@ static void rq_online_dl(struct rq *rq)
 }
 
 /* Assumes rq->lock is held */
-static void rq_offline_dl(struct rq *rq)
+static void rq_offline_dl(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->dl.overloaded)
 		dl_clear_overload(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5d7cffee1a4e..8032256d3972 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12446,14 +12446,14 @@ void trigger_load_balance(struct rq *rq)
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
index 3261b067b67e..8620474d117d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2426,7 +2426,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 }
 
 /* Assumes rq->lock is held */
-static void rq_online_rt(struct rq *rq)
+static void rq_online_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_set_overload(rq);
@@ -2437,7 +2437,7 @@ static void rq_online_rt(struct rq *rq)
 }
 
 /* Assumes rq->lock is held */
-static void rq_offline_rt(struct rq *rq)
+static void rq_offline_rt(struct rq *rq, enum rq_onoff_reason reason)
 {
 	if (rq->rt.overloaded)
 		rt_clear_overload(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0b6a34ba2457..bcc8056acadb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2271,6 +2271,11 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+enum rq_onoff_reason {
+	RQ_ONOFF_HOTPLUG,		/* CPU is going on/offline */
+	RQ_ONOFF_TOPOLOGY,		/* sched domain topology update */
+};
+
 struct affinity_context {
 	const struct cpumask *new_mask;
 	struct cpumask *user_mask;
@@ -2309,8 +2314,8 @@ struct sched_class {
 
 	void (*set_cpus_allowed)(struct task_struct *p, struct affinity_context *ctx);
 
-	void (*rq_online)(struct rq *rq);
-	void (*rq_offline)(struct rq *rq);
+	void (*rq_online)(struct rq *rq, enum rq_onoff_reason reason);
+	void (*rq_offline)(struct rq *rq, enum rq_onoff_reason reason);
 
 	struct rq *(*find_lock_rq)(struct task_struct *p, struct rq *rq);
 #endif
@@ -2853,8 +2858,8 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	raw_spin_rq_unlock(rq1);
 }
 
-extern void set_rq_online (struct rq *rq);
-extern void set_rq_offline(struct rq *rq);
+extern void set_rq_online (struct rq *rq, enum rq_onoff_reason reason);
+extern void set_rq_offline(struct rq *rq, enum rq_onoff_reason reason);
 extern bool sched_smp_initialized;
 
 #else /* CONFIG_SMP */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 99ea5986038c..12501543c56d 100644
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
2.44.0


