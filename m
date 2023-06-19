Return-Path: <bpf+bounces-2855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7C7356F0
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51BE281142
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD2E10940;
	Mon, 19 Jun 2023 12:31:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63861774C;
	Mon, 19 Jun 2023 12:31:54 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB0DD;
	Mon, 19 Jun 2023 05:31:52 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VlXENi4_1687177908;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VlXENi4_1687177908)
          by smtp.aliyun-inc.com;
          Mon, 19 Jun 2023 20:31:49 +0800
Date: Mon, 19 Jun 2023 20:31:48 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next 3/4] virtio-net: support coexistence of XDP and
 _F_GUEST_CSUM
Message-ID: <20230619123148.GB74977@h68b04307.sqa.eu95>
References: <20230619105738.117733-1-hengqi@linux.alibaba.com>
 <20230619105738.117733-4-hengqi@linux.alibaba.com>
 <20230619072320-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619072320-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 07:26:44AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 19, 2023 at 06:57:37PM +0800, Heng Qi wrote:
> > We are now re-probing the csum related fields and  trying
> > to have XDP and RX hw checksum capabilities coexist on the
> > XDP path. For the benefit of:
> > 1. RX hw checksum capability can be used if XDP is loaded.
> > 2. Avoid packet loss when loading XDP in the vm-vm scenario.
> > 
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 36 ++++++++++++++++++++++++------------
> >  1 file changed, 24 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 07b4801d689c..25b486ab74db 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1709,6 +1709,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >  	struct net_device *dev = vi->dev;
> >  	struct sk_buff *skb;
> >  	struct virtio_net_hdr_mrg_rxbuf *hdr;
> > +	__u8 flags;
> >  
> >  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> >  		pr_debug("%s: short packet %i\n", dev->name, len);
> > @@ -1717,6 +1718,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >  		return;
> >  	}
> >  
> > +	flags = ((struct virtio_net_hdr_mrg_rxbuf *)buf)->hdr.flags;
> > +
> >  	if (vi->mergeable_rx_bufs)
> >  		skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> >  					stats);
> 
> what's going on here?

Thanks for pointing this out. Will insert into mergeable and small modes
respectively.

> 
> > @@ -1728,19 +1731,28 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> >  	if (unlikely(!skb))
> >  		return;
> >  
> > -	hdr = skb_vnet_hdr(skb);
> > -	if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> > -		virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
> > -
> > -	if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > -		skb->ip_summed = CHECKSUM_UNNECESSARY;
> > +	if (unlikely(vi->xdp_enabled)) {
> > +		if (virtnet_set_csum_after_xdp(vi, skb, flags) < 0) {
> > +			pr_debug("%s: errors occurred in flow dissector setting csum",
> > +				 dev->name);
> > +			goto frame_err;
> > +		}
> >  
> > -	if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > -				  virtio_is_little_endian(vi->vdev))) {
> > -		net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> > -				     dev->name, hdr->hdr.gso_type,
> > -				     hdr->hdr.gso_size);
> > -		goto frame_err;
> > +	} else {
> > +		hdr = skb_vnet_hdr(skb);
> > +		if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> > +			virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
> > +
> > +		if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> > +
> > +		if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > +					  virtio_is_little_endian(vi->vdev))) {
> > +			net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> > +					     dev->name, hdr->hdr.gso_type,
> > +					     hdr->hdr.gso_size);
> > +			goto frame_err;
> > +		}
> >  	}
> >  
> >  	skb_record_rx_queue(skb, vq2rxq(rq->vq));
> > -- 
> > 2.19.1.6.gb485710b

