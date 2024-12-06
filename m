Return-Path: <bpf+bounces-46235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880339E6450
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 03:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45181169169
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5840317E01B;
	Fri,  6 Dec 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfQNkJHV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18214D433;
	Fri,  6 Dec 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452818; cv=none; b=LuUvH2k9CkIagEigqRQuKsu3Lkn+8Xqvl9EfMTUv+fEMkSJ2Gx6zlvyKmrKOjg0I7Jt/VzQeHJJ7pvw0Og34dF8M5r7pC/zSdGFc7qZMeCxzLwGiufTWUbA3IGXGQQC8t0Q1cUCNstVUOFME6KSc/4h11nE0diiv59imlC/cpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452818; c=relaxed/simple;
	bh=kutxWliyYMrFZcWXJ006HBnrlV8xm95oCb5CgE0l0ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9w3AcLND7s+Oo5jFh1lM4fWRiwEbe3AuY3U0fCWwaoLlAFHK+NAyjzQgC7KCssBBzk9gea+iHbeIXHNPttAcHfSCnRuvRIwg5jVpt3ER/+dYlFWuxFWDZlH4ql58CVXArJcCuaU3dxAYm/s0m0j+mJyQMIsiC8eEXihYtneeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfQNkJHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7856BC4CED6;
	Fri,  6 Dec 2024 02:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733452818;
	bh=kutxWliyYMrFZcWXJ006HBnrlV8xm95oCb5CgE0l0ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TfQNkJHV8m3/KABqjivX6rNREbRv43EQ8wZPFYT7CfYwmqNAt/sFnkNjeAr5D43fb
	 jZ9JdvkYkpt9/BXtZxyL8ES61EJLcXubKZ49B4QCB3sNH/bmDHBX+BbrPF87TB1VIa
	 e5+9Z9BLXkOv0GWslGLYFJe+dKELNbHPpMWwFkd5bDibgmeNq2vePzjaiiybyM8l2h
	 ZaccR92rEJlsv5UENx3SxK9WUGYv4Xt7PcXVeTmZufGLSNRNJIZ9L7NF4R8z6ELlRQ
	 N0D7uMW54XgzDJZ04BUyLOOKvqtHBBuSgt5sJRG7uHJxgKai3aOtYoQvNT9vqt/Z5G
	 r2PBztOUGhgIw==
Date: Thu, 5 Dec 2024 18:40:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 09/10] page_pool: allow mixing PPs within
 one bulk
Message-ID: <20241205184016.6941f504@kernel.org>
In-Reply-To: <20241203173733.3181246-10-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
	<20241203173733.3181246-10-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Very nice in general, I'll apply the previous 8 but I'd like to offer
some alternatives here..

On Tue,  3 Dec 2024 18:37:32 +0100 Alexander Lobakin wrote:
> +void page_pool_put_netmem_bulk(netmem_ref *data, u32 count)
>  {
> -	int i, bulk_len = 0;
> -	bool allow_direct;
> -	bool in_softirq;
> +	bool allow_direct, in_softirq, again = false;
> +	netmem_ref bulk[XDP_BULK_QUEUE_SIZE];
> +	u32 i, bulk_len, foreign;
> +	struct page_pool *pool;
>  
> -	allow_direct = page_pool_napi_local(pool);
> +again:
> +	pool = NULL;
> +	bulk_len = 0;
> +	foreign = 0;
>  
>  	for (i = 0; i < count; i++) {
> -		netmem_ref netmem = netmem_compound_head(data[i]);
> +		struct page_pool *netmem_pp;
> +		netmem_ref netmem;
> +
> +		if (!again) {
> +			netmem = netmem_compound_head(data[i]);
>  
> -		/* It is not the last user for the page frag case */
> -		if (!page_pool_is_last_ref(netmem))
> +			/* It is not the last user for the page frag case */
> +			if (!page_pool_is_last_ref(netmem))
> +				continue;

We check the "again" condition potentially n^2 times, is it written
this way because we expect no mixing? Would it not be fewer cycles
to do a first pass, convert all buffers to heads, filter out all
non-last refs, and delete the "again" check?

Minor benefit is that it removes a few of the long lines so it'd be
feasible to drop the "goto again" as well and just turn this function
into a while (count) loop.

> +		} else {
> +			netmem = data[i];
> +		}
> +
> +		netmem_pp = netmem_get_pp(netmem);

nit: netmem_pp is not a great name. Ain't nothing especially netmem
about it, it's just the _current_ page pool.

> +		if (unlikely(!pool)) {
> +			pool = netmem_pp;
> +			allow_direct = page_pool_napi_local(pool);
> +		} else if (netmem_pp != pool) {
> +			/*
> +			 * If the netmem belongs to a different page_pool, save
> +			 * it for another round after the main loop.
> +			 */
> +			data[foreign++] = netmem;
>  			continue;
> +		}
>  
>  		netmem = __page_pool_put_page(pool, netmem, -1, allow_direct);
>  		/* Approved for bulk recycling in ptr_ring cache */
>  		if (netmem)
> -			data[bulk_len++] = netmem;
> +			bulk[bulk_len++] = netmem;
>  	}
>  
>  	if (!bulk_len)

You can invert this condition, and move all the code from here to the
out label into a small helper with just 3 params (pool, bulk, bulk_len).
Naming will be the tricky part but you can save us a bunch of gotos.

> -		return;
> +		goto out;
>  
>  	/* Bulk producer into ptr_ring page_pool cache */
>  	in_softirq = page_pool_producer_lock(pool);
>  	for (i = 0; i < bulk_len; i++) {
> -		if (__ptr_ring_produce(&pool->ring, (__force void *)data[i])) {
> +		if (__ptr_ring_produce(&pool->ring, (__force void *)bulk[i])) {
>  			/* ring full */
>  			recycle_stat_inc(pool, ring_full);
>  			break;
> @@ -893,13 +915,22 @@ void page_pool_put_netmem_bulk(struct page_pool *pool, netmem_ref *data,
>  
>  	/* Hopefully all pages was return into ptr_ring */
>  	if (likely(i == bulk_len))
> -		return;
> +		goto out;
>  
>  	/* ptr_ring cache full, free remaining pages outside producer lock
>  	 * since put_page() with refcnt == 1 can be an expensive operation
>  	 */
>  	for (; i < bulk_len; i++)
> -		page_pool_return_page(pool, data[i]);
> +		page_pool_return_page(pool, bulk[i]);
> +
> +out:
> +	if (!foreign)
> +		return;
> +
> +	count = foreign;
> +	again = true;
> +
> +	goto again;
>  }
>  EXPORT_SYMBOL(page_pool_put_netmem_bulk);

