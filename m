Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32CD6BF473
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCQVi0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjCQVhV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:37:21 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3982962FD8;
        Fri, 17 Mar 2023 14:36:18 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id h8so6660037plf.10;
        Fri, 17 Mar 2023 14:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek2xB039Z37SY+SNJqL7xVXjLO75eTCaHSia7ob4yw8=;
        b=PcmKwOuwLfBUobUpytlBICTcmmbYezLZ2HfCN7STw9plQvvPtS8XdFhZ8mdx1kkMkO
         vdVV0GQBpCN5MVQHMHI55XHWiBJw4JOGDaIMCuxPCt31Jjn4ZcRnNkTCibwDW2OZGbrA
         1VrSYyzvIS9B/T3MqJsxnn/t8ZAEIF2qZQ1/XeXUEVkm/mia/jJ3D+JkJSlBRGjsovmu
         pdIXV7J1+70COvQIs1ui6h51LNoOVW8XXknD2oH/50DZMX5HWcdBqdWawrQisXNHbm6x
         oRaKpGJuZM01RDQSwvYHheXH0sP0ygsladF5BlF9nce5pZwZ5Tn5N32izHTXA1CoZeM7
         ICjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ek2xB039Z37SY+SNJqL7xVXjLO75eTCaHSia7ob4yw8=;
        b=5zy+XHnsyoXU9DFz+Q1gBE2Tj3NhV1VO7tOg5KdFVreLl08K9JoH38hMON1jt6z49N
         XtFfRlAZqqmxplKqjLsUFYzQTqTB8H4UCGeEBWjjnxYjzb3517FhI4ZUk/4heebhHArA
         EDhoh3CH9rK86o8MCRcic3GZF/68uWu+AJDu9WIUAH46GKN6rcxxAZ1oG6Q1NJyb9RXk
         LKkm46qerQBdC+prn5Zmkm5k/AnRUA5PIfdHiNgCxvb+iQNxWV4tRMNkcBe6yfA0iVy3
         Enimc4ZaVDUoeSBW0FbfMw1VJP2rzZb5PKhYvieOfA6kSvOY3tTWCWsVgzh3UqYcFMGk
         pz2g==
X-Gm-Message-State: AO0yUKVpNIMzj10lqoLY19Lxi03WH8mSBMt1t002K7qlB/I2IDgAWpaD
        KLnTzLoTdekMo+C+kqKY5f0=
X-Google-Smtp-Source: AK7set8+6hmCgCd6GrzyIyILipgdQZGDuGy8Zy8U81iwEJ4CpsPIOVxXEQzo3LcXxe+JJxpM1tAOjA==
X-Received: by 2002:a05:6a20:bc88:b0:d5:58df:fb7a with SMTP id fx8-20020a056a20bc8800b000d558dffb7amr5112510pzb.3.1679088837521;
        Fri, 17 Mar 2023 14:33:57 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78150000000b005825b8e0540sm1948805pfn.204.2023.03.17.14.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:33:57 -0700 (PDT)
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
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 08/32] sched: Expose css_tg(), __setscheduler_prio() and SCHED_CHANGE_BLOCK()
Date:   Fri, 17 Mar 2023 11:33:09 -1000
Message-Id: <20230317213333.2174969-9-tj@kernel.org>
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

These will be used by a new BPF extensible sched_class.

css_tg() will be used in the init and exit paths to visit all task_groups by
walking cgroups.

__setscheduler_prio() is used to pick the sched_class matching the current
prio of the task. For the new BPF extensible sched_class, the mapping from
the task configuration to sched_class isn't static and depends on a few
factors - e.g. whether the BPF progs implementing the scheduler are loaded
and in a serviceable state. That mapping logic will be added to
__setscheduler_prio().

When the BPF scheduler progs get loaded and unloaded, the mapping changes
and the new sched_class will walk the tasks applying the new mapping using
SCHED_CHANGE_BLOCK() and __setscheduler_prio().

v2: Expose SCHED_CHANGE_BLOCK() too and update the description.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 kernel/sched/core.c  | 47 +++----------------------------------------
 kernel/sched/sched.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc7008095249..2a602f93f5f8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2096,15 +2096,7 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_task(rq, p, flags);
 }
 
