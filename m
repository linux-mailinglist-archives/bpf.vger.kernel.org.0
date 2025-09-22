Return-Path: <bpf+bounces-69250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0408EB924BC
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 18:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010343ABF10
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953043126BB;
	Mon, 22 Sep 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1eKEgZ4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131F311C37
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559686; cv=none; b=NDSn75wT1HO6SZFmyjETNk1+Z5XnMUIFDEEWEVu9DxmXtI7mIEZiHmK82ofyh4oSswIoDd+wMT+uDD0vyiDFWGBNHrfuuQjYKSzevqnNsy45WNqKwoePJmnEFHk8I2SN3GlLqeJzy32tDoRBo06VYlBQY1/teDMDekOcZd5dd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559686; c=relaxed/simple;
	bh=jWXdeGGGgkjMzjGrqhFHOvMVLqFH9NLTOg+0l5iyG4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ndp59u0A0t4vzTE5vVo9ilHUoEzU3JcbnY8kX/AD3104gOgDP1Q9iW3FszBXyVGHjeuNMulMT9lQs+W1frJS06vflkCCrv+poB2QNbDdZf3UwRIUDUSjeqYjHJurfwzVAvU184MQyv0/SODX3Nxjn+Tdmcqmxl2p2zE/DHT6fTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1eKEgZ4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-330631e534eso4095878a91.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758559683; x=1759164483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLd/PEFRdlVhmkXjk+h4NVsNhitE9KvBZ+AXpxa+Bco=;
        b=O1eKEgZ4+afWq230dyw9VEpChT79Rdnl5e2dkUeQkf1/CQCp016p1b2Pibv9myjlqe
         ntLbUUsKYNQRywvIVAvsk9yXN58QCZo5Ga5XTmS2NwTXzGVTnmoQLlpcsP06zgRW4WIS
         kfaRDCoQi59Hg8WnrrAauJTh7ZVnM9afeYRtyS51vQFsGza7o8gnM4//M+aAKv4BMNMM
         /VJJu71JXqodtB7KyHixZ8aeo8ehpz2tR183W8bfGu4VK6y4V68AUWjhRZ5Hh0JpJQtP
         DcnOSxTuUYO6RCaNpm7UrLWXjuBQP4/3UBdDmR5ULKkKe0yxV40lctjDMayQwVFdMyNg
         MysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758559683; x=1759164483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLd/PEFRdlVhmkXjk+h4NVsNhitE9KvBZ+AXpxa+Bco=;
        b=ibbYB5KR24B5slyudV6MyIMrF8owsiQyl+6xDAnx7unynka8+JxAHrjqU59pDobv8U
         9xCRFUiJlgLtDWH+cHZW+Z4EfGcxHOcPg5Sb31tXKiUl0Ov8oj+5ft8Ewq/uRmnUhC+X
         vXzoS1hZ05hQVpBpkf98YMTQe54rpU6p/PSJNKBzaotPFK1eIPIqdvPBUi0zK9njs00H
         CNi1KZuHpcFFdUgIkb22hOTxsaazDtbX5edTzae0C0K5jhL8fRjnZpu8Yim+BaqpMGrH
         +SqTPR7I9Z7gs5hdiEIhDIs84/BspsYdnE6zKWx+AhMr1e792VM2FGGrdvUnnvy/bn5E
         qnvA==
X-Forwarded-Encrypted: i=1; AJvYcCUHioyiVOggBnFIfRRCSGy3b3Z7PoMxSAFsb25bm2LhUqHAyyNMGJVPdTGyCxFPdAbkY4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCB3l2QPF/QHOWYMFZkBrGDiyBtDsUKKYPUgagICgPZUzlSf1
	C/1Askn19hPSaRDKWTmeWVsUQ1o8MUSggw3o+R7s7gNYvNjEdumTndw=
X-Gm-Gg: ASbGnct9CNJqWmo++Ya8VWMVvGPYsVrqAF/JNIMgx5MQn9F4Dl9mZp5VFYsSWjjxF7/
	xm81pzcgyE9yueKKMRPCKG2NoE2jB6yBpsIRoeAlT4nZEiCKX6Igf0rrjOr0khK5SyTCbsUWscL
	YEj3kKUObyV5xa3js7FCe/mQMlWDxAjeCLZdj7NuRLaF4LoZZIS3z9xbMPSZPXENn73RCIZcNk3
	BxIEbBByFmWLvtEuPisNbS2V+dyFjH4Zi5kbk0kgRCBZlsHTcTJvOcoDA5CZ2zM7u0dhBwHKhxf
	PmHhlDEW4UgXBDXsDAE1Ga8foS+Vs5215Ya2DnbLAHwHpAOddF47tAAkWrFgG6xI7vQbIXQXtE5
	lmFcA6Z368Jszy1AObpdH1eiLM/x0ZAJYVOnUgZ7tr9Jp+zP9981+8pwfYX/2W5aUp2NwpPnK3u
	On9zuXO9QmMsR7wdb0QHeWm/EID128zZcEOZSYgEvEgT78yapDprAADJVDsynJsWhCYAPosz5sq
	HfV
