Return-Path: <bpf+bounces-22023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F0855187
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 19:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988942972B2
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8F12AAD1;
	Wed, 14 Feb 2024 18:02:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F3126F32;
	Wed, 14 Feb 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933760; cv=none; b=jTZjPzO6WibUNW/vedvMur3p9v11KrVPqX2anYS+wluoIckU+MypWAgLaUnMYYFbzyOsaXbrndSY5BGo1badyD09VNlw6sY13aTCIyCKuOAM7FuIM3E/bfUCwWUStEoNxhn+xFZQXRpQ1v995LNF3j2s48Hcm9ioOKNs+QsQbfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933760; c=relaxed/simple;
	bh=mi9PPom/j9dEgEqpLeXjgQGLWutzp/v4ktOkOCYFZx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hs/Hm3IvXhFVJtEjJpHAwNyUQU5Td6Ej2ja69z1sKsRTqCMTIkbP1oubro2aNkuVflTCq1gCvwh37evGlG5J8EMHq97FX9OBPdcSqPtxIFoQ+5bgVCqn9aVLvNkoiQ7WVlD4ZLZ19lVB+OOnbeZwhYr6UmSypKzkL9EbhRYvJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245FFC433C7;
	Wed, 14 Feb 2024 18:02:38 +0000 (UTC)
Date: Wed, 14 Feb 2024 13:04:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v7 14/36] function_graph: Use a simple LRU for
 fgraph_array index number
Message-ID: <20240214130409.463ae408@gandalf.local.home>
In-Reply-To: <170723220474.502590.7646977373091779892.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723220474.502590.7646977373091779892.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:10:04 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ae42de909845..323a74623543 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -99,10 +99,44 @@ enum {
>  DEFINE_STATIC_KEY_FALSE(kill_ftrace_graph);
>  int ftrace_graph_active;
>  
> -static int fgraph_array_cnt;
> -
>  static struct fgraph_ops *fgraph_array[FGRAPH_ARRAY_SIZE];
>  
> +/* LRU index table for fgraph_array */
> +static int fgraph_lru_table[FGRAPH_ARRAY_SIZE];
> +static int fgraph_lru_next;
> +static int fgraph_lru_last;
> +
> +static void fgraph_lru_init(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
> +		fgraph_lru_table[i] = i;
> +}
> +
> +static int fgraph_lru_release_index(int idx)
> +{
> +	if (idx < 0 || idx >= FGRAPH_ARRAY_SIZE ||
> +	    fgraph_lru_table[fgraph_lru_last] != -1)

Can fgraph_lru_table[fgraph_lru_last] != -1 ever happen? If not, we should
probably add a:

	    WARN_ON_ONCE(fgraph_lru_table[fgraph_lru_last] != -1))

As the size of fgraph_lru_table is the same size as the available indexes,
if we hit this I would think we had a fgraph_lru_relaese_index() without a
fgraph_lru_alloc_index() associated with it.

> +		return -1;
> +
> +	fgraph_lru_table[fgraph_lru_last] = idx;
> +	fgraph_lru_last = (fgraph_lru_last + 1) % FGRAPH_ARRAY_SIZE;
> +	return 0;
> +}
> +
> +static int fgraph_lru_alloc_index(void)
> +{
> +	int idx = fgraph_lru_table[fgraph_lru_next];
> +
> +	if (idx == -1)
> +		return -1;
> +
> +	fgraph_lru_table[fgraph_lru_next] = -1;
> +	fgraph_lru_next = (fgraph_lru_next + 1) % FGRAPH_ARRAY_SIZE;
> +	return idx;
> +}
> +
>  static inline int get_ret_stack_index(struct task_struct *t, int offset)
>  {
>  	return t->ret_stack[offset] & FGRAPH_RET_INDEX_MASK;
> @@ -367,7 +401,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
>  	if (index < 0)
>  		goto out;
>  
> -	for (i = 0; i < fgraph_array_cnt; i++) {
> +	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
>  		struct fgraph_ops *gops = fgraph_array[i];
>  
>  		if (gops == &fgraph_stub)
> @@ -935,21 +969,17 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  		/* The array must always have real data on it */
>  		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
>  			fgraph_array[i] = &fgraph_stub;
> +		fgraph_lru_init();
>  	}
>  
> -	/* Look for an available spot */
> -	for (i = 0; i < FGRAPH_ARRAY_SIZE; i++) {
> -		if (fgraph_array[i] == &fgraph_stub)
> -			break;
> -	}
> -	if (i >= FGRAPH_ARRAY_SIZE) {
> +	i = fgraph_lru_alloc_index();
> +	if (i < 0 ||
> +	    WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub)) {

The above can nicely fit on one column. No need to break it up:

	if (i < 0 || WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub)) {


>  		ret = -EBUSY;
>  		goto out;
>  	}
>  
>  	fgraph_array[i] = gops;
> -	if (i + 1 > fgraph_array_cnt)
> -		fgraph_array_cnt = i + 1;
>  	gops->idx = i;
>  
>  	ftrace_graph_active++;
> @@ -979,25 +1009,22 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  void unregister_ftrace_graph(struct fgraph_ops *gops)
>  {
>  	int command = 0;
> -	int i;
>  
>  	mutex_lock(&ftrace_lock);
>  
>  	if (unlikely(!ftrace_graph_active))
>  		goto out;
>  
> -	if (unlikely(gops->idx < 0 || gops->idx >= fgraph_array_cnt))
> +	if (unlikely(gops->idx < 0 || gops->idx >= FGRAPH_ARRAY_SIZE))
> +		goto out;
> +
> +	if (WARN_ON_ONCE(fgraph_array[gops->idx] != gops))
>  		goto out;
>  
> -	WARN_ON_ONCE(fgraph_array[gops->idx] != gops);
> +	if (fgraph_lru_release_index(gops->idx) < 0)
> +		goto out;

Removing the above WARN_ON_ONCE() is more reason to add it to the release
function.

-- Steve


>  
>  	fgraph_array[gops->idx] = &fgraph_stub;
> -	if (gops->idx + 1 == fgraph_array_cnt) {
> -		i = gops->idx;
> -		while (i >= 0 && fgraph_array[i] == &fgraph_stub)
> -			i--;
> -		fgraph_array_cnt = i + 1;
> -	}
>  
>  	ftrace_graph_active--;
>  


