Return-Path: <bpf+bounces-61649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9586AE966E
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 08:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689A71C25AD0
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486D623770A;
	Thu, 26 Jun 2025 06:41:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE522226D18;
	Thu, 26 Jun 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750920093; cv=none; b=XH8eRNZJp+AjmY+1+qUSqFzr/y3UxhbPYG7suP8n30kR4rQ9o20LncNgW2dBG7w2tGJxH8G9mRS9wUsDiGobYxYAfKbJ/TQnAEYH4iqcdBFnZaJFQlB3ufFSMLjJDBcnGfdZ8l/8gPfzKB+k/3SOnpWgTLmnW6ctZlCtEDpa9G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750920093; c=relaxed/simple;
	bh=IBU45ngT/QcLkfOFXGQS3B/xyXruqk6nhJNIpi8dvPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUFMZ+AWwPKNArEn6+LF8vuqeVYK6+VB2to7a6Uu6UJ+UtKY78nvg6RNiF85micRQvOj2jGwxIHu/Dt9eDo+nKtj1sAIHcYisORw9E2aYZP6c4oDLqJvxrm9FMi4LGkokB5xMvyq98ZV+A73NSL5w6CzHLckwLPGK6vK4zqHJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-a7-685ceb94fdf3
Date: Thu, 26 Jun 2025 15:41:19 +0900
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
Subject: Re: [PATCH net-next v7 0/7] Split netmem from struct page
Message-ID: <20250626064119.GB28653@system.software.com>
References: <20250625043350.7939-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625043350.7939-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHefeenXNcTo6zy5sJ1UpCSbtQ9EQR0ZdeKiHqUxeylac2mhqb
	Li0qdUYkbYVJ2VyxCLelwWKFzkir6bxQpBmuZV5q3S8mZYnTqDxW1Lcf/+fP73k+PDxWnZPH
	87qsHNGQpdGrWQWjGIi+lFL2Ybt2YcQ9G+yeqyxUj+SB65lPDvaqGgRfI085GGpqYeHypWEM
	9vZiBr55RjG8ag5zUO1Ng37nawZuHa/FED7VyoKleAxDfeQTB0U+tww6aqxyKButxFBb8IyD
	RzftLPRd/SmH134LA222Kwz0W1dDs2MqDN/7iKDJUyuD4ZMXWDjT6WDhRXE/gs7GMAMVhVYE
	noaQHMZGxh0VgT5u9Vza+HEQ0xtXnshona2Xow5vLr3uTqYloU5MvVUnWOr9UsrRnuAtlraW
	jzG0zjckoxbzJ5Z+ftXN0MGGLpZ6bnQx9L6jidsYu1WxMkPU60yiYcGqnQptqy2A99etyCt6
	E1eA+lJLUBRPhCXEbBmVlyB+gsu/ZksxIySS+nApKzErzCOhUARLlcnCAhIs3VKCFDwWzCwp
	7YowUidOWEPefQ9giZUCEGt1ISexalx5LFj4J48lbedfTvSxkExCP97JJCcWZhDXD16Ko4Sl
	xB42T1SmCHPInZoWmbSLCD6eXPQG5L9Pnk7uukPMaSTY/tPa/tPa/mkdCFchlS7LlKnR6Zek
	avOzdHmpu7MzvWj8XZyHv2/zoS8dm/1I4JE6WnktuE2rkmtMxvxMPyI8Vk9Wnl22VatSZmjy
	D4qG7HRDrl40+tEMnlFPUy4ePpChEvZqcsR9orhfNPydyvio+AK0PCFlE00yPcxACYH7Nv1u
	xUB9M26c+2h7yqSA/tpeZ3fHoaPsnqePBwaNqvai+auc1tMxb6uIv/3iurS1ceu3mNe4Zz+4
	/N6UGMs3BWNcR27vmll/4Vt58t2Xn4dyK2/2eNN9Y2V0lsU10JvUEJvp9D3fsGHjDt3OhKQp
	qPt4hUvNGLWaRcnYYNT8AtbzIgcqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z//2dlxtDpNrYN+m4xASCsq3zDCiuoQFH5IowvU0lMbzgtb
	iUbJ5jRLcplZ2pywiqy0Wi2bM7yE5mVaGIprrdxkpd0sS81aC8tJUd8envf3/D69NJb4yQha
	mXGYV2fIVVJKRIq2x+uXln/Yq1jWE5gPJstNCuq+58C1YbsATLU2BFP+F0KYfNRFwZVL0xhM
	fQUkfLX8wDDS6RNCnXUbeGtGSWgqasDgO9NNQUlBAEOz/5MQ8u3XCWivdgjgqc0ggPIfVzE0
	aIeFMPDARIHn5i8BjLaVkOAw3iDBa0iATvMimO4dQ/DI0kDA9OlqCs71myl4VeBF0N/uI6FK
	Z0BgaXEJIPB91lHV4REmyLj2sXHM1d94TnCNxiEhZ7Ye4e5dj+aKXf2Ys9aeojjrRJmQe+ls
	orjuygDJNdonCa5E/4nivoy4SW68ZZDirrz9THCW+kEyUbJbtDaVVymzeXXsuv0iRbexA2c1
	xufkvwnVIk9MMaJpllnJVk5lFqMQmmRkbLOvjApmilnCulx+HETCmFjWWbarGIlozOgptmzQ
	TwaZUGYD++5nBw5mMQOsoU4nDGbJrLLQqfvTL2QdF1/P8ZiJZl0z74igEzOR7LUZOliHMKtY
	k08/h4QzUexDWxdRisTG/9bG/9bGf2szwrUoTJmRnS5XqlbFaNIUuRnKnJiUzHQrmn2ImuM/
	z9rR1MCWNsTQSDpPfMe5RyERyLM1ueltiKWxNEx8IW63QiJOlece5dWZ+9RHVLymDUXSpHSx
	eOtOfr+EOSQ/zKfxfBav/nsl6JAILUqoQaXvN3n7+mxJ90NjI+/nKZ1g92xMlqwYV3oLK2S3
	n8WnHLLkB9yOAV0aHpyYCe/9eH7NpsQoxb6i1rxYWUtqlv0EDLWOxHh5jXRsJT5z98CKx3fX
	h95DrLop9+OxWxtkcSdH3dRRg64nuSJi4UHtgs2rd+StT3J/e5J4eY+U1Cjky6OxWiP/DaLH
	RgQMAwAA
