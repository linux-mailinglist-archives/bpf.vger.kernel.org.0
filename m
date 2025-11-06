Return-Path: <bpf+bounces-73893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEFAC3CF66
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5BC18988BD
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 17:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DBA347FC7;
	Thu,  6 Nov 2025 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YROH6cj0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10527C162;
	Thu,  6 Nov 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451551; cv=none; b=FckCDCqRw0Vbjg0rSL7oP8vEMazi/YDNF9m1MUBWrMWBIiAk0oQg2Ik/G+TYTTUN0cCBoa6cxqZr8mNclXewf/5WEKQqySodW5oRwHL6F44N0zbJvt1r+Hb8GYNXzAmNV89G6Efm6BH36RqBkcYoronj5Mvyhrk4IidPl6pyx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451551; c=relaxed/simple;
	bh=cJtj7JB1M9DqfpBo0oI4itSyzA0Ji3lQZZQ5SlarslU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE1vsrpLOSVAtZ167/Psc2WIrqbKvOa6QTD85wcxEOMo778/BLOnoEqH7FSFzUgOsas7JYa5XD0qvbYP2lojhcXmUoClZamB//ky/yQy4vq8qxCQwY/bn27Yir8LTtme40XEA6M1/aR7XSYMoZrzaKuEHj2if+H0F/U1cb3Xmag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YROH6cj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6131EC19421;
	Thu,  6 Nov 2025 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762451550;
	bh=cJtj7JB1M9DqfpBo0oI4itSyzA0Ji3lQZZQ5SlarslU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YROH6cj0jK/wsfeQIJjRcGcXELYF0QKSip1MEerdPZ68KsDM+u1q/4IrPcoVzUmAI
	 xWQQXAO4lnrm21AfbdyrY2guM/5pYZzFDLAuFe/AvSAlEgw6PWT7BPi9GNenr1vZ+x
	 gjvcAtysg9yvBQT+hcOFF0VgBuupQ4XBylGXMN+9I/k7M6fCbbG4ykbKbFMQjwKH2C
	 cQ0X+gLqINDNckAM4nXOQEhSB48PIBHFQZXvloKp2zq08wSYImW4LF9V7RS+1oTU5H
	 KU3+7eYDWDi5+YwWtQpqx6p43DFdax+T+zxgMI0IueHUU2xFcx8gPiTH10TljFvhf1
	 EW9q/ytiRbn+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E292FCE0B24; Thu,  6 Nov 2025 09:52:28 -0800 (PST)
Date: Thu, 6 Nov 2025 09:52:28 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org, frederic@kernel.org
Subject: Re: [PATCH v2 10/16] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <eb59555d-f3e8-47c9-b519-a7b628e68885@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
 <20251105203216.2701005-10-paulmck@kernel.org>
 <20251106110230.08e877ff@batman.local.home>
 <522b01cf-0cb6-4766-9102-2d08a3983d8a@paulmck-laptop>
 <20251106121005.76087677@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106121005.76087677@gandalf.local.home>

On Thu, Nov 06, 2025 at 12:10:05PM -0500, Steven Rostedt wrote:
> On Thu, 6 Nov 2025 09:01:30 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Thu, Nov 06, 2025 at 11:02:30AM -0500, Steven Rostedt wrote:
> > > On Wed,  5 Nov 2025 12:32:10 -0800
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:  
> > > > 
> > > > The current commit can be thought of as an approximate revert of that
> > > > commit, with some compensating additions of preemption disabling pointed
> > > > out by Steven Rostedt (thank you, Steven!).  This preemption disabling  
> > >   
> > > > uses guard(preempt_notrace)(), and while in the area a couple of other
> > > > use cases were also converted to guards.  
> > > 
> > > Actually, please don't do any conversions. That code is unrelated to
> > > this work and I may be touching it. I don't need unneeded conflicts.  
> > 
> > OK, thank you for letting me know.  Should I set up for the merge window
> > after this coming one (of course applying your feedback below), or will
> > you be making this safe for PREEMPT_RT as part of your work?
> 
> Just don't convert the open coded preempt_disable() to a guard(). That's
> the code I plan on touching. The rest is fine (with my suggestions ;-)

Ah, thank you for the clarification!  Will do.

Frederic, could you please drop this commit from your shared-RCU stack?

							Thanx, Paul

