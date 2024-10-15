Return-Path: <bpf+bounces-41974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF14399DF83
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4DA028378E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098F18B468;
	Tue, 15 Oct 2024 07:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xi+tactP"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC2139578;
	Tue, 15 Oct 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978340; cv=none; b=nUnlCeErUtIb88RcTb6PvUmyfWqepWZw8EazshD6yob5zjuzt/h63mLQ+/J0eOURvhHMK1xK3iBciICAIO/cNesrm+yigAJAdOXd7KyGijuAET4zUCfdT3fJcxmXGHRoLW92WmdaCR3+rHVfazsWpVLZ3VrAJQtUK4leSzEfyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978340; c=relaxed/simple;
	bh=qVcs0kJhhRW1riI5poKvzlKD/kZkjfCeZ2kffWNPmnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSvRbbBf+1iifBriYXx2P3Uon9j33meOGCQM1oNnsuQ28VzO9Y/WnNkPwpO8ESQlnqvP+gj0KmfTKED9bwXFXs/h/WwSdPwplDOYCkL799pXCoYlVFMIvR4Q4NIImjFV5/QURwgf8D62czTaBVKPmJieabctC58mCJNTChguNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xi+tactP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uDl9pkQsAejcP+DObQT+ZkdJLsTfQuExHlBqtK3i0Lw=; b=Xi+tactP679leZrVTEZf06myCZ
	Lazhki/vt00kcz2xJkUPsnILgNthufn5TE4c1BNHBiWZtiRsWUaB887np1DomuQDONzr3+1BLJWWe
	fSJexEH9js6viXzfRuASGR6PjFQtNDCQETReSJDYV7Ftz4jzdyybG88mH9YSYmH/2wG6h08Bm8HxV
	6RdA9s7mfJT8RxNuFIxXNDcNbfd9HXZAQoTu0ViwE1Dszl3V4xJ98EEeyzyuM/psLiSJ58eW7Lr20
	ANA47NJD5Sm6MoV48DkmO6Dt9SXHPRdJMgItmQNgg25E3MxzI+f1VtjxZJKWOwcBqVt8jtIzU4eFi
	Ctygb/4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t0cFD-00000006VAb-3tE0;
	Tue, 15 Oct 2024 07:45:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 74835300777; Tue, 15 Oct 2024 09:45:26 +0200 (CEST)
Date: Tue, 15 Oct 2024 09:45:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Trigger ops.update_idle() from
 pick_task_idle()
Message-ID: <20241015074526.GO16066@noisy.programming.kicks-ass.net>
References: <20241014220603.35280-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014220603.35280-1-andrea.righi@linux.dev>

On Tue, Oct 15, 2024 at 12:06:03AM +0200, Andrea Righi wrote:

> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index d2f096bb274c..5a10cbc7e9df 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -459,13 +459,13 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
>  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
>  {
>  	update_idle_core(rq);
> -	scx_update_idle(rq, true);
>  	schedstat_inc(rq->sched_goidle);
>  	next->se.exec_start = rq_clock_task(rq);
>  }
>  
>  struct task_struct *pick_task_idle(struct rq *rq)
>  {
> +	scx_update_idle(rq, true);
>  	return rq->idle;
>  }

Does this do the right thing in the case of core-scheduling doing
pick_task() for force-idle on a remote cpu?

The core-sched case is somewhat special in that the pick can be ignored
-- in which case you're doing a spurious scx_update_idle() call.



