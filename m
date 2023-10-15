Return-Path: <bpf+bounces-12240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC697C9AF5
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 21:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC131C20995
	for <lists+bpf@lfdr.de>; Sun, 15 Oct 2023 19:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EC5107BE;
	Sun, 15 Oct 2023 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzAeLYxX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C0D1FB9;
	Sun, 15 Oct 2023 19:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97783C433C8;
	Sun, 15 Oct 2023 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697397481;
	bh=R0SlymlymmOuTU6Y0PAYkc/uL1cbwCHuMM8dCsez20Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzAeLYxXLkurO36USIDtsCpz3cykmUdW7qX6KNXb+bLZEptR9M7VZT3d57ISNUIoK
	 DNxUiZkPxadlfupn/AOiksB9ky/w2LM34L5DmRt1z0pdym6MvX5WfOFPSyggaNrbTX
	 +upTfMuNBk5+QlY1yy0ywbuqPq+HFBO4E+NABk/Voq85kLTPc6F8MX1XvmvymsHdu/
	 jDT/nn6k3kxAIslKCKCF3uaJqmuLvaIt3vgU5UYwg5kHYUCrmSfFUnmS3JLHLJEgMT
	 qB+1pUAX5tbb2qlx0P0zlDbx+TEKn5JDyZ84R/TBKHSJI+JV+qqjrsOrjbblv1/ukP
	 vQ+OtKN0xJJDA==
Date: Sun, 15 Oct 2023 21:17:56 +0200
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH vhost 12/22] virtio_net: xsk: bind/unbind xsk
Message-ID: <20231015191756.GD1386676@kernel.org>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-13-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011092728.105904-13-xuanzhuo@linux.alibaba.com>

On Wed, Oct 11, 2023 at 05:27:18PM +0800, Xuan Zhuo wrote:

...

> +static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	struct device *dma_dev;
> +	struct virtnet_rq *rq;
> +	struct virtnet_sq *sq;
> +	int err1, err2;
> +
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;
> +
> +	sq = &vi->sq[qid];
> +	rq = &vi->rq[qid];
> +
> +	dma_dev = virtqueue_dma_dev(rq->vq);
> +
> +	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
> +
> +	xsk_pool_dma_unmap(sq->xsk.pool, 0);

nit: the line above makes Sparse a bit unhappy:

 .../xsk.c:168:35: warning: incorrect type in argument 1 (different address spaces)
 .../xsk.c:168:35:    expected struct xsk_buff_pool *pool
 .../xsk.c:168:35:    got struct xsk_buff_pool [noderef] __rcu *pool

> +
> +	/* Sync with the XSK wakeup and with NAPI. */
> +	synchronize_net();
> +
> +	err1 = virtnet_sq_bind_xsk_pool(vi, sq, NULL);
> +	err2 = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
> +
> +	return err1 | err2;
> +}

...

