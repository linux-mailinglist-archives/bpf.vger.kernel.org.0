Return-Path: <bpf+bounces-56784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78360A9DAC7
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 14:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB54A5DCA
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 12:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F04156CA;
	Sat, 26 Apr 2025 12:43:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7211CA0;
	Sat, 26 Apr 2025 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745671404; cv=none; b=RBJ8sGg06BP1ZJ3PI01HAbpJp0jRB+rZdkZtMniFkqikOFPAm4H0qCWD6SrdF/2+UEKVmHz6eqmk1EynhWy+GLUva0kzLXcc5Vpc4M9bfgv+eIx7yE1ClfB3mRxkOh4ucvZqEGmo2V1Wui0SVDbANy32L3gRDq3AekEvfc/K5n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745671404; c=relaxed/simple;
	bh=oFQ/UdfmwAsRFBa2Lc+Bk893yAmilXQtfZU7lTtdhw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8SjCJRTfil19dWmUwlqa/rbtCtGfIqweE7dXmfIMJGCfNmUpa8dv9Lzmm2dqPg++uWBC/cynBi+KcQYSRaXMHyVD59403/zc2R6y+xK3NkLQP5teL34aFVhJ2k/5uE6CEf4p3WlHRIp+oZc4LtwlrQKfwffQJiH2M7/ldjLzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AF5C4CEE2;
	Sat, 26 Apr 2025 12:43:21 +0000 (UTC)
Date: Sat, 26 Apr 2025 08:43:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Kees Cook
 <kees@kernel.org>, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Julia
 Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
Subject: Re: [RFC][PATCH 0/2] Add is_user_thread() and is_kernel_thread()
 helper functions
Message-ID: <20250426084320.335d4cb2@batman.local.home>
In-Reply-To: <20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
References: <20250425204120.639530125@goodmis.org>
	<20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 16:14:49 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> Seems sensible.  Please consider renaming PF_KTHREAD in order to break
> missed conversion sites.

It's not wrong to use the thread. I just find using these helper
functions a bit easier to review code. There's also some places that
have special tests where it can't use the flag:

kernel/sched/core.c:    if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
kernel/sched/fair.c:    if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
kernel/trace/bpf_trace.c:                    current->flags & (PF_KTHREAD | PF_EXITING)))
kernel/trace/bpf_trace.c:       if (unlikely(task->flags & (PF_KTHREAD | PF_EXITING)))

Maybe we can have a: is_user_exiting_or_kthread() ?

Note, for coccinelle patches, I would wait till the end of the merge
window, run the scripts on what's in Linus's tree, run my tests, and
then submit. This way it catches most of the conversions with the least
amount of conflicts.

-- Steve

