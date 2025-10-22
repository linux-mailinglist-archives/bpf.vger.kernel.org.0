Return-Path: <bpf+bounces-71701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F94BFB975
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B1518C3EA6
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 11:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA3331A56;
	Wed, 22 Oct 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Qfj838wH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7801330D23
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131844; cv=none; b=kxD4hHLycmg8qKNDsYnaWlVqcTCIcLU6Bdr2CWLWmhySZcVpMykuCLC2C1aZKkQyy3sc9N0/qr8++uU/xu1eqAyZD9XysHl19REJIFwoyDN9jEH8k7aotqaFBQzkuXZ4vzZC2lxY5bZQYsWSiRosbaNU0g9NmqkIip9DTpd2+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131844; c=relaxed/simple;
	bh=QeuDe5mCKorRYZdcLTYRatLCEejo1OGDNU3ebkGHVs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4c03ge/vk5bqSlxN+cDLQ+nYiTwivsXlIbFME9RH3fC1dLQq7gvKwZpRtDQf0iCoyPRYIDaXdECPa45GBtGCl83+p4lzRSwGynOLPCXSBiSjY/5d8PoFMhbZrPP998IZgTRtg+mFrq36J3d9cI6Y8xH5eliIKWnjNKimwMbriQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Qfj838wH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b40f11a1027so1330213166b.2
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761131840; x=1761736640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B9ZcYPe0GIdrUPaEzv9iPEgZlS6j3OkZvxTywqWGaxI=;
        b=Qfj838wHA3fL83twfmBIF+4/Gner83a6Bvy2PUVu3GfGANF1x60kZRd/Ckzszy3YUy
         rrkUC43HErzfgOHs0arpOQZlGDp3+zu2MWvM8CYReqDtt4UbHTQg8G3OAHMgfh9kR5df
         Z/eKHMXFifY/WCp/qcWzA+2T8zUIzEvK1CWnU0RWp4IRNHLFjGqGNeEVWGsMT35ltn10
         GRIHEg1288Nq4fhL7uFA7F9OHLJbhZsv7SOchI7B8qRfISXIMZWz/t+AVCvaGthgHv/X
         iFMBlEYDx8OidbjEqDXYggF7LPv+r51WLTHlJikbK33iqLuMlWytAtMdoWlYbPQZ45LF
         kAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131840; x=1761736640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9ZcYPe0GIdrUPaEzv9iPEgZlS6j3OkZvxTywqWGaxI=;
        b=t48pvVdp7KWBY4l6vhzTozbjr4AKhxBLaLplTViGjAWoWFSRtcpY57jQ3pZ5ZUVm2X
         4i4uQbbPXBYu+DxEtNnOiluIyCN5BgS0ucR/dT9S5JwetSu+AhPHPuZQTLx6Y4MqHxCv
         Azei4qYQcaKsCjcGds7usX6CxAM7ix4Z5XUw3OkpHE5L1UGqjk+HhtLp85V0MF4AESSl
         PW7Mu177i85L72AxT1q8LkwLUBl1HBCdGRsWLpwkoBaPmX8oxsHqW59Xi9dA9iYiPIMu
         cIhd6J9iL/UEmM59RD6b2LOhRTd+9T/itlOc3xXHkRG06f4+Y7recVOHefrPJX6S7tT3
         ehzQ==
X-Gm-Message-State: AOJu0YzV8VAEIzvHWovYCSWTxBcska7cq0KVVJWbcs55TXWYV3k+mzNZ
	QqHxrHb2Hzaau1BO6GLlRYM97hWw1zrA5ZTv2HTxE4K9udxC9scHZaV++T+I1LvmDXM=
