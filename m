Return-Path: <bpf+bounces-30621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4536F8CF6F5
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 02:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C2E1C20D67
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 00:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B748621;
	Mon, 27 May 2024 00:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvc25599"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA23BA33;
	Mon, 27 May 2024 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716768596; cv=none; b=oEw12SUXVQTdJsGEX9hw7zywC0yPoAM0fhorF2vtqFKYcCvnEyl6jGxwSWsItpMBLC5Gccya4Lix7qvGn4TCDX6CTzAT/UEZSGuEmI2DFbPmyMXpoAs724tX/98RRteWXeZDfi0zK+6BijOwZ61843ux8Ei5zPc+Gt7hvrmK9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716768596; c=relaxed/simple;
	bh=nl9oLr8Xc4c24Mq1utQNIikN4+8tQIWkxiS58d/4E84=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rcgfo+4BKh3aZE+z7Nig4nQtRP1mqhvT3UeSzi0GI/yCuByezPNubHFm7EH6wSrB5u9f5F0tQM1qiVeXIL9Q9mf0u6hGqo7kW5fOiKzjS5r2uW6qS4Ii0pobzbuM/c1GbsSlJgC+tN7W7k0nccYD8wTp25ObSCw1Yqv3i3BbAJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvc25599; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8193AC2BD10;
	Mon, 27 May 2024 00:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716768596;
	bh=nl9oLr8Xc4c24Mq1utQNIikN4+8tQIWkxiS58d/4E84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qvc25599Y15SqQsaZIBOMO66Htbhp9Yu10mOr0OOQLB3WSuRTRG0f0lsUDGFyNfnK
	 D4uO923onj/cs+zUTI26yvNrkgL7K0Vacsup9WL4N0cwkIuXxZRL9Mt1LEOTCq0FhQ
	 gaZBSl6bV8wULBhFfWA/zbTaGlKJ7fVMLfvnb474juMjUW6bkkKso53g7gDkxZ4giM
	 ygvNee0gHhiDXMdiAPOoQg9eZG4vvquZX37QYJmgFy7p17MdPktpA+jwiC7TGjqZIG
	 uKkhMopQCAk8APld1fVF+WzHRSTlbGy5TvG+bPcZBj2GXZ9AIdrusO+qfyzJmV/Y2p
	 bzCa4/7nyq9HA==
Date: Mon, 27 May 2024 09:09:49 +0900
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
Subject: Re: [PATCH 20/20] function_graph: Use bitmask to loop on fgraph
 entry
Message-Id: <20240527090949.70151ecb2e7d98d4f284c2c8@kernel.org>
In-Reply-To: <20240525023744.390040466@goodmis.org>
References: <20240525023652.903909489@goodmis.org>
	<20240525023744.390040466@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 May 2024 22:37:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of looping through all the elements of fgraph_array[] to see if
> there's an gops attached to one and then calling its gops->func(). Create
> a fgraph_array_bitmask that sets bits when an index in the array is
> reserved (via the simple lru algorithm). Then only the bits set in this
> bitmask needs to be looked at where only elements in the array that have
> ops registered need to be looked at.
> 
> Note, we do not care about races. If a bit is set before the gops is
> assigned, it only wastes time looking at the element and ignoring it (as
> it did before this bitmask is added).

This is OK because anyway we check gops == &fgraph_stub.
By the way, shouldn't we also make "if (gops == &fgraph_stub)"
check unlikely()?

This change looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/fgraph.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 5e8e13ffcfb6..1aae521e5997 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -173,6 +173,7 @@ DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
>  int ftrace_graph_active;
>  
>  static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
> +static unsigned long fgraph_array_bitmask;
>  
>  /* LRU index table for fgraph_array */
>  static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
> @@ -197,6 +198,8 @@ static int fgraph_lru_release_index(int idx)
>  
>  	fgraph_lru_table[fgraph_lru_last] = idx;
>  	fgraph_lru_last = (fgraph_lru_last + 1) % FGRAPH_ARRAY_SIZE;
> +
> +	clear_bit(idx, &fgraph_array_bitmask);
>  	return 0;
>  }
>  
> @@ -211,6 +214,8 @@ static int fgraph_lru_alloc_index(void)
>  
>  	fgraph_lru_table[fgraph_lru_next] = -1;
>  	fgraph_lru_next = (fgraph_lru_next + 1) % FGRAPH_ARRAY_SIZE;
> +
> +	set_bit(idx, &fgraph_array_bitmask);
>  	return idx;
>  }
>  
> @@ -632,7 +637,8 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  	if (offset < 0)
>  		goto out;
>  
> -	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
> +	for_each_set_bit(i, &fgraph_array_bitmask,
> +			 sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
>  		struct fgraph_ops *gops = fgraph_array[i];
>  		int save_curr_ret_stack;
>  
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

