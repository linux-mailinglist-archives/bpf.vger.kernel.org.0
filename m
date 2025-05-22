Return-Path: <bpf+bounces-58794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E5AC18AA
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 01:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE49A239B4
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 23:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501A42D1916;
	Thu, 22 May 2025 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+XB2kSh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729924DD1C;
	Thu, 22 May 2025 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958073; cv=none; b=UKvXxNRPqtL/O1aBU8B0aqXLz/lvz0funMHb80jZ3FzQVK2cQSTbp3KZ3IEMTWLdta2iz/l8LllAASOOZs/31fEdjkazrRbuAQdXf5XpyQOChVF/P7EcymWfzzUq+KV+ivKNF0JzgmhcNoMlFcIJta0tG9B7hOfvDkB3AoIh8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958073; c=relaxed/simple;
	bh=0r8VEa0kyQbiFc7N9DL94OOBDkT2qS+X9TyGqxgSk/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioAD7qODoLOdm2vxSu5eLIecuZr7LG2efDrkEzC/2P8NWoRI0OXkbb4+nlqsw0bxek+68Bu2sH82a7IeTJxXrmKxXVVl32ZPlKJUdijFAS/T2af3IBIGqQ1HxoPJifdrMJ1sif8hO9zjQucCBCIwG0LOVEvdDAXVtkLUN2P7xOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+XB2kSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6E9C4CEE4;
	Thu, 22 May 2025 23:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747958073;
	bh=0r8VEa0kyQbiFc7N9DL94OOBDkT2qS+X9TyGqxgSk/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+XB2kSh9aG7we3KWuFYfJYcsGq3jKShcl/sRFQZDGZ2eLYddXQjbkmR5Z0ixJ8+9
	 mG17kTVRdm7KsIpGEAM0Nu/a24nMRjM8FeQCyNZOTLS9xp/qB6MV7VL16SGoZmBq8d
	 cRkDhCHXZTO+QB6DswCdyrbZ+friqI8L2E7NGN4PJvbvuqaOAK2BATTE/0SxfWBVQe
	 TfEv0hKA57kusiKRZjN4V8KjhK4hB6Fqa6hJzYY+rBnjfG8iJNXonPmKw0WVrnu6T3
	 JZJJUWTKWfWmKRW1MgQ7Wn0eFYs4CLsvDDj5z4k8WxVWw+UeGsujeqN/wzh5OPeYVa
	 9Est2RgQAUR5g==
Date: Thu, 22 May 2025 16:54:31 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 08/11] net/mlx5e: Convert over to netmem
Message-ID: <aC-5N9GuwbP73vV7@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-9-git-send-email-tariqt@nvidia.com>
 <CAHS8izNeKdsys4VCEW5F1gDoK7dPJZ6fAew3700TwmH3=tT_ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNeKdsys4VCEW5F1gDoK7dPJZ6fAew3700TwmH3=tT_ag@mail.gmail.com>

On 22 May 16:18, Mina Almasry wrote:
>On Thu, May 22, 2025 at 2:46 PM Tariq Toukan <tariqt@nvidia.com> wrote:
>>
>> From: Saeed Mahameed <saeedm@nvidia.com>
>>
>> mlx5e_page_frag holds the physical page itself, to naturally support
>> zc page pools, remove physical page reference from mlx5 and replace it
>> with netmem_ref, to avoid internal handling in mlx5 for net_iov backed
>> pages.
>>
>> SHAMPO can issue packets that are not split into header and data. These
>> packets will be dropped if the data part resides in a net_iov as the
>> driver can't read into this area.
>>
>> No performance degradation observed.
>>
>> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
>>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 103 ++++++++++--------
>>  2 files changed, 61 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> index c329de1d4f0a..65a73913b9a2 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
>> @@ -553,7 +553,7 @@ struct mlx5e_icosq {
>>  } ____cacheline_aligned_in_smp;
>>
>>  struct mlx5e_frag_page {
>
>omega nit: maybe this should be renamed now to mlx5e_frag_netmem. Up to you.
>
30+ occurrences need changing, Tariq, Cosmin up to you. I agree with the
comment though.

>> -       struct page *page;
>> +       netmem_ref netmem;
>>         u16 frags;
>>  };
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> index e34ef53ebd0e..75e753adedef 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> @@ -273,33 +273,33 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
>>
>>  #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
>>
>> -static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
>> +static int mlx5e_page_alloc_fragmented(struct page_pool *pp,
>>                                        struct mlx5e_frag_page *frag_page)
>>  {
>> -       struct page *page;
>> +       netmem_ref netmem = page_pool_alloc_netmems(pp,
>> +                                                   GFP_ATOMIC | __GFP_NOWARN);
>>
>> -       page = page_pool_dev_alloc_pages(pool);
>> -       if (unlikely(!page))
>> +       if (unlikely(!netmem))
>>                 return -ENOMEM;
>>
>> -       page_pool_fragment_page(page, MLX5E_PAGECNT_BIAS_MAX);
>> +       page_pool_fragment_netmem(netmem, MLX5E_PAGECNT_BIAS_MAX);
>>
>>         *frag_page = (struct mlx5e_frag_page) {
>> -               .page   = page,
>> +               .netmem = netmem,
>>                 .frags  = 0,
>>         };
>>
>>         return 0;
>>  }
>>
>> -static void mlx5e_page_release_fragmented(struct page_pool *pool,
>> +static void mlx5e_page_release_fragmented(struct page_pool *pp,
>>                                           struct mlx5e_frag_page *frag_page)
>>  {
>>         u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
>> -       struct page *page = frag_page->page;
>> +       netmem_ref netmem = frag_page->netmem;
>>
>> -       if (page_pool_unref_page(page, drain_count) == 0)
>> -               page_pool_put_unrefed_page(pool, page, -1, true);
>> +       if (page_pool_unref_netmem(netmem, drain_count) == 0)
>> +               page_pool_put_unrefed_netmem(pp, netmem, -1, true);
>>  }
>>
>>  static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
>> @@ -359,7 +359,7 @@ static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
>>                 frag->flags &= ~BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
>>
>>                 headroom = i == 0 ? rq->buff.headroom : 0;
>> -               addr = page_pool_get_dma_addr(frag->frag_page->page);
>> +               addr = page_pool_get_dma_addr_netmem(frag->frag_page->netmem);
>>                 wqe->data[i].addr = cpu_to_be64(addr + frag->offset + headroom);
>>         }
>>
>> @@ -500,9 +500,10 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
>>                                struct xdp_buff *xdp, struct mlx5e_frag_page *frag_page,
>>                                u32 frag_offset, u32 len)
>>  {
>> +       netmem_ref netmem = frag_page->netmem;
>>         skb_frag_t *frag;
>>
>> -       dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
>> +       dma_addr_t addr = page_pool_get_dma_addr_netmem(netmem);
>>
>>         dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len, rq->buff.map_dir);
>>         if (!xdp_buff_has_frags(xdp)) {
>> @@ -515,9 +516,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
>>         }
>>
>>         frag = &sinfo->frags[sinfo->nr_frags++];
>> -       skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
>> +       skb_frag_fill_netmem_desc(frag, netmem, frag_offset, len);
>>
>> -       if (page_is_pfmemalloc(frag_page->page))
>> +       if (!netmem_is_net_iov(netmem) && netmem_is_pfmemalloc(netmem))
>
>nit: unnecessary net_iov check AFAICT?
>

