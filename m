Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C881563D079
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiK3IZZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiK3IYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:24:46 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC446D482;
        Wed, 30 Nov 2022 00:24:05 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r18so15367129pgr.12;
        Wed, 30 Nov 2022 00:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bT49z/mzeTzqh2wPqLdg02CTarWafMLV3eCTvzPKZD4=;
        b=ebWxoeUBkAcNEBzhdtaYvvAG3x4bUDfhz3wIqPwXkNvD2Be2WofD5+silHYd0TH/04
         WheMCbaSJIbXwqQ1kKBVeiCHtMVNEXYBxm+KLCNj4nn188bGJ7fumotihKDrLhO00lbL
         1V2f0szVq3K57ot6zdH1gY0FZPk07NgEFgjdh62PTQZydb+gsX7O7MCEqtskZURKxzMm
         AE7rTI3OyEOH0Mn7E6cXI0s6KFE/JMo1AvdKmaim3EFCpD/R+qg+ZUWa0Pwa9kPaaoPu
         VZWSxIeGxrw0oEiszUzLVz+ifdOuNqUH/5vhH1IcFW3fjjY5dIMxPHQ/8FPoC5KeU8XA
         QkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bT49z/mzeTzqh2wPqLdg02CTarWafMLV3eCTvzPKZD4=;
        b=BJ2iDXToXzrCvJRMTYnFgdZkAX57T+4JRO1oLI7Fe/5osWfUUzMSHUGPwjoSSMXzY+
         21Xy0cX9cpMieF5p8giS0TmJW+JmRrzbYUShqVblosz++VrUQIdH2n0wAPmU+B2gVNzM
         f80Ek98GMnciH5PcfGDLBN7A/BMNzm+gqikv9xGFjJv3lPOoL6LN8E+jLOwGcMRAED3J
         uaGkLfSwKnPxken9Wi/0VPWxuP0BgERUvXC630XoDnhpoMY7lkMyKznSwmjA/9PS5HNe
         0G65v7F4Tn8dwipDg/hKp5r1FGQNg/MVWCqxLd9EIvMaNy2fi1DjKxaGHdTFFkcHafp0
         xukg==
X-Gm-Message-State: ANoB5pkGMCV9+mqqg71t29+Yp0VF4EOppt3vDcOEd1yK///+c0i61ivR
        f9mnOb121FtoiGBLcXuuELI=
X-Google-Smtp-Source: AA0mqf7PZCYgmrrJ4accabsIH2WLe0OTvp2eB0fMJIPsF3WyPQpOvqfipESGqH+ip0YTNeK4+zW3Jg==
X-Received: by 2002:a63:185a:0:b0:476:e84c:ab63 with SMTP id 26-20020a63185a000000b00476e84cab63mr39686668pgy.496.1669796644760;
        Wed, 30 Nov 2022 00:24:04 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b0018099c9618esm739527plc.231.2022.11.30.00.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:04 -0800 (PST)
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
Subject: [PATCH 13/31] sched_ext: Add boilerplate for extensible scheduler class
Date:   Tue, 29 Nov 2022 22:22:55 -1000
Message-Id: <20221130082313.3241517-14-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This adds dummy implementations of sched_ext interfaces which interact with
the scheduler core and hook them in the correct places. As they're all
dummies, this doesn't cause any behavior changes. This is split out to help
reviewing.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h | 12 ++++++++++++
 kernel/fork.c             |  2 ++
 kernel/sched/core.c       | 35 +++++++++++++++++++++++++++--------
 kernel/sched/ext.h        | 34 ++++++++++++++++++++++++++++++++++
 kernel/sched/idle.c       |  2 ++
 kernel/sched/sched.h      |  2 ++
 6 files changed, 79 insertions(+), 8 deletions(-)
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
index a90c6a4938c6..606c6b349799 100644
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
@@ -833,6 +834,7 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9c5bfeeb30ba..b9e69e009343 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4554,6 +4554,8 @@ late_initcall(sched_core_sysctl_init);
  */
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
+	int ret;
+
 	__sched_fork(clone_flags, p);
 	/*
 	 * We mark the process as NEW here. This guarantees that
@@ -4590,12 +4592,16 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
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
 
@@ -4613,6 +4619,10 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
 	return 0;
+
+out_cancel:
+	scx_cancel_fork(p);
+	return ret;
 }
 
 int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
@@ -4643,16 +4653,18 @@ int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
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
@@ -5800,10 +5812,13 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 	 * We can terminate the balance pass as soon as we know there is
 	 * a runnable task of @class priority or higher.
 	 */
-	for_class_range(class, prev->sched_class, &idle_sched_class) {
+	for_balance_class_range(class, prev->sched_class, &idle_sched_class) {
 		if (class->balance(rq, prev, rf))
 			break;
 	}
+#else
+	/* SCX needs the balance call even in UP, call it explicitly */
+	balance_scx_on_up(rq, prev, rf);
 #endif
 
 	put_prev_task(rq, prev);
@@ -5818,6 +5833,9 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct sched_class *class;
 	struct task_struct *p;
 
+	if (scx_enabled())
+		goto restart;
+
 	/*
 	 * Optimization: we know that if all tasks are in the fair class we can
 	 * call that function directly, but only if the @prev task wasn't of a
@@ -5843,7 +5861,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
-	for_each_class(class) {
+	for_each_active_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
 			return p;
@@ -5876,7 +5894,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 	const struct sched_class *class;
 	struct task_struct *p;
 
-	for_each_class(class) {
+	for_each_active_class(class) {
 		p = class->pick_task(rq);
 		if (p)
 			return p;
@@ -9810,6 +9828,7 @@ void __init sched_init(void)
 	balance_push_set(smp_processor_id(), false);
 #endif
 	init_sched_fair_class();
+	init_sched_ext_class();
 
 	psi_init();
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
new file mode 100644
index 000000000000..f348158ed33a
--- /dev/null
+++ b/kernel/sched/ext.h
@@ -0,0 +1,34 @@
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
+static inline int balance_scx(struct rq *rq, struct task_struct *prev,
+			      struct rq_flags *rf) { return 0; }
+static inline void init_sched_ext_class(void) {}
+
+#define for_each_active_class		for_each_class
+#define for_balance_class_range		for_class_range
+
+#endif	/* CONFIG_SCHED_CLASS_EXT */
+
+#ifndef CONFIG_SMP
+static inline void balance_scx_on_up(struct rq *rq, struct task_struct *prev,
+				     struct rq_flags *rf)
+{
+	balance_scx(rq, prev, rf);
+}
+#endif
+
+#if defined(CONFIG_SCHED_CLASS_EXT) && defined(CONFIG_SMP)
+#error "NOT IMPLEMENTED YET"
+#else
+static inline void scx_update_idle(struct rq *rq, bool idle) {}
+#endif
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f26ab2675f7d..86bc5832bdc4 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -428,11 +428,13 @@ static void check_preempt_curr_idle(struct rq *rq, struct task_struct *p, int fl
 
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
index 0741827e3541..c00c27de2a30 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3252,4 +3252,6 @@ enum cpu_cftype_id {
 extern struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1];
 #endif /* CONFIG_CGROUP_SCHED */
 
+#include "ext.h"
+
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.38.1

