Return-Path: <bpf+bounces-30552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8D98CED6A
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 03:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A9D1C211EA
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 01:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4D315C9;
	Sat, 25 May 2024 01:31:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B210F2;
	Sat, 25 May 2024 01:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716600684; cv=none; b=u/CVhub6xpZ8HuHP7GFRndxFyl0Zhqx7gnKOQkWAQKFbMI/8wZG4mpWlFh4YTXirba4iVId6HGeXBcZJDg1vjC2yVYt/o6GV1+b1S/jAzbprEqxFF1New5ZKqeTsV4fcMIToY59ey7tLk7vb2KYe7zv+yeLWM6VXxwfmsJJvA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716600684; c=relaxed/simple;
	bh=z7oKLt6Rw3xg2+xTJUcSeAWH56aHvfdrjINRXOlJgLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uegw1GxFCb8+HcKsO+PSkH1KvI/tMHjd7euGY0oDTpXoMGXNXMBhgkCosEg83lzLfCAfjuFXxhIIEMs3GFg13IpI8BxEOeHAJMNMS2hYfMXgzMxgS9aey5UxFD3crPSm/OwHgM6TixYVDabRKRoR/boF6aC4spLDCCL6cjTq8nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AC3C2BBFC;
	Sat, 25 May 2024 01:31:21 +0000 (UTC)
Date: Fri, 24 May 2024 21:32:08 -0400
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
Subject: Re: [PATCH v10 07/36] function_graph: Allow multiple users to
 attach to function graph
Message-ID: <20240524213208.36f274c8@gandalf.local.home>
In-Reply-To: <171509096221.162236.8806372072523195752.stgit@devnote2>
References: <171509088006.162236.7227326999861366050.stgit@devnote2>
	<171509096221.162236.8806372072523195752.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 23:09:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -109,6 +244,21 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  	if (!current->ret_stack)
>  		return -EBUSY;
>  
> +	/*
> +	 * At first, check whether the previous fgraph callback is pushed by
> +	 * the fgraph on the same function entry.
> +	 * But if @func is the self tail-call function, we also need to ensure
> +	 * the ret_stack is not for the previous call by checking whether the
> +	 * bit of @fgraph_idx is set or not.
> +	 */
> +	ret_stack = get_ret_stack(current, current->curr_ret_stack, &offset);
> +	if (ret_stack && ret_stack->func == func &&
> +	    get_fgraph_type(current, offset + FGRAPH_FRAME_OFFSET) == FGRAPH_TYPE_BITMAP &&
> +	    !is_fgraph_index_set(current, offset + FGRAPH_FRAME_OFFSET, fgraph_idx))
> +		return offset + FGRAPH_FRAME_OFFSET;
> +
> +	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
> +
>  	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));

I'm trying to figure out what the above is trying to do. This gets called
once in function_graph_enter() (or function_graph_enter_ops()). What
exactly are you trying to catch here?

Is it from this email:

  https://lore.kernel.org/all/20231110105154.df937bf9f200a0c16806c522@kernel.org/

As that's the last version before you added the above code.

But you also noticed it may not be needed, but triggered a crash without it
in v3:

  https://lore.kernel.org/all/20231205234511.3839128259dfec153ea7da81@kernel.org/

I removed this code in my version and it runs just fine. Perhaps there was
another bug that this was hiding that you fixed in later versions?

-- Steve

