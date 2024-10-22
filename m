Return-Path: <bpf+bounces-42745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B08A9A9835
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 07:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76ECB21D56
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 05:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA2A84A36;
	Tue, 22 Oct 2024 05:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCQhNSZ2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71E1DDF5;
	Tue, 22 Oct 2024 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574272; cv=none; b=u6Y7r00649oZbrUZsJjUEWLhbWTmxG3l4i364QbE1YF9DC/oRFlrs7oOiHsaf6y6PgSL9mFancSkI8jp3FJ3dmIXlNGK8kYOKUPtVTeB/SVpHchi/caAYOZCE6ZSzNswAVt1u39Q9hrs8kX0RaYh9GZFS/Hmb71rJBv1tUgLtKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574272; c=relaxed/simple;
	bh=WJVe5y2/2RttbuSJfaUlaPFZBKz5XuicHH9Kdsg1OjY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DvftKfkVP3TpPXsFlN2qodqhMnoJazhuNPkQk9nLvRH0YZWoMPv+lhHKGepn6pUx22wFkhWZhgJC3wju8kLLE1brFr951LwrjSrYdOq2t39J9b2czRJcW9zSPiFNryRgwaxDHihFil9+f/uyK1zVYdVm6V6taUbldm/mZN5zxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCQhNSZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628A3C4CEC3;
	Tue, 22 Oct 2024 05:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729574271;
	bh=WJVe5y2/2RttbuSJfaUlaPFZBKz5XuicHH9Kdsg1OjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rCQhNSZ2c7eXTPf3U4mqQ3VQKd/xa/IULAcHHBQElCTvZxmv0jq3DIB/J3ayF4p2Q
	 2Ri1J6hV5x1Pm1OnuZV31v0BbnXiC5BEVwbsu3pMG9j1O+NTPi3aezz11FuwZAN2no
	 YzqxtoljVM+MhgUY7C9I0Z4S1624hGaUMi6FZx5juJNEL6CZo1DNR/G+5+EljRSzXU
	 Zxl5Y9SOVMw/tTWSFCxQtKzDlJMs40SAL/rQXOgF8+BBw8YMvQMBhHAyTlDMEKSOPC
	 k+lMODnFlmwLTJ9zP71qe8ul2241XIUVW5i7vri8g0R9PdJOaZgqcaysMQsBOS7qFM
	 bD8I6MvVYUj4Q==
Date: Tue, 22 Oct 2024 14:17:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Viktor Malik <vmalik@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Matt Wu
 <wuqiang.matt@bytedance.com>, bpf@vger.kernel.org, Andrii Nakryiko
 <andrii@kernel.org>
Subject: Re: [PATCH v2] objpool: fix choosing allocation for percpu slots
Message-Id: <20241022141748.521cb2d6a4a86428c9bfc99e@kernel.org>
In-Reply-To: <20240826060718.267261-1-vmalik@redhat.com>
References: <20240826060718.267261-1-vmalik@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 08:07:18 +0200
Viktor Malik <vmalik@redhat.com> wrote:

> objpool intends to use vmalloc for default (non-atomic) allocations of
> percpu slots and objects. However, the condition checking if GFP flags
> are equal to GFP_ATOMIC is wrong b/c GFP_ATOMIC is a combination of bits

You meant "whether GFP flags sets any bit of GFP_ATOMIC is wrong"?

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

Anyway, this looks good to me.

Thank you,

> Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
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
> -- 
> 2.46.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

