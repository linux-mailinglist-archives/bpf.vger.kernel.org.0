Return-Path: <bpf+bounces-12533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2757CD7B8
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 11:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EC6B20F45
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0227717993;
	Wed, 18 Oct 2023 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745E134BF;
	Wed, 18 Oct 2023 09:19:34 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784B5F9;
	Wed, 18 Oct 2023 02:19:32 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuQCd7i_1697620768;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VuQCd7i_1697620768)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 17:19:29 +0800
Message-ID: <1697620622.3183842-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce virtqueue_dma_[un]map_page_attrs
Date: Wed, 18 Oct 2023 17:17:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
 <20231018035751-mutt-send-email-mst@kernel.org>
 <1697616022.630633-2-xuanzhuo@linux.alibaba.com>
 <20231018044204-mutt-send-email-mst@kernel.org>
 <1697619441.5367694-3-xuanzhuo@linux.alibaba.com>
 <20231018051201-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231018051201-mutt-send-email-mst@kernel.org>
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

On Wed, 18 Oct 2023 05:13:44 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Oct 18, 2023 at 04:57:21PM +0800, Xuan Zhuo wrote:
> > On Wed, 18 Oct 2023 04:44:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Oct 18, 2023 at 04:00:22PM +0800, Xuan Zhuo wrote:
> > > > On Wed, 18 Oct 2023 03:59:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> > > > > > Hi Michael,
> > > > > >
> > > > > > Do you think it's appropriate to push the first two patches of this patch set to
> > > > > > linux 6.6?
> > > > > >
> > > > > > Thanks.
> > > > >
> > > > > I generally treat patchsets as a whole unless someone asks me to do
> > > > > otherwise. Why do you want this?
> > > >
> > > > As we discussed, the patch set supporting AF_XDP will be push to net-next.
> > > > But the two patchs belong to the vhost.
> > > >
> > > > So, if you think that is appropriate, I will post a new patchset(include the two
> > > > patchs without virtio-net + AF_XDP) to vhost. I wish that can be merged to 6.6.
> > >
> > > Oh wait 6.6? Too late really, merge window has been closed for weeks.
> >
> > I mean as a fix. So I ask you do you think it is appropriate?
>
> Sure if there's a bugfix please post is separately - what issues do
> these two patches fix? this is the part I'm missing. Especially patch 2
> which just adds a new API.


No bugfix. That is the requirement of the supporting AF_XDP.

So please ignore my question. Sorry ^_^.

Thanks.


>
> > >
> > > > Then when the 6.7 net-next merge window is open, I can push this patch set to 6.7.
> > > > The v1 version use the virtqueue_dma_map_single_attrs to replace
> > > > virtqueue_dma_map_page_attrs. But I think we should use virtqueue_dma_map_page_attrs.
> > > >
> > > > Thanks.
> > > >
> > >
> > > Get a complete working patchset that causes no regressions posted first please
> > > then we will discuss merge strategy.
> > > I would maybe just put everything in one file for now, easier to merge,
> > > refactor later when it's all upstream. But up to you.
> >
> > OK. I will get a working patchset firstly.
> >
> > Thanks.
> >
> > >
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>

