Return-Path: <bpf+bounces-64861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7B3B17A9F
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 02:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E9B54695E
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 00:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7E6BE49;
	Fri,  1 Aug 2025 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no9uVix6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213998F40;
	Fri,  1 Aug 2025 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008185; cv=none; b=dsfiRvklim7UWU6k8rVYVb5XspMo1CsrRgbeJVdm/W10V2A+OmBoSKH+kGm1Y5dWarq7jvoE+W3cmqP/GyA5Wxq5NaEIosl22cD8sI5iwKntdRHr2M/STWQdyBBfAmfrfh/iLi7PH8uqoqQttitG8tF4B/m793bzuKnEOjcgWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008185; c=relaxed/simple;
	bh=eZgXmtVleqBOW2a9EhVWZV3RbUp8RIO3Kyrj/CMoaP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhUzFIxBrDy/bAqnAR3X7vwUdyh6V2LDwrSiOA57ALrRCawLRKl6pl58B5a3HMA43rq1ObrLXc4V4mRo+NN52HskKGkRjT7iTtADYNqB274Yzhupl7QCvmeRSZVDMinqqJ9CGKkjChSP/OsfEvIX5A5JaJXj00/IPwKtXmAVwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no9uVix6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F912C4CEEF;
	Fri,  1 Aug 2025 00:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754008184;
	bh=eZgXmtVleqBOW2a9EhVWZV3RbUp8RIO3Kyrj/CMoaP4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=no9uVix6afnOBiymx4pq2a/XjiwyLroJSmeFDpg9ocCAHSNVTEJH2cTtKNRfJhgvX
	 +WNtGUcU3DJuUSesVwjGKvWOPfI0AV30FXiYYJC9Wlm7JaApQSffkC14N1kDKYLc3S
	 z2ptC81L6WP7o5tuMQ2yGmji584d3RGre8Juy0dMPibngWGiCbleXYIeEpSyOr5q9a
	 s08SGMrShIQ+RtMPd/GmRwCCevnWZLoPx+mIuIAXPs9nrLZ/euQ9Fbr+mY2dIrnCZm
	 /y+Cmkl0Uq2fMJ/lCjbEE36H12Oe/AvX3mBeDXuvfR7EUwaagD9kY6DfRA1lTVdyr8
	 q6IaTQrYjLpYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2F2D6CE0A73; Thu, 31 Jul 2025 17:29:44 -0700 (PDT)
Date: Thu, 31 Jul 2025 17:29:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v16 09/10] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <21c67d70-d8c2-4d6b-99d8-2de8f2966621@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250729182304.965835871@kernel.org>
 <20250729182406.331548065@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729182406.331548065@kernel.org>

On Tue, Jul 29, 2025 at 02:23:13PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Instead of using the callback_mutex to protect the link list of callbacks
> in unwind_deferred_task_work(), use SRCU instead. This gets called every
> time a task exits that has to record a stack trace that was requested.
> This can happen for many tasks on several CPUs at the same time. A mutex
> is a bottleneck and can cause a bit of contention and slow down performance.
> 
> As the callbacks themselves are allowed to sleep, regular RCU cannot be
> used to protect the list. Instead use SRCU, as that still allows the
> callbacks to sleep and the list can be read without needing to hold the
> callback_mutex.
> 
> Link: https://lore.kernel.org/all/ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com/
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

One quite likely stupid question below.

							Thanx, Paul

> ---
>  kernel/unwind/deferred.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index 2311b725d691..a5ef1c1f915e 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -41,7 +41,7 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
>  #define UNWIND_MAX_ENTRIES					\
>  	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
>  
> -/* Guards adding to and reading the list of callbacks */
> +/* Guards adding to or removing from the list of callbacks */
>  static DEFINE_MUTEX(callback_mutex);
>  static LIST_HEAD(callbacks);
>  
> @@ -49,6 +49,7 @@ static LIST_HEAD(callbacks);
>  
>  /* Zero'd bits are available for assigning callback users */
>  static unsigned long unwind_mask = RESERVED_BITS;
> +DEFINE_STATIC_SRCU(unwind_srcu);
>  
>  static inline bool unwind_pending(struct unwind_task_info *info)
>  {
> @@ -174,8 +175,9 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  
>  	cookie = info->id.id;
>  
> -	guard(mutex)(&callback_mutex);
> -	list_for_each_entry(work, &callbacks, list) {
> +	guard(srcu)(&unwind_srcu);
> +	list_for_each_entry_srcu(work, &callbacks, list,
> +				 srcu_read_lock_held(&unwind_srcu)) {
>  		if (test_bit(work->bit, &bits)) {
>  			work->func(work, &trace, cookie);
>  			if (info->cache)
> @@ -213,7 +215,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>  {
>  	struct unwind_task_info *info = &current->unwind_info;
>  	unsigned long old, bits;
> -	unsigned long bit = BIT(work->bit);
> +	unsigned long bit;
>  	int ret;
>  
>  	*cookie = 0;
> @@ -230,6 +232,14 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
>  	if (WARN_ON_ONCE(!CAN_USE_IN_NMI && in_nmi()))
>  		return -EINVAL;
>  
> +	/* Do not allow cancelled works to request again */
> +	bit = READ_ONCE(work->bit);
> +	if (WARN_ON_ONCE(bit < 0))
> +		return -EINVAL;
> +
> +	/* Only need the mask now */
> +	bit = BIT(bit);
> +
>  	guard(irqsave)();
>  
>  	*cookie = get_cookie(info);
> @@ -281,10 +291,15 @@ void unwind_deferred_cancel(struct unwind_work *work)
>  		return;
>  
>  	guard(mutex)(&callback_mutex);
> -	list_del(&work->list);

What happens if unwind_deferred_task_work() finds this item right here...

> +	list_del_rcu(&work->list);

...and then unwind_deferred_request() does its WARN_ON_ONCE() check
against -1 right here?

Can't that cause UAF?

This is quite possibly a stupid question because I am not seeing where to
apply this patch, so I don't know what other mechanisms might be in place.

> +	/* Do not allow any more requests and prevent callbacks */
> +	work->bit = -1;
>  
>  	__clear_bit(bit, &unwind_mask);
>  
> +	synchronize_srcu(&unwind_srcu);
> +
>  	guard(rcu)();
>  	/* Clear this bit from all threads */
>  	for_each_process_thread(g, t) {
> @@ -307,7 +322,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
>  	work->bit = ffz(unwind_mask);
>  	__set_bit(work->bit, &unwind_mask);
>  
> -	list_add(&work->list, &callbacks);
> +	list_add_rcu(&work->list, &callbacks);
>  	work->func = func;
>  	return 0;
>  }
> -- 
> 2.47.2
> 
> 

