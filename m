Return-Path: <bpf+bounces-63561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF29B08420
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 06:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825F316B55A
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 04:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354C81FBEB0;
	Thu, 17 Jul 2025 04:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ8N7/0Y"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789E17A309;
	Thu, 17 Jul 2025 04:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752727428; cv=none; b=gRJVnVrqBkTMFn00KTxJnB466DLsM+Z0yAUonZR9iMn1usXpGetVn2EnuBLdlduKNrUizoJVEspmCtvfJ26q/z2RsxDmdYuQJtvJtj8UawBQn7lKqNVBmpD/hb033BVkm/g6L4YpLm9NWpIra1IhN3GD9SWaMGREwcupkDV7XRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752727428; c=relaxed/simple;
	bh=6lVvVHz/c5X9krXweCRNUBaPhyNHQY6SALOUx6VGQ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B26lza6V+BuhGVKi8brBWq+M9GoN0NWA9iFj0JiiC2//jEXS5cVMVL25G5Wxwkzb22I39+FrdFXyILMUUosfJyC4PLek7SHUFTS1P5ibPbHaKCtlDGIqcaveXzkocurvsbDr2kMQiC4ag/PkN7Zw0n58tE/UPAB3+w/jNMeh7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZ8N7/0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098CAC4CEE3;
	Thu, 17 Jul 2025 04:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752727428;
	bh=6lVvVHz/c5X9krXweCRNUBaPhyNHQY6SALOUx6VGQ9A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iZ8N7/0YgvIEj/vvRSbQQETKGqVXhSZpCk/nzcT97njNqO2ZqHujfIUkk1QSlbj5Z
	 kEp71si3ohw3ylbNgl5JxzlTnlHnCbJt8rGzXiHUsHEUrexfut5Y8HK6f81FU9vuvk
	 qwvf5Cy5Q2W9IdMvlLnVotEHD1HfzWB+TZUXEpiEwN/jK3QfKGq35jrnG6bf3CStfI
	 upm8KbS1ZTTjXCWnvAXymIdZX61AnzS63vmEEeItBqCZb0PljRaqSaeLPYqzDbpie3
	 kFyAaJMJGbJPao+CYMQ8HxDdV8NEosGkqIHgZIQUgcyEOVGR4N71whAW6M0D21dXXK
	 0quFZO5u91niA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A8B84CE09C2; Wed, 16 Jul 2025 21:43:47 -0700 (PDT)
Date: Wed, 16 Jul 2025 21:43:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org, x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
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
Subject: Re: [PATCH v14 09/12] unwind deferred: Use SRCU
 unwind_deferred_task_work()
Message-ID: <47c3b0df-9f11-4e14-97e2-0f3ba3b09855@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250717004910.297898999@kernel.org>
 <20250717004957.918908732@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717004957.918908732@kernel.org>

On Wed, Jul 16, 2025 at 08:49:19PM -0400, Steven Rostedt wrote:
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
> Also added a new guard (srcu_lite) written by Peter Zilstra
> 
> Link: https://lore.kernel.org/all/20250715102912.GQ1613200@noisy.programming.kicks-ass.net/
> 
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v13: https://lore.kernel.org/20250708012359.172959778@kernel.org
> 
> - Have the locking of the link list walk use guard(srcu_lite)
>   (Peter Zijlstra)
> 
> - Fixed up due to the new atomic_long logic.
> 
>  include/linux/srcu.h     |  4 ++++
>  kernel/unwind/deferred.c | 27 +++++++++++++++++++++------
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 900b0d5c05f5..879054b8bf87 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -524,4 +524,8 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
>  		    srcu_read_unlock(_T->lock, _T->idx),
>  		    int idx)
>  
> +DEFINE_LOCK_GUARD_1(srcu_lite, struct srcu_struct,

You need srcu_fast because srcu_lite is being removed.  They are quite
similar, but srcu_fast is faster and is NMI-safe.  (This last might or
might not matter here.)

See https://lore.kernel.org/all/20250716225418.3014815-3-paulmck@kernel.org/
for a srcu_fast_notrace, so something like this:

DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
		    _T->scp = srcu_read_lock_fast(_T->lock),
		    srcu_read_unlock_fast(_T->lock, _T->scp),
		    struct srcu_ctr __percpu *scp)

Other than that, it looks plausible.

							Thanx, Paul

> +		    _T->idx = srcu_read_lock_lite(_T->lock),
> +		    srcu_read_unlock_lite(_T->lock, _T->idx),
> +		    int idx)
>  #endif
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index 2311b725d691..353f7af610bf 100644
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
> +	guard(srcu_lite)(&unwind_srcu);
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
> +	list_del_rcu(&work->list);
> +
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

