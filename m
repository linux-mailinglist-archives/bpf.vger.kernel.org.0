Return-Path: <bpf+bounces-7408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A4776D0D
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 02:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0362819C3
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 00:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AACE20F84;
	Thu, 10 Aug 2023 00:33:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980720F80
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 00:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5ACC433C8;
	Thu, 10 Aug 2023 00:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691627584;
	bh=L/nbIIt6zQRsornqrDmxHVuKE509Rih5VtpoAPTtkNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nY2t7RB6ZCGimEDoo7ZUzJI2tWUpvfBJkWdmpNwLld5tRVP7DWeWna8rVTkzmpLfa
	 iQjgesMOOnPj7T1UzQ3O3Ibeov36vklap0HE+zCPjLVdenaR5QyHTVpVHsJ4XtJENS
	 alrC1J8wcGRcVbrDb7z4yrtbLbvSSry5sCWiq8RZYv5t00hHNhE/hDbP1G48NC+eTj
	 K33CpquJiGUMKxWl2fiJJ2PeqdG/44dSUlcIa3vHn/uBMTrHsKIZ7pSW5ZJGeSkgIv
	 nHRHye4BWxFrcbu/feH6Lrnke69yDLM5B6eTkYLJp4vUOuZQjp+zPk3mMATvyeAUqd
	 AZv/jPlUTERfA==
Date: Thu, 10 Aug 2023 09:32:57 +0900
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
 Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 3/6] fprobe: rethook: Use fprobe_regs in fprobe
 exit handler and rethook
Message-Id: <20230810093257.e6954e08ae7e3ae628181535@kernel.org>
In-Reply-To: <CABRcYmLe05UiK+-mCq5LA0d1Xomdpb+R_5A5HLBLbuBqfBCwUA@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
	<169139093899.324433.3739544465888158332.stgit@devnote2>
	<CABRcYmK6X6okNKNu9ZjgLEO+JMGL42j7idE8QPZ_EpYA9S9UZQ@mail.gmail.com>
	<20230809234318.08784e46d0b7d88c1bccedbe@kernel.org>
	<CABRcYmLe05UiK+-mCq5LA0d1Xomdpb+R_5A5HLBLbuBqfBCwUA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 9 Aug 2023 17:45:29 +0200
Florent Revest <revest@chromium.org> wrote:

> On Wed, Aug 9, 2023 at 4:43 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > > I think there are two things that can be meant with "rethook uses ftrace_regs":
> > >
> > > - rethook callbacks receive a ftrace_regs (that's what you do further down)
> > > - rethook can hook to a traced function using a ftrace_regs (that's
> > > what you use in fprobe now)
> > >
> > > But I think the second proposition shouldn't imply that rethook_hook
> > > can _only_ hook to ftrace_regs. For the kprobe use case, I think there
> > > should also be a rethook_hook_pt_regs() that operates on a pt_regs. We
> > > could have a default implementation of rethook_hook that calls into
> > > the other (or vice versa) on HAVE_FTRACE_REGS_COMPATIBLE_WITH_PT_REGS
> > > but I think it's good to separate these two APIs
> >
> > Yeah, so for simplying the 2nd case, I added this dependency.
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index aff2746c8af2..e321bdb8b22b 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -201,6 +201,7 @@ config KRETPROBE_ON_RETHOOK
> >         def_bool y
> >         depends on HAVE_RETHOOK
> >         depends on KRETPROBES
> > +       depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >         select RETHOOK
> >
> > This is the point why I said that "do not remove kretprobe trampoline".
> > If there is arch dependent kretprobe trampoline, kretprobe does not use
> > the rethook for hooking return. And eventually I would like to remove
> > kretprobe itself (replace it with fprobe + rethook). If so, I don't want
> > to pay more efforts on this part, and keep kretprobe on rethook as it is.
> 
> What are your thoughts on kprobe + rethook though ?

Isn't it KRETPROBE_ON_RETHOOK?

> If that's something you think is worth having, then in this case, it
> seems that having a rethook_hook_pt_regs() API would help users.
> 
> If that's a frankenstein use case you don't want to support then I
> agree we can live without this API and get away with the cast
> protected by the depends on HAVE_PT_REGS_COMPAT_FTRACE_REGS...

Yeah, it needs to introduce arch_rethook_prepare_pt_regs() for each
arch too.

BTW, I found that I have to update the implementation of
arch_rethook_prepare() for x86. (Use ftrace_get_stack_pointer())

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

