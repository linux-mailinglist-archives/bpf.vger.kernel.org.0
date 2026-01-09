Return-Path: <bpf+bounces-78372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D596D0C0CB
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 20:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED6B430D59F6
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDB82FB99E;
	Fri,  9 Jan 2026 19:19:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C72DF134;
	Fri,  9 Jan 2026 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986345; cv=none; b=a3/UduMsWc6UaIOF7538XNuZNlrOrTq7Ui5sqD7YgkZxpQwWu+rmENgJHeIgxrHOW+xuQPHaqCsGGoSoJLiYFgMwlCwZRP6GKf2+034zYHb2adJhH/QSma26+k6sZ8bCHCNmCaif/UlvKzBIRxGk47ejgEuWMeIQOt9eVRJ90oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986345; c=relaxed/simple;
	bh=b9fkAHjAXiET4tDCdZO1d2UxiZ7wSIMCge1r9CaDPe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=me3nG2G6RLAoF7zG0gkhQMBCP8t47Krr/ho8n2gt6btR8PxYBH7Agrq/LEvJW2x5zKeXfP4kWUjuiU833TU0QNiNPOi6IHzkLIJ4ev2OVQalIgIp1Z9F4cAVrbH2AkECsJmaLR+W/1GF35g5CrWaM0kT5j0LWR628+sjMI2hhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id AB4C6BB599;
	Fri,  9 Jan 2026 19:19:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 80D2D3D;
	Fri,  9 Jan 2026 19:18:58 +0000 (UTC)
Date: Fri, 9 Jan 2026 14:19:30 -0500
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
Message-ID: <20260109141930.6deb2a0a@gandalf.local.home>
In-Reply-To: <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
References: <20260108220550.2f6638f3@fedora>
	<da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
	<CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 80D2D3D
X-Stat-Signature: mrxwuctbtb6qzwocxk1ia8h7ctoxwbwk
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18cMV76IqjIgBX803+m9q4qinkTmK1Zris=
X-HE-Tag: 1767986338-843608
X-HE-Meta: U2FsdGVkX19BAUi14sanQ9ajQTBpJxaO+v588L2XOniSoSYcGLFgUKxufpmR0en9l5+F99W2EiFzznSLDbaDocOPmF0Q0H5Cmgk1ZqzjH8A3Q3hnd/gBfpW75VfzYTdmuD+DZsKUzDf2u8vsk4tLcTdfYcQBv38ksntwQZmGwIKfYWBOqO457LbD1CTyLNI5pMUlmpbrhUGU1Lj5fhylOSkHt9DYm3RzcIX05uXPbkMGXxexc+CW8ocxjwP8TQP5vF+YhrNI+fteOITUftA0lvVUb1NGtmB3RbLKAEvGFn3BDIslz6sbJQ+X93S1tNUq5tTw584x0aSy1EaVpoZylQV94mVYcZnd

On Fri, 9 Jan 2026 11:10:16 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

\> >
> > We also have to consider that migrate disable is *not* cheap at all
> > compared to preempt disable.  
> 
> Looks like your complaint comes from lack of engagement in kernel
> development.

No need to make comments like that. The Linux kernel is an ocean of code.
It's very hard to keep up on everything that is happening. I knew of work
being done on migrate_disable but I didn't know what the impacts of that
work was. Mathieu is still very much involved and engaged in kernel
development.

> migrate_disable _was_ not cheap.
> Try to benchmark it now.
> It's inlined. It's a fraction of extra overhead on top of preempt_disable.

It would be good to have a benchmark of the two. What about fast_srcu? Is
that fast enough to replace the preempt_disable()? If so, then could we
just make this the same for both RT and !RT?

-- Steve


