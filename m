Return-Path: <bpf+bounces-12675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AC97CF0DE
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 09:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0913B212F2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 07:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A2CA56;
	Thu, 19 Oct 2023 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C44D262;
	Thu, 19 Oct 2023 07:15:23 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C689130;
	Thu, 19 Oct 2023 00:15:20 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuT9Ext_1697699715;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuT9Ext_1697699715)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 15:15:16 +0800
Message-ID: <1697699628.4189832-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 13/19] virtio_net: xsk: tx: virtnet_free_old_xmit() distinguishes xsk buffer
Date: Thu, 19 Oct 2023 15:13:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-14-xuanzhuo@linux.alibaba.com>
 <20231016164434.3a1a51e1@kernel.org>
 <1697508125.07194-1-xuanzhuo@linux.alibaba.com>
 <20231019023739-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231019023739-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 19 Oct 2023 02:38:16 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Oct 17, 2023 at 10:02:05AM +0800, Xuan Zhuo wrote:
> > On Mon, 16 Oct 2023 16:44:34 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Mon, 16 Oct 2023 20:00:27 +0800 Xuan Zhuo wrote:
> > > > @@ -305,9 +311,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
> > > >
> > > >  			stats->bytes += xdp_get_frame_len(frame);
> > > >  			xdp_return_frame(frame);
> > > > +		} else {
> > > > +			stats->bytes += virtnet_ptr_to_xsk(ptr);
> > > > +			++xsknum;
> > > >  		}
> > > >  		stats->packets++;
> > > >  	}
> > > > +
> > > > +	if (xsknum)
> > > > +		xsk_tx_completed(sq->xsk.pool, xsknum);
> > > >  }
> > >
> > > sparse complains:
> > >
> > > drivers/net/virtio/virtio_net.h:322:41: warning: incorrect type in argument 1 (different address spaces)
> > > drivers/net/virtio/virtio_net.h:322:41:    expected struct xsk_buff_pool *pool
> > > drivers/net/virtio/virtio_net.h:322:41:    got struct xsk_buff_pool
> > > [noderef] __rcu *pool
> > >
> > > please build test with W=1 C=1
> >
> > OK. I will add C=1 to may script.
> >
> > Thanks.
>
> And I hope we all understand, rcu has to be used properly it's not just
> about casting the warning away.


Yes. I see. I will use rcu_dereference() and rcu_read_xxx().

Thanks.

>
> --
> MST
>

