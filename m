Return-Path: <bpf+bounces-14342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E717E32AF
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 02:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EB21C20971
	for <lists+bpf@lfdr.de>; Tue,  7 Nov 2023 01:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121391C06;
	Tue,  7 Nov 2023 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7zjE0NZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D538D;
	Tue,  7 Nov 2023 01:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42041C433C8;
	Tue,  7 Nov 2023 01:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699321681;
	bh=CKwjpTG7MJNielJIoM00sd6eXu7x3IOlS8MVxwqNats=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L7zjE0NZtBV4FbRXpTA7PX5NK1699ItkbVPWK1Db8EMXaVV5e4Pv2t6QetZOqNqzM
	 WFOxVZ6MaND1ZMBTNKvSWtq0kVUsL7enH9vY7D926KZDVmviZXJMstE/lEFL711Feh
	 7S/C16ULC9LGt0lbSYmWF2Or3rb+vI9Am8vUqO1RIKFRwz9FRct1itz40jRhLjvt2i
	 2HNffJRb9ewxov/3kbv1HFUTjb81hhMMGrudtRqIbSX99iKEEUmlvvHkKlAflSrIhJ
	 ZQEaj/E1eEjNB9yPFJg8v/hWmyZoXP7BPzFXmDV2VGKcSoJ68DS0QcfkzahQqEWoa1
	 8fV3D+qYyO9Vg==
Date: Tue, 7 Nov 2023 10:47:55 +0900
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
Subject: Re: [RFC PATCH 10/32] function_graph: Have the instances use their
 own ftrace_ops for filtering
Message-Id: <20231107104755.19a72f896a016f5d4c165f31@kernel.org>
In-Reply-To: <169920051199.482486.17674190105884047734.stgit@devnote2>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920051199.482486.17674190105884047734.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Nov 2023 01:08:32 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Allow for instances to have their own ftrace_ops part of the fgraph_ops that
> makes the funtion_graph tracer filter on the set_ftrace_filter file of the
> instance and not the top instance.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/ftrace.h               |    1 +
>  kernel/trace/fgraph.c                |   60 +++++++++++++++++++++-------------
>  kernel/trace/ftrace.c                |    6 ++-
>  kernel/trace/trace.h                 |   16 +++++----
>  kernel/trace/trace_functions.c       |    2 +
>  kernel/trace/trace_functions_graph.c |    8 +++--
>  6 files changed, 58 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 7fd044ae3da5..9dab365c6023 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1044,6 +1044,7 @@ extern int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace, struct fgraph
>  struct fgraph_ops {
>  	trace_func_graph_ent_t		entryfunc;
>  	trace_func_graph_ret_t		retfunc;
> +	struct ftrace_ops		ops; /* for the hash lists */
>  	void				*private;
>  };
>  
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 1e8c17f70b84..0642f3281b64 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -17,14 +17,6 @@
>  #include "ftrace_internal.h"
>  #include "trace.h"
>  
> -#ifdef CONFIG_DYNAMIC_FTRACE
> -#define ASSIGN_OPS_HASH(opsname, val) \
> -	.func_hash		= val, \
> -	.local_hash.regex_lock	= __MUTEX_INITIALIZER(opsname.local_hash.regex_lock),
> -#else
> -#define ASSIGN_OPS_HASH(opsname, val)
> -#endif
> -
>  #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
>  #define FGRAPH_RET_INDEX (FGRAPH_RET_SIZE / sizeof(long))
>  
> @@ -338,9 +330,6 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  		return -EBUSY;
>  #endif
>  
> -	if (!ftrace_ops_test(&global_ops, func, NULL))
> -		return -EBUSY;
> -
>  	trace.func = func;
>  	trace.depth = ++current->curr_ret_depth;
>  
> @@ -361,7 +350,8 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  			atomic_inc(&current->trace_overrun);
>  			break;
>  		}
> -		if (fgraph_array[i]->entryfunc(&trace, fgraph_array[i])) {
> +		if (ftrace_ops_test(&gops->ops, func, NULL) &&
> +		    gops->entryfunc(&trace, gops)) {
>  			offset = current->curr_ret_stack;
>  			/* Check the top level stored word */
>  			type = get_fgraph_type(current, offset - 1);
> @@ -656,17 +646,25 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  }
>  #endif /* HAVE_FUNCTION_GRAPH_RET_ADDR_PTR */
>  
> -static struct ftrace_ops graph_ops = {
> -	.func			= ftrace_graph_func,
> -	.flags			= FTRACE_OPS_FL_INITIALIZED |
> -				   FTRACE_OPS_FL_PID |
> -				   FTRACE_OPS_GRAPH_STUB,
> +void fgraph_init_ops(struct ftrace_ops *dst_ops,
> +		     struct ftrace_ops *src_ops)
> +{
> +	dst_ops->func = ftrace_stub;
> +	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_FL_STUB;

This needs to use FTRACE_OPS_GRAPH_STUB instead of FTRACE_OPS_FL_STUB, 
because commit 0c0593b45c9b ("x86/ftrace: Make function graph use ftrace
directly") introduced this flag to switch the mode. (fgraph on ftrace)

> +
>  #ifdef FTRACE_GRAPH_TRAMP_ADDR
> -	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
> +	dst_ops->trampoline = FTRACE_GRAPH_TRAMP_ADDR;
>  	/* trampoline_size is only needed for dynamically allocated tramps */
>  #endif
> -	ASSIGN_OPS_HASH(graph_ops, &global_ops.local_hash)
> -};
> +
> +#ifdef CONFIG_DYNAMIC_FTRACE
> +	if (src_ops) {
> +		dst_ops->func_hash = &src_ops->local_hash;
> +		mutex_init(&dst_ops->local_hash.regex_lock);
> +		dst_ops->flags |= FTRACE_OPS_FL_INITIALIZED;
> +	}
> +#endif
> +}
>  
>  void ftrace_graph_sleep_time_control(bool enable)
>  {
> @@ -871,11 +869,20 @@ static int start_graph_tracing(void)
>  
>  int register_ftrace_graph(struct fgraph_ops *gops)
>  {
> +	int command = 0;
>  	int ret = 0;
>  	int i;
>  
>  	mutex_lock(&ftrace_lock);
>  
> +	if (!gops->ops.func) {
> +		gops->ops.flags |= FTRACE_OPS_FL_STUB;

Ditto.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

