Return-Path: <bpf+bounces-61035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EECADFF1D
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 09:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B4716C883
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D733A2566E6;
	Thu, 19 Jun 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AA6OjpEe"
X-Original-To: bpf@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47708218596;
	Thu, 19 Jun 2025 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319426; cv=none; b=sOOx3sZP74HfB8sBYNPsWE3G4s4SrzC3snMsZbGGtOn2jOulLSnN4XjgMFq/rLG1q2QOx5z4VsPI7YX+CkblgtAbH+SFN3xKrLRYC6akUbhfBLYYH0fY+x/S6566qQ7Xk6i7UUkR2NqocjsQJrnk9PCaVheSOFHiwyVMtbDAqTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319426; c=relaxed/simple;
	bh=+LdJTkLwhNLBRu51Qjbu3Cs+Afo6/71D2l3eYk+Jksw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbjBGiW5iGkSKADsCnXs7QM6sQwkXo+yBcjC3KL/Ty7MCV+4MYUSGfkvVJruvapndlJ2X/G6WFfU862Yk+1ylgmliWHLXf6ZON1ClrHG524VgLwzydWS6zHYDQZirJFNs+zoviWLjN0ffO9ye8x0s9I+zlrd2cLExNFvVMonBa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AA6OjpEe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hx0YVP2tukiJV2KpHYvTHfhjqFI5IFm6q+doEiyTGvs=; b=AA6OjpEeSklZgSVkmbQNpiPpkF
	YScSkT80pMjOwbudH1ZxaDzwL7EfdkGlfQUNONfl9VHmg6P92KkuwLpnJOczMwVF8mOKAFaZKgWcE
	FQYrXhAHij1j69QGRY7pdfKH6lbQqF54fFNXqehEBEfuni9RmiTGeHunbl6jL/1/6m/BWFsBWenEz
	pCPckHH0Z3Tlo+4xJ0QQdta6NFWxCYH90a/l4OLHgosFC4130U3Th+WtN438HuZpsS/wqt71GjCEI
	J9SgdrDsRV/z1itXsBOGduZytqJuqkydzasdfNWIJOvdpMUrrdosTEtaXOhVt/l1z+TCQj1Rgbklg
	0Pe05hqA==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSA2F-00000004NLC-1js9;
	Thu, 19 Jun 2025 07:50:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D4E883088F2; Thu, 19 Jun 2025 09:50:08 +0200 (CEST)
Date: Thu, 19 Jun 2025 09:50:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250619075008.GU1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.770214773@goodmis.org>
 <20250618184620.GT1613376@noisy.programming.kicks-ass.net>
 <20250618150915.3e811f4b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618150915.3e811f4b@gandalf.local.home>

On Wed, Jun 18, 2025 at 03:09:15PM -0400, Steven Rostedt wrote:
> On Wed, 18 Jun 2025 20:46:20 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > +struct unwind_work;
> > > +
> > > +typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 timestamp);
> > > +
> > > +struct unwind_work {
> > > +	struct list_head		list;  
> > 
> > Does this really need to be a list? Single linked list like
> > callback_head not good enough?
> 
> Doesn't a list head make it easier to remove without having to iterate the
> list?

Yeah, but why would you ever want to remove it? You asked for an unwind,
you get an unwind, no?

> > >  static __always_inline void unwind_exit_to_user_mode(void)
> > >  {
> > >  	if (unlikely(current->unwind_info.cache))
> > >  		current->unwind_info.cache->nr_entries = 0;
> > > +	current->unwind_info.timestamp = 0;  
> > 
> > Surely clearing that timestamp is only relevant when there is a cache
> > around? Better to not add this unconditional write to the exit path.
> 
> That's actually not quite true. If the allocation fails, we still want to
> clear the timestamp. But later patches add more data to check and it does
> exit out if there's been no requests:

Well, you could put in an error value on alloc fail or somesuch. Then
its non-zero.

> But for better reviewing, I could add a comment in this patch that states
> that this will eventually exit out early when it does more work.

You're making this really hard to review, why not do it right from the
get-go?

> > > +/* Guards adding to and reading the list of callbacks */
> > > +static DEFINE_MUTEX(callback_mutex);
> > > +static LIST_HEAD(callbacks);  
> > 
> > Global state.. smells like failure.
> 
> Yes, the unwind infrastructure is global, as it is the way tasks know what
> tracer's callbacks to call.

Well, that's apparently how you've set it up. I don't immediately see
this has to be like this.

And there's no comments no nothing.

I don't see why you can't have something like:

struct unwind_work {
	struct callback_head task_work;
	void *data;
	void (*func)(struct unwind_work *work, void *data);
};

void unwind_task_work_func(struct callback_head *task_work)
{
	struct unwind_work *uw = container_of(task_work, struct unwind_work, task_work);

	// do actual unwind

	uw->func(uw, uw->data);
}

or something along those lines. No global state involved.


> > > +	guard(mutex)(&callback_mutex);
> > > +	list_for_each_entry(work, &callbacks, list) {
> > > +		work->func(work, &trace, timestamp);
> > > +	}  
> > 
> > So now you're globally serializing all return-to-user instances. How is
> > that not a problem?
> 
> It was the original way we did things. The next patch changes this to SRCU.
> But it requires a bit more care. For breaking up the series, I preferred
> not to add that logic and make it a separate patch.
> 
> For better reviewing, I'll add a comment here that says:
> 
> 	/* TODO switch this global lock to SRCU */

Oh ffs :-(

So splitting up patches is for ease of review, but now you're making
splits that make review harder, how does that make sense?


