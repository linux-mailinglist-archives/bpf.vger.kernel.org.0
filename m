Return-Path: <bpf+bounces-78421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D68D0C785
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 23:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65BC33032FCD
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 22:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38F34107C;
	Fri,  9 Jan 2026 22:39:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410A2FD1C5;
	Fri,  9 Jan 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998362; cv=none; b=YaDwVy+V3Ne6Y8ozL8nEtWUtu8uGMWabOytLtAPaoz13FR/xGCgO7dbNNkNbAPRZVkdXx2f1BIruwND/WfIKH5kw6fVlVLAkJ7UkbrKVhSHoBnS27yJk1hCv69gduHYPup7TOYZqz9AFWhAGgMNWADTIxede6Xvir2XCSZA8Qj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998362; c=relaxed/simple;
	bh=mc1QKo7a3J9z8k1EXgq+/h/3Alt+UI3fXeAa7ve+reI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNS2HV+KMW0BjCzmilAIsH1YqdXWAphxqC0hqp8OEghKjRhZXRL2vmm9eCBxB73OhYegzgf1ZHR++uDqIOi+UX5TlvoW3u4zw7kBoYAlshmhZKlSz94CSHH/i0Cy8jpdHOXvHpRiCouMA+VhN/Q9xsIWDcAJNxoAm8jY8Vj5wQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id D1D56C3ECC;
	Fri,  9 Jan 2026 22:39:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id A98A332;
	Fri,  9 Jan 2026 22:39:16 +0000 (UTC)
Date: Fri, 9 Jan 2026 17:39:15 -0500
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
Message-ID: <20260109173915.1e8a784e@fedora>
In-Reply-To: <20260109173326.616e873c@fedora>
References: <20260108220550.2f6638f3@fedora>
	<da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
	<CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
	<20260109141930.6deb2a0a@gandalf.local.home>
	<3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
	<CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
	<20260109170028.0068a14d@fedora>
	<CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
	<20260109173326.616e873c@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A98A332
X-Stat-Signature: aqwm3wgko1hegeu1b8x387j1ngx59fni
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+eunUq5O62J9BP3l8pud2O5GxBVf4ALc0=
X-HE-Tag: 1767998356-9069
X-HE-Meta: U2FsdGVkX188sBO5fNYrseaG8Zk5PEAUpvcuW0hLACumdFemnGlyGbV8fPp3oFzztYMy8qg3pnJnnD3U99A1ZCSMpUqjAaMaBmPd2na+fNVBCXmeZY91Ysbw+9UvPYsXWJAANgkaynLPp+KEEm+okZZlhiSjqw6eMo/rSY8qUU/V1FBi6QHVxv8iyLSI5S1RhXZlF8g4/GdJkifisdWFliHxP0SgiN8B4XPJYbrqs/aT0dqF7emTFqCAcU2Tsd+Qe6tndSbwytVmdsDNx6dlhTBo6mrV8oowIikllnDJssNCs3t0zkD0A0KBSr5mRsMmzfVH48TYwk8WTC70IGkF/R7OS3pVQrgClnD/s4IaPpaRdipVoR+iUCWR3jZTVPDI

On Fri, 9 Jan 2026 17:33:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> How is this about lttng? Sure he cares about that, but even tracepoints
> that lttng uses doesn't get affected any more than ftrace or bpf.
> Because lttng is one of the callbacks. The migrate disable happens in
> the in-tree portion of the code.
> 
> So you are saying that all the tracepoints for xfs are not in a fastpath?

Regardless of tracing. I now have my RT hat on. The spin_locks that are
converted to mutex use migrate disable. The fact that migrate_disable
in modules are close to 10x slower than the same code in-kernel is
troubling to say the least. It means that modules in RT take a hit
every time they take a spin_lock().

The migrate disable being slow for modules is no longer just a tracing
issue. It's a PREEMPT_RT issue.

-- Steve

