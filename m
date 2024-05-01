Return-Path: <bpf+bounces-28343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896348B8C94
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB751C22484
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD2131E21;
	Wed,  1 May 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu4QtYDT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA013175E;
	Wed,  1 May 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576425; cv=none; b=IbjDL4dlUI4OGpyKSQPxzTDdIP83HSGhOrFuxlwpxkU+++smUMlaeNCuRNtGfmrcxICmAEnqiVkmOCpJY3ZdHxj82N2bn9fy8KRj1StM1KO62AlLtDccEtLcxra30cl2eimM5K4MkZsuTaVU5kTLpfHSbQWroerieuL3rsiukRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576425; c=relaxed/simple;
	bh=pegZxHoDjxfUmcl1jBoTXnuF+4NN+F73aBec/9dT70A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPL1GXDOpui/VrjOTsholzjVaKybL2qq0WL+fYWfHQCGHeAx6Edy0V949e+CGTAmgC9VrJsqulYzIQBi19/gGdbANMGFVsYR2ENCwhgA2Ellb+W/psINEiGPGB5vYR8K4Zz8G30zp/GbllKpAcxGMCloIGTasSzri0H1GxJDOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hu4QtYDT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e5715a9ebdso57868545ad.2;
        Wed, 01 May 2024 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576423; x=1715181223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfUvs+J8pKjROTT6OTT2EjYcFdEkqiGHtDwhMSGbBws=;
        b=Hu4QtYDTqTBNUzkC6qzpYHqTcALL67+TEdZNsaQEnha3qGRI7VxbTsblXCkOKxAaAw
         9RYbJStx26hF8JFWg8tFDw0/4q1PzO37gPKcqp21JJtDl0p7eYPZDRayPOFIt5zBkBhC
         bj6rObp3F29dkv4xFImBaDyVi/KgbdmeNY+LiE8o6OsCRkjoxmF20SUnd+qNmvD6HuAK
         3JOcPURyjjVmopKUWqQy0/hkaxwasMIODs8v/+leo2O6jUG16mrcsqrb1BTdn2AtCy1v
         lPzY/0roH2vs3+Lf39f7p5ubxv6UMtzl3ijESYInm/Z+t2vAgc/Xgo4AuWJexNrzmImP
         eN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576423; x=1715181223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dfUvs+J8pKjROTT6OTT2EjYcFdEkqiGHtDwhMSGbBws=;
        b=jQaKgpDb33GePCYTGS1yC9fSTKjSMblf3sCEdCzvmTqH88shQUrPwWhdDs3ErI71yN
         owl3OUCtpp+siHKW6uYDhROKHlVJIp/jkfN2p42nIyCx5mnRxWBPpNgVEdQ/B8j8WAcE
         Nnw+eqnjFXBtXaO4pmehn9R94UK4f1GXBVfLse258ueUA3YSZDHAHbSRQQX1WExFDq5y
         PFIXPCjsvlBThVXqVvuHqYZApyi1yBCXZtee9UsNQ4AZjjF76xQYurhDe33+qnaTS58v
         aoh/VVttEZJ+N6xB4O1Zm/GMhv13rnVBQSkKDStcnvHY1+a20JIfAFf9lMWwPlXfzRBj
         npqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS2wraLz7yX8F/1mfPuk5uwv2rbpCkuY6Lw9CqDBNrlV2DdrRS47iOZWWFJ/jYnj8L/VWSh3PUXN1g2qg7rdk2JVD3
X-Gm-Message-State: AOJu0YzmdZzpOXY4xlkSMEqJHVQ5fQrtZFtIYVvnJQFPWCLtTD/aS/ts
	ZgKfpvERdL5OENZmpGplsF9BaUWO9BDs/Gr34cuuQD80detO87bU
X-Google-Smtp-Source: AGHT+IF+KWFsY6Due4W2b1nmfxrz6tyjP+hK3pRB9CJ/VYW51JsbWR79SLBhujrOaGitJ0K726SYqw==
X-Received: by 2002:a17:903:234d:b0:1eb:1663:c7f7 with SMTP id c13-20020a170903234d00b001eb1663c7f7mr2899754plh.43.1714576423280;
        Wed, 01 May 2024 08:13:43 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001eab3ba79f2sm11918214plh.35.2024.05.01.08.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:43 -0700 (PDT)
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
Subject: [PATCH 13/39] sched_ext: Add boilerplate for extensible scheduler class
Date: Wed,  1 May 2024 05:09:48 -1000
Message-ID: <20240501151312.635565-14-tj@kernel.org>
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

This adds dummy implementations of sched_ext interfaces which interact with
the scheduler core and hook them in the correct places. As they're all
dummies, this doesn't cause any behavior changes. This is split out to help
reviewing.

