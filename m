Return-Path: <bpf+bounces-57549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94051AACCCF
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 20:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5F54E6CA4
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A8A2857FD;
	Tue,  6 May 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gkfsChz4"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D502853F6
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554736; cv=none; b=TdA6f0M92TeA1RskCVTqLjp4Y+P+lI1uQdFQK5hBye6NBwSZIQNDJHWCtnNHwpZWbmeHLQPnm0ql1pUIf9iS5TMHEJ1+880EvME1vURqdsYNerLhstN3qgzfTVq6+oT4C8eCGUBe21d88POgrlcpUu7tUwi739eErU6rIc683oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554736; c=relaxed/simple;
	bh=ZS1+sFzaUV5SLF1bd3uLP/wpEbajvfzjp8xRtvTubhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNxofEhGlRv4o1+FTIde6Kfasf9qB+qwIRUo5mkC5wITjg9fR3xdKQxZF9LMN7pqw5s8ROQXLIEdZUwsd/8HzHAT8T6wPLOHKYaLQ2J/QDNdtjVZ9Khzqqpe2o0qVm2veuSk0WIA+id4Kw56j4bhrB+kN+XAEvoB/WZ46H8vmhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gkfsChz4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 6 May 2025 11:05:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746554731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WXuUeFYcJkDDXEdT17Uj8ovL8NdXcFWCwoHDW6hsVg=;
	b=gkfsChz47hWo4rBNxGAPUQZQBuSRf7SWb6Fnn4uuOmiv7Devgy0Dg8vFxQM94kDBocO8i6
	fVFxfkjQwh5VlBn+M1TPnwBNCE043auZxyzrPb8lw7dV87YYNhQ7PFeBTBVCNXbuV9K2iQ
	bwxHA76yB8kck5hxZGuNa2aS7JNrs34=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
Message-ID: <4j5rqzw5lulawbggh22e5b2enqgvwhmuwvw2hljcj6fxngnbt7@6hbeyck7255g>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com>
 <a74hjevi7tyq36vekcft7mlfdgwtcg6ddvr3bekb3amcf4fiuc@z7xszkyjcrbb>
 <CAADnVQ+OroM-auGvC7GPzaOUz90zHktF545BC7wRz5s_tW6z4w@mail.gmail.com>
 <d25b6lxjjzi3zqbotlrapx57ukjl7frmyvg2lgx5omos3zqg4m@ukkod2jdmieb>
 <CAADnVQJt3aRCcG=Zgt+-hwKdeDcvE0Gvcc3fSKXURr0d+7OU8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJt3aRCcG=Zgt+-hwKdeDcvE0Gvcc3fSKXURr0d+7OU8A@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 05, 2025 at 06:51:28PM -0700, Alexei Starovoitov wrote:
> On Mon, May 5, 2025 at 6:25 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > > > >               obj_exts[off].objcg = NULL;
> > > > > -             refill_obj_stock(objcg, obj_size, true, -obj_size,
> > > > > -                              slab_pgdat(slab), cache_vmstat_idx(s));
> > > > > +             if (unlikely(lock_held)) {
> > > > > +                     atomic_add(obj_size, &objcg->nr_charged_bytes);
> > > >
> > > > objcg->nr_charged_bytes is stats ignorant and the relevant stats need to
> > > > be updated before putting stuff into it.
> > >
> > > I'm not following.
> > > It's functionally equivalent to refill_obj_stock() without
> > > __account_obj_stock().
> > > And the stats are not ignored.
> > > The next __memcg_slab_free_hook() from good context will update
> > > them. It's only a tiny delay in update.
> > > I don't see why it's an issue.
> >
> > For the slab object of size obj_size which is being freed here, we need
> > to update NR_SLAB_RECLAIMABLE_B or NR_SLAB_UNRECLAIMABLE_B stat for the
> > corresponding objcg by the amount of obj_size. If we don't call
> > __account_obj_stock() here we will loose the context and information to
> > update these stats later.
> 
> Lose context?
> pgdat has to match objcg, so I don't think we lose anything.
> Later refill_obj_stock() will take objcg->nr_charged_bytes and
> apply to appropriate NR_SLAB_[UN]RECLAIMABLE_B.

refill_obj_stock() will not apply objcg->nr_charged_bytes to
NR_SLAB_[UN]RECLAIMABLE_B. This is confusing because per-cpu objcg stock
has two distinct functions i.e. (1) byte level charge cache and (2) slab
stats cache, though both of them happen to share objcg (this will change
when I add multi-objcg support).

Let me explain this with an example. Let's say in the task context,
Job-A frees a charged slab object on CPU-i and also assume CPU-i's
memcg_stock has Job-A's objcg cached. Next let's assume while CPU-i was
in refill_obj_stock(), it got interrupted by a nmi and within nmi there
is a slab object charged to Job-B got freed.

In the above scenario and with this patch, the kernel will put the
obj_size of the Job-B's freed slab object to Job-B's
objcg->nr_charged_bytes and just return. Please note that CPU-i still
has Job-A's objcg (charge and stats) cached. When CPU-i's memcg_stock
get drained later, it will update stats of Job-A which were cached on
it. We have lost the stat updates for Job-B's freed slab object.

