Return-Path: <bpf+bounces-28499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F858BA942
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 10:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D00F281600
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 08:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3126114F115;
	Fri,  3 May 2024 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IK7scVgx"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DF942078;
	Fri,  3 May 2024 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726384; cv=none; b=gUwbWgkBo0v1+DjvP/dN6L+BJF2sHKqVcLKv1QPtc8XU2lwWX2j5VNwFtJFPFvCvtfwhOtShmz109pCUQ44MlLC+Hw5BpeC2ixq5vfrN6BAfoiLwoMentXgtr6UEcJZ7EX2pUvHMtEtOpq9l1JyxR7WUzloSx7kVKLPmX+V2dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726384; c=relaxed/simple;
	bh=tfIsg2m0rTplnSPTjbZcbaofplOQsoByH+XZniAFybY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiPE+WLTrsZfQDmU6AZ940BYYIobb3M+2DLAiNh97DCPLCRsRV+e7X7L+OUu8UoHgI8QIm3px+OIRVMklsDN+dGg2/W0r90F7ZsnIZAyKMMV+IZv6MFR0Fc7qh20ffAt8PnTwI/IZiTlPULQH2nbTo8vrENWe10psi4wcch+EfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IK7scVgx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hMz32PGVzRagLNUVyXc5cqkcVrop94QJdt3HE/Yw+ZQ=; b=IK7scVgxgViuf5ll8PEndwdTJJ
	8VNej+oQcUSk3N4WaIuIm04w4D84WTvu2RRECZt1AiyZWkEompbhdi2HEuzp4cZdaa0FW0RYwDSUw
	w1cudsaYNJQK9MscRomaEEgkEU14UnlozL1mqIhSrHwc7lMH/knwAwTPEYdlcW+e+QESVEvtdDMKE
	M8N85xi54qChXfviTPYACczxgyQ7pvibqJrwrX8RGZdyBgd+pd2V+beGqIIapJGKP4cG41dSdJAMf
	THlfOEEQfAZSZlt5L7A3Zwg1b6ERclkhL4fePFychLCCqmIUTz/y6ahhY0ml1X+MEN8GV7BsNedBC
	1TEpXGbw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2oef-00000000UIt-12Pg;
	Fri, 03 May 2024 08:52:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DD61F309319; Fri,  3 May 2024 10:52:32 +0200 (CEST)
Date: Fri, 3 May 2024 10:52:32 +0200
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
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
Message-ID: <20240503085232.GC30852@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjPnb1vdt80FrksA@slm.duckdns.org>

On Thu, May 02, 2024 at 09:20:15AM -1000, Tejun Heo wrote:
> Hello, Peter.
> 
> On Thu, May 02, 2024 at 10:48:00AM +0200, Peter Zijlstra wrote:
> > Can you please put your efforts and the touted Google collaboration in
> > fixing the existing cgroup mess?
> 
> I suppose you're referring to Rik's flattened hierarchy patchset.
> 
>   https://lore.kernel.org/all/20190822021740.15554-1-riel@surriel.com
> 
> Rik spent a lot of time and energy on it and IIRC one of the reasons why it
> didn't get pushed further was the lack of any enthusiasm or support from the
> upstream community.
> 
> We can resurrect the discussion on that patchset but how is that connected
> to sched_ext? 

I'm absolutely not taking any of this until at the very least the cgroup
situation that's been created is solved. And even then, I fundamentally
believe the approach to be detrimental to the scheduler eco-system.
Witness the metric ton of toy schedulers written for it, that's all
effort not put into improving the existing code.

You guys Google/Facebook got us the cgroup thing, Google did a lot of
the work for cpu-cgroup, and now you Facebook say you can't live with it
because it's too expensive. Yes Rik did put a lot of effort into it, but
Google shot it down. What am I to do?

You Google/Facebook are touting collaboration, collaborate on fixing it.
Instead of re-posting this over and over. After all, your main
motivation for starting this was the cpu-cgroup overhead.

From where I'm sitting, you created a problem (cpu-cgroup) and now
you're creating an even bigger problem as a work-around. Very much not
appreciated.



