Return-Path: <bpf+bounces-7209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96DD773758
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 05:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643E52815C3
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 03:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8640F1367;
	Tue,  8 Aug 2023 03:08:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502E382
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 03:08:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47F19F
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 20:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691464103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hhbbf/y3ixYRtFGuR8fxsOg96UrZPCnLYZgyvI13pPE=;
	b=d1g/CoKnIlSng14ToeJUFBit1DRZce3lHijmonWXsrNtjg7cQiVi94plOjyk73/P7ILXb9
	VX3NZiejDIGi+WgIvLxj5Xs99AjuIISP5TOT+Sk7GE5v/AhSNTTAHoYYGHXXIVSqVx2GMc
	n87l3DnB+Htv7TxLkpZZDH6o0pSB7aI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-81HJ9tHDPKuwsgMzoxA-og-1; Mon, 07 Aug 2023 23:08:22 -0400
X-MC-Unique: 81HJ9tHDPKuwsgMzoxA-og-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9bcf13746so54197491fa.0
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 20:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691464101; x=1692068901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hhbbf/y3ixYRtFGuR8fxsOg96UrZPCnLYZgyvI13pPE=;
        b=Hsc1lq+rc9RN9RDz0eE4dtee5k2HfHpnWP5Jb7c5K9Jk1ugLQcvPKTdKMRL6aaO9sa
         9ewPtWiV+9nmGxMaVd1Flhb6SQv2g+2EPom1rm499HJVx7eeu0gIvcPgeO+PIuyVfSWP
         mXZvbDxJQPjS57k344Jsg+L5XHZIP/Xz4F4t5QcjpizYNRUQTEjtIks9tezXly9nhD09
         S+59+ShzjxcqcYoqWXCHKU9Qf8v9jRSOJUIt7g5ja0u3m996EjxxBhlPN4H45nM8rwuL
         QeA2xgis5uSPXZ0xZlOb/AY1MafMMKrZ1Qx33FfP+8rohtlbXbme7ICMV4Zevb7ithKj
         fl6g==
X-Gm-Message-State: AOJu0YxT+iWTFXo37Jj7TfB9O0BqxjUrR06gCOO7NpEI1lBrXMQ+D93I
	paVIDXNrAu1WeibYhxnSZl01rN0vV/5SSzkZcHk85B/JvpgctB24dcOig5yl3AYXUmMFnxSJJfz
	5xuwfL79duW0nm1VGpb6dtuFrDSgG
X-Received: by 2002:a2e:8e93:0:b0:2b9:412a:111d with SMTP id z19-20020a2e8e93000000b002b9412a111dmr8068865ljk.42.1691464101074;
        Mon, 07 Aug 2023 20:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkFzuKUSTBxvr8xUJFBGEljqkZL6F7AvfmOw6ZPETh0gBINujkhDUrVUJXH6NVreAEes81Trgg6dPGFpEKYN0=
X-Received: by 2002:a2e:8e93:0:b0:2b9:412a:111d with SMTP id
 z19-20020a2e8e93000000b002b9412a111dmr8068854ljk.42.1691464100720; Mon, 07
 Aug 2023 20:08:20 -0700 (PDT)
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
 <1691462837.6043541-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691462837.6043541-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 11:08:09 +0800
Message-ID: <CACGkMEsM4cPaMHz-XowU+qpKZL2atZUwYzcUMUfr7N-GN+J2nQ@mail.gmail.com>
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

On Tue, Aug 8, 2023 at 10:52=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 8 Aug 2023 10:26:04 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Mon, Aug 7, 2023 at 2:15=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibab=
a.com> wrote:
> > >
> > > On Wed, 2 Aug 2023 09:49:31 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
> > > > On Tue, 1 Aug 2023 12:17:47 -0400, "Michael S. Tsirkin" <mst@redhat=
.com> wrote:
> > > > > On Fri, Jul 28, 2023 at 02:02:33PM +0800, Xuan Zhuo wrote:
> > > > > > On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > > > > On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirkin" <mst=
@redhat.com> wrote:
> > > > > > > > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> > > > > > > > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hc=
h@infradead.org> wrote:
> > > > > > > > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Ts=
irkin wrote:
> > > > > > > > > > > Well I think we can add wrappers like virtio_dma_sync=
 and so on.