X-Gm-Gg: ASbGncu2ACe6TwfW4o4sdQSAYweVCVsbxYuVMfU1IPVCG1huHwmDmaduCjg4RULE2lW
	IOhEb5v9m0vzI+gqzNcMMQE5TbNnIFzOp4MUrFy5zTLDiplgwMf9pyJxHXy1TRYC1zDjiC7dq0+
	xIL2XRvYXEWocOQ2QO7JHDsRt0Ku59bf7NFAoczuWSprNdmO7dwt1ZYVl2y9QTI++2mjsmctpsN
	DgUVtOY4+ORGUDYWhgmd/azXAc7qsplVz9BSYS+xrv3EjFr68p+jxBkV4GxH2Xkf2YIe3b53tLQ
	jn80F8S77Gcwf1dnUimjiPvucgC1XG2+4Ou1hGobxg416gWHKbU+s/Z8N7O2uQd4T+6F891tLzv
	zcgmdzC2Q/ABUw/pStBJ1mA2UqHDvoaCXdaQP4ItPYYgfNWtSxUFV1Pr7p1hjGMW8CUjIVUe7vv
	BD19AMGQp8Rl3v0bS50pu/BVc2OMWo9evmaUGCiHivVFE=
X-Google-Smtp-Source: AGHT+IGfQc0bKjK//UOsSHK/HgtEoC/56tPnU0c/UlK8cXX5VNwt+LQy6yAuVEG0LKO+SzfnOftPog==
X-Received: by 2002:a17:906:c104:b0:b40:5752:16b7 with SMTP id a640c23a62f3a-b6475124787mr2456134266b.51.1761131839762;
        Wed, 22 Oct 2025 04:17:19 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d3b4f48cfsm47250866b.41.2025.10.22.04.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:17:19 -0700 (PDT)
Message-ID: <ce3a6866-17fa-4b91-b02e-18b72538bb19@blackwall.org>
Date: Wed, 22 Oct 2025 14:17:17 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
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

It'd be nice to mention what the expected return value can be. See more below.

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

nit: reverse xmas tree order

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
> +
> +	/* Locking order is always from the virtual to the physical device
> +	 * since this is also the same order when applications open the
> +	 * memory provider later on.
> +	 */
> +	dst_dev = netdev_get_by_index_lock(genl_info_net(info), dst_ifidx);
> +	if (!dst_dev) {
> +		err = -ENODEV;
> +		goto err_genlmsg_free;
> +	}
> +	if (dst_dev->dev.parent) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination device is not a virtual device");
> +		goto err_unlock_dst_dev;
> +	}
> +	if (!dst_dev->queue_mgmt_ops ||
> +	    !dst_dev->queue_mgmt_ops->ndo_queue_create) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination driver does not support queue management operations");
> +		goto err_unlock_dst_dev;
> +	}
> +	if (dst_dev->real_num_rx_queues < 1) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination device must have at least one real RX queue");
> +		goto err_unlock_dst_dev;
> +	}
> +
> +	src_dev = netdev_get_by_index_lock(genl_info_net(info), src_ifidx);
> +	if (!src_dev) {
> +		err = -ENODEV;
> +		goto err_unlock_dst_dev;
> +	}
> +	if (!src_dev->dev.parent) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source device is a virtual device");
> +		goto err_unlock_src_dev;
> +	}
> +	if (!netif_device_present(src_dev)) {
> +		err = -ENODEV;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source device has been removed from the system");
> +		goto err_unlock_src_dev;
> +	}
> +	if (!src_dev->queue_mgmt_ops) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source driver does not support queue management operations");
> +		goto err_unlock_src_dev;
> +	}
> +	if (src_qid >= src_dev->num_rx_queues) {
> +		err = -ERANGE;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source device queue is out of range");
> +		goto err_unlock_src_dev;
> +	}
> +
> +	src_rxq = __netif_get_rx_queue(src_dev, src_qid);
> +	if (src_rxq->peer) {
> +		err = -EBUSY;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source device queue is already bound");
> +		goto err_unlock_src_dev;
> +	}
> +
> +	tmp_rxq = __netif_get_rx_queue(dst_dev, dst_dev->real_num_rx_queues - 1);
> +	if (tmp_rxq->peer && tmp_rxq->peer->dev != src_dev) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Binding multiple queues from difference source devices not supported");

s/difference/different/

