Return-Path: <bpf+bounces-59630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E262ACD678
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 05:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FBF1896EFB
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 03:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A51D238C29;
	Wed,  4 Jun 2025 03:23:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D17E1;
	Wed,  4 Jun 2025 03:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749007413; cv=none; b=OJDeGAWmxO04vXUBS2FxrIknMycqTJ0APFTdoeP8w7xFaUU+bZOG+daiQrxMjjVWc9M+4IMzc44dMO/0Dz6I+dtrtFtHC4UIoC4hBeTLHNNwif/olDifFXYKGaHNgLd3aVqarQikrzYMAbG518G5l9V6PE9JBsgBVKAqo8w8u0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749007413; c=relaxed/simple;
	bh=VuNxcj9d9+s7yVMInqnZZpWYjMWYL/VKjmzqcWnNJ54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZoWpmo1xzEt1YAtf0zmzIyMs4Dq2pqHdN8y1sZqfCIQ9hsWSqNybT0ece2/HvrapCmol/b3kL19W5pfg0QRzYO7cfNf8VXyYdEP4Ri/E1zypahURncgxTWAcrmlZl+Y1qf09YEwC0QYqGjnXMtaA6o1Dyxei8qrhiZFwjrMXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-15-683fbc2c3792
Date: Wed, 4 Jun 2025 12:23:19 +0900
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org, almasrymina@google.com
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
	vishal.moola@gmail.com, netdev@vger.kernel.org
Subject: Re: [RFC v4 00/18] Split netmem from struct page
Message-ID: <20250604032319.GA69870@system.software.com>
References: <20250604025246.61616-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604025246.61616-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUiTcRjH++099jocvS6zX4lGK6isPMrqETokSl6h6KJ/CrORb201p808
	1rlKOrTpMOlYszZCnUcMlukKtTLzKKWwzFVeLRXEskMbHl1uIfXfh+/D9/M8fzwMIcmkZjEK
	1WFerZIppbSIFH3yNi9ZXLlWHlqmCwajtZSGkpE0KOy2U2AsLkcwPPpOCEO19TTcMrsIMD5P
	J+G7dYyA3jqnELoK+kioPFdBgDO7gQZd+jgBp+0WAbwoz6IgdyyfgApttxBe3jfS0Fn6m4K+
	Gh0JjYYiErqyIqHO5AeuZx8R1ForBOC6mEfDpRYTDR/SuxC0PHaScP1UFgJrtYOC8REjHTmH
	Kyt6I+DuGTqEnMmWzN2xBHEZjhaCsxVfoDnbtxwh1/66kuYaro6T3D37kIDTnRmkua+9b0nu
	c3UrzVnLWkmuyVQr5IZsgVvYnaJVcbxSkcKrQ9bsEcn1+T1Eon5dWmbVA6RFt5dlIC8Gs+F4
	oMkomOQGs0HoZpKdh0eedHqYZudjh2OUcLMvG4Kr2yqoDCRiCLabwoPvsz3laWwEbi657SmI
	WcCXLY9JN0vY5Vhnf0X8zX1w47UeT06wQdjxq3+iy0ywPy78xbhjL3YFbh+84lFOZ+fih+X1
	AvcuzJoZ3Do8Sv49dCZ+ZHGQesQa/tMa/tMa/mlNiChGEoUqJV6mUIYHyzUqRVrw3oR4G5p4
	kYLjP3bZ0bcX22sQyyCpt9jevkYuoWQpSZr4GoQZQuornr1wIhLHyTRHeHVCrDpZySfVIH+G
	lM4QL3WlxknY/bLD/EGeT+TVk1MB4zVLixITHvlMDcDzNTNSi6JiT4sX/Gx+qu+YHdEQ8PCs
	yvv+/hupX0+GmfFN17J921QLf8TfKt+64+2UPOX6mE3tfcfuLv3CR+ufDyQHFJxgtIUbzX6b
	PwaiGGeTvKqnLSgiO6KNOpoqCc05/qFk5fCG6POH0lZHhdX27y78XNB6alGuZsMBKZkkl4UF
	Eeok2R8yzLENHgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRiH+e+cnR1Xg9NcelAkOAaWWRpmvFlpRNC/iIooAiNy5GEbXtnU
	NCm0DGnltcxaE2aRdxktcbPMapqX7OK1lpmaaVTUMp1DUzRnRH17eH4876eXJqR20otWxSXy
	6jh5DEeJSfH+refXBzSEK4M+NvqA3lhNQdV0CpQNW4Sgr6xD4Jh5J4LJ5lYKbpc4CdC/yiRh
	yviLgLGWEREMlX4ioSHLTMBIbhsF2ZmzBJyzlAugqbhdCJ11OUK4+usOAeb0YRH03NdTMFi9
	IIRP1mwS2nUVJAzl7IAWgwc4O74haDaaBeC8XEzBlW4DBR8zhxB0N42QcDMjB4Gx0SaE2Wk9
	tYPDtRVvBbhe916EDaYkfK/cH2tt3QQ2VV6ksGmiQIQHXjdQuO36LInrLZMCnH3eTuGfY/0k
	/tHYR+Hbn8cF2FjbR+LnhmbRwRUR4m1RfIwqmVcHhkWKlXl3RomEvJ0plx4+QumoJliL3GiW
	2cS2lehELiaZ1ez008Elphg/1mabIVwsYwLZxjdmoRaJaYIZFrL2D7kC1+DObGFfVNUsBRIG
	2GvlTaSLpUwIm23pJf74FWz7jdElTzD+rG3+y2JLL7I3WzZPu7Qbs5kdsBctnVzJ+LKP61oF
	eUii+6/W/Vfr/tUGRFQimSouOVauignZoIlWpsapUjacjI81ocUvKD0zl29Bjp7dVsTQiFsu
	sQyEKaVCebImNdaKWJrgZJJVaxeVJEqeeppXx59QJ8XwGivypknOU7L3KB8pZRTyRD6a5xN4
	9d9VQLt5paPDoZhTdnEZt56kKS6UyFB/cE2ls8dj7G6H8sGyToO72aEN6U/z23dItFUb4BPg
	satw4sAxdsF3WGrcnv/iZUFCaFBRzdlnvPa4vbCgbLQjr0W6rE2lDFqXRZwyO444tZ6lU/fD
	FWsUEQPcnEnV2zk2/n1kMHDPUF+U19fyjV0cqVHKN/oTao38N/hqM/gBAwAA
