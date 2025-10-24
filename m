Return-Path: <bpf+bounces-72147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D0EC07C72
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46533B3A40
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5B242D95;
	Fri, 24 Oct 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQxlR8IZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3F34A3D2
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331013; cv=none; b=dZccwos0wETfyQkMOO0MWuPtmRwkEBFjNnSAhHs+V1jvORkGIMJBHAgTRWeUjEnMXn9zwt1qoamDjWc2O8k6CG6JrdfuYsHfEofIskOoAaoMKatU++2nxFWIiby675A5T+y3yrG8H8DJLenHsuCHgwB78QiKP2OjHSIKKxmNdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331013; c=relaxed/simple;
	bh=TLJCfzmKFt/fyeAodJh1L0RNKxUAkg2mvHuuHAcwfAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGqxha6NutGo+PQX83a3VNOcAvyTG76OiDH8Z7PByKdRruqr5YK5z697jSZkmw3bKn+nB1uQt4NRT3taB9HrFwq+XffdgEhnZ15KGm6Y5/473bRPQeagNYGpV5QZL1yg/1ADoyXCkPNERNYFQvfH8pYK4OyVppQpWVeCKm2hCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQxlR8IZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a28226dd13so1445795b3a.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 11:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761331011; x=1761935811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/p9MJq52UuKppFKE5ODwKIT5v7QxFOxkS5Z3SporLhQ=;
        b=eQxlR8IZNmUVp+ZCpAYgPqmumiZWyZ94J76Vo5Y58Z7pi2RkSXh8SQC9gwuwD3uyNY
         XGAhCglqGSsfEDqYN5qHs5kI1V7vGYlrDJMkLsyus+tzca3GDSA2ub8o6xnQMy+NugE4
         t9Qdt+d1l2NBTuyTvqx4sY+Zhbh2W+0XWFtzB8xrzLZzirIfb2kShOkpIucWqlud0N4c
         yot24mYpbQ9T5C/R1TFvjUD1z5+drXSc87Cmp7+qTcbx3Hy5a9o13e4c9MLKRjbEqjB3
         CWz3cZGS107L5ehn3lcSMS10GafAS/5XmQ00mHpJh0Y1xL+FCriT+tqPHUGMVqHjv99L
         UZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331011; x=1761935811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p9MJq52UuKppFKE5ODwKIT5v7QxFOxkS5Z3SporLhQ=;
        b=oBBhaf7DXg41nO1WwwCfj8cN6WonDuc/Fv4Z1A5ClAOfw0OrkkBcxSAPSRumxULZCa
         Er23k2hJLX6KWjxNN3hQtFpErH4MwjYvg5L782LIw5Ah7ieYtbsIHIP51wTAyuZ2PitP
         ju/e9SN9q34lEY231YuxpT+mn8hWZyOZ4GVV703c3+9LUFeGzMIZyuYFGKwGz67EAD4E
         kk1Z6nqcJKXvMC2RYS9/ObS2JBA1SxYsVL37IQy+lebTMHsZvPQRn+sqdrOGFJUpIJ6D
         8c1DDixbgoRKJ/T1MoIXU2Hwy+91pnZ/6H44myi+BDxIfAJhxGwWqmUOAOFAg8iQcma6
         mHKA==
X-Forwarded-Encrypted: i=1; AJvYcCXJB4FQ3FQSoH+IIuTsAKRmVgW5F9UC9suVizCh1h8k9pjGB5NdZGSJShNqx3HTisjjZtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRHB0gJvum0B9ozelxRy96uuP6eT8ootzZ//j2uMBQAdSCClph
	7GsC+4PbYjwNQeFFi3Eg7QB7AoMVuOfS/epOzvhQGh9JIzM3lpBYt/o=
X-Gm-Gg: ASbGncsZcoAF6N7KY0Zqsdp6fRuLTyOGqtlnLU0ha5GrShGv4kUv7tECcLKZ5JeZsEY
	uq1poFzKEtT0nH5LHOOk27VtACnC3Rct3q107g7GgEVhqx198rdNtCXVE41JSFj/r8gi2iz5sUo
	OiDBYI6L/B5hF+aqA6Va8dPoIXAlAv2Pg0rX3dUn/0AIpuSJPcffUYKGxHmrAVOx+T8iAPc3uw6
	U5wWEO6PNt29GJBKw3/FF30s9DVDmWK1ymdCQMyzWy2KWTUVw3clq9j6NF73RbUij9bsGACGO6E
	GlRVjOwfJv0kVb76FdTribR1H6IBw8WdmKTrSaTvFlnH/wvXVzDHSyCmqS0PzeKu5TXvaFbdIJj
	fJiwHoykj+UiMJscBH8cqRnapuCEpJpyr1vGWK4LIFOUo3WM+xzDDzkFrmIb293xDAlzJtMI2ub
	rkomf5QoXZUldp0vB4k6VNSBejy8NWN2DG9ZYDTTCW7/27PD49DSwC/S7wtOL5o3Z+EiH8ru6r5
	/zaE5R9ebYKD8nGqHC0MAdR9Nf6ovMDj4PgadQPFcnq0ehBcdyIm3d1j9SfKztjCXU=
