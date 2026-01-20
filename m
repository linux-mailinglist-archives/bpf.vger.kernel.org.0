Return-Path: <bpf+bounces-79523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1699D3BCB4
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C68DD300B8BF
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9341C1F02;
	Tue, 20 Jan 2026 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IgvM1HwB"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BB417A586
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768871117; cv=none; b=qMHGjxOYmxbuxLpAv5MdSBrkJ6c4CJ41jvT9PXqokiru3ZhSw0q32CCDHyr2Xl2SpYHxFsHptAYZnJFC4DsH9S+aQ50lL74gAWYC7YOYTjNzlguM/Ovbut3/pH+sLmk75joIlUk1hRdYvksP5AbDLjioUerMDeGj2KPOUFMW2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768871117; c=relaxed/simple;
	bh=drJAWzQIGecQVEf2tcI4MRKRqtbpnbWGsrGVOawIcMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IirrsLe288W+sbs5wg8HZQDaIO9X1PhYz0kVxSMTaEyAbZBQEpfZo0qbzr/vV18iu8haQOkDuha2zxJ8qkZe5qIfvuLCyZV1yVm5Kr+ZNBsWF8R/Dlm+NrsHfBbJi7M3+H1cr5EB+wF9qSIvcAQtHtLH9STabGptGIWfW7c7G8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IgvM1HwB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 20 Jan 2026 09:04:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768871104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9BSJ4ovorQomCz+1Da1Tddw6wlufJXzsgj4XlYQhj7Y=;
	b=IgvM1HwBVnm1nH4XctY9W8aWko7pH1DWJDqLyckIB+pfAhPFdJqft+J/D6OvrqCDU789eX
	5LzUDvtEcx6WcECU9yu7XA3JpX1HYW1cR0wHeGIDzJzqi1xYQUtizIGfwSECxxZns6EzBB
	zteRdfKd97NcTmn/QySH9L6M0J6qhXw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 08/21] slab: handle kmalloc sheaves bootstrap
Message-ID: <knn6gyidf6675wzt63hjsoxixqp5x65x3nwqsoi5gizqa76bog@kcvsazfh2lgu>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-8-5595cb000772@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-8-5595cb000772@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 16, 2026 at 03:40:28PM +0100, Vlastimil Babka wrote:
> Enable sheaves for kmalloc caches. For other types than KMALLOC_NORMAL,
> we can simply allow them in calculate_sizes() as they are created later
> than KMALLOC_NORMAL caches and can allocate sheaves and barns from
> those.
> 
> For KMALLOC_NORMAL caches we perform additional step after first
> creating them without sheaves. Then bootstrap_cache_sheaves() simply
> allocates and initializes barns and sheaves and finally sets
> s->sheaf_capacity to make them actually used.
> 
> Afterwards the only caches left without sheaves (unless SLUB_TINY or
> debugging is enabled) are kmem_cache and kmem_cache_node. These are only
> used when creating or destroying other kmem_caches. Thus they are not
> performance critical and we can simply leave it that way.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 84 insertions(+), 4 deletions(-)
> 

Looks good to me. Thanks.
Reviewed-by: Hao Li <hao.li@linux.dev>

-- 
Thanks,
Hao

