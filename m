Return-Path: <bpf+bounces-60958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C23ADF171
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D919189F25F
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B7A2EF9B0;
	Wed, 18 Jun 2025 15:34:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A732E54CD;
	Wed, 18 Jun 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260841; cv=none; b=lq136Kj2b+/bj9crUWlmj1E4zo/vAntHdXfR3gp5ZWMzJ7z9uzpw6NNbkGVdmSxY7eYWsiXxzbbKA+hXZ2Ozq1GLIG8BDMmupIJj3sggDw27laC4wldmB+1XZqt5yuL0AuIoOJavx0a9wnLLYvQ6z/61JmGmGnF7eEZxmZzVhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260841; c=relaxed/simple;
	bh=/+3mDsUmmAwOcqtSmHgk1L6Pp9HylpoqA3Igxbt+tLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbaYLBklla8Rtj4JsOf/Rv+LWxMhDcD6nTn4p5zh5S4/Wwvd2lP4+AT/EX2U655ttWSldA3Yc2vvoZY0MFyXQAJ86fZGN2Qe1Rli4kDwvCvaNzywmhOcLkhvHlPe37OgOLr2qRJ2CwwhNAYcKmI+opBWimxgIt/XFloNp9ycbrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id C5B6816029D;
	Wed, 18 Jun 2025 15:33:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id DF05817;
	Wed, 18 Jun 2025 15:33:51 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:33:59 -0400
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
Subject: Re: [PATCH v10 05/14] unwind_user/deferred: Add unwind cache
Message-ID: <20250618113359.585b3770@gandalf.local.home>
In-Reply-To: <20250618141345.GR1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.603778772@goodmis.org>
	<20250618141345.GR1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DF05817
X-Stat-Signature: qn145nasyjo71b6c4mp48cby95e8fyix
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19z+V8EdxvZHYuSr2+nvc1NgqcE5Ym4NK0=
X-HE-Tag: 1750260831-793816
X-HE-Meta: U2FsdGVkX1/pJDS4niRQIt8lw8hjU2/CPzqN8+QqDAeVS5fEqQH8L3j2HRdolw6MlrXmneyfAmuLE2hEV5tilhjhHP1bQjtK7qcQ7+Po5tZGy/1c6OXAUc+XS7PXcsytj6O4KePSBBxPRf44KrAjuizxfTA2WkW0EyLXNrDjOOC1qsLaWBlilqYl1+Uf7IOS/Nt9yDSOVJ9B0kQIh7pGOQosFm9FhXEshz/VC7fPPLkTjB8H0/IbbrU3aEwkQY/wHiA9WL2yxCQnC7zJt7GazMXVY34OY7hM8QFbKhk5ypliehINYgkTGyAX2zoOXCZdrwjHlapnp3XBx3mgi5JVy+QEZTDGWu10Za6AlWu4l+ijsP/FVAtvFlrdnpMwJzf3SwqMoO/hdVM+YBSCipisUYF2Qp26aeOz

On Wed, 18 Jun 2025 16:13:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> > index f94f3fdf15fc..6e850c9d3f0c 100644
> > --- a/include/linux/entry-common.h
> > +++ b/include/linux/entry-common.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/resume_user_mode.h>
> >  #include <linux/tick.h>
> >  #include <linux/kmsan.h>
> > +#include <linux/unwind_deferred.h>
> >  
> >  #include <asm/entry-common.h>
> >  #include <asm/syscall.h>
> > @@ -362,6 +363,7 @@ static __always_inline void exit_to_user_mode(void)
> >  	lockdep_hardirqs_on_prepare();
> >  	instrumentation_end();
> >  
> > +	unwind_exit_to_user_mode();  
> 
> So I was expecting this to do the actual unwind, and was about to go
> yell this is the wrong place for that.
> 
> But this is not that. Perhaps find a better name like:
> unwind_clear_cache() or so?

Sure.

How about unwind_reset_info()?

As it's not going to just clear the cache but also reset the trace info
(like the timestamp and such).


> 
> >  	user_enter_irqoff();
> >  	arch_exit_to_user_mode();
> >  	lockdep_hardirqs_on(CALLER_ADDR0);  
> 
> 
> > diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
> > index aa32db574e43..db5b54b18828 100644
> > --- a/include/linux/unwind_deferred_types.h
> > +++ b/include/linux/unwind_deferred_types.h
> > @@ -2,8 +2,13 @@
> >  #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> >  #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
> >  
> > +struct unwind_cache {
> > +	unsigned int		nr_entries;
> > +	unsigned long		entries[];
> > +};
> > +
> >  struct unwind_task_info {
> > -	unsigned long		*entries;
> > +	struct unwind_cache	*cache;
> >  };
> >  
> >  #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
> > diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> > index 0bafb95e6336..e3913781c8c6 100644
> > --- a/kernel/unwind/deferred.c
> > +++ b/kernel/unwind/deferred.c
> > @@ -24,6 +24,7 @@
> >  int unwind_deferred_trace(struct unwind_stacktrace *trace)
> >  {
> >  	struct unwind_task_info *info = &current->unwind_info;
> > +	struct unwind_cache *cache;
> >  
> >  	/* Should always be called from faultable context */
> >  	might_fault();
> > @@ -31,17 +32,30 @@ int unwind_deferred_trace(struct unwind_stacktrace *trace)
> >  	if (current->flags & PF_EXITING)
> >  		return -EINVAL;
> >  
> > -	if (!info->entries) {
> > -		info->entries = kmalloc_array(UNWIND_MAX_ENTRIES, sizeof(long),
> > -					      GFP_KERNEL);
> > -		if (!info->entries)
> > +	if (!info->cache) {
> > +		info->cache = kzalloc(struct_size(cache, entries, UNWIND_MAX_ENTRIES),
> > +				      GFP_KERNEL);  
> 
> And now you're one 'long' larger than a page. Surely that's a crap size
> for an allocator?

Bah, Ingo suggested to put the counter in the allocation and I didn't think
about the size going over the page. Good catch!

Since it can make one per task, it may be good to make this into a
kmemcache.

-- Steve

