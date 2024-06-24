Return-Path: <bpf+bounces-32887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F6691480E
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32EA1C21ED2
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8674137901;
	Mon, 24 Jun 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UjlAMUwh"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CF137753;
	Mon, 24 Jun 2024 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227307; cv=none; b=A3nmsVtYd/d3cVxhSdN2y8eKy1alKUWC4FNEYKGG52MiAeEWrpuC9AtSAXZLVVGab+7BKu38grxfzdGrO//E6BYhsnVh69RmldEhfcJBRcpepZfeUtta8YnXyeZVdRZvKpFK0cw53HyGM80wy4PKLGb1QOZEt19I7uGG3cbRhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227307; c=relaxed/simple;
	bh=Xa52x9ju8kZ0ATQQyiPw1QGg5UNV8SVxaBJmxKI3g6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9szSxfoBvx18hz8lXsbDJ+eLNNBdquYhAjqJoardUdtGqzhMQdQAvy8/IFOllU6kMhB5GzMXhccwSa8cAQ70Cvq8TGDiYaAwZW8aGqBJ8rY9JZfyTy9s7ZKFcL1eG1Ub59usoeZBLd5uiocxPG4ov2Wt9Ddd8mDnVz588fD6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UjlAMUwh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IgHBmS9mm72gkhi4cETlocuOHSRdb4UBX7HvQNJvhx4=; b=UjlAMUwhJ2VF5EjiKB+POt6thX
	L16QAvno7ML/B02SZtfH/L0KDReRQX2ClibVR2kJBlEmVbgMWOEMfT9aQgvdkFNnIVDa6Osn5Mo1v
	Qsp2aGMauN2DMK/R6UTLK1Zq6QvIm5ZwfDvWICCqBhF1IkWgnYFA5TM9/DsH2kg6w50hyFdolgiCY
	HIMdfVZwucUyFwpsIWMiQ6ikBEk+ZltEsAx5jb//VhUKDQyhFyxVBBk5VPHqNNo/S3pGe5zR5KDas
	KBIm0zgww71lxhzsSrUGI4cHlfixSMHflSWbh8knsJd7ZXxTo5W7WcAEI2IEH3buJ593a1m8ubn86
	rc5UJSBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLhWk-00000008EDj-3etW;
	Mon, 24 Jun 2024 11:06:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0E455300754; Mon, 24 Jun 2024 13:06:24 +0200 (CEST)
Date: Mon, 24 Jun 2024 13:06:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 05/39] sched: Add sched_class->switching_to() and expose
 check_class_changing/changed()
Message-ID: <20240624110624.GJ31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-6-tj@kernel.org>