X-CFilter-Loop: Reflected

On Wed, Jun 25, 2025 at 01:33:43PM +0900, Byungchul Park wrote:
> Hi all,
> 
> In this version, I'm posting non-controversial patches first since there

To Jakub and net folks,

I believe v7 doesn't include any controversial patches.  It'd be
appreciated to lemme know if any.

	Byungchul

> are pending works that should be based on this series so that those can
> be started shortly.  I will post the rest later.
> 
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
>    3. converting of prueth_swdata.
>    4. converting of freescale driver.
> 
> For our discussion, I'm sharing what the final patch looks like the
> following.
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
> Changes from v5 (no actual updates):
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
> Byungchul Park (7):
>   netmem: introduce struct netmem_desc mirroring struct page
>   page_pool: rename page_pool_return_page() to page_pool_return_netmem()
>   page_pool: rename __page_pool_release_page_dma() to
>     __page_pool_release_netmem_dma()
>   page_pool: rename __page_pool_alloc_pages_slow() to
>     __page_pool_alloc_netmems_slow()
>   netmem: use _Generic to cover const casting for page_to_netmem()
>   page_pool: make page_pool_get_dma_addr() just wrap
>     page_pool_get_dma_addr_netmem()
>   netmem: introduce a netmem API, virt_to_head_netmem()
> 
>  include/net/netmem.h            | 130 ++++++++++++++++++++++++++------
>  include/net/page_pool/helpers.h |   7 +-
>  net/core/page_pool.c            |  36 ++++-----
>  3 files changed, 124 insertions(+), 49 deletions(-)
> 
> 
> base-commit: 8dacfd92dbefee829ca555a860e86108fdd1d55b
> -- 
> 2.17.1

