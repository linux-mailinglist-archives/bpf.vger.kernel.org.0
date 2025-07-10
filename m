Return-Path: <bpf+bounces-62901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA00EAFFCBE
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C293A77D6
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9A28CF4C;
	Thu, 10 Jul 2025 08:47:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D1156F4A;
	Thu, 10 Jul 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137249; cv=none; b=UM60QQqoEsIvSWQVS6k7WQJZwKAhFSTQsKx2ZR1RfEI9DUoB2XG1qP/H5Oz9E6Jq4kZBmakHsBwzcl+duuPgAU1HMfPhBCePenIFzh1nkEG6gULtYVlH8cvScqzhHsgqkxxWgd0JEnYaoAphcPPBApfM8dAg30PyMQiAYcWebds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137249; c=relaxed/simple;
	bh=ekuLnQdZp5hBMg0GrYtuko9ZZ1jvyVh9UAP2a1KyHk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiYfK5hpNSbnoA50EiacBpUJUiRL7AvOz5YKwtCMSpgYjoo+vhWa3hTSbHY05lTTOO5qsIVEMWArFvPESwxSndFkVI4PCY3T0m9CxAT/a/2w5q2803VZheUco7U2s3E4a/navcg6k9bqdiE8YnppxPqMeV4gArniSWnNSxKngo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-30-686f7e191331
Date: Thu, 10 Jul 2025 17:47:16 +0900
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
	vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
	jackmanb@google.com
Subject: Re: [PATCH net-next v9 0/8] Split netmem from struct page
Message-ID: <20250710084716.GA36026@system.software.com>
References: <20250710082807.27402-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710082807.27402-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHefa8e/e6Wr1OsyfrS6sIDLOrnCC6GNVTEAlFZNFl5UvvaJuy
	eS0qK0Wbl0qDai6aROYNVkvm7GI1zbQLyUpbFy9oFlFprbQtQ3NG1Lcf5/zP75wPh8PKs9Jw
	TqNPEgx6tVbFyhn55/ElkeGHE8R53m4ZWGxVLFT60uBKl1MKlgoHgu/+1zL41vCAhUslgxgs
	TzMZGLD9xNDbODpQad8AnaXvGLiVXYOh+2QTC/mZQxhu+/tkcMxZJoEWR4EUzvy8jKEmo0sG
	z25YWOioGpHCO1c+A83mcgY6C1ZAozUMBh99QtBgq5HAYN4FForcVhZ6MjsRuOu7GSg+WoDA
	VueRwpBv1FF8v0O2Yiat/9SPaXX5SwmtNbfLqNWeTK+XRVCTx42pveIES+3eQhl903aLpU3n
	hhha6/wmofnH+1j6tfcVQ/vrWllqq25l6GNrgyw2eJt8abyg1aQIhqhlu+XipQEHm+iISTud
	RzNQ7UITCuIIv4j0l/ZK//Lrch8TYIafRWxZdWyAWX428Xj82IQ4LpSPIm2FcSYk5zB/nCWF
	rf6xfAgfQ85/fIEDrOCBjOTeGWMlv5gMtZqYP/Vg0nz+7RhjPoJ4hj9IAk7MTyVXhrkABvHR
	xNlzMJCYxM8gdx0PJIFVhHdyJPeHG/85cwq5V+ZhTiHe/J/V/J/V/M9qRbgCKTX6FJ1ao100
	V0zXa9Lm7k3Q2dHou5Qe+rXdibwtm1yI55BqvKJln15UStUpxnSdCxEOq0IVvq1aUamIV6cf
	EAwJuwzJWsHoQlM5RjVZsWAwNV7J71MnCfsFIVEw/O1KuKDwDCRumRg6fFrescYzkGW8sTqu
	9GZYdZHkSaMmp8mXt6r72brN5Fh586r0JbqNOTsWJoaIjX2pIRPcVcHbc5Mta3vGjQurfbP6
	yPO+7KJi3fDspmuc6C3+cPTQ9Mjs5b73kSV76h+eKNw158vVzf6N06J3Rl3sXOltj+hP2NbQ
	7jKsv9oWq2KMonp+BDYY1b8BtN2KSioDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec97dnYcLk7L6mT1ZWkXITO6+EA3kcIXNRH6UEm3Yx3capu2
	qWhRWFPK1TQ1QeeElWVqwWjaNsOs1LwVFcZq3WZo96vdzGl0mRH17cf/+f/+nx4WK/x0KKvW
	ZYp6naBRMjJalrTMOH/a/nRVlK84Cqz2cwycHcmBM0/cErA2OBF88T+UwueOLgZqTgxjsN7K
	p+GrfRTDs84BKZx1rIX+2uc0tBxyYRgo7mbAnD+G4ZL/vRQOuusoaK/ukcBtZ5EEjo+exuDK
	eyKFOxetDPjO/ZTA8zYzDT2Wehr6i2Kg0zYFhq+/RdBhd1EwfLSagbI+GwOD+f0I+toHaKg6
	UITA3uqVwNjI742qaz5pTDhpf/sBk6b6+xRptjyWEpsjizTWRRCTtw8TR0MhQxyfSqXk0d0W
	hnRXjNGk2f2ZImbje4Z8fPaAJh9aPQypeTlEEXuTh05WpMiW7xA16mxRv2DlNpmq5quTyXDG
	5pQcJXmoeZEJBbE8t5h/WD9CB5jmwnl7QSsTYIabw3u9fmxCLBvCLeDvlm40IRmLOSPDl3r8
	4/1JXCxf+eYeDrCcA/7nkcvjrOCW8GMeE/0nn8j3VD4dZ8xF8N4fr6jAJuam82d+sAEM4pby
	7sG9gcZkbhZ/xdlFHUNyy3+y5T/Z8k+2IdyAQtS6bK2g1iyJNOxS5erUOZHb07UO9Pshavd9
	L3GjL3fi2hDHImWw/HaaTqWQCNmGXG0b4lmsDJGPbNCoFPIdQu4eUZ++VZ+lEQ1taDpLK6fK
	49eL2xRcmpAp7hLFDFH/90qxQaF5aF6YkOG7Wteyr1FaNi1heePqd7BuQpq/3HrdUzb7cFzi
	/lM3FFbn63WJyhWuzKTzrat6LxNivOoI3dyb6sYnC4aaMjpjhVqYGzoj2OxLTXS+KCxbyWmp
	BKPhRHl0QUp2Z9am3VvMvUPJL1Meaft2fpt5YY3rcEkFrQuObrgZH6akDSphYQTWG4RfWB2W
	HAwDAAA=