On Wed, May 01, 2024 at 05:09:40AM -1000, Tejun Heo wrote:
> When a task switches to a new sched_class, the prev and new classes are
> notified through ->switched_from() and ->switched_to(), respectively, after
> the switching is done.
> 
> A new BPF extensible sched_class will have callbacks that allow the BPF
> scheduler to keep track of relevant task states (like priority and cpumask).
> Those callbacks aren't called while a task is on a different sched_class.
> When a task comes back, we wanna tell the BPF progs the up-to-date state
> before the task gets enqueued, so we need a hook which is called before the
> switching is committed.
> 
> This patch adds ->switching_to() which is called during sched_class switch
> through check_class_changing() before the task is restored. Also, this patch
> exposes check_class_changing/changed() in kernel/sched/sched.h. They will be
> used by the new BPF extensible sched_class to implement implicit sched_class
> switching which is used e.g. when falling back to CFS when the BPF scheduler
> fails or unloads.
> 
> This is a prep patch and doesn't cause any behavior changes. The new
> operation and exposed functions aren't used yet.
> 
> v2: Improve patch description w/ details on planned use.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Acked-by: Josh Don <joshdon@google.com>
> Acked-by: Hao Luo <haoluo@google.com>
> Acked-by: Barret Rhoden <brho@google.com>

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8e23f19e8096..99e292368d11 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2301,6 +2301,7 @@ struct sched_class {
>  	 * cannot assume the switched_from/switched_to pair is serialized by
>  	 * rq->lock. They are however serialized by p->pi_lock.
>  	 */
> +	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
>  	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
>  	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
>  	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,

So I *think* that I can handle all the current cases in
sched_class::{en,de}queue_task() if we add {EN,DE}QUEUE_CLASS flags.

Would that work for the BPF thing as well?

Something like the very much incomplete below... It would allow removing
all these switch{ed,ing}_{to,from}() things entirely, instead of
adding yet more.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..da54c9f8f78d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6864,15 +6864,22 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-void __setscheduler_prio(struct task_struct *p, int prio)
+struct sched_class *__setscheduler_class(int prio)
 {
+	struct sched_class *class;
+
 	if (dl_prio(prio))
-		p->sched_class = &dl_sched_class;
+		class = &dl_sched_class;
 	else if (rt_prio(prio))
-		p->sched_class = &rt_sched_class;
+		class = &rt_sched_class;
 	else
-		p->sched_class = &fair_sched_class;
+		class = &fair_sched_class;
 
+	return class;
+}
+
+void __setscheduler_prio(struct task_struct *p, int prio)
+{
 	p->prio = prio;
 }
 
@@ -6919,7 +6926,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
 	int prio, oldprio, queued, running, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
-	const struct sched_class *prev_class;
+	const struct sched_class *prev_class, *class;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -6977,6 +6984,10 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		queue_flag &= ~DEQUEUE_MOVE;
 
 	prev_class = p->sched_class;
+	class = __setscheduler_class(prio);
+	if (prev_class != class)
+		queue_flags |= DEQUEUE_CLASS;
+
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 	if (queued)
@@ -7014,6 +7025,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 			p->rt.timeout = 0;
 	}
 
+	p->class = class;
 	__setscheduler_prio(p, prio);
 
 	if (queued)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62fd8bc6fd08..a03995d81c75 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2251,6 +2251,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
 #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
+#define DEQUEUE_CLASS		0x200 /* Matches ENQUEUE_CLASS */
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
@@ -2266,6 +2267,7 @@ extern const u32		sched_prio_to_wmult[40];
 #endif
 #define ENQUEUE_INITIAL		0x80
 #define ENQUEUE_MIGRATING	0x100
+#define ENQUEUE_CLASS		0x200
 
 #define RETRY_TASK		((void *)-1UL)
 
@@ -3603,6 +3605,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 
 extern int __sched_setscheduler(struct task_struct *p, const struct sched_attr *attr, bool user, bool pi);
 extern int __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx);
+extern struct sched_class *__setscheduler_class(int prio);
 extern void __setscheduler_prio(struct task_struct *p, int prio);
 extern void set_load_weight(struct task_struct *p, bool update_load);
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef9..dc104d996204 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -612,7 +612,7 @@ int __sched_setscheduler(struct task_struct *p,
 {
 	int oldpolicy = -1, policy = attr->sched_policy;
 	int retval, oldprio, newprio, queued, running;
-	const struct sched_class *prev_class;
+	const struct sched_class *prev_class, *class;
 	struct balance_callback *head;
 	struct rq_flags rf;
 	int reset_on_fork;
@@ -783,6 +783,12 @@ int __sched_setscheduler(struct task_struct *p,
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
+	class = prev_class = p->sched_class;
+	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS))
+		class = __setscheduler_class(newprio);
+	if (prev_class != class)
+		queue_flags |= DEQUEUE_CLASS;
+
 	queued = task_on_rq_queued(p);
 	running = task_current(rq, p);
 	if (queued)
@@ -790,10 +796,9 @@ int __sched_setscheduler(struct task_struct *p,
 	if (running)
 		put_prev_task(rq, p);
 
-	prev_class = p->sched_class;
-
 	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
 		__setscheduler_params(p, attr);
+		p->class = class;
 		__setscheduler_prio(p, newprio);
 	}
 	__setscheduler_uclamp(p, attr);

