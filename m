Return-Path: <bpf+bounces-66840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9CCB3A538
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 18:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0661C84E86
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3616265CC2;
	Thu, 28 Aug 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JdGORKLy"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8647258EE2
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396830; cv=none; b=rnIx5sbnq3N5GtnexjjBwABSV22PCoVu6oJH0jj0v5SpVuYGG4+FSn3QENJN1Yx/ToQQl1XWVdp+i8YBPMXifDlJQOZtnCx4ACZTaWSVl7l18Dfk1MseFFn7Hrqe1Qa6tNn1cHp2rvqWTo6LdGDn/XuPpo8Vkp7UPNTokSk65pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396830; c=relaxed/simple;
	bh=v7/ydkPHwIco7Gwa9i/7Q8IUsot9uk5dipuvhOcMZPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NErybU968+C8V2G2Keh07P0pbahfPNkS/xth7is7r8fC+CwxqRDHF87Ki1gpNtkKdLKVog4Kj735MJsq09gta3GkVV/aN0uG54xmu08CMKzEcFMdleINXgqnnWsKH8rHP76d5RpwhYoYU9TtuP52RcRKbbYBR6OTDB9+Bzg1ymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JdGORKLy; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 28 Aug 2025 09:00:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756396822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLksD5zZ3hW75VnfuYQpyfVSTaZvPE3GcGq9RUHPAyw=;
	b=JdGORKLy7Tpo1qPBHWrczqxUNsnGKvO8QPJKvENrXn5vHkSEGQoO2eDo+G+wzngs7gliDP
	87V7h9XTOMgO4wtDXf938KTj0xhiuydIss4DTLB4apLum7byaGH9i/qOfsgEuGkwIVdoBb
	rSBUCCoo7RJzaj1vtKzeewTYYj22dbU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	hannes@cmpxchg.org, usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc
 bpf_mm_get_mem_cgroup()
Message-ID: <gkhxoowgcfvoj5wwbaji6v7wpizj4imwyxzrxnmw3bbd3u6eg3@ekfuuadgpeer>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-3-laoar.shao@gmail.com>
 <299e12dc-259b-45c2-8662-2f3863479939@lucifer.local>
 <3m6jhfndkoshnoj76wyjjgmqa55p4ij4desc45yz6g7gbpxnrd@xumacckayj4t>
 <46cecd34-9102-48fe-8a98-091aff6cc88a@lucifer.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46cecd34-9102-48fe-8a98-091aff6cc88a@lucifer.local>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 28, 2025 at 11:40:16AM +0100, Lorenzo Stoakes wrote:
> On Wed, Aug 27, 2025 at 01:50:18PM -0700, Shakeel Butt wrote:
> > On Wed, Aug 27, 2025 at 04:34:48PM +0100, Lorenzo Stoakes wrote:
> > > > +__bpf_kfunc_start_defs();
> > > > +
> > > > +/**
> > > > + * bpf_mm_get_mem_cgroup - Get the memory cgroup associated with a mm_struct.
> > > > + * @mm: The mm_struct to query
> > > > + *
> > > > + * The obtained mem_cgroup must be released by calling bpf_put_mem_cgroup().
> > > > + *
> > > > + * Return: The associated mem_cgroup on success, or NULL on failure. Note that
> > > > + * this function depends on CONFIG_MEMCG being enabled - it will always return
> > > > + * NULL if CONFIG_MEMCG is not configured.
> > >
> > > What kind of locking is assumed here?
> > >
> > > Are we protected against mmdrop() clearing out the mm?
> >
> > No locking is needed. Just the valid mm object or NULL. Usually the
> > underlying function (get_mem_cgroup_from_mm) is called in page fault
> > context where the current is holding mm. Here the only requirement is
> > that mm is valid either through explicit reference or the context.
> 
> I mean this may be down to me being not so familiar with BPF, but my concern is
> that we're handing _any_ mm here.

It's not really any mm but rather the mm whose validity is ensured by
the caller. I don't know the BPF internals but if I understand Andrii's
response on other email, the BPF verifier will make sure the BPF program
is holding a valid mm on which it is calling this function. In non-BPF
world, get_mem_cgroup_from_mm() assumes the caller is providing a valid
mm.

> 
> So presumably this could also be a remote mm?

Which is fine as we already do this today i.e. page fault on accessing
memory of a remote process.

> 
> If not then why are we accepting an mm parameter at all, when we could just grab
> current->mm?

Because current->mm might not be equal to the faulting mm as in the case
of remote page fault.

> 
> If it's a remote mm, then we need to be absolutely sure that we won't UAF.
> 
> I also feel we should talk about this in the kdoc, unless BPF always somehow
> asserts these things to be the case + verifies them smoehow.
> 

Yeah some text on how BPF verifier is making sure that the BPF program
is handling a valid mm.

