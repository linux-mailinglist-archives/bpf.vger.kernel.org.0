Return-Path: <bpf+bounces-61044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49893AE002D
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 10:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1AEC7AF305
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 08:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C117265637;
	Thu, 19 Jun 2025 08:44:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADDA264F9C;
	Thu, 19 Jun 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322698; cv=none; b=SjLofCiwPoJSU0yyRvCcnsDBUtg2K9j1WkqvwjCpZmHBIxYGqbuBD34nnG+PwT/kmrrQFi7S6BJQTyfJm1gj0wvRyC2Fc0qyCcbR+H/MHiBqeemMZ8l40kvyloLh7i5oO7WXmE551d9yczKxO5E0KNq7/TgA/gD0iDAxxmOH4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322698; c=relaxed/simple;
	bh=4B1Mg/rUb8sAaCaNSvZH3vx8ti1Nm07+Tmko+JkJ1Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2Pukh2vCbLvJQywWg8rs++0eDGIJuLz2QJUF0sj0H+YgU3RsRu1xLTOX5MCHyKIJixJGxFUB4gJVx3Mx2YbWnMEqLeW0vTRM0CVilcgj+I9UQ06V5VZBwhWAyPLNxuUsFT3J5OR0K2Fz0YLzcG89eKwCJlDDacqTq/Lky8OkGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B6A1B5AF53;
	Thu, 19 Jun 2025 08:44:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id CD0F620029;
	Thu, 19 Jun 2025 08:44:44 +0000 (UTC)
Date: Thu, 19 Jun 2025 04:44:50 -0400
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
Message-ID: <20250619044450.64d6c019@batman.local.home>
In-Reply-To: <20250619075417.GW1613376@noisy.programming.kicks-ass.net>
References: <20250611005421.144238328@goodmis.org>
	<20250611010428.433111891@goodmis.org>
	<20250618140247.GQ1613376@noisy.programming.kicks-ass.net>
	<20250618112939.76f4bb87@gandalf.local.home>
	<20250619075417.GW1613376@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CD0F620029
X-Stat-Signature: nief18z4berszsd815n6hk4gpk9zouig
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+DCEjjs4l6M7N9GDYMFFUSWGqjmqCt2Cw=
X-HE-Tag: 1750322684-366548
X-HE-Meta: U2FsdGVkX19+H9lornc1JHqYbN9VPIzvbHGm9jmbvRYxx9zMgdUBFqYvC3XGtuNzvnhf3JUyerAOD3RZeCXHyxSVu1C+PPtyLPKro3pVcyQaMaCIc/RroFXcEhAvbH/UmykRpz2hF7dOfyzm9sHIi0uVQ/HvTHOHIpb1wRq49QXB3zIeqSEl/1KMBy/HPAeZxzlJFEPeuJQjoeQnUrto3T5i45t61XAXrmcQd359VlLNIem61rUTboA1PDwS4Q9mN9C3c1UaQcKCuA8iQWZxb1oYq9hPM6oS8SrJlE/KPdtOQnzC6t/Uy7326Xo9eIeMhV/iAiPLZbj6GU1SwICCM85cCLO/U/pUb/UQKpI0AbL8vXLLFZmE2M30B0/U19bO

On Thu, 19 Jun 2025 09:54:17 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jun 18, 2025 at 11:29:39AM -0400, Steven Rostedt wrote:
> 
> > Note, a request from the gcc folks is to add a system call that gives the
> > user space application a backtrace from its current location. This can be
> > handy for debugging as it would be similar to how we use dump_stack().  
> 
> That makes very little sense to me; apps can typically unwind themselves
> just fine, no? In fact, they can use DWARFs and all that.

Not really. It can in gdb, but doing it from a running app means that
the app needs a full parser, and access to the elf file it's running.

> 
> Also, how about we don't make thing complicated and not confuse comments
> with things like this? Focus on the deferred stuff (that's what these
> patches are about) -- and then return-to-user is the one and only place
> that makes sense.

The change log had:

   Add a function that must be called inside a faultable context that will
   retrieve a user space stack trace. The function unwind_deferred_trace()
   can be called by a tracer when a task is about to enter user space, or has
   just come back from user space and has interrupts enabled.

It doesn't mention the backtrace thing. It only makes a statement that
it needs to be done in a faultable context. I renamed the function to:

   unwind_user_faultable()

And updated the change log to:

    unwind_user/deferred: Add unwind_user_faultable()
    
    Add a new API to retrieve a user space callstack called
    unwind_user_faultable(). The difference between this user space stack
    tracer from the current user space stack tracer is that this must be
    called from faultable context as it may use routines to access user space
    data that needs to be faulted in.
    
    It can be safely called from entering or exiting a system call as the code

The explanation is that it must be called in faultable context. It
doesn't add any more policy that that (like it having to be deferred).

-- Steve

