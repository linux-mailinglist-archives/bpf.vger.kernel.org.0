Return-Path: <bpf+bounces-78719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3BD19383
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 14:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92008305E867
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D689A39283A;
	Tue, 13 Jan 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3FdTXzO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KTz2j3kb"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35439282D;
	Tue, 13 Jan 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312580; cv=none; b=T3hKHhUGqETEBZpk9Lg1nE7zUPd5Ai5/dKTz+gWbn2q8QPQtBb4SXY6Ko4kSI3RY0WBlniZT6/E28op5rjpaPTA9ACUh5M8Ssb/r9++W2dIxWkaQ7o+CLCqwIlQe4cYWb6lA/wtFarxnOh1qLsMN5wUlyfOtqXJ7F1Dbdq7rmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312580; c=relaxed/simple;
	bh=VKDfdEeAGmvs2Itgr8lGNLNIeh7BO8p2bQkfzHAwiR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8BE1VYtow3gJA4MGfr0gU8+B1bSttjW7ppBP7tL14cDrX+UlAzr01rafW/czylMkvxoGJy18BY1qVQRWvoQ5Im4cDPNdtfm2Nh8lx+katQG9c1iPn8UUaAbtAfayTSYTUK4Qqp+yMPaKt8ehHi9SoE0IQLz9YUkvmp0PL+2RBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3FdTXzO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KTz2j3kb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 14:56:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw8ZcQHK/uDcyJYw+AZQbOaYuF1pprqHw9wHUqcLuEQ=;
	b=n3FdTXzOr0VKcJs3mJugN4aNportC8bdbjxNqO7ba9vZJxdHdwRyKe+viT5AsTnoWzP4YF
	oqQRgN6gTybyMkL/4aUU4ya2NayTmm2nW8oSLNieKc++ngmQzmjJe6zhiuLBf2QQu4pW8r
	rpg31t89AZ3ZP9Yv3/S8D4BInqi0rI1tS29MLkYMANSeJki4PLJ1djIw+ZFUqNHgoK2Rno
	7asrBrydIiMLCi0nk1WcvC4ltvKse+bnbdGYiQZY8/mH6Wa47ew71GFqIjImrICvEA8H1D
	g6RpIzakTtDpFQfgBdn4BvlZty5I6vDStVOGzaoPmtDxw+MSsqEpOmIaspA1lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw8ZcQHK/uDcyJYw+AZQbOaYuF1pprqHw9wHUqcLuEQ=;
	b=KTz2j3kbnZctHgmTGHQCuyw8vAtNT91E2iVL+4b4eizyLcSvwLI46I1F+EG3WQgxHhaJpu
	qG4MCb1qPNlf6NBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260113135616.xt2Nm4IY@linutronix.de>
References: <20260108220550.2f6638f3@fedora>
 <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <20260109122142.108982d9@gandalf.local.home>
 <8252131c-4c54-43ca-9041-71481165e516@efficios.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8252131c-4c54-43ca-9041-71481165e516@efficios.com>

On 2026-01-09 13:58:21 [-0500], Mathieu Desnoyers wrote:
> On 2026-01-09 12:21, Steven Rostedt wrote:
> > > Using SRCU-fast to protect tracepoint callback iteration makes sense
> > > for preempt-rt, but I'd recommend moving the migrate disable guard
> > > within the bpf callback code rather than slowing down other tracers
> > > which execute within a short amount of time. Other tracers can then
> > > choose to disable preemption rather than migration if that's a better
> > > fit for their needs.
> > 
> > This is a discussion with the BPF folks.
> 
> FWIW, the approach I'm proposing would be similar to what I've done for
> faultable syscall tracepoints.

I just started reading this thread but we could limit the
migrate_disable() to only the BPF callback part so it does not effect
the whole tracepoint if there not a BFP program attached to it.

Sebastian

