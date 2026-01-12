Return-Path: <bpf+bounces-78591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F59D13C4A
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B5330ADDBE
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA283612EE;
	Mon, 12 Jan 2026 15:36:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DFB3612CB;
	Mon, 12 Jan 2026 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232175; cv=none; b=FxyaSN4+MCPTitQ6cil7Sw4036tVBgY+DLZBjTInikkxRw2h/DYrbbKng8PsufaCUY7cigpnaO/1Gaq+vd6QUET/L6cFDTVb02fUKpQPh1LY6yQKwfq1YiG+dteDx9NEbf5K6UtfzrMv8kVS5ldtFHjPJzWtgfHPdJLeQbGoqSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232175; c=relaxed/simple;
	bh=IJTeafi3GdmngR/Ug8cbCa4yRhJh7eOjuoI6sV6L7u8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFnp3u2sJ/4K+Khi5DqC+fL6YwVSxTz3QCE6UwyVMYJ894epZL9aZrlkwKvaKCI7eKXSnsWgO9pQmXotgg7ny9aLnxJYm5t2s6r9Kk0Q3RGchoAVKke/rDifKeNUMNPIjhV7VCmUazN8mDuloIvWGW2HI/Jbgff6Xx0dGsNYkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C5417D0F22;
	Mon, 12 Jan 2026 15:36:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 78FE060009;
	Mon, 12 Jan 2026 15:36:09 +0000 (UTC)
Date: Mon, 12 Jan 2026 10:36:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux
 trace kernel <linux-trace-kernel@vger.kernel.org>, bpf
 <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260112103612.41dd4f03@gandalf.local.home>
In-Reply-To: <20260112153128.GO830755@noisy.programming.kicks-ass.net>
References: <20260108220550.2f6638f3@fedora>
	<da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
	<CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
	<20260109141930.6deb2a0a@gandalf.local.home>
	<3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
	<20260109160202.22975aa4@gandalf.local.home>
	<20260112153128.GO830755@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 78FE060009
X-Stat-Signature: 1bw1oymr1hzm7aif4p945ohzhcf8qy8i
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188wDl0ClLWtdgAsR3BixK7EB7H0d78LlA=
X-HE-Tag: 1768232169-489420
X-HE-Meta: U2FsdGVkX1+25cV6CkjInKsAbuf455j8HF4zIIWJCb05b5Z+ZtTTGVIxEHyWOaEHHSdnB9fsl8qRwU2XZCu9j/3UtsvVRiB1HdKMXSTL6+J92LberiGxt34Y6/c4teMSnU5PZ745Zq1u1LkJLtQvnCERC3AXPDzgYDBRJUdDR6Fc43RvOudT0uZgp/tXcQeyJC5lGXX5cpTsEEK5t85cLPSUYb5Xd/US8CKkiomGTe7stWFD+8P7b70WrtJIeWMgC+uFmyFdncl082dPu1/mUKoh1F5qqVxCNj8CUF9R64FZ3JxMBczoQ4T83HJBccWgBWZOrbr+GAX0SzH3bKO6FBhK9Gsw1vdRKs1Kk7xvcZwzLgVMhvcmsjmJYCWliZC9

On Mon, 12 Jan 2026 16:31:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > OUCH! So migrate disable/enable has a much larger overhead when executed in
> > a module than in the kernel? This means all spin_locks() in modules
> > converted to mutexes in PREEMPT_RT are taking this hit!  
> 
> Not so, the migrate_disable() for PREEMPT_RT is still in core code --
> kernel/locking/spinlock_rt.c is very much not build as a module.

True. But still, wouldn't it be cleaner to have that variable separate from
the run queue and make the code a bit simpler?

As now it doesn't look like it will even bother tracing, as it appears that
only BPF would need it. So this would just be a clean up.

-- Steve

