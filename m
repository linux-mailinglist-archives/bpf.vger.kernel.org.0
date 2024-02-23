Return-Path: <bpf+bounces-22546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0AA86086B
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 02:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3631C20E41
	for <lists+bpf@lfdr.de>; Fri, 23 Feb 2024 01:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090D7B665;
	Fri, 23 Feb 2024 01:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y8IDWUgX"
X-Original-To: bpf@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879DFAD32;
	Fri, 23 Feb 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652551; cv=none; b=loKccIXNhrmr+KO9UQD3KkJIAsoipveS+7O39QRK5z/7asGVLs+z6CTivyI6CGMQR2kkzLbYfu6EhsGVL4pv1f1o00a0oN3WbdZaAg+ZZs6h65g+afxAInlHxTo93F1ClgeRbXjji4ojYde74U04WwrHl8/KLydlgnExh4JKS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652551; c=relaxed/simple;
	bh=52BQWIKSM9dbXtbk3tbReFoFAD0K+aTh0S2ao1RVbnw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=A/FcuTa8WMFc3Uy1VLj534j5Inl5kZkuEwluNXfSfGDMzr7msqvQu3GTal3Hfov/3N0kE5QRu9Cq2jm4BGTKaVJBHT1dTWvCBs9xZw697ZKhWwGLLy4IiyKCalLfTBlZHrU9k4NOdWGI+PogMxyPtazbl1m5matCcSG34lOZ8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y8IDWUgX; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708652546; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=hYJihYxVn8B/CLtvoS+mVwMQczZee/YJZgmgC0BQBjw=;
	b=Y8IDWUgXh+EAJrOCvIckzeh2a46kLplwEDARjuubCFaAXMPMQ16/HbD5bXCQfNi+YdIz/A5TXptAQ/Axz5AbNLWYsyF7dMyOoACoOvyswBQA8HTOLbXXHP2xPUVQbD+H91xGC47CDuRn9Zld6Ab6t/5mL+apKQ9C8PThlWcpTak=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W12LtQi_1708652544;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W12LtQi_1708652544)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 09:42:25 +0800
Message-ID: <1708652254.1517398-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5] virtio_net: Support RX hash XDP hint
Date: Fri, 23 Feb 2024 09:37:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 mst@redhat.com,
 jasowang@redhat.com,
 hengqi@linux.alibaba.com,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 john.fastabend@gmail.com,
 daniel@iogearbox.net,
 ast@kernel.org,
 Liang Chen <liangchen.linux@gmail.com>
References: <20240202121151.65710-1-liangchen.linux@gmail.com>
 <c8d59e75-d0bb-4a03-9ef4-d6de65fa9356@kernel.org>
 <CAKhg4tJFpG5nUNdeEbXFLonKkFUP0QCh8A9CpwU5OvtnBuz4Sw@mail.gmail.com>
 <5297dad6499f6d00f7229e8cf2c08e0eacb67e0c.camel@redhat.com>
 <CAKhg4tLbF8SfYD4dU9U9Nhii4FY2dftjPKYz-Emrn-CRwo10mg@mail.gmail.com>
 <73c242b43513bde04eebb4eb581deb189443c26b.camel@redhat.com>
 <CAKhg4tJPjcShkw4-FHFkKOcgzHK27A5pMu9FP7OWj4qJUX1ApA@mail.gmail.com>
 <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
