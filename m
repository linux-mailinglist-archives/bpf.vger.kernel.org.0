Return-Path: <bpf+bounces-78749-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDACD1ADBA
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 19:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3631C3054374
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A834D4F9;
	Tue, 13 Jan 2026 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hFImr025";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqkqfQnW"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4C2116F6;
	Tue, 13 Jan 2026 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329368; cv=none; b=cp+Qi5iy91plhmrD8jhiQlkfZ4imdIBsHUvrtdqccTPxgCPxDdsvKlYisQBl1LAQpwkUc4bEFOpwrrZBe2Edvb0vGSLDCLdNFPSv8jnv4WCbeuJ+nykqtH8AEMa8JDwSshoTnn0TSuizq5neR54rLViqudqB+F22F7DZmIbvOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329368; c=relaxed/simple;
	bh=waPBtMaWbPGlkrm/DtnNWB1BKXoDjj23sRuuXFc4iTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx8c85EEBFVf1yQDqTwAitvrnrHQBKJjVx2hjxjzKGU5kz+jP6s1NEZyYum1/VITLlS5o+KkHn1Yy3piyJlq4gdULEWd9xLsvMOwfYgNKac6m+of0j/WvVRiWVpta93dE3Yy93UeOOGrk9h1plluZOTWLo2e/TCwapqY9YwhsMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hFImr025; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqkqfQnW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 19:36:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768329365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pipRsFX69esF5KPLH4c9+I4B/dXZBlcjVkgFMV18ALI=;
	b=hFImr025oHU3L771wHk/hH+l4KUX+6lGspsuzw6PbnGGkZ+sQxro5UaFtiyINrXh796G4K
	00d1uB5mDQoevz9twPv15hzNWWdXn+XGhd+73I+SNexn4IkTU2nNSvy1PXxXwFdYjV7Gk9
	9t60Vv1kdj8AMcNFoFoTiAxaF5EtVm/czMWoktNQGYXLTDDEuDg013/R83Zb3x/tnImXLL
	nNyWEzk2QC/wXLH30bUnesKMvtrB5A+VpDJ48BLku+F+m3Qpe06OguRMBqDXM5CuEBiK8e
	GrFZ/Y30sTDtwgkpKZzcjPhkrmyXA+KxJVSXJobJG/bTu0hdd3ya8SXDXd5Vyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768329365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pipRsFX69esF5KPLH4c9+I4B/dXZBlcjVkgFMV18ALI=;
	b=xqkqfQnWaqaQfZqfL4aBVEtYUtp9diagEpNuEMaq04JbGoa7muCgQh8Bb8gxJUlcg5uYA/
	Wa0zRRjjiz3hY5AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC v2 06/20] slab: make percpu sheaves compatible with
 kmalloc_nolock()/kfree_nolock()
Message-ID: <20260113183604.ykHFYvV2@linutronix.de>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-6-98225cfb50cf@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112-sheaves-for-all-v2-6-98225cfb50cf@suse.cz>

On 2026-01-12 16:17:00 [+0100], Vlastimil Babka wrote:
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5727,6 +5742,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>  		 */
>  		return NULL;
>  
> +	ret = alloc_from_pcs(s, alloc_gfp, node);
> +	if (ret)
> +		goto success;

I'm sorry if I am slow but this actually should actually allow
kmalloc_nolock() allocations on PREEMPT_RT from atomic context. I am
mentioning this because of the patch which removes the nmi+hardirq
condtion (https://lore.kernel.org/all/20260113150639.48407-1-swarajgaikwad1925@gmail.com)

> +
> +	ret = ERR_PTR(-EBUSY);
> +
>  	/*
>  	 * Do not call slab_alloc_node(), since trylock mode isn't
>  	 * compatible with slab_pre_alloc_hook/should_failslab and

Sebastian

