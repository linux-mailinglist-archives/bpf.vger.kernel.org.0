Return-Path: <bpf+bounces-63150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329CBB03AF8
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1343A3C3F
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6E24167B;
	Mon, 14 Jul 2025 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BgUpScsw"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211E91D63E6;
	Mon, 14 Jul 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752485956; cv=none; b=qAMFwROJ7Q1bch5j5siAB5wqy59YyDTu05KCk+3fOutfs1kqm0uDwN5nGmjIFGXZ7p7T6QYfDGKMSCuu67N9pvluwdy2Ptz7GBau9e2pcpa4SkLbtr2HEg85xtL2W6QAQ+gYOKTtIneDaAvEltcMQAbYRVx/tXU+RhePHq/9Sks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752485956; c=relaxed/simple;
	bh=QvgqyqI/2e3vh73jqS9rVOu/+alucobeVAg8wWEq7Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJPH0rqy/E0ddVTxxVdLJX4jgFc3HDgCeOdgg16eOq+zXTi6CbJk2CNMzYp/Xs6cgJ1BUo08Bh2VV4lUoY7jgsPuneY4/CB/5UmSquKWA+mtvkiJwVhJSSTAnxgiL4XU+CyxXw0BHmZX5MrjVRFl7Fvxs/nibJFWc9tJgy0t2mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BgUpScsw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3++uAiHE4dUTcjWQO8Rw5mELn141xV8QyvzG/GiDdnA=; b=BgUpScswDlu1T5aShhumrPUi3I
	d6Gy/j7og8KYXxuLi7KafgU075SXzFz+5zefYVrPAF2DquglxxbDBHzCIt3EhU5X9ZY7tPUWD7uRX
	zeumm+eTiJLMX+TiQNUrBzAkxSGLxfiCogTGxMbp79AE6L5vhafTr+h7yT93I4byOZR8wapWB7LFv
	W0jOqvtZfLs4HY+7Kv8AqegtZZN2B1l9Wkv8rJRCQg3qmgIcijU2EYzZSI2vUJmhfqibGafH9s72p
	uZQIDpMkFydGL68Jne7rR0JNTOk5WS/s7yLRLFVG8T6AO7VglGmhtbG9D1a/+AmgjfGoW1y11/rfi
	BS20n2mA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubFeK-00000006hbD-2KWo;
	Mon, 14 Jul 2025 09:39:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6AE11300186; Mon, 14 Jul 2025 11:39:03 +0200 (CEST)
Date: Mon, 14 Jul 2025 11:39:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-ID: <20250714093903.GP905792@noisy.programming.kicks-ass.net>
References: <20250711082931.3398027-1-jolsa@kernel.org>
 <20250711082931.3398027-10-jolsa@kernel.org>
 <20250714173915.b9edd474742de46bcbe9c617@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714173915.b9edd474742de46bcbe9c617@kernel.org>

On Mon, Jul 14, 2025 at 05:39:15PM +0900, Masami Hiramatsu wrote:

> > +	/*
> > +	 * Some of the uprobe consumers has changed sp, we can do nothing,
> > +	 * just return via iret.
> > +	 */
> 
> Do we allow consumers to change the `sp`? It seems dangerous
> because consumer needs to know whether it is called from
> breakpoint or syscall. Note that it has to set up ax, r11
> and cx on the stack correctly only if it is called from syscall,
> that is not compatible with breakpoint mode.
> 
> > +	if (regs->sp != sp)
> > +		return regs->ax;
> 
> Shouldn't we recover regs->ip? Or in this case does consumer has
> to change ip (== return address from trampline) too?
> 
> IMHO, it should not allow to change the `sp` and `ip` directly
> in syscall mode. In case of kprobes, kprobe jump optimization
> must be disabled explicitly (e.g. setting dummy post_handler)
> if the handler changes `ip`.
> 
> Or, even if allowing to modify `sp` and `ip`, it should be helped
> by this function, e.g. stack up the dummy regs->ax/r11/cx on the
> new stack at the new `regs->sp`. This will allow modifying those
> registries transparently as same as breakpoint mode.
> In this case, I think we just need to remove above 2 lines.

There are two syscall return paths; the 'normal' is sysret and for that
you need to undo all things just right.

The other is IRET. At which point we can have whatever state we want,
including modified SP.

See arch/x86/entry/syscall_64.c:do_syscall_64() and
arch/x86/entry/entry_64.S:entry_SYSCALL_64

The IRET path should return pt_regs as is from an interrupt/exception
very much like INT3.

