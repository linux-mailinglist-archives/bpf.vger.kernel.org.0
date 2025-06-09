Return-Path: <bpf+bounces-60038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47102AD18B6
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C5C188B259
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 06:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95A28033F;
	Mon,  9 Jun 2025 06:50:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596578F4B;
	Mon,  9 Jun 2025 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749451806; cv=none; b=W5PW1w3o0400sEVDnW4L8M/RicOfe9UrqI2zEf4OhDZvxg88xQIjr+HSFrM870vjMpVdh6zLCqVHTxDQsleR6iDvfXC4wQTw7ngvJWd87g74XC5GclQC4lGR83NrpPkDkmBG6OgrRN6S31jHZJ6t1hrOZtPOR7El0QLIJKUeKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749451806; c=relaxed/simple;
	bh=6yy7uWYBmrpwoqPT7FTXXF937NeAXtOiGTHzyLC+6Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8ALlDrUCkdwhxD1PLGmPflev4TjGBElMOlekfPiHweZieRYbGnCl8ffua7dW8hGYewMRc/hgXde+uSCKsYSuqrAEyUH39xRUZZCYd/QrNyuIMTd06F2I0mRcg/Jcb3ssCjfXT7H+hm54pAda/TxmM5YCrtudljNjINYnX+XHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-5c-6846841883c9
Date: Mon, 9 Jun 2025 15:49:55 +0900
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
	vishal.moola@gmail.com
Subject: Re: [PATCH net-next 0/9] Split netmem from struct page
Message-ID: <20250609064955.GA57249@system.software.com>
References: <20250609043225.77229-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609043225.77229-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe/Ze9joaPK2sJ5XKaVSWmmF1PkgJWb5BRiAU1Qdd+dJGOmPe
	g0Jz3cxLmVHOSRNR5wUWS+fsIjbFaQWJZcxqTbQrmF00M9f1VSK//fifP79zPhyOUpxl/DiN
	Nl3QaVXJSlZGyz7Mrwol+h3q9QMjwWC0NLHQOJUNdUN2BowNNgQT359LYbzLyUJ11SQFxkd6
	Gr5apil43T0sBU/tGxrunG2lYLikh4UivZeCU3azBPpsxQyUTddQ0Jo7JIXHt4wsvGz6zcAb
	RxENvYZ6GjzF0dBtWgyTD0YRdFlaJTBZWMnC5X4TCyN6D4L+zmEaKvKKEVjaXQx4p4xsdCDf
	XD8o4dsMbilvsmbwN80hfIGrn+KtDedZ3vqlVMq/eHqH5XuueWm+zT4u4Yvyx1j+8+tnNP+x
	fYDlLc0DNP/Q1CXlx63L9uADsqgkIVmTKejCtyTK1IXvs465IftTnwvlItu6AuTDERxJ8r7Z
	6QLEzfCYOVGMaRxMci/opSKzeBVxub5TYmURDidPS/cXIBlH4R6GeK+/Y8TOQryVfHsxwoos
	x0Cmhs/N5Aq8kTiemKnZfAHpLX9Fi0zhEOL69V4iOinsT+p+cSL64E1kyJUuNnxxEOmwOSXi
	KoJrONJY3SKdvXgpuWd20RcRNsyxGuZYDf+tJkQ1IIVGm5mi0iRHhqlztJrssMOpKVb09z1q
	T/w4aEdf+uIdCHNIOV+eeHW7WsGoMtNyUhyIcJRykRx7tqkV8iRVznFBl5qgy0gW0hzIn6OV
	S+QbJrOSFPiIKl04KgjHBN2/qYTz8ctF6QGlg7dj78e9jVCXBI5ORDy37Yw57RfUUtHvDZ+4
	cslfNc/XufddXKpzpU+o32lNfka3M253QLawb2ns9q4blp8ng5/EX86PzHM3Ra6+uX9VeVne
	3tKY1KrprOUr1nzV6HZpy4OjDhV3dB5KoKrjK6vbzO6GXQMta71h6tuNdzefCVHSaWpVRAil
	S1P9AUtQ+nQaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+e+cnZ2NVsdpeVCUmIUhpUkqLxUmWfbvghR9EPuiwx3bUKds
	aloUcw4sL8tLUK1ZC8lMhYXKNBGLJakZaZo17zIvVMTMvGTOrFZEfvvxvL/n+fTShOQT6UMr
	VZmcWiVLlVIiUhR7IH8Pq49R7H3j3AomSz0FdSs58HCyhQ+mWiuCxe8jAljo6KSg6v4yAaZe
	PQlLllUCZl44BDBRPUtCW0EzAY7rXRSU6F0E6FpqePC8spsPfVYDH26sPiCgWTspgIFWEwXj
	9T/5MGsrIaHb+IiECUMUvDBvg+Wezwg6LM08WC6upKCi30zBlH4CQf9zBwl38gwILO12PrhW
	TFSUFDc9GuLhJ8YxATY3ZOHGmiBcaO8ncEPtNQo3fC0X4NF3bRTuuuUi8ZOWBR4uyXdSeH5m
	mMRz7YMUrvrwhYctTYMkfmXuEJz2OCc6KOdSldmcOiQyUaQo/nghYwxyvvTZkRZZdxcimmaZ
	MNZZk1iIhDTJ7GC1RXqBmykmkLXbvxNuxYsJYd+VxxciEU0wXXzWde8D3+14MofYb6NTlJvF
	DLArjqt/cgkTztre1hB/cw+2+/Y06WaCCWLt6x957k2C8WUfrtNuFDIR7KQ9021sZQLYZ9ZO
	XikSGzeUjRvKxv9lMyJqkZdSlZ0mU6aGB2tSFLkqZU5wUnpaA/r9AdWX18pa0OLAMRtiaCTd
	JE68eVQh4cuyNblpNsTShNRLzExEKyRiuSz3IqdOT1BnpXIaG/KlSam3+EQclyhhzssyuRSO
	y+DU/648WuijRa9HRure9yaMr0syjogbQ3WXsuYqJKLeIkMrlyc8c9buRCfvls31aK78CJ8O
	wIFRxqTY42ve8dEHns5fEE0l7wzzK981eco2NLw/ZrB9+0t/v8g1w3CIv+vwvuqheXnBZt0W
	7cLSY12Sp6M1IPmeMq7pk0VdSmXvr4rwkMpVjZelpEYhCw0i1BrZL1SNyB39AgAA