v2: balance_scx_on_up() dropped. This will be handled in sched_ext proper.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h        | 12 ++++++++++++
 kernel/fork.c                    |  2 ++
 kernel/sched/core.c              | 32 ++++++++++++++++++++++++--------
 kernel/sched/cpufreq_schedutil.c |  4 +++-
 kernel/sched/ext.h               | 25 +++++++++++++++++++++++++
 kernel/sched/idle.c              |  2 ++
 kernel/sched/sched.h             |  2 ++
 7 files changed, 70 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/sched/ext.h
 create mode 100644 kernel/sched/ext.h

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
new file mode 100644
index 000000000000..a05dfcf533b0
--- /dev/null
+++ b/include/linux/sched/ext.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCHED_EXT_H
+#define _LINUX_SCHED_EXT_H
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+#error "NOT IMPLEMENTED YET"
+#else	/* !CONFIG_SCHED_CLASS_EXT */
+
+static inline void sched_ext_free(struct task_struct *p) {}
+
+#endif	/* CONFIG_SCHED_CLASS_EXT */
+#endif	/* _LINUX_SCHED_EXT_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 02f12033db9c..6238b1ae3306 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -23,6 +23,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/ext.h>
 #include <linux/seq_file.h>
 #include <linux/rtmutex.h>
 #include <linux/init.h>
@@ -970,6 +971,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7542a39f1fde..0231905ec827 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4767,6 +4767,8 @@ late_initcall(sched_core_sysctl_init);
  */
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
+	int ret;
+
 	__sched_fork(clone_flags, p);
 	/*
 	 * We mark the process as NEW here. This guarantees that
@@ -4803,12 +4805,16 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->sched_reset_on_fork = 0;
 	}
 
-	if (dl_prio(p->prio))
-		return -EAGAIN;
-	else if (rt_prio(p->prio))
+	scx_pre_fork(p);
+
+	if (dl_prio(p->prio)) {
+		ret = -EAGAIN;
+		goto out_cancel;
+	} else if (rt_prio(p->prio)) {
 		p->sched_class = &rt_sched_class;
-	else
+	} else {
 		p->sched_class = &fair_sched_class;
+	}
 
 	init_entity_runnable_average(&p->se);
 
@@ -4826,6 +4832,10 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
 	return 0;
+
+out_cancel:
+	scx_cancel_fork(p);
+	return ret;
 }
 
 int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
@@ -4856,16 +4866,18 @@ int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 
-	return 0;
+	return scx_fork(p);
 }
 
 void sched_cancel_fork(struct task_struct *p)
 {
+	scx_cancel_fork(p);
 }
 
 void sched_post_fork(struct task_struct *p)
 {
 	uclamp_post_fork(p);
+	scx_post_fork(p);
 }
 
 unsigned long to_ratio(u64 period, u64 runtime)
@@ -6017,7 +6029,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * We can terminate the balance pass as soon as we know there is
 	 * a runnable task of @class priority or higher.
 	 */
-	for_class_range(class, prev->sched_class, &idle_sched_class) {
+	for_balance_class_range(class, prev->sched_class, &idle_sched_class) {
 		if (class->balance(rq, prev, rf))
 			break;
 	}
@@ -6035,6 +6047,9 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct sched_class *class;
 	struct task_struct *p;
 
+	if (scx_enabled())
+		goto restart;
+
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
@@ -6075,7 +6090,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (prev->dl_server)
 		prev->dl_server = NULL;
 
-	for_each_class(class) {
+	for_each_active_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
 			return p;
@@ -6108,7 +6123,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	const struct sched_class *class;
 	struct task_struct *p;
 
-	for_each_class(class) {
+	for_each_active_class(class) {
 		p = class->pick_task(rq);
 		if (p)
 			return p;
@@ -10135,6 +10150,7 @@ void __init sched_init(void)
 	balance_push_set(smp_processor_id(), false);
 #endif
 	init_sched_fair_class();
+	init_sched_ext_class();
 
 	psi_init();
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 972b7dd65af2..0827864c35ff 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -197,7 +197,9 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 
 static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 {
-	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
+	unsigned long min, max;
+	unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu) +
+		scx_cpuperf_target(sg_cpu->cpu);
 
 	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
 	util = max(util, boost);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
new file mode 100644
index 000000000000..42bd1e47b304
--- /dev/null
+++ b/kernel/sched/ext.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+#error "NOT IMPLEMENTED YET"
+#else	/* CONFIG_SCHED_CLASS_EXT */
+
+#define scx_enabled()		false
+
+static inline void scx_pre_fork(struct task_struct *p) {}
+static inline int scx_fork(struct task_struct *p) { return 0; }
+static inline void scx_post_fork(struct task_struct *p) {}
+static inline void scx_cancel_fork(struct task_struct *p) {}
+static inline void init_sched_ext_class(void) {}
+static inline u32 scx_cpuperf_target(s32 cpu) { return 0; }
+
+#define for_each_active_class		for_each_class
+#define for_balance_class_range		for_class_range
+
+#endif	/* CONFIG_SCHED_CLASS_EXT */
+
+#if defined(CONFIG_SCHED_CLASS_EXT) && defined(CONFIG_SMP)
+#error "NOT IMPLEMENTED YET"
+#else
+static inline void scx_update_idle(struct rq *rq, bool idle) {}
+#endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6135fbe83d68..3b6540cc436a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -458,11 +458,13 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
 static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 {
+	scx_update_idle(rq, false);
 }
 
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
+	scx_update_idle(rq, true);
 	schedstat_inc(rq->sched_goidle);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 11b4345d2638..fbd1e9ea8b18 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3540,4 +3540,6 @@ enum cpu_cftype_id {
 extern struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1];
 #endif /* CONFIG_CGROUP_SCHED */
 
+#include "ext.h"
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.44.0


