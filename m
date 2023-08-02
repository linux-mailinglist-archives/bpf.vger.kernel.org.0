Return-Path: <bpf+bounces-6650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9565E76C273
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 03:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6B71C210DF
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 01:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D48A40;
	Wed,  2 Aug 2023 01:47:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF97E;
	Wed,  2 Aug 2023 01:47:45 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB673F1;
	Tue,  1 Aug 2023 18:47:42 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VosmxL9_1690940857;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VosmxL9_1690940857)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:47:38 +0800
Message-ID: <1690940214.7564142-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Wed, 2 Aug 2023 09:36:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org,
 "David S.  Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo  Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel  Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John   Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Pavel Begunkov <asml.silence@gmail.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230728080305.5fe3737c@kernel.org>
 <CACGkMEs5uc=ct8BsJzV2SEJzAGXqCP__yxo-MBa6d6JzDG4YOg@mail.gmail.com>
 <20230731084651.16ec0a96@kernel.org>
 <1690855424.7821567-1-xuanzhuo@linux.alibaba.com>
 <20230731193606.25233ed9@kernel.org>
 <1690858650.8698683-2-xuanzhuo@linux.alibaba.com>
 <20230801084510.1c2460b9@kernel.org>
In-Reply-To: <20230801084510.1c2460b9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 1 Aug 2023 08:45:10 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 1 Aug 2023 10:57:30 +0800 Xuan Zhuo wrote:
> > > You have this working and benchmarked or this is just and idea?
> >
> > This is not just an idea. I said that has been used on large scale.
> >
> > This is the library for the APP to use the AF_XDP. We has open it.
> > https://gitee.com/anolis/libxudp
> >
> > This is the Alibaba version of the nginx. That has been opened, that su=
pported
> > to work with the libray to use AF_XDP.
> > http://tengine.taobao.org/
> >
> > I supported this on our kernel release Anolis/Alinux.
>
> Interesting!
>
> > The work was done about 2 years ago. You know, I pushed the first versi=
on to
> > enable AF_XDP on virtio-net about two years ago. I never thought the jo=
b would
> > be so difficult.
>
> Me neither, but it is what it is.
>
> > The nic (virtio-net) of AliYun can reach 24,000,000PPS.
> > So I think there is no different with the real HW on the performance.
> >
> > With the AF_XDP, the UDP pps is seven times that of the kernel udp stac=
k.
>
> UDP pps or QUIC pps? UDP with or without GSO?

UDP PPS without GSO.

>
> Do you have measurements of how much it saves in real world workloads?
> I'm asking mostly out of curiosity, not to question the use case.

YES=EF=BC=8Cthe result is affected by the request size, we can reach 10-40%.
The smaller the request size, the lower the result.

>
> > > What about io_uring zero copy w/ pre-registered buffers.
> > > You'll get csum offload, GSO, all the normal perf features.
> >
> > We tried io-uring, but it was not suitable for our scenario.
> >
> > Yes, now the AF_XDP does not support the csum offload and GSO.
> > This is indeed a small problem.
>
> Can you say more about io-uring suitability? It can do zero copy
> and recently-ish Pavel optimized it quite a bit.

First, AF_XDP is also zero-copy. We also use XDP for a few things.

And this was all about two years ago, so we have to say something about io-=
uring
two years ago.

As far as I know, io-uring still use kernel udp stack, AF_XDP can
skip all kernel stack directly to driver.

So here, io-ring does not have too much advantage.

Thanks.


