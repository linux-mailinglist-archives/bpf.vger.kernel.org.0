Return-Path: <bpf+bounces-14740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F33D7E79B7
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 08:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1233B1F20D3A
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4D1FC4;
	Fri, 10 Nov 2023 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rbi08Qqr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3115C8;
	Fri, 10 Nov 2023 07:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25074C433C8;
	Fri, 10 Nov 2023 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699600666;
	bh=mZiJ9Td++XlK5uAAB4qKyf/MCPDMIrq0nMmKby/gJag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rbi08Qqr2TYOjwc5dSkoT6yW5Ku4Ne2FfD8IwpZR93OJiz1jWrYIox5Cnoar3kj+3
	 lBiBZ8xC+m9BRFv1fIVcIvexFmpoBvH4yOZwMAuljOUP9cDO02npfNw/kXccfrP2Kl
	 T22qfAchu/gD2tJkVCKHw8pKBPDrCdGQnVlcPI0DAPCp4Mj08pEsvTCOV8Vchc4xzO
	 1hMtY62rTCv7SyL/F6seB8h3SWFqS5c+g5UqX29wbhVGUF/en0VQow0gD9XtvJxrwC
	 S1mpeztcpbAp608Sh5ZZyrGOPbAr0i0DuI5zUBp8dr6PXVJc2QjG6ny86Lt9HSc5nL
	 FSSqO3pckiE2Q==
Date: Fri, 10 Nov 2023 16:17:39 +0900
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
Subject: Re: [RFC PATCH v2 26/31] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20231110161739.f0ff9c50f20ebcfb57be6459@kernel.org>
In-Reply-To: <169945376173.55307.5892275268096520409.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
	<169945376173.55307.5892275268096520409.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Wed,  8 Nov 2023 23:29:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> + */
> +static inline int __fprobe_handler(unsigned long ip, unsigned long parent_ip,
> +				   struct fprobe *fp, struct ftrace_regs *fregs,
> +				   void *data)
> +{
> +	int ret = 0;
>  
> +	if (fp->entry_handler) {
> +		if (fp->exit_handler && fp->entry_data_size)
> +			data += sizeof(unsigned long);
> +		else
> +			data = NULL;
> +		ret = fp->entry_handler(fp, ip, parent_ip, fregs, data);
> +	}
> +
> +	return ret;
> +}
> +
> +static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
> +					  struct fprobe *fp, struct ftrace_regs *fregs,
> +					  void *data)
> +{
> +	int ret;
>  	/*
>  	 * This user handler is shared with other kprobes and is not expected to be
>  	 * called recursively. So if any other kprobe handler is running, this will
> @@ -108,45 +210,173 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
>  	 */
>  	if (unlikely(kprobe_running())) {
>  		fp->nmissed++;
> -		goto recursion_unlock;
> +		return 0;
>  	}
>  
>  	kprobe_busy_begin();
> -	__fprobe_handler(ip, parent_ip, ops, fregs);
> +	ret = __fprobe_handler(ip, parent_ip, fp, fregs, data);
>  	kprobe_busy_end();
> -
> -recursion_unlock:
> -	ftrace_test_recursion_unlock(bit);
> +	return ret;
>  }
>  
> -static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> -				unsigned long ret_ip, struct pt_regs *regs)
> +static int fprobe_entry(unsigned long func, unsigned long ret_ip,
> +			struct ftrace_regs *fregs, struct fgraph_ops *gops)
>  {
> -	struct fprobe *fp = (struct fprobe *)data;
> -	struct fprobe_rethook_node *fpr;
> -	struct ftrace_regs *fregs = (struct ftrace_regs *)regs;
> -	int bit;
> +	struct fprobe_hlist_node *node, *first;
> +	unsigned long header;
> +	void *fgraph_data = NULL;
> +	struct fprobe *fp;
> +	int size, used, ret;
>  
> -	if (!fp || fprobe_disabled(fp))
> -		return;
> +	if (WARN_ON_ONCE(!fregs))
> +		return 0;
>  
> -	fpr = container_of(rh, struct fprobe_rethook_node, node);
> +	first = node = find_first_fprobe_node(func);
> +	if (unlikely(!first))
> +		return 0;
> +
> +	size = 0;
> +	hlist_for_each_entry_from_rcu(node, hlist) {
> +		if (node->addr != func)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		/*
> +		 * Since fprobe can be enabled until the next loop, we ignore the
> +		 * disabled flag in this loop.
> +		 */
> +		if (fp && fp->exit_handler)
> +			size += FPROBE_HEADER_SIZE + fp->entry_data_size;
> +	}
> +	node = first;
> +	/* size can be 0 because fp only has entry_handler. */
> +	if (size) {
> +		fgraph_data = fgraph_reserve_data(size);
> +		if (unlikely(!fgraph_data)) {
> +			hlist_for_each_entry_from_rcu(node, hlist) {
> +				if (node->addr != func)
> +					break;
> +				fp = READ_ONCE(node->fp);
> +				if (fp && !fprobe_disabled(fp))
> +					fp->nmissed++;
> +			}
> +			return 0;
> +		}
> +	}
>  
>  	/*
> -	 * we need to assure no calls to traceable functions in-between the
> -	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
> +	 * TODO: recursion detection has been done in the fgraph. Thus we need
> +	 * to add a callback to increment missed counter.
>  	 */
> -	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
> -	if (bit < 0) {
> -		fp->nmissed++;
> +	used = 0;
> +	hlist_for_each_entry_from_rcu(node, hlist) {
> +		if (node->addr != func)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		if (!fp || fprobe_disabled(fp))
> +			continue;
> +
> +		if (fprobe_shared_with_kprobes(fp))
> +			ret = __fprobe_kprobe_handler(func, ret_ip,
> +					fp, fregs, fgraph_data + used);
> +		else
> +			ret = __fprobe_handler(func, ret_ip, fp,
> +					fregs, fgraph_data + used);


Since the fgraph callback is under rcu-locked but not preempt-disabled,
fprobe unittest fails. I need to add preempt_disable_notrace() and
preempt_enable_notrace() around this. Note that kprobe_busy_begin()/end()
also access to per-cpu variable, so it requires to disable preemption.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

