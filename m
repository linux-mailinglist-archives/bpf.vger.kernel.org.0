Return-Path: <bpf+bounces-61051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32DCAE009E
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA691899FE7
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D1265630;
	Thu, 19 Jun 2025 08:57:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C63200127;
	Thu, 19 Jun 2025 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323428; cv=none; b=ehOvxqHLr4S9q2KcJuSpYwsarzD0jYoYbtyOLmzgbpFF+p8lyjYQMPW8TLWGfuk8cSYlYB+3nCHsSRVXXIItSXcdTfJ6ZaP5BBYt3jt24jKvkxIi4vViPdVmLkFsgqH3+bGyBCK3CujGAWK4A/RVLeF5r+BtiVp8iWlVlJsiVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323428; c=relaxed/simple;
	bh=gfcuIFYhCl06aO8xfJLg9ceocBYaD3OMpX+RmyKMhbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S05D0BzL1s1FifKtCBs6qgCkcUcEPJ8EMDZlzoO1+Fwv6cmO2yu1rdJDbhbiObJSTCW5c1Uj0yIbX/ztC+Qlo99N6+Nw5xAKXeRNrvAn1HI2RGVERCoq1w8MWMsS+8dlIZTBzyMrqdNeZFdzddYh8zsLwmEsO6pwTw2vZ1R9lDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 67F33806F6;
	Thu, 19 Jun 2025 08:57:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 21AFF20035;
	Thu, 19 Jun 2025 08:56:55 +0000 (UTC)
Date: Thu, 19 Jun 2025 04:56:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v10 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250619045659.390cc014@batman.local.home>
In-Reply-To: <20250619075008.GU1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.770214773@goodmis.org>
	<20250618184620.GT1613376@noisy.programming.kicks-ass.net>
	<20250618150915.3e811f4b@gandalf.local.home>
	<20250619075008.GU1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 21AFF20035
X-Rspamd-Server: rspamout08
X-Stat-Signature: 93qcbrc46ffetio7ugxpb7t8s9ocaspu
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/GSAyh9tSEN32gmKXjkVBA2dq3LBhuMTE=
X-HE-Tag: 1750323415-985225
X-HE-Meta: U2FsdGVkX19A2hskoL8tdAMlOvZDhLq1M9SkWRs+0wMFWomrgmfltfYaVBcVlfQwH13aERtTBd3Fbj+tqCDV2m9xFzg9kq5USczg8q6SOMZakeTeqtDqgQkZh+5kY6TvsQQYSN9mJv7cvQUOxEfw8R1pB/DqKR2LX4FFY3N3fVWEF+tGP05OHIRCM4/U17AHDlMii6JAc+x4pxiWbAkSGMuUh7J0N+6n6/k4Gt4Iu6t1Vi0vuVd13va6FtFw1Tg9IFkw7k6EDX1jpFGSXZMxUaKsbv7pST+ZXpXzWgIXlPsjRW/90g6oeobsguhCs6oiGWUADYYbReh3Kh3TiOdC6Zyv2YfyWcu1or2bh6b7a2Ft+DZP4rDg0yCUPzW7udCU

On Thu, 19 Jun 2025 09:50:08 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jun 18, 2025 at 03:09:15PM -0400, Steven Rostedt wrote:
> > On Wed, 18 Jun 2025 20:46:20 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > > +struct unwind_work;
> > > > +
> > > > +typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 timestamp);
> > > > +
> > > > +struct unwind_work {
> > > > +	struct list_head		list;    
> > > 
> > > Does this really need to be a list? Single linked list like
> > > callback_head not good enough?  
> > 
> > Doesn't a list head make it easier to remove without having to iterate the
> > list?  
> 
> Yeah, but why would you ever want to remove it? You asked for an unwind,
> you get an unwind, no?

No, it's not unique per tracing infrastructure, but tracing instance.
That is, per perf program, or per tracing instance. It needs to be
removed.

> 
> > > >  static __always_inline void unwind_exit_to_user_mode(void)
> > > >  {
> > > >  	if (unlikely(current->unwind_info.cache))
> > > >  		current->unwind_info.cache->nr_entries = 0;
> > > > +	current->unwind_info.timestamp = 0;    
> > > 
> > > Surely clearing that timestamp is only relevant when there is a cache
> > > around? Better to not add this unconditional write to the exit path.  
> > 
> > That's actually not quite true. If the allocation fails, we still want to
> > clear the timestamp. But later patches add more data to check and it does
> > exit out if there's been no requests:  
> 
> Well, you could put in an error value on alloc fail or somesuch. Then
> its non-zero.

OK.

> 
> > But for better reviewing, I could add a comment in this patch that states
> > that this will eventually exit out early when it does more work.  
> 
> You're making this really hard to review, why not do it right from the
> get-go?

Because the value that is to be checked isn't here yet.

> 
> > > > +/* Guards adding to and reading the list of callbacks */
> > > > +static DEFINE_MUTEX(callback_mutex);
> > > > +static LIST_HEAD(callbacks);    
> > > 
> > > Global state.. smells like failure.  
> > 
> > Yes, the unwind infrastructure is global, as it is the way tasks know what
> > tracer's callbacks to call.  
> 
> Well, that's apparently how you've set it up. I don't immediately see
> this has to be like this.
> 
> And there's no comments no nothing.
> 
> I don't see why you can't have something like:
> 
> struct unwind_work {
> 	struct callback_head task_work;
> 	void *data;
> 	void (*func)(struct unwind_work *work, void *data);
> };
> 
> void unwind_task_work_func(struct callback_head *task_work)
> {
> 	struct unwind_work *uw = container_of(task_work, struct unwind_work, task_work);
> 
> 	// do actual unwind
> 
> 	uw->func(uw, uw->data);
> }
> 
> or something along those lines. No global state involved.

We have a many to many relationship here where a task_work doesn't work.

That is, you can have a tracer that expects callbacks from several
tasks at the same time, as well as some of those tasks expect to send a
callback to different tracers.

Later patches add a bitmask to every task that gets set to know which
trace to use.

Since the number of tracers that can be called back is fixed to the
number of bits in long (for the bitmask), I can get rid of the link
list and make it into an array. That would make this easier.


> 
> 
> > > > +	guard(mutex)(&callback_mutex);
> > > > +	list_for_each_entry(work, &callbacks, list) {
> > > > +		work->func(work, &trace, timestamp);
> > > > +	}    
> > > 
> > > So now you're globally serializing all return-to-user instances. How is
> > > that not a problem?  
> > 
> > It was the original way we did things. The next patch changes this to SRCU.
> > But it requires a bit more care. For breaking up the series, I preferred
> > not to add that logic and make it a separate patch.
> > 
> > For better reviewing, I'll add a comment here that says:
> > 
> > 	/* TODO switch this global lock to SRCU */  
> 
> Oh ffs :-(
> 
> So splitting up patches is for ease of review, but now you're making
> splits that make review harder, how does that make sense?

Actually, a comment isn't the right place, I should have mentioned this
in the change log.

-- Steve

