Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ABC6BF47A
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjCQVi6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjCQVi1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:38:27 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2302774A6C;
        Fri, 17 Mar 2023 14:36:51 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso6625817pjb.3;
        Fri, 17 Mar 2023 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK2aJVKovuD8X9fkbu87j/H7Z7JuonUqKoeh6yiYhnU=;
        b=DWP/A6JL25BlAScJg8Mki7VMS8L338jbzxjTJehps9vOBsi9ZV1lfEeMKn2IjLzSKM
         Bey1eWR5JXAi5uMKygnqVH918L2m7qjWG5UxVBH/OyHQgq8pDAtgN5HxXXg8duYQq2f3
         JfCRrofmXL7UEVArd9u70V8nrEJzAeU/XrnWqAl1XOoHZZvRGDEQHcPDiHqea0tM/Ik2
         vN7UQ867RTfemMFk9v+/RSMukUoKV1V01Ea/ME/QRzsD+Gq7K/3/yFPRbGbuMIZX7QEm
         gm8K+O6t3a6nd4Vm9siK4gxKpdI8inMcz046rPnqciExTJYWnbvErJ16PYTUpZKVbjlZ
         ksIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QK2aJVKovuD8X9fkbu87j/H7Z7JuonUqKoeh6yiYhnU=;
        b=O3vgLBlYtWn8MCQYqBxaefaqU3ah/cu1FIieCQ8wN0zltkESkV/EgW9CmsnffL4DwL
         KEzUk/glYCkUJt+0OWXNPehdd2Lg4dYkdDcahlafiNpNLEBYFi2hKzri61TiDhqvI9l2
         /zWH9VenNFb0fiWQ7X3rxdzP5C09s3pZ+z7XGmK2kr+DNSLySBLcitAcJ4an0Ddj158F
         uXnTM4IGjOae0Ym2rUryKGHm9rLHyNWIEwSfwknqisAVBtWMMUu8NaGL2wOLOq2v1bvY
         qdu7QlUW0UXfYROmurKz1vRNpwwo/AGrdRKF+v8NhNGIIKTHNkYjxR2X5STEn/gUtVeW
         SKxQ==
X-Gm-Message-State: AO0yUKX90hIJb96Lu+0DPU+kASv75fN86r+idMlQWjpTqMcI+f/lIMJE
        THvwmFOMegC3w4TfK4IBnDI=
X-Google-Smtp-Source: AK7set8B/7PevrNGdStT+45BZoFOmumu4wp0v36haQyhTH+fqHdz/ucGTEC9p63/hgY3fJHRwhaOgA==
X-Received: by 2002:a17:90a:de94:b0:237:47b0:3235 with SMTP id n20-20020a17090ade9400b0023747b03235mr9519254pjv.32.1679088844803;
        Fri, 17 Mar 2023 14:34:04 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090abc8300b0023f4274bd9asm1837666pjr.29.2023.03.17.14.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:34:04 -0700 (PDT)
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
Subject: [PATCH 12/32] sched_ext: Add boilerplate for extensible scheduler class
Date:   Fri, 17 Mar 2023 11:33:13 -1000
Message-Id: <20230317213333.2174969-13-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
index 0d166537a1a3..68d08701acd0 100644
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
@@ -843,6 +844,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aa63371aa84c..9ecee40eb0bc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4682,6 +4682,8 @@ late_initcall(sched_core_sysctl_init);
  */
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
+	int ret;
+
 	__sched_fork(clone_flags, p);
 	/*
 	 * We mark the process as NEW here. This guarantees that
@@ -4718,12 +4720,16 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
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
 
@@ -4741,6 +4747,10 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
 	return 0;
+
+out_cancel:
+	scx_cancel_fork(p);
+	return ret;
 }
 
 int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
@@ -4771,16 +4781,18 @@ int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
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
@@ -5935,7 +5947,7 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * We can terminate the balance pass as soon as we know there is
 	 * a runnable task of @class priority or higher.
 	 */
-	for_class_range(class, prev->sched_class, &idle_sched_class) {
+	for_balance_class_range(class, prev->sched_class, &idle_sched_class) {
 		if (class->balance(rq, prev, rf))
 			break;
 	}
@@ -5953,6 +5965,9 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct sched_class *class;
 	struct task_struct *p;
 
+	if (scx_enabled())
+		goto restart;
+
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
@@ -5978,7 +5993,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
-	for_each_class(class) {
+	for_each_active_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
 			return p;
@@ -6011,7 +6026,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	const struct sched_class *class;
 	struct task_struct *p;
 
-	for_each_class(class) {
+	for_each_active_class(class) {
 		p = class->pick_task(rq);
 		if (p)
 			return p;
@@ -9953,6 +9968,7 @@ void __init sched_init(void)
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
index e9ef66be2870..65378f0be8dc 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -407,11 +407,13 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 
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
index 6397843b4482..6c42b042daa4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3411,4 +3411,6 @@ enum cpu_cftype_id {
 extern struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1];
 #endif /* CONFIG_CGROUP_SCHED */
 
+#include "ext.h"
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.39.2