X-CFilter-Loop: Reflected

On Thu, Jul 10, 2025 at 05:27:59PM +0900, Byungchul Park wrote:
> Hi all,
> 
> The MM subsystem is trying to reduce struct page to a single pointer.
> See the following link for your information:
> 
>    https://kernelnewbies.org/MatthewWilcox/Memdescs/Path
> 
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for page pool.
> 
> Matthew Wilcox tried and stopped the same work, you can see in:
> 
>    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
> 
> I focused on removing the page pool members in struct page this time,
> not moving the allocation code of page pool from net to mm.  It can be
> done later if needed.
> 
> The final patch removing the page pool fields will be posted once all
> the converting of page to netmem are done:
> 
>    1. converting use of the pp fields in struct page in prueth_swdata.
>    2. converting use of the pp fields in struct page in freescale driver.

     3. converting use of the pp fields in strcut page in libeth.

	Byungchul

> For our discussion, I'm sharing what the final patch looks like, in this
> cover letter.
> 
> 	Byungchul
> --8<--
> commit 1847d9890f798456b21ccb27aac7545303048492
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
> index 32ba5126e221..db2fe0d0ebbf 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -120,17 +120,6 @@ struct page {
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
> index 8f354ae7d5c3..3414f184d018 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -42,11 +42,8 @@ struct netmem_desc {
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
> Changes from v8:
> 	1. Rebase on net-next/main as of Jul 10.
> 	2. Exclude non-controversial patches that have already been
> 	   merged to net-next.
> 	3. Re-add the patches that focus on removing accessing the page
> 	   pool fields in struct page.
> 	4. Add utility APIs e.g. casting, to use struct netmem_desc as
> 	   descriptor, to support __netmem_get_pp() that has started to
> 	   be used again e.g. by libeth.
> 
> Changes from v7 (no actual updates):
> 	1. Exclude "netmem: introduce struct netmem_desc mirroring
> 	   struct page" that might be controversial.
> 	2. Exclude "netmem: introduce a netmem API,
> 	   virt_to_head_netmem()" since there are no users.
> 
> Changes from v6 (no actual updates):
> 	1. Rebase on net-next/main as of Jun 25.
> 	2. Supplement a comment describing struct net_iov.
> 	3. Exclude a controversial patch, "page_pool: access ->pp_magic
> 	   through struct netmem_desc in page_pool_page_is_pp()".
> 	4. Exclude "netmem: remove __netmem_get_pp()" since the API
> 	   started to be used again by libeth.
> 
> Changes from v5 (no actual updates):
> 	1. Rebase on net-next/main as of Jun 20.
> 	2. Add given 'Reviewed-by's and 'Acked-by's, thanks to all.
> 	3. Add missing cc's.
> 
> Changes from v4:
> 	1. Add given 'Reviewed-by's, thanks to all.
> 	2. Exclude potentially controversial patches.
> 
> Changes from v3:
> 	1. Relocates ->owner and ->type of net_iov out of netmem_desc
> 	   and make them be net_iov specific.
> 	2. Remove __force when casting struct page to struct netmem_desc.
> 
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
> Byungchul Park (8):
>   netmem: introduce struct netmem_desc mirroring struct page
>   netmem: introduce utility APIs to use struct netmem_desc
>   page_pool: access ->pp_magic through struct netmem_desc in
>     page_pool_page_is_pp()
>   netmem: use netmem_desc instead of page to access ->pp in
>     __netmem_get_pp()
>   netmem: introduce a netmem API, virt_to_head_netmem()
>   mlx4: use netmem descriptor and APIs for page pool
>   netdevsim: use netmem descriptor and APIs for page pool
>   mt76: use netmem descriptor and APIs for page pool
> 
>  drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  48 ++---
>  drivers/net/ethernet/mellanox/mlx4/en_tx.c    |   8 +-
>  drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   4 +-
>  drivers/net/netdevsim/netdev.c                |  19 +-
>  drivers/net/netdevsim/netdevsim.h             |   2 +-
>  drivers/net/wireless/mediatek/mt76/dma.c      |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt76.h     |  12 +-
>  .../net/wireless/mediatek/mt76/sdio_txrx.c    |  24 +--
>  drivers/net/wireless/mediatek/mt76/usb.c      |  10 +-
>  include/linux/mm.h                            |  12 --
>  include/net/netmem.h                          | 183 +++++++++++++++---
>  mm/page_alloc.c                               |   1 +
>  12 files changed, 231 insertions(+), 98 deletions(-)
> 
> 
> base-commit: c65d34296b2252897e37835d6007bbd01b255742
> -- 
> 2.17.1

