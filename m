Return-Path: <bpf+bounces-63404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE542B06BC3
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 04:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDC64E3D24
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 02:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3490E274B42;
	Wed, 16 Jul 2025 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOa7Ree5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A820E704;
	Wed, 16 Jul 2025 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752633580; cv=none; b=NWx+hr2teMLsNIQ7a8YwB2CQ1ie/mARJ6B1TCba7c429drlEy9d9xpjyF6+AkBRuIv01s6n1zotVHh5qFRNH7F/M7cervu/S+VICXO7Y5ezhho+ywxN/0jZbGE7HqI93lr4WQn0aroE5m8NIMb0aQKG0EctfW5kMBsAY96ud3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752633580; c=relaxed/simple;
	bh=AJAN0XknSeZv8NdQ/g7V1Wjyjj+exrMZPi6CbZvy2lM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=psWQG2tqGkwXX5IyGVWgdk7friTEUBphnbk9hUjjSo3jv8x7bOFlPXqbhxEQGH6AVJ45+XV0cl43IcX0Dn7tYxs/fVLIU8eiA960wdK17r/n99p8JN38X1sRJeW0OJ3zmfjNcH7m1MZEDQiequnhP6ev6gSsxawuoCcjFIau/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOa7Ree5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE85CC4CEE3;
	Wed, 16 Jul 2025 02:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752633580;
	bh=AJAN0XknSeZv8NdQ/g7V1Wjyjj+exrMZPi6CbZvy2lM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fOa7Ree5wNbmTQO7JZ7GMMeHWS/IYshHjW7mqZhqd69VUZh884ITrQx34asmL5kLz
	 tVmrmIc7rQl0Vx79RYIMmUsc3R+yxoyV/HPo2NSsPrBY0VaX3qPLdjWQtiJAljAYUJ
	 aFkSWzSDqiIh6RTTbFDbi2/yaCGsmdKvrONNUqRExNm6g8LjsmzYZcspSjMnEgw6Md
	 7P+xN7QrmQv0DgzYe9hkN5gQUZdCeNjPq1TN4li5MPYk9tMeEQur8FIJK4gnVUPL4X
	 kU9S6BFlM4kblGCAQV0WouxN068oKgK40h0zLeQOr1T2jk2SK4YkMnsAdIrcyFrd3H
	 tIQScbO+01HZg==
Date: Wed, 16 Jul 2025 11:39:36 +0900
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
Message-Id: <20250716113936.c5b94cc3f0ae1f4f578cdaba@kernel.org>
In-Reply-To: <aHZGofDkcJDCx3wY@krava>
References: <20250711082931.3398027-1-jolsa@kernel.org>
	<20250711082931.3398027-10-jolsa@kernel.org>
	<20250714173915.b9edd474742de46bcbe9c617@kernel.org>
	<20250714093903.GP905792@noisy.programming.kicks-ass.net>
	<20250714191935.577ec7df5ae8a73282cddce7@kernel.org>
	<aHV2mrao8EMOTz8S@krava>
	<20250715085451.6a871a3b40c5ff19d3568956@kernel.org>
	<aHZGofDkcJDCx3wY@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 14:16:33 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Tue, Jul 15, 2025 at 08:54:51AM +0900, Masami Hiramatsu wrote:
> > On Mon, 14 Jul 2025 23:28:58 +0200
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> > > On Mon, Jul 14, 2025 at 07:19:35PM +0900, Masami Hiramatsu wrote:
> > > > On Mon, 14 Jul 2025 11:39:03 +0200
> > > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > > 
> > > > > On Mon, Jul 14, 2025 at 05:39:15PM +0900, Masami Hiramatsu wrote:
> > > > > 
> > > > > > > +	/*
> > > > > > > +	 * Some of the uprobe consumers has changed sp, we can do nothing,
> > > > > > > +	 * just return via iret.
> > > > > > > +	 */
> > > > > > 
> > > > > > Do we allow consumers to change the `sp`? It seems dangerous
> > > > > > because consumer needs to know whether it is called from
> > > > > > breakpoint or syscall. Note that it has to set up ax, r11
> > > > > > and cx on the stack correctly only if it is called from syscall,
> > > > > > that is not compatible with breakpoint mode.
> > > > > > 
> > > > > > > +	if (regs->sp != sp)
> > > > > > > +		return regs->ax;
> > > > > > 
> > > > > > Shouldn't we recover regs->ip? Or in this case does consumer has
> > > > > > to change ip (== return address from trampline) too?
> > > > > > 
> > > > > > IMHO, it should not allow to change the `sp` and `ip` directly
> > > > > > in syscall mode. In case of kprobes, kprobe jump optimization
> > > > > > must be disabled explicitly (e.g. setting dummy post_handler)
> > > > > > if the handler changes `ip`.
> > > > > > 
> > > > > > Or, even if allowing to modify `sp` and `ip`, it should be helped
> > > > > > by this function, e.g. stack up the dummy regs->ax/r11/cx on the
> > > > > > new stack at the new `regs->sp`. This will allow modifying those
> > > > > > registries transparently as same as breakpoint mode.
> > > > > > In this case, I think we just need to remove above 2 lines.
> > > > > 
> > > > > There are two syscall return paths; the 'normal' is sysret and for that
> > > > > you need to undo all things just right.
> > > > > 
> > > > > The other is IRET. At which point we can have whatever state we want,
> > > > > including modified SP.
> > > > > 
> > > > > See arch/x86/entry/syscall_64.c:do_syscall_64() and
> > > > > arch/x86/entry/entry_64.S:entry_SYSCALL_64
> > > > > 
> > > > > The IRET path should return pt_regs as is from an interrupt/exception
> > > > > very much like INT3.
> > > > 
> > > > OK, so SYSRET case, we need to follow;
> > > > 
> > > > sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> trampoline -> retaddr
> > > > 
> > > > But using IRET to return, we can skip returning to trampoline,
> > > > 
> > > > sys_uprobe -> do_syscall_64 -> entry_SYSCALL_64 -> regs->ip
> > > 
> > > the handler gets the original breakpoint address, it's set in:
> > > 
> > >         regs->ip  = ax_r11_cx_ip[3] - 5;
> > > 
> > > and at the point we do:
> > > 
> > >         /*
> > >          * Some of the uprobe consumers has changed sp, we can do nothing,
> > >          * just return via iret.
> > >          */
> > >         if (regs->sp != sp)
> > >                 return regs->ax;
> > > 
> > > 
> > > .. regs->ip value wasn't restored for the trampoline's return address,
> > > so iret will skip the trampoline
> > 
> > Ah, OK. So unless we restore regs->cx = regs->ip and 
> > regs->r11 = regs->flags, it automatically use IRET. Got it.
> > 
> > > 
> > > but perhaps we could do the extra check below to land on the next instruction?
> > 
> > Hmm, can you clarify the required condition of changing regs
> > in the consumers? regs->sp change need to be handled by the
> > IRET, but other changes can be handled by trampoline. Is that
> > correct?
> 
> yes,
> if handler changes regs->sp we return through iret
> if handler changes regs->ip (the only other tricky one IIUC), we return through
> the trampoline and jump to regs->ip via trampoline's 'ret' instruction


Got it. Thanks for confirming it.

Thank you,

> 
> jirka


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