X-CFilter-Loop: Reflected

On Mon, Jun 09, 2025 at 01:32:16PM +0900, Byungchul Park wrote:
> Hi all,

I'm so sorry.. I missed to add v5 into the prefix..

	Byungchul

> In this version, I'm posting non-controversial patches first.  I will
> post the rest more carefully later.  In this version, no update has been
> applied except excluding some patches from the previous version.  See
> the changes below.
> 
> --8<---
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
> Byungchul Park (9):
>   netmem: introduce struct netmem_desc mirroring struct page
>   page_pool: rename page_pool_return_page() to page_pool_return_netmem()
>   page_pool: rename __page_pool_release_page_dma() to
>     __page_pool_release_netmem_dma()
>   page_pool: rename __page_pool_alloc_pages_slow() to
>     __page_pool_alloc_netmems_slow()
>   netmem: use _Generic to cover const casting for page_to_netmem()
>   netmem: remove __netmem_get_pp()
>   page_pool: make page_pool_get_dma_addr() just wrap
>     page_pool_get_dma_addr_netmem()
>   netmem: introduce a netmem API, virt_to_head_netmem()
>   page_pool: access ->pp_magic through struct netmem_desc in
>     page_pool_page_is_pp()
> 
>  include/linux/mm.h              |  12 ---
>  include/net/netmem.h            | 138 ++++++++++++++++++++++----------
>  include/net/page_pool/helpers.h |   7 +-
>  mm/page_alloc.c                 |   1 +
>  net/core/page_pool.c            |  36 ++++-----
>  5 files changed, 117 insertions(+), 77 deletions(-)
> 
> 
> base-commit: 90b83efa6701656e02c86e7df2cb1765ea602d07
> -- 
> 2.17.1

