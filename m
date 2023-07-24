Return-Path: <bpf+bounces-5704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1723A75EC95
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 09:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D12F2814A0
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 07:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D12186D;
	Mon, 24 Jul 2023 07:33:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1A15C5
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 07:33:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829E21A1
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690183978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obJKEr7PPFK0pLw7ZGOQfDHbqPEfj1yDCcKlqGnAfNY=;
	b=isgWf84nq2zW75OZo68IreQZ1lFD9rId/lj5Ehw7+Xuc/z7NEWb847Ea3hmcSAekp1gT31
	WmRy7zOKcgb0Ys0DwX6w4Zco9KLd1ZNdqSySfozA1RHLwsQjFEkYx67s3y1owonI7lJHJL
	QRL2xT5555RB9cwJjDmG40WwYmnkJng=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-NJVHaDlHPvWL86nAJhnVZA-1; Mon, 24 Jul 2023 03:32:56 -0400
X-MC-Unique: NJVHaDlHPvWL86nAJhnVZA-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b70cabc656so36178031fa.0
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 00:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690183975; x=1690788775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obJKEr7PPFK0pLw7ZGOQfDHbqPEfj1yDCcKlqGnAfNY=;
        b=MsEoedFwuDUybitwK5bT3N2pD4OHRqhC5QaRYyXhQNKoKmxlbCB71sqnOB2C/6ZnEh
         LzC3/muKQom7TYfiSWX/gSbMos///ts1MPYGaUBlGmjhOeihYTbauUfoKJRDMECLgDkI
         1Ja1U7ITRZjeM1Bo4IhDX8Pb24D5KTsojXoVLMg6EzmIyL3bVsYGxjMYXbpKfG3T2pIx
         ajeCJY077O/sj6SLwqx1pBwGVtkzBtgOXOXWOqrBD9gekJ2WV2qbRWvr1oUItTlAeZYM
         yZ9SsM8yh/zj6uQ+HwkCFW/E4ysJ6NBcgK4EHpWphpEPIrQiZmOzPmFn9xMSPLIr/Wmt
         mfcQ==
X-Gm-Message-State: ABy/qLbHq1PIzH/hbe8BYTlc5LTBbSDtp317W9PqqC9+QIvSUeF3dS3F
	Hk9ZTxGBnQGl5I3cmlwUfjkm7gcyQtasf+2WPKaOpX7shzgjdu0on/Of5tTJpvkqITIvCH0Pc2D
	mV2TZekjMzH1f
X-Received: by 2002:a2e:988d:0:b0:2b6:fa92:479e with SMTP id b13-20020a2e988d000000b002b6fa92479emr5540265ljj.42.1690183975468;
        Mon, 24 Jul 2023 00:32:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFha0kr3za1tiulXuUUpmLoGr/15/UKVQHTMghA8BLPnDMFKNbxFPtb4c1QICku3M6nKSRLrA==
X-Received: by 2002:a2e:988d:0:b0:2b6:fa92:479e with SMTP id b13-20020a2e988d000000b002b6fa92479emr5540249ljj.42.1690183975012;
        Mon, 24 Jul 2023 00:32:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e0:3800:a16e:b2a0:7d06:58aa])
        by smtp.gmail.com with ESMTPSA id h19-20020a1ccc13000000b003fbcdba1a63sm4012097wmb.12.2023.07.24.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 00:32:54 -0700 (PDT)
Date: Mon, 24 Jul 2023 03:32:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavinl@nvidia.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, jiri@nvidia.com, dtatulea@nvidia.com,
	gavi@nvidia.com, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next V3 3/4] virtio_net: support per queue interrupt
 coalesce command
Message-ID: <20230724032451-mutt-send-email-mst@kernel.org>
References: <20230724034048.51482-1-gavinl@nvidia.com>
 <20230724034048.51482-4-gavinl@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724034048.51482-4-gavinl@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 06:40:47AM +0300, Gavin Li wrote:
