Return-Path: <bpf+bounces-78554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E396ED12FA8
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E8CA3009FFD
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 14:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3E35CBB4;
	Mon, 12 Jan 2026 14:02:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E5827FD45;
	Mon, 12 Jan 2026 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226539; cv=none; b=NdhiPpsEXptQ8Z63fMr0JvJyEYFzvUPVlu7HR+FmYWgCb+g52t4C2qfcRG8/BzGwn3rGxzIuOtEKODe9+587988iobPCzjtRqXdnV8F581h9KRyCPYgKnx+IS1p7Bg7QKnCTmwRspapeid9/gd/HoPFFWZtjXi3aprLtSdnZKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226539; c=relaxed/simple;
	bh=XmcTzjP+IJ00WyfHItPCpaDCCeKe1TYq6v4q5Ysbfgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rewhoa2tzbx8PWYHef3f9EHOyCId3NhLTj+IwtJaBiby/UCnRWpd6c/Qic4DKiBwtQZp46fH6jQ8YxCAOimgnGv4bunnyu/a0l1wognRYMnINIMG6j/13MPJWnXMfys292lgo9UpU9zAZWTYSq2pQQT+hWGcC+T2oFX1HwQgtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 45DC11AC23A;
	Mon, 12 Jan 2026 13:53:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 1890B20012;
	Mon, 12 Jan 2026 13:53:20 +0000 (UTC)
Date: Mon, 12 Jan 2026 08:53:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260112085257.26bb7b5b@fedora>
In-Reply-To: <CAADnVQJiEhDrfYVEyV8eGUECE_XFt7PGG=PFJRKU4jRBn-TsvA@mail.gmail.com>
References: <20260108220550.2f6638f3@fedora>
	<da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
	<CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
	<20260109141930.6deb2a0a@gandalf.local.home>
	<3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
	<CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
	<20260109170028.0068a14d@fedora>
	<CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
	<20260109173326.616e873c@fedora>
	<20260109173915.1e8a784e@fedora>
	<CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
	<20260110111454.7d1a7b66@fedora>
	<CAADnVQJ_L_TvFogq0+-qOH=vxe5bzU9iz3c-6-N7VFYE6cBnjQ@mail.gmail.com>
	<20260111170953.49127c00@fedora>
	<CAADnVQJiEhDrfYVEyV8eGUECE_XFt7PGG=PFJRKU4jRBn-TsvA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1890B20012
X-Stat-Signature: gcjjox51mrxtmsrreow5a3i5gw9tp9u1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18VqfY3Eg7yuckf9KrSUxHmnxOL9VS9acY=
X-HE-Tag: 1768226000-715225
X-HE-Meta: U2FsdGVkX1+wTUSCcvJ9YKpsslDni28EAev+O6hnTL6tiTGLW0myv/79edh+fekfijsTR7aIpnz8hmKYF2xhvPXobM33rS2uQkTVovE2iyUdXw0rOq7B6E/4uX86Jjy+eftROHVdeBEaxZal79AXTNZkiNEVP6iIFv8v5TPx7M95BmtmfvkQPmNR1EvQel25yBF8V417IqDiLvCakFAO6b0Rje3Mxqst/KERgAA79+LQ26kJMd0u0Ghq2pOXZqPFggnEww5/QYezuNqZCfByYGTxwo0Jl3PQt+Y2+CP499laogRxBUT1XxWYJ9irixSKd3Iw5B2VRttQTRHg43D2bTkoIXr/c2my

On Sun, 11 Jan 2026 15:38:38 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> > Oh, so you are OK replacing the preempt_disable in the tracepoint
> > callbacks with fast SRCU?  
> 
> yes, but..
> 
> > Then I guess we can simply do that. Would it be fine to do that for
> > both RT and non-RT? That will simplify the code quite a bit.  
> 
> Agree. perf needs preempt_disable in their callbacks (as this patch does)
> and bpf side needs to add migrate_disable in __bpf_trace_run for now.
> Though syscall tracepoints are sleepable we don't take advantage of
> that on the bpf side. Eventually we will, and then rcu_lock
> inside __bpf_trace_run will become srcu_fast_lock.
> 
> The way to think about generic infrastructure like tracepoints is
> to minimize their overhead no matter what out-of-tree and in-tree
> users' assumptions are today, so why do we need preempt_disable
> or srcu_fast there?

Either preempt disable or srcu_fast is still needed.

> I think today it's there because all callbacks (perf, ftrace, bpf)
> expect preemption to be disabled, but can we just remove it from tp side?
> and move preempt_disable to callbacks that actually need it?

Yes if we are talking about switching from preempt_disable to src_fast.
No if you mean to remove both as it still needs RCU protection. It's
used for synchronizing changes in the tracepoint infrastructure itself.
That __DO_TRACE_CALL() macro is the guts of the tracepoint callback
code. It needs to handle races with additions and removals of callbacks
there, as the callbacks also get data passed to them. If it gets out of
sync, a callback could be called with another callback's data.

That's why it has:

                it_func_ptr =                                           \
                        rcu_dereference_raw((&__tracepoint_##name)->funcs);

> 
> I'm looking at release_probes(). It's fine as-is, no?

That's just freeing, and as you see, there's RCU synchronization
required.

Updates to tracepoints require RCU protection. It started out with
preempt_disable() for all tracepoints (which was synchronized with
synchronized_sched() which later became just synchronize_rcu()).

The issue that came about was that both ftrace and perf had an
assumption that its tracepoint callbacks always have preempt disabled
when being called. To move to srcu_fast() that is no longer the case.
And we need to do that for PREEMPT_RT if BPF is running very long
callbacks to the tracepoints.

Ftrace has been fixed to not require it, but still needs to take into
account if tracepoints disable preemption or not so that it can display
the preempt_count() of when the tracepoint was called correctly.

Perf is trivial to fix as it can simply add a preempt_disable() in its
handler.

But we were originally told that BPF had an issue because it had the
assumption that tracepoint callbacks wouldn't migrate. That's where
this patch came about.

Now if you are saying that BPF will handle migrate_disable() on its own
and not require the tracepoint infrastructure to do it for it, then
this is perfect. And I can then simplify this code, and just use
srcu_fast for both RT and !RT.

-- Steve

