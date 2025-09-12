Return-Path: <bpf+bounces-68266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ECDB55823
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4CE45885AF
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 21:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5637532ED2D;
	Fri, 12 Sep 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fesVLqO3"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F1A28489B
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711528; cv=none; b=pf8JChtnRh8fEUiGTveFrTPqm52+/7bXq05rSzpqz8MRaPDRkS0QOyl5hL2EfDCN/k/kWtUm26E640o3WcNQhFYPwD3NN4C2FyvsRz0hmjFl7GoRJoT3p4ILuL3I72t/04FuJdXKyebZDlq5H7l/pwvhXxi++WXOP3UjEz9nDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711528; c=relaxed/simple;
	bh=8fY6dfs2EejDJ573yFkVwHfXXkpRhl7578Qlz44+BoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNVvH0kT/Cxim/ZeuX3lG9Ltv7JyEkmGOkGdlryqNGyob6qJ+rIbu+CgVU5NACngLOnTpyrX7rmK6m96VZM8bbsf7Nxni47vASM9teuBaeBDhN914NqfPUJfKB4XLglCshvPr+bdlXh3mnemustoouKKCHpYfjECNEt4nw8+5q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fesVLqO3; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 12 Sep 2025 14:11:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757711523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1iy96TgkS7WHq5/odvTgYGKNjQS3AcZjxGa0biOKkQ=;
	b=fesVLqO3DPPZfy0knzjdCqF+npTedXM005odVu1M+PKq7OSCmK7RVHSpNaQKMT+rQshgkg
	0xdAOfJF/iFP25TpQ+mzS1+diMmTThKjrZgS9wW6syv6VcASiuiHEYViatucq9ogWFXfkB
	VJwAMhad7c4X4N4Bb0jivh41wYh04wE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, vbabka@suse.cz, harry.yoo@oracle.com, mhocko@suse.com, 
	bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org, 
	peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev
Subject: Re: [PATCH slab v5 5/6] slab: Reuse first bit for OBJEXTS_ALLOC_FAIL
Message-ID: <avhakjldsgczmq356gkwmvfilyvf7o6temvcmtt5lqd4fhp5rk@47gp2ropyixg>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-6-alexei.starovoitov@gmail.com>
 <jftidhymri2af5u3xtcqry3cfu6aqzte3uzlznhlaylgrdztsi@5vpjnzpsemf5>
 <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGUjaZcs1r9ADKck_Ni7f41kHaiejR01Z0bE8pG0K1uXA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 12, 2025 at 02:03:03PM -0700, Suren Baghdasaryan wrote:
[...]
> > I do have some questions on the state of slab->obj_exts even before this
> > patch for Suren, Roman, Vlastimil and others:
> >
> > Suppose we newly allocate struct slab for a SLAB_ACCOUNT cache and tried
> > to allocate obj_exts for it which failed. The kernel will set
> > OBJEXTS_ALLOC_FAIL in slab->obj_exts (Note that this can only be set for
> > new slab allocation and only for SLAB_ACCOUNT caches i.e. vec allocation
> > failure for memory profiling does not set this flag).
> >
> > Now in the post alloc hook, either through memory profiling or through
> > memcg charging, we will try again to allocate the vec and before that we
> > will call slab_obj_exts() on the slab which has:
> >
> >         unsigned long obj_exts = READ_ONCE(slab->obj_exts);
> >
> >         VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS), slab_page(slab));
> >
> > It seems like the above VM_BUG_ON_PAGE() will trigger because obj_exts
> > will have OBJEXTS_ALLOC_FAIL but it should not, right? Or am I missing
> > something? After the following patch we will aliasing be MEMCG_DATA_OBJEXTS
> > and OBJEXTS_ALLOC_FAIL and will avoid this trigger though which also
> > seems unintended.
> 
> You are correct. Current VM_BUG_ON_PAGE() will trigger if
> OBJEXTS_ALLOC_FAIL is set and that is wrong. When
> alloc_slab_obj_exts() fails to allocate the vector it does
> mark_failed_objexts_alloc() and exits without setting
> MEMCG_DATA_OBJEXTS (which it would have done if the allocation
> succeeded). So, any further calls to slab_obj_exts() will generate a
> warning because MEMCG_DATA_OBJEXTS is not set. I believe the proper
> fix would not be to set MEMCG_DATA_OBJEXTS along with
> OBJEXTS_ALLOC_FAIL because the pointer does not point to a valid
> vector but to modify the warning to:
> 
> VM_BUG_ON_PAGE(obj_exts && !(obj_exts & (MEMCG_DATA_OBJEXTS |
> OBJEXTS_ALLOC_FAIL)), slab_page(slab));
> 
> IOW, we expect the obj_ext to be either NULL or have either
> MEMCG_DATA_OBJEXTS or OBJEXTS_ALLOC_FAIL set.
> >
> > Next question: OBJEXTS_ALLOC_FAIL is for memory profiling and we never
> > set it when memcg is disabled and memory profiling is enabled or even
> > with both memcg and memory profiling are enabled but cache does not have
> > SLAB_ACCOUNT. This seems unintentional as well, right?
> 
> I'm not sure why you think OBJEXTS_ALLOC_FAIL is not set by memory
> profiling (independent of CONFIG_MEMCG state).
> __alloc_tagging_slab_alloc_hook()->prepare_slab_obj_exts_hook()->alloc_slab_obj_exts()
> will attempt to allocate the vector and set OBJEXTS_ALLOC_FAIL if that
> fails.
> 

prepare_slab_obj_exts_hook() calls alloc_slab_obj_exts() with new_slab
as false and alloc_slab_obj_exts() will only call
mark_failed_objexts_alloc() if new_slab is true.

> >
> > Also I think slab_obj_exts() needs to handle OBJEXTS_ALLOC_FAIL explicitly.
> 
> Agree, so is my proposal to update the warning sounds right to you?

Yes that seems right to me.