-struct sched_change_guard {
-	struct task_struct	*p;
-	struct rq		*rq;
-	bool			queued;
-	bool			running;
-	bool			done;
-};
-
-static struct sched_change_guard
+struct sched_change_guard
 sched_change_guard_init(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_change_guard cg = {
@@ -2129,7 +2121,7 @@ sched_change_guard_init(struct rq *rq, struct task_struct *p, int flags)
 	return cg;
 }
 
-static void sched_change_guard_fini(struct sched_change_guard *cg, int flags)
+void sched_change_guard_fini(struct sched_change_guard *cg, int flags)
 {
 	if (cg->queued)
 		enqueue_task(cg->rq, cg->p, flags | ENQUEUE_NOCLOCK);
@@ -2138,34 +2130,6 @@ static void sched_change_guard_fini(struct sched_change_guard *cg, int flags)
 	cg->done = true;
 }
 
-/**
- * SCHED_CHANGE_BLOCK - Nested block for task attribute updates
- * @__rq: Runqueue the target task belongs to
- * @__p: Target task
- * @__flags: DEQUEUE/ENQUEUE_* flags
- *
- * A task may need to be dequeued and put_prev_task'd for attribute updates and
- * set_next_task'd and re-enqueued afterwards. This helper defines a nested
- * block which automatically handles these preparation and cleanup operations.
- *
- *  SCHED_CHANGE_BLOCK(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
- *	  update_attribute(p);
- *        ...
- *  }
- *
- * If @__flags is a variable, the variable may be updated in the block body and
- * the updated value will be used when re-enqueueing @p.
- *
- * If %DEQUEUE_NOCLOCK is specified, the caller is responsible for calling
- * update_rq_clock() beforehand. Otherwise, the rq clock is automatically
- * updated iff the task needs to be dequeued and re-enqueued. Only the former
- * case guarantees that the rq clock is up-to-date inside and after the block.
- */
-#define SCHED_CHANGE_BLOCK(__rq, __p, __flags)					\
-	for (struct sched_change_guard __cg =					\
-			sched_change_guard_init(__rq, __p, __flags);		\
-	     !__cg.done; sched_change_guard_fini(&__cg, __flags))
-
 static inline int __normal_prio(int policy, int rt_prio, int nice)
 {
 	int prio;
@@ -7016,7 +6980,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-static void __setscheduler_prio(struct task_struct *p, int prio)
+void __setscheduler_prio(struct task_struct *p, int prio)
 {
 	if (dl_prio(prio))
 		p->sched_class = &dl_sched_class;
@@ -10413,11 +10377,6 @@ void sched_move_task(struct task_struct *tsk)
 	task_rq_unlock(rq, tsk, &rf);
 }
 
-static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct task_group, css) : NULL;
-}
-
 static struct cgroup_subsys_state *
 cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9a6cba6f9299..866ce69a445e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -469,6 +469,11 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 	return walk_tg_tree_from(&root_task_group, down, up, data);
 }
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 extern int tg_nop(struct task_group *tg, void *data);
 
 extern void free_fair_sched_group(struct task_group *tg);
@@ -2386,6 +2391,8 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
+extern void __setscheduler_prio(struct task_struct *p, int prio);
+
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
@@ -2466,6 +2473,47 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
+struct sched_change_guard {
+	struct task_struct	*p;
+	struct rq		*rq;
+	bool			queued;
+	bool			running;
+	bool			done;
+};
+
+extern struct sched_change_guard
+sched_change_guard_init(struct rq *rq, struct task_struct *p, int flags);
+
+extern void sched_change_guard_fini(struct sched_change_guard *cg, int flags);
+
+/**
+ * SCHED_CHANGE_BLOCK - Nested block for task attribute updates
+ * @__rq: Runqueue the target task belongs to
+ * @__p: Target task
+ * @__flags: DEQUEUE/ENQUEUE_* flags
+ *
+ * A task may need to be dequeued and put_prev_task'd for attribute updates and
+ * set_next_task'd and re-enqueued afterwards. This helper defines a nested
+ * block which automatically handles these preparation and cleanup operations.
+ *
+ *  SCHED_CHANGE_BLOCK(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+ *	  update_attribute(p);
+ *        ...
+ *  }
+ *
+ * If @__flags is a variable, the variable may be updated in the block body and
+ * the updated value will be used when re-enqueueing @p.
+ *
+ * If %DEQUEUE_NOCLOCK is specified, the caller is responsible for calling
+ * update_rq_clock() beforehand. Otherwise, the rq clock is automatically
+ * updated iff the task needs to be dequeued and re-enqueued. Only the former
+ * case guarantees that the rq clock is up-to-date inside and after the block.
+ */
+#define SCHED_CHANGE_BLOCK(__rq, __p, __flags)					\
+	for (struct sched_change_guard __cg =					\
+			sched_change_guard_init(__rq, __p, __flags);		\
+	     !__cg.done; sched_change_guard_fini(&__cg, __flags))
+
 extern void check_class_changing(struct rq *rq, struct task_struct *p,
 				 const struct sched_class *prev_class);
 extern void check_class_changed(struct rq *rq, struct task_struct *p,
-- 
2.39.2

