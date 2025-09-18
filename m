Return-Path: <bpf+bounces-68799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57AB85864
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 17:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D111661F9
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB130CD8F;
	Thu, 18 Sep 2025 15:18:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437628466C;
	Thu, 18 Sep 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208682; cv=none; b=FRF2tqZ6+IKFgmVy3+0fIuVwj9D6pbgpSkdxUBZ8P+nTdIxGUNtFLg8ggSU0hrSKF8zCXjuCfZUSMMvBD+uopj4M9rgsFRSQ6/EUg0zAC9qMV9Ja5guHcV1boHgTHa/lDIo2DGaSkYADt6IDGm2JPlLP/EOIXwlR0Zygh0tEvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208682; c=relaxed/simple;
	bh=/qqM+OnbdxuaSsWAHehkRJ5d3NIG8IKHyVeXH3ttzOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGSVaDHnFlhrTFx9TrSGP49rx9aMQT4LhbJsGdUKYWf6qQlLGhMIoV8PyknE3ZdPDtQyO4FyjamaNJcBv1NNUtb5uza2YkxcvEq+5JKSwtExFh7a5aJ5D/3yGcLRYhba/ismb7DL3xVRyGuJ81L+RALA3iTEdvnt+lBbsThcHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 04853139686;
	Thu, 18 Sep 2025 15:17:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id A56D22001C;
	Thu, 18 Sep 2025 15:17:45 +0000 (UTC)
Date: Thu, 18 Sep 2025 11:18:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Florian Weimer
 <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Kees Cook
 <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>
Subject: Re: [RESEND][PATCH v15 0/4] perf: Support the deferred unwinding
 infrastructure
Message-ID: <20250918111853.5dc424df@gandalf.local.home>
In-Reply-To: <20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
References: <20250908171412.268168931@kernel.org>
	<20250918114610.GZ3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: m719uiotxajw89bojnoubs1mmbksosce
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: A56D22001C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18DtFopQGFaWtIxBTa3O6GGeiywGvx+DoQ=
X-HE-Tag: 1758208665-421618
X-HE-Meta: U2FsdGVkX1/VQb2NHcbL5LrPbBZ059FL5TbDk3IaTeCsyrBrjO8jdMYMlCjSbGX+5dkPlzWVRri9nJ7pgHA1QdUUnG5kr491vZMHqh48Tm92cgY2+4JrsEkA3qfCKdNFPQAJfCzYdJ3y+HjDal4h91QHNy9Bl/CkJQrk2Gao3P2ft/6vGAoDYL0D1AzOGHjuV0WFmjA0ciUU8vf2tdNnNqiNDi/3dE3xjSju756kDulC3/KRYZh0JwNZ7ZrZHMV5iwfJbsorQFMen1eOGdsHNVMFm2r00YYCXR5uRe3kGf9ElPOdv25Z5z6LTE7FsnFz30dtBrIvT10xBlMcMCKnrsQ5tBnt+BCt7KpxYsbetIbb6Vm2Cu1fD5kwODI5DoNj

On Thu, 18 Sep 2025 13:46:10 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> So I started looking at this, but given I never seen the deferred unwind
> bits that got merged I have to look at that first.
> 
> Headers want something like so.. Let me read the rest.
> 
> ---
>  include/linux/unwind_deferred.h       | 38 +++++++++++++++++++----------------
>  include/linux/unwind_deferred_types.h |  2 ++
>  2 files changed, 23 insertions(+), 17 deletions(-)

Would you like to send a formal patch with this? I'd actually break it into
two patches. One to clean up the long lines, and the other to change the
logic.

-- Steve


> 
> diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
> index 26122d00708a..5d51a3f2f8ec 100644
> --- a/include/linux/unwind_deferred.h
> +++ b/include/linux/unwind_deferred.h
> @@ -8,7 +8,8 @@
>  
>  struct unwind_work;
>  
> -typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie);
> +typedef void (*unwind_callback_t)(struct unwind_work *work,
> +				  struct unwind_stacktrace *trace, u64 cookie);
>  
>  struct unwind_work {
>  	struct list_head		list;
> @@ -44,22 +45,22 @@ void unwind_deferred_task_exit(struct task_struct *task);
>  static __always_inline void unwind_reset_info(void)
>  {
>  	struct unwind_task_info *info = &current->unwind_info;
> -	unsigned long bits;
> +	unsigned long bits = info->unwind_mask;
>  
>  	/* Was there any unwinding? */
> -	if (unlikely(info->unwind_mask)) {
> -		bits = info->unwind_mask;
> -		do {
> -			/* Is a task_work going to run again before going back */
> -			if (bits & UNWIND_PENDING)
> -				return;
> -		} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
> -		current->unwind_info.id.id = 0;
> +	if (likely(!bits))
> +		return;
>  
> -		if (unlikely(info->cache)) {
> -			info->cache->nr_entries = 0;
> -			info->cache->unwind_completed = 0;
> -		}
> +	do {
> +		/* Is a task_work going to run again before going back */
> +		if (bits & UNWIND_PENDING)
> +			return;
> +	} while (!try_cmpxchg(&info->unwind_mask, &bits, 0UL));
> +	current->unwind_info.id.id = 0;
> +
> +	if (unlikely(info->cache)) {
> +		info->cache->nr_entries = 0;
> +		info->cache->unwind_completed = 0;
>  	}
>  }
>  
> @@ -68,9 +69,12 @@ static __always_inline void unwind_reset_info(void)
>  static inline void unwind_task_init(struct task_struct *task) {}
>  static inline void unwind_task_free(struct task_struct *task) {}
>  
> -static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
> -static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
> -static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
> +static inline int unwind_user_faultable(struct unwind_stacktrace *trace)
> +{ return -ENOSYS; }
> +static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
> +{ return -ENOSYS; }
> +static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
> +{ return -ENOSYS; }
>  static inline void unwind_deferred_cancel(struct unwind_work *work) {}
>  
>  static inline void unwind_deferred_task_exit(struct task_struct *task) {}
> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> index 33b62ac25c86..29452ff49859 100644
> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
>  
> +#include <linux/types.h>
> +
>  struct unwind_cache {
>  	unsigned long		unwind_completed;
>  	unsigned int		nr_entries;


