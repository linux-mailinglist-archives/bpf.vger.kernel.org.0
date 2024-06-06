Return-Path: <bpf+bounces-31484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE68FE0E8
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 10:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5347283BF2
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4426513C3F6;
	Thu,  6 Jun 2024 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sLwLe/V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745D03EA72
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662405; cv=none; b=apS9a8S+hafae/mMrVwbf0oMuo4UOEuZFHcjI2NlKK0jDk18B33fxgYDWHlb9UzuGjaIKZIaEdb6kt2o86rOxMg3/Oq5k59w5weh1nviLev7ebLt0KfpR9lQNKYMQXYsLTLKEw9ynrFZ9jOUGW0LlrDj62ItugPvvO9Rw1cFxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662405; c=relaxed/simple;
	bh=n0pZueRUmpdvtloIPpgcxNu/B7/nDsSTEeurRzHnHsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK9I5s85O+dEVQndNFXwzicby5i8JoAOg3sHWGitagnHAPQC2vg0iwB/Ax4KWVk8D9yhdtf2McKEhhTNyWnGTftTw88Hlyaz7ZCHSnLezB/p0ooiUjyPCKBb3Rd2kE5LFPyQQFhjVbjS6QxOxIm1EpAXbYiMIYhYXgdcXzSb7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sLwLe/V; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7951cf70432so46865085a.3
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717662403; x=1718267203; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAoWLPLPpZp/YDC/UyXezS+9/hRBrQtfl1bKW+wACuw=;
        b=4sLwLe/VCU1z+LGkTU/t4s4Cd1FwfbmOkfVfCrOwYJcYfEqjjOHAKAHy8TKNTS4fkR
         q8ZTin+epAoNF1aZq1Fi7VlUJyQJRPQMWIqdCbNx0u6CHHUGj6j/His/PmZWQOi+iV84
         Cst8iVnSuBzxMPuobisSYOVjd+GMvbaU73+0zK19uKHrt35eSSkxnkapG/CTSAph0B0F
         V7jsjbZ3MIULy4Yl+0/z54IQxl7pYzMH2qI7SwCkwTqB5UQ0hfIxUtZjewsbFfWH//GU
         oLmhXN6O/K6fymHf7F2Jn8megNtSVGl95et4im40bONWGV+gcIOoinUjMC090iI9EI5J
         OKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662403; x=1718267203;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAoWLPLPpZp/YDC/UyXezS+9/hRBrQtfl1bKW+wACuw=;
        b=h4biNc3imSRGQXG5CavJPMzFRKc6QMsLnmWMYa7tDvEFvSp24vc2XaEvQrpY12wrgc
         U/47p2zhO+1EqXH+aevociRxDce5QQQQN2wg7kJCenV6SEVTjVJNvEVt4eEVwjgz/QJc
         P0O6yAX/ejEiyA/gFz0uhY/vXfHcJ+vCAmGawnkwguQzqaQTYgd186zfuq6mjFBNIHYk
         7uSWCKJtUvrDVEEU9ZcJESgd7U0Zf563i9DgfT39Cto1uaH0kzT0WaYKgYRW9yTgUvi1
         qjltiDR152YMIXzzRkdfTYlHi43tGRmIkyBTYxGJ2cqjF2SqyS1Hu9IQyziFncG7vIN0
         J/VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqml0fCj3N7TEM696y6gjFBLalESpzhr5JaZ7R3YXNQAEyPBBC2qv2R1eft3yEIAfVDd8OO5gnqVBu68T9fkJxzvj3
X-Gm-Message-State: AOJu0YxHQgsDDLgYV72Ins1Wj2ZzfYaGKv0SR+5j4SW66w/LzFUB0vPC
	keV6A1PkHCWEU3pHorPbOy4khhSn7K+RqPQZde/XhqD7LYAxzvpzzZnL4v9NWgeu2scs94fjQVg
	uqJJ/wzQM83mlgdPUSCIdiasNlSajoge77Xpq
X-Google-Smtp-Source: AGHT+IHSPl2srWABU7TtuEx6MInqkT/TqH/zLF1tN13BVl/h67uv526s9BJchBKedf9gNhwL02Rx2Ai332/cTTjwml8=
X-Received: by 2002:a05:6214:3911:b0:6af:c66a:d5a8 with SMTP id
 6a1803df08f44-6b030aa0653mr52388716d6.51.1717662403007; Thu, 06 Jun 2024
 01:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com> <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
 <1717644183.6895547-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1717644183.6895547-1-xuanzhuo@linux.alibaba.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 6 Jun 2024 10:26:06 +0200
Message-ID: <CAG_fn=Uvfeg7LGQGjTy4qDSoYis39OeyA3W7=FgOAU+isk5Acg@mail.gmail.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

>
> Could you try this?

(resending without HTML, sorry for inconvenience).
Hi Xuan,

What kernel revision does this patch apply to? I tried it against
v6.10-rc2, and only the first hunk applied.
However this seems to fix the problem, at least the kernel boots
without warnings now.

> Thanks.
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 37c9c5b55864..cb280b66c7a2 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3119,8 +3119,10 @@ dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
>
> -       if (!vq->use_dma_api)
> +       if (!vq->use_dma_api) {
> +               kmsan_handle_dma(virt_to_page(ptr), offset_in_page(ptr), size, dir);
>                 return (dma_addr_t)virt_to_phys(ptr);
> +       }
>
>         return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
>  }
> @@ -3171,8 +3173,10 @@ dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct page *page
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
>
> -       if (!vq->use_dma_api)
> +       if (!vq->use_dma_api) {
> +               kmsan_handle_dma(page, offset, size, dir);
>                 return page_to_phys(page) + offset;
> +       }
>
>         return dma_map_page_attrs(vring_dma_dev(vq), page, offset, size, dir, attrs);
>  }

