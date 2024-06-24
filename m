Return-Path: <bpf+bounces-32888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDCD914861
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF23B1C22275
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C1F13A261;
	Mon, 24 Jun 2024 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bl3CIU+B"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09942130A79;
	Mon, 24 Jun 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227979; cv=none; b=KuX/wIJNJQYN13x7ZidzNq6E5m3fWS5JFOKdr3Lx/MUWF+9VXtXF7/ggVaV0JJ/LtaGGCqSLdtaDDy5RPUjtRB1BAmc7zMwpLXiRBenMEPYgk1sNRUkF2K6MUAXwIhvV6kY0fNBOxkLCZt1C34symP8xts4jkLZxrssWQUQcw/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227979; c=relaxed/simple;
	bh=BpZFPOraAJARwEuZfOOxK+QfMqQ9M8iP5u2zFlhkQGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBlLKshNKG0oi+VI1swNI40u/IAJBoM/OYusAUUaRFN+hxqujxmX2vkJ6x9+eHYUv0+DqKd/Qcl/q//nLFo4n7VDeFn7Nnw15EfIs+kZl5VrAjD3G8Jxyp3uIkBS1RfH/sNx54CV8zCwDopO8XmIsoaiXvNviQ/ZjIfHxBz1W84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bl3CIU+B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FiMplOi81qHnbDtgdQ5aPw5RfrkWwvgPxbnndxJB7DQ=; b=bl3CIU+Bb4dGEcayTo7Dwbfkd6
	o2Xxh9/N36hIU6BZjlOIbQgElBB5F+b7BmSGnlGwSgzZ0+ei6pgg6BrBD3Wybxbwo5OmOutdrR9A1
	SuVmfYz8WpB/7hBxsD2Kfu0TewdHBDMFxI8g0uTSnyEn5fafbOjSA9LVuxzFr3ObWsVN9wUnhMT/U
	zXVZLuNlCWLg4eaEZuEu8qZBxWd7a24NigUZeB5kof11xoKQThylJWf5rmZ2M5USbaIAB2+lS1IdA
	M34ttVL/VIWCoOZcxq6RjGT1LKe6cquE+XajIxlI3U3cG2NkUgg+kFyzclH11p7ODnAFeSJijFgYJ
	NHodGVBQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLhjB-00000009yyQ-3Hcv;
	Mon, 24 Jun 2024 11:19:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FD4F300754; Mon, 24 Jun 2024 13:19:17 +0200 (CEST)
Date: Mon, 24 Jun 2024 13:19:17 +0200
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
	kernel-team@meta.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 07/39] sched: Expose css_tg() and __setscheduler_prio()
Message-ID: <20240624111917.GK31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-8-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-8-tj@kernel.org>

On Wed, May 01, 2024 at 05:09:42AM -1000, Tejun Heo wrote:
> These will be used by a new BPF extensible sched_class.
> 
> css_tg() will be used in the init and exit paths to visit all task_groups by
> walking cgroups.
> 
> __setscheduler_prio() is used to pick the sched_class matching the current
> prio of the task. For the new BPF extensible sched_class, the mapping from
> the task configuration to sched_class isn't static and depends on a few
> factors - e.g. whether the BPF progs implementing the scheduler are loaded
> and in a serviceable state. That mapping logic will be added to
> __setscheduler_prio().
> 
> When the BPF scheduler progs get loaded and unloaded, the mapping changes
> and the new sched_class will walk the tasks applying the new mapping using
> __setscheduler_prio().
> 
> v3: Dropped SCHED_CHANGE_BLOCK() as upstream is adding more generic cleanup
>     mechanism.
> 
> v2: Expose SCHED_CHANGE_BLOCK() too and update the description.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Acked-by: Josh Don <joshdon@google.com>
> Acked-by: Hao Luo <haoluo@google.com>
> Acked-by: Barret Rhoden <brho@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  kernel/sched/core.c  | 7 +------
>  kernel/sched/sched.h | 7 +++++++
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9b60df944263..987209c0e672 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7098,7 +7098,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
>  }
>  EXPORT_SYMBOL(default_wake_function);
>  
> -static void __setscheduler_prio(struct task_struct *p, int prio)
> +void __setscheduler_prio(struct task_struct *p, int prio)
>  {
>  	if (dl_prio(prio))
>  		p->sched_class = &dl_sched_class;

FWIW this conflicts with patches in tip/sched/core, and did so at the
time of posting.

