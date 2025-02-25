Return-Path: <bpf+bounces-52518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFFDA4440D
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 16:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D08C87A6897
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A463F26B0B8;
	Tue, 25 Feb 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwIcd9sh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231A921ABDD;
	Tue, 25 Feb 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740496437; cv=none; b=A6hz0/LOCHWEqnTh0OZVrXNSgA0y1QwKBN/Y5QpWKe1n4pFS+Ig2BgA+lvi97QImXzi83rXU71PWflIx0zQHBbaqFcQ9PXqIlYBUEQbl128LDJSZIRFkZDKh+KJTxpwOQcG+dAExg4uNCTTtJWFYjqBi+ue6zEM+h+Jy6JAmeSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740496437; c=relaxed/simple;
	bh=a2YZv/1QZDn3VN6AQmlt6Nog70dPk30yV5obHPkUik8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3K6rRWCDUk/GuwcHfatQ7t1a1r9VBKSgF0cMW0ZFW8El2ZyzcEFweKL2hswyMt+lcaD7g+OJ3jOHZvQeMyWVYqiez/+lKb38ttTWILfY0Qa/ztrFYvgYKjISPyBwlHiOxbq/99CUluiUtH8L9Errp0/azVkyTs1BWwMR23m434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwIcd9sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91295C4CEDD;
	Tue, 25 Feb 2025 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740496435;
	bh=a2YZv/1QZDn3VN6AQmlt6Nog70dPk30yV5obHPkUik8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JwIcd9shT229Zf7eHqLfNmMHL93VVQ49C4O2/2FIi3+Mc2/YffA30OMpjpDJLBwTY
	 qQWIsxaRPwJdEQR2zAwmci8W/KWGXInSc/R+5pfH42u9gp5o33THLjG8NNna8a39Y2
	 cvztAGYJJpGRtU6+P4w3EqVR8T25BQwcNJosZJvmQ73v998XHMkIiTWUo7Y0GdFxRY
	 yHruwZorfELM2lQX2ipRQGCilnjzF5M/6Je5F+Sqi7JBoIZJgFldQTWvYBESzbZ6rs
	 255tD60EwQ6dgEqMmdD/SzNs5W+n+pCBW5FcgsU/5tl3p2vs2KAzF9Il+cB2LV/Bvs
	 Py+XHS9W37xyQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B455CE045A; Tue, 25 Feb 2025 07:13:55 -0800 (PST)
Date: Tue, 25 Feb 2025 07:13:55 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	jolsa@kernel.org
Subject: Re: [PATCH v3 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
Message-ID: <04598803-a22b-4663-b79a-4c79de480838@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241024044159.3156646-1-andrii@kernel.org>
 <20241024044159.3156646-3-andrii@kernel.org>
 <20250224-impressive-onyx-boa-36e85d@leitao>
 <CAEf4BzbupJe10k0MROG5iZq6cYu6PRoN3sHhNK=L7eDLOULvNQ@mail.gmail.com>
 <20250225-transparent-bronze-cobra-bafff4@leitao>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225-transparent-bronze-cobra-bafff4@leitao>

On Tue, Feb 25, 2025 at 03:46:53AM -0800, Breno Leitao wrote:
> Hello Andrii,
> 
> On Mon, Feb 24, 2025 at 02:23:51PM -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 24, 2025 at 4:23 AM Breno Leitao <leitao@debian.org> wrote:
> > >
> > > Hello Andrii,
> > >
> > > On Wed, Oct 23, 2024 at 09:41:59PM -0700, Andrii Nakryiko wrote:
> > > >
> > > > +static struct uprobe* hprobe_expire(struct hprobe *hprobe, bool get)
> > > > +{
> > > > +     enum hprobe_state hstate;
> > > > +
> > > > +     /*
> > > > +      * return_instance's hprobe is protected by RCU.
> > > > +      * Underlying uprobe is itself protected from reuse by SRCU.
> > > > +      */
> > > > +     lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
> > >
> > > I am hitting this warning in d082ecbc71e9e ("Linux 6.14-rc4") on
> > > aarch64. I suppose this might happen on x86 as well, but I haven't
> > > tested.
> > >
> > >         WARNING: CPU: 28 PID: 158906 at kernel/events/uprobes.c:768 hprobe_expire (kernel/events/uprobes.c:825)
> > >
> > >         Call trace:
> > >         hprobe_expire (kernel/events/uprobes.c:825) (P)
> > >         uprobe_copy_process (kernel/events/uprobes.c:691 kernel/events/uprobes.c:2103 kernel/events/uprobes.c:2142)
> > >         copy_process (kernel/fork.c:2636)
> > >         kernel_clone (kernel/fork.c:2815)
> > >         __arm64_sys_clone (kernel/fork.c:? kernel/fork.c:2926 kernel/fork.c:2926)
> > >         invoke_syscall (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
> > >         do_el0_svc (arch/arm64/kernel/syscall.c:139 arch/arm64/kernel/syscall.c:151)
> > >         el0_svc (arch/arm64/kernel/entry-common.c:165 arch/arm64/kernel/entry-common.c:178 arch/arm64/kernel/entry-common.c:745)
> > >         el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:797)
> > >         el0t_64_sync (arch/arm64/kernel/entry.S:600)
> > >
> > > I broke down that warning, and the problem is on related to
> > > rcu_read_lock_held(), since RCU read lock does not seem to be held in
> > > this path.
> > >
> > > Reading this code, RCU read lock seems to protect old hprobe, which
> > > doesn't seem so.
> > >
> > > I am wondering if we need to protect it properly, something as:
> > >
> > >         @@ -2089,7 +2092,9 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> > >                                 return -ENOMEM;
> > >
> > >                         /* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
> > >         +               rcu_read_lock();
> > >                         uprobe = hprobe_expire(&o->hprobe, true);
> > >         +               rcu_write_lock();
> > >
> > 
> > I think this is not good enough. rcu_read_lock/unlock should be around
> > the entire for loop, because, technically, that return_instance can be
> > freed before we even get to hprobe_expire.
> 
> re you suggesting that we should use an RCU read lock to protect the
> "traversal" of return_instances? In other words, is it currently being
> traversed unsafely, given that return_instance can be freed at any time?
> 
> > So, just like we have guard(srcu)(&uretprobes_srcu); we should have
> > guard(rcu)();
> > 
> > Except, there is that kmemdup() hidden inside dup_return_instance(),
> > so we can't really do that.
> 
> Right. kmemdup() is using GFP_KERNEL, which might sleep, so, it cannot
> be called using rcu read lock.

There is always SRCU?

							Thanx, Paul

