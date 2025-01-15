Return-Path: <bpf+bounces-49001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3F7A12F5B
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4AF7A2BA4
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6F1DC9B2;
	Wed, 15 Jan 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HvWross3"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA871DC99A
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736984841; cv=none; b=XSwI2/HOIJb/kjbJa9BpZksJHNfasiJirsaRvgRNuBnr2yePGofE2lklTmr29P/wsuzhWXld4FouOVxunlZbPrObvSaMoVjXOuj/ZDeT+py/U0zV0p5b+hMZQBSivJ6mO1+C74pGEYq0D/+EIXY4TTP+dy1yC3CTDUnzuYWggw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736984841; c=relaxed/simple;
	bh=mGzLrEbJOPf8VurtWaoXvcfcpOIzEfaHVFANeNdACfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heB/JMGR9PPPVqMvcjIhufNftecSaj6BecJ6ODTR3dCPItUjSGujs3Kk1jLjC5VrzDiMbBQeTgccn7fB/5afyaMNNijFYGS/nqye4hXW/f7rfTTZSG7Cf7gxatBqjHKCYpWHCHuVh6jlx1gphU04J6ke73c10KGh+hwn+8ctD08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HvWross3; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 15 Jan 2025 15:47:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736984831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHNq/pnk2CXWVu7asoZVq4jYoXWOdxzbfK/2GqNmkNs=;
	b=HvWross3YlmtIxpzMsqIJdkHSpFzZgil4N7xG1U766z9MAjyfNCgNG4aVd1wexsryr2nXT
	AjzDe/kYv0VSq0+Po04DXXHYLTnd0V/XKLz6flZ59TcTaz9bWlO1jVCjq1IjjPwfhFFfrz
	0+NCu1vEypSu4dxZeUgAUzfzz6vVc7Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 1/7] mm, bpf: Introduce try_alloc_pages() for
 opportunistic page allocation
Message-ID: <ntbykvhaw7ohuu5nb7x4g4kqrlqkxfzb5ydjxpxszayfvewkrn@lvx22b7p7it5>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-2-alexei.starovoitov@gmail.com>
 <9fb94763-69b2-45bd-bc54-aef82037a68c@suse.cz>
 <CAADnVQ+TecNdNir8QK_3cOKf4WhYj9+j5oZKdzWUoE6H5PuetQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+TecNdNir8QK_3cOKf4WhYj9+j5oZKdzWUoE6H5PuetQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 15, 2025 at 03:00:08PM -0800, Alexei Starovoitov wrote:
> On Wed, Jan 15, 2025 at 3:19 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> >

Sorry missed your response here.

> > What about set_page_owner() from post_alloc_hook() and it's stackdepot
> > saving. I guess not an issue until try_alloc_pages() gets used later, so
> > just a mental note that it has to be resolved before. Or is it actually safe?
> 
> set_page_owner() should be fine.
> save_stack() has in_page_owner recursion protection mechanism.
> 
> stack_depot_save_flags() may be problematic if there is another
> path to it.
> I guess I can do:
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 245d5b416699..61772bc4b811 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -630,7 +630,7 @@ depot_stack_handle_t
> stack_depot_save_flags(unsigned long *entries,
>                         prealloc = page_address(page);
>         }

There is alloc_pages(gfp_nested_mask(alloc_flags)...) just couple of
lines above. How about setting can_alloc false along with the below
change for this case? Or we can set ALLOC_TRYLOCK in core alloc_pages()
for !gfpflags_allow_spinning().

> 
> -       if (in_nmi()) {
> +       if (in_nmi() || !gfpflags_allow_spinning(alloc_flags)) {
>                 /* We can never allocate in NMI context. */
>                 WARN_ON_ONCE(can_alloc);
>                 /* Best effort; bail if we fail to take the lock. */
>                 if (!raw_spin_trylock_irqsave(&pool_lock, flags))
>                         goto exit;
> 
> as part of this patch,
> but not convinced whether it's necessary.
> stack_depot* is effectively noinstr.
> kprobe-bpf cannot be placed in there and afaict
> it doesn't call any tracepoints.
> So in_nmi() is the only way to reenter and that's already covered.

Are the locks in stack_depot* only the issue for bpf programs triggered
inside stack_depot*?

