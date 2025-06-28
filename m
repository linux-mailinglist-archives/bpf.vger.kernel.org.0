Return-Path: <bpf+bounces-61790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A0AEC38C
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 02:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612684A286B
	for <lists+bpf@lfdr.de>; Sat, 28 Jun 2025 00:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3513C918;
	Sat, 28 Jun 2025 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is9ZQW5S"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3109210E4;
	Sat, 28 Jun 2025 00:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751071052; cv=none; b=YXWSVwVwgR2W1s9ngP7Cet83q4pMaULSvRcqi+gWlfuNpT7CyTtfJ+r/6JQJfVcah1+uC95KgRh1PQp/70OJ6gl8d8RY0+ZmA/PvJNK9w1qJCvBnosoVJQQhHakNkYW8e7pF+IWR3b2nNTEwLr7CcFIfRq61vlmKFYSJiFt9PQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751071052; c=relaxed/simple;
	bh=tBZzo3Vernjc/RqLkt5V8ZGDjHbDEERaWaQdG3x/eHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZi6cATxXkRTIAHzsB0vTNWzQP13cABP+uh2IL6vLJAiy8VRQ8EGHDlpGTyYdXcx0WHMD5T2v+9S4burBAPh4oJlgyhg6KZ0Y7PhIhaNWqutnHVTHrBbzKsdmK5nyfE2YuvX6oVWgs4YSPcVunU42GxK8hfQtHpuR+QQ2iHYgBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is9ZQW5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C330AC4CEE3;
	Sat, 28 Jun 2025 00:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751071051;
	bh=tBZzo3Vernjc/RqLkt5V8ZGDjHbDEERaWaQdG3x/eHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=is9ZQW5S9yroLWwxDcQ2Vxz+Dg5Y50/NyQBvJwjq5cDM1u51Bvk5Cs9/lFSIE85jJ
	 EV1+RIIonsc367dy6yP/idPDFgr6//xfQlVccl7agu2V2Q3+nSw0HqSQzJy/Ws4x85
	 XyV9cF86Q+a0q6WEyplKPawW8vsbH54tVyMecukC+IqEIzYXn75h/C1Lcvf4Is4uDr
	 lJ52UeZLlgHJ6/I7fuqzz8U430UyFRX7eVcTMu+FL7v+mHAR9q6aM7DA4cUV6pl0o7
	 w3UqoSNnFp0wIsJSzfYwHB6ye62zLTsYGZaMEGE7CW6jC4fdVac34dRgfi1QCh0Dzu
	 /15NohvMHz1dA==
Date: Fri, 27 Jun 2025 17:37:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
Subject: Re: [PATCH net-next v7 1/7] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <20250627173730.15b25a8c@kernel.org>
In-Reply-To: <20250627035405.GA4276@system.software.com>
References: <20250625043350.7939-1-byungchul@sk.com>
	<20250625043350.7939-2-byungchul@sk.com>
	<20250626174904.4a6125c9@kernel.org>
	<20250627035405.GA4276@system.software.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 12:54:05 +0900 Byungchul Park wrote:
> On Thu, Jun 26, 2025 at 05:49:04PM -0700, Jakub Kicinski wrote:
> > On Wed, 25 Jun 2025 13:33:44 +0900 Byungchul Park wrote:  
> > > +/* A memory descriptor representing abstract networking I/O vectors,
> > > + * generally for non-pages memory that doesn't have its corresponding
> > > + * struct page and needs to be explicitly allocated through slab.  
> > 
> > I still don't get what your final object set is going to be.  
> 
> The ultimate goal is:
> 
>    Remove the pp fields from struct page
> 
> The second important goal is:
> 
>    Introduce a network pp descriptor, netmem_desc
> 
> While working on these two goals, I added some extra patches too, to
> clean up related code if it's obvious e.g. patches for renaming and so
> on.

Object set. Not objective.

> > We have
> >  - CPU-readable buffers (struct page)
> >  - un-readable buffers (struct net_iov)
> >  - abstract reference which can be a pointer to either of the
> >    above two (bitwise netmem_ref)
> > 
> > You say you want to evacuate page pool state from struct page
> > so I'd expect you to add a type which can always be fed into
> > some form of $type_to_virt(). A type which can always be cast
> > to net_iov, but not vice versa. So why are you putting things
> > inside net_iov, not outside.  
> 
> The type, struct netmem_desc, is declared outside.  Even though it's
> used overlaying on struct page *for now*, it will be dynamically
> allocated through slab shortly - it's also one of mm's plan.
> 
> As you know, net_iov is working with the assumption that it overlays on
> struct page *for now* indeed, when it comes to netmem_ref.  See the
> following APIs as example:
> 
> static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
> {
> 	return (struct net_iov *)((__force unsigned long)netmem & ~NET_IOV);
> }
> 
> static inline void netmem_set_pp(netmem_ref netmem, struct page_pool *pool)
> {
> 	__netmem_clear_lsb(netmem)->pp = pool;
> }
> 
> I'd say, I replaced the overlaying (on struct page) part with a
> well-defined struct, netmem_desc that will play the role of struct page
> for pp usage, instead of a set of the current overlaying fields of
> net_iov.
> 
> This 'introduction of netmem_desc' patch can be the base for network
> code to use netmem_desc as pp descriptor instead of struct page.  That's
> what I meant.
> 
> Am I missing something or got you wrong?  If yes, please explain in more
> detail then I will get back with the answer.

Ugh, you keep explaining the mechanics to me. Our goal here is not
just to move fields around and make it still compile :/

Let me ask you this way: you said "netmem_desc" will be allocated
thru slab "shortly". How will calling the equivalent of page_address()
on netmem_desc work at that stage? Feel free to refer me to the existing
docs if its covered..

