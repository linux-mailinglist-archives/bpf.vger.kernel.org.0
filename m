Return-Path: <bpf+bounces-59255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BECAAC7675
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 05:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2949E3D7D
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 03:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63013248869;
	Thu, 29 May 2025 03:29:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3009D2EAE3;
	Thu, 29 May 2025 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748489357; cv=none; b=fuxz/u3SUQ5SkdlAar2T/yV1xQuKZxsHTVpP5K52IbF7PSgi1T3zyhtGJ7oqTvVpID2bsX7olMJAhtBRGu+gKnV1BLbTYcGPY6EnVKrQlUbWbsdDLLA08tpi/whXdanxXXv5PbdIUnsfukQHl580ptGFPyu9RgF8mRMtM+GjGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748489357; c=relaxed/simple;
	bh=IUxEdRG+ZYpiSQ6ECtVtnjnubZIa5EDRVhpJpvsRhsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkGEG8tXKf+b9wmPUh7KONQc/nGcdgOD1aTOBOekX25MabX32lKdPrSVH6IQYNiypwAzwbtxRdsVOBMyq/UQJCfimq/QjtuEYWrgoCeN8FS2n706QjYUfZIbNa8x/TfQmm/by1kuLj1WcLJC7FWgqT6zusWy4mRLxNJN03QauH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-22-6837d484f185
Date: Thu, 29 May 2025 12:29:03 +0900
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
	david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	vishal.moola@gmail.com, anthony.l.nguyen@intel.com
Subject: Re: [RFC v3 00/18] Split netmem from struct page
Message-ID: <20250529032903.GA14480@system.software.com>
References: <20250529031047.7587-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529031047.7587-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe+69u7sbrm7L6ikhZRGBkGYveqIy6dNDFAT5xYpq5K2N5hxb
	vkUvthRp+JaV1DSaSU5nsbLS+ZKoiRkWybKxzFJ0aoYW5QtTy3ITqW8/zvmf3zkfDkfL80Rr
	ObX2rKDXKjUKVspIxwJKNmV2Rak2192kodj+gIVKbypY+xwiqO/0UlBsq0YwMf1RDOOtL1ko
	LZmaj73NYGDSPkPDYFu/GHrLhhhoyKqhoT+vnYWcjFkajI5yCjqrc0VwY+Y+DTXpfWJ4V1fM
	wucHf0Qw1JLDwCtzBQO9uTHQZlkFUx2jCFrtNRRMZd9h4brTwsJARi8C54t+Boou5yKwN7pF
	MOstZmMU5GnFB4rUmj+JiaUqiTwpDyWlDSMUMbmdNKmyXWVJ1c8CMelxNbCk/dYsQ2od4xTJ
	ufKNJT8GuxnyvfE9S+xP3zPktaVVfHD5YemueEGjThb04dEnpKohr0SXFZ360OFi0tG1zSYk
	4TC/DZdnD4gX2ftpgPIxw2/Ao4WZIh+z/Ebsdk/TJsRxgXw4dhXEmZCUo3mPCM+W5PnzK/gd
	uK2jlPGxjAdcb/von5XPO2+bmtmF+nL86rbHn6H5UOyeG6F8TpoPwtY5zleW8Ntx4ZNCv3Il
	vx43Vb+kfLswX8Fha+Y4vXDnGtxc7mbyEW/+T2v+T2v+p7Ug2obkam1yglKt2RamStOqU8NO
	JiZUofk3Kbvw64gD/ew81IJ4DikCZO0oSiUXKZMNaQktCHO0IlBm3BOpksvilWnnBH3icX2S
	RjC0oCCOUayWbZlKiZfzp5VnhTOCoBP0i12Kk6xNR/at+c92zTSfKoi0DW+/99hl6HZOxkYt
	K6T2hBgfvQlRXtz/+Nu6YKcnE+2tfNu2z9MUf6LU9Mh6aVVKcFyArmly6SHPkt13a4ICuw/Q
	2pDa52O6iiid5zyZ6fh6tKtLUlQ3atlSORrxpWdlNHVwhebWcOyx39Rk0vRE7M4Nv40lcQrG
	oFJGhNJ6g/IvoUnNhCIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z/bjqPR6eTlVBQ0SUNSE1JfKewGebogfirKDzny1IZzxqai
	RWW6MFfOtJRaKyaHvKWspuimpjXNFD8kK8e6mGYqBXa1ZLqwmhH57eF5n9/v00vj7FdiNa3S
	ZAtajUItp6SENHlrUaT+ebxyc4klDMzWRgruevOgdsxOQseQFwNzQyuC73OvJDDT+4QCsXoW
	B/NTPQE/rPM4TPaNS2C0ZoqAzuI2HMbL+iko1ftwKLTXYdBza4CEoVYjCdfm7+DQVjAmgWft
	ZgreNP4iYcpZSsCAqZ6AUeMO6LMEw+zgNIJeaxsGs5dvUXDVZaHgnX4UgatnnICb540IrF0e
	EnxeM7UjlG+pf4HxDtOIhLfYcvjmughe7PyA8QaPC+dtDSUUb/tWIeFfuzspvv+6j+Ad9hmM
	Ly36RPFfJ18S/OeuYYoX33/BeGvLMJHCHpFuSxfUqlxBG52YJlVOeQNOFifmNdndRAEq32xA
	ATTHbOG8I+8wfyaYDdx01QXSnykmnPN45nADoulAJppzVxw2ICmNMxMk56suW9yvZBK4vkGR
	8GcZA1xHw6tFlv3jvGF4RP3tV3ADNyYWNzgTwXkWPmB+J86s4WoXaH8dwMRyVc1Vi8ogJpR7
	2PoEu4JkpiW0aQlt+k9bEN6AAlWa3EyFSh0bpctQ5mtUeVHHsjJt6M8j1Jz5WW5H358lORFD
	I/kyWT+KV7KkIleXn+lEHI3LA2WF2+OUrCxdkX9K0GYd1eaoBZ0TraEJeYhs3yEhjWVOKLKF
	DEE4KWj/XTE6YHUBaqspJoMrTWRL4WT3rjJj7/paR0/Squ79Ce6DJZc2Kefikitz0bqsj6LD
	1/S2/YoYnJlq/DLOLZ8udzcmRKqGo00zEzEHXGd3W1ins+ucZPvCvdIHUclYkHlCpggpOC2G
	58XtvH1RLx6nwjam9p6P2buWTdo7G5gSkvj49P09LjmhUypiInCtTvEbooWcCQQDAAA=
