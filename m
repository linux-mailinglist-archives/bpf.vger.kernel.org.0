Return-Path: <bpf+bounces-61672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E3AE9FF9
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68C3567B67
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1948E2E7F04;
	Thu, 26 Jun 2025 14:11:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332BE28FFEE;
	Thu, 26 Jun 2025 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947065; cv=none; b=GFgHfeqmWyqfRf/5q4x0xE6RLUSl1b2gN+hEULdFIbrFB48j3yNzCzOtOXV5uNI7bW5bhl98bibuJF4L3ySrn3SPKXZFtHAFHtewJrpJx1wh+i2wEYdrwgQ3NFKMqEEshxTKJV7OPJQrzLui2TZVFoSXMS7gI49G8B720OnhUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947065; c=relaxed/simple;
	bh=k+PlH4M/dONX/Y7DAYamHb2UhCXdl+3x0eQwz8TJ+6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTySMhzCHJsy1w6TNjKt+IdGUBXZIqy7G/Owf/8vZATlCLRZDqBLeQg10/2K6ACecbVAfGORCAMlpwCfgZls7xfwj1u+DrNFn9YyyyR3lsjCW6M4ncU35Nu8sMi/RbUGn88/bYk6ivi/0M4q86thIANm7jrpSG3DJ9VzYcZpntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C2D9B1202D6;
	Thu, 26 Jun 2025 14:10:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id A18A320027;
	Thu, 26 Jun 2025 14:10:55 +0000 (UTC)
Date: Thu, 26 Jun 2025 10:11:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 03/11] perf: Use current->flags & PF_KTHREAD instead
 of current->mm == NULL
Message-ID: <20250626101115.3e6b99bf@gandalf.local.home>
In-Reply-To: <a3b456f2-deeb-45c9-b509-23bbe5e96cfd@kernel.dk>
References: <20250625231541.584226205@goodmis.org>
	<20250625231622.172100822@goodmis.org>
	<a3b456f2-deeb-45c9-b509-23bbe5e96cfd@kernel.dk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4ymo5mipbk8gcjdq5npams95x563i54f
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: A18A320027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/N621g61In4Y2fVBleF6OF75dPcGbes5E=
X-HE-Tag: 1750947055-359244
X-HE-Meta: U2FsdGVkX1+n3jdg+aKXOb56mHFBWq+oesOU81aTWJL+AgfIaVxEQitthOmfcgcL3jC1vpBKa52f4r+GBI4Vih6iDYN3bQKEIbSSHzyDJLa3smBvAloDRwJIibq3tFyiCBCJA9p6IQ6zsI74iBdTX846OXS/XBqfxz2RwZazjQXWqWFSbtl5uJVHaHzJtqjeMYHut6P3zIW1ka5/wQCw/RGGCKjJjhVJbuCybPsXREpP4SmmPdtOoIfbjAS24YGImnvegu2YuIEg7hDw0TJSV8Vgwnu//75qOeqFqwVqHeC79sbSgr0MIG2IgEKogLXYIpdJj4O+2v0NJ2dryEqMoIS1/bBEMW3rlzsWVWwc4c0R3HDFgVRtSdWy18q2m8mS624vAiwa6kQHZBAMmoUk3Q==

On Thu, 26 Jun 2025 07:48:40 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 6/25/25 5:15 PM, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > To determine if a task is a kernel thread or not, it is more reliable to
> > use (current->flags & PF_KTHREAD) than to rely on current->mm being NULL.
> > That is because some kernel tasks (io_uring helpers) may have a mm field.  
> 
> This commit message is very odd, imho, and wrong. To check if it's a
> kernel thread yes you should use PF_KTHREAD, but that has nothing to do

Yeah, I figured this was wrong when I saw your reply in the other thread.
That's why I Cc'd you on this.

[
  For those interested in what that other thread is:
  https://lore.kernel.org/all/20250624130744.602c5b5f@batman.local.home/
]

> with PF_USER_WORKER. In fact, as mentioned in a previous reply,
> current->mm may be non-NULL for a kthread as well, if it's done
> kthread_use_mm().
> 
> If the current check for "is kernel thread" was using ->mm to gauge
> then, then the current check was just wrong, period.

Yes, but unfortunately, that was a way a task was checked to see if it was
a kernel thread or not. Which was right "most of the time". But it's wrong
to use that, because it can be wrong "some of the time" :-p

Which brings us to this discussion.

I believe Peter was under the assumption that we should not use current->mm
to see if it's a user task or not, and use PF_KTHREAD instead. But for
perf, a user task is something that will return back to user space, as the
idea is to profile the user space stack trace.

You said that PF_USER_WORKER never came from user space, so from the perf
point of view, it *is* a kernel thread, and we don't want to treat it as a
user space one. If we check current->mm to be a user space task, or if we
check for PF_KTHREAD to be a kernel task, we are wrong in both cases when
it comes to a task marked as PF_USER_WORKER.

This brings up having a function like "is_kernel_thread()" (or remove the
'is' if people don't like that) that returns true if the task *only* runs
in the kernel.

-- Steve

