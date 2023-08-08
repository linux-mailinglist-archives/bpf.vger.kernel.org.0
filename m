Return-Path: <bpf+bounces-7238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845A773D52
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6480280F6F
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A98014A88;
	Tue,  8 Aug 2023 16:04:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C081401D
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:04:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C461B9
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691510628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0l/zIpBzoNd3YD/UzVcSkuz5BdVlgIEgD7g5fXRAKWw=;
	b=ML7uOGWXzUzxZEXOLxB4QceX5fhiQrweU9MLinK61S6ITVN0wNk9zPzjzWIl0mSySrHMPk
	oYyu2D6OcB7l3Gyrac5ik9J/s1WwoiPHmeMrF/KtT7QZASyNX8KKA+dCWtouFcQJIcd6YE
	LaYF14zvkxqNgC+BoVMOaOr/cgYpSXU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-3wuPiNQbPBOg1-fmOUK6LA-1; Mon, 07 Aug 2023 23:59:21 -0400
X-MC-Unique: 3wuPiNQbPBOg1-fmOUK6LA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ba1949656bso39771621fa.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 20:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691467160; x=1692071960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0l/zIpBzoNd3YD/UzVcSkuz5BdVlgIEgD7g5fXRAKWw=;
        b=Jg7zZtyHuTVWW9JzBTPl3CsnlTlOmsaJlaPRWuFwA2ah7I3v2HZ2xENlP6fwA+1Ub6
         z9fpcd2TpI9Wpn++SGpXlFDBPHrHtZ6dn/3fbf6sTGVGPcBdsj/ORRWhymC8pFALV7vV
         bgtCneLUogS2RWxpYcRm1Ecsrz5u1xofrE409Oa9DReOr/9Pk1vZAy0ZtruBmC/lPXAq
         SWg0CpBdllHzUFfPmJXhsY/x/y75SuFRr1lbn4eMwYiE9NqCzeufRa8xGF8jaCEssMe3
         tVYGwWnsHAkoWOQHbyyQiH2rQBCD/X8n+r529ZC31jBzkGsoNSuvSI1pLtGGQ11IDveW
         lRIA==
X-Gm-Message-State: AOJu0YwmZA4JBoDBdptMZxe/81pznqpAFoGFQICYFsoLA686UV8X0gKt
	XjB/S4nD4xntcSStFJLhEw3j+R6+G1KPF5iGgPPr34mZGtNxllEfIL0VEFHj+PnMhnK6ATBLdnu
	TrNOIskHtVDmGUkNU7gBfGE+XgzUh
X-Received: by 2002:a2e:8706:0:b0:2b9:e317:ec4d with SMTP id m6-20020a2e8706000000b002b9e317ec4dmr9509532lji.39.1691467160181;
        Mon, 07 Aug 2023 20:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/9DQrTRIe+MaGC1ED1i2uMJlzXFS32E9/+NfifHX+gPXxXE3/LPQ40a8wIeObDaFpyFOuHy6vDfjex5ZAdXk=
X-Received: by 2002:a2e:8706:0:b0:2b9:e317:ec4d with SMTP id
 m6-20020a2e8706000000b002b9e317ec4dmr9509524lji.39.1691467159855; Mon, 07 Aug
 2023 20:59:19 -0700 (PDT)
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
 <1691388845.9121156-1-xuanzhuo@linux.alibaba.com> <CACGkMEsoivXfBV75whjyB0yreUNh7HeucGLw3Bq9Zvu1NGnj_g@mail.gmail.com>
 <1691462837.6043541-2-xuanzhuo@linux.alibaba.com> <CACGkMEsM4cPaMHz-XowU+qpKZL2atZUwYzcUMUfr7N-GN+J2nQ@mail.gmail.com>
 <1691464183.5436294-1-xuanzhuo@linux.alibaba.com> <CACGkMEvUJ+GhhfkOB4Ux7-bDaPHvkA3xnvnMMQ+dYfWE4ZzFyw@mail.gmail.com>
 <1691466855.2312648-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691466855.2312648-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 11:59:04 +0800
Message-ID: <CACGkMEtf8SHZUdpGwDgtWv=Pf02t7RCLSZusFmsyi93TZ7dFkw@mail.gmail.com>
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

On Tue, Aug 8, 2023 at 11:57=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 8 Aug 2023 11:49:08 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Tue, Aug 8, 2023 at 11:12=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Tue, 8 Aug 2023 11:08:09 +0800, Jason Wang <jasowang@redhat.com> w=
rote:
> > > > On Tue, Aug 8, 2023 at 10:52=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > On Tue, 8 Aug 2023 10:26:04 +0800, Jason Wang <jasowang@redhat.co=
m> wrote:
> > > > > > On Mon, Aug 7, 2023 at 2:15=E2=80=AFPM Xuan Zhuo <xuanzhuo@linu=
x.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Wed, 2 Aug 2023 09:49:31 +0800, Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > > > > > > > On Tue, 1 Aug 2023 12:17:47 -0400, "Michael S. Tsirkin" <ms=
t@redhat.com> wrote:
> > > > > > > > > On Fri, Jul 28, 2023 at 02:02:33PM +0800, Xuan Zhuo wrote=
:
> > > > > > > > > > On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> > > > > > > > > > > On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirk=
in" <mst@redhat.com> wrote:
> > > > > > > > > > > > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo=
 wrote:
> > > > > > > > > > > > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hel=
lwig <hch@infradead.org> wrote:
> > > > > > > > > > > > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Micha=
el S. Tsirkin wrote:
> > > > > > > > > > > > > > > Well I think we can add wrappers like virtio_=
dma_sync and so on.
> > > > > > > > > > > > > > > There are NOP for non-dma so passing the dma =
device is harmless.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, please.
> > > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > I am not sure I got this fully.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Are you mean this:
> > > > > > > > > > > > > https://lore.kernel.org/all/20230214072704.126660=
-8-xuanzhuo@linux.alibaba.com/
> > > > > > > > > > > > > https://lore.kernel.org/all/20230214072704.126660=
-9-xuanzhuo@linux.alibaba.com/
> > > > > > > > > > > > >
> > > > > > > > > > > > > Then the driver must do dma operation(map and syn=
c) by these virtio_dma_* APIs.
> > > > > > > > > > > > > No care the device is non-dma device or dma devic=
e.
> > > > > > > > > > > >
> > > > > > > > > > > > yes
> > > > > > > > > > > >
> > > > > > > > > > > > > Then the AF_XDP must use these virtio_dma_* APIs =
for virtio device.
> > > > > > > > > > > >
> > > > > > > > > > > > We'll worry about AF_XDP when the patch is posted.
> > > > > > > > > > >
> > > > > > > > > > > YES.
> > > > > > > > > > >
> > > > > > > > > > > We discussed it. They voted 'no'.
> > > > > > > > > > >
> > > > > > > > > > > http://lore.kernel.org/all/20230424082856.15c1e593@ke=
rnel.org
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Hi guys, this topic is stuck again. How should I procee=
d with this work?
> > > > > > > > > >
> > > > > > > > > > Let me briefly summarize:
> > > > > > > > > > 1. The problem with adding virtio_dma_{map, sync} api i=
s that, for AF_XDP and
> > > > > > > > > > the driver layer, we need to support these APIs. The cu=
rrent conclusion of
> > > > > > > > > > AF_XDP is no.
> > > > > > > > > >
> > > > > > > > > > 2. Set dma_set_mask_and_coherent, then we can use DMA A=
PI uniformly inside
> > > > > > > > > > driver. This idea seems to be inconsistent with the fra=
mework design of DMA. The
> > > > > > > > > > conclusion is no.
> > > > > > > > > >
> > > > > > > > > > 3. We noticed that if the virtio device supports VIRTIO=
_F_ACCESS_PLATFORM, it
> > > > > > > > > > uses DMA API. And this type of device is the future dir=
ection, so we only
> > > > > > > > > > support DMA premapped for this type of virtio device. T=
he problem with this
> > > > > > > > > > solution is that virtqueue_dma_dev() only returns dev i=
n some cases, because
> > > > > > > > > > VIRTIO_F_ACCESS_PLATFORM is supported in such cases.
> > > > > >
> > > > > > Could you explain the issue a little bit more?
> > > > > >
> > > > > > E.g if we limit AF_XDP to ACESS_PLATFROM only, why does
> > > > > > virtqueue_dma_dev() only return dev in some cases?
> > > > >
> > > > > The behavior of virtqueue_dma_dev() is not related to AF_XDP.
> > > > >
> > > > > The return value of virtqueue_dma_dev() is used for the DMA APIs.=
 So it can
> > > > > return dma dev when the virtio is with ACCESS_PLATFORM. If virtio=
 is without
> > > > > ACCESS_PLATFORM then it MUST return NULL.
> > > > >
> > > > > In the virtio-net driver, if the virtqueue_dma_dev() returns dma =
dev,
> > > > > we can enable AF_XDP. If not, we return error to AF_XDP.
> > > >
> > > > Yes, as discussed, just having wrappers in the virtio_ring and doin=
g
> > > > the switch there. Then can virtio-net use them without worrying abo=
ut
> > > > DMA details?
> > >
> > >
> > > Yes. In the virtio drivers, we can use the wrappers. That is ok.
> > >
> > > But we also need to support virtqueue_dma_dev() for AF_XDP, because t=
hat the
> > > AF_XDP will not use the wrappers.
> >
> > You mean AF_XDP core or other? Could you give me an example?
>
>
> Yes. The AF_XDP core.
>
> Now the AF_XDP core will do the dma operation.  Because that the memory i=
s
> allocated by the user from the user space.  So before putting the memory =
to the
> driver, the AF_XDP will do the dma mapping.
>
>
> int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
>                unsigned long attrs, struct page **pages, u32 nr_pages)
> {

I think it's the driver who passes the device pointer here. Anything I miss=
ed?

Thanks


