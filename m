Return-Path: <bpf+bounces-61952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A68AEF813
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 14:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362D63B0EA5
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA74273816;
	Tue,  1 Jul 2025 12:14:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD82144C7;
	Tue,  1 Jul 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372057; cv=none; b=CWhiUB3D2Kj2ibPxF0Sw+qKGXFbBmoxFfJjTKBhWs83chkIWhVuRM3Sun4c2clQffNOPIhrR7YMF57GoRlgbRc/iiToF6jbCN/Q9xGG8p2NSYb1JHNXIBLwuudf+CGl9SjSh0o975btU3EhQi8vgJKyMNg5bN6rSZV3rYFyDrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372057; c=relaxed/simple;
	bh=x01HNYNwDDLXcjWcCrE0mqoQgIj68sPhSKSzvqvTQqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZUBKSzy2pV6AEs26FLCyQi1KGXWCSylBxqvM6bpmTufFd41MxElibhIuqOsalSmCheGCnwQnqH8pW7TnKqvh+ZGtMOMp0JufcjNqeEJN1z1ZeR8C7lpVHGPHpZ+1deIgQVuBfqCh29AAOKX0mQQZQcpHv3mGwpbteo5XLuZuQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 313E458ED3;
	Tue,  1 Jul 2025 12:14:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 02B1A80018;
	Tue,  1 Jul 2025 12:14:05 +0000 (UTC)
Date: Tue, 1 Jul 2025 08:14:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v12 02/14] unwind_user: Add frame pointer support
Message-ID: <20250701081443.05db9bdd@gandalf.local.home>
In-Reply-To: <87tt3wikmh.fsf@oldenburg.str.redhat.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005450.888492528@goodmis.org>
	<CAHk-=wiWOYB4c3E-Cc=D89j0txbN4AGqm0j1dojqHq3uzJ+LqQ@mail.gmail.com>
	<87tt3wikmh.fsf@oldenburg.str.redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 02B1A80018
X-Rspamd-Server: rspamout02
X-Stat-Signature: 96siq8skzd3h9weupi34zaeoemiq6c6p
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19fT6yzGiKYcbwtytVYFWpIzgNP+gwzFGs=
X-HE-Tag: 1751372045-426657
X-HE-Meta: U2FsdGVkX19ToTxBr9YDYejpdUlVDhyPq9MxTXihYZiA4jzwP2G25wDGx6mYVfqyf1VG1t4JiLOE7QxuqLLeu0KPMUhJrEovc1XU9YMhCmhK+qMUqP/a7Dud9SHsM+rV+Iug4+6+7FYHNqQIzZklfF7rHxMb0aaMgyQCvXMD7Iwe+5Aw0aP+8NqpBSpQJsdL5YyJ48fSvbJ3De2/VYPrXhXgs+UDvNpFCzB9VWTjjPy5puU9HDrqjI0LM+CoCeArv0nTUPKU/SJ/JENGK5/0Q4JOcV8n6+mojlE53TDzVx+ot5wEPoomagJupyOUtW+Aw/9NHYJIjQ1cSWOseLUdzZ7zU7lFtHz/fb6WCHW7b4xPJFFM4cgdy4HpyZ9yp4zrLjZg+QzDyhR6r5Fr6C4MOg==

On Tue, 01 Jul 2025 06:46:14 +0200
Florian Weimer <fweimer@redhat.com> wrote:

> * Linus Torvalds:
> 
> > On Mon, 30 Jun 2025 at 17:54, Steven Rostedt <rostedt@goodmis.org> wrote:  
> >>
> >> +       /* stack going in wrong direction? */
> >> +       if (cfa <= state->sp)
> >> +               goto done;  
> >
> > I suspect this should do a lot more testing.
> >  
> >> +       /* Find the Return Address (RA) */
> >> +       if (get_user(ra, (unsigned long *)(cfa + frame->ra_off)))
> >> +               goto done;
> >> +
> >> +       if (frame->fp_off && get_user(fp, (unsigned long __user *)(cfa + frame->fp_off)))
> >> +               goto done;  
> >
> > .. and this should check the frame for validity too.  At a minimum it
> > should be properly aligned, but things like "it had better be above
> > the current frame" to avoid having some loop would seem to be a good
> > idea.  
> 
> I don't think SFrame as-is requires stacks to be contiguous.  Maybe
> there could be a per-frame flag that indicates whether a stack switch is
> expected?

Looking at the current code of perf, it appears to only check that the
address is valid to read from user space. Perhaps that's the only check
needed here too?

Now this loop will not go into an infinite loop as the code has:

	for_each_user_frame(&state) {
		trace->entries[trace->nr++] = state.ip;
		if (trace->nr >= max_entries)
			break;
	}

Where

#define for_each_user_frame(state) \
	for (unwind_user_start((state)); !(state)->done; unwind_user_next((state)))

It will stop at "max_entries" even if the user space tries to make it go
forever. max_entries is either 511 (on 64 bit) or 1023 (on 32 bit), as it
is defined as:

/* Make the cache fit in a 4K page */
#define UNWIND_MAX_ENTRIES					\
	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))

Now, perhaps we need to verify that the cfa is indeed canonical, but what
other test do we have perform?

In the future, this code will also be handling JIT and possibly interpreted
code. How much do we really want to limit the stack walking due to checks?

-- Steve


