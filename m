Return-Path: <bpf+bounces-4847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF773750373
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 11:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A071C20DE9
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 09:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528811F95B;
	Wed, 12 Jul 2023 09:42:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67614433;
	Wed, 12 Jul 2023 09:42:08 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E310EF;
	Wed, 12 Jul 2023 02:42:03 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VnCXL6R_1689154918;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VnCXL6R_1689154918)
          by smtp.aliyun-inc.com;
          Wed, 12 Jul 2023 17:41:59 +0800
Message-ID: <1689154785.322522-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next V1 3/4] virtio_net: support per queue interrupt coalesce command
Date: Wed, 12 Jul 2023 17:39:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Gavin Li <gavinl@nvidia.com>
Cc: <virtualization@lists.linux-foundation.org>,
 <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>,
 <davem@davemloft.net>,
 <edumazet@google.com>,
 <kuba@kernel.org>,
 <pabeni@redhat.com>,
 <ast@kernel.org>,
 <daniel@iogearbox.net>,
 <hawk@kernel.org>,
 <john.fastabend@gmail.com>,
 <jiri@nvidia.com>,
 <dtatulea@nvidia.com>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230710092005.5062-4-gavinl@nvidia.com>
In-Reply-To: <20230710092005.5062-4-gavinl@nvidia.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Mon, 10 Jul 2023 12:20:04 +0300, Gavin Li <gavinl@nvidia.com> wrote:
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
> ---
>  drivers/net/virtio_net.c        | 117 ++++++++++++++++++++++++++++----
>  include/uapi/linux/virtio_net.h |  14 ++++
>  2 files changed, 119 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 802ed21453f5..333a38e1941f 100644
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
> @@ -3078,6 +3082,56 @@ static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
>  	return 0;
>  }
>
> +static int virtnet_send_ctrl_coal_vq_cmd(struct virtnet_info *vi,
> +					 u16 vqn, u32 max_usecs, u32 max_packets)
> +{
> +	struct virtio_net_ctrl_coal_vq coal_vq = {};

We should alloc this on the heap.

Thanks.


> +	struct scatterlist sgs;
> +
> +	coal_vq.vqn = cpu_to_le16(vqn);
> +	coal_vq.coal.max_usecs = cpu_to_le32(max_usecs);
> +	coal_vq.coal.max_packets = cpu_to_le32(max_packets);
> +	sg_init_one(&sgs, &coal_vq, sizeof(coal_vq));
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
> @@ -3094,23 +3148,36 @@ static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
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
> @@ -3118,7 +3185,7 @@ static int virtnet_set_coalesce_one(struct net_device *dev,
>  		return ret;
>
>  	if (update_napi) {
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = queue_number; i < queue_count; i++)
>  			vi->sq[i].napi.weight = napi_weight;
>  	}
>
> @@ -3130,19 +3197,29 @@ static int virtnet_set_coalesce(struct net_device *dev,
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
> @@ -3158,7 +3235,21 @@ static int virtnet_get_coalesce(struct net_device *dev,
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
> @@ -3291,6 +3382,8 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
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
>

