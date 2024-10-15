Return-Path: <bpf+bounces-41962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E137799DD73
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 07:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E6A01C21C98
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 05:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF3A1779BB;
	Tue, 15 Oct 2024 05:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ttQ1Y10u"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582911684A2
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969718; cv=none; b=d6MOwqY+BzehHvLcrh16RQqGetDDl5eIkJp7aqooPWCfhDy7/aRWrL9OOFiGECITJ55j+pr/Kqw9wKjjkcYffJTy3mPw+poaEYo//SGStkHTeJlmPakuOLT+dajzAehKqlJjaj/g+M1AvT24F5dIF1rAtEICcl4i7gv6tEzEz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969718; c=relaxed/simple;
	bh=woZIcwezUsE6wX6Afbs8PRpZryzSNtwpEz7wJoFXfSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNa2OqR9UuOzBMigzfwN1vbDfN2gC5EbS/EwvyHCaMaWvsgsc+DbSezRhewqH3qMvgKKCqemYbFdhcuRBttXjnZLIBmqlgYE/51TYgEUuAEIpDTOddtRBiqEIMhbuXq2scgl7XCSjGgzQQ7KTcWmawEMJZG5lwrE2z+fL8JjxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ttQ1Y10u; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Oct 2024 07:21:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728969714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qs6jusuhwrvoW+FjDM8QnlgVGy9SBNuKT+Rpjq29JgY=;
	b=ttQ1Y10uFaRLDKcIyr+45IIpuc+5hCyoefgItQPQSSzLLSL7XJwuKZ0huVkNZDCTki5Tr0
	Vt9L2astrve1g+kX8Lt9KKpIbWQ3KTO6yXArWnfUsMNd6G3KXbObbtz1RhY+18D8pPUliN
	VByOXFa1AmC4Pn1pTx8+SabA9lHgv4o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Trigger ops.update_idle() from
 pick_task_idle()
Message-ID: <Zw377f2g1JnIYNSu@gpd3>
References: <20241014220603.35280-1-andrea.righi@linux.dev>
 <Zw3BcEWQQVLxcrOp@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw3BcEWQQVLxcrOp@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Oct 14, 2024 at 03:12:16PM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Oct 15, 2024 at 12:06:03AM +0200, Andrea Righi wrote:
> > @@ -459,13 +459,13 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
> >  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
> >  {
> >  	update_idle_core(rq);
> > -	scx_update_idle(rq, true);
> >  	schedstat_inc(rq->sched_goidle);
> >  	next->se.exec_start = rq_clock_task(rq);
> >  }
> >  
> >  struct task_struct *pick_task_idle(struct rq *rq)
> >  {
> > +	scx_update_idle(rq, true);
> 
> Thanks a lot for debugging this. Both the analysis and solution make sense
> to me. However, as this puts scx_update_idle() in a different place from
> other idle handling functions, can you please add a comment explaining why
> it needs to be in pick_task_idle() instead of set_next_task_idle()?
> 
> Thanks.

Sure, I'll send a v3 with a proper comment.

Thanks,
-Andrea

> 
> -- 
> tejun

