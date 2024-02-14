Return-Path: <bpf+bounces-22026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7D98552D1
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 19:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998CF290F58
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC15813A27A;
	Wed, 14 Feb 2024 18:58:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B072134738;
	Wed, 14 Feb 2024 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937109; cv=none; b=r2ZTEtir8FUEgQ7iUOqLWGDeVJzTYqIbPjy8AcahrPiJ0qpUPj3hGnAr27QuNFGFvm69ugPLrLCWvIhqvtsVyuOaTCsPAuc1N+SifXtmpJ8ogDz4LBgoW/c0M2dMWjeD3KjS/kbGBFK1e3aOTPb0hFBa4Y3V7z1KYGawJbwawBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937109; c=relaxed/simple;
	bh=NJ0teznko9avctRgXsk9CYac2kHQHkkdyHoR2QZxcIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0jdL/FrbYLgZn25ECWlmfDgpeQwSZ+WRpzPVe7X8ByGyxB0u46EQvNKxQTR+Pvnp72K+59m43lXKsqKNmTyKwksuWS80e/31B9FYqwZBs3V/f7znguRD6+EfVX3J0t9P7jfLuHxIGlMEZ0MYO5anChRw3CB6mJv6cj4TxPiQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478F5C433C7;
	Wed, 14 Feb 2024 18:58:27 +0000 (UTC)
Date: Wed, 14 Feb 2024 13:59:58 -0500
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
Subject: Re: [PATCH v7 19/36] function_graph: Implement
 fgraph_reserve_data() and fgraph_retrieve_data()
Message-ID: <20240214135958.23ed55e1@gandalf.local.home>
In-Reply-To: <170723226123.502590.4924916690354403889.stgit@devnote2>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723226123.502590.4924916690354403889.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 00:11:01 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Ste
> +/**
> + * fgraph_reserve_data - Reserve storage on the task's ret_stack
> + * @idx:	The index of fgraph_array
> + * @size_bytes: The size in bytes to reserve
> + *
> + * Reserves space of up to FGRAPH_MAX_DATA_SIZE bytes on the
> + * task's ret_stack shadow stack, for a given fgraph_ops during
> + * the entryfunc() call. If entryfunc() returns zero, the storage
> + * is discarded. An entryfunc() can only call this once per iteration.
> + * The fgraph_ops retfunc() can retrieve this stored data with
> + * fgraph_retrieve_data().
> + *
> + * Returns: On success, a pointer to the data on the stack.
> + *   Otherwise, NULL if there's not enough space left on the
> + *   ret_stack for the data, or if fgraph_reserve_data() was called
> + *   more than once for a single entryfunc() call.
> + */
> +void *fgraph_reserve_data(int idx, int size_bytes)
> +{
> +	unsigned long val;
> +	void *data;
> +	int curr_ret_stack = current->curr_ret_stack;
> +	int data_size;
> +
> +	if (size_bytes > FGRAPH_MAX_DATA_SIZE)
> +		return NULL;
> +
> +	/* Convert to number of longs + data word */
> +	data_size = DIV_ROUND_UP(size_bytes, sizeof(long));

Hmm, the above is a fast path. I wonder if we should add a patch to make that into:

	if (unlikely(size_bytes & (sizeof(long) - 1)))
		data_size = DIV_ROUND_UP(size_bytes, sizeof(long));
	else
		data_size = size_bytes >> (sizeof(long) == 4 ? 2 : 3);

to keep from doing the division.

-- Steve

> +
> +	val = get_fgraph_entry(current, curr_ret_stack - 1);
> +	data = &current->ret_stack[curr_ret_stack];
> +
> +	curr_ret_stack += data_size + 1;
> +	if (unlikely(curr_ret_stack >= SHADOW_STACK_MAX_INDEX))
> +		return NULL;
> +
> +	val = make_fgraph_data(idx, data_size, __get_index(val) + data_size + 1);
> +
> +	/* Set the last word to be reserved */
> +	current->ret_stack[curr_ret_stack - 1] = val;
> +
> +	/* Make sure interrupts see this */
> +	barrier();
> +	current->curr_ret_stack = curr_ret_stack;
> +	/* Again sync with interrupts, and reset reserve */
> +	current->ret_stack[curr_ret_stack - 1] = val;
> +
> +	return data;
> +}
> +

