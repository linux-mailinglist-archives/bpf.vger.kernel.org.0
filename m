Return-Path: <bpf+bounces-78505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA10D0FD7E
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 21:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16E513016475
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 20:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA4258CD9;
	Sun, 11 Jan 2026 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN3AN4Dn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4059221721
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768164927; cv=none; b=cj7THi9tsDqB0KjWwgKPc77d9sJWQ0DEd7m/WC6ywTrMV9DvXOJyZABrKqBAA4zlnf3pFQNbK8Q6/8iQZrERKIrtQulREkCK0rPe6kAlCELopJbq+I2bv7976+bMZePGHLrgQUKRQgq7ud1Hz6f4Doa08BJXAmw2whMyqOkgDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768164927; c=relaxed/simple;
	bh=raf5s2qz0YvrEUseW4I4R1/vKZB6hxJ3uKY1UDxpOZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN8y6jestbp1A2d2mg2NnOl3aXMWZHnqYEHRSjHqFndkWqLzJdFfqZ+Gen8DFtvrB73tcGQM3/5ynicylLqTJ3p+rm3Tnkkyk1leKFyzWwB2wTC2LksKNIUlTSlvq/irdQi2UWWE1FaKAk6DM8Be9kbaoaVCxdeKLUAaCVDJSz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN3AN4Dn; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ae38f81be1so5896082eec.0
        for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 12:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768164925; x=1768769725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=00CnYMvLSnYadKME2IJNAU7KIzGfoX2dKPWJIpBxCsY=;
        b=PN3AN4DnZgAYA3TC1tWgZoQ/qyapruQyTxE9aEz6HXKPdZoQA2xHnHSGOjgwwh7x89
         5rxMUydOiSXxN2ObN3Kwx5pFnVZdtxhMTrUyI1DPXLZ6gEDt4q6YhiMjY98N0qa2eyvZ
         K/W/1lyeBQBrtMoS52hFDDY4xLflmniKeHtdRh5VP2TygRfke/qajo4pryIPXvsplf9X
         aVwf977gE3xalYwPYl4nx/12ByvaXNMgIxXN4p+DW0KJYD0AkFaw/kHLkUibZv+N7FDG
         ekFOTWdHWnL0ppzcF6nAM153KkeK0TtBJNdW9uhGdkFr86LPDEBO4yYG/74JAiw4+Wn0
         O3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768164925; x=1768769725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00CnYMvLSnYadKME2IJNAU7KIzGfoX2dKPWJIpBxCsY=;
        b=mWd6d4Zqqla34Pm2ukisZ66ah5wCkD+55EnPDoToG/EcaKQD8YbV40Dk6m/OEvw6/b
         HgMh1lhMat3cL9RYzKYzQo+JHsG5RbPUzXlkrhN03doAdhC38Y3GC2knDFgAOsOBjien
         dbdphbwpno+HRA/m1P/PbiMpvpKQ7VVGSDpDNw7dcYHbhwANsZcTM/fN49HL+5aWavzf
         4h/fZYyMXm9RnsQOQsLsj20K0n+u/tfvWpUauaIgFQ8bQzi4Xb4QMjwsmPLXXyEs6hI7
         NqzH4aF+B/knAbst5FRJOfmPiu1SyCvvNSytu6Sg01sc9CLW1nxjGRZRLmjqAYWZsypP
         UtGg==
X-Forwarded-Encrypted: i=1; AJvYcCUfStg+IUz/DxZtkMCzbjvneifINDx0OiSwkNNm0vcxLg/Wwog6NOXQ1h9+gfk8rB6s5tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh+8R0RwyqNHo5sJlRY11ika3DNxge9gm2KCaUQVpJZqSfvH8B
	8MO3pDUXnGw1JdQ4X9Nn9nBkQq/IQvC2JHm8XYog6FeHqqzXNqCkLIo=
