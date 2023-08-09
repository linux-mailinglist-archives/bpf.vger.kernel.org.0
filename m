Return-Path: <bpf+bounces-7362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AC3776216
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 16:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0E01C2122E
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FA719BAB;
	Wed,  9 Aug 2023 14:10:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F34612D
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 14:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF941C433C8;
	Wed,  9 Aug 2023 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691590217;
	bh=2eEmHOtaW98wEIaTzp1lW7UBm7j4xm9z1dP/0aIC++8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R9HffduBuPOErEDethBZPLCgOiIDoL5ALMjPA5YwJbsIEtlphtvcF5EQ1XxOQz+T5
	 bge7lkcC+E9rS8ioMfGLf1kgPPAAF/qrhkbin4oikq+BCiwUYAUbdFBoijg20wyKBG
	 EpaP3M9ZFVIjouUYix6gT0jQWzoMGJK/hY6vl4CE91QmIzkD9selukv1VTxuwaPUvD
	 ObOWf5lLnlBwExfhxAicq1Ufi+pPDzA3eme/iNZobG+vZJmLKGnRBWttFWaaJOIZQc
	 r4zW1yZnWwvEOSXW14L73xPPx+9Abe5gLLExjGgTryXBg1bsXCjCh3YmGUM0bt1JlS
	 a5GhL+hIz1AsA==
Date: Wed, 9 Aug 2023 23:10:11 +0900
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
Subject: Re: [RFC PATCH v2 1/6] fprobe: Use fprobe_regs in fprobe entry
 handler
Message-Id: <20230809231011.b125bd68887a5659db59905e@kernel.org>
In-Reply-To: <CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
References: <169139090386.324433.6412259486776991296.stgit@devnote2>
	<169139091575.324433.13168120610633669432.stgit@devnote2>
	<CABRcYmKRAbOuqNQm5mCwC9NWbtcz1JJDYL_h5x6dK77SJ5FRkA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Florent,

On Wed, 9 Aug 2023 12:28:38 +0200
Florent Revest <revest@chromium.org> wrote:

> On Mon, Aug 7, 2023 at 8:48 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> > on arm64.
> 
> This patch lets fprobe code build on configs WITH_ARGS and !WITH_REGS
> but fprobe wouldn't run on these builds because fprobe still registers
> to ftrace with FTRACE_OPS_FL_SAVE_REGS, which would fail on
> !WITH_REGS. Shouldn't we also let the fprobe_init callers decide
> whether they want REGS or not ?

Ah, I think you meant FPROBE_EVENTS? Yes I forgot to add the dependency
on it. But fprobe itself can work because fprobe just pass the ftrace_regs
to the handlers. (Note that exit callback may not work until next patch)

> 
> >  static int
> >  kprobe_multi_link_handler(struct fprobe *fp, unsigned long fentry_ip,
> > -                         unsigned long ret_ip, struct pt_regs *regs,
> > +                         unsigned long ret_ip, struct ftrace_regs *fregs,
> >                           void *data)
> >  {
> >         struct bpf_kprobe_multi_link *link;
> > +       struct pt_regs *regs = ftrace_get_regs(fregs);
> > +
> > +       if (!regs)
> > +               return 0;
> 
> (with the above comment addressed) this means that BPF multi_kprobe
> would successfully attach on builds WITH_ARGS but the programs would
> never actually run because here regs would be 0. This is a confusing
> failure mode for the user. I think that if multi_kprobe won't work
> (because we don't have a pt_regs conversion path yet), the user should
> be notified at attachment time that they won't be getting any events.

Yes, so I changed it will not be compiled in that case.

@@ -2460,7 +2460,7 @@ static int __init bpf_event_init(void)
 fs_initcall(bpf_event_init);
 #endif /* CONFIG_MODULES */
 
-#ifdef CONFIG_FPROBE
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 struct bpf_kprobe_multi_link {
 	struct bpf_link link;
 	struct fprobe fp;

> That's why I think kprobe_multi should inform fprobe_init that it
> wants FTRACE_OPS_FL_SAVE_REGS and fail if that's not possible (no
> trampoline for it for example)

Yeah, that's another possibility, but in the previous thread we
discussed and agreed to introduce the ftrace_partial_regs() which
will copy the partial registers from ftrace_regs to pt_regs.


Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

