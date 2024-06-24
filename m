Return-Path: <bpf+bounces-32884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F7B91475A
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D316D1F233FF
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09122134415;
	Mon, 24 Jun 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HdBXznvU"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129C40BF5;
	Mon, 24 Jun 2024 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224642; cv=none; b=GcvuWVaDMxJytHHfvh6sOODr5e/FhaeJkNJbEeW+4fYqf7prCo/GfkKURBMEHypDzOWBM766hss4kEWSiuGvR8jQTmU8Ei6D1jgLjRukouU62z98xGLdIT1T9RTH78yFxgWGPCqW/RQryzS7I9KL7oW+bIPj8J6d19qYBL/+L8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224642; c=relaxed/simple;
	bh=kwl9ysTtxwwiYZgCX+ks5Uum+g9453TToB8gi/f8gFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwJYT87ko/jO+G1AzaFnVGYiPWMVrTdnNT8GCxBtlv5FW9LFhht0WH3xMv6JBZ4N9GGdiRw/lgevKLmrIZFUEWVldoABi45NKvwMn0NCqHwlFXWj/3abVjN3Hin/Y5vNFO1J3lWA9ti0FZQ8WdF4vsRHCq3SMnfTunNC9geOY5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HdBXznvU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3YRnYh+NxQ23uQNVs9oU3g3KLYw/QlDiQ65qEUSP4zI=; b=HdBXznvUMDN4SqradOJ6PJrgGe
	Kt1I6iO8Q7dsowfv+7ICoKnXpWwuSb7A0dKfmVd9bENyCbFfFmKFwfc8a7fkcf+jH7jxyud5+YtCq
	UYHdtUq6/5Eg7l5eSnfoP4/b9CXjMqB2KBVEjv4fWKeuCVcn5oUX8he/72Pg0LFA+qPPBfrUuwiY+
	7ixdAqN/Q2+vL6T72v/qB7nwh/XsOrpNHhUOCEoxCOIYc+J9nf17+3H1XMbejjOMMuhVvFDG7fRmR
	+h1zcUGgIbY4x25CMJIc2hGw+Nt/WrywWD61KCF3f3aFvfJr0WgHr3PomiL9pQxzDoDmsRvllHW14
	yQZbO/vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLgrE-00000009wG7-2AGO;
	Mon, 24 Jun 2024 10:23:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B4040300754; Mon, 24 Jun 2024 12:23:31 +0200 (CEST)
Date: Mon, 24 Jun 2024 12:23:31 +0200
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
Subject: Re: [PATCH 04/39] sched: Add sched_class->reweight_task()
Message-ID: <20240624102331.GI31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-5-tj@kernel.org>

On Wed, May 01, 2024 at 05:09:39AM -1000, Tejun Heo wrote:
> Currently, during a task weight change, sched core directly calls
> reweight_task() defined in fair.c if @p is on CFS. Let's make it a proper
> sched_class operation instead. CFS's reweight_task() is renamed to
> reweight_task_fair() and now called through sched_class.
> 
> While it turns a direct call into an indirect one, set_load_weight() isn't
> called from a hot path and this change shouldn't cause any noticeable
> difference. This will be used to implement reweight_task for a new BPF
> extensible sched_class so that it can keep its cached task weight
> up-to-date.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Acked-by: Josh Don <joshdon@google.com>
> Acked-by: Hao Luo <haoluo@google.com>
> Acked-by: Barret Rhoden <brho@google.com>
> ---
>  kernel/sched/core.c  | 4 ++--
>  kernel/sched/fair.c  | 3 ++-
>  kernel/sched/sched.h | 4 ++--
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b12b1b7405fd..4b9cb2228b04 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1342,8 +1342,8 @@ static void set_load_weight(struct task_struct *p, bool update_load)
>  	 * SCHED_OTHER tasks have to update their load when changing their
>  	 * weight
>  	 */
> -	if (update_load && p->sched_class == &fair_sched_class) {
> -		reweight_task(p, prio);
> +	if (update_load && p->sched_class->reweight_task) {
> +		p->sched_class->reweight_task(task_rq(p), p, prio);
>  	} else {
>  		load->weight = scale_load(sched_prio_to_weight[prio]);
>  		load->inv_weight = sched_prio_to_wmult[prio];

This reminds me, I think we have a bug here...

  https://lkml.kernel.org/r/20240422094157.GA34453@noisy.programming.kicks-ass.net

I *think* we want something like the below, hmm?


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..32a40d85c0b1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1328,15 +1328,15 @@ int tg_nop(struct task_group *tg, void *data)
 void set_load_weight(struct task_struct *p, bool update_load)
 {
 	int prio = p->static_prio - MAX_RT_PRIO;
-	struct load_weight *load = &p->se.load;
+	unsigned long weight;
+	u32 inv_weight;
 
-	/*
-	 * SCHED_IDLE tasks get minimal weight:
-	 */
 	if (task_has_idle_policy(p)) {
-		load->weight = scale_load(WEIGHT_IDLEPRIO);
-		load->inv_weight = WMULT_IDLEPRIO;
-		return;
+		weight = scale_load(WEIGHT_IDLEPRIO);
+		inv_weight = WMULT_IDLEPRIO;
+	} else {
+		weight = scale_load(sched_prio_to_weight[prio]);
+		inv_weight = sched_prio_to_wmult[prio];
 	}
 
 	/*
@@ -1344,10 +1344,11 @@ void set_load_weight(struct task_struct *p, bool update_load)
 	 * weight
 	 */
 	if (update_load && p->sched_class == &fair_sched_class) {
-		reweight_task(p, prio);
+		reweight_task(p, weight, inv_weight);
 	} else {
-		load->weight = scale_load(sched_prio_to_weight[prio]);
-		load->inv_weight = sched_prio_to_wmult[prio];
+		struct load_weight *lw = &p->se.load;
+		lw->weight = weight;
+		lw->inv_weight = inv_weight;
 	}
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..07398042e342 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3835,7 +3835,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 }
 
-void reweight_task(struct task_struct *p, int prio)
+void reweight_task(struct task_struct *p, unsigned long weight, u32 inv_weight)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62fd8bc6fd08..c1d07957e38a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2509,7 +2509,7 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
+extern void reweight_task(struct task_struct *p, unsigned long weight, u32 inv_weight);
 
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);

