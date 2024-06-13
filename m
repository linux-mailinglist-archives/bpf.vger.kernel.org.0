Return-Path: <bpf+bounces-32034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AD90620D
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978FB1C20EDD
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3DD12BF1B;
	Thu, 13 Jun 2024 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="C75didqU"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D312129E94;
	Thu, 13 Jun 2024 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718246369; cv=none; b=G5cLpdNIvUnnRn86XfG0d5S+uSgWaieZtzlNDH2Tf+j5ZAFDl3KY8A2K8s/Sw6IiKjfz50qnlinBtzBXlvajktyILL8VE7Xc/IBFR+eKKzhoOci7aPPdd63ECBW2cQwOXinz1qBEVmJiOsoi8cNzzQo/0zGr4yMcPohTXkn2fAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718246369; c=relaxed/simple;
	bh=wPPE2Ssaq69cZU1iRXz6+qxkFK8Ff9UHmMthwAPpAhk=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=iWJP6rdBB2ZFdYxo+Il518lig7aLjxD/5YR9HcINgT9nOzrorgb5SNtQ6q3Hq4BCZM9gTaRrZvW2X52K8Cg0O18/wZxqF+SCIV1Aty8u8bdWhdYb0wAT5p6U+LgTQBgzd5a+7xdOeSYNj/eCVxLcw097tVX0ZVppFJxz6SxgE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=C75didqU; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718246358; h=Message-ID:Subject:Date:From:To;
	bh=td1XJw66f+wQG/FODBLlh/MSxtLfQLLtTzZiZwnOIJg=;
	b=C75didqU/ZZMckF3ML/w6Y8kUZctTE//o+Il1tXB9xJ2XKHVDO7B8sDpRn5Ttw53eTKpzazyVaHqSeSU045C5GfFUQUpGKx3tRyl8hFIUDkX9TjYTV6QgcPKrPvdh/qVCPLYS6piGigPNBnQ1VRbdqITLZZHOaZnczklERmz8lY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W8MKCQh_1718246355;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8MKCQh_1718246355)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 10:39:16 +0800
Message-ID: <1718246339.0960987-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 01/15] virtio_ring: introduce dma map api for page
Date: Thu, 13 Jun 2024 10:38:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240611114147.31320-1-xuanzhuo@linux.alibaba.com>
 <20240611114147.31320-2-xuanzhuo@linux.alibaba.com>
 <20240612162011.7f1d03a0@kernel.org>
In-Reply-To: <20240612162011.7f1d03a0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Wed, 12 Jun 2024 16:20:11 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 11 Jun 2024 19:41:33 +0800 Xuan Zhuo wrote:
> > +/**
> > + * virtqueue_dma_map_page_attrs - map DMA for _vq
> > + * @_vq: the struct virtqueue we're talking about.
> > + * @page: the page to do dma
> > + * @offset: the offset inside the page
> > + * @size: the size of the page to do dma
> > + * @dir: DMA direction
> > + * @attrs: DMA Attrs
> > + *
> > + * The caller calls this to do dma mapping in advance. The DMA address can be
> > + * passed to this _vq when it is in pre-mapped mode.
> > + *
> > + * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
>
> You gotta format the return value doc in a kdoc-sanctioned way.
> please run ./scripts/kernel-doc -none -Wall to find such issues

Will fix.

Thanks.


>
> > + */
> > +dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page,
> > +					size_t offset, size_t size,
> > +					enum dma_data_direction dir,
> > +					unsigned long attrs)

