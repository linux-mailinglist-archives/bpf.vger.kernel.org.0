Return-Path: <bpf+bounces-6779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3CE76DDB3
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 03:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93215281EEA
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 01:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A35046BF;
	Thu,  3 Aug 2023 01:55:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849D7F
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 01:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9989EC433C7;
	Thu,  3 Aug 2023 01:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691027733;
	bh=8bcmBU6UJXfBBUjLouuDS8paEUI0aVBdp/2XqX+Gop4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u19FFhV2TK+D+tVZD87Zm5hkMwHS8OoJgc7dVKX0fn9QT9ZTiwGReEZKV3JHR9syR
	 LR76vtAlG1FQ/MK27TEEMQhswKRZ0eL8HARcPWkZTII4h1BlOSxRnhCLrMVF45VxdM
	 kPyw7nK75ayI7lIE8UinDqMdIrS3F+xBspjiHKWd4qtcIzKq8Bh+YZnKGlTokzHFfx
	 IqWBKLjCybEoggTKv58GcbuK/sEh4K6hLoiWcbjCsZ37ghpMhnrStkv+le+4bBzOlt
	 cLPst9olh0Z1hrISOyfLooTy37ojSX7uSCc825cvCZHTHtJVlWr0aDVWJBW9xW9MG/
	 kuVX7cgU09BTw==
Date: Thu, 3 Aug 2023 10:55:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Florent Revest <revest@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-Id: <20230803105527.838017f58531af25c125f577@kernel.org>
In-Reply-To: <CABRcYm+-tBmM1sUMozPaa8fBfRFhTNpTNtwT5z6xz0nsZA=P0g@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
	<20230801085724.9bb07d2c82e5b6c6a6606848@kernel.org>
	<CAADnVQLaFpd2OhqP7W3xWB1b9P2GAKgrVQU1FU2yeNYKbCkT=Q@mail.gmail.com>
	<20230802000228.158f1bd605e497351611739e@kernel.org>
	<20230801112036.0d4ee60d@gandalf.local.home>
	<20230801113240.4e625020@gandalf.local.home>
	<CAADnVQ+N7b8_0UhndjwW9-5Vx2wUVvojujFLOCFr648DUv-Y2Q@mail.gmail.com>
	<20230801190920.7a1abfd5@gandalf.local.home>
	<20230802092146.9bda5e49528e6988ab97899c@kernel.org>
	<20230801204054.3884688e@rorschach.local.home>
	<20230802225634.f520080cd9de759d687a2b0a@kernel.org>
	<CABRcYm+-tBmM1sUMozPaa8fBfRFhTNpTNtwT5z6xz0nsZA=P0g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 2 Aug 2023 17:47:03 +0200
Florent Revest <revest@chromium.org> wrote:

> On Wed, Aug 2, 2023 at 3:56 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Tue, 1 Aug 2023 20:40:54 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Wed, 2 Aug 2023 09:21:46 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >
> > > > > Then use kprobes. When I asked Masami what the difference between fprobes
> > > > > and kprobes was, he told me that it would be that it would no longer rely
> > > > > on the slower FTRACE_WITH_REGS. But currently, it still does.
> > > >
> > > > kprobes needs to keep using pt_regs because software-breakpoint exception
> > > > handler gets that. And fprobe is used for bpf multi-kprobe interface,
> > > > but I think it can be optional.
> > > >
> > > > So until user-land tool supports the ftrace_regs, you can just disable
> > > > using fprobes if CONFIG_DYNAMIC_FTRACE_WITH_REGS=n
> > >
> > > I'm confused. I asked about the difference between kprobes on ftrace
> > > and fprobes, and you said it was to get rid of the requirement of
> > > FTRACE_WITH_REGS.
> > >
> > >  https://lore.kernel.org/all/20230120205535.98998636329ca4d5f8325bc3@kernel.org/
> >
> > Yes, it is for enabling fprobe (and fprobe-event) on more architectures.
> > I don't think it's possible to change everything at once. So, it will be
> > changed step by step. At the first step, I will replace pt_regs with
> > ftrace_regs, and make bpf_trace.c and fprobe_event depends on
> > FTRACE_WITH_REGS.
> >
> > At this point, we can split the problem into two, how to move bpf on
> > ftrace_regs and how to move fprobe-event on ftrace_regs. fprobe-event
> > change is not hard because it is closing in the kernel and I can do it.
> > But for BPF, I need to ask BPF user-land tools to support ftrace_regs.
> 
> Ah! I finally found the branch where I had pushed my proof of concept
> of fprobe with ftrace_regs... it's a few months old and I didn't get
> it in a state such that it could be sent to the list but maybe this
> can save you a little bit of lead time Masami :) (especially the bpf
> and arm64 specific bits)
> 
> https://github.com/FlorentRevest/linux/commits/bpf-arm-complete
> 
> 08afb628c6e1 ("ftrace: Add a macro to forge an incomplete pt_regs from
> a ftrace_regs")
> 203e96fe1790 ("fprobe, rethook: Use struct ftrace_regs instead of
> struct pt_regs")
> 1a9e280b9b16 ("arm64,rethook,kprobes: Replace kretprobe with rethook on arm64")
> 7751c6db9f9d ("bpf: Fix bpf get_func_ip() on arm64 multi-kprobe programs")
> a10c49c0d717 ("selftests/bpf: Update the tests deny list on aarch64")

Thanks for the work! I also pushed my patches on 

https://kernel.googlesource.com/pub/scm/linux/kernel/git/mhiramat/linux/+/refs/heads/topic/fprobe-ftrace-regs

628e6c19d7dc ("tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS")
311c98c29cfd ("fprobe: Use fprobe_regs in fprobe entry handler")

This doesn't cover arm64 and rethook, but provides ftrace_regs optimized
fprobe-event code, which uses a correct APIs for ftrace_regs.

For the rethook we still need to provide 2 version for kretprobe(pt_regs)
and fprobe(ftrace_regs).
I think eventually we should replace the kretprobe with fprobe, but
current rethook is tightly coupled with kretprobe and the kretprobe
needs pt_regs. So, I would like to keep arm64 kretprobe impl, and add
new rethook with ftrace_regs.

Or, maybe we need these 2 configs intermediately.
CONFIG_RETHOOK_WITH_REGS - in this case, kretprobe uses rethook
CONFIG_RETHOOK_WITH_ARGS - in this case, kretprobe uses its own stack

The problem is ftrace_regs only depends on CONFIG_DYNAMIC_FTRACE_WITH_*.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

