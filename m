Return-Path: <bpf+bounces-7207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98841773691
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 04:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EA71C20DE6
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 02:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBDAEC1;
	Tue,  8 Aug 2023 02:26:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65584656
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 02:26:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A561B183
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 19:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691461579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3bPtKkgi1i397NDq9plny0QBkcNq3/yfnepW49dbsU=;
	b=DAWrkLw/OfWnLYJmhHuELtqTbaOEbGbqgdvQ/22hj7Fopw55EjKQKZxJtvliCll7QFMRV2
	It2GUi09GNeP5lTNdHVioxZGQod/e2Mj/AxTyQcZWrt634qNgVFp9wmQj/O/Lv/R8cTnJA
	A5yYsKJzH1ORd9rn9PmhyMgPJA2KnAQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-mhhNHMxKPZC249RhS0448Q-1; Mon, 07 Aug 2023 22:26:18 -0400
X-MC-Unique: mhhNHMxKPZC249RhS0448Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe0800f960so5091355e87.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 19:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691461576; x=1692066376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3bPtKkgi1i397NDq9plny0QBkcNq3/yfnepW49dbsU=;
        b=M+AQswX5mfY5BFK0yjCHIQLv4OxPsjH6coG5UuNQpaFQubkMruWSfMFe64/qQqJZ6k
         0Qc5pvqcSbH3ONNARUDPtFfihk46tJOkczdF1o7K3H/Fz8bNSfi7xA0E3k/o7E6NsY2X
         V5Xh9MF5zvWDa2cIKSNdXm5O1xP+fhQYe5ujL4afkyRxtxIGA0k9E00DktQz8qyn5Nxu
         u3TXyWBXs1A8lqIdXxXh5JAxy3e5XLjYgxxZ+0Z63q2yEWma3mvlMm/r5liWgGiuvGTU
         tL3kRADpv0rRwWzdlXSHvQ0hbQkd6qyl1ZWOWOykykjQH/lP3GkuOG/+XeYJyayXw0V9
         NMEQ==
X-Gm-Message-State: AOJu0YwzXWBGgjJh1DuHIDYlJMO7vPJA/C6ybapGkDOuJJTpnif6umiL
	RKmVcrfzsZXH0wh9A9dF53CDbPWxH25z44bwX5eE0NSEHTVxaP+WPCuDIjJLYA5iNdswZfvxHE+
	/40E7wbvXzNc8rdhwSRGWbz9WS5dZ
X-Received: by 2002:a2e:9dd2:0:b0:2b9:e24d:21f6 with SMTP id x18-20020a2e9dd2000000b002b9e24d21f6mr8537853ljj.20.1691461576629;
        Mon, 07 Aug 2023 19:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNEm+Y6WWl+v6SW3V5FlF+qxZoMtf5PiRX9TeSa9v9sMGFuEkcW6A6jSYVhkrmtuO0whT+JZmflWz4uo7ct/I=
X-Received: by 2002:a2e:9dd2:0:b0:2b9:e24d:21f6 with SMTP id
 x18-20020a2e9dd2000000b002b9e24d21f6mr8537832ljj.20.1691461576310; Mon, 07
 Aug 2023 19:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com> <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org> <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org> <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com> <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com> <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org> <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 10:26:04 +0800
Message-ID: <CACGkMEsoivXfBV75whjyB0yreUNh7HeucGLw3Bq9Zvu1NGnj_g@mail.gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
	virtualization@lists.linux-foundation.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 7, 2023 at 2:15=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Wed, 2 Aug 2023 09:49:31 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com>=
 wrote:
> > On Tue, 1 Aug 2023 12:17:47 -0400, "Michael S. Tsirkin" <mst@redhat.com=
> wrote:
> > > On Fri, Jul 28, 2023 at 02:02:33PM +0800, Xuan Zhuo wrote:
> > > > On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > > > > On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirkin" <mst@red=
hat.com> wrote:
> > > > > > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> > > > > > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@in=
fradead.org> wrote:
> > > > > > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirki=
n wrote:
> > > > > > > > > Well I think we can add wrappers like virtio_dma_sync and=
 so on.
> > > > > > > > > There are NOP for non-dma so passing the dma device is ha=
rmless.
> > > > > > > >
> > > > > > > > Yes, please.
> > > > > > >
> > > > > > >
> > > > > > > I am not sure I got this fully.
> > > > > > >
> > > > > > > Are you mean this:
> > > > > > > https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@=
linux.alibaba.com/
> > > > > > > https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@=
linux.alibaba.com/
> > > > > > >
> > > > > > > Then the driver must do dma operation(map and sync) by these =
virtio_dma_* APIs.
> > > > > > > No care the device is non-dma device or dma device.
> > > > > >
> > > > > > yes
> > > > > >
> > > > > > > Then the AF_XDP must use these virtio_dma_* APIs for virtio d=
evice.
> > > > > >
> > > > > > We'll worry about AF_XDP when the patch is posted.
> > > > >
> > > > > YES.
> > > > >
> > > > > We discussed it. They voted 'no'.
> > > > >
> > > > > http://lore.kernel.org/all/20230424082856.15c1e593@kernel.org
> > > >
> > > >
> > > > Hi guys, this topic is stuck again. How should I proceed with this =
work?
> > > >
> > > > Let me briefly summarize:
> > > > 1. The problem with adding virtio_dma_{map, sync} api is that, for =
AF_XDP and
> > > > the driver layer, we need to support these APIs. The current conclu=
sion of
> > > > AF_XDP is no.
> > > >
> > > > 2. Set dma_set_mask_and_coherent, then we can use DMA API uniformly=
 inside
> > > > driver. This idea seems to be inconsistent with the framework desig=
n of DMA. The
> > > > conclusion is no.
> > > >
> > > > 3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_PL=
ATFORM, it
> > > > uses DMA API. And this type of device is the future direction, so w=
e only
> > > > support DMA premapped for this type of virtio device. The problem w=
ith this
> > > > solution is that virtqueue_dma_dev() only returns dev in some cases=
, because
> > > > VIRTIO_F_ACCESS_PLATFORM is supported in such cases.

Could you explain the issue a little bit more?

E.g if we limit AF_XDP to ACESS_PLATFROM only, why does
virtqueue_dma_dev() only return dev in some cases?

Thanks

>Otherwise NULL is returned.
> > > > This option is currently NO.
> > > >
> > > > So I'm wondering what should I do, from a DMA point of view, is the=
re any
> > > > solution in case of using DMA API?
> > > >
> > > > Thank you
> > >
> > >
> > > I think it's ok at this point, Christoph just asked you
> > > to add wrappers for map/unmap for use in virtio code.
> > > Seems like a cosmetic change, shouldn't be hard.
> >
> > Yes, that is not hard, I has this code.
> >
> > But, you mean that the wrappers is just used for the virtio driver code=
?
> > And we also offer the  API virtqueue_dma_dev() at the same time?
> > Then the driver will has two chooses to do DMA.
> >
> > Is that so?
>
> Ping.
>
> Thanks
>
> >
> >
> > > Otherwise I haven't seen significant comments.
> > >
> > >
> > > Christoph do I summarize what you are saying correctly?
> > > --
> > > MST
> > >
> >
>


