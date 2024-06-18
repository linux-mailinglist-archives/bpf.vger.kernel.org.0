Return-Path: <bpf+bounces-32442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EC790DE29
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5081F22D05
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DF9185E5B;
	Tue, 18 Jun 2024 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJO9xJIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447C1891D0;
	Tue, 18 Jun 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745681; cv=none; b=Y33/9wsOx/xLv4mtN8rVRBHlJyy+DaQW+gmmFE6FsqHu9MbYPL8P3c1ueQPZRnFjKmtb2nQ/2IETS8pvDhYmcCtpQsQZ2lUdiZe8sLk43vs46lzq1mxAhlvuiSdIjXRFMiTT6LnvB+jxuB+6eritqs8M0ieKscqy7PlYMPyCIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745681; c=relaxed/simple;
	bh=jmOcb/IcTEoILUf0VhqwFVlR6EMt8FGUcjcazrJnSdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9x6nvt5tR46A9jRhRCmGdjdiFEQV9KpFs8DsYQjiTPAT9GbHT0wk60Asyd4RqdPfF/3qVxOrDAtMJnLzwz0ha7oAp4zk0Rqr7jHXyp60lVXS30CEtDdLmIGhQrU2YV+stYBV5vBpNN+nhJHFZxQ9VFylZmA0iJhIe6Sb/Nqf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJO9xJIQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7042882e741so4896963b3a.2;
        Tue, 18 Jun 2024 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745679; x=1719350479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ffa8YpwXAMqPkPHHa1RnRzpp/y6eCtDT+TtAUiHJ/Xk=;
        b=KJO9xJIQuUj9NZVC0me7TklHl0Ab40mPH0w0q4QGLXuUrID5BxLzkQorPBE8y6ntzk
         1TfUUZSGXpsQoiWSn4kIsaCGr407iUNsFQpsbTkl8SFn9NA4G/6MBfp01AP0/iOOh2Vo
         ybD/j+AuAn1XE0NR6wOx1Es/X0p/sVGqgn8rr4rm7E/tdLUgVFl0LsSq9YYsd7tMNUlu
         yaRtNsMVMkad7pKt/a1r12wNVWgzCUq0ILNCNf3OkPr747MXINZl1hstkbo0i41SzqRw
         /JQ8K5OsYb9+72ZRNs5fJWFe+K+T9azHHu92KpCJVdsoGDuQGDnxkvWoDIlHCHIBP3G+
         nwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745679; x=1719350479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ffa8YpwXAMqPkPHHa1RnRzpp/y6eCtDT+TtAUiHJ/Xk=;
        b=Z7paBfR7uYii/L0fWkA0DDFtErFprjVnESdGMAL27RYC3P7IqX6PktNW7+Rf65jk9H
         gutvOnZZYLayGCGeWhv3Z850p95T21PrfKAj86hZF22LE5yJkxoP61nnbJijcQbIh/IT
         aVDZQomcc4Hh0QEi7w03tr/ydhh+2NsWVnilstJa/1hfXr+3SSUByZVPaMgC+g+5snMQ
         9laYPeZ6VW/b+fjaHUs/kiL7RA1PfKNf0559p2jpm0XIZx1N/pGMgX1hh9zXSUfKc+9S
         r2IvKXZyZYIjXXQ7bpKFDE0UUPc0kVOxRYRtPIhmys94wUigMUsMJ9Rx3P2UdCmgV86S
         eypQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaNRefs5hPtz0L7UKikDxNVBrWCKVKyvm6IVvj/JUUCSJh12m0lhybkYTCKXF+04We/+Ved4NPaJ5FFuuJmEQUhEiy
X-Gm-Message-State: AOJu0Yz0NfP3wfJstEvrKvoLaX314u6tL+JpKzB7WQiz2sjBkYvToXdx
	MJ4RXwnqKGmV7CMvfMWNTfUiMqlOXip4WVEra8qRx9BgxhYqzRby
X-Google-Smtp-Source: AGHT+IHKGQgmm7i/0HS1cAiWYe72jiZL6nxs9+5SSqGupL9d55+fNEThH4Mrmjn54NyZdhpPB1SPCA==
X-Received: by 2002:a05:6a20:1e4a:b0:1b4:33c0:4a12 with SMTP id adf61e73a8af0-1bcbb426f83mr735742637.17.1718745679213;
        Tue, 18 Jun 2024 14:21:19 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d309sm9401078b3a.104.2024.06.18.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:18 -0700 (PDT)
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
Subject: [PATCH 08/30] sched_ext: Add boilerplate for extensible scheduler class
Date: Tue, 18 Jun 2024 11:17:23 -1000
Message-ID: <20240618212056.2833381-9-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
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
 include/linux/sched/ext.h | 12 ++++++++++++
 kernel/fork.c             |  2 ++
 kernel/sched/core.c       | 32 ++++++++++++++++++++++++--------
 kernel/sched/ext.h        | 24 ++++++++++++++++++++++++
 kernel/sched/idle.c       |  2 ++
 kernel/sched/sched.h      |  2 ++
 6 files changed, 66 insertions(+), 8 deletions(-)
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
index e601fdf787c3..741d962db0d9 100644
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
@@ -971,6 +972,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0bfbceebc4e9..d8c963fea9eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4559,6 +4559,8 @@ late_initcall(sched_core_sysctl_init);
  */
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
+	int ret;
+
 	__sched_fork(clone_flags, p);
 	/*
 	 * We mark the process as NEW here. This guarantees that
@@ -4595,12 +4597,16 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
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
 
@@ -4618,6 +4624,10 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
 	return 0;
+
+out_cancel:
+	scx_cancel_fork(p);
+	return ret;
 }
 
 int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
@@ -4648,16 +4658,18 @@ int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
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
@@ -5800,7 +5812,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * We can terminate the balance pass as soon as we know there is
 	 * a runnable task of @class priority or higher.
 	 */
-	for_class_range(class, prev->sched_class, &idle_sched_class) {
+	for_balance_class_range(class, prev->sched_class, &idle_sched_class) {
 		if (class->balance(rq, prev, rf))
 			break;
 	}
@@ -5818,6 +5830,9 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct sched_class *class;
 	struct task_struct *p;
 
+	if (scx_enabled())
+		goto restart;
+
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
@@ -5858,7 +5873,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	if (prev->dl_server)
 		prev->dl_server = NULL;
 
-	for_each_class(class) {
+	for_each_active_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
 			return p;
@@ -5891,7 +5906,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	const struct sched_class *class;
 	struct task_struct *p;
 
-	for_each_class(class) {
+	for_each_active_class(class) {
 		p = class->pick_task(rq);
 		if (p)
 			return p;
@@ -8355,6 +8370,7 @@ void __init sched_init(void)
 	balance_push_set(smp_processor_id(), false);
 #endif
 	init_sched_fair_class();
+	init_sched_ext_class();
 
 	psi_init();
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
new file mode 100644
index 000000000000..6a93c4825339
--- /dev/null
+++ b/kernel/sched/ext.h
@@ -0,0 +1,24 @@
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
index 6e78d071beb5..c7a218123b7a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -452,11 +452,13 @@ static void wakeup_preempt_idle(struct rq *rq, struct task_struct *p, int flags)
 
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
index 25660dc9f639..c52ad5fdd096 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3658,4 +3658,6 @@ static inline void balance_callbacks(struct rq *rq, struct balance_callback *hea
 
 #endif
 
+#include "ext.h"
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.45.2


