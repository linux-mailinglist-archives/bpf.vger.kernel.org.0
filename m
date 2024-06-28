Return-Path: <bpf+bounces-33321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7EA91B503
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 04:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E11C217BD
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 02:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E11B970;
	Fri, 28 Jun 2024 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbsS0Mod"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864F17C66
	for <bpf@vger.kernel.org>; Fri, 28 Jun 2024 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541196; cv=none; b=kZFa/nhCnXW5d6VqgK0yugpwpvg1v10o5hV1J3gJHI3wSzHllCxjTSS05yEL6BKwOQapwT3MrN2y8zV3Lpf1IF6e/ZbTiNTR3FxQEiM2GA5Q9UN4BwNEIQil8JPzI7cYylfjDcFBg9AfRg3bseLsGxoBqXn6JIxzqgsl7hrfdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541196; c=relaxed/simple;
	bh=0pl5IDO84YuTZzRBLOi54dqVTmqUceO1ojj7jTBbAEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9h4uNxL0B3jPhgu5MGpbibic0SLbuwLwhlECzCErgIt5mEmtx84ULe1ZVtMa55UnHb51dXWBN9AVJSDoPREyqm3zJ8JEsSFwUeu3EzT7fAQSRX/UWVp+RcXEfAIpHrKYuDYDOBG0od3vfpYWl31m387cPrMWyzQgDTyksDNpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SbsS0Mod; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719541193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nd9rJ/TDcLIKdWBumem351Ij8O7si91I+/ZDY+8chw=;
	b=SbsS0ModtgsKGQm4wyI0f/MDRCNT2a8vg7672iCRDpy7oTngVkVHxIBHSqKqe7Sk+4UcZC
	3TDYlURdYBf2EMACGjX7aZWQa1gaOmMdRXy7Y2z+fSAjcNahWkgvqJzeHoqyqWCGD71nFX
	9SgLqXPxpaWGyq03D2XDFAAGUf6+LzI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-W0nRV1D5Np2lgBjnLwv04Q-1; Thu, 27 Jun 2024 22:19:52 -0400
X-MC-Unique: W0nRV1D5Np2lgBjnLwv04Q-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3d244d4f2f5so209448b6e.2
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2024 19:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719541191; x=1720145991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nd9rJ/TDcLIKdWBumem351Ij8O7si91I+/ZDY+8chw=;
        b=qU1HF8q9XCQqqMX96+SXSyfDXXAunjbMsrSTZC2roEuBrQGVhFPssSRWTGFVpm4Q4K
         j6zBSdHFWb+4efNDUHehGNP4OeccGPtAs+sYBGbi6ZvPeecYyuuStwVXXmzFoM/AEJor
         8b2n2S+Hmb5ijLF6ShPqlESt6vLB4sfK08Lir6YnFI/G7XlLHeKGfTN/+dJUWYE/a24p
         8VgwfPsq0RIgydR5gSEpQl4o7K4c+/2xM+4FGX3b1oHLQOaWpJ5CRNlGFWbjxyUKJcwe
         4TcLn4X6tZVZjgMfkaphNUquTdHdGiSthfsSUooQUetj3AgYs/z1Gxm/Ji61/t/QDuWc
         Xcvg==
X-Forwarded-Encrypted: i=1; AJvYcCV7X+Hfzgs1ikaTTJLeOlAo05AuC2psVaYGry2cH608BzBsGyhVD45Eqvm4Cgno7WKnbjq5GQHAwvtbwKTs8qfAjDIB
X-Gm-Message-State: AOJu0YxMVOzeDaMSi0vHnHsbkZcx/RJ46hI4CHolOK7p6FfCpFACyoYd
	IwWqtd3Za6FcSWqCfHsEhoc2h5EUS2prgK3qHYVCffMp6Hoz+Qg8H6BF7VOXAUHC8PS9hjL84xu
	RSWxCXpKyOGro1UTK6q+aaWdeO/Xdi/uMWnRzyL1t0cHiRFL+fhkfr+7Wrx2EcV9AlH2qkwvJrc
	QN1F1pqgEOq1FFMbHEbR5AdPwG
X-Received: by 2002:a05:6808:15a6:b0:3d5:64be:890f with SMTP id 5614622812f47-3d564be8c87mr6974066b6e.49.1719541191260;
        Thu, 27 Jun 2024 19:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwwofqbOpDvkSmww0NDTJydZp0AN9afbKh2t1W7XoMUGKRy4SuVLpPH3aktVMj0GBaaPOqCpDTYZtjp/p+Mrw=
X-Received: by 2002:a05:6808:15a6:b0:3d5:64be:890f with SMTP id
 5614622812f47-3d564be8c87mr6974036b6e.49.1719541190592; Thu, 27 Jun 2024
 19:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618075643.24867-1-xuanzhuo@linux.alibaba.com> <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240618075643.24867-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Jun 2024 10:19:37 +0800
Message-ID: <CACGkMEta9o97cqUy+wV=1Xpu8MBoFt4CEtWS35dhTMs0Dm4AKg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/10] virtio_net: xsk: rx: support fill with
 xsk buffer
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

On Tue, Jun 18, 2024 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Implement the logic of filling rq with XSK buffers.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 68 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2bbc715f22c6..2ac5668a94ce 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -355,6 +355,8 @@ struct receive_queue {
>
>                 /* xdp rxq used by xsk */
>                 struct xdp_rxq_info xdp_rxq;
> +
> +               struct xdp_buff **xsk_buffs;
>         } xsk;
>  };
>
> @@ -1032,6 +1034,53 @@ static void check_sq_full_and_disable(struct virtn=
et_info *vi,
>         }
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg->dma_address =3D addr;
> +       sg->length =3D len;
> +}
> +
> +static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct recei=
ve_queue *rq,
> +                                  struct xsk_buff_pool *pool, gfp_t gfp)
> +{
> +       struct xdp_buff **xsk_buffs;
> +       dma_addr_t addr;
> +       u32 len, i;
> +       int err =3D 0;
> +       int num;
> +
> +       xsk_buffs =3D rq->xsk.xsk_buffs;
> +
> +       num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> +       if (!num)
> +               return -ENOMEM;
> +
> +       len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> +
> +       for (i =3D 0; i < num; ++i) {
> +               /* use the part of XDP_PACKET_HEADROOM as the virtnet hdr=
 space */
> +               addr =3D xsk_buff_xdp_get_dma(xsk_buffs[i]) - vi->hdr_len=
;

We had VIRTIO_XDP_HEADROOM, can we reuse it? Or if it's redundant
let's send a patch to switch to XDP_PACKET_HEADROOM.

Btw, the code assumes vi->hdr_len < xsk_pool_get_headroom(). It's
better to fail if it's not true when enabling xsk.

Thanks


