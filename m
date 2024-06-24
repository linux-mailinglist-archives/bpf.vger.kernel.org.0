Return-Path: <bpf+bounces-32885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521D9914786
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 12:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22B31F22F0A
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 10:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABBB1369BE;
	Mon, 24 Jun 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SuU3V/hR"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E48125D6;
	Mon, 24 Jun 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719225077; cv=none; b=aIDZZd91J8OqQDvyOgga/X+A3zUgNTyYao07Qn5EmBKieFUyHkGESsaJiEIBXrrqhjFzobxytvLvbAZpcamc+CjIq74k8k8Kt2+AjQDJ0mdTQyL4V4zfL2RzudHJvZLpXO43N3ygDPAGriWmg0K/Pc0+2YJ9iuVAbYnSOsD+Yjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719225077; c=relaxed/simple;
	bh=CDWFY1Wz7kzf19AoUpVvr5v5uDGjfVMWWzLGMU1WwME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cjna7V2RxEx+vDbXKNILt6m7Bzob5YVnjwLqT+2Ke9FudT2BsDOUMewLf2iMOMDi06NDqV5tQZFG6+h+R4UPyrh+1RNKexljFKWSXoMsWgum65MyvIw/i5btukJENGnXXTwCGxPlLW1gX8Ekv9eFJvbRItUWFgonPiLI+VJa6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SuU3V/hR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YoKVY0EiZ3rdD+1pUxvCrFxI8zi0uETaiNkLU7GA9P4=; b=SuU3V/hRM9iWWxmJ23/GnUItjP
	nh/Q1SotgAvoo3wJpMNHsYZ9TWOgmTH5Mo1uiasxaypkBFfhjKZongGTOJvKniL38n0XKA204tOVJ
	ZTE/dYzeVjp7QzSachbuqALsikJxkVW43Z6BzPeTta/TLqrB7VS25TutzWWIqJ4J8b7lbr9xWIkQ9
	RkyW3Th9viDBhVGkR0sjiccB93GiNQN6GYsyrFTr8Xq+FTtWZ9HRh0yF9jqrMF8P1ABl+biZ02EOe
	//MAZ7XJ6qkc+iGZ+Ak+q63mKDnEcfMXhv7rxoYX7gEI7czOdjK6dAkzOesCJiemFlQFzGqOGoOvW
	80kLeZVg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLgyU-00000009wdA-2Bqr;
	Mon, 24 Jun 2024 10:31:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2C587300754; Mon, 24 Jun 2024 12:31:02 +0200 (CEST)
Date: Mon, 24 Jun 2024 12:31:02 +0200
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
Message-ID: <20240624103102.GV12673@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-5-tj@kernel.org>
 <20240624102331.GI31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624102331.GI31592@noisy.programming.kicks-ass.net>

On Mon, Jun 24, 2024 at 12:23:31PM +0200, Peter Zijlstra wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 41b58387023d..07398042e342 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3835,7 +3835,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  	}
>  }
>  
> -void reweight_task(struct task_struct *p, int prio)
> +void reweight_task(struct task_struct *p, unsigned long weight, u32 inv_weight)
>  {
>  	struct sched_entity *se = &p->se;
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);

Lost something in transition...

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..cd9b89e9e944 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3835,15 +3835,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 }
 
-void reweight_task(struct task_struct *p, int prio)
+void reweight_task(struct task_struct *p, unsigned long weight, u32 inv_weight)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct load_weight *load = &se->load;
-	unsigned long weight = scale_load(sched_prio_to_weight[prio]);
 
 	reweight_entity(cfs_rq, se, weight);
-	load->inv_weight = sched_prio_to_wmult[prio];
+	load->inv_weight = inv_weight;
 }
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);

