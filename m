Return-Path: <bpf+bounces-67505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D671B448B8
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 23:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA50567143
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794A02C21DE;
	Thu,  4 Sep 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoqPOz7g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AC265CA2;
	Thu,  4 Sep 2025 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022209; cv=none; b=s3UdVet6K/k22NXuUrLrAfLUPRicqKahPslQT6waLUWThm+aM6WmKZQN5tnIjar5wEzKpfgdtaUl/HKGKafJwuoHzH2+wyvtISLj4qGSAImqDobgpqXIyPSBHT4yHej3O5FLjweqzo6Dvyh8Jxu+cwBc/8kPeboXnXaaklPzrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022209; c=relaxed/simple;
	bh=lmdSHR+sDOzJlQJ5baywCcS7HXdzD4kawscTHt4X3wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLFvw+0561fzkcoy+64KXfOxvhVlR07csMPOFdWCCHqN3jFKNaJ8P7k9uIT09MxmwQALEHVAGJqBStRyQuBmY4UQax66NOfjrKiEMThRtqXU7kzswJrGrOJfv7rC5hp1ITAv6TLB80VdrJTPozBlRGt7l65YtVk5Akh4pLD63SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoqPOz7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C31C4CEF0;
	Thu,  4 Sep 2025 21:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757022208;
	bh=lmdSHR+sDOzJlQJ5baywCcS7HXdzD4kawscTHt4X3wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoqPOz7g2HYlaNz8DnGvkMyTkWfXuvGcMwW4/Oddz8BpTcwExpOfu5Hqkp02rmDfy
	 w6Loeu2TAynPCHd+xnUAs63g01EPCXTYbDfovksnBcTTMlgrj/yFL9Q9RYbwG2PVxy
	 VSqk7lQu5NB6m1l91tVQsmOxJB78zv03yNdePedudim5NPYiKKqD3HC+w/cgiwV9UK
	 p1ZmEAquwkKeDLKVxbQcRyDUGOzmp6UGF8Hmig9xYDIIeDJ/joDfcUTH8aXNaJBgdt
	 smuq1UTtzRr8Rhrl6oHm/J5Q61wULTObDwfwoc7YVcFU6UPp/0IwVjCQyRsepjHnFC
	 aVuSlEgNhRtQw==
Date: Thu, 4 Sep 2025 11:43:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luigi De Matteis <ldematteis123@gmail.com>
Subject: Re: [PATCH 07/16] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aLoH_5TfiTGgQsb0@slm.duckdns.org>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-8-arighi@nvidia.com>
 <aLidEvX41Xie5kwY@slm.duckdns.org>
 <20250903200822.GO4067720@noisy.programming.kicks-ass.net>
 <aLin8VayVsYyKXze@slm.duckdns.org>
 <20250903205646.GR4067720@noisy.programming.kicks-ass.net>
 <20250904202858.GN4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904202858.GN4068168@noisy.programming.kicks-ass.net>

Hello, Peter.

On Thu, Sep 04, 2025 at 10:28:58PM +0200, Peter Zijlstra wrote:
...
>   RUNNABLE:
>   1) hold both source and target rq->lock.
...
> Now, assuming you have a locking order like:
> 
>  p->pi_lock
>    rq->lock
>      dsq->lock
> 
> When you do something like:
> 
>   __schedule()
>     raw_spin_lock(rq->lock);
>     next = pick_next_task() -> pick_task_scx()
>       raw_spin_lock(dsq->lock);
> 
> Then you are, in effect, in the RUNNABLE 1) case above. You hold both
> locks. Nothing is going to move your task around while you hold that
> dsq->lock. That task is on the dsq, anybody else wanting to also do
> anything with that task, will have to first take dsq->lock.
>
> Therefore, at this point, it is perfectly fine to do:
> 
> 	set_task_cpu(cpu_of(rq)); // move task here
> 
> There is no actual concurrency. The only thing there is is
> set_task_cpu() complaining you're not following the rules -- but you
> are, it just doesn't know -- and we can fix that.

I can't convince myself this is safe. For example, when task_rq_lock()
returns, it should guarantee that the rq that the task is currently
associated with is locked and the task can't go anywhere. However, as
task_rq_lock() isn't interlocked with dsq lock, this won't hold true. I
think this will break multiple things subtly - e.g. the assumptions that
task_call_func() makes in the comment wouldn't hold anymore,
task_sched_runtime()'s test of task_on_rq_queued() would be racy, and so on.

ie. Operations protected by deq/enq pair would be fine but anything which is
protected only by task_rq_lock/unlock() would become racy, right?

Thanks.

-- 
tejun

