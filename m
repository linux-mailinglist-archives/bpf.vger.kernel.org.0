Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5676D6BF472
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjCQViZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjCQVhV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:37:21 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C7438460;
        Fri, 17 Mar 2023 14:36:16 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso6625400pjb.3;
        Fri, 17 Mar 2023 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5RYcwx9iQWgNlT0187t5NhcGeh1nY2e8DTY6uu1F9k=;
        b=KnGUtjGld2eavhY0nV7HDE35mBtuIWhB1vCYI+6hUw1whbxTqlRP/HVJmAOtjw7CGZ
         XoWk5NzaCey8siqObwBHeMVno3GGcGi4CAK+QwrlQst1f1lHFnfGtNV383iJH3S8jmeM
         p/JpSju7bNUUNqbMjhRbUYxugQ0mWk4TW5zXlXu5WhpH/p3OekuAk9x8Bw+QcSmWddi8
         /TjOVylJKCiOFluMtlAJTnWsYQOxInqnnu29NpvVD51xajyLUdR5rdnPgwWmJ8ErCinV
         LEW1km3yY39wF2LwyETTG6c7BpVXOpcOBXrwh/zG72JYDv+a2mPrAmTcBll5NQdZmh6o
         E8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a5RYcwx9iQWgNlT0187t5NhcGeh1nY2e8DTY6uu1F9k=;
        b=bkcBxNzV9NpkmovC9yQaYi0l6l2WdL1aj5UV9qmvgHjAqGADwA9GPOXu87HGR47432
         LzczaxUyFatvBRewvjkxDeIDjZKZiC0ikOQ7eEODLsyzCXRhNS+xzb3m59Syy6P0+OOV
         V1D0SnWAz14wG1ve2i2wXSRmMW6G+b6IfuK/3yrctqKWk077rxMNK7VFIl5l24/JZbZL
         ROR2sqnYJH4lGhsnHtEY9/7PfZOgIswd+PQGFgbdfx24DpdNSNhTIdpat4nDQo54rYMv
         hUfoxinoaR7F3Y+B3qe0TYPM5b2inxVi29b1oPYe9q1v7cKWyI65psZnBxcKSM9KwwLx
         3LwA==
X-Gm-Message-State: AO0yUKVQZYnmUm6Fu4cOX0pQtOajlu5+7qwmscov1k5mzGa+SK3isIlP
        Ir5cBQ6XasRdzlabYCD5dJMIEfdtz+A=
X-Google-Smtp-Source: AK7set+wYKqTu+UvkEUiB9+iJeVt9Zmjl0xO6rrvXVzbme08VsjclTAvv6X8kLE73mZ0QWmebCrPWg==
X-Received: by 2002:a17:90b:1b4c:b0:23d:2532:ae34 with SMTP id nv12-20020a17090b1b4c00b0023d2532ae34mr4736986pjb.2.1679088833872;
        Fri, 17 Mar 2023 14:33:53 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id fa23-20020a17090af0d700b00231227781d5sm5560031pjb.2.2023.03.17.14.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:33:53 -0700 (PDT)
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
Subject: [PATCH 06/32] sched: Add sched_class->switching_to() and expose check_class_changing/changed()
Date:   Fri, 17 Mar 2023 11:33:07 -1000
Message-Id: <20230317213333.2174969-7-tj@kernel.org>
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

When a task switches to a new sched_class, the prev and new classes are
notified through ->switched_from() and ->switched_to(), respectively, after
the switching is done.

A new BPF extensible sched_class will have callbacks that allow the BPF
scheduler to keep track of relevant task states (like priority and cpumask).
Those callbacks aren't called while a task is on a different sched_class.
When a task comes back, we wanna tell the BPF progs the up-to-date state
before the task gets enqueued, so we need a hook which is called before the
switching is committed.

This patch adds ->switching_to() which is called during sched_class switch
through check_class_changing() before the task is restored. Also, this patch
exposes check_class_changing/changed() in kernel/sched/sched.h. They will be
used by the new BPF extensible sched_class to implement implicit sched_class
switching which is used e.g. when falling back to CFS when the BPF scheduler
fails or unloads.

This is a prep patch and doesn't cause any behavior changes. The new
operation and exposed functions aren't used yet.

v2: Improve patch description w/ details on planned use.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 20 +++++++++++++++++---
 kernel/sched/sched.h |  7 +++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5a6f4884384e..a378e8e09061 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2223,6 +2223,17 @@ inline int task_curr(const struct task_struct *p)
 	return cpu_curr(task_cpu(p)) == p;
 }
 
+/*
+ * ->switching_to() is called with the pi_lock and rq_lock held and must not
+ * mess with locking.
+ */
+void check_class_changing(struct rq *rq, struct task_struct *p,
+			  const struct sched_class *prev_class)
+{
+	if (prev_class != p->sched_class && p->sched_class->switching_to)
+		p->sched_class->switching_to(rq, p);
+}
+
 /*
  * switched_from, switched_to and prio_changed must _NOT_ drop rq->lock,
  * use the balance_callback list if you want balancing.
@@ -2230,9 +2241,9 @@ inline int task_curr(const struct task_struct *p)
  * this means any call to check_class_changed() must be followed by a call to
  * balance_callback().
  */
-static inline void check_class_changed(struct rq *rq, struct task_struct *p,
-				       const struct sched_class *prev_class,
-				       int oldprio)
+void check_class_changed(struct rq *rq, struct task_struct *p,
+			 const struct sched_class *prev_class,
+			 int oldprio)
 {
 	if (prev_class != p->sched_class) {
 		if (prev_class->switched_from)
@@ -7139,6 +7150,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		}
 
 		__setscheduler_prio(p, prio);
+		check_class_changing(rq, p, prev_class);
 	}
 
 	check_class_changed(rq, p, prev_class, oldprio);
@@ -7748,6 +7760,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		}
 		__setscheduler_uclamp(p, attr);
 
+		check_class_changing(rq, p, prev_class);
+
 		/*
 		 * We enqueue to tail when the priority of a task is
 		 * increased (user space view).
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7934b597053d..1545779c5db8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2211,6 +2211,7 @@ struct sched_class {
 	 * cannot assume the switched_from/switched_to pair is serialized by
 	 * rq->lock. They are however serialized by p->pi_lock.
 	 */
+	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
@@ -2447,6 +2448,12 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
+extern void check_class_changing(struct rq *rq, struct task_struct *p,
+				 const struct sched_class *prev_class);
+extern void check_class_changed(struct rq *rq, struct task_struct *p,
+				const struct sched_class *prev_class,
+				int oldprio);
+
 extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 
 #ifdef CONFIG_PREEMPT_RT
-- 
2.39.2

