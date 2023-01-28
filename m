Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC5267F2E8
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjA1ARj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjA1ARW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:17:22 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A210A8B7BB;
        Fri, 27 Jan 2023 16:17:07 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id cr11so2676595pfb.1;
        Fri, 27 Jan 2023 16:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaSH0lBUFNrOuEwNNJQpHJ3+/E2VBdXbaH8UuhQdXnk=;
        b=SChcJ3P1SUB48iOxqJmg6K6hG+0FV9tVxBj7k+F5YGOG99MKTpCsmpX49tCTP/ioaY
         MCxE8hP9mqp98dJyDzHgTG+NNhjNBzJ8xG7FhC3H+07fyDDyUaN39ZFCS/cxBvJOGAnj
         sAOdTGs7v0WimDoqCnPR9zooYTc3sR4Q6ndNQDpJSKgGTo3bF4c4qjMpfQWgkdA9oJsr
         /tHrpCxLUq1VPCOnlc+ET4aTM4FRyJtcHgEtURv62/vR0sszLQ4uy5IiFb5EIKlxIYDd
         j99kJxjNwrlf5KRDDebLvN7/+Xh2CdvxGrPbRz3xBQx96tIC0jQWfyRp8AEj6qJAFqOb
         xx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GaSH0lBUFNrOuEwNNJQpHJ3+/E2VBdXbaH8UuhQdXnk=;
        b=X1SaHr/TRzi13iYObfWR1HrgEWFuZ3xcNU7dTrp+PR6GyTzB7uqNAmuxTSDVzbwChg
         nWmjJb7RVwRtqBy7HWU4IuhHYcQx5KJ0Ygqlh8yAXxSZoWADqziTIrwJR7wnXxaLeg6O
         nIaFuPe6ISlGlJTzN1EfTuXGUtlRFuEGYkgvFyEtRAgbR3RuFAHD/k1M2ZCbjVPnxnzF
         dPaCou/v+d3KOrCUrpjgWUKVdqDr6E8KqMgCeneCDNe5mHllNZzxIdb3LaZN1ZrfuH9g
         HeuEiRVOcWqCa8BiBit9N0eo8sjbE1A70rda1tNEipx5YCTQnLi+0uTz2NpTwwGgCBWJ
         5tEQ==
X-Gm-Message-State: AFqh2kqXa+lMv90acd0OMuAJCSN0VOhVRAyY8kTIj1XAa6v11pm7efKm
        931Kp7lr6CgN/mIiUdPhWP8=
X-Google-Smtp-Source: AMrXdXurwcWVtNJVJsH2qtPHQTUYmFSpKN9fFu84p1bisJ6AWnekB/kpcCS+Cdfmggdx4iqLUQgXcA==
X-Received: by 2002:a62:4e8e:0:b0:580:fb8e:3044 with SMTP id c136-20020a624e8e000000b00580fb8e3044mr43420417pfb.22.1674865026877;
        Fri, 27 Jan 2023 16:17:06 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id br13-20020a056a00440d00b00581ad007a9fsm3154791pfb.153.2023.01.27.16.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:06 -0800 (PST)
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
Subject: [PATCH 08/30] sched: Expose css_tg(), __setscheduler_prio() and SCHED_CHANGE_BLOCK()
Date:   Fri, 27 Jan 2023 14:16:17 -1000
Message-Id: <20230128001639.3510083-9-tj@kernel.org>
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
---
 kernel/sched/core.c  | 47 +++----------------------------------------
 kernel/sched/sched.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 70698725f6de..1fd4e2cde35c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2094,15 +2094,7 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
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
@@ -2127,7 +2119,7 @@ sched_change_guard_init(struct rq *rq, struct task_struct *p, int flags)
 	return cg;
 }
 
-static void sched_change_guard_fini(struct sched_change_guard *cg, int flags)
+void sched_change_guard_fini(struct sched_change_guard *cg, int flags)
 {
 	if (cg->queued)
 		enqueue_task(cg->rq, cg->p, flags | ENQUEUE_NOCLOCK);
@@ -2136,34 +2128,6 @@ static void sched_change_guard_fini(struct sched_change_guard *cg, int flags)
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
@@ -6949,7 +6913,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-static void __setscheduler_prio(struct task_struct *p, int prio)
+void __setscheduler_prio(struct task_struct *p, int prio)
 {
 	if (dl_prio(prio))
 		p->sched_class = &dl_sched_class;
@@ -10340,11 +10304,6 @@ void sched_move_task(struct task_struct *tsk)
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
index 946fdb51b6e6..1927adc6c4bb 100644
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
@@ -493,6 +498,8 @@ extern long sched_group_rt_runtime(struct task_group *tg);
 extern long sched_group_rt_period(struct task_group *tg);
 extern int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk);
 
+extern void __setscheduler_prio(struct task_struct *p, int prio);
+
 extern struct task_group *sched_create_group(struct task_group *parent);
 extern void sched_online_group(struct task_group *tg,
 			       struct task_group *parent);
@@ -2461,6 +2468,47 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
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
2.39.1

