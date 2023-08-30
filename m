Return-Path: <bpf+bounces-8970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C300778D386
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 09:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8BF1C20AFC
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 07:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B481865;
	Wed, 30 Aug 2023 07:20:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD481847
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 07:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFD3C433C9;
	Wed, 30 Aug 2023 07:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693380043;
	bh=QQ0quCTLpUTsywVNQHdI0D3Qosir/o/XOI1N8Eq4ZxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U/2MQvmFCsFlRDKWqD8Aprgs2DuOLsQgvv4AhaAGNtDvzD/+9TQ1WYHhRsuy2kMP1
	 3RkwvpgKtUNE5Wlg65kgx2DiXWg7XE9avA4ZAqrSu8uEVnYlDOhSUpP+dl/GjOK5so
	 m0ID85W7RN3W75zl6198lp9TJj8HAp0gwGtBh7XmZaK7Q5wjIWSYMWBzPihqGLUida
	 pHeP3p8Q+Q824kvECId4pVMOOrKDL8uiaHto+5iNZ6ApYBdkrf2p8R3Dysgo8iB08z
	 oGqRnolNsTRc4huwBU55FEiz/sNVcWhyOHn2fy0A2jXayxtR5zJD7sISUXnTavV544
	 ttOxmud+b06aQ==
Date: Wed, 30 Aug 2023 16:20:39 +0900
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
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 6/9] tracing/fprobe: Enable fprobe events with
 CONFIG_DYNAMIC_FTRACE_WITH_ARGS
Message-Id: <20230830162039.95c575460609cebdc34ab0c1@kernel.org>
In-Reply-To: <169280379741.282662.12221517584561036597.stgit@devnote2>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
	<169280379741.282662.12221517584561036597.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 00:16:37 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> +	defined(CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST)
> +
> +static __always_inline
> +struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
> +{
> +	/* See include/linux/ftrace.h, this returns &fregs->regs */
> +	return ftrace_partial_regs(fregs, NULL);
> +}
> +
> +#define perf_fprobe_return_regs(regs) do {} while (0)
> +
> +#else /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS && !CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> +
> +/* Since fprobe handlers can be nested, pt_regs buffer need to be a stack */
> +#define PERF_FPROBE_REGS_MAX	4
> +
> +struct pt_regs_stack {
> +	struct pt_regs regs[PERF_FPROBE_REGS_MAX];
> +	int idx;
> +};
> +
> +static DEFINE_PER_CPU(struct pt_regs_stack, perf_fprobe_regs);
> +
> +static __always_inline
> +struct pt_regs *perf_fprobe_partial_regs(struct ftrace_regs *fregs)
> +{
> +	struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
> +	struct pt_regs *regs;
> +
> +	if (stack->idx < PERF_FPROBE_REGS_MAX) {
> +		regs = stack->regs[stack->idx++];
> +		return ftrace_partial_regs(fregs, regs);
> +	}
> +	return NULL;
> +}
> +
> +static __always_inline void perf_fprobe_return_regs(struct pt_regs *regs)
> +{
> +	struct pt_regs_stack *stack = this_cpu_ptr(&perf_fprobe_regs);
> +
> +	if (WARN_ON_ONCE(regs != stack->regs[stack->idx]))
> +		return;
> +
> +	--stack->idx;
> +}

Ah, I found that the perf_trace_buf_alloc() does the same thing. So

perf_trace_buf_alloc(size, &pt_regs, &rctx);

will give us the pt_regs at that point. Trace event does that so I think
it is OK to do that here.

Thank you,

> +
> +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_TO_FTRACE_REGS_CAST */
> +
>  static int fentry_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> -			    struct pt_regs *regs)
> +			    struct ftrace_regs *fregs)
>  {
>  	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
>  	struct fentry_trace_entry_head *entry;
>  	struct hlist_head *head;
>  	int size, __size, dsize;
> +	struct pt_regs *regs;
>  	int rctx;
>  
> +	regs = perf_fprobe_partial_regs(fregs);
> +	if (!regs)
> +		return -EINVAL;
> +
>  	head = this_cpu_ptr(call->perf_events);
>  	if (hlist_empty(head))
> -		return 0;
> +		goto out;
>  
> -	dsize = __get_data_size(&tf->tp, regs);
> +	dsize = __get_data_size(&tf->tp, fregs);
>  	__size = sizeof(*entry) + tf->tp.size + dsize;
>  	size = ALIGN(__size + sizeof(u32), sizeof(u64));
>  	size -= sizeof(u32);
>  
>  	entry = perf_trace_buf_alloc(size, NULL, &rctx);

Here, we can borrow the pt_regs.

>  	if (!entry)
> -		return 0;
> +		goto out;
>  
>  	entry->ip = entry_ip;
>  	memset(&entry[1], 0, dsize);
> -	store_trace_args(&entry[1], &tf->tp, regs, sizeof(*entry), dsize);
> +	store_trace_args(&entry[1], &tf->tp, fregs, sizeof(*entry), dsize);
>  	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
>  			      head, NULL);
> +out:
> +	perf_fprobe_return_regs(regs);
>  	return 0;
>  }
>  NOKPROBE_SYMBOL(fentry_perf_func);
>  
>  static void
>  fexit_perf_func(struct trace_fprobe *tf, unsigned long entry_ip,
> -		unsigned long ret_ip, struct pt_regs *regs)
> +		unsigned long ret_ip, struct ftrace_regs *fregs)
>  {
>  	struct trace_event_call *call = trace_probe_event_call(&tf->tp);
>  	struct fexit_trace_entry_head *entry;
>  	struct hlist_head *head;
>  	int size, __size, dsize;
> +	struct pt_regs *regs;
>  	int rctx;
>  
> +	regs = perf_fprobe_partial_regs(fregs);
> +	if (!regs)
> +		return;
> +
>  	head = this_cpu_ptr(call->perf_events);
>  	if (hlist_empty(head))
> -		return;
> +		goto out;
>  
> -	dsize = __get_data_size(&tf->tp, regs);
> +	dsize = __get_data_size(&tf->tp, fregs);
>  	__size = sizeof(*entry) + tf->tp.size + dsize;
>  	size = ALIGN(__size + sizeof(u32), sizeof(u64));
>  	size -= sizeof(u32);
>  
>  	entry = perf_trace_buf_alloc(size, NULL, &rctx);

Ditto.

Thanks,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

