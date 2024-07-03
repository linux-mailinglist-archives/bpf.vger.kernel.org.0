Return-Path: <bpf+bounces-33822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C8F926B0D
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6126FB226F7
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A118191F9E;
	Wed,  3 Jul 2024 21:57:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF401E49F;
	Wed,  3 Jul 2024 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043877; cv=none; b=NSRM1MxSSb9uUuslaAiEGHZkMYBJ8oH8oJQfF07DUoVWZP+O4o8pyMdJnyp/sEJoWEp186kivlc4x1xj3vTcwyFCjAQo+nztBPV4pw8yqFOBFwCKbsoINEisdoNl0okdrPK9yhPe/JU43OSPTbWzfYyXz1buAOxkm+ZGWJqm99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043877; c=relaxed/simple;
	bh=cFamejzPbTUJqhVtYHKVSrJ25Uc967XiW5wbLJ8xK68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbpzwA5I3Fvj9eeyBxygp8AEl+mdlB3g20BlKMxInQXKv326A/HPFje3Gr9xbpHIlBrZtmFmDU2wybj9lHZRLQjH9NMmNlurtjeo1B5OGs1ZUbYtZ7KlGJQKnjBiayyqfU+fwYukUKGVwNXURBkU64SPTTfku9YDcawnIV2MMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF3EC2BD10;
	Wed,  3 Jul 2024 21:57:55 +0000 (UTC)
Date: Wed, 3 Jul 2024 17:57:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org, oleg@redhat.com,
 mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, clm@meta.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] uprobes: add batched register/unregister APIs
 and per-CPU RW semaphore
Message-ID: <20240703175754.4c6a7bf1@rorschach.local.home>
In-Reply-To: <20240703075057.GK11386@noisy.programming.kicks-ass.net>
References: <20240701223935.3783951-1-andrii@kernel.org>
	<20240702102353.GG11386@noisy.programming.kicks-ass.net>
	<20240702115447.GA28838@noisy.programming.kicks-ass.net>
	<CAEf4BzaQUzQdba2=F2NoV7=Th98fxz2EN62QX2Ej92bazt1GAg@mail.gmail.com>
	<20240702191857.GJ11386@noisy.programming.kicks-ass.net>
	<fd1d8b71-2a42-4649-b7ba-1b2e88028a20@paulmck-laptop>
	<20240703075057.GK11386@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 09:50:57 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > However, in the past, the memory-barrier and array-indexing overhead
> > of SRCU has made it a no-go for lightweight probes into fastpath code.
> > And these cases were what motivated RCU Tasks Trace (as opposed to RCU
> > Tasks Rude).  
> 
> I'm thinking we're growing too many RCU flavours again :/ I suppose I'll
> have to go read up on rcu/tasks.* and see what's what.

This RCU flavor is the one to handle trampolines. If the trampoline
never voluntarily schedules, then the quiescent state is a voluntary
schedule. The issue with trampolines is that if something was preempted
as it was jumping to a trampoline, there's no way to know when it is
safe to free that trampoline, as some preempted task's next instruction
is on that trampoline.

Any trampoline that does not voluntary schedule can use RCU task
synchronization. As it will wait till all tasks have voluntarily
scheduled or have entered user space (IIRC, Paul can correct me if I'm
wrong).

Now, if a trampoline does schedule, it would need to incorporate some
ref counting on the trampoline to handle the scheduling, but could
still use RCU task synchronization up to the point of the ref count.

And yes, the rude flavor was to handle the !rcu_is_watching case, and
can now be removed.

-- Steve