X-Gm-Gg: AY/fxX7uKurJxREn9pp973MR7q0SN8kGZzlKZ/kH3E1Ru+Y6gyBivlzVZ/OkB6AoIr5
	yTnDafOsr+ZVUSW4A3Wu/MzL8SFbyXaQrlotROzC9GIwuEN+Nuk3RMHN9bofvWH+fcgsjQgOqLX
	3jdz6B+mqNu0LBOOL5Ty9ZE44iBl3MQjFB1MnN2QtSW2Ghp4hbygyC/K2NedrXTQ41f2Hh11Qyw
	Y6K/FwCsdrT0fg0LRi07kg8kV6Pi0FzKUbPklMFDRxl8IXqcb9ggnvKgAuzg4nIyqFQpGyhvSn5
	oNH4M2ClaF7gyeDLJ7kA0cyh0Au6iBPofWyxZGmxI8nS39nXLTZlpUDlFEdfGmVncUARHjDg6To
	jM1nWgYNrXzTDcq2dTluS8Aip/bBg9E7uIxVrunNK1mew4qxdAc8QjzaqlbPlvDTKZdwD4wLezZ
	vgC7XZYvReSqT77iNVHzZ6jTdJHQTGIqjRJCv7/9uB1NrWTNyFWj0YRTYgSR8ytcNnQ4v6P/5xd
	UeS0A==
X-Google-Smtp-Source: AGHT+IEVAz6IANnY+WRQe8rWMdQm3Yennsrw5Zaj5LUn3D23TNuTNGO5QRyd/d+0rUS7TFFSOwlb9g==
X-Received: by 2002:a05:7022:113:b0:119:e569:f626 with SMTP id a92af1059eb24-121f8b7a9f2mr16276498c88.31.1768164924560;
        Sun, 11 Jan 2026 12:55:24 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24984a3sm23813047c88.13.2026.01.11.12.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:55:23 -0800 (PST)
Date: Sun, 11 Jan 2026 12:55:23 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v5 02/16] net: Implement
 netdev_nl_queue_create_doit
Message-ID: <aWQOO0xhXxNebmXF@mini-arch>
References: <20260109212632.146920-1-daniel@iogearbox.net>
 <20260109212632.146920-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109212632.146920-3-daniel@iogearbox.net>

