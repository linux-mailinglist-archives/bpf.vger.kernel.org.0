Return-Path: <bpf+bounces-31479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C28FDD86
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 05:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738C01C22016
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 03:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDB21E867;
	Thu,  6 Jun 2024 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u+syJuc1"
X-Original-To: bpf@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0660134B6;
	Thu,  6 Jun 2024 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644778; cv=none; b=iuXcFDE27KyxSRMnUxRBPRcSB7Gdc2PKvCAlNolGNblR9HopWXoKEBJdOqrHbhYrYBRWBtynqIRHCAza49uMxcQctD+c5ejHy4S3iXomDepwTgM1+Fv2dFf/2SLGJb9VtQahK80qTtSIgsYHTWKQosL06VIFDN7fg3X/6/aUYZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644778; c=relaxed/simple;
	bh=bgVAcuwY1SKXG3vjyzdqlv2nugV2OGyQixNnAyg2jA8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=K0z64RY1JW5kQUyqu7Yto+yS72DASoFAh0fQc4FaEgPXIPIdfiReouBjMp4o7Vb4nub1rvAAz0siOQaEsdlWB4S0GuS8g7uFWfN011ikxFB7PbF6tPUEBXJ6DGTiNwEIjwAdQnt0s2tGTZvsbrNY/2K/f7Cy2VRIhWJy5dOwS5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u+syJuc1; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717644773; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=OFu44R6J/QcE53wYRSjB6IeSCEeSV0oNByx8BtNCsr4=;
	b=u+syJuc1xHClMPZtszLXvdzQSWAoWuOcB+ICb/eei3U9gYdfOlR4m5HjvbXf60YKiRlrJGJ7h6/A6E5gK8sH3kNLXtFIqm/UnFBQZgvK4rqwuBqtpHbS9VUY0QNgSBAPQh0aSvVCCnrlnxrcC9Qnd+sHQB6VmTkVTSFYiSZgvpY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W7wj7E1_1717644453;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7wj7E1_1717644453)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 11:27:34 +0800
Message-ID: <1717644183.6895547-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
Date: Thu, 6 Jun 2024 11:23:03 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John  Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org,
 bpf@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Alexander  Potapenko <glider@google.com>,
 virtualization@lists.linux-foundation.org
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com>
 <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
In-Reply-To: <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 04 Jun 2024 18:07:44 +0200, Ilya Leoshkevich <iii@linux.ibm.com> wr=
ote:
> On Thu, 2023-08-10 at 20:30 +0800, Xuan Zhuo wrote:
> > If the vq is the premapped mode, use the sg_dma_address() directly.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> > =C2=A0drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
> > =C2=A01 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c
> > b/drivers/virtio/virtio_ring.c
> > index 8e81b01e0735..f9f772e85a38 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const struct
> > vring_virtqueue *vq)
> > =C2=A0static int vring_map_one_sg(const struct vring_virtqueue *vq, str=
uct
> > scatterlist *sg,
> > =C2=A0			=C2=A0=C2=A0=C2=A0 enum dma_data_direction direction,
> > dma_addr_t *addr)
> > =C2=A0{
> > +	if (vq->premapped) {
> > +		*addr =3D sg_dma_address(sg);
> > +		return 0;
> > +	}
> > +
>
> I wonder if something needs to be done for KMSAN here, like it's done
> by the next block in this function? I'm looking into what seems to be a
> KMSAN false positive on s390x:
>
> BUG: KMSAN: uninit-value in receive_buf+0x45ca/0x6990
>  receive_buf+0x45ca/0x6990
>  virtnet_poll+0x17e0/0x3130
>  net_rx_action+0x832/0x26e0
>  handle_softirqs+0x330/0x10f0
>  [...]
>
> Uninit was created at:
>  __alloc_pages_noprof+0x62a/0xe60
>  alloc_pages_noprof+0x392/0x830
>  skb_page_frag_refill+0x21a/0x5c0
>  virtnet_rq_alloc+0x50/0x1500
>  try_fill_recv+0x372/0x54c0
>  virtnet_open+0x210/0xbe0
>  __dev_open+0x56e/0x920
>  __dev_change_flags+0x39c/0x2000
>  dev_change_flags+0xaa/0x200
>  do_setlink+0x197a/0x7420
>  rtnl_setlink+0x77c/0x860
>  [...]
>
> My understanding is that virtnet_rq_alloc() allocates a page for
> receiving data from a virtio device, which is then wrapped in struct
> scatterlist by virtnet_rq_init_one_sg(), which is in turn associated
> with a virtqueue through the virtqueue_add_inbuf_ctx() ->
> virtqueue_add() -> virtqueue_add_split() -> vring_map_one_sg()
> call chain.
>
> Someone should unpoison this page (since KMSAN doesn't know that the
> hypervisor writes to it), and today for the non-premapped case this is
> vring_map_one_sg(). So I tried the following naive fix:
>
>         if (vq->premapped) {
>                 *addr =3D sg_dma_address(sg);
> +               if (!vq->use_dma_api) {
> +                       kmsan_handle_dma(phys_to_page(*addr), sg-
> >offset, sg->length, direction);
> +               }
>
> but it didn't help. I plan to investigate this further, but any hints
> are much appreciated.
>
> > =C2=A0	if (!vq->use_dma_api) {
> > =C2=A0		/*
> > =C2=A0		 * If DMA is not used, KMSAN doesn't know that the
> > scatterlist


Could you try this?

Thanks.

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 37c9c5b55864..cb280b66c7a2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3119,8 +3119,10 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct vir=
tqueue *_vq, void *ptr,
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       if (!vq->use_dma_api)
+       if (!vq->use_dma_api) {
+               kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), si=
ze, dir);
                return (dma_addr_t)virt_to_phys(ptr);
+       }

        return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attr=
s);
 }
@@ -3171,8 +3173,10 @@ dma_addr_t virtqueue_dma_map_page_attrs(struct virtq=
ueue *_vq, struct page *page
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       if (!vq->use_dma_api)
+       if (!vq->use_dma_api) {
+               kmsan_handle_dma(page, offset, size, dir);
                return page_to_phys(page) + offset;
+       }

        return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size, di=
r, attrs);
 }

