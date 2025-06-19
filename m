Return-Path: <bpf+bounces-61040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD62ADFFE3
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051BB4A13D7
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB688265CAF;
	Thu, 19 Jun 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WF+wGXau"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BFF25EFBB;
	Thu, 19 Jun 2025 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322068; cv=none; b=Yk/A62C8hPoijZ2loCAgWmeG8TiQCctxHsIP8mk6UGG0AZRHrpSrHN6zZlAmbf3CqZsHdPEOYUF7MOyfuz34cacgFrtnW1CNWEv0Gt2n/GNdXo7axeXao8PMHUGaJYCxL8e7SlbtzaeaoS5UIS9odUddDQIS0ReT5OLbiKP14eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322068; c=relaxed/simple;
	bh=c4M48DAPUB6EdmaCMv6HQ2OsHeYOy7PcUMGd5aRfG+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJOPg7RKTugG/GChWWSI1y+TfnljmdoyI6CEDIzJCzAVRLOyrpHVgWcPKs8zh8QsAv1IS69Guc1K3+8QA7TssJcNOXd8HO9xz4GRUBHk8W84YlFXwAqFrTfP6LRCXwapfk+DPNLdF2yAN4RfTyDO5MuYgVU92Vo4ZCh4KLZtmOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WF+wGXau; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DsByoZYD8zFBKsiCOPlBpf2Aj97G3XGrcpCEr3Mc8Wk=; b=WF+wGXauAjTvc7esDxVuCdR2SV
	64jbFjdk8sXoIcty5oT1C8gx/AgoyW7B6KRCUGhsMjZUeywOfKOK/nHwYFLlxnhQzzHuP6I9wVgfc
	B7F2cLBYFeBP/Jz9/JKN4s8Y+RizMJO5pf/8H8SirFJuWyMmK3cY0D0q2UTmHzM8CV1P8z9Ms79fa
	RvQNOi97XHkPQNplD8vzvqvVKYW1A54jJIrwNzxk9+zZRl5MsazSFz0vYqSpu/ALvDY2e8GW4Xf8g
	zGmaxI7pD976dkTrKxEr1AQ1gVSymp3oQNediz1abz1cbEgntPnFJ+ib+it+oZDLSHxI20ZNCKa43
	8ToYzQqQ==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSAiu-00000007uGX-3Fl2;
	Thu, 19 Jun 2025 08:34:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B39593088F2; Thu, 19 Jun 2025 10:34:15 +0200 (CEST)
Date: Thu, 19 Jun 2025 10:34:15 +0200
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
Subject: Re: [PATCH v10 07/14] unwind_user/deferred: Make unwind deferral
 requests NMI-safe
Message-ID: <20250619083415.GZ1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010428.938845449@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010428.938845449@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:28PM -0400, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Make unwind_deferred_request() NMI-safe so tracers in NMI context can
> call it and safely request a user space stacktrace when the task exits.
> 
> A "nmi_timestamp" is added to the unwind_task_info that gets updated by
> NMIs to not race with setting the info->timestamp.

I feel this is missing something... or I am.

> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v9: https://lore.kernel.org/linux-trace-kernel/20250513223552.636076711@goodmis.org/
> 
> - Check for ret < 0 instead of just ret != 0 from return code of
>   task_work_add(). Don't want to just assume it's less than zero as it
>   needs to return a negative on error.
> 
>  include/linux/unwind_deferred_types.h |  1 +
>  kernel/unwind/deferred.c              | 91 ++++++++++++++++++++++++---
>  2 files changed, 84 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> index 5df264cf81ad..ae27a02234b8 100644
> --- a/include/linux/unwind_deferred_types.h
> +++ b/include/linux/unwind_deferred_types.h
> @@ -11,6 +11,7 @@ struct unwind_task_info {
>  	struct unwind_cache	*cache;
>  	struct callback_head	work;
>  	u64			timestamp;
> +	u64			nmi_timestamp;
>  	int			pending;
>  };
>  
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index b76c704ddc6d..88c867c32c01 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -25,8 +25,27 @@ static u64 get_timestamp(struct unwind_task_info *info)
>  {
>  	lockdep_assert_irqs_disabled();
>  
> -	if (!info->timestamp)
> -		info->timestamp = local_clock();
> +	/*
> +	 * Note, the timestamp is generated on the first request.
> +	 * If it exists here, then the timestamp is earlier than
> +	 * this request and it means that this request will be
> +	 * valid for the stracktrace.
> +	 */
> +	if (!info->timestamp) {
> +		WRITE_ONCE(info->timestamp, local_clock());
> +		barrier();
> +		/*
> +		 * If an NMI came in and set a timestamp, it means that
> +		 * it happened before this timestamp was set (otherwise
> +		 * the NMI would have used this one). Use the NMI timestamp
> +		 * instead.
> +		 */
> +		if (unlikely(info->nmi_timestamp)) {
> +			WRITE_ONCE(info->timestamp, info->nmi_timestamp);
> +			barrier();
> +			WRITE_ONCE(info->nmi_timestamp, 0);
> +		}
> +	}
>  
>  	return info->timestamp;
>  }
> @@ -103,6 +122,13 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  
>  	unwind_deferred_trace(&trace);
>  
> +	/* Check if the timestamp was only set by NMI */
> +	if (info->nmi_timestamp) {
> +		WRITE_ONCE(info->timestamp, info->nmi_timestamp);
> +		barrier();
> +		WRITE_ONCE(info->nmi_timestamp, 0);
> +	}
> +
>  	timestamp = info->timestamp;
>  
>  	guard(mutex)(&callback_mutex);
> @@ -111,6 +137,48 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  	}
>  }
>  
> +static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
> +{
> +	struct unwind_task_info *info = &current->unwind_info;
> +	bool inited_timestamp = false;
> +	int ret;
> +
> +	/* Always use the nmi_timestamp first */
> +	*timestamp = info->nmi_timestamp ? : info->timestamp;
> +
> +	if (!*timestamp) {
> +		/*
> +		 * This is the first unwind request since the most recent entry
> +		 * from user space. Initialize the task timestamp.
> +		 *
> +		 * Don't write to info->timestamp directly, otherwise it may race
> +		 * with an interruption of get_timestamp().
> +		 */
> +		info->nmi_timestamp = local_clock();
> +		*timestamp = info->nmi_timestamp;
> +		inited_timestamp = true;
> +	}
> +
> +	if (info->pending)
> +		return 1;
> +
> +	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
> +	if (ret < 0) {
> +		/*
> +		 * If this set nmi_timestamp and is not using it,
> +		 * there's no guarantee that it will be used.
> +		 * Set it back to zero.
> +		 */
> +		if (inited_timestamp)
> +			info->nmi_timestamp = 0;
> +		return ret;
> +	}
> +
> +	info->pending = 1;
> +
> +	return 0;
> +}

So what's the actual problem here, something like this:

  if (!info->timestamp)
    <NMI>
      if (!info->timestamp)
        info->timestamp = local_clock(); /* Ta */
    </NMI>
      info->timestamp = local_clock();   /* Tb */

And now info has Tb which is after Ta, which was recorded for the NMI
request?
       
Why can't we cmpxchg_local() the thing and avoid this horrible stuff?

static u64 get_timestamp(struct unwind_task_info *info)
{
	u64 new, old = info->timestamp;

	if (old)
		return old;
	
	new = local_clock();
	old = cmpxchg_local(&info->timestamp, old, new);
	if (old)
		return old;
	return new;
}

Seems simple enough; what's wrong with it?