On 01/09, Daniel Borkmann wrote:
> Implement netdev_nl_queue_create_doit which creates a new rx queue in a
> virtual netdev and then leases it to a rx queue in a physical netdev.
> 
> Example with ynl client:
> 
>   # ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-create \
>       --json '{"ifindex": 8, "type": "rx", "lease": {"ifindex": 4, "queue": {"type": "rx", "id": 15}}}'
>   {'id': 1}
> 
> Note that the netdevice locking order is always from the virtual to
> the physical device.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  include/net/netdev_queues.h   |  19 ++++-
>  include/net/netdev_rx_queue.h |   9 ++-
>  include/net/xdp_sock_drv.h    |   2 +-
>  net/core/dev.c                |   7 ++
>  net/core/dev.h                |   2 +
>  net/core/netdev-genl.c        | 146 +++++++++++++++++++++++++++++++++-
>  net/core/netdev_queues.c      |  57 +++++++++++++
>  net/core/netdev_rx_queue.c    |  50 +++++++++++-
>  net/xdp/xsk.c                 |   2 +-
>  9 files changed, 282 insertions(+), 12 deletions(-)
> 
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index cd00e0406cf4..f65319a6fb87 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -130,6 +130,11 @@ void netdev_stat_queue_sum(struct net_device *netdev,
>   * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
>   *			   for this queue. Return NULL on error.
>   *
> + * @ndo_queue_create: Create a new RX queue which can be leased to another queue.
> + *		      Ops on this queue are redirected to the leased queue e.g.
> + *		      when opening a memory provider. Return the new queue id on
> + *		      success. Return negative error code on failure.
> + *
>   * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
>   * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
>   * be called for an interface which is open.
> @@ -149,9 +154,12 @@ struct netdev_queue_mgmt_ops {
>  						  int idx);
>  	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
>  							 int idx);
> +	int			(*ndo_queue_create)(struct net_device *dev);
>  };
>  
> -bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx);
> +bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx);
> +bool netif_rxq_has_mp(struct net_device *dev, unsigned int rxq_idx);
> +bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx);
>  
>  /**
>   * DOC: Lockless queue stopping / waking helpers.
> @@ -329,5 +337,10 @@ static inline void netif_subqueue_sent(const struct net_device *dev,
>  	})
>  
>  struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx);
> -
> -#endif
> +bool netdev_can_create_queue(const struct net_device *dev,
> +			     struct netlink_ext_ack *extack);
> +bool netdev_can_lease_queue(const struct net_device *dev,
> +			    struct netlink_ext_ack *extack);
> +bool netdev_queue_busy(struct net_device *dev, int idx,
> +		       struct netlink_ext_ack *extack);
> +#endif /* _LINUX_NET_QUEUES_H */
> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
> index 8cdcd138b33f..1cacc2451516 100644
> --- a/include/net/netdev_rx_queue.h
> +++ b/include/net/netdev_rx_queue.h
> @@ -28,6 +28,8 @@ struct netdev_rx_queue {
>  #endif
>  	struct napi_struct		*napi;
>  	struct pp_memory_provider_params mp_params;
> +	struct netdev_rx_queue		*lease;
> +	netdevice_tracker		lease_tracker;
>  } ____cacheline_aligned_in_smp;
>  
>  /*
> @@ -57,5 +59,8 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
>  }
>  
>  int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
> -
> -#endif
> +void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
> +			   struct netdev_rx_queue *rxq_src);
> +void netdev_rx_queue_unlease(struct netdev_rx_queue *rxq_dst,
> +			     struct netdev_rx_queue *rxq_src);
> +#endif /* _LINUX_NETDEV_RX_QUEUE_H */
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 242e34f771cc..c07cfb431eac 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -28,7 +28,7 @@ void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries);
>  bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
>  void xsk_tx_release(struct xsk_buff_pool *pool);
> -struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
> +struct xsk_buff_pool *xsk_get_pool_from_qid(const struct net_device *dev,
>  					    u16 queue_id);
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
>  void xsk_set_tx_need_wakeup(struct xsk_buff_pool *pool);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 36dc5199037e..c2b64ffeb9e6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1102,6 +1102,13 @@ netdev_get_by_index_lock_ops_compat(struct net *net, int ifindex)
>  	return __netdev_put_lock_ops_compat(dev, net);
>  }
>  
> +struct net_device *
> +netdev_put_lock(struct net_device *dev, netdevice_tracker *tracker)
> +{
> +	netdev_tracker_free(dev, tracker);
> +	return __netdev_put_lock(dev, dev_net(dev));
> +}
> +
>  struct net_device *
>  netdev_xa_find_lock(struct net *net, struct net_device *dev,
>  		    unsigned long *index)
> diff --git a/net/core/dev.h b/net/core/dev.h
> index da18536cbd35..9bcb76b325d0 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -30,6 +30,8 @@ netdev_napi_by_id_lock(struct net *net, unsigned int napi_id);
>  struct net_device *dev_get_by_napi_id(unsigned int napi_id);
>  
>  struct net_device *__netdev_put_lock(struct net_device *dev, struct net *net);
> +struct net_device *netdev_put_lock(struct net_device *dev,
> +				   netdevice_tracker *tracker);
>  struct net_device *
>  netdev_xa_find_lock(struct net *net, struct net_device *dev,
>  		    unsigned long *index);
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index aae75431858d..cd4dc4eef029 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -1122,7 +1122,151 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  int netdev_nl_queue_create_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return -EOPNOTSUPP;
> +	const int qmaxtype = ARRAY_SIZE(netdev_queue_id_nl_policy) - 1;
> +	const int lmaxtype = ARRAY_SIZE(netdev_lease_nl_policy) - 1;
> +	int err, ifindex, ifindex_lease, queue_id, queue_id_lease;
> +	struct nlattr *qtb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
> +	struct nlattr *ltb[ARRAY_SIZE(netdev_lease_nl_policy)];
> +	struct netdev_rx_queue *rxq, *rxq_lease;
> +	struct net_device *dev, *dev_lease;
> +	netdevice_tracker dev_tracker;
> +	struct nlattr *nest;
> +	struct sk_buff *rsp;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_LEASE))
> +		return -EINVAL;
> +	if (nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]) !=
> +	    NETDEV_QUEUE_TYPE_RX) {
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_QUEUE_TYPE]);
> +		return -EINVAL;
> +	}
> +
> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
> +
> +	nest = info->attrs[NETDEV_A_QUEUE_LEASE];
> +	err = nla_parse_nested(ltb, lmaxtype, nest,
> +			       netdev_lease_nl_policy, info->extack);
> +	if (err < 0)
> +		return err;
> +	if (NL_REQ_ATTR_CHECK(info->extack, nest, ltb, NETDEV_A_LEASE_IFINDEX) ||
> +	    NL_REQ_ATTR_CHECK(info->extack, nest, ltb, NETDEV_A_LEASE_QUEUE))
> +		return -EINVAL;
> +	if (ltb[NETDEV_A_LEASE_NETNS_ID]) {
> +		NL_SET_BAD_ATTR(info->extack, ltb[NETDEV_A_LEASE_NETNS_ID]);
> +		return -EINVAL;
> +	}
> +
> +	ifindex_lease = nla_get_u32(ltb[NETDEV_A_LEASE_IFINDEX]);
> +
> +	nest = ltb[NETDEV_A_LEASE_QUEUE];
> +	err = nla_parse_nested(qtb, qmaxtype, nest,
> +			       netdev_queue_id_nl_policy, info->extack);
> +	if (err < 0)
> +		return err;
> +	if (NL_REQ_ATTR_CHECK(info->extack, nest, qtb, NETDEV_A_QUEUE_ID) ||
> +	    NL_REQ_ATTR_CHECK(info->extack, nest, qtb, NETDEV_A_QUEUE_TYPE))
> +		return -EINVAL;
> +	if (nla_get_u32(qtb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
> +		NL_SET_BAD_ATTR(info->extack, qtb[NETDEV_A_QUEUE_TYPE]);
> +		return -EINVAL;
> +	}
> +	if (ifindex == ifindex_lease) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Lease ifindex cannot be the same as queue creation ifindex");
> +		return -EINVAL;
> +	}
> +
> +	queue_id_lease = nla_get_u32(qtb[NETDEV_A_QUEUE_ID]);
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
> +	dev = netdev_get_by_index_lock(genl_info_net(info), ifindex);
> +	if (!dev) {
> +		err = -ENODEV;
> +		goto err_genlmsg_free;
> +	}
> +	if (!netdev_can_create_queue(dev, info->extack)) {
> +		err = -EINVAL;
> +		goto err_unlock_dev;
> +	}
> +
> +	dev_lease = netdev_get_by_index(genl_info_net(info), ifindex_lease,
> +					&dev_tracker, GFP_KERNEL);
> +	if (!dev_lease) {
> +		err = -ENODEV;
> +		goto err_unlock_dev;
> +	}
> +	if (!netdev_can_lease_queue(dev_lease, info->extack)) {
> +		netdev_put(dev_lease, &dev_tracker);
> +		err = -EINVAL;
> +		goto err_unlock_dev;
> +	}
> +
> +	dev_lease = netdev_put_lock(dev_lease, &dev_tracker);
> +	if (!dev_lease) {
> +		err = -ENODEV;
> +		goto err_unlock_dev;
> +	}
> +	if (queue_id_lease >= dev_lease->real_num_rx_queues) {
> +		err = -ERANGE;
> +		NL_SET_BAD_ATTR(info->extack, qtb[NETDEV_A_QUEUE_ID]);
> +		goto err_unlock_dev_lease;
> +	}
> +	if (netdev_queue_busy(dev_lease, queue_id_lease, info->extack)) {
> +		err = -EBUSY;
> +		goto err_unlock_dev_lease;
> +	}
> +
> +	rxq_lease = __netif_get_rx_queue(dev_lease, queue_id_lease);
> +	rxq = __netif_get_rx_queue(dev, dev->real_num_rx_queues - 1);
> +
> +	if (rxq->lease && rxq->lease->dev != dev_lease) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Leasing multiple queues from different devices not supported");
> +		goto err_unlock_dev_lease;
> +	}
> +
> +	err = queue_id = dev->queue_mgmt_ops->ndo_queue_create(dev);
> +	if (err < 0) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Device is unable to create a new queue");
> +		goto err_unlock_dev_lease;
> +	}
> +
> +	rxq = __netif_get_rx_queue(dev, queue_id);
> +	netdev_rx_queue_lease(rxq, rxq_lease);
> +
> +	nla_put_u32(rsp, NETDEV_A_QUEUE_ID, queue_id);
> +	genlmsg_end(rsp, hdr);
> +
> +	netdev_unlock(dev_lease);
> +	netdev_unlock(dev);
> +
> +	return genlmsg_reply(rsp, info);
> +
> +err_unlock_dev_lease:
> +	netdev_unlock(dev_lease);
> +err_unlock_dev:
> +	netdev_unlock(dev);
> +err_genlmsg_free:
> +	nlmsg_free(rsp);
> +	return err;
>  }
>  
>  void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
> diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
> index 251f27a8307f..fae92ee090c4 100644
> --- a/net/core/netdev_queues.c
> +++ b/net/core/netdev_queues.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
>  #include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
> +#include <net/xdp_sock_drv.h>
>  
>  /**
>   * netdev_queue_get_dma_dev() - get dma device for zero-copy operations
> @@ -25,3 +27,58 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
>  	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
>  }
>  
> +bool netdev_can_create_queue(const struct net_device *dev,
> +			     struct netlink_ext_ack *extack)
> +{
> +	if (dev->dev.parent) {
> +		NL_SET_ERR_MSG(extack, "Device is not a virtual device");
> +		return false;
> +	}
> +	if (!dev->queue_mgmt_ops ||
> +	    !dev->queue_mgmt_ops->ndo_queue_create) {
> +		NL_SET_ERR_MSG(extack, "Device does not support queue creation");
> +		return false;
> +	}
> +	if (dev->real_num_rx_queues < 1 ||
> +	    dev->real_num_tx_queues < 1) {
> +		NL_SET_ERR_MSG(extack, "Device must have at least one real queue");
> +		return false;
> +	}
> +	return true;
> +}
> +
> +bool netdev_can_lease_queue(const struct net_device *dev,
> +			    struct netlink_ext_ack *extack)
> +{
> +	if (!dev->dev.parent) {
> +		NL_SET_ERR_MSG(extack, "Lease device is a virtual device");
> +		return false;
> +	}
> +	if (!netif_device_present(dev)) {
> +		NL_SET_ERR_MSG(extack, "Lease device has been removed from the system");
> +		return false;
> +	}
> +	if (!dev->queue_mgmt_ops) {
> +		NL_SET_ERR_MSG(extack, "Lease device does not support queue management operations");
> +		return false;
> +	}
> +	return true;
> +}
> +
> +bool netdev_queue_busy(struct net_device *dev, int idx,
> +		       struct netlink_ext_ack *extack)
> +{
> +	if (netif_rxq_is_leased(dev, idx)) {
> +		NL_SET_ERR_MSG(extack, "Lease device queue is already leased");
> +		return true;
> +	}
> +	if (xsk_get_pool_from_qid(dev, idx)) {
> +		NL_SET_ERR_MSG(extack, "Lease device queue in use by AF_XDP");
> +		return true;
> +	}
> +	if (netif_rxq_has_mp(dev, idx)) {
> +		NL_SET_ERR_MSG(extack, "Lease device queue in use by memory provider");
> +		return true;
> +	}
> +	return false;
> +}
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index c7d9341b7630..ed85dfb434a0 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -9,15 +9,57 @@
>  
>  #include "page_pool_priv.h"
>  
> -/* See also page_pool_is_unreadable() */
> -bool netif_rxq_has_unreadable_mp(struct net_device *dev, int idx)
> +void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
> +			   struct netdev_rx_queue *rxq_src)
> +{
> +	netdev_assert_locked(rxq_src->dev);
> +	netdev_assert_locked(rxq_dst->dev);
> +
> +	WARN_ON_ONCE(READ_ONCE(rxq_src->dev->reg_state) == NETREG_UNREGISTERING);

I might have missed some of your discussions with Jakub, but what is
this WARN_ON_ONCE above trying to catch? And why not handle it explicitly
(via returning an error from netdev_rx_queue_lease)?

