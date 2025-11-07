Return-Path: <bpf+bounces-73913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02615C3DFF0
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 01:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7409F3AAF45
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949A2E11B8;
	Fri,  7 Nov 2025 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL/gwm/9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB7026E154;
	Fri,  7 Nov 2025 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475997; cv=none; b=hZg1KF85cmHqPaDe7TiP6LiIrZLhr7cvpUX9y3qlAGOniuDX2ZEdggbFf1WPY/Onzdo8umFnfVAM3+7sDJVvA6miReC2mSYGD/sD2Zrr3wWjelm2E/2rl0HSrt7HgawSGxi2+7Pfbgq4UElmaRCgSl8c8KGSRI4GzdbPzV3avhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475997; c=relaxed/simple;
	bh=0IdYDmwOk5SwSznAbg4wSvIbvjUnSV5xTi/r+7XGXFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLv9FgvQHLSYZtajQvkg5j9FCSrZttmp5EFpKl9XnjJP2a1iQp2HMvh9ZftxtkIiHhnocYpbDWiz1WrG38YXDlGaTlhf6mvUyp4BdEK+NqrEMYOec/Dqj9JfheaW1nwrFHYTX3EXnHwL2M2XsiKtIoCgRTEZeVIMAtaNNF1dADs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL/gwm/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D171C116D0;
	Fri,  7 Nov 2025 00:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762475997;
	bh=0IdYDmwOk5SwSznAbg4wSvIbvjUnSV5xTi/r+7XGXFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VL/gwm/9jdHUjn0xE1dptwGQ9AXdl4cGT61HFsCoKaFkL/c/Eu/hqboLCCauYlQ0+
	 kmYSk//PJq6pi1cJAmU6hsTCikwYdLuER7yDI2x7TAnhpQ0tOOBS9VLEpZEj2miLrN
	 CsKc/p7jHXf3O1q0+Nj51ucnQAZVjSInKs0EMKxdOKiQIQaM9pVyf0vHVHYl0vg6oT
	 aheBT75yFc+H24URhwT0KvNkAtz3Vq/f70ADzbWaa9y1xvrI16Rf72Vl0tHZjfvEjh
	 aNpp89xQwrZuDBRzVUgmyxxaJf0SkHr1lBqruk0elgyervRJMr/aJ3ZJLK7apnOde1
	 d5tBWPJ7AyYaA==
Date: Thu, 6 Nov 2025 16:39:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v4 02/14] net: Implement
 netdev_nl_bind_queue_doit
