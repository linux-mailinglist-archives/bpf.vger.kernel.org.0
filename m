Return-Path: <bpf+bounces-63473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FEDB07CE4
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 20:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A871C41C40
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A218E29A30D;
	Wed, 16 Jul 2025 18:26:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C8299AB1;
	Wed, 16 Jul 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690383; cv=none; b=qj77B8WQFaJsqzviNUO3cNGa68ttJUOe9QVcs/5Tn0yOFnUOHFWjgZRWJxpwP0Er6YtMQSq0f32RpJoVSIV++I0vr3JDdmXyfUCKo+aMvDiPWXU3lrcNMb8hL3ituB8QMkvZAb3jQTVAJkzVhLfdLj5fowqxAzcRTVOz/IW1ZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690383; c=relaxed/simple;
	bh=XzpgU7jl/zpAfUMEFHo0K1KXG3Oiqgp651zOZTVwv/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkHElJ5NmrJxtpEML29W8ClFAEZp4OAK2vFfscqctFlxsK9iPANa3xCrlzPel4O1VIoykCBnHmmb6d4v6Vlv+8nC0LR3SNFHIlDb8oOtMbZA5jZtgIy6dfMqEOQSv1GbhpDK51oqYlZ+YlQJ04L/43y1tEHNzHb9yN4R0jR4Q7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 5AB6210FCB2;
	Wed, 16 Jul 2025 18:26:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id AAE451C;
	Wed, 16 Jul 2025 18:26:10 +0000 (UTC)
Date: Wed, 16 Jul 2025 14:26:09 -0400
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
Message-ID: <20250716142609.47f0e4a5@batman.local.home>
In-Reply-To: <20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
References: <20250708012239.268642741@kernel.org>
	<20250708012359.345060579@kernel.org>
	<20250715102912.GQ1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: AAE451C
X-Stat-Signature: axpt9nptznm8di1wxstaxcbqkwqzigw1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/PWOeFhq+1iBqv5Jz8IESvBHKT5u4Gdmk=
X-HE-Tag: 1752690370-713770
X-HE-Meta: U2FsdGVkX19X2p8S26zainYyCRQRlNq+Gt0Aaey/HsEXn6oTubLKF+mNLCQCZAojQyy2k04Y6mlvkfQAzwlN72jOd7BvBd2Y1A6+zsKysDZGIRqumosaUARILqOjTPxj7z0XWwoPpJD+Wg70Xhy3yEIKNzCTHrq2Xiqmn+AelJsE1mW3zHRpx1VV71DCQdewNYZ+so3zSElenfRjRDqxN9KTbMDfUus17kTdz9V9LuuSdFhvdBopjuvz8szljVzSM3eBgcJwr8s515D2Gaj/NFsfObE3NGr0oBpWMcE9+AoiG97g1T3JQxH8NyeY+D/ZGHDZIe5J4Ry8Y28fQzTJ7bKp18fq0x77Ajqy/YELaQ0dYunIIBveKVg4kvwMuJyb

On Tue, 15 Jul 2025 12:29:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 07, 2025 at 09:22:49PM -0400, Steven Rostedt wrote:
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

The above is still needed as is (explained below).


> @@ -170,41 +193,62 @@ static void unwind_deferred_task_work(st
>  int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>  {
>  	struct unwind_task_info *info = &current->unwind_info;
> -	int ret;
> +	unsigned long bits, mask;
> +	int bit, ret;
>  
>  	*cookie = 0;
>  
> -	if (WARN_ON_ONCE(in_nmi()))
> -		return -EINVAL;
> -
>  	if ((current->flags & (PF_KTHREAD | PF_EXITING)) ||
>  	    !user_mode(task_pt_regs(current)))
>  		return -EINVAL;
>  
> +	/* NMI requires having safe cmpxchg operations */
> +	if (WARN_ON_ONCE(!UNWIND_NMI_SAFE && in_nmi()))
> +		return -EINVAL;
> +
> +	/* Do not allow cancelled works to request again */
> +	bit = READ_ONCE(work->bit);
> +	if (WARN_ON_ONCE(bit < 0))
> +		return -EINVAL;
> +
>  	guard(irqsave)();
>  
>  	*cookie = get_cookie(info);
>  
> -	/* callback already pending? */
> -	if (info->pending)
> +	bits = UNWIND_PENDING | BIT(bit);
> +	mask = atomic_long_fetch_or(bits, &info->unwind_mask);
> +	if (mask & bits)
>  		return 1;


So the fetch_or() isn't good enough for what needs to be done, and why
the code above is the way it is.

We have this scenario:


  perf and ftrace are both tracing the same task. perf with bit 1 and
  ftrace with bit 2. Let's say there's even another perf program
  running and registered bit 3.


  perf requests a deferred callback, and info->unwind_mask gets bit 1
  and the pending bit set.

  The task is exiting to user space and calls perf's callback and
  clears the pending bit but keeps perf's bit set as it was already
  called, and doesn't need to be called again even if perf requests a
  new stacktrace before the task gets back to user space.

  Now before the task gets back to user space, ftrace requests the
  deferred trace. To do so, it must set the pending bit and its bit,
  but it must also clear the perf bit as it should not call perf's
  callback again.

The atomic_long_fetch_or() above will set ftrace's bit but not clear
perf's bits and the perf callback will get called a second time even
though perf never requested another callback.

This is why the code at the top has:

	bits = UNWIND_PENDING | BIT(bit);

	/*
	 * If the cmpxchg() fails, it means that an NMI came in and set
	 * the pending bit as well as cleared the other bits. Just
	 * jump to setting the bit for this work.
	 */
	if (CAN_USE_IN_NMI) {
		/* Claim the work unless an NMI just now swooped in to do so. */
		if (!local_try_cmpxchg(&info->pending, &pending, 1))
		if (!try_cmpxchg(&info->unwind_mask, &old, bits))
			goto out;

That cmpxchg() clears out any of the old bits if pending isn't set. Now
if an NMI came in and the other perf process requested a callback, it
would set its own bit plus the pending bit and then ftrace only needs
to jump to the end and do the test_and_set on its bit.

-- Steve


>  
>  	/* The work has been claimed, now schedule it. */
>  	ret = task_work_add(current, &info->work, TWA_RESUME);
>  	if (WARN_ON_ONCE(ret))
> -		return ret;
> -
> -	info->pending = 1;
> -	return 0;
> +		atomic_long_set(0, &info->unwind_mask);
>  }
>  

