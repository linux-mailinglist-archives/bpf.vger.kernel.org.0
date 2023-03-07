Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6427A6AD440
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 02:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjCGBs0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 20:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCGBsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 20:48:25 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C629340C6;
        Mon,  6 Mar 2023 17:48:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VdJ7o38_1678153700;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VdJ7o38_1678153700)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 09:48:20 +0800
Message-ID: <1678153623.7521684-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio_net: add checking sq is full inside xdp xmit
Date:   Tue, 7 Mar 2023 09:47:03 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        Yichun Zhang <yichun@openresty.com>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
 <20230306041535.73319-3-xuanzhuo@linux.alibaba.com>
 <20230306125344-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230306125344-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 6 Mar 2023 12:57:34 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Mar 06, 2023 at 12:15:35PM +0800, Xuan Zhuo wrote:
> > If the queue of xdp xmit is not an independent queue, then when the xdp
> > xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> > the following error.
> >
> > net ens4: Unexpected TXQ (0) queue failure: -28
> >
> > This patch adds a check whether sq is full in XDP Xmit.
> >
> > Reported-by: Yichun Zhang <yichun@openresty.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 777de0ec0b1b..3001b9a548e5 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -302,6 +302,8 @@ struct padded_vnet_hdr {
> >
> >  static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
> >  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> > +static void check_sq_full(struct virtnet_info *vi, struct net_device *dev,
> > +			  struct send_queue *sq);
> >
> >  static bool is_xdp_frame(void *ptr)
> >  {
> > @@ -341,6 +343,16 @@ static int rxq2vq(int rxq)
> >  	return rxq * 2;
> >  }
> >
>
> I'd really rather we ordered functions reasonably so declarations
> are not needed.

Yes, but this function depends on some other functions. If we put this function
above, then these dependent functions must be processed. The current method
should be a relatively simple way.

Thanks.


>
> > +static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> > +{
> > +	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> > +		return false;
> > +	else if (q < vi->curr_queue_pairs)
> > +		return true;
> > +	else
> > +		return false;
> > +}
> > +
> >  static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
> >  {
> >  	return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> > @@ -686,6 +698,9 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> >  	}
> >  	ret = nxmit;
> >
> > +	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > +		check_sq_full(vi, dev, sq);
> > +
> >  	if (flags & XDP_XMIT_FLUSH) {
> >  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
> >  			kicks = 1;
> > @@ -1784,16 +1799,6 @@ static void check_sq_full(struct virtnet_info *vi, struct net_device *dev,
> >  	}
> >  }
> >
> > -static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> > -{
> > -	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> > -		return false;
> > -	else if (q < vi->curr_queue_pairs)
> > -		return true;
> > -	else
> > -		return false;
> > -}
> > -
> >  static void virtnet_poll_cleantx(struct receive_queue *rq)
> >  {
> >  	struct virtnet_info *vi = rq->vq->vdev->priv;
> > --
> > 2.32.0.3.g01195cf9f
>
