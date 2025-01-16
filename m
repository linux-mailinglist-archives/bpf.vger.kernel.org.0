Return-Path: <bpf+bounces-49039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBD3A13476
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 08:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5467E18881DC
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 07:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64200198A38;
	Thu, 16 Jan 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V3o+/kXN"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4057F194AD5;
	Thu, 16 Jan 2025 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014201; cv=none; b=lBJakf+ZTTwvuIdvb6k0o8px/kh3rhfAzSVGdvb3OQGiTnquVjWeDO8uedneY2wpLsj/HlIqpjcCXNYBc9mIYZZ6wMqV1rqv6WrZ3GX6CscZherQb7tUhQ1wSwjwULFEsiKfS0GEEd1vT791qokh8ho3Om+DOlwoXWnnf5PTI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014201; c=relaxed/simple;
	bh=pkqdGjdMYi1yzQk1vCN3PKgu8+/8JJKz6CLoOkKB+s8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Egf0DjVeqL/vOtFq96N4MROTvqfrBolbnWxEbG0a5zR9TXGGtvveklUiaAfc+yKzhA7jfmvLwK7fSdalGJUnPR2PceA0ypewiCH7Jmm1pyL+bYptTS3UUUJqIqyeaNfhtm1XPUN/m1FHD3wGEiOxzTXQvyIghSpObLDkfcCfzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V3o+/kXN; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737014197; h=Message-ID:Subject:Date:From:To;
	bh=QyeVoBuE8ZtHm/3gJn14NT7ilefLQr2T3k8o7w8Ll+c=;
	b=V3o+/kXNC4J7+Kle5bZ3MO5P2qt4IG822PS7G9t7WpWYwVOLawutZnNHBM8At5FsLJLwUI3we+Z36UiKJMbkn880qcmrV2JHQ59gNWhQSoTdd5JOeBwN/T/UN6ciNrA2CZ2RiBcGhKunDXxg9ngmuRve+qlORQJak/EiUB6fsWk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WNkwH05_1737014194 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Jan 2025 15:56:35 +0800
Message-ID: <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
Date: Thu, 16 Jan 2025 15:53:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Joe Damato <jdamato@fastly.com>
Cc: gerhard@engleder-embedded.com,
 jasowang@redhat.com,
 leiyang@redhat.com,
 mkarsten@uwaterloo.ca,
 Joe Damato <jdamato@fastly.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
 linux-kernel@vger.kernel.org (open list),
 bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
 netdev@vger.kernel.org
References: <20250116055302.14308-1-jdamato@fastly.com>
 <20250116055302.14308-4-jdamato@fastly.com>
In-Reply-To: <20250116055302.14308-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote:
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps.
>
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
>
> $ sudo ethtool -L ens4 combined 4
>
> $ ./tools/net/ynl/pyynl/cli.py \
>        --spec Documentation/netlink/specs/netdev.yaml \
>        --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'type': 'tx'},
>  {'id': 1, 'ifindex': 2, 'type': 'tx'},
>  {'id': 2, 'ifindex': 2, 'type': 'tx'},
>  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
>
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  v2:
>    - Eliminate RTNL code paths using the API Jakub introduced in patch 1
>      of this v2.
>    - Added virtnet_napi_disable to reduce code duplication as
>      suggested by Jason Wang.
>
>  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index cff18c66b54a..c6fda756dd07 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqueue *vq,
>  	local_bh_enable();
>  }
>
> -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
> +static void virtnet_napi_enable(struct virtqueue *vq,
> +				struct napi_struct *napi)
>  {
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	int q = vq2rxq(vq);
> +	u16 curr_qs;
> +
>  	virtnet_napi_do_enable(vq, napi);
> +
> +	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> +	if (!vi->xdp_enabled || q < curr_qs)
> +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, napi);

So what case the check of xdp_enabled is for?

And I think we should merge this to last commit.

Thanks.

>  }
>
>  static void virtnet_napi_tx_enable(struct virtnet_info *vi,
> @@ -2826,6 +2835,20 @@ static void virtnet_napi_tx_enable(struct virtnet_info *vi,
>  	virtnet_napi_do_enable(vq, napi);
>  }
>
> +static void virtnet_napi_disable(struct virtqueue *vq,
> +				 struct napi_struct *napi)
> +{
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	int q = vq2rxq(vq);
> +	u16 curr_qs;
> +
> +	curr_qs = vi->curr_queue_pairs - vi->xdp_queue_pairs;
> +	if (!vi->xdp_enabled || q < curr_qs)
> +		netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NULL);
> +
> +	napi_disable(napi);
> +}
> +
>  static void virtnet_napi_tx_disable(struct napi_struct *napi)
>  {
>  	if (napi->weight)
> @@ -2842,7 +2865,8 @@ static void refill_work(struct work_struct *work)
>  	for (i = 0; i < vi->curr_queue_pairs; i++) {
>  		struct receive_queue *rq = &vi->rq[i];
>
> -		napi_disable(&rq->napi);
> +		virtnet_napi_disable(rq->vq, &rq->napi);
> +
>  		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
>  		virtnet_napi_enable(rq->vq, &rq->napi);
>
> @@ -3042,7 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>  {
>  	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> -	napi_disable(&vi->rq[qp_index].napi);
> +	virtnet_napi_disable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
>  	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>  }
>
> @@ -3313,7 +3337,7 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	bool running = netif_running(vi->dev);
>
>  	if (running) {
> -		napi_disable(&rq->napi);
> +		virtnet_napi_disable(rq->vq, &rq->napi);
>  		virtnet_cancel_dim(vi, &rq->dim);
>  	}
>  }
> @@ -5932,7 +5956,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	/* Make sure NAPI is not using any XDP TX queues for RX. */
>  	if (netif_running(dev)) {
>  		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			napi_disable(&vi->rq[i].napi);
> +			virtnet_napi_disable(vi->rq[i].vq, &vi->rq[i].napi);
>  			virtnet_napi_tx_disable(&vi->sq[i].napi);
>  		}
>  	}
> --
> 2.25.1
>

