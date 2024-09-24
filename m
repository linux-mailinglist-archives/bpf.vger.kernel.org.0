Return-Path: <bpf+bounces-40244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F54A984062
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D6AB22B4F
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1939714F123;
	Tue, 24 Sep 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="teDtWxmQ"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FEC14D2A7;
	Tue, 24 Sep 2024 08:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166250; cv=none; b=VEptzfjVGI0+28EWmARHHo4QenRht1Gz+oi7OUCdrWxg72h60P1xJ85IwwGiX9sw5u4/V2J574vkpNxir7IOC2Y/Xgc8JLE75lLqDemw0WF4/PVr9SbHo3qZypYi28owLd5PoPUdeKfN9lHJSdM74ZRG03/vz0RJx3+WnR+6nzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166250; c=relaxed/simple;
	bh=HLr8oWvgzOpLtqPcMBjfonh4/FyMI+ThhNUZFnu5JcI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=I67RXlyqGMJsRYEUn94pYzurj4xY9bjeeJ69wE0cu5oMP6cmO2LypBbnmNe4hzmuozFt3vrVdCotCoqWidTtRnTFiU1F3FIZ4m5mNx7CAWOUv5MCDX6eIC2nlxdNCo5PcEcQryvCxN+g9VBnn9GL7qer/KGNfLeV4Hm31+dfxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=teDtWxmQ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727166244; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=xisSaNawnlGSwR/PzRWf7E78QFcMlAE+VNQimYqDHBg=;
	b=teDtWxmQWskXeiaUXQZaDBPImhagFptu/bKRDv35ZsYnzqcPzBhGC/IGF5AvVV3zjn1H9E6RJbaV/c23sKyIkZlQG2NfdsuNj5fg52LP2V9kPjWL5jLyjexw/rI7+3JmakSlkue4faZrW7aQUhu0N2IPxqpSHPHQuxYXb5jJyV8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WFfUpEj_1727166243)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 16:24:04 +0800
Message-ID: <1727166134.9448166-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next v1 04/12] virtio_ring: perform premapped operations based on per-buffer
Date: Tue, 24 Sep 2024 16:22:14 +0800
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
 <20240924013204.13763-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEtuF8xx-R08oKmoZo3dMSnCBkjG9tKTZJ=mL1z=SgO2tQ@mail.gmail.com>
In-Reply-To: <CACGkMEtuF8xx-R08oKmoZo3dMSnCBkjG9tKTZJ=mL1z=SgO2tQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Tue, 24 Sep 2024 15:35:01 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Sep 24, 2024 at 9:32=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > The current configuration sets the virtqueue (vq) to premapped mode,
> > implying that all buffers submitted to this queue must be mapped ahead
> > of time. This presents a challenge for the virtnet send queue (sq): the
> > virtnet driver would be required to keep track of dma information for vq
> > size * 17, which can be substantial. However, if the premapped mode were
> > applied on a per-buffer basis, the complexity would be greatly reduced.
> > With AF_XDP enabled, AF_XDP buffers would become premapped, while kernel
> > skb buffers could remain unmapped.
> >
> > We can distinguish them by sg_page(sg), When sg_page(sg) is NULL, this
> > indicates that the driver has performed DMA mapping in advance, allowing
> > the Virtio core to directly utilize sg_dma_address(sg) without
> > conducting any internal DMA mapping. Additionally, DMA unmap operations
> > for this buffer will be bypassed.
>
> So I think we still need some explanation here. I think this works for
> virtio-net as the sgs are initialized by the virtio-net device itself.
>
> But it seems not the case for all the others where the sgs were passed
> from the uppyer subsystem. For example in __virtscsi_add_cmd(), we
> had:
>
>         if (sc && sc->sc_data_direction !=3D DMA_NONE) {
>         if (sc->sc_data_direction !=3D DMA_FROM_DEVICE)
>                 out =3D &sc->sdb.table;
>         if (sc->sc_data_direction !=3D DMA_TO_DEVICE)
>                 in =3D &sc->sdb.table;
>         }
>
>         /* Request header.  */
>         sg_init_one(&req, &cmd->req, req_size);
>         sgs[out_num++] =3D &req;
>
>         /* Data-out buffer.  */
>         if (out) {
>                 /* Place WRITE protection SGLs before Data OUT payload */
>                 if (scsi_prot_sg_count(sc))
>                         sgs[out_num++] =3D scsi_prot_sglist(sc);
>                 sgs[out_num++] =3D out->sgl;
>         }


With this in mind, I think the new api is a suitable approach to avoid chan=
ging
sg.

Thanks.

>
> Thanks
>

