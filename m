Return-Path: <bpf+bounces-8063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A663E780B8B
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E60282372
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 12:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28818AE2;
	Fri, 18 Aug 2023 12:09:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E617FE9
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 12:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD8EC433C8;
	Fri, 18 Aug 2023 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692360595;
	bh=qRm/5BQEOqveVuPVOYC8Yu7FNSY0Aw9Zjpws7V195Mg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lgUKE5nlef6jyUQgTCNYyOWUiV8gyqOA4tQE2v5wPl42nB7U8/maPPo/B3YvKxbdC
	 n1nor5pfjj9ZIDn01Fr00qCBYurl/kNXSj9wtvtdUaeNg5q7McOnM/0IvzzxP+yIru
	 iqcL0g+rqhp4IB4PPhVp1tf3mGN4xXNKRDxwfqsMsRQu7Ym3N3pij1aRx4YcDUVyYJ
	 9oNFg2qLX29PaHT4Z23Xu8S2nUWhZS4vCvDgK11uNMWhHWIEgnPRl4oiiAdiAC8fgs
	 y9XCGiBqh+MuE5EyhTA5nmHyVYBGy+DAxr62vXck8gl0sMn7XURbpM1dhC6TVn1pcv
	 pQ8T9h23/ztZA==
Date: Fri, 18 Aug 2023 21:09:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 5/8] tracing/fprobe: Enable fprobe events with
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20230818210949.e7811cb660d979e1c94a7a20@kernel.org>
In-Reply-To: <CAADnVQ+En1sxXFrDZBefDCBSS=mChDJ3Xg_Xz+WKXmPqziSxgw@mail.gmail.com>
References: <169181859570.505132.10136520092011157898.stgit@devnote2>
	<169181865486.505132.6447946094827872988.stgit@devnote2>
	<CAADnVQ+En1sxXFrDZBefDCBSS=mChDJ3Xg_Xz+WKXmPqziSxgw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Aug 2023 13:44:41 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Fri, Aug 11, 2023 at 10:37 PM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > +#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API
> > +static __always_inline unsigned long
> > +ftrace_regs_get_kernel_stack_nth(struct ftrace_regs *fregs, unsigned int nth)
> > +{
> > +       unsigned long *stackp;
> > +
> > +       stackp = (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
> > +       if (((unsigned long)(stackp + nth) & ~(THREAD_SIZE - 1)) ==
> > +           ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
> > +               return *(stackp + nth);
> > +
> > +       return 0;
> > +}
> > +#endif /* CONFIG_HAVE_REGS_AND_STACK_ACCESS_API */
> ...
> >
> > @@ -140,17 +140,17 @@ process_fetch_insn(struct fetch_insn *code, void *rec, void *dest,
> >         /* 1st stage: get value from context */
> >         switch (code->op) {
> >         case FETCH_OP_STACK:
> > -               val = regs_get_kernel_stack_nth(regs, code->param);
> > +               val = ftrace_regs_get_kernel_stack_nth(fregs, code->param);
> >                 break;
> 
> Just noticed that bit.
> You probably want to document that access to arguments and
> especially arguments on stack is not precise. It's "best effort".
> x86-64 calling convention is not as simple as it might appear.
> For example if 6th argument is a 16-byte struct like sockptr_t it will be
> passed on the stack and 7th actual argument (if it's <= 8 byte) will
> be the register.

Yes, that's right. To access the precise arguments, the easiest way is
using DWARF (e.g. perf probe), and another way is reconstruct the ABI
from the type like BTF.

> 
> Things similar on 32-bit and there is a non-zero chance that
> regs_get_kernel_argument() doesn't return the actual arg.

Yeah, it is hard to get the actual argument...

Let me update the document.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

