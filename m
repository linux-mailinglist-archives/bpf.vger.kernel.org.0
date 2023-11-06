Return-Path: <bpf+bounces-14285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3577E1DD9
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 11:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2CF1C20B63
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FE171D7;
	Mon,  6 Nov 2023 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bov0Hu9H"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E9317730;
	Mon,  6 Nov 2023 10:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CF4C433C7;
	Mon,  6 Nov 2023 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699265062;
	bh=N+J4uYmXVpTzfaXKjD6eS71G3lnyCcY7HtDKx1e+Uts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bov0Hu9H0C1RcT+NiXHNn+Pibn5nMp6Y45MKQJCmsmiNT0AlDwPjmasythPTi8B4p
	 JKsmpx+T/Cnf3/7nhpaiGRiZh3cC6Wjrf7UEAJEwoz/aYcweViMP2ZXLc3JOBHaR+Z
	 IUqacxRFDE4Mn2VB0DNucAnLf0wGpEmc5znw/gUCGwSXTYtE4Nq9OipLq2MRN/n9BD
	 OoLoG4QEWt7A19uM6bmpDcbRQAp4KOS7x+7KQuxOtV1zbro++cjVaqyHOCqZ4K/AHN
	 OUIDxeaxwf0T84aI2O36puv5Ko76ATVLCs9GyjydvIpTWY117PxdUSGDonRkZe48Kc
	 4ZNZqDd4eihzQ==
Date: Mon, 6 Nov 2023 19:04:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 18/32] function_graph: Fix to initalize ftrace_ops
 for fgraph with ftrace_graph_func
Message-Id: <20231106190416.cbd04fdd5bb9cdff72563e64@kernel.org>
In-Reply-To: <169920060974.482486.15664806338999944098.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920060974.482486.15664806338999944098.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Nov 2023 01:10:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to initialize the ftrace_ops of fgraph_ops with ftrace_graph_func
> instead of ftrace_stub.

I've changed this, because fprobe entry handler is not called via
fgraph without this. But maybe I have to set correct gops->ops.func
after init?

Thank you,

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fgraph.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 597250bd30dc..858fb73440ec 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -872,7 +872,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  void fgraph_init_ops(struct ftrace_ops *dst_ops,
>  		     struct ftrace_ops *src_ops)
>  {
> -	dst_ops->func = ftrace_stub;
> +	dst_ops->func = ftrace_graph_func;
>  	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_FL_STUB;
>  
>  #ifdef FTRACE_GRAPH_TRAMP_ADDR
> @@ -1120,7 +1120,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  
>  	if (!gops->ops.func) {
>  		gops->ops.flags |= FTRACE_OPS_FL_STUB;
> -		gops->ops.func = ftrace_stub;
> +		gops->ops.func = ftrace_graph_func;
>  #ifdef FTRACE_GRAPH_TRAMP_ADDR
>  		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;
>  #endif
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

