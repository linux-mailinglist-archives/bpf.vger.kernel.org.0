Return-Path: <bpf+bounces-4668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56574E322
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5141C20BF0
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578817E3;
	Tue, 11 Jul 2023 01:14:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8430417D3
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:14:30 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE39E5C;
	Mon, 10 Jul 2023 18:14:27 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a04e5baffcso4221913b6e.3;
        Mon, 10 Jul 2023 18:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038066; x=1691630066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1R3xNYOnmy8Od9NsS0fwbcMtICDjdN2Tr6YXEQ6PAo=;
        b=S4By5e7ChMYkr/EKw23p9jBROrFs3PmA7NriPbCOa4r0y1++wSq7QCb9p33UFV7gOJ
         enA2w+Upm9q26xp8hdooQLg+7f277MjID8zo00r2QMaUewLSK/dNxVSAP5fBJ8OJPVKD
         JQskbx3zIxf9tWfP1zdNT6kv+EUak7XCEzIheXYbN7BbBDi4aoXsmL9wkO3gLslVvufm
         1ss0XkT1F5LbTWX4D4+e/ONJmYb5msscvHgTaHattx4UPDxUkpXbC99pK43qSPSXpp9v
         /mEjcQFrtcFThXCshMsBfat/kKWzAxw+YLK+dpu86cPdTF5oqqtCwxwJy1/7gvWdZ3n4
         v1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038066; x=1691630066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q1R3xNYOnmy8Od9NsS0fwbcMtICDjdN2Tr6YXEQ6PAo=;
        b=BUXDuEXLjxyjyIARek87QseLKWRTt2wVzyoEzZTvOdC4WT1sWM9hJFJTKseg3vu6Zr
         5dwu99GW2B0CVP/jHEp2B6ogVpaLwQqb9jYHNd6hP3Of9RVV2km3ZYjmipr1/66qlEBc
         0rLqC8CU/wi4piW5E8fdNa/xcDTlOmrOtBDUmNTNmYESs9vsJCYfsf7QZ3B0U+jgCkhF
         xwSk6MD7Qw+hXOQ2ztmQ23++WJkV9iLBAUChUaBnPzborpYOFhq+39dQeuGLjfjIgYY/
         kVBc1LBEpuABUlWSAVGoq/LMFEz1g7Ge2yNpEJb2ZAC6ed1NE9X5qMvQv/RjedDdYfkL
         IZIg==
X-Gm-Message-State: ABy/qLYcRwrghMkkujUqX/83+h4KKWB124y4SORboqtwJ3X9S3odPc6N
	65zqN0LF7I/IYRdIoBq9AsQ=
X-Google-Smtp-Source: APBJJlFbWm+O9+mA92Jv0EIq8aAtUa/vi+1ZtlAbl2GcjJ5J/7T7dDhTgW8dlsNsrFEgxeEDIQAJEg==
X-Received: by 2002:a05:6358:9487:b0:134:df5e:4776 with SMTP id i7-20020a056358948700b00134df5e4776mr13539716rwb.24.1689038066108;
        Mon, 10 Jul 2023 18:14:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id l130-20020a633e88000000b0055b5f206ea2sm324419pga.39.2023.07.10.18.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:25 -0700 (PDT)
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
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/34] sched: Add sched_class->switching_to() and expose check_class_changing/changed()
Date: Mon, 10 Jul 2023 15:13:23 -1000
Message-ID: <20230711011412.100319-6-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 kernel/sched/core.c  | 19 ++++++++++++++++---
 kernel/sched/sched.h |  7 +++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a205d00f0669..29f75a31b414 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2178,6 +2178,17 @@ inline int task_curr(const struct task_struct *p)
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
@@ -2185,9 +2196,9 @@ inline int task_curr(const struct task_struct *p)
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
@@ -7140,6 +7151,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	}
 
 	__setscheduler_prio(p, prio);
+	check_class_changing(rq, p, prev_class);
 
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
@@ -7768,6 +7780,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_prio(p, newprio);
 	}
 	__setscheduler_uclamp(p, attr);
+	check_class_changing(rq, p, prev_class);
 
 	if (queued) {
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1a12a0d9ea40..0a25bcd8d9d1 100644
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
@@ -2451,6 +2452,12 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
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
2.41.0


