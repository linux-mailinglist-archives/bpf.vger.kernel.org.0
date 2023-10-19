Return-Path: <bpf+bounces-12645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3F7CEE95
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 06:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894D4B2127A
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 04:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F75028F4;
	Thu, 19 Oct 2023 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVYKOIlu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562146669
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 04:17:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECE8121
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 21:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697689037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KkTsB++L+7i7UU1Yoshrhi1BDk79q1+A3Ig7HjEAKaw=;
	b=UVYKOIluqDo9VqNy1gmiEPkhn8y3IZjcDjg6cU80WJ6zr1CuKmBpnyOuVfN5hrsDX5cQ0P
	AOxjFB2nGMlU+jusj+BR3EHDh3GD+CX95xoGzsDbjBg1aGty9HjTP5uI/WwWx4FqKalgf9
	WjWFWvM7K3RiU2BCv5Z3Dtvc8smEMy0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-6N52hok_MfCns9sfkSM8Vw-1; Thu, 19 Oct 2023 00:17:16 -0400
X-MC-Unique: 6N52hok_MfCns9sfkSM8Vw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-507a00a2357so195536e87.1
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 21:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697689034; x=1698293834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkTsB++L+7i7UU1Yoshrhi1BDk79q1+A3Ig7HjEAKaw=;
        b=FKI8NRjvLFEcqVBSLglhHxMTlI/5VlLqo2VReeob7RlJquFfabeHhqgPm84GBZ2fZM
         Pwa0r/v1PhsPaIFhfginUjfqkbUBd3mo4LjYzy71i4aoxUy9S+peFj7r6X+LCHZfkguU
         xytB44vk57hMgoo0ION/010Xj5yEbz5PtGqYF9VU0s+4d5AMMw84D08KJOLPQgxs1m+H
         dptNttbbyrKWOMxF8bR5OlKXebaXF9dKd6RNSfhzDx5Qce4y4D/gkh+ixTLr3565hAmC
         UnTXBnbsDFST9eTP1cosF9S8r6kkEAalw2YvEwD6VOGAQN1bV+CsEf+SyPx0FfwPD3DF
         zaYQ==
X-Gm-Message-State: AOJu0YzKZiWl7S/8eF1OLrIifjvIrCf3OkGzzRvxhauopt7AfObUGA8Q
	GmpRQQWcq6CpqG6p8sXUR/WyG+c5Jf3xF4BvlFuuZMkuqlSFSYqzw3c1qK8RgIkF3jIJvNu2/Wn
	nCgUHR0nKB1figuP55Wa6trnF34al
X-Received: by 2002:a05:6512:3c99:b0:504:33cd:ad1 with SMTP id h25-20020a0565123c9900b0050433cd0ad1mr206006lfv.27.1697689034578;
        Wed, 18 Oct 2023 21:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfUGZ0KgN83ChsxOZDC1tVe9D8W4LROZWc0NwAIHQ4POZXJoKA9TotA+ytmBZT+6J9VOoYZT2zJ5oG4swkEF4=
X-Received: by 2002:a05:6512:3c99:b0:504:33cd:ad1 with SMTP id
 h25-20020a0565123c9900b0050433cd0ad1mr205982lfv.27.1697689034175; Wed, 18 Oct
 2023 21:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 12:17:03 +0800
Message-ID: <CACGkMEuU9Ek-01wf0vf82pF=+1SKbjVpykLFdboDioA-CaSV8w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 01/19] virtio_net: rename free_old_xmit_skbs
 to free_old_xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:00=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Since free_old_xmit_skbs not only deals with skb, but also xdp frame and
> subsequent added xsk, so change the name of this function to
> free_old_xmit.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fe7f314d65c9..3d87386d8220 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -744,7 +744,7 @@ static void virtnet_rq_set_premapped(struct virtnet_i=
nfo *vi)
>         }
>  }
>
> -static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
> +static void free_old_xmit(struct send_queue *sq, bool in_napi)
>  {
>         unsigned int len;
>         unsigned int packets =3D 0;
> @@ -816,7 +816,7 @@ static void check_sq_full_and_disable(struct virtnet_=
info *vi,
>                                 virtqueue_napi_schedule(&sq->napi, sq->vq=
);
>                 } else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))=
) {
>                         /* More just got used, free them then recheck. */
> -                       free_old_xmit_skbs(sq, false);
> +                       free_old_xmit(sq, false);
>                         if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
>                                 netif_start_subqueue(dev, qnum);
>                                 virtqueue_disable_cb(sq->vq);
> @@ -2124,7 +2124,7 @@ static void virtnet_poll_cleantx(struct receive_que=
ue *rq)
>
>                 do {
>                         virtqueue_disable_cb(sq->vq);
> -                       free_old_xmit_skbs(sq, true);
> +                       free_old_xmit(sq, true);
>                 } while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>
>                 if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> @@ -2246,7 +2246,7 @@ static int virtnet_poll_tx(struct napi_struct *napi=
, int budget)
>         txq =3D netdev_get_tx_queue(vi->dev, index);
>         __netif_tx_lock(txq, raw_smp_processor_id());
>         virtqueue_disable_cb(sq->vq);
> -       free_old_xmit_skbs(sq, true);
> +       free_old_xmit(sq, true);
>
>         if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
>                 netif_tx_wake_queue(txq);
> @@ -2336,7 +2336,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, =
struct net_device *dev)
>                 if (use_napi)
>                         virtqueue_disable_cb(sq->vq);
>
> -               free_old_xmit_skbs(sq, false);
> +               free_old_xmit(sq, false);
>
>         } while (use_napi && kick &&
>                unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> --
> 2.32.0.3.g01195cf9f
>


