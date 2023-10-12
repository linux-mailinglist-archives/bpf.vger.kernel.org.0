Return-Path: <bpf+bounces-12026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FF47C6D6F
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 13:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C756F1C210A6
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B025101;
	Thu, 12 Oct 2023 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0C24A11;
	Thu, 12 Oct 2023 11:55:38 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843B64C0C;
	Thu, 12 Oct 2023 04:55:35 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0Vu-mkwQ_1697111731;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vu-mkwQ_1697111731)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 19:55:32 +0800
Message-ID: <1697111642.7917345-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 21/22] virtio_net: update tx timeout record
Date: Thu, 12 Oct 2023 19:54:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-22-xuanzhuo@linux.alibaba.com>
 <20231012050936-mutt-send-email-mst@kernel.org>
 <1697101953.6236846-1-xuanzhuo@linux.alibaba.com>
 <20231012052017-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231012052017-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 12 Oct 2023 05:36:56 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Oct 12, 2023 at 05:12:33PM +0800, Xuan Zhuo wrote:
> > On Thu, 12 Oct 2023 05:10:55 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Oct 11, 2023 at 05:27:27PM +0800, Xuan Zhuo wrote:
> > > > If send queue sent some packets, we update the tx timeout
> > > > record to prevent the tx timeout.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  drivers/net/virtio/xsk.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > > > index 7abd46bb0e3d..e605f860edb6 100644
> > > > --- a/drivers/net/virtio/xsk.c
> > > > +++ b/drivers/net/virtio/xsk.c
> > > > @@ -274,6 +274,16 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
> > > >
> > > >  	virtnet_xsk_check_queue(sq);
> > > >
> > > > +	if (stats.packets) {
> > > > +		struct netdev_queue *txq;
> > > > +		struct virtnet_info *vi;
> > > > +
> > > > +		vi = sq->vq->vdev->priv;
> > > > +
> > > > +		txq = netdev_get_tx_queue(vi->dev, sq - vi->sq);
> > > > +		txq_trans_cond_update(txq);
> > > > +	}
> > > > +
> > > >  	u64_stats_update_begin(&sq->stats.syncp);
> > > >  	sq->stats.packets += stats.packets;
> > > >  	sq->stats.bytes += stats.bytes;
> > >
> > > I don't get what this is doing. Is there some kind of race here you
> > > are trying to address? And what introduced the race?
> >
> >
> > Because the xsk xmit shares the send queue with the kernel xmit,
> > then when I do benchmark, the xsk will always use the send queue,
> > so the kernel may have no chance to do xmit, the tx watchdog
> > thinks that the send queue is hang and prints tx timeout log.
> >
> > So I call the txq_trans_cond_update() to tell the tx watchdog
> > that the send queue is working.
> >
> > Thanks.
>
> Don't like this hack.
> So packets are stuck in queue - that's not good is it?
> Is ours the only driver that shares queues like this?

NO.

And txq_trans_cond_update() is called by many net drivers for the similar reason.

Thanks


>
> >
> > >
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > >
> > >
>

