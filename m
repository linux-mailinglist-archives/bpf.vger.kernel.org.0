Return-Path: <bpf+bounces-63376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE4B06901
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DE5565A10
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 22:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635972BEC41;
	Tue, 15 Jul 2025 22:01:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0245945;
	Tue, 15 Jul 2025 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752616884; cv=none; b=SCnYl93i6GPyfq7iKOKiXSK/WFd6Z8xxlEnZ+qi3mu9mLjGyErrctEQ9ckHbfsENUyhZL6WDC8Yi+IykmCaUrKbCjMGG0lWxnK/BKS7Ea/ogLDWXYfdBfDasZEzdJ39m1pY1F17VzVQaWbG1RKPALdIJ4yzic2H6GrkCtsve9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752616884; c=relaxed/simple;
	bh=VIKRw06pGE2/3puvs1e2lNmGY2lvMx6DwWfE6MV66WI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psKbtVu7YaxF/s7MMry0GP7looAtmHCaxXUqwmFfDR5v+GpD5NYEZdB0NezSuHQRNXAh4gdxYIUOItCi/HnFJ4fGl2O3EYNKKs0QqvHX9g6dQxNJLyGAu2F+NJTrDM2fNVMoTDDXGtzxvOrE6R67FeZYyBbnZGhtYij8sFACKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 0133E12B3C0;
	Tue, 15 Jul 2025 22:01:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 2B7EB18;
	Tue, 15 Jul 2025 22:01:06 +0000 (UTC)
Date: Tue, 15 Jul 2025 18:01:05 -0400
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
Message-ID: <20250715180105.2a36560a@batman.local.home>
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
X-Stat-Signature: 318wnxsifrjw9hrdnoxb3rqssc8wnpj4
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2B7EB18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/NNwN0TIKShUMbuKenhraq5IABVHHjb7U=
X-HE-Tag: 1752616866-522475
X-HE-Meta: U2FsdGVkX19Zl+x3EINDkb0eDwqz4ng8mKFqqTtyydAMOYsUrKwf4Tms8KzAjALEnRlfvUTEsJPBSf1I7/cmDXddtL5vBWM9mlwpsj7Sbgy2rrHD1ByMOG/Sjx4UYT2zsaNarhAfMI9+o/jBNmzYFnA9Is0nezV4rN0Zapo7vK0QbEXZe9gOPyMebyn46Nj8CwtVcSjDSPBco9gFlo0oN20MVLpRyIuZxLtYSrT7/lCk7fD6UjYsaxwX4hsGVD3NrO9wnCC52YpXyb3c+GHs6DQtkCSHBSA8rRrdDoKQ7V4Zw2REelzQ0VQmhPHKBVSiPN6Klv/xKWs+PjA1OfUF9UUDzo8i/RFrhBBjXnhj8Ak6U5ZIj4j+P/XL/l22fYIU

On Tue, 15 Jul 2025 12:29:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> The below is the last four patches rolled into one. Not been near a
> compiler.

And it shows ;-)

> @@ -117,13 +138,13 @@ static void unwind_deferred_task_work(st
>  	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
>  	struct unwind_stacktrace trace;
>  	struct unwind_work *work;
> +	unsigned long bits;
>  	u64 cookie;
>  
> -	if (WARN_ON_ONCE(!info->pending))
> +	if (WARN_ON_ONCE(!unwind_pending(info)))
>  		return;
>  
> -	/* Allow work to come in again */
> -	WRITE_ONCE(info->pending, 0);
> +	bits = atomic_long_fetch_andnot(UNWIND_PENDING, &info->unwind_mask);

I may need to do what other parts of the kernel has done and turn the
above into:

	bits = atomic_long_fetch_andnot(UNWIND_PENDING, (atomic_long_t *)&info->unwind_mask);

As there's other bit manipulations that atomic_long does not take care
of and it's making the code more confusing. When I looked to see how
other users of atomic_long_andnot() did things, most just typecasted
the value to use that function :-/

-- Steve


>  
>  	/*
>  	 * From here on out, the callback must always be called, even if it's
> @@ -136,9 +157,11 @@ static void unwind_deferred_task_work(st
>  
>  	cookie = info->id.id;
>  
> -	guard(mutex)(&callback_mutex);
> -	list_for_each_entry(work, &callbacks, list) {
> -		work->func(work, &trace, cookie);
> +	guard(srcu_lite)(&unwind_srcu);
> +	list_for_each_entry_srcu(work, &callbacks, list,
> +				 srcu_read_lock_held(&unwind_srcu)) {
> +		if (test_bit(work->bit, &bits))
> +			work->func(work, &trace, cookie);
>  	}
>  }
>  
> @@ -162,7 +185,7 @@ static void unwind_deferred_task_work(st
>   * because it has already been previously called for the same entry context,
>   * it will be called again with the same stack trace and cookie.
>   *
> - * Return: 1 if the the callback was already queued.
> + * Return: 1 if the callback was already queued.
>   *         0 if the callback successfully was queued.
>   *         Negative if there's an error.
>   *         @cookie holds the cookie of the first request by any user

