Return-Path: <bpf+bounces-11507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD27BAFDB
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 03:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E25E42824BD
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 01:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B9315CB;
	Fri,  6 Oct 2023 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hwGL3kkX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B710E7
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 01:01:01 +0000 (UTC)
Received: from out-195.mta1.migadu.com (out-195.mta1.migadu.com [IPv6:2001:41d0:203:375::c3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B9010C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 18:00:59 -0700 (PDT)
Message-ID: <7aa47549-5a95-22d7-1d03-ffdd251cec6d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696554056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uFabqeCC0ZaRLQsefD4hwIIguPVcY2YJuzj553oCas=;
	b=hwGL3kkX/wvNGM5EF592wWTbKt6DKNsaYezKHyVPJEY0O2hUwc/F/BRLiId2/qWzJT6N/C
	w8z+e8XnmevSY9uBv9ZZmir7GByWW/08ch2uBW/6wNFE30BD6sjQg4YmS6uzWUUjeL6uYk
	Id9AS6BVmiIk5Y3DZ8yXK9BHwqB6CAg=
Date: Thu, 5 Oct 2023 18:00:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3] net/xdp: fix zero-size allocation warning in
 xskq_create()
Content-Language: en-US
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
 syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, daniel@iogearbox.net
References: <20231005193548.515-1-andrew.kanner@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231005193548.515-1-andrew.kanner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/5/23 12:35 PM, Andrew Kanner wrote:
> Syzkaller reported the following issue:
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 2807 at mm/vmalloc.c:3247 __vmalloc_node_range (mm/vmalloc.c:3361)
>   Modules linked in:
>   CPU: 0 PID: 2807 Comm: repro Not tainted 6.6.0-rc2+ #12
>   Hardware name: Generic DT based system
>   unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
>   show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
>   dump_stack_lvl from __warn (kernel/panic.c:633 kernel/panic.c:680)
>   __warn from warn_slowpath_fmt (./include/linux/context_tracking.h:153 kernel/panic.c:700)
>   warn_slowpath_fmt from __vmalloc_node_range (mm/vmalloc.c:3361 (discriminator 3))
>   __vmalloc_node_range from vmalloc_user (mm/vmalloc.c:3478)
>   vmalloc_user from xskq_create (net/xdp/xsk_queue.c:40)
>   xskq_create from xsk_setsockopt (net/xdp/xsk.c:953 net/xdp/xsk.c:1286)
>   xsk_setsockopt from __sys_setsockopt (net/socket.c:2308)
>   __sys_setsockopt from ret_fast_syscall (arch/arm/kernel/entry-common.S:68)
> 
> xskq_get_ring_size() uses struct_size() macro to safely calculate the
> size of struct xsk_queue and q->nentries of desc members. But the
> syzkaller repro was able to set q->nentries with the value initially
> taken from copy_from_sockptr() high enough to return SIZE_MAX by
> struct_size(). The next PAGE_ALIGN(size) is such case will overflow
> the size_t value and set it to 0. This will trigger WARN_ON_ONCE in

Please ignore the pw-bot email. A question just came to my mind after applying.

> diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
> index f8905400ee07..c7e8bbb12752 100644
> --- a/net/xdp/xsk_queue.c
> +++ b/net/xdp/xsk_queue.c
> @@ -34,6 +34,11 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
>   	q->ring_mask = nentries - 1;
>   
>   	size = xskq_get_ring_size(q, umem_queue);
> +	if (unlikely(size == SIZE_MAX)) {

What if "size" is SIZE_MAX-1? Would it still overflow the PAGE_ALIGN below?

> +		kfree(q);
> +		return NULL;
> +	}
> +
>   	size = PAGE_ALIGN(size);
>   
>   	q->ring = vmalloc_user(size);


