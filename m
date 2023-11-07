Return-Path: <bpf+bounces-14376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584017E34EF
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 06:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9209A1C20A6C
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 05:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A522106;
	Tue,  7 Nov 2023 05:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjyH0wDe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB5920E7;
	Tue,  7 Nov 2023 05:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F43C433C7;
	Tue,  7 Nov 2023 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699335812;
	bh=ZjCW8mn+WzSc8W2ku8xQ1P6bpGEosFP1Q+Pzo/jsu2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OjyH0wDe0oDtiIOwS9+037THfI23Qg7eC47ZeuyigIfTzrLjZxQ5f2yufpj+EKPmZ
	 /VpX+Iy2mgxC9km1jhBFskyZdf3W3rT7JRrbrOdrQDiQz54cEvPpFs8pOIswNtG0Fh
	 CPLdbFB/M42woObZYUAIPrHAp3VFA5UA2T58ShaZyl7HdtX6z2rokmMLOGf3guySwX
	 Kq8jCffiYPrixWIZBGmeGeYM8gPEa3+beLteCGByQ1VX9OH+37rqdEkF+8xlSeLQD/
	 F4xsD16R7Pzw1hMF+b/IeI7AZUbIH0y8kL/MAiW0yRH4SXqewg2Ggw/zdwfr+7ffCI
	 G+d5s0PC8CsGA==
Date: Tue, 7 Nov 2023 14:43:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-Id: <20231107144328.cc763a2a137391ceb105e9db@kernel.org>
In-Reply-To: <20231106220617.5eb73f2f@gandalf.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920068069.482486.6540417903833579700.stgit@devnote2>
	<20231105172536.GA7124@noisy.programming.kicks-ass.net>
	<20231105141130.6ef7d8bd@rorschach.local.home>
	<20231105231734.GE3818@noisy.programming.kicks-ass.net>
	<20231105183301.38be5598@rorschach.local.home>
	<20231106100549.33f6ce30d968906979ca3954@kernel.org>
	<20231106113710.3bf69211@gandalf.local.home>
	<20231107094258.d41a46c202197e92bc6d9656@kernel.org>
	<20231106220617.5eb73f2f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Nov 2023 22:06:17 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 7 Nov 2023 09:42:58 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Got it. So does ftrace_regs need a placeholder for direct trampoline?
> > (Or, can we use a register to pass it?)
> > I think we don't need to clear it for return_to_handler() but if
> > `ftrace_regs` spec requires it, it is better to do so.
> 
> It's per arch defined. I think I wrote somewhere that it just needs to pass
> back something that can tell if the handler is to return to a direct
> trampoline or not. It could be a unused register, or something else.

Oh, I meant the flag (address) for "return" trampoline. If we have
direct "return" trampoline we may use it, but currently not.

> 
> It's only needed if an architecture supports direct trampolines.

I see, and x86_64 needs it.
OK, maybe better to keep it clear on x86-64 even on the
return handler.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

