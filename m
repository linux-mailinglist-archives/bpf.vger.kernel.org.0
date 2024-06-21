Return-Path: <bpf+bounces-32747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77876912BE6
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678A51C277CB
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38D61667CF;
	Fri, 21 Jun 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccTmi/2A"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E11662F6
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988836; cv=none; b=FYTiMOdatIAiZIRuzvO1lma8+MYJMndBzvv4Z6tln0JzmUKTk0ETxJnXcw336j4oSMbyOqTYfVmZeBKzb12SR7r0cPyn97W7g4wkKyBqN14OkLTlrnSHeEr3+wgB+VIZu/yZmsWWVhOmzU5Q9jvpbVPhA2Je8lvK4LPUa55t0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988836; c=relaxed/simple;
	bh=ZlSwBMzBHxWlNWqUuyqs5XqfDTQcYh+6+TrNc2i2/yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXt8s2fC7QSc88sY0fXtsOz3PWRHCmuZjDsHNNUE1tvOZSrowHbJvkl08EqwX1KpTfsNfCzzoKFfBid9RDi/7K4kLbgD2omS8WBbhJ5aTkUo/gWYBAz3l0nHaiRDcbrB2Np/7+STNwhHZZusgw+dxbAPIJGUxEVXEXzXaWLK3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccTmi/2A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718988833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98J4OC312FGkaowbYujp5y890n377gkjQxs8ni0Mxpk=;
	b=ccTmi/2APyUWenhNxIimy+dhTCcliajowVVrs9jadzMwpVrgUCIfW6rkW92uh6mMBNQpv8
	eO1wPSifzzYppcBc9yxVVR4y/fCJzJgLPpIG045LGqkbOQgEVyDO4fDaHiSSQ/4rIrAaQj
	kaY4nUzIc/nEDRlEVybkcqJ03BJHCtY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-iW8OVxfZPCiS8LTj9Vh5vQ-1; Fri,
 21 Jun 2024 12:53:49 -0400
X-MC-Unique: iW8OVxfZPCiS8LTj9Vh5vQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA93D1955DC9;
	Fri, 21 Jun 2024 16:53:44 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.9.79])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F4C23000218;
	Fri, 21 Jun 2024 16:53:30 +0000 (UTC)
Date: Fri, 21 Jun 2024 12:53:27 -0400
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 04/30] sched: Add sched_class->switching_to() and expose
 check_class_changing/changed()
Message-ID: <20240621165327.GA51310@lorien.usersys.redhat.com>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618212056.2833381-5-tj@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jun 18, 2024 at 11:17:19AM -1000 Tejun Heo wrote:
> When a task switches to a new sched_class, the prev and new classes are
> notified through ->switched_from() and ->switched_to(), respectively, after
> the switching is done.
> 
> A new BPF extensible sched_class will have callbacks that allow the BPF
> scheduler to keep track of relevant task states (like priority and cpumask).
> Those callbacks aren't called while a task is on a different sched_class.
> When a task comes back, we wanna tell the BPF progs the up-to-date state

"wanna" ?   How about "want to"?

That makes me wanna stop reading right there... :)


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
> v3: Refreshed on top of tip:sched/core.
> 
> v2: Improve patch description w/ details on planned use.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Acked-by: Josh Don <joshdon@google.com>
> Acked-by: Hao Luo <haoluo@google.com>
> Acked-by: Barret Rhoden <brho@google.com>
> ---
>  kernel/sched/core.c     | 12 ++++++++++++
>  kernel/sched/sched.h    |  3 +++
>  kernel/sched/syscalls.c |  1 +
>  3 files changed, 16 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 48f9d00d0666..b088fbeaf26d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2035,6 +2035,17 @@ inline int task_curr(const struct task_struct *p)
>  	return cpu_curr(task_cpu(p)) == p;
>  }
>  
> +/*
> + * ->switching_to() is called with the pi_lock and rq_lock held and must not
> + * mess with locking.
> + */
> +void check_class_changing(struct rq *rq, struct task_struct *p,
> +			  const struct sched_class *prev_class)
> +{
> +	if (prev_class != p->sched_class && p->sched_class->switching_to)
> +		p->sched_class->switching_to(rq, p);
> +}

Does this really need wrapper? The compiler may help but it doesn't seem to
but you're doing a function call and passing in prev_class just to do a
simple check.  I guess it's not really a fast path. Just seemed like overkill.

I guess I did read past the commit message ...


Cheers,
Phil



> +
>  /*
>   * switched_from, switched_to and prio_changed must _NOT_ drop rq->lock,
>   * use the balance_callback list if you want balancing.
> @@ -7021,6 +7032,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>  	}
>  
>  	__setscheduler_prio(p, prio);
> +	check_class_changing(rq, p, prev_class);
>  
>  	if (queued)
>  		enqueue_task(rq, p, queue_flag);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a2399ccf259a..0ed4271cedf5 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2322,6 +2322,7 @@ struct sched_class {
>  	 * cannot assume the switched_from/switched_to pair is serialized by
>  	 * rq->lock. They are however serialized by p->pi_lock.
>  	 */
> +	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
>  	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
>  	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
>  	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
> @@ -3608,6 +3609,8 @@ extern void set_load_weight(struct task_struct *p, bool update_load);
>  extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
>  extern void dequeue_task(struct rq *rq, struct task_struct *p, int flags);
>  
> +extern void check_class_changing(struct rq *rq, struct task_struct *p,
> +				 const struct sched_class *prev_class);
>  extern void check_class_changed(struct rq *rq, struct task_struct *p,
>  				const struct sched_class *prev_class,
>  				int oldprio);
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index ae1b42775ef9..cf189bc3dd18 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -797,6 +797,7 @@ int __sched_setscheduler(struct task_struct *p,
>  		__setscheduler_prio(p, newprio);
>  	}
>  	__setscheduler_uclamp(p, attr);
> +	check_class_changing(rq, p, prev_class);
>  
>  	if (queued) {
>  		/*
> -- 
> 2.45.2
> 
> 

-- 


