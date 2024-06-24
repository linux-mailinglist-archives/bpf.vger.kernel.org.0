Return-Path: <bpf+bounces-32890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD89148CB
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183281F2358C
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 11:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3713A876;
	Mon, 24 Jun 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ig59ESpN"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD7139587;
	Mon, 24 Jun 2024 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228753; cv=none; b=K4Af52xKCJCaSB+XYdv0xdiGSS96z+4sfsBnn3BMliVr7yioh2eFWwTSTAh3xWVdu++DF4skysi7Sh0min83hCXEsOUorfPKz9HiSCEf770bCbCJmz15uNPfDK2rCl56akDn4ufs6HmT5fnnEKiTTHOeL2CSIdK3LMPqrzd2yOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228753; c=relaxed/simple;
	bh=dlwoMqqpHTHz0k407tV38a7MEhLtRzKWVCbV8Vy+X0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOT0UxWM0n9vt4wp9opw75xYdklWiqvlQxbFAE0eeNZbBMsr3OV+BUBjIINJ7bcZKYI0a4FLb8jMjcbkCyh3k7pMuTr7aZfgCLAVfFfUa0E8Vvd2ePF7TTuSm9c8hKpgxumGyj0gmgb8HPOWyozADRVPTE983zefcD1mxGEOMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ig59ESpN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vKn3LL9QlCU8yZa5/dSm1QoXS3v3sOjL469QMcp00gg=; b=Ig59ESpNlp/b5PzceBq54c2rmp
	2r7ex5ugtIf15OWYSlPQzDp7cNhYYuruHvgrQF6Df/tnZH6wFK68sK0ynHDYt2MqJeWvTYfvNIfnY
	Nrh3btIkWwYrNm000hVoern/5ZKL63yeKz+R2dbRg3P4G8+Vy4ezqGizK4brdrHPST+zyfhndmDEj
	2bQhnbXYsE1rHEI2oO+jSuMY/R9uqX3/cRnlw0w1NeeIfRXiHMdAs2GPMu0+LHiD0cW8MefkRYZUK
	Qd4ubnpWKvi3wt/0LbBt1jf8aoBT+miRIny5aRx8S7CxN6u/DMhRzTkri6nwdylSDKoZobOr7O5S1
	YTEBjSjA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLhvh-00000009zrl-1sCX;
	Mon, 24 Jun 2024 11:32:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F02BD300754; Mon, 24 Jun 2024 13:32:12 +0200 (CEST)
Date: Mon, 24 Jun 2024 13:32:12 +0200
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
Subject: Re: [PATCH 09/39] sched: Add @reason to
 sched_class->rq_{on|off}line()
Message-ID: <20240624113212.GL31592@noisy.programming.kicks-ass.net>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-10-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501151312.635565-10-tj@kernel.org>

On Wed, May 01, 2024 at 05:09:44AM -1000, Tejun Heo wrote:
> ->rq_{on|off}line are called either during CPU hotplug or cpuset partition
> updates. A planned BPF extensible sched_class wants to tell the BPF
> scheduler progs about CPU hotplug events in a way that's synchronized with
> rq state changes.
> 
> As the BPF scheduler progs aren't necessarily affected by cpuset partition
> updates, we need a way to distinguish the two types of events. Let's add an
> argument to tell them apart.

That would be a bug. Must not be able to ignore partitions.



