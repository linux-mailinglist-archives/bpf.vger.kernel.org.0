Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FCB317292
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 22:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhBJVmQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 16:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232439AbhBJVmO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Feb 2021 16:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612993248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hi2X5jnGRi7KT3vlKkAdXUsSwPyG3HDv963BA62z9vA=;
        b=MVc4/xHA901ccgJrH6G7F4PWP0eCRvcxVtsKa1YglX/g/MrwwhJWRWwOakjVreGCcr3esa
        MFOlkwU3vtzh5Cw7J8gnxXI60W7Mvek04MChtQds5iN1tQtzHiCFM4dZ4qcAZURIDue4C9
        5G5ONXN9bQiurLv4FPBSCtheF1WMT6s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-dKAXJQqSMXGGn-0oSfFz-w-1; Wed, 10 Feb 2021 16:40:46 -0500
X-MC-Unique: dKAXJQqSMXGGn-0oSfFz-w-1
Received: by mail-wm1-f71.google.com with SMTP id u15so1494019wmm.6
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 13:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hi2X5jnGRi7KT3vlKkAdXUsSwPyG3HDv963BA62z9vA=;
        b=LEiCW533+NouL/Sv2kvU8AP6op3NnNSxEyiIv3MltbpfHafTuF5PmTaUjOgzO6yoEE
         YRMvluVPmpEsllFTlZDOZavqz9Wgw6ILpS/LAWBdUlZ+P2qH71Zo2iCJ3VkJZwGS2EF3
         tkUSGJS+NN9G3oAH7QY5RccTv9+aYLCJyCkPuG8bTYZT7Q64J3wc8h9KRyTStNlzA4A6
         6UGUIcrBAJDc4RnKREp+IDf4TDHEGEY8vUREv2trZeYviRCNDKfXmLHwoYIQIk+BjC4K
         i3gVdA5utQG/PVCSlNAggO2HUXh3Lrvxb/okRtFswl1PvH5zz9cjjLI6C3n1E8Ojrq+l
         wbNw==
X-Gm-Message-State: AOAM533iTgcItmQlk4W1oAqRi2zO5x8HM05/HyFsMUq2Cm0w19FnysqG
        ZaS4MoHA2+ggS9ji8rPFxS5Hwp/iGllZWp/w/r/bDqA5NqT8Vk2fY8rowdwjn84uLzm17Q/TM4O
        cIyrNSTdN9PDT
X-Received: by 2002:a1c:c903:: with SMTP id f3mr1050589wmb.69.1612993245120;
        Wed, 10 Feb 2021 13:40:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEZ8liZuKYUAcB0H7NMYB9jERfv/Iy/eLiiOFihgo+hWnxXSocQL+S/PQhfhUBwNqqpOQigQ==
X-Received: by 2002:a1c:c903:: with SMTP id f3mr1050574wmb.69.1612993244940;
        Wed, 10 Feb 2021 13:40:44 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id j185sm5103692wma.1.2021.02.10.13.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 13:40:44 -0800 (PST)
Date:   Wed, 10 Feb 2021 16:40:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        dust.li@linux.alibaba.com
Subject: Re: [PATCH netdev] virtio-net: support XDP_TX when not more queues
Message-ID: <20210210163945-mutt-send-email-mst@kernel.org>
References: <81abae33fc8dbec37ef0061ff6f6fd696b484a3e.1610523188.git.xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81abae33fc8dbec37ef0061ff6f6fd696b484a3e.1610523188.git.xuanzhuo@linux.alibaba.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 13, 2021 at 04:08:57PM +0800, Xuan Zhuo wrote:
> The number of queues implemented by many virtio backends is limited,
> especially some machines have a large number of CPUs. In this case, it
> is often impossible to allocate a separate queue for XDP_TX.
> 
> This patch allows XDP_TX to run by reuse the existing SQ with
> __netif_tx_lock() hold when there are not enough queues.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

I'd like to get some advice on whether this is ok from some
XDP experts - previously my understanding was that it is
preferable to disable XDP for such devices than
use locks on XDP fast path.

