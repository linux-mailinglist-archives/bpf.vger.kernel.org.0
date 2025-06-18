Return-Path: <bpf+bounces-60957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256ACADF164
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88ABA3A5BB5
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DCE2EF9B5;
	Wed, 18 Jun 2025 15:29:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D92E9ECB;
	Wed, 18 Jun 2025 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260581; cv=none; b=VJdqR/5BTcTHv5VbNs4Fw6hM0BUln7FvnEwAr0l1RVEJpOQujrI9Ci3op4D+TkJYQrKKxyfKJEHNLDG5nQtdgIvf876GEh8F/0pEp+PN/jBO587W2KgV+NnrAHAr8OZz1RYw7X3RxbZCGHffkelu+YLPcMo6m46901GCdx9rt24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260581; c=relaxed/simple;
	bh=lW4X2/j0mHA1tNFg9bYU+FZz+tPT0wmbAyYt+FoNbkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9Hyxx9SKlPe56FI6cEQal68cv/vG5xcld/YI7eNq+Pbqc6p44bVN8hwLHAeNA2YO819bHad0H8EdQR/VRYewSFTj0rNd12EeJrR+JTqRPX+VyeMX/522rzQt3m7vocP+2kFa2+K4w3Txyrk9tnKdRHxLxR/8tO/jcGiakiuKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id DF163C02B9;
	Wed, 18 Jun 2025 15:29:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 1DF0C20;
	Wed, 18 Jun 2025 15:29:32 +0000 (UTC)
Date: Wed, 18 Jun 2025 11:29:39 -0400
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
Subject: Re: [PATCH v10 04/14] unwind_user/deferred: Add
 unwind_deferred_trace()
Message-ID: <20250618112939.76f4bb87@gandalf.local.home>
In-Reply-To: <20250618140247.GQ1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.433111891@goodmis.org>
	<20250618140247.GQ1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1DF0C20
X-Stat-Signature: tsa5f6hsoe9t4jumybf5yux1amccjmzj
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ezSxyACc6GRwHDFQgKNfyshvjstQIJbs=
X-HE-Tag: 1750260572-758865
X-HE-Meta: U2FsdGVkX1+Whxt1YjVRFQvEKsQMCy9zG2QwWy029AeidKVH9+toGcDXMZj8vlnlbKg4bRAYkDEWJZJ3BlnpVFJCZfLHu9gOsWVs2MPYcB7VluSY9kVBMf3BDjLLXCAPOqCINfYDJQShbdoIOK/NWnU/xBvCopScba2ktXD1eqUlebES9UbMRxF/XGcxwcoJk161avURclnzXwo7nk590Q8+maVlST30WYNfjW+qx9ISH1/REGHsV1g1dU9SH24cRwM7tB2heJz2Avqy8ydHqxAwpw0FJT4SeSfUUBdwN+dDNChy8hAMzewIJEmTx4NqH70FwetUvUEEFnqZ9Z9iVXMYTSdCjwLW0jOe3Q5ICG26FSzHg3I8D340vipkZXA3

On Wed, 18 Jun 2025 16:02:47 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 10, 2025 at 08:54:25PM -0400, Steven Rostedt wrote:
> > +/**
> > + * unwind_deferred_trace - Produce a user stacktrace in faultable context
> > + * @trace: The descriptor that will store the user stacktrace
> > + *
> > + * This must be called in a known faultable context (usually when entering
> > + * or exiting user space). Depending on the available implementations
> > + * the @trace will be loaded with the addresses of the user space stacktrace
> > + * if it can be found.  
> 
> I am confused -- why would we ever want to call this on exiting
> user-space, or rather kernel entry?
> 
> I thought the whole point was to request a user trace while in-kernel,
> and defer that to return-to-user.

This code was broken out of the unwind deferred trace to be more stand
alone. Actually, it should be renamed to unwind_faultable_trace() or
something to denote that it must be called from a faultable context.

When Josh made perf use the task_work directly, it used this function to do
the trace as it handled the deferring.

Note, a request from the gcc folks is to add a system call that gives the
user space application a backtrace from its current location. This can be
handy for debugging as it would be similar to how we use dump_stack().

This function would be used for that.

-- Steve

