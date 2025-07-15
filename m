Return-Path: <bpf+bounces-63319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C5B05A92
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 14:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D37168D4E
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 12:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAD21D590;
	Tue, 15 Jul 2025 12:49:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA231EF09D;
	Tue, 15 Jul 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583772; cv=none; b=NAVEGRQWLheSAkAxaK/nGqbcMih87FRlVr6kBTXBkpwFn5sKnmYkTJWAi+8wHcV08U5oWa4eRLMrv2AcCnufjqFYUXVPMg1xgLJ8u5pqthT4aYip+gTKPkMF3rr0YQnmJtqd/QhmYSlbNESYItr0JgEYP6XqZrn45WtbH3ZrDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583772; c=relaxed/simple;
	bh=v4S/Fj4BA1B8viFWJqUTH7JyIKCD1bp3x1HwshUmh5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sl1nJIbOo69nTCULldGzW4XSZ47c/GBKCywIuAR5ZLUH30jl2YgWs0l7pRDvnSj5bMjhga3P592NZt+w52UUTkw36rvZwOg+Ly/Wb74B07XCtzTh5fYmKaVSr37Bd6hetpw71yDEwGfIQq1rRFNVUXu6E61Fep47xyzPnxIFe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E51E814048D;
	Tue, 15 Jul 2025 12:49:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 6CF6F2E;
	Tue, 15 Jul 2025 12:49:16 +0000 (UTC)
Date: Tue, 15 Jul 2025 08:49:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>, Sam
 James <sam@gentoo.org>
Subject: Re: [PATCH v13 10/14] unwind: Clear unwind_mask on exit back to
 user space
Message-ID: <20250715084932.0563f532@gandalf.local.home>
In-Reply-To: <20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.345060579@kernel.org>
	<20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6CF6F2E
X-Stat-Signature: yexnwodxqt8ue8qfospadikka56s95yg
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/5/yy+laR4mZJUfsHY6UE/+evDZ7yBUf0=
X-HE-Tag: 1752583756-570069
X-HE-Meta: U2FsdGVkX18fnfS/TIlTqvL0E56yXq4ZGQ0F2sReWnZxhLcuy1yIV/H05NVLJWnU8vpPUs0HnzYeoh0U9gZ58X8dP4xI4zBA+8Br1N/Ly7TiLMFS5cSFrbZJBmPd/m1SDhMpqhPzGZrNZqA8LanxDYWAPaV3swXW8UMfsqOhD9ZDQVyhbc/lYf4dLxZFiqqHQEpyafUDvpON44zdzVPAqjUqwD05syVrERn1HPadhi7oyFl41oegTfk99eqYWqYKIKLbP8SE8gJV+Bu7cs3oWCRqAyxnufqP16QCFQHMI7zhsxb4U5WsKlXGEAWaREcdM4e8dGCsWWlEcxoHXHD3GIs9MfAV60QbNbL5LhMeLJnJ+nUV1g3holoyV6IujN4n

