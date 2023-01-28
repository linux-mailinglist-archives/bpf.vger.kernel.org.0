Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB267F2E3
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjA1ARQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjA1ARN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:17:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F27D981;
        Fri, 27 Jan 2023 16:17:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso9527127pjs.4;
        Fri, 27 Jan 2023 16:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz8WtJpJcNM2R282wYEgyHbfluHq5aIu4Y0bgBQVYB0=;
        b=o/lUjJX4jwOKAgmQuZRpkxVJZIJy4TAponBdxsIIjYFmGELGxNZDavIPVgC+llz1/O
         XgZpEr/Un7kCUaCnQ6RndnRoQwXA6gIUshikb00U9eUNl6YxTslqtKdbpoZx9H4YjQVY
         nnHS768UFgQqFjYTARV1wrrXTRc9wMVGEKQGs9/O1QRUGYwDsLT0zvtAzVePsDRbkIny
         RBoDyw3HeECu43QRbptCqc0DzP23+oIv9U4DbVcbod8vKw8kfjAe6Z7E0sSdh/PU26nm
         pzmV414mb8+0C2vJqQBoJVL1WNzkC45nrnHndpK31Y9khp4N8p0AgQ3CXGYQBYN1DbGj
         ZMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vz8WtJpJcNM2R282wYEgyHbfluHq5aIu4Y0bgBQVYB0=;
        b=SMSc1DJr/Bqx8UquOvW7XDvbicG//27BRUF2doi/KTKuWWxfl2oCrR+dnm9GhvTtf4
         3NEJL9z2eNWxlNffWMj1aWpH9WtLsu8eanBTWRH966xeRwDJ2jwoUxkydQd1Lewgv4sb
         OtinwbNlRkfFoexZblmwUkJAp1PTUymw0iDNl78ZRlbuURMs6NsI6PgsszTOVfB9RbFV
         Y3sk1tNocaW5huYSqFtcifFyyXY1I7UHMZhZcmjTkr60R7gBzC0ENyFeircKvBkQw8ER
         KZUtwZ+VYFq8h8zv9vpzP3AJqvwF0Ws7iAJg2w1a1jJQQ4XGKtVXf7CUX778Jr6L4XAJ
         HEPQ==
X-Gm-Message-State: AFqh2kp39ag7k5/ctv8Zt/SVWDE74Hg92T+brt4Jx1y+vgIUDJkjTqfs
        /CjGKY8NS+tCDhlxPpJwTUk=
X-Google-Smtp-Source: AMrXdXvEz6bN1nYBgS9BQqpQsG8E5P2mIxt21YaOBnceea7QUwDZivIt3IGbGgbugfQmGtuQ6jhSzg==
X-Received: by 2002:a05:6a21:3a96:b0:ad:e5e8:cfe8 with SMTP id zv22-20020a056a213a9600b000ade5e8cfe8mr47195967pzb.48.1674865023391;
        Fri, 27 Jan 2023 16:17:03 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78c0a000000b00582bdaab584sm3202026pfd.81.2023.01.27.16.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:03 -0800 (PST)
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
Subject: [PATCH 06/30] sched: Add sched_class->switching_to() and expose check_class_changing/changed()
Date:   Fri, 27 Jan 2023 14:16:15 -1000
Message-Id: <20230128001639.3510083-7-tj@kernel.org>
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
index ce27ed857975..e6d5374edf58 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2221,6 +2221,17 @@ inline int task_curr(const struct task_struct *p)
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
@@ -2228,9 +2239,9 @@ inline int task_curr(const struct task_struct *p)
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
@@ -7072,6 +7083,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		}
 
 		__setscheduler_prio(p, prio);
+		check_class_changing(rq, p, prev_class);
 	}
 
 	check_class_changed(rq, p, prev_class, oldprio);
@@ -7681,6 +7693,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		}
 		__setscheduler_uclamp(p, attr);
 
+		check_class_changing(rq, p, prev_class);
+
 		/*
 		 * We enqueue to tail when the priority of a task is
 		 * increased (user space view).
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 070603f00470..c083395c5477 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2206,6 +2206,7 @@ struct sched_class {
 	 * cannot assume the switched_from/switched_to pair is serialized by
 	 * rq->lock. They are however serialized by p->pi_lock.
 	 */
+	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
@@ -2442,6 +2443,12 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
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
2.39.1

