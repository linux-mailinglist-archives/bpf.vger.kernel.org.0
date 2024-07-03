Return-Path: <bpf+bounces-33824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5463926B3C
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6AD28148A
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D564187567;
	Wed,  3 Jul 2024 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJrV/uC6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B418E17995;
	Wed,  3 Jul 2024 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720044422; cv=none; b=akqNO+uO3zYbMN4Ttw805tmHwEqMMt5A1Zt0I/0eSvY/LxY+issPFdfqGbQZ3fU9NhbPQRzHypqa7IwKGhf92bvhhYJHPs3RT3uevvNUhHiYxpPjcycuCBQ8HYqmG4IBPi2onFPyDwPbUaIizMK8NSec7mzwdueZxHqrcPjZXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720044422; c=relaxed/simple;
	bh=pvYZwe6lLH9pgNMzyKDtaoFNpQdZP1M+fnTc6yK0vHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI/QF7QqLEjiBNuX+qubMgrR8pJZN9ujbvsjgO2a19EmGXKM1FFcCcof9WKQoHpN0HR1SmCGxUNoBibgECrTf1qg57vtO0apSv5FhGoxwdFa7GVLNJkk5x2GAugGFFRg1bOr8hbQnt2eCkcbgd5FCWZiCUzegDVhMecfSxRn4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJrV/uC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA2EC4AF0A;
	Wed,  3 Jul 2024 22:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720044422;
	bh=pvYZwe6lLH9pgNMzyKDtaoFNpQdZP1M+fnTc6yK0vHA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WJrV/uC6IPFNn2P0bpCVWvdHo02pjF0T378Q4XXqm6vZXCxK/s2XWxAduWX/8tjD0
	 Edbd9y1k8fXDhPGGsTcTIeYRIJfEs0EQya2LETky/BA56FVgGDvH41KJ3F3yWspbz0
	 hu+MAlO19r4frpCP4KpB/22NEVM1uGYlACf29sgyPHtO5VSIZS5IB2XpZqN3aKVlfN
	 1TuzblKyfmy486xdjlwAnhVwgjW9gv8SOdzRAh3fbYL2jCPrKAjn0N1PsDoqSSIZWt
	 CGjPyaY9u3srJJwe94gPKEanFhJlhzlrWFP/7X3wQT5fQ40l7IQnxboAsX5JcQR3kg
	 E+ZoW9RJ82c5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C7AF8CE0BC3; Wed,  3 Jul 2024 15:07:01 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:07:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
	oleg@redhat.com, mingo@redhat.com, bpf@vger.kernel.org,
	jolsa@kernel.org, clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <4304cf1f-26e8-44c5-9755-bc7c526dcd7b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240701223935.3783951-1-andrii@kernel.org>
 <20240702102353.GG11386@noisy.programming.kicks-ass.net>
 <20240702115447.GA28838@noisy.programming.kicks-ass.net>
 <CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
 <20240702191857.GJ11386@noisy.programming.kicks-ass.net>
 <fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>
 <20240703075057.GK11386@noisy.programming.kicks-ass.net>
 <20240703175754.4c6a7bf1@rorschach.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703175754.4c6a7bf1@rorschach.local.home>

On Wed, Jul 03, 2024 at 05:57:54PM -0400, Steven Rostedt wrote:
> On Wed, 3 Jul 2024 09:50:57 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > However, in the past, the memory-barrier and array-indexing overhead
> > > of SRCU has made it a no-go for lightweight probes into fastpath code.
> > > And these cases were what motivated RCU Tasks Trace (as opposed to RCU
> > > Tasks Rude).  
> > 
> > I'm thinking we're growing too many RCU flavours again :/ I suppose I'll
> > have to go read up on rcu/tasks.* and see what's what.
> 
> This RCU flavor is the one to handle trampolines. If the trampoline
> never voluntarily schedules, then the quiescent state is a voluntary
> schedule. The issue with trampolines is that if something was preempted
> as it was jumping to a trampoline, there's no way to know when it is
> safe to free that trampoline, as some preempted task's next instruction
> is on that trampoline.
> 
> Any trampoline that does not voluntary schedule can use RCU task
> synchronization. As it will wait till all tasks have voluntarily
> scheduled or have entered user space (IIRC, Paul can correct me if I'm
> wrong).

Agreed!

> Now, if a trampoline does schedule, it would need to incorporate some
> ref counting on the trampoline to handle the scheduling, but could
> still use RCU task synchronization up to the point of the ref count.

Or, if the schedule is due at most to a page fault, it can use RCU
Tasks Trace.

> And yes, the rude flavor was to handle the !rcu_is_watching case, and
> can now be removed.

From x86, agreed.

But have the other architectures done all the inlining and addition of
noistr required to permit this?  (Maybe they have, I honestly do not know.
But last I checked a few months ago, ARMv8 was not ready yet.)

							Thanx, Paul