> > > > > > > > > > > There are NOP for non-dma so passing the dma device i=
s harmless.
> > > > > > > > > >
> > > > > > > > > > Yes, please.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > I am not sure I got this fully.
> > > > > > > > >
> > > > > > > > > Are you mean this:
> > > > > > > > > https://lore.kernel.org/all/20230214072704.126660-8-xuanz=
huo@linux.alibaba.com/
> > > > > > > > > https://lore.kernel.org/all/20230214072704.126660-9-xuanz=
huo@linux.alibaba.com/
> > > > > > > > >
> > > > > > > > > Then the driver must do dma operation(map and sync) by th=
ese virtio_dma_* APIs.
> > > > > > > > > No care the device is non-dma device or dma device.
> > > > > > > >
> > > > > > > > yes
> > > > > > > >
> > > > > > > > > Then the AF_XDP must use these virtio_dma_* APIs for virt=
io device.
> > > > > > > >
> > > > > > > > We'll worry about AF_XDP when the patch is posted.
> > > > > > >
> > > > > > > YES.
> > > > > > >
> > > > > > > We discussed it. They voted 'no'.
> > > > > > >
> > > > > > > http://lore.kernel.org/all/20230424082856.15c1e593@kernel.org
> > > > > >
> > > > > >
> > > > > > Hi guys, this topic is stuck again. How should I proceed with t=
his work?
> > > > > >
> > > > > > Let me briefly summarize:
> > > > > > 1. The problem with adding virtio_dma_{map, sync} api is that, =
for AF_XDP and
> > > > > > the driver layer, we need to support these APIs. The current co=
nclusion of
> > > > > > AF_XDP is no.
> > > > > >
> > > > > > 2. Set dma_set_mask_and_coherent, then we can use DMA API unifo=
rmly inside
> > > > > > driver. This idea seems to be inconsistent with the framework d=
esign of DMA. The
> > > > > > conclusion is no.
> > > > > >
> > > > > > 3. We noticed that if the virtio device supports VIRTIO_F_ACCES=
S_PLATFORM, it
> > > > > > uses DMA API. And this type of device is the future direction, =
so we only
> > > > > > support DMA premapped for this type of virtio device. The probl=
em with this
> > > > > > solution is that virtqueue_dma_dev() only returns dev in some c=
ases, because
> > > > > > VIRTIO_F_ACCESS_PLATFORM is supported in such cases.
> >
> > Could you explain the issue a little bit more?
> >
> > E.g if we limit AF_XDP to ACESS_PLATFROM only, why does
> > virtqueue_dma_dev() only return dev in some cases?
>
> The behavior of virtqueue_dma_dev() is not related to AF_XDP.
>
> The return value of virtqueue_dma_dev() is used for the DMA APIs. So it c=
an
> return dma dev when the virtio is with ACCESS_PLATFORM. If virtio is with=
out
> ACCESS_PLATFORM then it MUST return NULL.
>
> In the virtio-net driver, if the virtqueue_dma_dev() returns dma dev,
> we can enable AF_XDP. If not, we return error to AF_XDP.

Yes, as discussed, just having wrappers in the virtio_ring and doing
the switch there. Then can virtio-net use them without worrying about
DMA details?

Thanks

>
> Thanks
>
>
>
>
> >
> > Thanks
> >
> > >Otherwise NULL is returned.
> > > > > > This option is currently NO.
> > > > > >
> > > > > > So I'm wondering what should I do, from a DMA point of view, is=
 there any
> > > > > > solution in case of using DMA API?
> > > > > >
> > > > > > Thank you
> > > > >
> > > > >
> > > > > I think it's ok at this point, Christoph just asked you
> > > > > to add wrappers for map/unmap for use in virtio code.
> > > > > Seems like a cosmetic change, shouldn't be hard.
> > > >
> > > > Yes, that is not hard, I has this code.
> > > >
> > > > But, you mean that the wrappers is just used for the virtio driver =
code?
> > > > And we also offer the  API virtqueue_dma_dev() at the same time?
> > > > Then the driver will has two chooses to do DMA.
> > > >
> > > > Is that so?
> > >
> > > Ping.
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > > Otherwise I haven't seen significant comments.
> > > > >
> > > > >
> > > > > Christoph do I summarize what you are saying correctly?
> > > > > --
> > > > > MST
> > > > >
> > > >
> > >
> >
>