X-CFilter-Loop: Reflected

On Thu, May 29, 2025 at 12:10:29PM +0900, Byungchul Park wrote:
> The MM subsystem is trying to reduce struct page to a single pointer.
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for netmem which is used for page pools.
> 
> Matthew Wilcox tried and stopped the same work, you can see in:
> 
>    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
> 
> Mina Almasry already has done a lot fo prerequisite works by luck, he
> said :).  I stacked my patches on the top of his work e.i. netmem.
> 
> I focused on removing the page pool members in struct page this time,
> not moving the allocation code of page pool from net to mm.  It can be
> done later if needed.
> 
> The final patch removing the page pool fields will be submitted once
> all the converting work of page to netmem are done:
> 
>    1. converting of libeth_fqe by Tony Nguyen.
>    2. converting of mlx5 by Tariq Toukan.

+cc Tony Nguyen
+cc Tariq Toukan

	Byungchul

>    3. converting of prueth_swdata (on me).
>    4. converting of freescale driver (on me).
> 
> For our discussion, I'm sharing what the final patch looks like the
> following.
> 
> 	Byungchul
> --8<--
> commit 86be39ea488df859cff6bc398a364f1dc486f2f9
> Author: Byungchul Park <byungchul@sk.com>
> Date:   Wed May 28 20:44:55 2025 +0900
> 
>     mm, netmem: remove the page pool members in struct page
>     
>     Now that all the users of the page pool members in struct page have been
>     gone, the members can be removed from struct page.
>     
>     However, since struct netmem_desc still uses the space in struct page,
>     the important offsets should be checked properly, until struct
>     netmem_desc has its own instance from slab.
>     
>     Remove the page pool members in struct page and modify static checkers
>     for the offsets.
>     
>     Signed-off-by: Byungchul Park <byungchul@sk.com>
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 56d07edd01f9..5a7864eb9d76 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -119,17 +119,6 @@ struct page {
>  			 */
>  			unsigned long private;
>  		};
> -		struct {	/* page_pool used by netstack */
> -			/**
> -			 * @pp_magic: magic value to avoid recycling non
> -			 * page_pool allocated pages.
> -			 */
> -			unsigned long pp_magic;
> -			struct page_pool *pp;
> -			unsigned long _pp_mapping_pad;
> -			unsigned long dma_addr;
> -			atomic_long_t pp_ref_count;
> -		};
>  		struct {	/* Tail pages of compound page */
>  			unsigned long compound_head;	/* Bit zero is set */
>  		};
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 9e4ed3530788..e88e299dd0f0 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -39,11 +39,8 @@ struct netmem_desc {
>  	static_assert(offsetof(struct page, pg) == \
>  		      offsetof(struct netmem_desc, desc))
>  NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
> -NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
> -NETMEM_DESC_ASSERT_OFFSET(pp, pp);
> -NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
> -NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
> -NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> +NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic);
> +NETMEM_DESC_ASSERT_OFFSET(mapping, _pp_mapping_pad);
>  #undef NETMEM_DESC_ASSERT_OFFSET
>  
>  /*
> ---
> Changes from v2:
> 	1. Introduce a netmem API, virt_to_head_netmem(), and use it
> 	   when it's needed.
> 	2. Introduce struct netmem_desc as a new struct and union'ed
> 	   with the existing fields in struct net_iov.
> 	3. Make page_pool_page_is_pp() access ->pp_magic through struct
> 	   netmem_desc instead of struct page.
> 	4. Move netmem alloc APIs from include/net/netmem.h to
> 	   net/core/netmem_priv.h.
> 	5. Apply trivial feedbacks, thanks to Mina, Pavel, and Toke.
> 	6. Add given 'Reviewed-by's, thanks to Mina.
> 
> Changes from v1:
> 	1. Rebase on net-next's main as of May 26.
> 	2. Check checkpatch.pl, feedbacked by SJ Park.
> 	3. Add converting of page to netmem in mt76.
> 	4. Revert 'mlx5: use netmem descriptor and APIs for page pool'
> 	   since it's on-going by Tariq Toukan.  I will wait for his
> 	   work to be done.
> 	5. Revert 'page_pool: use netmem APIs to access page->pp_magic
> 	   in page_pool_page_is_pp()' since we need more discussion.
> 	6. Revert 'mm, netmem: remove the page pool members in struct
> 	   page' since there are some prerequisite works to remove the
> 	   page pool fields from struct page.  I can submit this patch
> 	   separatedly later.
> 	7. Cancel relocating a page pool member in struct page.
> 	8. Modify static assert for offests and size of struct
> 	   netmem_desc.
> 
> Changes from rfc:
> 	1. Rebase on net-next's main branch.
> 	   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
> 	2. Fix a build error reported by kernel test robot.
> 	   https://lore.kernel.org/all/202505100932.uzAMBW1y-lkp@intel.com/
> 	3. Add given 'Reviewed-by's, thanks to Mina and Ilias.
> 	4. Do static_assert() on the size of struct netmem_desc instead
> 	   of placing place-holder in struct page, feedbacked by
> 	   Matthew.
> 	5. Do struct_group_tagged(netmem_desc) on struct net_iov instead
> 	   of wholly renaming it to strcut netmem_desc, feedbacked by
> 	   Mina and Pavel.
> 
> Byungchul Park (18):
>   netmem: introduce struct netmem_desc mirroring struct page
>   netmem: introduce netmem alloc APIs to wrap page alloc APIs
>   page_pool: use netmem alloc/put APIs in __page_pool_alloc_page_order()
>   page_pool: rename __page_pool_alloc_page_order() to
>     __page_pool_alloc_netmem_order()
>   page_pool: use netmem alloc/put APIs in __page_pool_alloc_pages_slow()
>   page_pool: rename page_pool_return_page() to page_pool_return_netmem()
>   page_pool: use netmem put API in page_pool_return_netmem()
>   page_pool: rename __page_pool_release_page_dma() to
>     __page_pool_release_netmem_dma()
>   page_pool: rename __page_pool_put_page() to __page_pool_put_netmem()
>   page_pool: rename __page_pool_alloc_pages_slow() to
>     __page_pool_alloc_netmems_slow()
>   mlx4: use netmem descriptor and APIs for page pool
>   netmem: use _Generic to cover const casting for page_to_netmem()
>   netmem: remove __netmem_get_pp()
>   page_pool: make page_pool_get_dma_addr() just wrap
>     page_pool_get_dma_addr_netmem()
>   netdevsim: use netmem descriptor and APIs for page pool
>   netmem: introduce a netmem API, virt_to_head_netmem()
>   mt76: use netmem descriptor and APIs for page pool
>   page_pool: access ->pp_magic through struct netmem_desc in
>     page_pool_page_is_pp()
> 
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  48 +++---
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
>  drivers/net/netdevsim/netdev.c                |  19 +--
>  drivers/net/netdevsim/netdevsim.h             |   2 +-
>  drivers/net/wireless/mediatek/mt76/dma.c      |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
>  .../net/wireless/mediatek/mt76/sdio_txrx.c    |  24 +--
>  drivers/net/wireless/mediatek/mt76/usb.c      |  10 +-
>  include/linux/mm.h                            |  12 --
>  include/net/netmem.h                          | 145 +++++++++++++-----
>  include/net/page_pool/helpers.h               |   7 +-
>  mm/page_alloc.c                               |   1 +
>  net/core/netmem_priv.h                        |  14 ++
>  net/core/page_pool.c                          | 101 ++++++------
>  15 files changed, 239 insertions(+), 174 deletions(-)
> 
> 
> base-commit: d09a8a4ab57849d0401d7c0bc6583e367984d9f7
> -- 
> 2.17.1

