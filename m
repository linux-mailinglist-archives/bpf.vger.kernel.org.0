Return-Path: <bpf+bounces-12012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F47C6799
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 10:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E6B1C20FA9
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F241EA73;
	Thu, 12 Oct 2023 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5320317;
	Thu, 12 Oct 2023 08:33:30 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F40291;
	Thu, 12 Oct 2023 01:33:28 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VtzyJcc_1697099604;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VtzyJcc_1697099604)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 16:33:25 +0800
Message-ID: <1697099560.6227698-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 00/22] virtio-net: support AF_XDP zero copy
Date: Thu, 12 Oct 2023 16:32:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011100057.535f3834@kernel.org>
 <1697075634.444064-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsadYH8Y-KOxPX6vPic7pBqzj2DLnog5osuBDtypKgEZA@mail.gmail.com>
In-Reply-To: <CACGkMEsadYH8Y-KOxPX6vPic7pBqzj2DLnog5osuBDtypKgEZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 12 Oct 2023 15:50:13 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Thu, Oct 12, 2023 at 9:58=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Wed, 11 Oct 2023 10:00:57 -0700, Jakub Kicinski <kuba@kernel.org> wr=
ote:
> > > On Wed, 11 Oct 2023 17:27:06 +0800 Xuan Zhuo wrote:
> > > > ## AF_XDP
> > > >
> > > > XDP socket(AF_XDP) is an excellent bypass kernel network framework.=
 The zero
> > > > copy feature of xsk (XDP socket) needs to be supported by the drive=
r. The
> > > > performance of zero copy is very good. mlx5 and intel ixgbe already=
 support
> > > > this feature, This patch set allows virtio-net to support xsk's zer=
ocopy xmit
> > > > feature.
> > >
> > > You're moving the driver and adding a major feature.
> > > This really needs to go via net or bpf.
> > > If you have dependencies in other trees please wait for
> > > after the merge window.
> >
> >
> > If so, I can remove the first two commits.
> >
> > Then, the sq uses the premapped mode by default.
> > And we can use the api virtqueue_dma_map_single_attrs to replace the
> > virtqueue_dma_map_page_attrs.
> >
> > And then I will fix that on the top.
> >
> > Hi Micheal and Jason, is that ok for you?
>
> I would go with what looks easy for you but I think Jakub wants the
> series to go with next-next (this is what we did in the past for
> networking specific features that is done in virtio-net). So we need
> to tweak the prefix to use net-next instead of vhost.

OK.

I will fix that in next version.

Thanks.

>
> Thanks
>
>
> >
> > Thanks.
> >
>