On Tue, 15 Jul 2025 12:29:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 07, 2025 at 09:22:49PM -0400, Steven Rostedt wrote:
> > diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
> > index 12bffdb0648e..587e120c0fd6 100644
> > --- a/include/linux/unwind_deferred.h
> > +++ b/include/linux/unwind_deferred.h
> > @@ -18,6 +18,14 @@ struct unwind_work {
> >  
> >  #ifdef CONFIG_UNWIND_USER
> >  
> > +#define UNWIND_PENDING_BIT	(BITS_PER_LONG - 1)
> > +#define UNWIND_PENDING		BIT(UNWIND_PENDING_BIT)  
> 
> Since it really didn't matter what bit you took, why not take bit 0?

I was worried about it affecting the global unwind_mask test, but I guess
bit zero works too. In fact, I think I could just set the PENDING and USED
(see next patch) bits in the global unwind mask as being already "used" and
then change:

	/* See if there's a bit in the mask available */
	if (unwind_mask == ~(UNWIND_PENDING|UNWIND_USED))
		return -EBUSY;

Back to:

	/* See if there's a bit in the mask available */
	if (unwind_mask == ~0UL)
		return -EBUSY;

> 


> >  /*
> >   * This is a unique percpu identifier for a given task entry context.
> >   * Conceptually, it's incremented every time the CPU enters the kernel from
> > @@ -143,14 +148,17 @@ static void unwind_deferred_task_work(struct callback_head *head)
> >  	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
> >  	struct unwind_stacktrace trace;
> >  	struct unwind_work *work;
> > +	unsigned long bits;
> >  	u64 cookie;
> >  	int idx;
> >  
> > -	if (WARN_ON_ONCE(!local_read(&info->pending)))
> > +	if (WARN_ON_ONCE(!unwind_pending(info)))
> >  		return;
> >  
> > -	/* Allow work to come in again */
> > -	local_set(&info->pending, 0);
> > +	/* Clear pending bit but make sure to have the current bits */
> > +	bits = READ_ONCE(info->unwind_mask);
> > +	while (!try_cmpxchg(&info->unwind_mask, &bits, bits & ~UNWIND_PENDING))
> > +		;  
> 
> We have:
> 
> 	bits = atomic_long_fetch_andnot(UNWIND_PENDING, &info->unwind_mask);
> 
> for that. A fair number of architecture can actually do this better than
> a cmpxchg loop.

Thanks, I didn't know about that one.

> 
> >  
> >  	/*
> >  	 * From here on out, the callback must always be called, even if it's
> > @@ -166,10 +174,8 @@ static void unwind_deferred_task_work(struct callback_head *head)
> >  	idx = srcu_read_lock(&unwind_srcu);
> >  	list_for_each_entry_srcu(work, &callbacks, list,
> >  				 srcu_read_lock_held(&unwind_srcu)) {
> > -		if (test_bit(work->bit, &info->unwind_mask)) {
> > +		if (test_bit(work->bit, &bits))
> >  			work->func(work, &trace, cookie);
> > -			clear_bit(work->bit, &info->unwind_mask);
> > -		}
> >  	}
> >  	srcu_read_unlock(&unwind_srcu, idx);
> >  }
> > @@ -194,15 +200,17 @@ static void unwind_deferred_task_work(struct callback_head *head)
> >   * because it has already been previously called for the same entry context,
> >   * it will be called again with the same stack trace and cookie.
> >   *
> > - * Return: 1 if the the callback was already queued.
> > - *         0 if the callback successfully was queued.
> > + * Return: 0 if the callback successfully was queued.
> > + *         UNWIND_ALREADY_PENDING if the the callback was already queued.
> > + *         UNWIND_ALREADY_EXECUTED if the callback was already called
> > + *                (and will not be called again)
> >   *         Negative if there's an error.
> >   *         @cookie holds the cookie of the first request by any user
> >   */  
> 
> Lots of babbling in the Changelog, but no real elucidation as to why you
> need this second return value.
> 
> AFAICT it serves no real purpose; the users of this function should not
> care. The only difference is that the unwind reference (your cookie)
> becomes a backward reference instead of a forward reference. But why
> would anybody care?

Older versions of the code required it. I think I can remove it now.

> 
> Whatever tool is ultimately in charge of gluing humpty^Wstacktraces back
> together again should have no problem with this.
> 
> >  int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
> >  {
> >  	struct unwind_task_info *info = &current->unwind_info;
> > -	long pending;
> > +	unsigned long old, bits;
> >  	int bit;
> >  	int ret;
> >  
> > @@ -225,32 +233,52 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
> >  
> >  	*cookie = get_cookie(info);
> >  
> > -	/* This is already queued */
> > -	if (test_bit(bit, &info->unwind_mask))
> > -		return 1;
> > +	old = READ_ONCE(info->unwind_mask);
> > +
> > +	/* Is this already queued */
> > +	if (test_bit(bit, &old)) {
> > +		/*
> > +		 * If pending is not set, it means this work's callback
> > +		 * was already called.
> > +		 */
> > +		return old & UNWIND_PENDING ? UNWIND_ALREADY_PENDING :
> > +			UNWIND_ALREADY_EXECUTED;
> > +	}
> >  
> > -	/* callback already pending? */
> > -	pending = local_read(&info->pending);
> > -	if (pending)
> > +	if (unwind_pending(info))
> >  		goto out;
> >  
> > +	/*
> > +	 * This is the first to enable another task_work for this task since
> > +	 * the task entered the kernel, or had already called the callbacks.
> > +	 * Set only the bit for this work and clear all others as they have
> > +	 * already had their callbacks called, and do not need to call them
> > +	 * again because of this work.
> > +	 */
> > +	bits = UNWIND_PENDING | BIT(bit);
> > +
> > +	/*
> > +	 * If the cmpxchg() fails, it means that an NMI came in and set
> > +	 * the pending bit as well as cleared the other bits. Just
> > +	 * jump to setting the bit for this work.
> > +	 */
> >  	if (CAN_USE_IN_NMI) {
> > -		/* Claim the work unless an NMI just now swooped in to do so. */
> > -		if (!local_try_cmpxchg(&info->pending, &pending, 1))
> > +		if (!try_cmpxchg(&info->unwind_mask, &old, bits))
> >  			goto out;
> >  	} else {
> > -		local_set(&info->pending, 1);
> > +		info->unwind_mask = bits;
> >  	}
> >  
> >  	/* The work has been claimed, now schedule it. */
> >  	ret = task_work_add(current, &info->work, TWA_RESUME);
> > -	if (WARN_ON_ONCE(ret)) {
> > -		local_set(&info->pending, 0);
> > -		return ret;
> > -	}
> >  
> > +	if (WARN_ON_ONCE(ret))
> > +		WRITE_ONCE(info->unwind_mask, 0);
> > +
> > +	return ret;
> >   out:
> > -	return test_and_set_bit(bit, &info->unwind_mask);
> > +	return test_and_set_bit(bit, &info->unwind_mask) ?
> > +		UNWIND_ALREADY_PENDING : 0;
> >  }  
> 
> This is some of the most horrifyingly confused code I've seen in a
> while.
> 
> Please just slow down and think for a minute.
> 
> The below is the last four patches rolled into one. Not been near a
> compiler.

Are you recommending that I fold those patches into one?

I'm fine with that. Note, part of the way things are broken up is because I
took Josh's code and built on top of his work. I tend to try not to modify
someone else's code when doing that and make building blocks of each stage.

Also, it follows the way I tend to review code. Which is to take the entire
patch set, apply it, then look at each patch compared to the final result.

That probably explains why my patch series is confusing for you, as it was
written more for the way I review. Sorry about that.

-- Steve

