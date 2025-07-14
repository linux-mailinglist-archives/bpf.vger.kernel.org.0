Return-Path: <bpf+bounces-63277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42EB04C90
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 01:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ECA18872D1
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A38279354;
	Mon, 14 Jul 2025 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT+1i+SJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F01CD1F;
	Mon, 14 Jul 2025 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537295; cv=none; b=OewFVaze6V1GZBSP/Oj76t5lbx/WCi+C93jz4meSCM1/oOR9k/OzGDs3EWjFnSuy93nEUfsLJVt8MGTXa0UQbNFC6KtWQVcRllcOUsnElB7AFVO2O5WPY7bCx/vAyaMzXsni1IYoey86aRzgg35W7GLuUxAl9jtiDqAGa8wMLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537295; c=relaxed/simple;
	bh=RF5FQP+eMAd2Jg+qBB19wJDPlGSH92fwMalkqtfYpiA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BAnSD/IivybwJxzOcpZqtMEeyIU0+BZz0n26jotdFq6/+fmx2oLtvoKMI6BQCQ0HuwNareEiB1rp20Dmkjh7w6QVLTvsE8BdxKlgwQ9gjYoODkUXBJKqvgoC+djl5LPX6ctlec5CY/zClF+89Yd2j2fVICNsJBHJduJ+UkzbxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT+1i+SJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D10C4CEED;
	Mon, 14 Jul 2025 23:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752537294;
	bh=RF5FQP+eMAd2Jg+qBB19wJDPlGSH92fwMalkqtfYpiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qT+1i+SJ+7QknqHTQBNUHAD7FEktNLURySkqyn3pCf7HK/o0UuZYuZQDXzQPk+LI3
	 QJy0cj4MYHgDFaB2gt1uVGagdknr0dA5lx/aMsoKqcEbfgEX/Z6S5t2dAtAAATIZTr
	 WaoJhfN/Iz6r7ec4uhG5OXsu2B/Uv9D0HRPYrdFWdfAUVG6rKRugWASuUYmCJg0xZd
	 gOmZTeeiAi8qyY9yJND6g8q82jsetLKOdCD63/YEYSRKndXexrCTrReiK3NngQ6q0p
	 ZrYOksYG3QbvVYnfViT/eHBNffZvzNbiU3FxpxDw+RnBiqM/j427Cwr4vfUythgLn+
	 yJwGS+Z46996A==
Date: Tue, 15 Jul 2025 08:54:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo
 <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, Alan Maguire
 <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [PATCHv5 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
Message-Id: <20250715085451.6a871a3b40c5ff19d3568956@kernel.org>
In-Reply-To: <aHV2mrao8EMOTz8S@krava>
References: <20250711082931.3398027-1-jolsa@kernel.org>
	<20250711082931.3398027-10-jolsa@kernel.org>
	<20250714173915.b9edd474742de46bcbe9c617@kernel.org>
	<20250714093903.GP905792@noisy.programming.kicks-ass.net>
	<20250714191935.577ec7df5ae8a73282cddce7@kernel.org>
	<aHV2mrao8EMOTz8S@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 23:28:58 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Mon, Jul 14, 2025 at 07:19:35PM +0900, Masami Hiramatsu wrote:
> > On Mon, 14 Jul 2025 11:39:03 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Mon, Jul 14, 2025 at 05:39:15PM +0900, Masami Hiramatsu wrote:
> > > 
> > > > > +	/*
> > > > > +	 * Some of the uprobe consumers has changed sp, we can do nothing,
> > > > > +	 * just return via iret.
> > > > > +	 */
> > > > 
> > > > Do we allow consumers to change the `sp`? It seems dangerous
> > > > because consumer needs to know whether it is called from
> > > > breakpoint or syscall. Note that it has to set up ax, r11
> > > > and cx on the stack correctly only if it is called from syscall,
> > > > that is not compatible with breakpoint mode.
> > > > 
> > > > > +	if (regs->sp != sp)
> > > > > +		return regs->ax;
> > > > 
> > > > Shouldn't we recover regs->ip? Or in this case does consumer has
> > > > to change ip (== return address from trampline) too?
> > > > 
> > > > IMHO, it should not allow to change the `sp` and `ip` directly
> > > > in syscall mode. In case of kprobes, kprobe jump optimization
> > > > must be disabled explicitly (e.g. setting dummy post_handler)
> > > > if the handler changes `ip`.
> > > > 
> > > > Or, even if allowing to modify `sp` and `ip`, it should be helped
> > > > by this function, e.g. stack up the dummy regs->ax/r11/cx on the
> > > > new stack at the new `regs->sp`. This will allow modifying those
> > > > registries transparently as same as breakpoint mode.
> > > > In this case, I think we just need to remove above 2 lines.
> > > 
> > > There are two syscall return paths; the 'normal' is sysret and for that
> > > you need to undo all things just right.
> > > 
> > > The other is IRET. At which point we can have whatever state we want,
> > > including modified SP.
> > > 
> > > See arch/x86/entry/syscall_64.c:do_syscall_64() and
> > > arch/x86/entry/entry_64.S:entry_SYSCALL_64
> > > 
> > > The IRET path should return pt_regs as is from an interrupt/exception
> > > very much like INT3.
> > 
> > OK, so SYSRET case, we need to follow;
> > 
> > sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> trampoline -> retaddr
> > 
> > But using IRET to return, we can skip returning to trampoline,
> > 
> > sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> regs->ip
> 
> the handler gets the original breakpoint address, it's set in:
> 
>         regs->ip  = ax_r11_cx_ip[3] - 5;
> 
> and at the point we do:
> 
>         /*
>          * Some of the uprobe consumers has changed sp, we can do nothing,
>          * just return via iret.
>          */
>         if (regs->sp != sp)
>                 return regs->ax;
> 
> 
> .. regs->ip value wasn't restored for the trampoline's return address,
> so iret will skip the trampoline

Ah, OK. So unless we restore regs->cx = regs->ip and 
regs->r11 = regs->flags, it automatically use IRET. Got it.

> 
> but perhaps we could do the extra check below to land on the next instruction?

Hmm, can you clarify the required condition of changing regs
in the consumers? regs->sp change need to be handled by the
IRET, but other changes can be handled by trampoline. Is that
correct?

Thank you,

> 
> jirka
> 
> 
> ---
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 043d826295a3..4318517aa852 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -817,8 +817,12 @@ SYSCALL_DEFINE0(uprobe)
>  	 * Some of the uprobe consumers has changed sp, we can do nothing,
>  	 * just return via iret.
>  	 */
> -	if (regs->sp != sp)
> +	if (regs->sp != sp) {
> +		/* skip the trampoline call */
> +		if (ax_r11_cx_ip[3] - 5 == regs->ip)
> +			regs->ip += 5;
>  		return regs->ax;
> +	}
>  
>  	regs->sp -= sizeof(ax_r11_cx_ip);
>  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

