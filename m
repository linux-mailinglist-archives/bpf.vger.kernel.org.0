Return-Path: <bpf+bounces-58961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2737AC469B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 04:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EF216C970
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025F19F12A;
	Tue, 27 May 2025 02:51:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0A10A1E;
	Tue, 27 May 2025 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748314261; cv=none; b=n9EdO8IX8BpuJI59wnbAbvmolCo370MerPMEhU/T5bKVBfzFtEPkwfoJT+enxQMxpzi61TSS5KvdN8wwdmjQ7cUxB9RMs+CE4lfAwV+0LXxxBvcjbNCVmMazue8mTwdQ/rOv++OtAPERjqyGgeplLn6nzp49e6roNkSK0HwPgz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748314261; c=relaxed/simple;
	bh=TlIY9JNkwJsKjfJ1swckzIto2KdAGpqj0S9z2joe3mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cma/MnRKKHATHfMmDJAtCMNj4dR13ugXprVCaa2HiCYT8MnV5elLvkYv9whgpSR1d25fBToI8aVcXdK+OpfdYeZB4rWZCR+Xm+B/Dk1Il8L1Mr4QXKKNy1auWYvfbGJ81F2aO3j9z13xrsxsFD5Ec7LEauUkwsFevS7YR/BEmfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-78-6835288c9dc9
Date: Tue, 27 May 2025 11:50:47 +0900
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
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
Message-ID: <20250527025047.GA71538@system.software.com>
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523032609.16334-2-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0zMcRjH97nP97737dZtHyd81ObHmfXDJMSeP8z852sYhugojvvqjuuy
	KymbLWTp1LEydefMYXT92G4uq1CNtOpGuoV2fqQ6lDZER8oVurPGf6+9n/f7/Tx/PByWG8Xh
	nFafIRj0Kp2ClTLST6FXFxdErdDE/SiKBKujioXK0Swo660Tg7WiBsG3sVcS8DW3snD96ggG
	a0cuA98dPzG8b/FKoOdmPwP1ebUYvOfaWCjM9WM4WWcXgbvGJIYLP29gqM3plcDTu1YW3lT9
	FkN/UyEDLks5Az2mNdBimwkjjz4iaHbUimCk4DILxZ02Ft7m9iDofOhl4NIJEwJHo0cM/lEr
	u2Y+f7v8hYi/Y+mW8DbnEb7aHsMbPZ2Yd1bks7xzuEjCv+6qZ/m2Uj/D36nzifjCU59Z/uv7
	lww/1Pic5R23nzP8Y1uzhPc552wmSukqtaDTZgqGJav3SjXVDWfw4fGIrCc+F5ODOsKMKISj
	JJ72vMkXT/HY6yEmwAxZSO2njEFmSST1eMawEXFcGFlCu4oSjUjKYdImpv4rH4LZ6URHrxWP
	B/0yAnSifkAUYDlR0Wp7J/tXn0Zd5ndBDyYx1PNrUBToxCSClv3iAnIIWUkvnh0KRmeQBfR+
	TasosIuSGxytHvZK/t45mz6we5jziFj+q7X8V2v5V2tDuALJtfrMVJVWFx+rydZrs2L3p6U6
	0eSH3Dw+vqsODbu3NiHCIUWozC3Ea+RiVWZ6dmoTohxWhMlqzk9KMrUq+5hgSNtjOKIT0ptQ
	BMcoZsmWjRxVy0mKKkM4JAiHBcPUVMSFhOegna0piu1JLQc3xLcnKfdGyrt2mAz3tMro2ANX
	rqu7yzO2uesTfH0N6tI25eKJEnVJQ+XGuXkDTrv72brEDuXo2tNe/eeSBBfzxZyx7ndUxIR5
	a1SOv31e4vq+xrgz0QbX4HjxIg9+2p+8JXn9QnPCw9Kx3dblt4b3bTLnm/y4Xadg0jWqpTHY
	kK76A1aqNMYdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG+Z9zdnacDY5z5SElYiqKkGZkvFSEX8o/Rlmf0uji1JMbzkub
	d0g0hWqpmYXYmrSSdJowUPOWmszRFCtFuyyzlJVmoFl5SZ1azoj89vC8v9/z6WVIyTS1nVEm
	pfLqJLlKRoso0fED+bsK/UMUu/WWraA31dHwaDETqsdaBKCvbUIwt/ReCLMWKw2V9xdI0PcX
	UDBvWiZh/JldCKNVExS0X2kmwX6jh4aiAgcJl1uMBHRX9ApgoKlYALeXH5LQnDsmhKE2PQ0f
	634LYMJcREGvroaC0eJQeGbYBgt9UwgspmYCFgoraLg1aKDhU8EogsFuOwV384oRmDptAnAs
	6ulQGW6seUfgVt0HITbUp+EGYwDW2gZJXF97jcb1P0uFeORNO417yh0Ubm2ZJXBR/jca/xgf
	pvBM52saV05+J7Cp8TWFnxsswhNup0UH43iVMp1XBx2KFikaOq6SKSuemS9ne6lc1C/VIheG
	Y/dySyMzlDNTrC9nzNduZJr142y2JVKLGEbKBnFvSqO0SMSQbI+Ac9ybFDgZd1bFPbi1ssGL
	WeBW278Qzixh5VyDcZD+27txvXc+bzAkG8DZ1r4Szk2S9eSq1xhn7cLu48quz2yoW1lvrqvJ
	SpQgsW6Trdtk6/7bBkTWIqkyKT1RrlSFBGoSFFlJyszA2OTEerT+BFWXVm62oLmhMDNiGSTb
	Ih7g9yokAnm6JivRjDiGlEnFTSXrlThOnpXNq5PPq9NUvMaMPBlK5iEOP8VHS9h4eSqfwPMp
	vPrflWBctueix2bUdbiyr857R6v7i4y+7tTgBYl1+Ej5Pq9c04HRvhx7QuLqnjPWuldlOcrK
	GMpHkRHRPBn8baer1PXj0ak8vvFXFH4b6nXSYY9VHPPdv4eJvxjRNu9z4eWTMOTfH9MRmc1b
	I8Nlr/YnW0p03tNzHhOFXuIcv3NuvCJFc/b4UxmlUciDA0i1Rv4HlY6vsgADAAA=
