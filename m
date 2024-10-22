Return-Path: <bpf+bounces-42782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FF9AA73E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AAF2841E8
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E56719E7E0;
	Tue, 22 Oct 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWJCeoHG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BE2BAF5;
	Tue, 22 Oct 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604724; cv=none; b=j7huyOdGfTvXyvlAblaEGvZMC9vzjRuL09ReVpLtmRRMkn8WJ6547EV9dMKrs5NEu9HgUJHacxQ//PiIq1dRYjv1lya197WpID1jnNBshi8AJb3Sh0aerOz0mdkad2QT2RWxhIHmMdteRW0DWtbKNGwVSl8ugRWpwL0NGyq0+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604724; c=relaxed/simple;
	bh=Y3of95RA9/HwSVZtOVvqqjWXqboGxrXcyJVBeg4xcTU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qBZQcCwVaB7XTwgtFkvnJUgr1ijjSk1C5BPfJf6dT8U+6H3PoOM3TID2K88tBZCP7Mp9RvNf1TnWslI3NPjCNneif19l3xI18dRSN18sRWYAJfLjsMtV9G7ZgpBRqcW6XmF+nAU+XW2MswP3/aTQsN+Z895dTFmGVfTrvZ4K3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWJCeoHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987CDC4CEC7;
	Tue, 22 Oct 2024 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729604724;
	bh=Y3of95RA9/HwSVZtOVvqqjWXqboGxrXcyJVBeg4xcTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BWJCeoHGh0I9e3yHUThIVP2IL/fYYGYtuwHfEqmBey+lfIs6NyqHZ5RlC8xSBNhcL
	 6UUQYLiWF4kdeYGmTfMkxy0billLB7gHTx0HCERsyjcUyXC2VlA2ELbifKn8g5ZCqa
	 EvW8dwtq4442MIkAo2Rfj64gdnmhBgs3ZRiqmMkZnjkoJrBdR2Jzpuo6+C9TY2glhd
	 nI0AF5sBlPpQLdHBwHtTc8JNiUDPvvs/iBSzqHskVHB5S06Dv9njNMMPX/ldcS7FnS
	 G8dgoQYo0pHhGCJBusI2YBXD6bTDtDNdo06XdHqVcHfFBfVvcAG1uKUSgHhlR4Dzk2
	 hECHPmcKOxSZg==
Date: Tue, 22 Oct 2024 22:45:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Viktor Malik <vmalik@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Matt Wu <wuqiang.matt@bytedance.com>,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH v2] objpool: fix choosing allocation for percpu slots
Message-Id: <20241022224520.33f753971ce61ce7d0f1fc93@kernel.org>
In-Reply-To: <3d1ad598-531a-4e31-a0cc-b8fe05d37f64@redhat.com>
References: <20240826060718.267261-1-vmalik@redhat.com>
	<20241022141748.521cb2d6a4a86428c9bfc99e@kernel.org>
	<3d1ad598-531a-4e31-a0cc-b8fe05d37f64@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 13:45:08 +0200
Viktor Malik <vmalik@redhat.com> wrote:

> On 10/22/24 07:17, Masami Hiramatsu (Google) wrote:
> > On Mon, 26 Aug 2024 08:07:18 +0200
> > Viktor Malik <vmalik@redhat.com> wrote:
> > 
> >> objpool intends to use vmalloc for default (non-atomic) allocations of
> >> percpu slots and objects. However, the condition checking if GFP flags
> >> are equal to GFP_ATOMIC is wrong b/c GFP_ATOMIC is a combination of bits
> > 
> > You meant "whether GFP flags sets any bit of GFP_ATOMIC is wrong"?
> 
> Well, I meant that the condition is wrong w.r.t. what is supposedly its
> original purpose. But feel free to rephrase as you seem fit or I can
> send v3 if you prefer.

No problem :) let me rephrase that part.

Thank you!

> 
> Thanks.
> Viktor
> 
> > 
> >> (__GFP_HIGH|__GFP_KSWAPD_RECLAIM) and so `pool->gfp & GFP_ATOMIC` will
> >> be true if either bit is set. Since GFP_ATOMIC and GFP_KERNEL share the
> >> ___GFP_KSWAPD_RECLAIM bit, kmalloc will be used in cases when GFP_KERNEL
> >> is specified, i.e. in all current usages of objpool.
> >>
> >> This may lead to unexpected OOM errors since kmalloc cannot allocate
> >> large amounts of memory.
> >>
> >> For instance, objpool is used by fprobe rethook which in turn is used by
> >> BPF kretprobe.multi and kprobe.session probe types. Trying to attach
> >> these to all kernel functions with libbpf using
> >>
> >>     SEC("kprobe.session/*")
> >>     int kprobe(struct pt_regs *ctx)
> >>     {
> >>         [...]
> >>     }
> >>
> >> fails on objpool slot allocation with ENOMEM.
> >>
> >> Fix the condition to truly use vmalloc by default.
> >>
> > 
> > Anyway, this looks good to me.
> > 
> > Thank you,
> > 
> >> Fixes: b4edb8d2d464 ("lib: objpool added: ring-array based lockless MPMC")
> >> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> >> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >> Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
> >> ---
> >>  lib/objpool.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/objpool.c b/lib/objpool.c
> >> index 234f9d0bd081..fd108fe0d095 100644
> >> --- a/lib/objpool.c
> >> +++ b/lib/objpool.c
> >> @@ -76,7 +76,7 @@ objpool_init_percpu_slots(struct objpool_head *pool, int nr_objs,
> >>  		 * mimimal size of vmalloc is one page since vmalloc would
> >>  		 * always align the requested size to page size
> >>  		 */
> >> -		if (pool->gfp & GFP_ATOMIC)
> >> +		if ((pool->gfp & GFP_ATOMIC) == GFP_ATOMIC)
> >>  			slot = kmalloc_node(size, pool->gfp, cpu_to_node(i));
> >>  		else
> >>  			slot = __vmalloc_node(size, sizeof(void *), pool->gfp,
> >> -- 
> >> 2.46.0
> >>
> > 
> > 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

