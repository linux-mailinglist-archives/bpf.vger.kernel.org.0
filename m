Return-Path: <bpf+bounces-78507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3794ED10081
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 23:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A4D030550EE
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1962D23B1;
	Sun, 11 Jan 2026 22:10:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F11339A4;
	Sun, 11 Jan 2026 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768169406; cv=none; b=TagIZ60qno5lcdrrIWy1A27GljbkqEdfwV6nM9ouKwbG8zh8AZEiVK+uI9+Ep5XRoCiBEneddOsxfMkuG5Ou484sYugeufzGrqm3uEFba/xMAA9dLHDPAaZ48eDfA2oU6gSnk8V+y4DjE5WBTWRCW9lR0tLniHHcZhFDvVoABvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768169406; c=relaxed/simple;
	bh=8brB/gIotb0DWiWePfrKUYHLIGrO47udlc70WW+Ne0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LA/3q3hoKfI/FKswEc+Lu4LjciP4lIG94DYN8Gv0gOL/1umRCdD6frbXSlnTcOzYNFdtRBv9xwVdOc94fIoDHmuwTrrEaHVTiYjw797QF3N1hgb+EB6ozQ6pfF/FDWGVpsL0St8qC74HUrOQ/JF7g6tg8ixUaS9MnGU5x8Sr2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C0D9A161286;
	Sun, 11 Jan 2026 22:09:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 863631A;
	Sun, 11 Jan 2026 22:09:54 +0000 (UTC)
Date: Sun, 11 Jan 2026 17:09:53 -0500
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
Message-ID: <20260111170953.49127c00@fedora>
In-Reply-To: <CAADnVQJ_L_TvFogq0+-qOH=vxe5bzU9iz3c-6-N7VFYE6cBnjQ@mail.gmail.com>
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
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 863631A
X-Stat-Signature: moc7n7gme61qa88wc8cnoifmaq1zt7ed
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+fgY/X4vzJwIPhelmP5ZQGGi/VoABAAq8=
X-HE-Tag: 1768169394-114868
X-HE-Meta: U2FsdGVkX19V6IrRjUZy1KASoCP9WyyBPXG1m7hVp8NAkVx3Be8qztIDSmfGd7IWbbf5rxAAmG4NWPj2EcOT+AN8JEuw6wPeL7EaZ8gL/ZtkQyo4vUf3kpsDyJgMRPy7XBJP1Y0eEl6YE7nzIRMPXUVPRRgI1QJj2ZDDyj/OTO7VLeKsLMIKndJk6mMRbYEcQVApVjvnLB8xnVQpSThdjta4bbu7E9b/TQSfRsRevezPdndMYLngx1a2fbCTZX2gSIgRQRIC3g8grOKEOKcF/z7KoH0jNp/Hbnw9XZakutLMoAEO1RHPbIM7/ofMNvP8j/SFEWGYq0VH7avSMzDGUZiThSc/z11Y

On Sun, 11 Jan 2026 12:04:51 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> The diff has nothing to do with bpf needs and/or bpf internals.
> It's really about being a good citizen of PREEMP_RT.
> bpf side already does migrate_disable,
> rcu_read_lock, srcu_fast/task_trace when necessary.
> Most of the time we don't rely on any external preempt state or rcu/srcu.
> Removing guard(preempt_notrace)(); from tracepoint invocation
> would be just fine for bpf. Simple remove will trigger bug
> on cant_sleep(), but that's a trivial fix.

Oh, so you are OK replacing the preempt_disable in the tracepoint
callbacks with fast SRCU? 

Then I guess we can simply do that. Would it be fine to do that for
both RT and non-RT? That will simplify the code quite a bit.

-- Steve

