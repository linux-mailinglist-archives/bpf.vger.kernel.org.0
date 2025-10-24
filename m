Return-Path: <bpf+bounces-72142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A600C07B89
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5E41892F94
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85FD346E74;
	Fri, 24 Oct 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxb69m2v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3621CC49
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330015; cv=none; b=ubQ/5ZS1mnt3jCevaKTpaRyeMmQPQsdkrgDYgw3aDQkDOgF/mGmbQNjvFhKYMmVPDeYfAdbVDgCJQdlcDzl1Nh3oFblN2ePXdlUl1Tkb/w67ZwEUoZaa+13/LENuPXLRkNPHkJcIYgKc0Y5ZGoGoY3kc7WB6uNBTxy2ovY2F04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330015; c=relaxed/simple;
	bh=XEWcdB8nSL7TWcB0vmWs3gPFfFkARIiMj9ncUdIOKvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZYtcX8786GuSvYd58moRDvvRmQ/ccG66NRp/3+w4il6jGe3NfpL02xIIiJZqQCikQLtki9JsU+a/YExR/G9ZahwvyK23hSFafWhs0cjGwfu2qhQxhmlnHIrU0qWWZNEij58w7EtViySeGNuoO97+12wPoosu4oCZHIt6yXlnpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxb69m2v; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a2738daea2so2109274b3a.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761330013; x=1761934813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mF8pASkRSmy3g5pAre6pJzEAWPU5hy46lyxgo7GleXY=;
        b=Hxb69m2vcZLJBzX+QHiR+EYvsOj3PsSBmFSqAmXnoaM55Rswoj2yAwWv+vWyKXm0TI
         qhXMC0gh27QainkDAUDMoXiEHCwEAvQR9er9wyHbompffxJhej6vSC3rMZs3X05D97pZ
         mNMmVRsYFZiUajGKdVHaNtZiihUPTetmhShf6SgB2Ke0hsH6qGWGcYpts3azfT3YFxNg
         ysjpZZ55LtYnVUnMVOZTtsSVH70gwjetIDYZyQ1VZ3pCokGyErGxpRgXPOqWyJCqOXQy
         PyiejjyzCPYSufxx00o4ieO0a1dKDHuUalM9d8rma65XFNk+QpUG0pM2hwlnBYXnwLbT
         Atcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330013; x=1761934813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF8pASkRSmy3g5pAre6pJzEAWPU5hy46lyxgo7GleXY=;
        b=rPiM52WXXlywqqHr5piAkHHLrXHgx2UCiTc+iS2Lj89P/Xu7+qpAbAW2Ef02nYkLj9
         xFJsXgxmzDD0YFEpg9uoabLfDlx3yiwU6OTwTUhHNuPjpIdYhn9Et6nCkaUnHmXqeVv5
         x79pHDx+nEE7osI4SBrq3CR/G663BvxuaFujmCenhzZRtRqY/HsI5GTnn+5+niKdhS9G
         P2voOaQcGXIXKVF97x4qbi+vwzda1aPp983W4cfYkiBebUwNmrcw/HckjMS/bAtclYM0
         55BJ2iRo99gBL8ZXV6NML+il8IcFnC6lpdTyCRfLDOmbsby2VrXLpE62lqGZzxrMrMae
         AW/A==
X-Forwarded-Encrypted: i=1; AJvYcCXnDxWWRvkwmlIudZXeLiFs1yhvlSr/20W0BnPiVby/YgDSjwd/UZrqjYwvBU9FJuFFCc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEukVL/mmCOLCrFq8op6VlOcNARTZqfsZR7jafJBom7nuTstI
	WOgFwsFM6ppuLZWahgtMbj3HkpMWHWjh3/ROf5LNB1QyDMaFl81qtKc=
X-Gm-Gg: ASbGncu47eAC8VQ0M4wcJVw5hD9PYQF2uO1AJPLShhds50UpvPViw9NZK3U4KM1ZjhK
	R/Uy/xk2sKOZejwdte3DD4JBmV7mChO0Bvq23cNHC/JYwiqJNOzJDEikQ7cfcxB6tgo7kB4YLa4
	hCI5pSlokG/twVjJ9VOy3YuSf1n9QL3d8NI37Dqy+VcoTwSR/kv2899+lI92Wi0rq7vHE2ceZKx
	GJR28GNnjhN/Vw0BcxiiZk9QsVWRBXC3v5x69r4VsZPNlNh2W96LQSFpw/iIqnWz1hXXYySYYaV
	lZo1B0M+WEosH/BdmC8SNvvrNZf3ZP43mDzxIFeDBEMFSrlScdQmHvC5WrGfUQrFUW6q7IfbWxD
	/e7UfMoIpW/e/eQstxihtGYL+M/kznQwIPaG9WrNBmUEOrs/7+wMcgJ/xa6fCfD0WZo7bvIJsgc
	31UvCF/CYFoocHIoy8aVxCnn0Yk0+h8/ODs8lpB/hs/cN/1w/CWIEkd6Z1a13owStUjwdfJsmOO
	/8CyIDcamieFKhzDZLiSNW2ajoOVjtj1H3VXJKCbqYop+QGYOYLZnMw6Jyu7FepS98=
X-Google-Smtp-Source: AGHT+IFl3AvSw+4rywJDi3NIfeZ09z7+cHIedsvqceTYOl/yM/dg2dUTcTxeuql+mG9DZvg6arOO/g==
X-Received: by 2002:a05:6a20:72a7:b0:334:a1bb:58a7 with SMTP id adf61e73a8af0-334a8614287mr38803933637.46.1761330012605;
        Fri, 24 Oct 2025 11:20:12 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a274a9e580sm6537353b3a.17.2025.10.24.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:20:12 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:20:11 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
