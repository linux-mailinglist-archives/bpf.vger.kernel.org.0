Return-Path: <bpf+bounces-69525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7DCB9909E
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 11:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B240E7A30C9
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 09:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B792D592F;
	Wed, 24 Sep 2025 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pP25+uBD"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BD728136C;
	Wed, 24 Sep 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704916; cv=none; b=NT7aVAIeMu9oJdLfFsddNF0fmj2zTM+p5sx6xOJGZrTrnjjzBkoO+kFTZpF1a7JhPfmjurw7XAzxPMB3/UmAzyHNKPboQs6d0HwCw/A3yKGx6NDDww9norZhPOpy4FmEKl7rmbiRhy7pvqwmGWsmvHKCLJGUHCZWrxTOv71w5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704916; c=relaxed/simple;
	bh=HCAf5x5iUC/1d6pieTNRXIj/VvY3r+w60+F14Yh9+Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1+BHvNl7ok0DOqEWT2m+1rdhK7Q/KkFdgCMbyAJKSQIrwJ3Dvnp6RcUcqWUxKltzGb+D8929aLG6OzX2bpNC+aAgVbmec+6ZOa/nqsLFEhKvX5WzrWGTKzOnNV/WMKihbbxWI9UUS+69lBmV8/I+D57if+6wQZ7jViREk1nNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pP25+uBD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DsZZ9X+fBIV6DT/2CVWvuuacO48iv66RchXHuf4yZZs=; b=pP25+uBDnoTa9fG/gaGSM9anvA
	NJPMwL+CT20Ikl7/EiiUGGjM7nGPHHAcrLmRtJMneDNLx8kTI4Nr1WthhAD+r7TsTqzJLFWFOHLZ/
	WASxFonTcIUcTJN9hE28Kjn+Rn+NMNyiBrd+hKeoxv0IfFHjn9Lyy9D3mOT8g+4VLiqW+wHmHPPzr
	LCTajnZEwtzwCa4ssIZk48cGwrMuj5z7qup7WXSQwnn96+dh8OKd7Ifit0UC5ogfZXx7k1VNZO1Vf
	rG89xSZ8dZo91jbkAEYfF2Ifk713L1VwycpQdIjbphCTi7Ci0GfN7RLucjcsLYObmJZ8umZhuWCRI
	kyW5VlIg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1LUF-0000000CWF1-004O;
	Wed, 24 Sep 2025 09:08:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8586530033D; Wed, 24 Sep 2025 11:08:30 +0200 (CEST)
Date: Wed, 24 Sep 2025 11:08:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 15/34] rcu: Add noinstr-fast
 rcu_read_{,un}lock_tasks_trace() APIs
Message-ID: <20250924090830.GX3245006@noisy.programming.kicks-ass.net>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
 <20250923142036.112290-15-paulmck@kernel.org>
 <20250923173216.GU3245006@noisy.programming.kicks-ass.net>
 <d341688c-fa19-4dab-88cb-3a45838cc2f1@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d341688c-fa19-4dab-88cb-3a45838cc2f1@paulmck-laptop>

On Wed, Sep 24, 2025 at 01:44:09AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 23, 2025 at 07:32:16PM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 23, 2025 at 07:20:17AM -0700, Paul E. McKenney wrote:
> > > When expressing RCU Tasks Trace in terms of SRCU-fast, it was
> > > necessary to keep a nesting count and per-CPU srcu_ctr structure
> > > pointer in the task_struct structure, which is slow to access.
> > > But an alternative is to instead make rcu_read_lock_tasks_trace() and
> > > rcu_read_unlock_tasks_trace(), which match the underlying SRCU-fast
> > > semantics, avoiding the task_struct accesses.
> > > 
> > > When all callers have switched to the new API, the previous
> > > rcu_read_lock_trace() and rcu_read_unlock_trace() APIs will be removed.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Andrii Nakryiko <andrii@kernel.org>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: <bpf@vger.kernel.org>
> > > ---
> > >  include/linux/rcupdate_trace.h | 37 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > > 
> > > diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
> > > index 0bd47f12ecd17b..b87151e6b23881 100644
> > > --- a/include/linux/rcupdate_trace.h
> > > +++ b/include/linux/rcupdate_trace.h
> > > @@ -34,6 +34,43 @@ static inline int rcu_read_lock_trace_held(void)
> > >  
> > >  #ifdef CONFIG_TASKS_TRACE_RCU
> > >  
> > > +/**
> > > + * rcu_read_lock_tasks_trace - mark beginning of RCU-trace read-side critical section
> > > + *
> > > + * When synchronize_rcu_tasks_trace() is invoked by one task, then that
> > > + * task is guaranteed to block until all other tasks exit their read-side
> > > + * critical sections.  Similarly, if call_rcu_trace() is invoked on one
> > > + * task while other tasks are within RCU read-side critical sections,
> > > + * invocation of the corresponding RCU callback is deferred until after
> > > + * the all the other tasks exit their critical sections.
> > > + *
> > > + * For more details, please see the documentation for srcu_read_lock_fast().
> > > + */
> > > +static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(void)
> > > +{
> > > +	struct srcu_ctr __percpu *ret = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
> > > +
> > > +	if (IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR))
> > > +		smp_mb();
> > 
> > I am somewhat confused by the relation between noinstr and smp_mb()
> > here. Subject mentions is, but Changelog is awfully silent again.
> 
> Thank you for looking this over!
> 
> To Alexei's point, this commit should be merged with 18/34.
> 
> > Furthermore I note that this is a positive while unlock is a negative
> > relation between the two. Which adds even more confusion.
> 
> You are right, at most one of these two conditions can be correct.  ;-)
> 
> I believe that the one above needs a "!".

Whew :-)

> The point of this is that architectures that set ARCH_WANTS_NO_INSTR
> have promised that any point in the entry/exit code that RCU is not
> watching has been marked noinstr.  For those architectures, SRCU-fast
> can rely on the fact that the key updates in __srcu_read_lock_fast()
> and __srcu_read_unlock_fast() are either interrrupt-disabled regions or
> atomic operations, depending on the architecture.  This means that
> the synchronize_rcu{,_expedited}() calls in the SRCU-fast grace-period
> code will be properly ordered with those accesses.
> 
> But for !ARCH_WANTS_NO_INSTR architectures, it is possible to attach
> various forms of tracing to entry/exit code that RCU is not watching,
> which means that those synchronize_rcu{,_expedited}() calls won't have
> the needed ordering properties.  So we use smp_mb() on the read side
> to force the needed ordering.
> 
> Does that help, or am I missing the point of your question?

Yes, that was indeed what I was asking. This might make a good comment
to go along with that IS_ENABLED(CONFIG_ARCH_WANTS_NO_INSTR) thing.

Thanks!

