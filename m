Return-Path: <bpf+bounces-8061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B23780AA5
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC141C21601
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3E182AA;
	Fri, 18 Aug 2023 11:01:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E0614F61
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 11:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B846C433C8;
	Fri, 18 Aug 2023 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692356514;
	bh=7hSNv8eDnTjtYePwvMwfe0ilLiKcuhYv/oX8ohwRoT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V0/1fHV+ivD5ad5/S+EYa0zA4ukXawKVPlfQJVOK7i8X2MDyjC4Hm/FTqoFo5S5G0
	 xIjHJcxyqHfD5Lj27zk7OOAiRdRFRfV94Qr5OX/r0fgUzBk3NtS9DBiQuIMMG7rIEs
	 oEfQk5s+ejjlTb/Q8sWF1Q1ZKFvqGzqczi+sNecyxUlD+y5hgV0PNCRvi4POgqSAGG
	 vOKUqATOchaBb/apLmQHmoSw0hDqG40qCPgWfC6SGOU7Au/hZpJyb9KGR6aLpL0Vue
	 1vm/rCyhFdbsK6fRCFBdttFUn2QggLpa3chgtMKdgdFXekXbXU2KAXDoVwI86TIcWU
	 Pn+JszsTy7R/Q==
Date: Fri, 18 Aug 2023 20:01:48 +0900
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
Subject: Re: [PATCH v3 4/8] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
Message-Id: <20230818200148.66fd9878ddd32f810c6ae860@kernel.org>
In-Reply-To: <CABRcYmK2-jiDOrTqjgg41t0T2-Uf1jbsuiV0xT37M=5cVCB+Zw@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
	<169181864347.505132.7098838654251139622.stgit@devnote2>
	<CABRcYmK2-jiDOrTqjgg41t0T2-Uf1jbsuiV0xT37M=5cVCB+Zw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Aug 2023 10:57:40 +0200
Florent Revest <revest@chromium.org> wrote:

> On Sat, Aug 12, 2023 at 7:37 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 976fd594b446..d56304276318 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -57,6 +57,13 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >          This allows for use of ftrace_regs_get_argument() and
> >          ftrace_regs_get_stack_pointer().
> >
> > +config HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> > +       bool
> > +       help
> > +        If this is set, the memory layout of the ftrace_regs data structure
> > +        is the same as the pt_regs. So the pt_regs is possible to be casted
> > +        to ftrace_regs.
> 
> What would you think of introducing a:
> 
> #ifdef HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> static_assert(sizeof(struct pt_regs) == sizeof(struct ftrace_regs);
> #endif // HAVE_PT_REGS_TO_FTRACE_REGS_CAST
> 
> somewhere in ftrace.h just as a small extra safety net ? It doesn't
> exactly guarantee all we want but it should give an early warning of
> mistakes.

That's a good idea :)
OK, I'll add it in the next version.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