Message-ID: <aPvDW0o89kmtGFfH@mini-arch>
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020162355.136118-3-daniel@iogearbox.net>

On 10/20, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Implement netdev_nl_bind_queue_doit() that creates an rx queue in a
> virtual netdev and then binds it to an rxq in a real netdev to create
> a queue pair.
> 
> Example with ynl client:
> 
>   # ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do bind-queue \
>       --json '{"src-ifindex": 4, "src-queue-id": 15, "dst-ifindex": 8, "queue-type": "rx"}'
>   {'dst-queue-id': 1}
> 
> Note that the netdevice locking order is always from the virtual to
> the physical device.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/netdev_queues.h   |   5 ++
>  include/net/netdev_rx_queue.h |  36 ++++++++-
>  net/core/netdev-genl.c        | 141 +++++++++++++++++++++++++++++++++-
>  net/core/netdev_rx_queue.c    |  61 +++++++++++++++
>  4 files changed, 240 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index cd00e0406cf4..286d5edce07d 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -130,6 +130,10 @@ void netdev_stat_queue_sum(struct net_device *netdev,
>   * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
>   *			   for this queue. Return NULL on error.
>   *
> + * @ndo_queue_create: Create a new RX queue which can be bound to another queue.
> + *		      Ops on this queue are redirected to the peer queue e.g.
> + *		      when opening a memory provider.
> + *
>   * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
>   * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
>   * be called for an interface which is open.
> @@ -149,6 +153,7 @@ struct netdev_queue_mgmt_ops {
>  						  int idx);
>  	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
>  							 int idx);
> +	int			(*ndo_queue_create)(struct net_device *dev);
>  };
>  
>  bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index 8cdcd138b33f..db3ef94c0744 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -28,6 +28,7 @@ struct netdev_rx_queue {
>  #endif
>  	struct napi_struct		*napi;
>  	struct pp_memory_provider_params mp_params;
> +	struct netdev_rx_queue		*peer;
>  } ____cacheline_aligned_in_smp;
>  
>  /*
> @@ -56,6 +57,37 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>  	return index;
>  }
>  
> -int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> +static inline void __netdev_rx_queue_peer(struct netdev_rx_queue *src_rxq,
> +					  struct netdev_rx_queue *dst_rxq)
> +{
> +	src_rxq->peer = dst_rxq;
> +	dst_rxq->peer = src_rxq;
> +}
>  
> -#endif
> +static inline void __netdev_rx_queue_unpeer(struct netdev_rx_queue *src_rxq,
> +					    struct netdev_rx_queue *dst_rxq)
> +{
> +	src_rxq->peer = NULL;
> +	dst_rxq->peer = NULL;
> +}
> +
> +static inline bool netdev_rx_queue_peered(struct net_device *dev,
> +					  u16 queue_id)
> +{
> +	if (queue_id < dev->real_num_rx_queues)
> +		return dev->_rx[queue_id].peer;
> +	return false;
> +}
> +
> +void netdev_rx_queue_peer(struct net_device *src_dev,
> +			  struct netdev_rx_queue *src_rxq,
> +			  struct netdev_rx_queue *dst_rxq);
> +void netdev_rx_queue_unpeer(struct net_device *src_dev,
> +			    struct netdev_rx_queue *src_rxq,
> +			    struct netdev_rx_queue *dst_rxq);
> +int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> +struct netdev_rx_queue *
> +netif_get_rx_queue_peer_locked(struct net_device **dev,
> +			       unsigned int *rxq_idx,
> +			       bool *needs_unlock);
> +#endif /* _LINUX_NETDEV_RX_QUEUE_H */
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index ce1018ea390f..579469abac8c 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1122,7 +1122,146 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	u32 src_ifidx, src_qid, dst_ifidx, dst_qid, q_type;
> +	struct netdev_rx_queue *src_rxq, *dst_rxq, *tmp_rxq;
> +	struct net_device *src_dev, *dst_dev;
> +	struct sk_buff *rsp;
> +	int err = 0;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_QUEUE_TYPE) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_DST_IFINDEX))
> +		return -EINVAL;
> +
> +	src_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX]);
> +	src_qid = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID]);
> +	dst_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_DST_IFINDEX]);
> +	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_QUEUE_TYPE]);
> +
> +	if (q_type != NETDEV_QUEUE_TYPE_RX) {
> +		NL_SET_ERR_MSG(info->extack, "Only binding of RX queue supported");
> +		return -EOPNOTSUPP;
> +	}
> +	if (dst_ifidx == src_ifidx) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination driver cannot be same as source driver");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr) {
> +		err = -EMSGSIZE;
> +		goto err_genlmsg_free;
> +	}

[..]

> +	/* Locking order is always from the virtual to the physical device
> +	 * since this is also the same order when applications open the
> +	 * memory provider later on.
> +	 */
> +	dst_dev = netdev_get_by_index_lock(genl_info_net(info), dst_ifidx);
> +	if (!dst_dev) {
> +		err = -ENODEV;
> +		goto err_genlmsg_free;
> +	}

...

> +	src_dev = netdev_get_by_index_lock(genl_info_net(info), src_ifidx);
> +	if (!src_dev) {
> +		err = -ENODEV;
> +		goto err_unlock_dst_dev;
> +	}

But isn't the above susceptible to ABBA exploitation from the userspace?
I can try to concurrently do two requests, the second one being with
dst_dev and src_dev swapped. Or do we assume that we exit earlier for
the swapped case based on some other condition?