> ---
>  drivers/net/virtio_net.c | 47 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ba8e637..7a3b2a7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -195,6 +195,9 @@ struct virtnet_info {
>  	/* # of XDP queue pairs currently used by the driver */
>  	u16 xdp_queue_pairs;
>  
> +	/* xdp_queue_pairs may be 0, when xdp is already loaded. So add this. */
> +	bool xdp_enabled;
> +
>  	/* I like... big packets and I cannot lie! */
>  	bool big_packets;
>  
> @@ -481,14 +484,34 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>  	return 0;
>  }
>  
> -static struct send_queue *virtnet_xdp_sq(struct virtnet_info *vi)
> +static struct send_queue *virtnet_get_xdp_sq(struct virtnet_info *vi)
>  {
>  	unsigned int qp;
> +	struct netdev_queue *txq;
> +
> +	if (vi->curr_queue_pairs > nr_cpu_ids) {
> +		qp = vi->curr_queue_pairs - vi->xdp_queue_pairs + smp_processor_id();
> +	} else {
> +		qp = smp_processor_id() % vi->curr_queue_pairs;
> +		txq = netdev_get_tx_queue(vi->dev, qp);
> +		__netif_tx_lock(txq, raw_smp_processor_id());
> +	}
>  
> -	qp = vi->curr_queue_pairs - vi->xdp_queue_pairs + smp_processor_id();
>  	return &vi->sq[qp];
>  }
>  
> +static void virtnet_put_xdp_sq(struct virtnet_info *vi)
> +{
> +	unsigned int qp;
> +	struct netdev_queue *txq;
> +
> +	if (vi->curr_queue_pairs <= nr_cpu_ids) {
> +		qp = smp_processor_id() % vi->curr_queue_pairs;
> +		txq = netdev_get_tx_queue(vi->dev, qp);
> +		__netif_tx_unlock(txq);
> +	}
> +}
> +
>  static int virtnet_xdp_xmit(struct net_device *dev,
>  			    int n, struct xdp_frame **frames, u32 flags)
>  {
> @@ -512,7 +535,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	if (!xdp_prog)
>  		return -ENXIO;
>  
> -	sq = virtnet_xdp_sq(vi);
> +	sq = virtnet_get_xdp_sq(vi);
>  
>  	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK)) {
>  		ret = -EINVAL;
> @@ -560,12 +583,13 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	sq->stats.kicks += kicks;
>  	u64_stats_update_end(&sq->stats.syncp);
>  
> +	virtnet_put_xdp_sq(vi);
>  	return ret;
>  }
>  
>  static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
>  {
> -	return vi->xdp_queue_pairs ? VIRTIO_XDP_HEADROOM : 0;
> +	return vi->xdp_enabled ? VIRTIO_XDP_HEADROOM : 0;
>  }
>  
>  /* We copy the packet for XDP in the following cases:
> @@ -1457,12 +1481,13 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  		xdp_do_flush();
>  
>  	if (xdp_xmit & VIRTIO_XDP_TX) {
> -		sq = virtnet_xdp_sq(vi);
> +		sq = virtnet_get_xdp_sq(vi);
>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>  			u64_stats_update_begin(&sq->stats.syncp);
>  			sq->stats.kicks++;
>  			u64_stats_update_end(&sq->stats.syncp);
>  		}
> +		virtnet_put_xdp_sq(vi);
>  	}
>  
>  	return received;
> @@ -2416,12 +2441,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		xdp_qp = nr_cpu_ids;
>  
>  	/* XDP requires extra queues for XDP_TX */
> -	if (curr_qp + xdp_qp > vi->max_queue_pairs) {
> -		NL_SET_ERR_MSG_MOD(extack, "Too few free TX rings available");
> -		netdev_warn(dev, "request %i queues but max is %i\n",
> -			    curr_qp + xdp_qp, vi->max_queue_pairs);
> -		return -ENOMEM;
> -	}
> +	if (curr_qp + xdp_qp > vi->max_queue_pairs)
> +		xdp_qp = 0;
>  
>  	old_prog = rtnl_dereference(vi->rq[0].xdp_prog);
>  	if (!prog && !old_prog)
> @@ -2453,12 +2474,14 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
>  	vi->xdp_queue_pairs = xdp_qp;
>  
> +	vi->xdp_enabled = false;
>  	if (prog) {
>  		for (i = 0; i < vi->max_queue_pairs; i++) {
>  			rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
>  			if (i == 0 && !old_prog)
>  				virtnet_clear_guest_offloads(vi);
>  		}
> +		vi->xdp_enabled = true;
>  	}
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> @@ -2526,7 +2549,7 @@ static int virtnet_set_features(struct net_device *dev,
>  	int err;
>  
>  	if ((dev->features ^ features) & NETIF_F_LRO) {
> -		if (vi->xdp_queue_pairs)
> +		if (vi->xdp_enabled)
>  			return -EBUSY;
>  
>  		if (features & NETIF_F_LRO)
> -- 
> 1.8.3.1

