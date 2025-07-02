Return-Path: <bpf+bounces-62167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C19AF5FEF
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 19:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864DA189E9A0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 17:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2231301130;
	Wed,  2 Jul 2025 17:26:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AD9253351;
	Wed,  2 Jul 2025 17:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477177; cv=none; b=Y+XyKmWDtNgmoea+fMlfUXCn+fl0CZEHiKDjlCl78QijzUhTN4a8OfQi2v3FwsTS7AUTTviAHsf0SQ+wG1FMKhFZtTwXWHucNhMnMDQ5W1uB1gW/9XPCXDY+NNHD3fhsyi4RJfqWm6xhUljvYVkF32ttTUInCrso/yZ1RG5Sbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477177; c=relaxed/simple;
	bh=bXSmc02F75nIJvMlBiM/UqcmD6w8cL7JjpMIMURcveg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNDdoFC8gUoAuT2vknjEthh0QxxVkRm7W6l3AeI9bfNNWr9kCHXQhwiiHXemEJ5UuBU3rmAkN9yx5Nyc/boopTvLOWcva3wvgJf457m5ycJdiNJ7BEJz+Zu0jTLwbH4R7Pu11j3SWo7sBH3w/pEnLwhVJ6GzjjcfU2lgaL4fJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 50EE758773;
	Wed,  2 Jul 2025 17:26:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id C97E520011;
	Wed,  2 Jul 2025 17:26:06 +0000 (UTC)
Date: Wed, 2 Jul 2025 13:26:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Florian Weimer
 <fweimer@redhat.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250702132605.6c79c1ec@batman.local.home>
In-Reply-To: <CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
References: <20250701005321.942306427@goodmis.org>
	<20250701005451.571473750@goodmis.org>
	<20250702163609.GR1613200@noisy.programming.kicks-ass.net>
	<20250702124216.4668826a@batman.local.home>
	<CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tktg39hzfs7wn5za67xmj5fwbzdwkt8z
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C97E520011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/RJ0IoK3u7id2+J4EPVANbMUuEfiAP0tQ=
X-HE-Tag: 1751477166-162882
X-HE-Meta: U2FsdGVkX1+uGjlTJH/4Zv4mwQYQFeUzECJf4kRqyI0KBAe8k0HYSMZwXsE/Iay4VbyjGmFc2ov6Bodb5hPI6+ybnn3EfqDDH3lU/BqV+adg5a99wBr5CcvG2rsFFiPHKgSYQtuEbh8dhgT9Ssxx6TbAO3GbEw+txahunb/IrVD6DBjQqtkdgKOXfx3mo84czb0GanscrXbM1GYTktTM7FTnWegNwszXowP+mkbdrrnK0VOZOGh9eMtwFc2W+htoauKMvUsaxW34LuWxgb46QwiCLpla8MKlm+XgPjP8IijKak936DW+addLIV00jceMLXwohpxTW4Plc7mRAgjlYgpykyipx5CU09GpKfWX4ESlfPtoD0Mi4MV/LTXuXhSJ

On Wed, 2 Jul 2025 09:56:39 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Also, does it actually have to be entirely unique? IOW, a 32-bit
> counter (or even less) might be sufficient if there's some guarantee
> that processing happens before the counter wraps around? Again - for
> correlation purposes, just *how* many outstanding events can you have
> that aren't ordered by other things too?
> 
> I'm sure people want to also get some kind of rough time idea, but
> don't most perf events have them simply because people want time
> information for _informatioal_ reasons, rather than to correlate two
> events?

And it only needs to be unique per thread per system call. The real
reason for this identifier is for lost events. As I explained in the
perf patchset, the issues is this:

In case of dropped events, we could have the case of:

  system_call() {
    <nmi> {
      take kernel stack trace
      ask for deferred trace.

   [EVENTS START DROPPING HERE]
    }
    Call deferred callback to record trace [ BUT IS DROPPED ]
  }

  system_call() {
    <nmi> {
      take kernel stack trace
      ask for deferred trace [ STILL DROPPING ]
    }
    [ READER CATCHES UP AND STARTS READING EVENTS AGAIN]

    Call deferred callback to record trace
  }

The user space tool will see that kernel stack traces of the first
system call, then it will see events dropped, and then it will see the
deferred user space stack trace of the second call.

The identifier is only there for uniqueness for that one thread to let
the tracer know if the deferred trace can be tied to events before it
lost them.

We figured a single 32 bit counter would be good enough when we first
discussed this idea, but we wanted per cpu counters to not have cache
contention every time a CPU wanted to increment the  counter. But each
CPU would need an identifier so that a task migrating will not get the
same identifier for a different system call just because it migrated.

We used 16 bits for the CPU counter thinking that 32K of CPUs would
last some time in the future. We then chose to use a 64 bit number to
allow us to have 48 bits left for uniqueness which is plenty.

If we use 32 bits, that would give us 32K of unique systemcalls, and it
does seem possible that on a busy system, a tracer could lose 32K of
system calls before it gets going again. But we could still use it
anyway as the likelihood of losing exactly 32K of system calls and
starting tracing back up again will probably never happen. And if it
does, the worse thing that it will do is have the tracer mistake which
user space stack trace goes to which event. If your are tracing that
many events, this will likely be in the noise.

So I'm fine with making this a 32 bit counter using 16 bits for the CPU
and 16 bits for per thread uniqueness.

-- Steve