yep, redundant.

>>                 xdp_buff_set_frag_pfmemalloc(xdp);
>>         sinfo->xdp_frags_size += len;
>>  }
>> @@ -528,27 +529,29 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
>>                    u32 frag_offset, u32 len,
>>                    unsigned int truesize)
>>  {
>> -       dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
>> +       dma_addr_t addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
>>         u8 next_frag = skb_shinfo(skb)->nr_frags;
>> +       netmem_ref netmem = frag_page->netmem;
>>
>>         dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
>>                                 rq->buff.map_dir);
>>
>> -       if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset)) {
>> +       if (skb_can_coalesce_netmem(skb, next_frag, netmem, frag_offset)) {
>>                 skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
>> -       } else {
>> -               frag_page->frags++;
>> -               skb_add_rx_frag(skb, next_frag, frag_page->page,
>> -                               frag_offset, len, truesize);
>> +               return;
>>         }
>> +
>> +       frag_page->frags++;
>> +       skb_add_rx_frag_netmem(skb, next_frag, netmem,
>> +                              frag_offset, len, truesize);
>>  }
>>
>>  static inline void
>>  mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
>> -                     struct page *page, dma_addr_t addr,
>> +                     netmem_ref netmem, dma_addr_t addr,
>>                       int offset_from, int dma_offset, u32 headlen)
>>  {
>> -       const void *from = page_address(page) + offset_from;
>> +       const void *from = netmem_address(netmem) + offset_from;
>
>I think this needs a check that netmem_address != NULL and safe error
>handling in case it is? If the netmem is unreadable, netmem_address
>will return NULL, and because you add offset_from to it, you can't
>NULL check from as well.
>

Nope, this code path is not for GRO_HW, it is always safe to assume this is
not iov_netmem.

>>         /* Aligning len to sizeof(long) optimizes memcpy performance */
>>         unsigned int len = ALIGN(headlen, sizeof(long));
>>
>> @@ -685,7 +688,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
>>                 if (unlikely(err))
>>                         goto err_unmap;
>>
>> -               addr = page_pool_get_dma_addr(frag_page->page);
>> +               addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
>>
>>                 for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
>>                         header_offset = mlx5e_shampo_hd_offset(index++);
>> @@ -796,7 +799,8 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
>>                 err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
>>                 if (unlikely(err))
>>                         goto err_unmap;
>> -               addr = page_pool_get_dma_addr(frag_page->page);
>> +
>> +               addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
>>                 umr_wqe->inline_mtts[i] = (struct mlx5_mtt) {
>>                         .ptag = cpu_to_be64(addr | MLX5_EN_WR),
>>                 };
>> @@ -1216,7 +1220,7 @@ static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
>>         struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
>>         u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
>>
>> -       return page_address(frag_page->page) + head_offset;
>> +       return netmem_address(frag_page->netmem) + head_offset;
>
>Similar concern here. netmem_address may be NULL, especially when you
>enable unreadable netmem support in the later patches. There are a
>couple of call sites below as well.

This is the header path, so we are good.

We only need to check one location in mlx5, which is the data payload path of
GRO_HW and it's covered.


