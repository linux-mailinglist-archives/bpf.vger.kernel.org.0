Return-Path: <bpf+bounces-38091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F0695F81D
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 19:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED09282B4D
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 17:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ABA179958;
	Mon, 26 Aug 2024 17:30:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87D10E9;
	Mon, 26 Aug 2024 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693454; cv=none; b=TNqpukuZzbyPtg9+1BFhIr0SDtQIdrvET/CutLpxNIT8MnospdMvmk14gQcR7XAgceFoXQ3dt7GzDHNOOtEM0jQfz9PnNWKVsfthfq21VU8pA/AuLh/mLOL9rabXvi+0BetmG9L1SOzKI39gZ3QjOg6izPRindKuH4qRCxt7Gqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693454; c=relaxed/simple;
	bh=hvjbSglVG52utS/TNtvwDZVFsSLINCOLzNEh+HdAtW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2EhiC23zNoHzMMT3Q2jUShCSBIvpB4jlroJfl/UtqJ1KS9S7Xm+3alid/KHo2H5qsmWQVToPmw0WhkPj/N4zCT0KuZ8TTfysFCxNrn/syROjVdyZyNZqsHqDOTeo/zBNaZTHdF2YdMFwfVM727M50JAfh0pcZ9DHU9WfXIzX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8217DC8B7BF;
	Mon, 26 Aug 2024 17:30:53 +0000 (UTC)
Date: Mon, 26 Aug 2024 13:31:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Viktor Malik <vmalik@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Matt Wu <wuqiang.matt@bytedance.com>,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] objpool: fix choosing allocation for percpu slots
Message-ID: <20240826133133.5affc7e6@gandalf.local.home>
In-Reply-To: <20240826060718.267261-1-vmalik@redhat.com>
References: <20240826060718.267261-1-vmalik@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 08:07:18 +0200
Viktor Malik <vmalik@redhat.com> wrote:

> objpool intends to use vmalloc for default (non-atomic) allocations of
> percpu slots and objects. However, the condition checking if GFP flags
> are equal to GFP_ATOMIC is wrong b/c GFP_ATOMIC is a combination of bits
> (__GFP_HIGH|__GFP_KSWAPD_RECLAIM) and so `pool->gfp & GFP_ATOMIC` will
> be true if either bit is set. Since GFP_ATOMIC and GFP_KERNEL share the
> ___GFP_KSWAPD_RECLAIM bit, kmalloc will be used in cases when GFP_KERNEL
> is specified, i.e. in all current usages of objpool.
> 
> This may lead to unexpected OOM errors since kmalloc cannot allocate
> large amounts of memory.
> 
> For instance, objpool is used by fprobe rethook which in turn is used by
> BPF kretprobe.multi and kprobe.session probe types. Trying to attach
> these to all kernel functions with libbpf using
> 
>     SEC("kprobe.session/*")
>     int kprobe(struct pt_regs *ctx)
>     {
>         [...]
>     }
> 
> fails on objpool slot allocation with ENOMEM.
> 
> Fix the condition to truly use vmalloc by default.
> 
> Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  lib/objpool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/objpool.c b/lib/objpool.c
> index 234f9d0bd081..fd108fe0d095 100644
> --- a/lib/objpool.c
> +++ b/lib/objpool.c
> @@ -76,7 +76,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
>  		 * mimimal size of vmalloc is one page since vmalloc would
>  		 * always align the requested size to page size
>  		 */
> -		if (pool->gfp & GFP_ATOMIC)
> +		if ((pool->gfp & GFP_ATOMIC) == GFP_ATOMIC)
>  			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
>  		else
>  			slot = __vmalloc_node(size, sizeof(void *), pool->gfp,