X-CFilter-Loop: Reflected

On Fri, May 23, 2025 at 12:25:52PM +0900, Byungchul Park wrote:
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
> 
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, reusing struct net_iov that already mirrored struct page.
> 
> While at it, relocate _pp_mapping_pad to group struct net_iov's fields.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  include/linux/mm_types.h |  2 +-
>  include/net/netmem.h     | 43 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 56d07edd01f9..873e820e1521 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -120,13 +120,13 @@ struct page {
>  			unsigned long private;
>  		};
>  		struct {	/* page_pool used by netstack */
> +			unsigned long _pp_mapping_pad;
>  			/**
>  			 * @pp_magic: magic value to avoid recycling non
>  			 * page_pool allocated pages.
>  			 */
>  			unsigned long pp_magic;
>  			struct page_pool *pp;
> -			unsigned long _pp_mapping_pad;
>  			unsigned long dma_addr;
>  			atomic_long_t pp_ref_count;
>  		};
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 386164fb9c18..08e9d76cdf14 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -31,12 +31,41 @@ enum net_iov_type {
>  };
>  
>  struct net_iov {
> -	enum net_iov_type type;
> -	unsigned long pp_magic;
> -	struct page_pool *pp;
> -	struct net_iov_area *owner;
> -	unsigned long dma_addr;
> -	atomic_long_t pp_ref_count;
> +	/*
> +	 * XXX: Now that struct netmem_desc overlays on struct page,
> +	 * struct_group_tagged() should cover all of them.  However,
> +	 * a separate struct netmem_desc should be declared and embedded,
> +	 * once struct netmem_desc is no longer overlayed but it has its
> +	 * own instance from slab.  The final form should be:
> +	 *
> +	 *    struct netmem_desc {
> +	 *	   unsigned long pp_magic;
> +	 *	   struct page_pool *pp;
> +	 *	   unsigned long dma_addr;
> +	 *	   atomic_long_t pp_ref_count;
> +	 *    };
> +	 *
> +	 *    struct net_iov {
> +	 *	   enum net_iov_type type;
> +	 *	   struct net_iov_area *owner;
> +	 *	   struct netmem_desc;
> +	 *    };
> +	 */
> +	struct_group_tagged(netmem_desc, desc,

So..  For now, this is the best option we can pick.  We can do all that
you told me once struct netmem_desc has it own instance from slab.

Again, it's because the page pool fields (or netmem things) from struct
page will be gone by this series.

Mina, thoughts?

	Byungchul

> +		/*
> +		 * only for struct net_iov
> +		 */
> +		enum net_iov_type type;
> +		struct net_iov_area *owner;
> +
> +		/*
> +		 * actually for struct netmem_desc
> +		 */
> +		unsigned long pp_magic;
> +		struct page_pool *pp;
> +		unsigned long dma_addr;
> +		atomic_long_t pp_ref_count;
> +	);
>  };
>  
>  struct net_iov_area {
> @@ -51,9 +80,9 @@ struct net_iov_area {
>  /* These fields in struct page are used by the page_pool and net stack:
>   *
>   *        struct {
> + *                unsigned long _pp_mapping_pad;
>   *                unsigned long pp_magic;
>   *                struct page_pool *pp;
> - *                unsigned long _pp_mapping_pad;
>   *                unsigned long dma_addr;
>   *                atomic_long_t pp_ref_count;
>   *        };
> -- 
> 2.17.1