X-Google-Smtp-Source: AGHT+IF+oD35LIv3CJ6KA7GHnZhPc4X7hT0udCz/Fxf7vUFgycWpsJe9ezDmgaCzuDGvU8c7RvG9Lw==
X-Received: by 2002:a17:90b:3b49:b0:32e:37a1:cf65 with SMTP id 98e67ed59e1d1-33098362f99mr16420429a91.28.1758559682804;
        Mon, 22 Sep 2025 09:48:02 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-332906a5348sm875704a91.1.2025.09.22.09.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 09:48:02 -0700 (PDT)
Date: Mon, 22 Sep 2025 09:48:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 13/20] xsk: Proxy pool management for mapped
 queues
Message-ID: <aNF9waxmQUipXe1_@mini-arch>
References: <20250919213153.103606-1-daniel@iogearbox.net>
 <20250919213153.103606-14-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919213153.103606-14-daniel@iogearbox.net>

On 09/19, Daniel Borkmann wrote:
> Similarly what we do for net_mp_{open,close}_rxq for mapped queues,
> proxy also the xsk_{reg,clear}_pool_at_qid via __netif_get_rx_queue_peer
> such that when a virtual netdev picked a mapped rxq, the request gets
> through to the real rxq in the physical netdev.
> 
> Change the function signatures for queue_id to unsigned int in order
> to pass the queue_id parameter into __netif_get_rx_queue_peer. The
> proxying is only relevant for queue_id < dev->real_num_rx_queues since
> right now its only supported for rxqs.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  include/net/xdp_sock_drv.h |  4 ++--
>  net/xdp/xsk.c              | 16 +++++++++++-----
>  net/xdp/xsk.h              |  5 ++---
>  3 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 47120666d8d6..709af292cba7 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -29,7 +29,7 @@ bool xsk_tx_peek_desc(struct xsk_buff_pool *pool, struct xdp_desc *desc);
>  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 max);
>  void xsk_tx_release(struct xsk_buff_pool *pool);
>  struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
> -					    u16 queue_id);
> +					    unsigned int queue_id);
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool);
>  void xsk_set_tx_need_wakeup(struct xsk_buff_pool *pool);
>  void xsk_clear_rx_need_wakeup(struct xsk_buff_pool *pool);
> @@ -286,7 +286,7 @@ static inline void xsk_tx_release(struct xsk_buff_pool *pool)
>  }
>  
>  static inline struct xsk_buff_pool *
> -xsk_get_pool_from_qid(struct net_device *dev, u16 queue_id)
> +xsk_get_pool_from_qid(struct net_device *dev, unsigned int queue_id)
>  {
>  	return NULL;
>  }
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index cf40c70ee59f..b9efa6d8a112 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -23,6 +23,8 @@
>  #include <linux/netdevice.h>
>  #include <linux/rculist.h>
>  #include <linux/vmalloc.h>
> +
> +#include <net/netdev_queues.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/busy_poll.h>
>  #include <net/netdev_lock.h>
> @@ -111,19 +113,20 @@ bool xsk_uses_need_wakeup(struct xsk_buff_pool *pool)
>  EXPORT_SYMBOL(xsk_uses_need_wakeup);
>  
>  struct xsk_buff_pool *xsk_get_pool_from_qid(struct net_device *dev,
> -					    u16 queue_id)
> +					    unsigned int queue_id)
>  {
>  	if (queue_id < dev->real_num_rx_queues)
>  		return dev->_rx[queue_id].pool;
>  	if (queue_id < dev->real_num_tx_queues)
>  		return dev->_tx[queue_id].pool;
> -
>  	return NULL;
>  }
>  EXPORT_SYMBOL(xsk_get_pool_from_qid);
>  
> -void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
> +void xsk_clear_pool_at_qid(struct net_device *dev, unsigned int queue_id)
>  {
> +	if (queue_id < dev->real_num_rx_queues)
> +		__netif_get_rx_queue_peer(&dev, &queue_id);
>  	if (queue_id < dev->num_rx_queues)
>  		dev->_rx[queue_id].pool = NULL;
>  	if (queue_id < dev->num_tx_queues)
> @@ -135,7 +138,7 @@ void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id)
>   * This might also change during run time.
>   */
>  int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
> -			u16 queue_id)
> +			unsigned int queue_id)
>  {
>  	if (queue_id >= max_t(unsigned int,
>  			      dev->real_num_rx_queues,
> @@ -143,6 +146,10 @@ int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *pool,
>  		return -EINVAL;
>  	if (xsk_get_pool_from_qid(dev, queue_id))
>  		return -EBUSY;
> +	if (queue_id < dev->real_num_rx_queues)
> +		__netif_get_rx_queue_peer(&dev, &queue_id);
> +	if (xsk_get_pool_from_qid(dev, queue_id))
> +		return -EBUSY;
>  
>  	pool->netdev = dev;
>  	pool->queue_id = queue_id;

I feel like both of the above are also gonna be problematic wrt netdev
lock. The callers lock the netdev, the callers will also have
to resolve the virtual->real queue mapping. Hacking up the
queue/netdev deep in the call stack in a few places is not gonna work.

Maybe also add assert for the (new) netdev lock to __netif_get_rx_queue_peer
to trigger these.

