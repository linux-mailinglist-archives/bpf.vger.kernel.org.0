Return-Path: <bpf+bounces-61379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD41AAE69F6
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 17:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94AD77B5B22
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 14:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4082291C1A;
	Tue, 24 Jun 2025 14:55:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59114658D;
	Tue, 24 Jun 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776956; cv=none; b=ARrmlluHA575wcBkGwy2DpNdFdIBb3PUxZJ1XO/TTX7TXPJmLehi9jkmPnJ/ir+75Dv/uhK7DlBOLAYhDzy1ss6UN8vFIAJhweptb/tu4O9pcGrwaF/rUve76wVYN1i/tdSOf+MEBLpw5TMxP5Q63UD8MupGdfUzVj+TWdWRSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776956; c=relaxed/simple;
	bh=2mGUqi7ynJEotHSSGSQqcmuOahlWlSMMh1DrTO5Z7Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqhXC49TfoFwEmv5DqIL0E4fRbiYky/hZsyEljnk3nma9ZKk/hhrhvePI9tWgpWo7XJnHXDOfBFbS9RQPgk79GneRTzNQQISzIAr/JzV+NejljDsj7rzPy9/S9jwmA1lTiRitgE9ALqyiCOIYega1xky1lkcCYQetECzd+ybu4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 230DD1206B1;
	Tue, 24 Jun 2025 14:55:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 2FA246000A;
	Tue, 24 Jun 2025 14:55:39 +0000 (UTC)
Date: Tue, 24 Jun 2025 10:55:38 -0400
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
Subject: Re: [PATCH v10 08/14] unwind deferred: Use bitmask to determine
 which callbacks to call
Message-ID: <20250624105538.6336a717@batman.local.home>
In-Reply-To: <20250620081542.GK1613200@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010429.105907436@goodmis.org>
	<20250620081542.GK1613200@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2FA246000A
X-Rspamd-Server: rspamout08
X-Stat-Signature: r8ojnx37taqrtomz34qucktn97ccscxt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+fwVjbD4404+ie+3DcXHy3PECM6hU5IH0=
X-HE-Tag: 1750776939-795717
X-HE-Meta: U2FsdGVkX18c5xzk7gCerXGpaaD2cVmuUGlUR/BIOEVfnX9ZAW9d3g0mZr8w1do8d87sMe37QupTsC4UYuqbjCTTE4lVdcHBMjXBBJAgOuhSWqXlZfiNC4EJTs5kkwnSEKjncUvgooXoTEOQ/4KTqWCBQLwy2Q6TVM7z8a0uBV3Dh4vSWgJU7D4pdaaUxDWz840BhLMHhocMrfHyoGxy8FaBWJ6eUE0jkywVeSJs+lQh4IVyJozNrg/F7EuHYdGzpvcxVQrv3LW//nYEHnpSQZkN5FwD0xMpv/TYPoaZYcCVqp9exUaWi+6zu0zM5EHhjkn8mSW9deowg9LhK/vq9GfVw5H62ZyrNAk3Rm0h/WagHpS19vlxJADuFjRGtBZx

On Fri, 20 Jun 2025 10:15:42 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 10, 2025 at 08:54:29PM -0400, Steven Rostedt wrote:
> 
> 
> >  void unwind_deferred_cancel(struct unwind_work *work)
> >  {
> > +	struct task_struct *g, *t;
> > +
> >  	if (!work)
> >  		return;
> >  
> >  	guard(mutex)(&callback_mutex);
> >  	list_del(&work->list);
> > +
> > +	clear_bit(work->bit, &unwind_mask);  
> 
> atomic bitop

Yeah, it just seemed cleaner than: unwind_mask &= ~(work->bit);

It's not needed as the update of unwind_mask is done within the
callback_mutex.

> 
> > +
> > +	guard(rcu)();
> > +	/* Clear this bit from all threads */
> > +	for_each_process_thread(g, t) {
> > +		clear_bit(work->bit, &t->unwind_info.unwind_mask);
> > +	}
> >  }
> >  
> >  int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
> > @@ -256,6 +278,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
> >  	memset(work, 0, sizeof(*work));
> >  
> >  	guard(mutex)(&callback_mutex);
> > +
> > +	/* See if there's a bit in the mask available */
> > +	if (unwind_mask == ~0UL)
> > +		return -EBUSY;
> > +
> > +	work->bit = ffz(unwind_mask);
> > +	unwind_mask |= BIT(work->bit);  
> 
> regular or
> 
> > +
> >  	list_add(&work->list, &callbacks);
> >  	work->func = func;
> >  	return 0;
> > @@ -267,6 +297,7 @@ void unwind_task_init(struct task_struct *task)
> >  
> >  	memset(info, 0, sizeof(*info));
> >  	init_task_work(&info->work, unwind_deferred_task_work);
> > +	info->unwind_mask = 0;
> >  }  
> 
> Which is somewhat inconsistent;
> 
>   __clear_bit()/__set_bit()

Hmm, are the above non-atomic?

> 
> or:
> 
>   unwind_mask &= ~BIT() / unwind_mask |= BIT()

although, because the update is always guarded, this may be the better
approach, as it shows there's no atomic needed.

-- Steve


