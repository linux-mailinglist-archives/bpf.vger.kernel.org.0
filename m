Return-Path: <bpf+bounces-78476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D02D0D90C
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 17:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D197300EE4B
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 16:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BED348466;
	Sat, 10 Jan 2026 16:15:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80118221721;
	Sat, 10 Jan 2026 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768061701; cv=none; b=RzrRYR7iPTsJDtvS3Spd+Brf9/21LafVXP0zJuLwGPnpWiJO4OTqdojuyDGIfYubNE77t78nhJ9ei5l155ysbKwW7vnClBfZzsh5kOGqrGx98WF0/z8NvD1wd00+HaYlq20U6rcTbZe9x4QepAyC7vrb7AE9YV1AzMScLzz3Et8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768061701; c=relaxed/simple;
	bh=M8xDG8Zyq+S6Zw8Ow+7JZRxGuqo88eowOcC6lsWy6io=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEIJn8tvSpqO4Bh8IC7I6fe2GS8HFa0/8Eae4EDv95iqrrc5FfPYCjlBV/qc3K0aHDdzmd5LAqD6qrTzAyodLx9MKwm8Dg/HuLBrWS8t/kyimTwirP9jP6wPyi/xBR36ejej1ZjG83HSF2lfyzGmdnwnIubOSviVs490Ho0UEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id E9DFEB7634;
	Sat, 10 Jan 2026 16:14:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id B23C032;
	Sat, 10 Jan 2026 16:14:55 +0000 (UTC)
Date: Sat, 10 Jan 2026 11:14:54 -0500
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
Message-ID: <20260110111454.7d1a7b66@fedora>
In-Reply-To: <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
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
X-Rspamd-Queue-Id: B23C032
X-Stat-Signature: psxdaohb3y3b1egirjm1w7akid13m1fw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1980Q2rEboLvVSZYrlNtXLFvLB8KS4zNlI=
X-HE-Tag: 1768061695-312487
X-HE-Meta: U2FsdGVkX182fYwLQzjI8sd87GfmW4tkMaCzXYz3eJcBF12cYnAvQTKscF2Hi5wrYzh6zi8LRvELCMG9pDeQWv5gk1//IpAan3++G4HVdnxkfwy1n44NetW74GK0yp5J7y7YjczJkWvH8a16lfkBU/08arB720UPGfIAXRPSyunwE1fl0MgWf+jDrL3VJOnFlVBo1QvAgBNvENorais/zLJiLCNkpmMVSNAZfkG41PEWh+THX3UGdVJPvBCVtnzcwSSTVeJtL6URfqcpXjfrgbhM9kBstKFsHMDyRq33iLryhmgiEr4lRHdXpup2/uQfuKjlMmBkBW6t6JO+mQCzJxD/XCgFOCpk

On Fri, 9 Jan 2026 16:35:10 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> migrate_enable/disable() wasn't inlined for a long time.
> It bothered us enough, since sleepable bpf is the main user
> of it besides RT, so we made an effort to inline it.

It did bother us too. it went through lots of iterations to become more
efficient over the years (it was really bad in the beginning while
still in the rt-patch), and hopefully that will continue.

> 
> RT, at the same time, doesn't inline rt_spin_lock() itself
> so inlining migrate_disable() or not is not 10x at all.
> Benchmark spin_lock on RT in-tree and in-module and I bet
> there won't be a big difference.

I'll put that on my todo list. But still, having migrate_disable a
function for modules and 100% inlined for in-kernel code just because
it needs access to a field in the run queue that doesn't need to be in
the run queue seems like it should be fixed.

As for tracepoints, BPF is the only one that needs migrate disable.
It's not needed for ftrace or perf (although perf uses preempt
disable). It should be moved into the BPF callback code as perf has its
preempt disable in its callback code.

If BPF doesn't care about the extra overhead of migrate_disable() for
modules, then why should XFS suffer from that too?

-- Steve

