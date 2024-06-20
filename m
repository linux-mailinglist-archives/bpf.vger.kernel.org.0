Return-Path: <bpf+bounces-32586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5299101FC
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 12:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B092F282733
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FED1A8C3B;
	Thu, 20 Jun 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bER9gDZN"
X-Original-To: bpf@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1411CD2B;
	Thu, 20 Jun 2024 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880911; cv=none; b=mwoP0tU6XYpdzVIsrNXGVAw2EfyfErZHV4y0XVmC+6T2iU0gvfVDM5ZYRzwcoGwE/t70m0K8mJkzrzmV8fAmscjiC7xiArp9gQo5g+PPoYCP7xLLUnWqLct5gkm2DkxEtZlvTMbpLMgWkrHC119nI/PGX4xl9xyjX1x++gDYmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880911; c=relaxed/simple;
	bh=kROW9RQ/mhmEg14a8RjZNTEPPLtvdCD4Fhrlk7IyI3w=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ZVceWVW6tfFobaZBngX+V2TeRp13p7g0fM+2m1g1LTce4RmhpHPKzGF5B8V/g6GDMUeEWm+aONm0hR5yAvoPcpU/8o1WNrz+ICdowMYeUFzMBjPqZe8IohijtI1TDqNiLqlxMg3IZu766pNZ5fTBcaFVbjYBrf1B65sAZGOboCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bER9gDZN; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718880906; h=Message-ID:Subject:Date:From:To;
	bh=Fel2/8/EOFmcfP6qOXtVIWxVD5zcPAVWJrMLgPVGTog=;
	b=bER9gDZNBHy8F7nCSchbby7YiuO/O5ubCzVmgNGCQWwLKMDrngF7gxAfQXwk6skrXRXCbsv9Hs6gPSxOppT1LMhdvHmla64nWoFbggAZuo2qaKoydYpxc0mTz6vx7Je2t2OriRGEqM+LbaaiN6Ix+Xrdurgl1THLb4PbxCVbRsE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8s9g52_1718880905;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8s9g52_1718880905)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 18:55:05 +0800
Message-ID: <1718880882.9011145-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 10/10] virtio_net: xsk: rx: free the unused xsk buffer
Date: Thu, 20 Jun 2024 18:54:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com>
 <20240618075643.24867-11-xuanzhuo@linux.alibaba.com>
 <38db3facdfefbefecd367ccce2e9b094d0b0314d.camel@redhat.com>
In-Reply-To: <38db3facdfefbefecd367ccce2e9b094d0b0314d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Thu, 20 Jun 2024 12:46:24 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2024-06-18 at 15:56 +0800, Xuan Zhuo wrote:
> > Release the xsk buffer, when the queue is releasing or the queue is
> > resizing.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio_net.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cfa106aa8039..33695b86bd99 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -967,6 +967,11 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> >
> >  	rq = &vi->rq[i];
> >
> > +	if (rq->xsk.pool) {
> > +		xsk_buff_free((struct xdp_buff *)buf);
> > +		return;
> > +	}
> > +
> >  	if (!vi->big_packets || vi->mergeable_rx_bufs)
> >  		virtnet_rq_unmap(rq, buf, 0);
>
>
> I'm under the impression this should be squashed in a previous patch,
> likely "virtio_net: xsk: bind/unbind xsk for rx"

OK.

Thanks.


>
> Thanks,
>
> Paolo
>

