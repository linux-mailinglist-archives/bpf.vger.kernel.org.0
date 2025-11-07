Return-Path: <bpf+bounces-73919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49569C3E1F7
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 02:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CAFB934CB00
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 01:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA732F5A3F;
	Fri,  7 Nov 2025 01:25:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347372D3A77;
	Fri,  7 Nov 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478743; cv=none; b=fzoz1L9UBk3IanOmxFnL2k5G7ONdsoADC09qJTaKEyc/xAjEym10n+eJ64oEHHHlRq3yhwEP4FP0DW/KzMekXCMHwcsEzEtevzu9xl1fld7quJRGatFnCDJNCgRy1X+Uq4wjs9WrctSCmUEc6QTT+LHWP1vyGXYghn2Nx6kCLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478743; c=relaxed/simple;
	bh=l+HkW8boKXXIbvN9jqeLG3k3Gf7ksT07ZL9Tg4hUtyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiv8jbkxeBtZwF1iseltb2Jw3kti7farGq718DcUdDQfITCTlv1bR7cZmlIlcJRajsLf/MnqdmQAlbX8v3ZxH/67jyH3twd3YyHavccQKd8a5WtHDo1imIFvTvorLQ9Ukm7vuNaUY3z0v563LbbmKRhrUxLjY0dzSLxpS1dkk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 5C2D487C3A;
	Fri,  7 Nov 2025 01:16:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 535202000F;
	Fri,  7 Nov 2025 01:16:46 +0000 (UTC)
Date: Thu, 6 Nov 2025 20:16:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org, frederic@kernel.org
Subject: Re: [PATCH v2 10/16] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20251106201644.3eef6a4a@batman.local.home>
In-Reply-To: <46365769-2b3a-4da1-a926-1b3e489d434a@paulmck-laptop>
References: <bb177afd-eea8-4a2a-9600-e36ada26a500@paulmck-laptop>
	<20251105203216.2701005-10-paulmck@kernel.org>
	<20251106110230.08e877ff@batman.local.home>
	<522b01cf-0cb6-4766-9102-2d08a3983d8a@paulmck-laptop>
	<20251106121005.76087677@gandalf.local.home>
	<eb59555d-f3e8-47c9-b519-a7b628e68885@paulmck-laptop>
	<20251106190314.5a43cc10@gandalf.local.home>
	<46365769-2b3a-4da1-a926-1b3e489d434a@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 535202000F
X-Stat-Signature: ujusm8xsq5jngca3san18n6facuf7mr7
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18J1tqfJ/0WoJd3jGL9TNSLJ6HHk3PrGPk=
X-HE-Tag: 1762478206-621186
X-HE-Meta: U2FsdGVkX195KBIqfQ3B8KODLF1oxlJRib/7IceoXWErrBQMnYcdQn8apKV3ByQ7rgJwWG77VJz0PBudH/QbiZYvogdwtJx7QjKJnsS4rvzUZlFVcrAZ3Enr3Nik8saTDhNiEgflpxoe8mvH7hBLEv0uxwiZJR4cLIvVQ/9QgWAH//sN8PuLun8ErOwWFV5AjYANzLhKZcxKiHWiEy3+L7yYgWOfetuu2OZYheQUwlHyknJMl2UfHhN6CgQAGjFDVNK+IgVqtOSoVAdGO6mo6FOQa3VHz9RzKvV9e45hAulDTmDJRfXp6L97/MPcLTjX2i3XSJ8WGtpoSzxzyimneqCEfwejvTcCHycjaJZ80sVQo737aosBJXtowhFr6/9nUrwTh8+zWBeDvGIdOT+Y8Q==

On Thu, 6 Nov 2025 17:04:33 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > It gets a bit more confusing. We see "migrate disabled" (the last number)
> > except when preemption is enabled.  
> 
> Huh.  Would something like "...11" indicate that both preemption and
> migration are disabled?

Preemption was disabled when coming in.

> 
> >                                    That's because in your code, we only do
> > the migrate dance when preemption is disabled:
> >   
> > > +			if (IS_ENABLED(CONFIG_PREEMPT_RT) && preemptible()) {	\  
> 
> You lost me on this one.  Wouldn't the "preemptible()" condition in that
> "if" statement mean that migration is disabled only when preemption
> is *enabled*?
> 
> What am I missing here?

So preemption is disabled when the event was hit. That would make
"preemptible()" false, and we will then up the preempt_count again and
not disable migration.

The code that records the preempt count expects the tracing code to
increment the preempt_count, so it decrements it by one. Thus it records;

  ...1.

As migrate disable wasn't set.

> 
> > > +				guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> > > +				guard(migrate)();				\
> > > +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> > > +			} else {						\
> > > +				guard(preempt_notrace)();			\
> > > +				__DO_TRACE_CALL(name, TP_ARGS(args));		\
> > > +			}  
> > 
> > And that will make accounting in the trace event callback much more
> > difficult, when it's sometimes disabling migration and sometimes disabling
> > preemption. It must do one or the other. It can't be conditional like that.
> > 
> > With my update below, it goes back to normal:
> > 
> >             bash-1040    [004] d..2.    49.339890: lock_release: 000000001d24683a tasklist_lock
> >             bash-1040    [004] d..2.    49.339890: irq_enable: caller=_raw_write_unlock_irq+0x28/0x50 parent=0x0
> >             bash-1040    [004] ...1.    49.339891: lock_release: 00000000246b21a5 rcu_read_lock
> >             bash-1040    [004] .....    49.339891: lock_acquire: 0000000084e3738a read &mm->mmap_lock
> >             bash-1040    [004] .....    49.339892: lock_release: 0000000084e3738a &mm->mmap_lock
> >             bash-1040    [004] .....    49.339892: lock_acquire: 00000000f5b22878 read rcu_read_lock_trace
> >             bash-1040    [004] .....    49.339892: lock_acquire: 0000000084e3738a read &mm->mmap_lock
> >             bash-1040    [004] .....    49.339893: lock_release: 0000000084e3738a &mm->mmap_lock
> >             bash-1040    [004] .....    49.339893: sys_exit: NR 109 = 0
> >             bash-1040    [004] .....    49.339893: lock_acquire: 0000000084e3738a read &mm->mmap_lock
> >             bash-1040    [004] .....    49.339894: lock_release: 0000000084e3738a &mm->mmap_lock
> >             bash-1040    [004] .....    49.339894: sys_setpgid -> 0x0
> >             bash-1040    [004] .....    49.339895: lock_release: 00000000f5b22878 rcu_read_lock_trace
> >             bash-1040    [004] d....    49.339895: irq_disable: caller=do_syscall_64+0x37a/0x9a0 parent=0x0
> >             bash-1040    [004] d....    49.339895: irq_enable: caller=do_syscall_64+0x167/0x9a0 parent=0x0
> >             bash-1040    [004] d....    49.339897: irq_disable: caller=irqentry_enter+0x57/0x60 parent=0x0
> > 
> > I did some minor testing of this patch both with and without PREEMPT_RT
> > enabled. This replaces this current patch. Feel free to use it.  
> 
> OK, I will add it with your SoB and give it a spin.  Thank you!

Signed-off-by: Steve Rostedt (Google) <rostedt@goodmis.org>

Cheers,

-- Steve

