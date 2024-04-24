Return-Path: <bpf+bounces-27684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864038B0C98
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 16:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E721C249AB
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9416315E80A;
	Wed, 24 Apr 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF5mQVER"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B391E535;
	Wed, 24 Apr 2024 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969123; cv=none; b=jWj/rLB0CP37uqzPt1GekBAixXiEa13WSgmRqLY2R2WO8uutgNyD9YydEjvFIPEjr4HuGyi/lD1fGsXdhb1keyT+HrSth7eqL5hDSaMZud6c+J8E5XykI4zbuCQWn2unVhOTeimC0B0Ggp5OEYzQj/VPtYNaThUOKLQ9nagp2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969123; c=relaxed/simple;
	bh=wAod5RSgdsjuTw+r1YaB6JyjK+go0sx8F9HiXNQiL+c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=phYfFZqmjfDKQusCUYGn1l3CceFJLVx7dyUTTDKQ//k05dNJcbBon8QMfCF30lbTl/nr1yY59d/a0Qkma8TSP+8Y1GK3p+6113u5gNZm6wkAhoCuBvvPOQ3gKNZGhoEAka+BXzEVpERwwBkoi+9vijLIQuB3/5ObUfijUw1sOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF5mQVER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B754BC113CD;
	Wed, 24 Apr 2024 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969122;
	bh=wAod5RSgdsjuTw+r1YaB6JyjK+go0sx8F9HiXNQiL+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YF5mQVERP1lV0bpGS15IMBcfuFXzXrJHuxpR36+ZbHsx7429bMXL550RKR76jvgi3
	 NvnfhA1/owyvN77viCAM/xEJmmnLXO9Bv8ICnRsZQx3lO20Cn6UiWoXZ08CY696eDB
	 IugIt2fcj8iLcs+c/Ld8p2FEEx0YEbzk3BnqgH8naoHcnXyA5ePl+jmPOSr235eccc
	 WnTiFFrellPtqecVJEOnSLTzXABA6rtikRiFEVgzDkXiPzQPO/3+3VikHSjc78ByRY
	 Qq+WHny79SINk1mw+FMA69BKGAGNhRN7yIfnW4/PKQ7qvXhbYcLg9q6/4dnFdkKUNX
	 XUDbghxo88H4g==
Date: Wed, 24 Apr 2024 23:31:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v9 01/36] tracing: Add a comment about ftrace_regs
 definition
Message-Id: <20240424233156.67b39d2a3485069fed156308@kernel.org>
In-Reply-To: <CABRcYmK+JMLDf41csuZB4aJSb9956wTy=5rpB1YDsSv0-MoZHg@mail.gmail.com>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
	<171318535003.254850.2125783941049872788.stgit@devnote2>
	<CABRcYmK_Btem8cBbz=j==RWxw11PQ8cNAUshNA540VD3O=2WEQ@mail.gmail.com>
	<CABRcYmK+JMLDf41csuZB4aJSb9956wTy=5rpB1YDsSv0-MoZHg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 24 Apr 2024 15:19:24 +0200
Florent Revest <revest@chromium.org> wrote:

> On Wed, Apr 24, 2024 at 2:23 PM Florent Revest <revest@chromium.org> wrote:
> >
> > On Mon, Apr 15, 2024 at 2:49 PM Masami Hiramatsu (Google)
> > <mhiramat@kernel.org> wrote:
> > >
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > >
> > > To clarify what will be expected on ftrace_regs, add a comment to the
> > > architecture independent definition of the ftrace_regs.
> > >
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > ---
> > >  Changes in v8:
> > >   - Update that the saved registers depends on the context.
> > >  Changes in v3:
> > >   - Add instruction pointer
> > >  Changes in v2:
> > >   - newly added.
> > > ---
> > >  include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index 54d53f345d14..b81f1afa82a1 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -118,6 +118,32 @@ extern int ftrace_enabled;
> > >
> > >  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > >
> > > +/**
> > > + * ftrace_regs - ftrace partial/optimal register set
> > > + *
> > > + * ftrace_regs represents a group of registers which is used at the
> > > + * function entry and exit. There are three types of registers.
> > > + *
> > > + * - Registers for passing the parameters to callee, including the stack
> > > + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> > > + * - Registers for passing the return values to caller.
> > > + *   (e.g. rax and rdx on x86_64)
> >
> > Ooc, have we ever considered skipping argument registers that are not
> > return value registers in the exit code paths ? For example, why would
> > we want to save rdi in a return handler ?
> >
> > But if we want to avoid the situation of having "sparse ftrace_regs"
> > all over again, we'd have to split ftrace_regs into a ftrace_args_regs
> > and a ftrace_ret_regs which would make this refactoring even more
> > painful, just to skip a few instructions. :|
> >
> > I don't necessarily think it's worth it, I just wanted to make sure
> > this was considered.
> 
> Ah, well, I just reached patch 22 and noticed that there you add add:
> 
> + * Basically, ftrace_regs stores the registers related to the context.
> + * On function entry, registers for function parameters and hooking the
> + * function call are stored, and on function exit, registers for function
> + * return value and frame pointers are stored.
> 
> So ftrace_regs can be a a sparse structure then. That's fair enough with me! ;)

Yes, and in this patch, I explained that too :)

> + * On the function entry, those registers will be restored except for
> + * the stack pointer, so that user can change the function parameters
> + * and instruction pointer (e.g. live patching.)
> + * On the function exit, only registers which is used for return values
> > + * are restored.

So the function exit, ftrace_regs will be sparse.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

