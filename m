Return-Path: <bpf+bounces-14825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990EB7E886C
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD262810A4
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EC2569F;
	Sat, 11 Nov 2023 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hooOxgAK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A62538B
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:49:06 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201AB3C15;
	Fri, 10 Nov 2023 18:49:05 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d2fedd836fso1545524a34.1;
        Fri, 10 Nov 2023 18:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670944; x=1700275744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnvceBwEwQIq3CHNvlwGcK1kEYVCGki32oZyHSsxsJ8=;
        b=hooOxgAKhia+HAaGBUOfccSOxoPs8yonOps4gZYhG3j37PVTOp7ADAxou68ZbLRagT
         QpOXNueMpBnA+6Cmga1HWucOy3YkUJt3ke0QwJ+S/qE4sYvaP5axgc/g3tqtB1mKwpaC
         WbXzEQMGEtlJ9RK7bBRS5lKExrULTB9fZtATUfyR9I587ceDHTJafeTyUze3Q6ol6Ejf
         aUZgXbkXIFjtJNkYguRb0U6V85o8xooYnzL0BVLJ20QMeh5bJs6Ui3XCvGalWBIa2hsl
         KIigLpxrEfPUZuQPocnETsFTZKh1CGehrWL3gZGWV528Sqgnv9WPwsCgwqxa/j/TGaD7
         lBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670944; x=1700275744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnvceBwEwQIq3CHNvlwGcK1kEYVCGki32oZyHSsxsJ8=;
        b=L6GUF9qC9VgLWWem0lPH1LrjewmzW7OqXzKrVuufe6mnNAuLRyMMrJJNvTQ2dGtDyM
         kCEsZ2m/hdvHlw9Gbbf5RMFbe054jv2z7k99ZqYFoeyBVGgxwQ8+t0hzGpuenqhbH2VG
         Shg6lycNrAVopJzpRekgyQP04sTsaaYGz1jR5Mvb50JAlDgx67ylkhL0RfSxnicLwDN4
         /AiJ3a1nyBUW1pMaeUPtRK8iR2VXWkD81VZuFdOw7wC+WcFOmbXEkxZONZSP0Nia3uyj
         Fpc7XiCdkqvSmnryb53Z1wUyOZnLJBaPiChbnihjoTfoQVkJGCW2rSSYnSkWH1ICjaWP
         gAuA==
X-Gm-Message-State: AOJu0YzYb8fnUoPkUUIxMol1Yd/Ix+cyFGsYCb1bOJiiJW/MZT0905M/
	rARGv79QkEkJ/3kpIJ9tFNI=
X-Google-Smtp-Source: AGHT+IHOo89qWbgi/0bNNDKlb9QO/jvkXr/fy8hw1fghaE8Iul3mlya+POS++2KB14WDzaPkJLQhHg==
X-Received: by 2002:a9d:7318:0:b0:6d4:80e7:7884 with SMTP id e24-20020a9d7318000000b006d480e77884mr850907otk.1.1699670944023;
        Fri, 10 Nov 2023 18:49:04 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b001b895336435sm357926pli.21.2023.11.10.18.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:03 -0800 (PST)
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
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/36] sched: Add sched_class->switching_to() and expose check_class_changing/changed()
Date: Fri, 10 Nov 2023 16:47:31 -1000
Message-ID: <20231111024835.2164816-6-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 09e6ce45e65a..26ad5dc65ede 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2191,6 +2191,17 @@ inline int task_curr(const struct task_struct *p)
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
@@ -2198,9 +2209,9 @@ inline int task_curr(const struct task_struct *p)
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
@@ -7193,6 +7204,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	}
 
 	__setscheduler_prio(p, prio);
+	check_class_changing(rq, p, prev_class);
 
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
@@ -7852,6 +7864,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_prio(p, newprio);
 	}
 	__setscheduler_uclamp(p, attr);
+	check_class_changing(rq, p, prev_class);
 
 	if (queued) {
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a66b48bc45ba..bfe7303559f1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2257,6 +2257,7 @@ struct sched_class {
 	 * cannot assume the switched_from/switched_to pair is serialized by
 	 * rq->lock. They are however serialized by p->pi_lock.
 	 */
+	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
@@ -2497,6 +2498,12 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
+extern void check_class_changing(struct rq *rq, struct task_struct *p,
+				 const struct sched_class *prev_class);
+extern void check_class_changed(struct rq *rq, struct task_struct *p,
+				const struct sched_class *prev_class,
+				int oldprio);
+
 extern void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags);
 
 #ifdef CONFIG_PREEMPT_RT
-- 
2.42.0


