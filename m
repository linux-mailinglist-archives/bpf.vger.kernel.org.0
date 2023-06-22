Return-Path: <bpf+bounces-3126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CBF739C3C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 11:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DBD1C21090
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1069D3D61;
	Thu, 22 Jun 2023 09:11:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1771FDF
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:11:14 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1A65FDF
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:11:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f866a3d8e4so7555328e87.0
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brouer-com.20221208.gappssmtp.com; s=20221208; t=1687425063; x=1690017063;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i68QhW4jCBgd/NtsI2qPa46H1bMJZjISzdeu9Mv7K80=;
        b=eXUIsg4HCOoUA0sni5zGY/9riTsJ0Epc64IYMXshP1UJwyTc3JRasP09a8sPoyIbLx
         4Z6U5i26+5lAgJ8zRf38Ifyu44hrNqzFMEFYh3h+9NsgxtlzDqMyIrHIYF0Ykjx7oBNz
         NBYE3adbiVy7n3MRR3WcvaY7CWQFCGmTR/8voXc2phGZBdi77SpzfdE5ECPvuiAwltnu
         zijjpIUgpz/HMI66rlLNqAKm0GerIPN/ptc7bKamEXz6cyhSSrLZYNZfenrQJNXfR8Iz
         6RPOH1GqxCOLIypR6XtuP4SzWBsanu/HzVbeS7qnjHtEhL1OAVP6znIU0D+fAFFxvVqc
         nWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687425063; x=1690017063;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i68QhW4jCBgd/NtsI2qPa46H1bMJZjISzdeu9Mv7K80=;
        b=k6DiCV4LUJlJxYgYyPKACfa0/h8bUcChqzqPwi2QAWkeTikfkz+cQT+5VLSItswaGT
         jo/fUlhhD6Klpc4rq/3M9m85cWqxrzM2kt0zDhFgj+nOoyfvjqRtxWbwptGzMXDJ1jcl
         61q2uuJTA406LEGN0ILHzgMwZbNmxZDM382Fri6iW3wrSpzPYSt2lWShoMqhqGLjHU9Y
         tuzPff97x0LvnuIqXMx+gDbKzxZGJ+Opf+urVJD3vF8aRc7pXhGy8ZRpzejZ24ScJzKx
         IGqEjagjHK4FYlr0M/69M2ZagPS76tHnqa6e/NtEdfcBnkuNu7jEpZetrjHcz25JUjXI
         fUqQ==
X-Gm-Message-State: AC+VfDx7ncnE4naCldHftufir1guxxIYbLlRpgMACUOPQpJmPYGiXmuI
	u0oLKDjlGQEPef2f3H9oTop56A==
X-Google-Smtp-Source: ACHHUZ5Qq793/Bbh160b9m80rrV0j9sd5ebnGHfSQeiL8zJ9Q1llTbiB9VBgGECuwfIckL1bsRJn7w==
X-Received: by 2002:ac2:5b0c:0:b0:4f8:666b:9de8 with SMTP id v12-20020ac25b0c000000b004f8666b9de8mr9364113lfn.13.1687425062684;
        Thu, 22 Jun 2023 02:11:02 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b003078681a1e8sm6552550wrt.54.2023.06.22.02.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:11:02 -0700 (PDT)
Message-ID: <57b9fc14-c02e-f0e5-148d-a549ebab6cf6@brouer.com>
Date: Thu, 22 Jun 2023 11:11:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "Karlsson, Magnus" <magnus.karlsson@intel.com>,
 "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>
Subject: Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-4-sdf@google.com>
From: "Jesper D. Brouer" <netdev@brouer.com>
In-Reply-To: <20230621170244.1283336-4-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


This needs to be reviewed by AF_XDP maintainers Magnus and Bjørn (Cc)

On 21/06/2023 19.02, Stanislav Fomichev wrote:
> For zerocopy mode, tx_desc->addr can point to the arbitrary offset
> and carry some TX metadata in the headroom. For copy mode, there
> is no way currently to populate skb metadata.
> 
> Introduce new XDP_TX_METADATA_LEN that indicates how many bytes
> to treat as metadata. Metadata bytes come prior to tx_desc address
> (same as in RX case).

 From looking at the code, this introduces a socket option for this TX 
metadata length (tx_metadata_len).
This implies the same fixed TX metadata size is used for all packets.
Maybe describe this in patch desc.

What is the plan for dealing with cases that doesn't populate same/full
TX metadata size ?


> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>   include/net/xdp_sock.h      |  1 +
>   include/net/xsk_buff_pool.h |  1 +
>   include/uapi/linux/if_xdp.h |  1 +
>   net/xdp/xsk.c               | 31 ++++++++++++++++++++++++++++++-
>   net/xdp/xsk_buff_pool.c     |  1 +
>   net/xdp/xsk_queue.h         |  7 ++++---
>   6 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index e96a1151ec75..30018b3b862d 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -51,6 +51,7 @@ struct xdp_sock {
>   	struct list_head flush_node;
>   	struct xsk_buff_pool *pool;
>   	u16 queue_id;
> +	u8 tx_metadata_len;
>   	bool zc;
>   	enum {
>   		XSK_READY = 0,
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index a8d7b8a3688a..751fea51a6af 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -75,6 +75,7 @@ struct xsk_buff_pool {
>   	u32 chunk_size;
>   	u32 chunk_shift;
>   	u32 frame_len;
> +	u8 tx_metadata_len; /* inherited from xsk_sock */
>   	u8 cached_need_wakeup;
>   	bool uses_need_wakeup;
>   	bool dma_need_sync;
> diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
> index a78a8096f4ce..2374eafff7db 100644
> --- a/include/uapi/linux/if_xdp.h
> +++ b/include/uapi/linux/if_xdp.h
> @@ -63,6 +63,7 @@ struct xdp_mmap_offsets {
>   #define XDP_UMEM_COMPLETION_RING	6
>   #define XDP_STATISTICS			7
>   #define XDP_OPTIONS			8
> +#define XDP_TX_METADATA_LEN		9
>   
>   struct xdp_umem_reg {
>   	__u64 addr; /* Start of packet data area */
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index cc1e7f15fa73..c9b2daba7b6d 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -485,6 +485,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>   		int err;
>   
>   		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
> +		hr = max(hr, L1_CACHE_ALIGN((u32)xs->tx_metadata_len));
>   		tr = dev->needed_tailroom;
>   		len = desc->len;
>   
> @@ -493,14 +494,21 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>   			return ERR_PTR(err);
>   
>   		skb_reserve(skb, hr);
> -		skb_put(skb, len);
> +		skb_put(skb, len + xs->tx_metadata_len);
>   
>   		buffer = xsk_buff_raw_get_data(xs->pool, desc->addr);
> +		buffer -= xs->tx_metadata_len;
> +
>   		err = skb_store_bits(skb, 0, buffer, len);
>   		if (unlikely(err)) {
>   			kfree_skb(skb);
>   			return ERR_PTR(err);
>   		}
> +
> +		if (xs->tx_metadata_len) {
> +			skb_metadata_set(skb, xs->tx_metadata_len);
> +			__skb_pull(skb, xs->tx_metadata_len);
> +		}
>   	}
>   
>   	skb->dev = dev;
> @@ -1137,6 +1145,27 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>   		mutex_unlock(&xs->mutex);
>   		return err;
>   	}
> +	case XDP_TX_METADATA_LEN:
> +	{
> +		int val;
> +
> +		if (optlen < sizeof(val))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&val, optval, sizeof(val)))
> +			return -EFAULT;
> +
> +		if (val >= 256)
> +			return -EINVAL;
> +
> +		mutex_lock(&xs->mutex);
> +		if (xs->state != XSK_READY) {
> +			mutex_unlock(&xs->mutex);
> +			return -EBUSY;
> +		}
> +		xs->tx_metadata_len = val;
> +		mutex_unlock(&xs->mutex);
> +		return err;
> +	}
>   	default:
>   		break;
>   	}
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 26f6d304451e..66ff9c345a67 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -85,6 +85,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
>   		XDP_PACKET_HEADROOM;
>   	pool->umem = umem;
>   	pool->addrs = umem->addrs;
> +	pool->tx_metadata_len = xs->tx_metadata_len;
>   	INIT_LIST_HEAD(&pool->free_list);
>   	INIT_LIST_HEAD(&pool->xsk_tx_list);
>   	spin_lock_init(&pool->xsk_tx_list_lock);
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 6d40a77fccbe..c8d287c18d64 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -133,12 +133,13 @@ static inline bool xskq_cons_read_addr_unchecked(struct xsk_queue *q, u64 *addr)
>   static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>   					    struct xdp_desc *desc)
>   {
> -	u64 offset = desc->addr & (pool->chunk_size - 1);
> +	u64 addr = desc->addr - pool->tx_metadata_len;
> +	u64 offset = addr & (pool->chunk_size - 1);
>   
>   	if (offset + desc->len > pool->chunk_size)
>   		return false;
>   
> -	if (desc->addr >= pool->addrs_cnt)
> +	if (addr >= pool->addrs_cnt)
>   		return false;
>   
>   	if (desc->options)
> @@ -149,7 +150,7 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>   static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
>   					      struct xdp_desc *desc)
>   {
> -	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr);
> +	u64 addr = xp_unaligned_add_offset_to_addr(desc->addr) - pool->tx_metadata_len;
>   
>   	if (desc->len > pool->chunk_size)
>   		return false;

