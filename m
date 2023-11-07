Return-Path: <bpf+bounces-14343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA97E32B4
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 02:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36185B20A8D
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 01:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D8020F5;
	Tue,  7 Nov 2023 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+2Cu3r9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40720E7;
	Tue,  7 Nov 2023 01:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714DDC433C7;
	Tue,  7 Nov 2023 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699321771;
	bh=o57Oo72eUrm3u6MYx7YL/oAhyhHYwVpaaRbGoLiy8Ao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B+2Cu3r90Z6yufZ45PfuS8fRl2gsvd6mS0EeFsljOCkwS+le68hgcXilqdyS+VwjA
	 cf9SSnrDRYrLK/u5n2pHeayvVzrFmxwAKc3rYvb7D76n5Wq0rn/9XNNuETE+gDz4Cj
	 MXl21GkEse8aau0NuGosfM8vscpUObcLo8NZKby6ArXAVP40ugolVRm/CLLoeLQSJ/
	 Z1lRO4DnFJolokdvI+9gr0ZrYvNLN1YLsJO7Z38opKRlwBTyLXG/Zx5Blldrw1aa2b
	 0sdr+Q00BjvJHDqZNYdOADyr4phIyrCDM7tm2tBvzuqus7wE5JtycxgcU+ccygBYlG
	 TeMCFWI3cCK8Q==
Date: Tue, 7 Nov 2023 10:49:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
Message-Id: <20231107104924.d992919b8277be36d6fa8455@kernel.org>
In-Reply-To: <20231106190416.cbd04fdd5bb9cdff72563e64@kernel.org>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920060974.482486.15664806338999944098.stgit@devnote2>
	<20231106190416.cbd04fdd5bb9cdff72563e64@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Nov 2023 19:04:16 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon,  6 Nov 2023 01:10:10 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Fix to initialize the ftrace_ops of fgraph_ops with ftrace_graph_func
> > instead of ftrace_stub.
> 
> I've changed this, because fprobe entry handler is not called via
> fgraph without this. But maybe I have to set correct gops->ops.func
> after init?

I confirmed that this is right because it is introduced by
0c0593b45c9b ("x86/ftrace: Make function graph use ftrace directly")
which replaces ftrace_stub with ftrace_graph_func (which automatically
switched by architecture)

Thanks,

> 
> Thank you,
> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/fgraph.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> > index 597250bd30dc..858fb73440ec 100644
> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -872,7 +872,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
> >  void fgraph_init_ops(struct ftrace_ops *dst_ops,
> >  		     struct ftrace_ops *src_ops)
> >  {
> > -	dst_ops->func = ftrace_stub;
> > +	dst_ops->func = ftrace_graph_func;
> >  	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_FL_STUB;
> >  
> >  #ifdef FTRACE_GRAPH_TRAMP_ADDR
> > @@ -1120,7 +1120,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
> >  
> >  	if (!gops->ops.func) {
> >  		gops->ops.flags |= FTRACE_OPS_FL_STUB;
> > -		gops->ops.func = ftrace_stub;
> > +		gops->ops.func = ftrace_graph_func;
> >  #ifdef FTRACE_GRAPH_TRAMP_ADDR
> >  		gops->ops.trampoline = FTRACE_GRAPH_TRAMP_ADDR;
> >  #endif
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

