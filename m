Return-Path: <bpf+bounces-71838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 578C4BFDDEE
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBAFC342830
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 18:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696BF34C81B;
	Wed, 22 Oct 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BStiLw+O"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B8336ECD;
	Wed, 22 Oct 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158272; cv=none; b=rZDYDE3AdM6IZ6QdLTJWMs+hZ/XSQ7pt3M82pSVVAg3h+GXS8baPChaCA8O64IbnDEHMrRoTlkxZkpMQb01ighbnKz84IarZ77tXRIkSqgZPt+yH91hlB9nnpittgrGwkaWrUngsPgKUrOz2ZuIEsCuMQ91+WHLaCa3DMra7WgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158272; c=relaxed/simple;
	bh=0vJzsc2xBFAt13a48rK9JJhVT0Bscacy1fZCkHXSbTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvPePoWcZw2w//NfuKLh9btYzg1FwfYJ3Yuy3Km6zRXLIhg5NbgvDGGHyTKHp0WRiXtmOXCwCoWr90lcYcAmPFAq64Drg17zLer9wzuPZ9fukXmrV0vMCQtg/ss7tiRHeWTu8BXyfgv8eUgRLB7HADHbL3GpKO45bPiEPtDEzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BStiLw+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C21C4CEE7;
	Wed, 22 Oct 2025 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761158271;
	bh=0vJzsc2xBFAt13a48rK9JJhVT0Bscacy1fZCkHXSbTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BStiLw+OHIomPTGTOilKZVIK64ctdu3AHyIySpOFjknrh5QHBpELJOY5P2RQGpTzm
	 0qoouXmAQK/unJK/l7+KPqdID7UZSJuWKKfOkVRmcrp3AuuGGSNshcaeIpcHHPXla8
	 p7jeNPg6oo2c8ZR+WERDQ9ao3x3jC6NRYaiehz3aYDwXX7aqVbnyPVtRE1fAXJvTgG
	 g3/0p3ByZgfMLRl6/VwVgoHPsknNWyl6ztMmDKKNxF/58CvaKrmjYHRpkt4K1J7hYe
	 hcA8Rs0OKwTXweqYalPxxGqZ3Oms408O0S6VynfrdHRp0pH3vjamoIdEN4LXiKzbHR
	 Ec9e01u2kWy6g==
Date: Wed, 22 Oct 2025 08:37:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: sched_ext: Fix SCX_KICK_WAIT to work reliably
Message-ID: <aPkkftTJndFx1CEy@slm.duckdns.org>
References: <20251021210354.89570-1-tj@kernel.org>
 <20251021210354.89570-3-tj@kernel.org>
 <aPiLHWVf0Vp1qUzV@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPiLHWVf0Vp1qUzV@gpd4>

Hello, Andrea.

On Wed, Oct 22, 2025 at 09:43:25AM +0200, Andrea Righi wrote:
> > @@ -5208,12 +5214,11 @@ static void kick_cpus_irq_workfn(struct
> >  
> >  		if (cpu != cpu_of(this_rq)) {
> 
> It's probably fine anyway, but should we check for cpu_online(cpu) here?

This block gets activated iff kick_one_cpu() returns true and that is gated
by the CPU being online && the current task being on SCX. For the CPU to go
offline, that task has to go off CPU and thus increment the sequence
counter.

> >  			while (smp_load_acquire(wait_pnt_seq) == pseqs[cpu])
> >  				cpu_relax();
> 
> I'm wondering if we can break the semantic if cpu_rq(cpu)->curr->scx.slice
> is refilled concurrently between kick_one_cpu() and this busy wait. In this
> case we return, because wait_pnt_seq is incremented, but we keep running
> the same task.
> 
> Should we introduce a flag (or something similar) to force the re-enqueue
> of the prev task in this case?

Ah, right, that's a hole. There's another hole. The BPF scheduler can choose
to run the same task and put_prev_task_scx() won't be called. I think we
need to bump the seq count on entry to pick_task_scx() too. That should
solve both problems. All that we're guaranteeing is that we wait until the
task enters scheduling path. If a higher class task gets picked,
put_prev_task_scx() will be called. Otherwise, we break the wait when
pick_task_scx() is entered.

Thanks.

-- 
tejun

