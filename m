Return-Path: <bpf+bounces-63161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD15FB03BC2
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 12:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D93A6D85
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09F243369;
	Mon, 14 Jul 2025 10:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmwJR/2+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11423A6;
	Mon, 14 Jul 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488380; cv=none; b=V4JCrz9+JQxc1xexlprYwOhWPhKRqLM3TIpHD5naPJN17Va3SuR9fwZGilUxRiEvdCBXWk7UMZ0Vnlpy7Pajc5M04xfcA6aSGUQhdZXJKFVqnHXc4sFJ2AvJ7pm8N1hiffMBJD9TX4gNsTu578bYN1KnrPUF6mwSAFGF+SoLZzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488380; c=relaxed/simple;
	bh=39rq6f9QAUgi9Gag8B9x+LYtn+RnZJRDTlegcXSs4qI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CCV/rUbAtvWBNctNBfqx36kNSvPnx1SKBijh5amtmCosKMn0lheiQ/qoTr5ygqAXa54pCFNJzkn8qH50sabpnqG4li6SqEzezsWDHhDNsCdVQKdO0uIeN057BArUg1GtaYoha2CJrN1Rv//ANrx/orH9xmPWbQvdeyQlLitt0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmwJR/2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A9BC4CEED;
	Mon, 14 Jul 2025 10:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752488378;
	bh=39rq6f9QAUgi9Gag8B9x+LYtn+RnZJRDTlegcXSs4qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JmwJR/2+i3C2MKBArn5hUIm3IW8zx0J5avjDiPsGWQDOnF1XEKGo2dn83XztCtXcg
	 SUUN/IsDt7WenKeCEGp8slLQ84xKlxYT32HV8DWzL6h7RbhXji5BfIPNUkZGlz4Tz2
	 ljDWF48rZ9Mvvn1XUFkhscVFQMpsLUc3qz0A9wYo90HBck7lCP9Kv0GK4LVB4dMdTE
	 lbsRgUFTzFcYFzMU8QhvOXYSTciw9kJXws1nd8wDO9x7iE0W3UG4Q5DTqcxWKwKXfF
	 s6PzDkB7D7liG1Sja40SuMsfTqOHlKuAQ4QmyH2M2JuOqsxK/Ip4ZIGlN0f9CWg82d
	 tW6pu4nhy5qJA==
Date: Mon, 14 Jul 2025 19:19:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andrii
 Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Alan Maguire
 <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-Id: <20250714191935.577ec7df5ae8a73282cddce7@kernel.org>
In-Reply-To: <20250714093903.GP905792@noisy.programming.kicks-ass.net>
References: <20250711082931.3398027-1-jolsa@kernel.org>
	<20250711082931.3398027-10-jolsa@kernel.org>
	<20250714173915.b9edd474742de46bcbe9c617@kernel.org>
	<20250714093903.GP905792@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 11:39:03 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Jul 14, 2025 at 05:39:15PM +0900, Masami Hiramatsu wrote:
> 
> > > +	/*
> > > +	 * Some of the uprobe consumers has changed sp, we can do nothing,
> > > +	 * just return via iret.
> > > +	 */
> > 
> > Do we allow consumers to change the `sp`? It seems dangerous
> > because consumer needs to know whether it is called from
> > breakpoint or syscall. Note that it has to set up ax, r11
> > and cx on the stack correctly only if it is called from syscall,
> > that is not compatible with breakpoint mode.
> > 
> > > +	if (regs->sp != sp)
> > > +		return regs->ax;
> > 
> > Shouldn't we recover regs->ip? Or in this case does consumer has
> > to change ip (== return address from trampline) too?
> > 
> > IMHO, it should not allow to change the `sp` and `ip` directly
> > in syscall mode. In case of kprobes, kprobe jump optimization
> > must be disabled explicitly (e.g. setting dummy post_handler)
> > if the handler changes `ip`.
> > 
> > Or, even if allowing to modify `sp` and `ip`, it should be helped
> > by this function, e.g. stack up the dummy regs->ax/r11/cx on the
> > new stack at the new `regs->sp`. This will allow modifying those
> > registries transparently as same as breakpoint mode.
> > In this case, I think we just need to remove above 2 lines.
> 
> There are two syscall return paths; the 'normal' is sysret and for that
> you need to undo all things just right.
> 
> The other is IRET. At which point we can have whatever state we want,
> including modified SP.
> 
> See arch/x86/entry/syscall_64.c:do_syscall_64() and
> arch/x86/entry/entry_64.S:entry_SYSCALL_64
> 
> The IRET path should return pt_regs as is from an interrupt/exception
> very much like INT3.

OK, so SYSRET case, we need to follow;

sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> trampoline -> retaddr

But using IRET to return, we can skip returning to trampoline,

sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> regs->ip

Thus we have to check the way, or in both cases use trampoline hack to
change return address.

Thank you,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

