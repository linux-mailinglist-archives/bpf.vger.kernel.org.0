Return-Path: <bpf+bounces-31485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B20B8FE0ED
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 10:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EE1C24807
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 08:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AB313C67E;
	Thu,  6 Jun 2024 08:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sPi7NfIH"
X-Original-To: bpf@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308F13B7A9;
	Thu,  6 Jun 2024 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662435; cv=none; b=QFupSz+OplH8oXWZtIPTmNMVYXJeXalYzd4y/E/rVgVfz7Dvo7HZyXDfrk2Fad22Ok6cGOhGx3cS4kKaEMV7udUf2NKXN337yAqgtyWLXmKfiwgRr8gsE/F4Lv4Zpz6VbZR/8BQ6Mv+ppzlCXrlEDPZhFMdwZf1TY1qGMP2Vw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662435; c=relaxed/simple;
	bh=0RPa2qG64d4CV8qTMSVJcHebmM0oHIdUaDhe4/gM4L4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=VfPIMBSol2XPRNzf++2at0dYTs3p5FPHuj788U8S7gNUVwPw2wjv8VS89B1vQEVDgdrCd6xVsUOFPy2E2ZkQRE1pdE861jc+YxLRV9NOtkJr1u6fXB6IwbgRTe1cn8Fw8lwuMjQTIE4dsNAvZNXIozVGdToDkVeYv9flq0LU1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sPi7NfIH; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717662428; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=DJ4ESPeHxb8olJByyigV2mRr385Ve3kcSAKM7qYz2MM=;
	b=sPi7NfIHIR4TbxB8rRkNAijvsBn0jLo9Mx6keQxiOtxsraO4LGuWmj+n+D0FR8HAqvf1UdDOfqNWZsDB5VlPNm3fD0oL4LGUTGJQJ9rqDxSLubrzYsT8iJCgaA2pNNRSaGAF3BHhyT54nZ4xhIQXsatyEZqzo1qDfvAaPW/hYCc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7xkc8b_1717662426;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7xkc8b_1717662426)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 16:27:06 +0800
Message-ID: <1717662283.8634596-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
Date: Thu, 6 Jun 2024 16:24:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Alexander Potapenko <glider@google.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com>
 <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
 <1717644183.6895547-1-xuanzhuo@linux.alibaba.com>
 <CAG_fn=UsqAhH57s08+prkj2iJshhxuLznzDNft4dPXHKX9V72Q@mail.gmail.com>
In-Reply-To: <CAG_fn=UsqAhH57s08+prkj2iJshhxuLznzDNft4dPXHKX9V72Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 6 Jun 2024 10:20:21 +0200, Alexander Potapenko <glider@google.com> =
wrote:
> > Could you try this?
>
> Hi Xuan,
>
> What kernel revision does this patch apply to? I tried it against
> v6.10-rc2, and only the first hunk applied.
> However this seems to fix the problem, at least the kernel boots without
> warnings now.


Sorry, I have some changes locally.

If the hunk #1 is applied, then it is ok.

Do you think we need more test? Or I post an new patch directly.

Thanks.


>
> > Thanks.
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 37c9c5b55864..cb280b66c7a2 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -3119,8 +3119,10 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct
> virtqueue *_vq, void *ptr,
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -       if (!vq->use_dma_api)
> > +       if (!vq->use_dma_api) {
> > +               kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr),
> size, dir);
> >                 return (dma_addr_t)virt_to_phys(ptr);
> > +       }
> >
> >         return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir,
> attrs);
> >  }
> > @@ -3171,8 +3173,10 @@ dma_addr_t virtqueue_dma_map_page_attrs(struct
> virtqueue *_vq, struct page *page
> >  {
> >         struct vring_virtqueue *vq =3D to_vvq(_vq);
> >
> > -       if (!vq->use_dma_api)
> > +       if (!vq->use_dma_api) {
> > +               kmsan_handle_dma(page, offset, size, dir);
> >                 return page_to_phys(page) + offset;
> > +       }
> >
> >         return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size,
> dir, attrs);
> >  }
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
>