> +		goto err_unlock_src_dev;
> +	}
> +
> +	err = dst_dev->queue_mgmt_ops->ndo_queue_create(dst_dev);
> +	if (err <= 0) {

<= 0 is a bit weird, if 0 signals an error perhaps "err" must be set?

Maybe directly use dst_qid above and set "err" appropriately to better
demonstrate what's expected?

> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination device is unable to create a new queue");
> +		goto err_unlock_src_dev;
> +	}
> +
> +	dst_qid = err - 1;
> +	dst_rxq = __netif_get_rx_queue(dst_dev, dst_qid);
> +
> +	netdev_rx_queue_peer(src_dev, src_rxq, dst_rxq);
> +
> +	nla_put_u32(rsp, NETDEV_A_QUEUE_PAIR_DST_QUEUE_ID, dst_qid);
> +	genlmsg_end(rsp, hdr);
> +
> +	netdev_unlock(src_dev);
> +	netdev_unlock(dst_dev);
> +
> +	return genlmsg_reply(rsp, info);
> +
> +err_unlock_src_dev:
> +	netdev_unlock(src_dev);
> +err_unlock_dst_dev:
> +	netdev_unlock(dst_dev);
> +err_genlmsg_free:
> +	nlmsg_free(rsp);
> +	return err;
>  }
>  
>  void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index c7d9341b7630..916ca8d7ae7c 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -18,6 +18,67 @@ bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
>  }
>  EXPORT_SYMBOL(netif_rxq_has_unreadable_mp);
>  
> +void netdev_rx_queue_peer(struct net_device *src_dev,
> +			  struct netdev_rx_queue *src_rxq,
> +			  struct netdev_rx_queue *dst_rxq)
> +{
> +	netdev_assert_locked(src_dev);
> +	netdev_assert_locked(dst_rxq->dev);
> +
> +	netdev_hold(src_dev, &src_rxq->dev_tracker, GFP_KERNEL);
> +	__netdev_rx_queue_peer(src_rxq, dst_rxq);
> +}
> +
> +void netdev_rx_queue_unpeer(struct net_device *src_dev,
> +			    struct netdev_rx_queue *src_rxq,
> +			    struct netdev_rx_queue *dst_rxq)
> +{
> +	WARN_ON_ONCE(READ_ONCE(dst_rxq->dev->reg_state) != NETREG_UNREGISTERING);
> +
> +	netdev_assert_locked(dst_rxq->dev);
> +	netdev_assert_locked(src_dev);
> +
> +	__netdev_rx_queue_unpeer(src_rxq, dst_rxq);
> +	netdev_put(src_dev, &src_rxq->dev_tracker);
> +}
> +
> +static struct netdev_rx_queue *
> +__netif_get_rx_queue_peer(struct net_device **dev, unsigned int *rxq_idx,
> +			  bool virt_to_phys_only)
> +{
> +	struct net_device *req_dev = *dev;
> +	struct netdev_rx_queue *rxq = __netif_get_rx_queue(req_dev, *rxq_idx);
> +
> +	if (rxq->peer) {
> +		if (virt_to_phys_only &&
> +		    req_dev->dev.parent)
> +			return NULL;
> +		rxq = rxq->peer;
> +		*rxq_idx = get_netdev_rx_queue_index(rxq);
> +		*dev = rxq->dev;
> +	}
> +	return rxq;
> +}
> +
> +struct netdev_rx_queue *
> +netif_get_rx_queue_peer_locked(struct net_device **dev, unsigned int *rxq_idx,
> +			       bool *needs_unlock)
> +{
> +	struct net_device *req_dev = *dev;
> +	struct netdev_rx_queue *rxq;
> +
> +	/* Locking order is always from the virtual to the physical device
> +	 * see netdev_nl_bind_queue_doit().
> +	 */
> +	netdev_ops_assert_locked(req_dev);
> +	rxq = __netif_get_rx_queue_peer(dev, rxq_idx, true);
> +	if (rxq && req_dev != *dev) {
> +		*needs_unlock = true;
> +		netdev_lock(*dev);
> +	}
> +	return rxq;
> +}
> +>  int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
>  {
>  	struct netdev_rx_queue *rxq = __netif_get_rx_queue(dev, rxq_idx);


