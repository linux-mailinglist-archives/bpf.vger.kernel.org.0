Return-Path: <bpf+bounces-61156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2D7AE15A2
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 10:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6242F18916E9
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 08:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B55233708;
	Fri, 20 Jun 2025 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DDVg+WAJ"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F5A28F3;
	Fri, 20 Jun 2025 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750407362; cv=none; b=YqJt16D5Ng8u1TjzSdDuNSGO2TPviCrpkspTPoSbQ6YiuJ54iX99UtNvQwtvzIsXY95lPLSzh5Bk8XmP62WY/1UXU9kuNaJIZNcO5O7dzLHDvLup6VgOggG3RJ4w296Eg6bxYtV/xOBxjY96xiJs2rAlsdcqxdsrtefsdSKKhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750407362; c=relaxed/simple;
	bh=wgoyCtEiXxlezBvNBqyM0qd8zvtWEkhDLIA41gSe+KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1enz3dmm5IxqIvY99aFIYTd8ADnOmSFYbWz6Dcm0SzNxImEGWDwznNDUTSnc2v+EVLxNG1A+7WF4s0EiMNZcIC9XHn7cry/d8YJtiZOWy40/6TJ9hbOH4JKTur4FsZMJOX8m8aqOHaH2Jw3pAPhNQG6jiz/frYRWXhSKuOODl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DDVg+WAJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C2SozZJF+dRAW0Ug5ciknM6joODBVsslgQj4ViQKp00=; b=DDVg+WAJhj1HBfuYFYKza+kG2L
	FZDDJqxrzufbuVfq0x4QTJmAmJ0FMVsnBwOlLjFj6hVVoMW7dJCtGaCs+6NssJ4r0Ob5Rgg3kdg7/
	3ZM2qiGLMirbX96pM44FaW/99Tzp+eVWIigQ2BxxqFBY8og/GWpezZgHUL6VBmpcy81I+xGK1qTFN
	rY97ZdWCggDOBwx40+aTaru34tQZzLHZaG3chkNviXSqshmmxzIw2tC/cDRYSs2T8KK3EmVXULnKo
	x03Mq9I3JWZYHKTEYFyjJHMK1Yj3YzPBlgqlXsn2HERUb/8lk+ef5xse3pBEBAbVmJ8X/dyAbVflN
	/X8Isljg==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSWuV-0000000C3B1-2rb6;
	Fri, 20 Jun 2025 08:15:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B3A69308989; Fri, 20 Jun 2025 10:15:42 +0200 (CEST)
Date: Fri, 20 Jun 2025 10:15:42 +0200
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
Subject: Re: [PATCH v10 08/14] unwind deferred: Use bitmask to determine
 which callbacks to call
Message-ID: <20250620081542.GK1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
 <20250611010429.105907436@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611010429.105907436@goodmis.org>

On Tue, Jun 10, 2025 at 08:54:29PM -0400, Steven Rostedt wrote:


>  void unwind_deferred_cancel(struct unwind_work *work)
>  {
> +	struct task_struct *g, *t;
> +
>  	if (!work)
>  		return;
>  
>  	guard(mutex)(&callback_mutex);
>  	list_del(&work->list);
> +
> +	clear_bit(work->bit, &unwind_mask);

atomic bitop

> +
> +	guard(rcu)();
> +	/* Clear this bit from all threads */
> +	for_each_process_thread(g, t) {
> +		clear_bit(work->bit, &t->unwind_info.unwind_mask);
> +	}
>  }
>  
>  int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
> @@ -256,6 +278,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
>  	memset(work, 0, sizeof(*work));
>  
>  	guard(mutex)(&callback_mutex);
> +
> +	/* See if there's a bit in the mask available */
> +	if (unwind_mask == ~0UL)
> +		return -EBUSY;
> +
> +	work->bit = ffz(unwind_mask);
> +	unwind_mask |= BIT(work->bit);

regular or

> +
>  	list_add(&work->list, &callbacks);
>  	work->func = func;
>  	return 0;
> @@ -267,6 +297,7 @@ void unwind_task_init(struct task_struct *task)
>  
>  	memset(info, 0, sizeof(*info));
>  	init_task_work(&info->work, unwind_deferred_task_work);
> +	info->unwind_mask = 0;
>  }

Which is somewhat inconsistent;

  __clear_bit()/__set_bit()

or:

  unwind_mask &= ~BIT() / unwind_mask |= BIT()