In-Reply-To: <1b2d471a5d06ecadcb75e3d9155b6d566afb2767.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Fri, 09 Feb 2024 13:57:25 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> On Fri, 2024-02-09 at 18:39 +0800, Liang Chen wrote:
> > On Wed, Feb 7, 2024 at 10:27=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Wed, 2024-02-07 at 10:54 +0800, Liang Chen wrote:
> > > > On Tue, Feb 6, 2024 at 6:44=E2=80=AFPM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > > >
> > > > > On Sat, 2024-02-03 at 10:56 +0800, Liang Chen wrote:
> > > > > > On Sat, Feb 3, 2024 at 12:20=E2=80=AFAM Jesper Dangaard Brouer =
<hawk@kernel.org> wrote:
> > > > > > > On 02/02/2024 13.11, Liang Chen wrote:
> > > > > [...]
> > > > > > > > @@ -1033,6 +1039,16 @@ static void put_xdp_frags(struct xdp=
_buff *xdp)
> > > > > > > >       }
> > > > > > > >   }
> > > > > > > >
> > > > > > > > +static void virtnet_xdp_save_rx_hash(struct virtnet_xdp_bu=
ff *virtnet_xdp,
> > > > > > > > +                                  struct net_device *dev,
> > > > > > > > +                                  struct virtio_net_hdr_v1=
_hash *hdr_hash)
> > > > > > > > +{
> > > > > > > > +     if (dev->features & NETIF_F_RXHASH) {
> > > > > > > > +             virtnet_xdp->hash_value =3D hdr_hash->hash_va=
lue;
> > > > > > > > +             virtnet_xdp->hash_report =3D hdr_hash->hash_r=
eport;
> > > > > > > > +     }
> > > > > > > > +}
> > > > > > > > +
> > > > > > >
> > > > > > > Would it be possible to store a pointer to hdr_hash in virtne=
t_xdp_buff,
> > > > > > > with the purpose of delaying extracting this, until and only =
if XDP
> > > > > > > bpf_prog calls the kfunc?
> > > > > > >
> > > > > >
> > > > > > That seems to be the way v1 works,
> > > > > > https://lore.kernel.org/all/20240122102256.261374-1-liangchen.l=
inux@gmail.com/
> > > > > > . But it was pointed out that the inline header may be overwrit=
ten by
> > > > > > the xdp prog, so the hash is copied out to maintain its integri=
ty.
> > > > >
> > > > > Why? isn't XDP supposed to get write access only to the pkt
> > > > > contents/buffer?
> > > > >
> > > >
> > > > Normally, an XDP program accesses only the packet data. However,
> > > > there's also an XDP RX Metadata area, referenced by the data_meta
> > > > pointer. This pointer can be adjusted with bpf_xdp_adjust_meta to
> > > > point somewhere ahead of the data buffer, thereby granting the XDP
> > > > program access to the virtio header located immediately before the
> > >
> > > AFAICS bpf_xdp_adjust_meta() does not allow moving the meta_data befo=
re
> > > xdp->data_hard_start:
> > >
> > > https://elixir.bootlin.com/linux/latest/source/net/core/filter.c#L4210
> > >
> > > and virtio net set such field after the virtio_net_hdr:
> > >
> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net=
.c#L1218
> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/virtio_net=
.c#L1420
> > >
> > > I don't see how the virtio hdr could be touched? Possibly even more
> > > important: if such thing is possible, I think is should be somewhat
> > > denied (for the same reason an H/W nic should prevent XDP from
> > > modifying its own buffer descriptor).
> >
> > Thank you for highlighting this concern. The header layout differs
> > slightly between small and mergeable mode. Taking 'mergeable mode' as
> > an example, after calling xdp_prepare_buff the layout of xdp_buff
> > would be as depicted in the diagram below,
> >
> >                       buf
> >                        |
> >                        v
> >         +--------------+--------------+-------------+
> >         | xdp headroom | virtio header| packet      |
> >         | (256 bytes)  | (20 bytes)   | content     |
> >         +--------------+--------------+-------------+
> >         ^                             ^
> >         |                             |
> >  data_hard_start                    data
> >                                   data_meta
> >
> > If 'bpf_xdp_adjust_meta' repositions the 'data_meta' pointer a little
> > towards 'data_hard_start', it would point to the inline header, thus
> > potentially allowing the XDP program to access the inline header.
>
> I see. That layout was completely unexpected to me.
>
> AFAICS the virtio_net driver tries to avoid accessing/using the
> virtio_net_hdr after the XDP program execution, so nothing tragic
> should happen.
>
> @Michael, @Jason, I guess the above is like that by design? Isn't it a
> bit fragile?

YES. We process it carefully. That brings some troubles, we hope to put the
virtio-net header to the vring desc like other NICs. But that is a big proj=
ect.

I think this patch is ok, this can be merged to net-next firstly.

Thanks.


>
> Thanks!
>
> Paolo
>

