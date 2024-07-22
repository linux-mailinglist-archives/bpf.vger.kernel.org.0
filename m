Return-Path: <bpf+bounces-35212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7EE938A05
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 09:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF6328169F
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 07:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB66208A4;
	Mon, 22 Jul 2024 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7ZJS+px"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380731BC40
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633283; cv=none; b=bFaJDTnbMuVoYJhmkJHMMZsOZYRYcqgU1+PcJcwVgfubx+UofbGvJ02QY3iEc7KwKzsNpNSZCLIm5dZGp+F7DRtdk6fkK19AF/SVhWW89WNd8Pya66fKEU8IGb1I+BOII1LvVQA+yVSR7T9vsAUnrJCTTy+eQ4ABhuH4brlrmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633283; c=relaxed/simple;
	bh=Nm/iP+Ef8w5C1p1oN7/SGXtY7xU8KLhZVOqrCxwRuHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTptXF3qgLzDb/WHdTtP3g68JORKgBxU0I6CCFhf2+eaSrS4MyLRRkQOVJrPPYPi79LoIBUaGLIgYPXvqVFiIvTO3S6oPdOXpNq45+U3KhT0Duxtzlgh4PsXMQ+Q+wAQ0WS0+/JwwsoBBCArvBxRbM638AHO7FCz95eocnKdp3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7ZJS+px; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721633281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T95/0g9beK9xkQ+nBBsS0HYON2c9LYVJ1w/U2mpnGSc=;
	b=F7ZJS+pxZGtH5RS0W5gdGiEocn17Mpye4byDXn/GZB94UGxf/TIFS6xYq36XbUT497t288
	cWvAW6R+xP98x2vW8g6ZJRAdzbXD4z/zTA6XjwGNsPbDN6XnxTM1mEbmCVRbinDihugIBx
	eCezfsG6MzA5fkqebVrFq3Lckm/PHSU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-xcHuGd2zMYCGEiSEKSY9Xg-1; Mon, 22 Jul 2024 03:27:59 -0400
X-MC-Unique: xcHuGd2zMYCGEiSEKSY9Xg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-70d235e630dso655620b3a.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 00:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721633274; x=1722238074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T95/0g9beK9xkQ+nBBsS0HYON2c9LYVJ1w/U2mpnGSc=;
        b=r0o8rAmN9iG1J9rrzHX6gaOBz6nQinvgAkX/UgJjbaMim7SCPmwrxX2Ib/GiTBVVDC
         MyJkeIaEoplDh/6WgBr6+ttEfoZxU34G2QeyuB1tHtqoze+14ZBtdzvEuZJ9oEaIjjaf
         7Vik8Qj6hRgHPuTMaujMSPAdBxQLk6X4cPSnhKCuoM0fiqsB18oMSEzKEG8upby1chN9
         WCU/0l9fS+p85OAAR8cxX7B1a34Fy6zRneGLnI7MiK8BfwDDlPYFLQmmZbIFo3JuyDwJ
         WE16SpNu4oNp7+V3r45bvBn88JhoVl03MeiARnQmWKQ36pbNmPP1iYl/cJfdPTIXd6/X
         FVdg==
X-Forwarded-Encrypted: i=1; AJvYcCVy6Vvx31zj9nqNa+uKE9uqpBrA6b0iLTW4bcdhnPh/40sJz0H5cGYeBoDddmI3bIqo2LPGKvLuofLAI43apkSFqgKg
X-Gm-Message-State: AOJu0Yx33XMQi9kD8Degs3UAtgnh5TeOH5ab1OJ7+ObfKFF03k+7N/BH
	10N55CbFQFpOI4rWKP1Sm+a7M0wUjwoDgdSIgWtqOpuKjmWulBWCD8CKiHhwwLRjHYgBY1z10ss
	eYxzbKOLWKsFgUeQZkD9Rxt4xXRhydZCouxr1khRc1F2ioeccAti67//tW0PP7q1cKTLNt5b9EE
	5mqZuS1QjYZyDVN9shM3QlaXSo