Message-ID: <20251106163955.6de6c609@kernel.org>
In-Reply-To: <20251031212103.310683-3-daniel@iogearbox.net>
References: <20251031212103.310683-1-daniel@iogearbox.net>
	<20251031212103.310683-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 22:20:51 +0100 Daniel Borkmann wrote:
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index cd00e0406cf4..67e89710577f 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -130,6 +130,11 @@ void netdev_stat_queue_sum(struct net_device *netdev,
>   * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
>   *			   for this queue. Return NULL on error.
>   *
> + * @ndo_queue_create: Create a new RX queue which can be bound to another queue.
> + *		      Ops on this queue are redirected to the peer queue e.g.
> + *		      when opening a memory provider. On success, the new queue
> + *		      id is stored into idx.

index is positive, errors negative, just return it.

>  bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index 8cdcd138b33f..3a02d47e42bc 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -28,6 +28,8 @@ struct netdev_rx_queue {
>  #endif
>  	struct napi_struct		*napi;
>  	struct pp_memory_provider_params mp_params;
> +	struct netdev_rx_queue		*peer;

s/peer/lease/

> +	netdevice_tracker		peer_tracker;
>  } ____cacheline_aligned_in_smp;
>  
>  /*
> @@ -56,6 +58,38 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>  	return index;
>  }
>  
> -int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> +static inline void __netdev_rx_queue_peer(struct netdev_rx_queue *src_rxq,
> +					  struct netdev_rx_queue *dst_rxq)
> +{
> +	WRITE_ONCE(src_rxq->peer, dst_rxq);
> +	WRITE_ONCE(dst_rxq->peer, src_rxq);
> +}
>  
> -#endif
> +static inline void __netdev_rx_queue_unpeer(struct netdev_rx_queue *src_rxq,
> +					    struct netdev_rx_queue *dst_rxq)
> +{
> +	WRITE_ONCE(src_rxq->peer, NULL);
> +	WRITE_ONCE(dst_rxq->peer, NULL);
> +}

Both these helpers are called once, inline them, I don't think they
help readability.

> +static inline bool netdev_rx_queue_peered(struct net_device *dev,
> +					  u16 queue_id)

netdev_rx_queue_leased() ? Please try to add the helpers where they are used.
This should be in the next patch.

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
> +			       unsigned int *rxq_idx);
> +void netif_put_rx_queue_peer_locked(struct net_device *orig_dev,
> +				    struct net_device *dev);
> +#endif /* _LINUX_NETDEV_RX_QUEUE_H */
> diff --git a/net/core/dev.h b/net/core/dev.h
> index 900880e8b5b4..321529477b38 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -35,6 +35,13 @@ struct net_device *
>  netdev_xa_find_lock(struct net *net, struct net_device *dev,
>  		    unsigned long *index);
>  
> +static inline struct net_device *netdev_put_lock(struct net_device *dev,
> +						 netdevice_tracker *tracker)
> +{
> +	netdev_tracker_free(dev, tracker);
> +	return __netdev_put_lock(dev, dev_net(dev));
> +}

Does not have to be a static inline.

>  DEFINE_FREE(netdev_unlock, struct net_device *, if (_T) netdev_unlock(_T));
>  
>  #define for_each_netdev_lock_scoped(net, var_name, ifindex)		\
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index ce1018ea390f..4fa7e881441f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1122,7 +1122,155 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  int netdev_nl_bind_queue_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	struct netdev_rx_queue *src_rxq, *dst_rxq, *tmp_rxq;
> +	u32 src_ifidx, src_qid, dst_ifidx, dst_qid, q_type;
> +	struct net_device *src_dev, *dst_dev;
> +	netdevice_tracker dev_tracker;
> +	struct sk_buff *rsp;
> +	int err = 0;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_QUEUE_TYPE) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_PAIR_DST_IFINDEX))
> +		return -EINVAL;

Hopefully the src/dst will be gone after rework. I have to check this if
every time to figure out which one is which (dst qid is not required ==
dst is netkit)

> +	src_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_IFINDEX]);
> +	src_qid = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_SRC_QUEUE_ID]);
> +	dst_ifidx = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_DST_IFINDEX]);
> +	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_PAIR_QUEUE_TYPE]);
> +
> +	if (q_type != NETDEV_QUEUE_TYPE_RX) {
> +		NL_SET_ERR_MSG(info->extack, "Only binding of RX queue supported");
> +		return -EOPNOTSUPP;

EINVAL

> +	}
> +	if (dst_ifidx == src_ifidx) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination driver cannot be same as source driver");
> +		return -EOPNOTSUPP;

EINVAL

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