X-Google-Smtp-Source: AGHT+IElytHOLHqAJt40PmFD33nDV30/pQ9pjEo3pyPzbMNhsNB5oVrUYLU5jCyElmliYgWdmv3Z0Q==
X-Received: by 2002:a05:6a20:3d84:b0:2af:65aa:4eef with SMTP id adf61e73a8af0-334a8621973mr36217923637.47.1761331010417;
        Fri, 24 Oct 2025 11:36:50 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33fb0191b1dsm6473090a91.18.2025.10.24.11.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:36:50 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:36:49 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v3 05/15] net: Proxy net_mp_{open,close}_rxq for
 mapped queues
Message-ID: <aPvHQYXJ8SGA-lSw@mini-arch>
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-6-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020162355.136118-6-daniel@iogearbox.net>

On 10/20, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> When a process in a container wants to setup a memory provider, it will
> use the virtual netdev and a mapped rxq, and call net_mp_{open,close}_rxq
> to try and restart the queue. At this point, proxy the queue restart on
> the real rxq in the physical netdev.
> 
> For memory providers (io_uring zero-copy rx and devmem), it causes the
> real rxq in the physical netdev to be filled from a memory provider that
> has DMA mapped memory from a process within a container.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  include/net/page_pool/memory_provider.h |  4 +-
>  net/core/netdev_rx_queue.c              | 57 +++++++++++++++++--------
>  2 files changed, 41 insertions(+), 20 deletions(-)
> 
> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
> index ada4f968960a..b6f811c3416b 100644
> --- a/include/net/page_pool/memory_provider.h
> +++ b/include/net/page_pool/memory_provider.h
> @@ -23,12 +23,12 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dma_addr_t addr);
>  void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *niov);
>  void net_mp_niov_clear_page_pool(struct net_iov *niov);
>  
> -int net_mp_open_rxq(struct net_device *dev, unsigned ifq_idx,
> +int net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  		    struct pp_memory_provider_params *p);
>  int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  		      const struct pp_memory_provider_params *p,
>  		      struct netlink_ext_ack *extack);
> -void net_mp_close_rxq(struct net_device *dev, unsigned ifq_idx,
> +void net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
>  		      struct pp_memory_provider_params *old_p);
>  void __net_mp_close_rxq(struct net_device *dev, unsigned int rxq_idx,
>  			const struct pp_memory_provider_params *old_p);
> diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
> index 8ee289316c06..b4ff3497e086 100644
> --- a/net/core/netdev_rx_queue.c
> +++ b/net/core/netdev_rx_queue.c
> @@ -170,48 +170,63 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>  		      struct netlink_ext_ack *extack)
>  {
>  	struct netdev_rx_queue *rxq;
> +	bool needs_unlock = false;
>  	int ret;
>  
>  	if (!netdev_need_ops_lock(dev))
>  		return -EOPNOTSUPP;
> -
>  	if (rxq_idx >= dev->real_num_rx_queues) {
>  		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>  		return -ERANGE;
>  	}
> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>  
> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
> +	rxq = netif_get_rx_queue_peer_locked(&dev, &rxq_idx, &needs_unlock);
> +	if (!rxq) {
> +		NL_SET_ERR_MSG(extack, "rx queue peered to a virtual netdev");
> +		return -EBUSY;
> +	}
> +	if (!dev->dev.parent) {
> +		NL_SET_ERR_MSG(extack, "rx queue is mapped to a virtual netdev");
> +		ret = -EBUSY;
> +		goto out;
> +	}
>  	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
>  		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  	if (dev->cfg->hds_thresh) {
>  		NL_SET_ERR_MSG(extack, "hds-thresh is not zero");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
>  	if (dev_xdp_prog_count(dev)) {
>  		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto out;
>  	}
> -
> -	rxq = __netif_get_rx_queue(dev, rxq_idx);
>  	if (rxq->mp_params.mp_ops) {
>  		NL_SET_ERR_MSG(extack, "designated queue already memory provider bound");
> -		return -EEXIST;
> +		ret = -EEXIST;
> +		goto out;
>  	}
>  #ifdef CONFIG_XDP_SOCKETS
>  	if (rxq->pool) {
>  		NL_SET_ERR_MSG(extack, "designated queue already in use by AF_XDP");
> -		return -EBUSY;
> +		ret = -EBUSY;
> +		goto out;
>  	}
>  #endif
> -
>  	rxq->mp_params = *p;
>  	ret = netdev_rx_queue_restart(dev, rxq_idx);
>  	if (ret) {
>  		rxq->mp_params.mp_ops = NULL;
>  		rxq->mp_params.mp_priv = NULL;
>  	}
> +out:
> +	if (needs_unlock)
> +		netdev_unlock(dev);

Can we do something better than needs_unlock flag? Maybe something like the
following?

netif_put_rx_queue_peer_locked(orig_dev, dev)
{
	if (orig_dev != dev)
		netdev_unlock(dev);
}

Then we can do:

orig_dev = dev;
rxq = netif_get_rx_queue_peer_locked(&dev, &rx_idx);
...
netif_put_rx_queue_peer_locked(orig_dev, dev);

