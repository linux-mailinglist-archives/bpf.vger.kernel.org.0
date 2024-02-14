Return-Path: <bpf+bounces-22040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA78855770
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 00:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B67128D6F4
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95F13F003;
	Wed, 14 Feb 2024 23:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROb/g6o4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2D13DB90;
	Wed, 14 Feb 2024 23:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954358; cv=none; b=ijam2aRpr+124yIW6Usu1/ONrs88xIlM2qTz0Arcj4sbLk7ZpKNDD1r6RAMDV4Rp5ykNaDiOOqD8sgMRuu7fKO0yKKtZScimQd/vWwhDs/FLj7bJmrqTviWlFOQxcMsgfLC47MInUG5pxo721F+aLyfM6pplv/CM1fo/PQv6XMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954358; c=relaxed/simple;
	bh=hn5Jto1lbD3UHNlb8zUDUPu4Gm63tv903DcDXQ0+ApI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=agpvCoibGdYldhjn0vRE4r+x706HBjRHiGCzvN0udnMcu9c0SCJYpW7AmVMAaxknfQl+KjFE3kOqwXrPp9wL/Xn0310ANYBitPvRvJI/+WJd4D6n591+7d8XNMcBuo3WZwaoqIcN5tlACFQRxXFHUeIC8/Hvp7rRYyzsJ4/I/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROb/g6o4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81BDC433F1;
	Wed, 14 Feb 2024 23:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707954358;
	bh=hn5Jto1lbD3UHNlb8zUDUPu4Gm63tv903DcDXQ0+ApI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ROb/g6o4xeezKeZLKlXyLy3rPKgfQLts9chQg4z2aKEOn6iAzcTEYaZsmNGajI9NN
	 G3xX8reIVUmp0jCg3fdzBXzBZW1gcW2IBX0xwrA7//yVVm609XLvRPY0SZJOKGsyUU
	 dOZjWr6jSUoTfskYgTsK6Kh0PolaH5QBU7IpscamflkQxirQKnZSL4VrwIgFA6PEmS
	 A9Zndmm5qaijY8dyxVZy1UbZeO5U/QomSplCyr5mgwn6XhqvAtdGxuxYIDUNNyeO0q
	 8E3vdGLhm9x3A0jS7D3OPDaAgpZvq9QFiaRvNQ5o9bSmcwZoLMRwZYRlzWsljy+NfY
	 GkzGElWMW+CbQ==
Date: Thu, 15 Feb 2024 08:45:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20240215084552.b72d6d22ce1b93bb8e04b70a@kernel.org>
In-Reply-To: <20240214135958.23ed55e1@gandalf.local.home>
References: <170723204881.502590.11906735097521170661.stgit@devnote2>
	<170723226123.502590.4924916690354403889.stgit@devnote2>
	<20240214135958.23ed55e1@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 13:59:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  7 Feb 2024 00:11:01 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Ste
> > +/**
> > + * fgraph_reserve_data - Reserve storage on the task's ret_stack
> > + * @idx:	The index of fgraph_array
> > + * @size_bytes: The size in bytes to reserve
> > + *
> > + * Reserves space of up to FGRAPH_MAX_DATA_SIZE bytes on the
> > + * task's ret_stack shadow stack, for a given fgraph_ops during
> > + * the entryfunc() call. If entryfunc() returns zero, the storage
> > + * is discarded. An entryfunc() can only call this once per iteration.
> > + * The fgraph_ops retfunc() can retrieve this stored data with
> > + * fgraph_retrieve_data().
> > + *
> > + * Returns: On success, a pointer to the data on the stack.
> > + *   Otherwise, NULL if there's not enough space left on the
> > + *   ret_stack for the data, or if fgraph_reserve_data() was called
> > + *   more than once for a single entryfunc() call.
> > + */
> > +void *fgraph_reserve_data(int idx, int size_bytes)
> > +{
> > +	unsigned long val;
> > +	void *data;
> > +	int curr_ret_stack = current->curr_ret_stack;
> > +	int data_size;
> > +
> > +	if (size_bytes > FGRAPH_MAX_DATA_SIZE)
> > +		return NULL;
> > +
> > +	/* Convert to number of longs + data word */
> > +	data_size = DIV_ROUND_UP(size_bytes, sizeof(long));
> 
> Hmm, the above is a fast path. I wonder if we should add a patch to make that into:
> 
> 	if (unlikely(size_bytes & (sizeof(long) - 1)))
> 		data_size = DIV_ROUND_UP(size_bytes, sizeof(long));
> 	else
> 		data_size = size_bytes >> (sizeof(long) == 4 ? 2 : 3);
> 
> to keep from doing the division.

OK, I thought DIV_ROUND_UP was not much cost. Since sizeof(long) is
fixed 4 or 8, so 

data_size = (size_bytes + sizeof(long) - 1) >> BITS_PER_LONG;

will this work?

Thanks,

> 
> -- Steve
> 
> > +
> > +	val = get_fgraph_entry(current, curr_ret_stack - 1);
> > +	data = &current->ret_stack[curr_ret_stack];
> > +
> > +	curr_ret_stack += data_size + 1;
> > +	if (unlikely(curr_ret_stack >= SHADOW_STACK_MAX_INDEX))
> > +		return NULL;
> > +
> > +	val = make_fgraph_data(idx, data_size, __get_index(val) + data_size + 1);
> > +
> > +	/* Set the last word to be reserved */
> > +	current->ret_stack[curr_ret_stack - 1] = val;
> > +
> > +	/* Make sure interrupts see this */
> > +	barrier();
> > +	current->curr_ret_stack = curr_ret_stack;
> > +	/* Again sync with interrupts, and reset reserve */
> > +	current->ret_stack[curr_ret_stack - 1] = val;
> > +
> > +	return data;
> > +}
> > +


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

