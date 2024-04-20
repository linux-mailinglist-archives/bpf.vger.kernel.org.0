Return-Path: <bpf+bounces-27275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 857B48AB949
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 05:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28481F2152F
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 03:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8BD520;
	Sat, 20 Apr 2024 03:53:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF92563;
	Sat, 20 Apr 2024 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585185; cv=none; b=R+ekvD/I+MT5TXwte/D4k2dJ38Zthbya2j6ch3lyZP9SNsJbZX3BiyOgsiZ8B/4m+vIdkfJTGzZy672Zt5oXZ391P5OBRXNzYAg1L3/8PYoqWJ9ZiAvvPB0We7sEMLyhJAZyUOPaV5sfkwplf9LWa/7AqhEZhkm1BYqfoeEfQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585185; c=relaxed/simple;
	bh=6tHXInfbVm0cVL3xkeZnDT/qgKwE8YrS1uVdADz7660=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbtxZ4q063HKtQqy4TOCIWkkLJscL08At4CBL6iH9kAKdf80pDzznnPGID6ORcGahMRfBeTnhT1T/EjYhWcUelt1XJEGYvfjY3cvxdWzCP4K3aDsEIBs259eUmAO4yqaODlCkZjXGS2nbr5QYpFTZCP25Rl2YTf7+n4kk35lxaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06856C072AA;
	Sat, 20 Apr 2024 03:53:02 +0000 (UTC)
Date: Fri, 19 Apr 2024 23:52:58 -0400
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
Subject: Re: [PATCH v9 07/36] function_graph: Allow multiple users to attach
 to function graph
Message-ID: <20240419235258.64cada90@rorschach.local.home>
In-Reply-To: <171318542015.254850.16655743605260166696.stgit@devnote2>
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
	<171318542015.254850.16655743605260166696.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 21:50:20 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -27,23 +28,157 @@
>  
>  #define FGRAPH_RET_SIZE sizeof(struct ftrace_ret_stack)
>  #define FGRAPH_RET_INDEX DIV_ROUND_UP(FGRAPH_RET_SIZE, sizeof(long))
> +
> +/*
> + * On entry to a function (via function_graph_enter()), a new ftrace_ret_stack
> + * is allocated on the task's ret_stack with indexes entry, then each
> + * fgraph_ops on the fgraph_array[]'s entryfunc is called and if that returns
> + * non-zero, the index into the fgraph_array[] for that fgraph_ops is recorded
> + * on the indexes entry as a bit flag.
> + * As the associated ftrace_ret_stack saved for those fgraph_ops needs to
> + * be found, the index to it is also added to the ret_stack along with the
> + * index of the fgraph_array[] to each fgraph_ops that needs their retfunc
> + * called.
> + *
> + * The top of the ret_stack (when not empty) will always have a reference
> + * to the last ftrace_ret_stack saved. All references to the
> + * ftrace_ret_stack has the format of:
> + *
> + * bits:  0 -  9	offset in words from the previous ftrace_ret_stack
> + *			(bitmap type should have FGRAPH_RET_INDEX always)
> + * bits: 10 - 11	Type of storage
> + *			  0 - reserved
> + *			  1 - bitmap of fgraph_array index
> + *
> + * For bitmap of fgraph_array index
> + *  bits: 12 - 27	The bitmap of fgraph_ops fgraph_array index

I really hate the terminology I came up with here, and would love to
get better terminology for describing what is going on. I looked it
over but I'm constantly getting confused. And I wrote this code!

Perhaps we should use:

 @frame : The data that represents a single function call. When a
          function is traced, all the data used for all the callbacks
          attached to it, is in a single frame. This would replace the
          FGRAPH_RET_SIZE as FGRAPH_FRAME_SIZE.

 @offset : This is the word size position on the stack. It would
           replace INDEX, as I think "index" is being used for more
           than one thing. Perhaps it should be "offset" when dealing
           with where it is on the shadow stack, and "pos" when dealing
           with which callback ops is being referenced.


> + *
> + * That is, at the end of function_graph_enter, if the first and forth
> + * fgraph_ops on the fgraph_array[] (index 0 and 3) needs their retfunc called
> + * on the return of the function being traced, this is what will be on the
> + * task's shadow ret_stack: (the stack grows upward)
> + *
> + * |                                            | <- task->curr_ret_stack
> + * +--------------------------------------------+
> + * | bitmap_type(bitmap:(BIT(3)|BIT(0)),        |
> + * |             offset:FGRAPH_RET_INDEX)       | <- the offset is from here
> + * +--------------------------------------------+
> + * | struct ftrace_ret_stack                    |
> + * |   (stores the saved ret pointer)           | <- the offset points here
> + * +--------------------------------------------+
> + * |                 (X) | (N)                  | ( N words away from
> + * |                                            |   previous ret_stack)
> + *
> + * If a backtrace is required, and the real return pointer needs to be
> + * fetched, then it looks at the task's curr_ret_stack index, if it
> + * is greater than zero (reserved, or right before poped), it would mask
> + * the value by FGRAPH_RET_INDEX_MASK to get the offset index of the
> + * ftrace_ret_stack structure stored on the shadow stack.
> + */
> +
> +#define FGRAPH_RET_INDEX_SIZE	10

Replace SIZE with BITS.

> +#define FGRAPH_RET_INDEX_MASK	GENMASK(FGRAPH_RET_INDEX_SIZE - 1, 0)

  #define FGRAPH_FRAME_SIZE_BITS	10
  #define FGRAPH_FRAME_SIZE_MASK	GENMASK(FGRAPH_FRAME_SIZE_BITS - 1, 0)


> +
> +#define FGRAPH_TYPE_SIZE	2
> +#define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_SIZE - 1, 0)

  #define FGRAPH_TYPE_BITS	2
  #define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_BITS - 1, 0)


> +#define FGRAPH_TYPE_SHIFT	FGRAPH_RET_INDEX_SIZE
> +
> +enum {
> +	FGRAPH_TYPE_RESERVED	= 0,
> +	FGRAPH_TYPE_BITMAP	= 1,
> +};
> +
> +#define FGRAPH_INDEX_SIZE	16

replace "INDEX" with "OPS" as it will be the indexes of ops in the
array.

  #define FGRAPH_OPS_BITS	16
  #define FGRAPH_OPS_MASK	GENMASK(FGRAPH_OPS_BITS - 1, 0)

> +#define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_SIZE - 1, 0)
> +#define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_SIZE)
> +
> +/* Currently the max stack index can't be more than register callers */
> +#define FGRAPH_MAX_INDEX	(FGRAPH_INDEX_SIZE + FGRAPH_RET_INDEX)

FGRAPH_MAX_INDEX isn't even used. Let's delete it.

> +
> +#define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_SIZE

  #define FGRAPH_ARRAY_SIZE	FGRAPH_INDEX_BITS

> +
>  #define SHADOW_STACK_SIZE (PAGE_SIZE)
>  #define SHADOW_STACK_INDEX (SHADOW_STACK_SIZE / sizeof(long))
>  /* Leave on a buffer at the end */
> -#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - FGRAPH_RET_INDEX)
> +#define SHADOW_STACK_MAX_INDEX (SHADOW_STACK_INDEX - (FGRAPH_RET_INDEX + 1))

We probably should rename this is previous patches as well.

Unfortunately, it's getting close to the time for me to pick up my wife
from the airport to start our vacation. But I think we should rename a
lot of these variables to make things more consistent.

I'll try to look more at the previous patches as well to make my
comments there, when I get some time. Maybe even later today.

-- Steve


