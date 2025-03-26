Return-Path: <bpf+bounces-54751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B10A717DF
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 14:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC53173715
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6651F0E5B;
	Wed, 26 Mar 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbyAtgkG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60291EFF9D;
	Wed, 26 Mar 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997275; cv=none; b=UWK21FKKYhkgwY6JE5zBFKL45w4N7UjfFAxvVGE+gNms7psPGRtM9CnUPgz3c7ckOPAt5ZpTSUTldFK0yZs3iVNwH+wp7n73DlVIqz9eXSLYFNcBhY7lbnKQ73Fz2CQowSBshPbXBpG7+GnXzn1FVYBPVB8B/qxYcbDAMdn+lAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997275; c=relaxed/simple;
	bh=MITqSr2jxezS0QyojVv0ctDgJnQhqNl2NQ/2YZtbfcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+yOsacY488lyi/ipPCVnyTGPDUfOjkeq7iUX2kmLrrcBNnDgmSrXYfbo/CJnQazPlXpketwTyfd2wk3Ni8oozc34Dmm/FC8kA6csGYg3YhZo07QJyhHN3RvLfWDCSY/ogWHYEx85UVOWCtsQL6PYWc6zDZg/MnwW75HHDAlLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbyAtgkG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C49BC4CEE2;
	Wed, 26 Mar 2025 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742997274;
	bh=MITqSr2jxezS0QyojVv0ctDgJnQhqNl2NQ/2YZtbfcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PbyAtgkGc+aKaImYhRMQjv+zRBhwIak2tCy9xSaIpgTDPzvjlfsgexNGHffaTrHQ4
	 Qa42mNEgB5FWzqoY/Kcobv23eDqoxmSOyahMfSZeiuCDjXQYIvz+ChC4ZKZ80ro1EW
	 z3d2wMl49SRmGb0guBH9CyEvZ+BGMw76RpFBxL8DMYfpv3ROji0In7+P+KVpc/1JsP
	 SpZe1W+c4V6JxmoUozZo8XRQrUMd+fRcimXegdLuL7YmOX7+0TniZRuCGVHQDUfvge
	 gZziZstnk7KgSv7qSjhWb+6b/DhcgSYpfcRXub9Nj6LRNpoXVaqaeOHmUWJ8HBKO9P
	 eBH3H93mNqU/w==
Message-ID: <e9e0affd-683d-418b-9618-4b1a69095342@kernel.org>
Date: Wed, 26 Mar 2025 14:54:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>,
 Yuying Ma <yuma@redhat.com>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/03/2025 16.45, Toke Høiland-Jørgensen wrote:
> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
> they are released from the pool, to avoid the overhead of re-mapping the
> pages every time they are used. This causes resource leaks and/or
> crashes when there are pages still outstanding while the device is torn
> down, because page_pool will attempt an unmap through a non-existent DMA
> device on the subsequent page return.
> 
> To fix this, implement a simple tracking of outstanding DMA-mapped pages
> in page pool using an xarray. This was first suggested by Mina[0], and
> turns out to be fairly straight forward: We simply store pointers to
> pages directly in the xarray with xa_alloc() when they are first DMA
> mapped, and remove them from the array on unmap. Then, when a page pool
> is torn down, it can simply walk the xarray and unmap all pages still
> present there before returning, which also allows us to get rid of the
> get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
> synchronisation is needed, as a page will only ever be unmapped once.
> 
> To avoid having to walk the entire xarray on unmap to find the page
> reference, we stash the ID assigned by xa_alloc() into the page
> structure itself, using the upper bits of the pp_magic field. This
> requires a couple of defines to avoid conflicting with the
> POINTER_POISON_DELTA define, but this is all evaluated at compile-time,
> so does not affect run-time performance. The bitmap calculations in this
> patch gives the following number of bits for different architectures:
> 
> - 23 bits on 32-bit architectures
> - 21 bits on PPC64 (because of the definition of ILLEGAL_POINTER_VALUE)
> - 32 bits on other 64-bit architectures
> 
> Stashing a value into the unused bits of pp_magic does have the effect
> that it can make the value stored there lie outside the unmappable
> range (as governed by the mmap_min_addr sysctl), for architectures that
> don't define ILLEGAL_POINTER_VALUE. This means that if one of the
> pointers that is aliased to the pp_magic field (such as page->lru.next)
> is dereferenced while the page is owned by page_pool, that could lead to
> a dereference into userspace, which is a security concern. The risk of
> this is mitigated by the fact that (a) we always clear pp_magic before
> releasing a page from page_pool, and (b) this would need a
> use-after-free bug for struct page, which can have many other risks
> since page->lru.next is used as a generic list pointer in multiple
> places in the kernel. As such, with this patch we take the position that
> this risk is negligible in practice. For more discussion, see[1].
> 
> Since all the tracking added in this patch is performed on DMA
> map/unmap, no additional code is needed in the fast path, meaning the
> performance overhead of this tracking is negligible there. A
> micro-benchmark shows that the total overhead of the tracking itself is
> about 400 ns (39 cycles(tsc) 395.218 ns; sum for both map and unmap[2]).
> Since this cost is only paid on DMA map and unmap, it seems like an
> acceptable cost to fix the late unmap issue. Further optimisation can
> narrow the cases where this cost is paid (for instance by eliding the
> tracking when DMA map/unmap is a no-op).
> 
> The extra memory needed to track the pages is neatly encapsulated inside
> xarray, which uses the 'struct xa_node' structure to track items. This
> structure is 576 bytes long, with slots for 64 items, meaning that a
> full node occurs only 9 bytes of overhead per slot it tracks (in
> practice, it probably won't be this efficient, but in any case it should
> be an acceptable overhead).
> 
> [0]https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
> [1]https://lore.kernel.org/r/20250320023202.GA25514@openwall.com
> [2]https://lore.kernel.org/r/ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com
> 
> Reported-by: Yonglong Liu<liuyonglong@huawei.com>
> Closes:https://lore.kernel.org/r/8743264a-9700-4227-a556-5f931c720211@huawei.com
> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
> Suggested-by: Mina Almasry<almasrymina@google.com>
> Reviewed-by: Mina Almasry<almasrymina@google.com>
> Reviewed-by: Jesper Dangaard Brouer<hawk@kernel.org>
> Tested-by: Jesper Dangaard Brouer<hawk@kernel.org>
> Tested-by: Qiuling Ren<qren@redhat.com>
> Tested-by: Yuying Ma<yuma@redhat.com>
> Tested-by: Yonglong Liu<liuyonglong@huawei.com>
> Signed-off-by: Toke Høiland-Jørgensen<toke@redhat.com>
> ---
>   include/linux/poison.h        |  4 +++
>   include/net/page_pool/types.h | 49 +++++++++++++++++++++++---
>   net/core/netmem_priv.h        | 28 ++++++++++++++-
>   net/core/page_pool.c          | 82 ++++++++++++++++++++++++++++++++++++-------
>   4 files changed, 145 insertions(+), 18 deletions(-)


Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


