Return-Path: <bpf+bounces-31176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E08D7A1A
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 04:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EF4B20AD2
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 02:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEACE63D5;
	Mon,  3 Jun 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaZ1Qs4j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD662566;
	Mon,  3 Jun 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382250; cv=none; b=jkdrdGzwvh1MHNniJvSxBoR9poIoGTgfTiOGqRKUyEypfnoH+fnX8X6Kk6auxbHAflg1/Y01+lHzIurxDcBZsdwGjRr8nHYcOCtBaSaOkgplljUrVP2bc89xCtIsk2NnUX0JGqnTjfsBdSFOH6irXc2UsPQZAemvVZvkcLOHasc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382250; c=relaxed/simple;
	bh=NIzaEEdmhkDh0uGhxZPp5iX+ogXWqvyKuKECBW+n7O0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CK+hT1Cb94eWXs4efN21wlwwpVmSPckhAlnF8TlG9T9C6PdxIGvCeLEhgure19PizwO14eYlnHch0wkOrBcUP48pH/T3+lmxjqmdLexfbyck6YUFIpqj5fEkoun0QiCyAbR9DJm4X66BrVk9tx9Pa+tjtlOv7jXMqoRiIZr97fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaZ1Qs4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A3AC2BBFC;
	Mon,  3 Jun 2024 02:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717382250;
	bh=NIzaEEdmhkDh0uGhxZPp5iX+ogXWqvyKuKECBW+n7O0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JaZ1Qs4jkK7eicqpf+ZVdQ1SaHd5SmbcssQBSbE4iOc0WoSt0WLKrecFRW2wDVgdS
	 SNn5ZWMPBxaXvE5qiKjEprt/dKFJYLMR7mFPa7RJpabL7t983AzQ0IYGrnVqO1TwyV
	 gsgrapyOQ2kNVE/1ru+zjW4sj2Uiw2/anoy+/y3Ib9b8MHRL1PQND97NRXEa+pkf18
	 t6KQR+IPkfV79/mqCMTxJuvbk6rIvtdSNsaL+p6+3LSLZ3PUK7DWccu6RpB12Fv5Nb
	 QLxjZIgFnukVllECh4huW3R5Lu3Os2WXvGyYn/m6TRRQQaLFypp6Jov9MS1ZOAFRew
	 9lcST+XFzf5NQ==
Date: Mon, 3 Jun 2024 11:37:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v2 11/27] ftrace: Allow subops filtering to be modified
Message-Id: <20240603113723.b192c8c346e0ed55cb94b61a@kernel.org>
In-Reply-To: <20240602033832.870736657@goodmis.org>
References: <20240602033744.563858532@goodmis.org>
	<20240602033832.870736657@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 01 Jun 2024 23:37:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

[...]
>  
> +static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
> +					      struct ftrace_hash **orig_subhash,
> +					      struct ftrace_hash *hash,
> +					      int enable)
> +{
> +	struct ftrace_ops *ops = subops->managed;
> +	struct ftrace_hash **orig_hash;
> +	struct ftrace_hash *save_hash;
> +	struct ftrace_hash *new_hash;
> +	int ret;
> +
> +	/* Manager ops can not be subops (yet) */
> +	if (WARN_ON_ONCE(!ops || ops->flags & FTRACE_OPS_FL_SUBOP))
> +		return -EINVAL;

This does return if ops->flags & FTRACE_OPS_FL_SUBOP, but --> (1)

> +
> +	/* Move the new hash over to the subops hash */
> +	save_hash = *orig_subhash;
> +	*orig_subhash = __ftrace_hash_move(hash);
> +	if (!*orig_subhash) {
> +		*orig_subhash = save_hash;
> +		return -ENOMEM;
> +	}
> +
> +	/* Create a new_hash to hold the ops new functions */
> +	if (enable) {
> +		orig_hash = &ops->func_hash->filter_hash;
> +		new_hash = append_hashes(ops);
> +	} else {
> +		orig_hash = &ops->func_hash->notrace_hash;
> +		new_hash = intersect_hashes(ops);
> +	}
> +
> +	/* Move the hash over to the new hash */
> +	ret = ftrace_hash_move_and_update_ops(ops, orig_hash, new_hash, enable);

This also a bit wired to me. maybe we need simple version like

`__ftrace_hash_move_and_update_ops()`

And call it from ftrace_hash_move_and_update_ops() and here?

> +
> +	free_ftrace_hash(new_hash);
> +
> +	if (ret) {
> +		/* Put back the original hash */
> +		free_ftrace_hash_rcu(*orig_subhash);
> +		*orig_subhash = save_hash;
> +	} else {
> +		free_ftrace_hash_rcu(save_hash);
> +	}
> +	return ret;
> +}
> +
> +
>  static u64		ftrace_update_time;
>  unsigned long		ftrace_update_tot_cnt;
>  unsigned long		ftrace_number_of_pages;
> @@ -4770,8 +4823,33 @@ static int ftrace_hash_move_and_update_ops(struct ftrace_ops *ops,
>  {
>  	struct ftrace_ops_hash old_hash_ops;
>  	struct ftrace_hash *old_hash;
> +	struct ftrace_ops *op;
>  	int ret;
>  
> +	if (ops->flags & FTRACE_OPS_FL_SUBOP)
> +		return ftrace_hash_move_and_update_subops(ops, orig_hash, hash, enable);

(1) This calls ftrace_hash_move_and_update_subops() if ops->flags & FTRACE_OPS_FL_SUBOP ?

Thank you,

> +
> +	/*
> +	 * If this ops is not enabled, it could be sharing its filters
> +	 * with a subop. If that's the case, update the subop instead of
> +	 * this ops. Shared filters are only allowed to have one ops set
> +	 * at a time, and if we update the ops that is not enabled,
> +	 * it will not affect subops that share it.
> +	 */
> +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED)) {
> +		/* Check if any other manager subops maps to this hash */
> +		do_for_each_ftrace_op(op, ftrace_ops_list) {
> +			struct ftrace_ops *subops;
> +
> +			list_for_each_entry(subops, &op->subop_list, list) {
> +				if ((subops->flags & FTRACE_OPS_FL_ENABLED) &&
> +				     subops->func_hash == ops->func_hash) {
> +					return ftrace_hash_move_and_update_subops(subops, orig_hash, hash, enable);
> +				}
> +			}
> +		} while_for_each_ftrace_op(op);
> +	}
> +
>  	old_hash = *orig_hash;
>  	old_hash_ops.filter_hash = ops->func_hash->filter_hash;
>  	old_hash_ops.notrace_hash = ops->func_hash->notrace_hash;
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

