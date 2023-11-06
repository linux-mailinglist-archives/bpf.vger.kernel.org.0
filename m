Return-Path: <bpf+bounces-14289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D2D7E2232
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 13:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A202BB20EC3
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB871A592;
	Mon,  6 Nov 2023 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giNYOukD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D133D5;
	Mon,  6 Nov 2023 12:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29123C433C7;
	Mon,  6 Nov 2023 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699274836;
	bh=ZKPkoYHE+kdPCNAugjno/omWZzc7yMN7RXy8qs3DD5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=giNYOukD28FBmGEenY1xFYwWuBmV8/q/WR0g1ZPiIKOpz2FvZN1YF3y8ncXXdiXru
	 ic8wuicePL6JiQY8EkJaNqGFbHqlORc90fpqo9dPUOLx0UsYqvjyZzdRJ3MPwCLFdK
	 tcAycTq9JxTcslU3E8TF914Y/Srma8S+f2wajFRD4VoRF+L8YAHXW+j4klmaDZyUuE
	 qxpIpfqJ8WwDtmg6D1erTp35IuKdrinzKFXNv87uTto31RmsT+TkamFExYM0eU1sjv
	 elo7YvY1YyCkl7bUEGeQRzlMTgxCE3Ff5ivV3bYwZ0FVAGXZU8mFdCghMF3+kyFeXj
	 BYiMAISbrqavA==
Date: Mon, 6 Nov 2023 21:47:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-Id: <20231106214708.d132cfd9984beac55e4b420e@kernel.org>
In-Reply-To: <20231106101932.GJ8262@noisy.programming.kicks-ass.net>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920068069.482486.6540417903833579700.stgit@devnote2>
	<20231105172536.GA7124@noisy.programming.kicks-ass.net>
	<20231105141130.6ef7d8bd@rorschach.local.home>
	<20231105231734.GE3818@noisy.programming.kicks-ass.net>
	<20231105183301.38be5598@rorschach.local.home>
	<20231105183409.424bc368@rorschach.local.home>
	<20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>
	<20231106101932.GJ8262@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Nov 2023 11:19:32 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Nov 06, 2023 at 09:38:50AM +0900, Masami Hiramatsu wrote:
> > On Sun, 5 Nov 2023 18:34:09 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Sun, 5 Nov 2023 18:33:01 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > 
> > > > For x86_64, that would be:
> > > > 
> > > >   rdi, rsi, rdx, r8, r9, rsp
> > > 
> > > I missed rcx.
> > 
> > I would like to add rax to the list so that it can handle the return value too. :)
> 
> So something like so?
> 
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 897cf02c20b1..71bfe27594a5 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -36,6 +36,10 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  
>  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  struct ftrace_regs {
> +	/*
> +	 * Partial, filled with:
> +	 *  rax, rcx, rdx, rdi, rsi, r8, r9, rsp

Don't we need rbp too? (for frame pointer)


> +	 */
>  	struct pt_regs		regs;
>  };


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