X-Received: by 2002:a05:6a21:999b:b0:1c2:1ed4:4f90 with SMTP id adf61e73a8af0-1c4285689f6mr3925563637.19.1721633273712;
        Mon, 22 Jul 2024 00:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxIPcCd1WW98vl8lXbLzkIH0a8Q+ehSVLCBNp9CRt+/VuFx/jMBlf8mhAQqthIef6gJKjwps/aEk4qySfjQO4=
X-Received: by 2002:a05:6a21:999b:b0:1c2:1ed4:4f90 with SMTP id
 adf61e73a8af0-1c4285689f6mr3925519637.19.1721633273096; Mon, 22 Jul 2024
 00:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jul 2024 15:27:42 +0800
Message-ID: <CACGkMEsX5CwQmrwYzosSDMRdOfYVEmaL6x0-M9fWq0whwyRwSQ@mail.gmail.com>
Subject: Re: [RFC net-next 00/13] virtio-net: support AF_XDP zero copy (tx)
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 2:46=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> ## AF_XDP
>
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The z=
ero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already suppo=
rt
> this feature, This patch set allows virtio-net to support xsk's zerocopy =
xmit
> feature.
>
> At present, we have completed some preparation:
>
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
>
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
>
> Virtio-net can not increase the queue num at will, so xsk shares the queu=
e with
> kernel.
>
> This patch set includes some refactor to the virtio-net to let that to su=
pport
> AF_XDP.
>
> ## About virtio premapped mode
>
> The current configuration sets the virtqueue (vq) to premapped mode,
> implying that all buffers submitted to this queue must be mapped ahead
> of time. This presents a challenge for the virtnet send queue (sq): the
> virtnet driver would be required to keep track of dma information for vq
> size * 17, which can be substantial. However, if the premapped mode were
> applied on a per-buffer basis, the complexity would be greatly reduced.
> With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
> skb buffers could remain unmapped.
>
> We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
> indicates that the driver has performed DMA mapping in advance, allowing
> the Virtio core to directly utilize sg_dma_address(sg) without
> conducting any internal DMA mapping. Additionally, DMA unmap operations
> for this buffer will be bypassed.
>
> ## performance
>
> ENV: Qemu with vhost-user(polling mode).
> Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
>
> ### virtio PMD in guest with testpmd
>
> testpmd> show port stats all
>
>  ######################## NIC statistics for port 0 #####################=
###
>  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
>  RX-errors: 0
>  RX-nombuf: 0
>  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
>
>
>  Throughput (since last show)
>  Rx-pps:   8861574     Rx-bps:  3969985208
>  Tx-pps:   8861493     Tx-bps:  3969962736
>  ########################################################################=
####
>
> ### AF_XDP PMD in guest with testpmd
>
> testpmd> show port stats all
>
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
>
>   Throughput (since last show)
>   Rx-pps:      6333196          Rx-bps:   2837272088
>   Tx-pps:      6333227          Tx-bps:   2837285936
>   #######################################################################=
#####
>
> But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
>
> Please review.
>
> Thanks.
>
> Xuan Zhuo (13):
>   virtio_ring: introduce vring_need_unmap_buffer
>   virtio_ring: split: harden dma unmap for indirect
>   virtio_ring: packed: harden dma unmap for indirect
>   virtio_ring: perform premapped operations based on per-buffer
>   virtio-net: rq submits premapped buffer per buffer
>   virtio_ring: remove API virtqueue_set_dma_premapped
>   virtio_net: refactor the xmit type
>   virtio_net: xsk: bind/unbind xsk for tx
>   virtio_net: xsk: prevent disable tx napi
>   virtio_net: xsk: tx: support xmit xsk buffer
>   virtio_net: xsk: tx: handle the transmitted xsk buffer
>   virtio_net: update tx timeout record
>   virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
>
>  drivers/net/virtio_net.c     | 363 ++++++++++++++++++++++++++++-------
>  drivers/virtio/virtio_ring.c | 302 ++++++++++++-----------------
>  include/linux/virtio.h       |   2 -
>  3 files changed, 421 insertions(+), 246 deletions(-)
>
> --
> 2.32.0.3.g01195cf9f
>

Hi Xuan:

I wonder why this series is tagged as "RFC"?

Thanks