X-CFilter-Loop: Reflected

On Wed, Jun 04, 2025 at 11:52:28AM +0900, Byungchul Park wrote:
> The MM subsystem is trying to reduce struct page to a single pointer.
> The first step towards that is splitting struct page by its individual
> users, as has already been done with folio and slab.  This patchset does
> that for netmem which is used for page pools.
> 
> Matthew Wilcox tried and stopped the same work, you can see in:
> 
>    https://lore.kernel.org/linux-mm/20230111042214.907030-1-willy@infradead.org/
> 
> Mina Almasry already has done a lot fo prerequisite works by luck.  I
> stacked my patches on the top of his work e.i. netmem.
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
>    3. converting of prueth_swdata (on me).
>    4. converting of freescale driver (on me).
> 
> For our discussion, I'm sharing what the final patch looks like the
> following.

To Willy and Mina,

I believe this version might be the final version.  Please check the
direction if it's going as you meant so as to go ahead convinced.

As I mentioned above, the final patch should be submitted later once all
the required works on drivers are done, but you can check what it looks
like, in the following embedded patch in this cover letter.

	Byungchul

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
>  include/net/netmem.h                          | 138 ++++++++++++------
>  include/net/page_pool/helpers.h               |   7 +-
>  mm/page_alloc.c                               |   1 +
>  net/core/netmem_priv.h                        |  14 ++
>  net/core/page_pool.c                          | 103 ++++++-------
>  15 files changed, 234 insertions(+), 174 deletions(-)
> 
> 
> base-commit: 90b83efa6701656e02c86e7df2cb1765ea602d07
> -- 
> 2.17.1