I dislike this. We worked hard to avoid having any dependencies
between instance locks :( If the "lease" was a standalone object we
could perhaps avoid this. Another option would be to have the queue
count and lower as part of netkit attrs when netkit is created.
The netkit instance lock seems to be needed only to create the queue. 

But I guess this code "works". IDK.

Pretty sure the current code will splat in lockdep tho, cause the
compare function doesn't understand your new logic.

> +	dst_dev = netdev_get_by_index_lock(genl_info_net(info), dst_ifidx);
> +	if (!dst_dev) {
> +		err = -ENODEV;
> +		goto err_genlmsg_free;
> +	}
> +	if (dst_dev->dev.parent) {
> +		err = -EOPNOTSUPP;

EINVAL

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

EINVAL

> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination device must have at least one real RX queue");
> +		goto err_unlock_dst_dev;
> +	}

Consider factoring out these checks. The function is quite long.
You can probably lock the netkit, get the real device, and pass
them both to a helper which will do the validation. It will also
help with the double-gotos

> +	src_dev = netdev_get_by_index(genl_info_net(info), src_ifidx,
> +				      &dev_tracker, GFP_KERNEL);
> +	if (!src_dev) {
> +		err = -ENODEV;
> +		goto err_unlock_dst_dev;
> +	}
> +	if (!src_dev->dev.parent) {
> +		err = -EOPNOTSUPP;

EINVAL

> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source device is a virtual device");
> +		goto err_unlock_dst_dev_src_dev_put;
> +	}
> +	if (!netif_device_present(src_dev)) {
> +		err = -ENODEV;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source device has been removed from the system");
> +		goto err_unlock_dst_dev_src_dev_put;
> +	}
> +	if (!src_dev->queue_mgmt_ops) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source driver does not support queue management operations");
> +		goto err_unlock_dst_dev_src_dev_put;
> +	}
> +
> +	src_dev = netdev_put_lock(src_dev, &dev_tracker);
> +	if (!src_dev) {
> +		err = -ENODEV;
> +		goto err_unlock_dst_dev;
> +	}
> +	if (src_qid >= src_dev->real_num_rx_queues) {
> +		err = -ERANGE;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source device queue is out of range");

NL_SET_BAD_ATTR(), attr + ERANGE will spell this out better than the current message..

> +		goto err_unlock_src_dev;
> +	}
> +
> +	src_rxq = __netif_get_rx_queue(src_dev, src_qid);
> +	if (src_rxq->peer) {

What if it has AF_XDP or mp already bound? Are we okay with that?

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
> +			       "Binding multiple queues from different source devices not supported");
> +		goto err_unlock_src_dev;
> +	}
> +
> +	err = dst_dev->queue_mgmt_ops->ndo_queue_create(dst_dev, &dst_qid);
> +	if (err) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Destination device is unable to create a new queue");
> +		goto err_unlock_src_dev;
> +	}
> +
> +	dst_rxq = __netif_get_rx_queue(dst_dev, dst_qid);
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
> +err_unlock_dst_dev_src_dev_put:
> +	netdev_put(src_dev, &dev_tracker);
> +	goto err_unlock_dst_dev;
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
> index c7d9341b7630..6eb12f3b969c 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -18,6 +18,69 @@ bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
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
> +	netdev_hold(src_dev, &src_rxq->peer_tracker, GFP_KERNEL);
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
> +	netdev_put(src_dev, &src_rxq->peer_tracker);
> +}

I think this belongs directly in the unregister path in the core.

> +static struct netdev_rx_queue *
> +__netif_get_rx_queue_peer(struct net_device **dev, unsigned int *rxq_idx)
> +{
> +	struct net_device *orig_dev = *dev;
> +	struct netdev_rx_queue *rxq = __netif_get_rx_queue(orig_dev, *rxq_idx);
> +
> +	if (rxq->peer) {
> +		if (orig_dev->dev.parent)
> +			return NULL;
> +		rxq = rxq->peer;
> +		*rxq_idx = get_netdev_rx_queue_index(rxq);
> +		*dev = rxq->dev;
> +	}
> +	return rxq;
> +}
> +
> +struct netdev_rx_queue *
> +netif_get_rx_queue_peer_locked(struct net_device **dev, unsigned int *rxq_idx)
> +{
> +	struct net_device *orig_dev = *dev;
> +	struct netdev_rx_queue *rxq;
> +
> +	/* Locking order is always from the virtual to the physical device
> +	 * see netdev_nl_bind_queue_doit().
> +	 */
> +	netdev_ops_assert_locked(orig_dev);
> +	rxq = __netif_get_rx_queue_peer(dev, rxq_idx);
> +	if (rxq && orig_dev != *dev)
> +		netdev_lock(*dev);
> +	return rxq;
> +}
> +
> +void netif_put_rx_queue_peer_locked(struct net_device *orig_dev,
> +				    struct net_device *dev)
> +{
> +	if (orig_dev != dev)
> +		netdev_unlock(dev);
> +}

These helpers belong in patch 5.

