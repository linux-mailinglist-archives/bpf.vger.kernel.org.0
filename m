Return-Path: <bpf+bounces-40257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC8984508
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 13:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE670B25A0F
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B80F1A7057;
	Tue, 24 Sep 2024 11:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FpmetXj3"
X-Original-To: bpf@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8E19B3E4;
	Tue, 24 Sep 2024 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178075; cv=none; b=qwAfOsKZBI70RtF70C6iQZ2p3WIGThKpOkfXdEto4C5BbEMdglrH+0KWsjQPs2YkOgsos877XTFB7P89n1CSar5VdP5JPhJLBMb9b5BJSN7TFnODw7232oG3WhnFrIRAbp7V5+DLsnssH1Csid/MeXB2imgO8i5l3zC4SdzcHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178075; c=relaxed/simple;
	bh=pGcclbUN3Ei1TFXCliRkZs+/G35HN9mIIUQXOiF0OIk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=Rx8uVTxODug9w8jkGLGpwCfRy1uFYdRE0xE1hu8eBSFWVK/xGMHhTEZui1a1c7YWr3gwezAIgZ6PbwcjCVds4B0aHJ4mLFbfkGMGQFptqKXvXkHLWMVG5w7e8VGOVzWl82jMS+EzHo2bUWY9ccWpDJEDNBvBnBy3iLEhK6x65IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FpmetXj3; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727178070; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=WHs0Ul2MPSi9UYmyoRMrIaLj6QL34LhvrlMbdj4rYx4=;
	b=FpmetXj318ru+Oq03dp3Qby212sRL/fX7CcJ6CVzQEM8DTTjTo0bloLjWGP6pB8vR3bSMNZW3VL4BAVvbKmJ/EWIw+64dH/Lb5Bq7wto1hj7xm/7lyQkgv96t+L6v/krkAgGKE265HfFkIXwLyaZLowp+apD1jyV3jkHGGF9O2I=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFgDOvN_1727178069)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 19:41:10 +0800
Message-ID: <1727177967.6466465-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next v1 07/12] virtio_net: refactor the xmit type
Date: Tue, 24 Sep 2024 19:39:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240924013204.13763-1-xuanzhuo@linux.alibaba.com>
 <20240924013204.13763-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEtbNrwbxhRbjHGiEQeQbWUb2iL0ZtyosXs4_+GoZY-Gsw@mail.gmail.com>
In-Reply-To: <CACGkMEtbNrwbxhRbjHGiEQeQbWUb2iL0ZtyosXs4_+GoZY-Gsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 24 Sep 2024 15:35:03 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Because the af-xdp will introduce a new xmit type, so I refactor the
> > xmit type mechanism first.
> >
> > In general, pointers are aligned to 4 or 8 bytes.
>
> I think this needs some clarification, the alignment seems to depend
> on the lowest common multiple between the alignments of all struct
> members. So we know both xdp_frame and sk_buff are at least 4 bytes
> aligned.
>
> If we want to reuse the lowest bit of pointers in AF_XDP, the
> alignment of the data structure should be at least 4 bytes.

YES, for AF_XDP. See more in #10.


>
> > If it is aligned to 4
> > bytes, then only two bits are free for a pointer. But there are 4 types
> > here, so we can't use bits to distinguish them. And 2 bits is enough for
> > 4 types:
> >
> >     00 for skb
> >     01 for SKB_ORPHAN
> >     10 for XDP
> >     11 for af-xdp tx
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 90 +++++++++++++++++++++++-----------------
> >  1 file changed, 51 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 630e5b21ad69..41a5ea9b788d 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -45,9 +45,6 @@ module_param(napi_tx, bool, 0644);
> >  #define VIRTIO_XDP_TX          BIT(0)
> >  #define VIRTIO_XDP_REDIR       BIT(1)
> >
> > -#define VIRTIO_XDP_FLAG                BIT(0)
> > -#define VIRTIO_ORPHAN_FLAG     BIT(1)
> > -
> >  /* RX packet size EWMA. The average packet size is used to determine t=
he packet
> >   * buffer size when refilling RX rings. As the entire RX ring may be r=
efilled
> >   * at once, the weight is chosen so that the EWMA will be insensitive =
to short-
> > @@ -512,34 +509,35 @@ static struct sk_buff *virtnet_skb_append_frag(st=
ruct sk_buff *head_skb,
> >                                                struct page *page, void =
*buf,
> >                                                int len, int truesize);
> >
> > -static bool is_xdp_frame(void *ptr)
> > -{
> > -       return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > -}
> > +enum virtnet_xmit_type {
> > +       VIRTNET_XMIT_TYPE_SKB,
> > +       VIRTNET_XMIT_TYPE_SKB_ORPHAN,
> > +       VIRTNET_XMIT_TYPE_XDP,
> > +};
> >
> > -static void *xdp_to_ptr(struct xdp_frame *ptr)
> > -{
> > -       return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
> > -}
> > +/* We use the last two bits of the pointer to distinguish the xmit typ=
e. */
> > +#define VIRTNET_XMIT_TYPE_MASK (BIT(0) | BIT(1))
> >
> > -static struct xdp_frame *ptr_to_xdp(void *ptr)
> > +static enum virtnet_xmit_type virtnet_xmit_ptr_strip(void **ptr)
>
> Nit: not a native speaker but I think something like pack/unpack might
> be better.


Will fix.

Thanks

>
> With those changes.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>