> Add interrupt_coalesce config in send_queue and receive_queue to cache user
> config.
> 
> Send per virtqueue interrupt moderation config to underline device in order
> to have more efficient interrupt moderation and cpu utilization of guest
> VM.
> 
> Signed-off-by: Gavin Li <gavinl@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/virtio_net.c        | 120 ++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_net.h |  14 ++++
>  2 files changed, 122 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 802ed21453f5..0c3ee1e26ece 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -144,6 +144,8 @@ struct send_queue {
>  
>  	struct virtnet_sq_stats stats;
>  
> +	struct virtnet_interrupt_coalesce intr_coal;
> +
>  	struct napi_struct napi;
>  
>  	/* Record whether sq is in reset state. */
> @@ -161,6 +163,8 @@ struct receive_queue {
>  
>  	struct virtnet_rq_stats stats;
>  
> +	struct virtnet_interrupt_coalesce intr_coal;
> +
>  	/* Chain pages by the private ptr. */
>  	struct page *pages;
>  
> @@ -212,6 +216,7 @@ struct control_buf {
>  	struct virtio_net_ctrl_rss rss;
>  	struct virtio_net_ctrl_coal_tx coal_tx;
>  	struct virtio_net_ctrl_coal_rx coal_rx;
> +	struct virtio_net_ctrl_coal_vq coal_vq;
>  };
>  
>  struct virtnet_info {
> @@ -3078,6 +3083,55 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>  	return 0;
>  }
>  
> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> +					 u16 vqn, u32 max_usecs, u32 max_packets)
> +{
> +	struct scatterlist sgs;
> +
> +	vi->ctrl->coal_vq.vqn = cpu_to_le16(vqn);
> +	vi->ctrl->coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
> +	vi->ctrl->coal_vq.coal.max_packets = cpu_to_le32(max_packets);
> +	sg_init_one(&sgs, &vi->ctrl->coal_vq, sizeof(vi->ctrl->coal_vq));
> +
> +	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +				  VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET,
> +				  &sgs))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int virtnet_send_notf_coal_vq_cmds(struct virtnet_info *vi,
> +					  struct ethtool_coalesce *ec,
> +					  u16 queue)
> +{
> +	int err;
> +
> +	if (ec->rx_coalesce_usecs || ec->rx_max_coalesced_frames) {
> +		err = virtnet_send_ctrl_coal_vq_cmd(vi, rxq2vq(queue),
> +						    ec->rx_coalesce_usecs,
> +						    ec->rx_max_coalesced_frames);
> +		if (err)
> +			return err;
> +		/* Save parameters */
> +		vi->rq[queue].intr_coal.max_usecs = ec->rx_coalesce_usecs;
> +		vi->rq[queue].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> +	}
> +
> +	if (ec->tx_coalesce_usecs || ec->tx_max_coalesced_frames) {
> +		err = virtnet_send_ctrl_coal_vq_cmd(vi, txq2vq(queue),
> +						    ec->tx_coalesce_usecs,
> +						    ec->tx_max_coalesced_frames);
> +		if (err)
> +			return err;
> +		/* Save parameters */
> +		vi->sq[queue].intr_coal.max_usecs = ec->tx_coalesce_usecs;
> +		vi->sq[queue].intr_coal.max_packets = ec->tx_max_coalesced_frames;
> +	}
> +
> +	return 0;
> +}
> +
>  static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>  {
>  	/* usecs coalescing is supported only if VIRTIO_NET_F_NOTF_COAL
> @@ -3094,23 +3148,39 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>  }
>  
>  static int virtnet_set_coalesce_one(struct net_device *dev,
> -				    struct ethtool_coalesce *ec)
> +				    struct ethtool_coalesce *ec,
> +				    bool per_queue,
> +				    u32 queue)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	int ret, i, napi_weight;
> +	int queue_count = per_queue ? 1 : vi->max_queue_pairs;
> +	int queue_number = per_queue ? queue : 0;

Actually can't we refactor this? This whole function is littered
with if/else branches. just code it separately - the only
common part is:

        napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
        if (napi_weight ^ vi->sq[0].napi.weight) {
                if (dev->flags & IFF_UP)
                        return -EBUSY;
                else
                        update_napi = true;
        }

so just move this to a helper and have two functions - global and
per queue.



>  	bool update_napi = false;
> +	int ret, i, napi_weight;
> +
> +	if (queue >= vi->max_queue_pairs)
> +		return -EINVAL;
>  
>  	/* Can't change NAPI weight if the link is up */
>  	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> -	if (napi_weight ^ vi->sq[0].napi.weight) {
> -		if (dev->flags & IFF_UP)
> -			return -EBUSY;
> -		else
> +	for (i = queue_number; i < queue_count; i++) {
> +		if (napi_weight ^ vi->sq[i].napi.weight) {
> +			if (dev->flags & IFF_UP)
> +				return -EBUSY;
> +
>  			update_napi = true;
> +			/* All queues that belong to [queue_number, queue_count] will be
> +			 * updated for the sake of simplicity, which might not be necessary
> +			 */
> +			queue_number = i;
> +			break;
> +		}
>  	}
>  
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
> +	if (!per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>  		ret = virtnet_send_notf_coal_cmds(vi, ec);
> +	else if (per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> +		ret = virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
>  	else
>  		ret = virtnet_coal_params_supported(ec);
>  
> @@ -3118,7 +3188,7 @@ static int virtnet_set_coalesce_one(struct net_device *dev,
>  		return ret;
>  
>  	if (update_napi) {
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = queue_number; i < queue_count; i++)
>  			vi->sq[i].napi.weight = napi_weight;
>  	}
>  
> @@ -3130,19 +3200,29 @@ static int virtnet_set_coalesce(struct net_device *dev,
>  				struct kernel_ethtool_coalesce *kernel_coal,
>  				struct netlink_ext_ack *extack)
>  {
> -	return virtnet_set_coalesce_one(dev, ec);
> +	return virtnet_set_coalesce_one(dev, ec, false, 0);
>  }
>  
>  static int virtnet_get_coalesce_one(struct net_device *dev,
> -				    struct ethtool_coalesce *ec)
> +				    struct ethtool_coalesce *ec,
> +				    bool per_queue,
> +				    u32 queue)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
> +	if (queue >= vi->max_queue_pairs)
> +		return -EINVAL;
> +
> +	if (!per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL)) {
>  		ec->rx_coalesce_usecs = vi->intr_coal_rx.max_usecs;
>  		ec->tx_coalesce_usecs = vi->intr_coal_tx.max_usecs;
>  		ec->tx_max_coalesced_frames = vi->intr_coal_tx.max_packets;
>  		ec->rx_max_coalesced_frames = vi->intr_coal_rx.max_packets;
> +	} else if (per_queue && virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
> +		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
> +		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
> +		ec->rx_max_coalesced_frames = vi->rq[queue].intr_coal.max_packets;
>  	} else {
>  		ec->rx_max_coalesced_frames = 1;
>  
> @@ -3158,7 +3238,21 @@ static int virtnet_get_coalesce(struct net_device *dev,
>  				struct kernel_ethtool_coalesce *kernel_coal,
>  				struct netlink_ext_ack *extack)
>  {
> -	return virtnet_get_coalesce_one(dev, ec);
> +	return virtnet_get_coalesce_one(dev, ec, false, 0);
> +}
> +
> +static int virtnet_set_per_queue_coalesce(struct net_device *dev,
> +					  u32 queue,
> +					  struct ethtool_coalesce *ec)
> +{
> +	return virtnet_set_coalesce_one(dev, ec, true, queue);
> +}
> +
> +static int virtnet_get_per_queue_coalesce(struct net_device *dev,
> +					  u32 queue,
> +					  struct ethtool_coalesce *ec)
> +{
> +	return virtnet_get_coalesce_one(dev, ec, true, queue);
>  }
>  
>  static void virtnet_init_settings(struct net_device *dev)
> @@ -3291,6 +3385,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
>  	.set_link_ksettings = virtnet_set_link_ksettings,
>  	.set_coalesce = virtnet_set_coalesce,
>  	.get_coalesce = virtnet_get_coalesce,
> +	.set_per_queue_coalesce = virtnet_set_per_queue_coalesce,
> +	.get_per_queue_coalesce = virtnet_get_per_queue_coalesce,
>  	.get_rxfh_key_size = virtnet_get_rxfh_key_size,
>  	.get_rxfh_indir_size = virtnet_get_rxfh_indir_size,
>  	.get_rxfh = virtnet_get_rxfh,
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index 12c1c9699935..cc65ef0f3c3e 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -56,6 +56,7 @@
>  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> +#define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
>  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
>  #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
>  #define VIRTIO_NET_F_GUEST_USO6	55	/* Guest can handle USOv6 in. */
> @@ -391,5 +392,18 @@ struct virtio_net_ctrl_coal_rx {
>  };
>  
>  #define VIRTIO_NET_CTRL_NOTF_COAL_RX_SET		1
> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET		2
> +#define VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET		3
> +
> +struct virtio_net_ctrl_coal {
> +	__le32 max_packets;
> +	__le32 max_usecs;
> +};
> +
> +struct  virtio_net_ctrl_coal_vq {
> +	__le16 vqn;
> +	__le16 reserved;
> +	struct virtio_net_ctrl_coal coal;
> +};
>  
>  #endif /* _UAPI_LINUX_VIRTIO_NET_H */
> -- 
> 2.39.1


