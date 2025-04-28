Return-Path: <bpf+bounces-56841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B116A9F065
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 14:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736051886582
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 12:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EDB268C7C;
	Mon, 28 Apr 2025 12:12:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8126869F;
	Mon, 28 Apr 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842339; cv=none; b=WsIxnigIrNAZHbZrQS9L1br6aLQUb/rFiTj01Y4gjpLSyRpmkzJ1lvKesR9u/s+vu1W/pQW6HMqZg5v/HEQLciF/o+eDqSKVixWG2u0m5AlVWOP/DzF3iJ9zNEHfN08aTPoSH/hxJGGrlJT9RAkuClaGu6u3OpFSv7YWkavThpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842339; c=relaxed/simple;
	bh=PI3wkQxGME8M8mxRJ8/Wwuimx/s8GdcPML0cZPEzLbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWT+DYjU/emoHFzs1MXNUubG8ijaYgdfCjhj8VMVMP2vomrtqlHdTuM/J+XGrqg4ocrdyVdlRRV2qI6mxb+FgKXemVoY5lW2vq2TUtgGKsWFn3YNqDy5UBJmMMrqgCqgrAL4xeyEzu/Q0TauVvmaJf7G64yIf1RZehxoM4dclWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FE5C4CEE4;
	Mon, 28 Apr 2025 12:12:17 +0000 (UTC)
Date: Mon, 28 Apr 2025 08:12:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar
 <mingo@redhat.com>, x86@kernel.org, Kees Cook <kees@kernel.org>,
 bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH] sched/core: Introduce task_*() helpers for PF_ flags
Message-ID: <20250428081220.1f3f2165@gandalf.local.home>
In-Reply-To: <aA0pDUDQViCA1hwi@gmail.com>
References: <20250425204120.639530125@goodmis.org>
	<20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
	<20250426084320.335d4cb2@batman.local.home>
	<aA0pDUDQViCA1hwi@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Apr 2025 20:42:21 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> I'll send out a full series if there's no better suggestions for the 
> general approach.

Fine, you can take over. I have other things to work on.

Unless you add a task_user() or something similar that makes it very easy
to see that a task is a user thread other than testing if it's not a kernel
thread, it doesn't solve the issue that was my original motivation for my
patches. That is, there's places in the code that needs to only work on
user threads, and it would be nice to quickly see that the if statement is
checking if it is or not.

We have places that check if it's a kernel thread to exit out early:

	if (task_kernel(task))
		goto out;

And places that do something if it's a user thread:

	if (task_user(task))
		// do something special

By explicitly stating "user" in the test, makes that very easy to see,
where as:

	if (task_kernel(task))
		goto out;

and

	if (!task_kernel(task))
		// do something special

makes you have to look a bit harder. The kernel is complex enough, I
believe we should make it easier where there's low hanging fruit to do so.

-- Steve

