Return-Path: <bpf+bounces-12795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 699F37D08D2
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 08:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5A2B214FF
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 06:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC66CA5C;
	Fri, 20 Oct 2023 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijVHk9iQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF59C8E4
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:52:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD0AB8
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697784728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10cbfzEVk27kgN03LPBPjZemOEg2DlC+TkYfvJQWsAc=;
	b=ijVHk9iQkYEru/cRNWGDdRD8VqsoK2KQO591Iw8eElKVKN4zDjJnWpwIeAzdIJBSjlzkhq
	TL72kxKVWRAfmRxI5O7TaYF9nd/jcQXLqo5QvZMlC4Zw4vGFww+d/E13w51PSC+LDH7C59
	SmjR4Jo1QUHK0u3QbUheOmAgiAzgY1g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-7i-HvLm9NRe-737DOgrmgg-1; Fri, 20 Oct 2023 02:52:07 -0400
X-MC-Unique: 7i-HvLm9NRe-737DOgrmgg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507b9078aaaso445807e87.2
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 23:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784726; x=1698389526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10cbfzEVk27kgN03LPBPjZemOEg2DlC+TkYfvJQWsAc=;
        b=fYtsmupbcr2VUr+PkgZokLsz1KP2eafdQlfcjz9MRsoMVtTixQ2K4PCdn0m8pYSAoV
         i4zRqhxq0fO0nI5vORgebi8/xCXdNCHMTNp0yuDs2iBMObuZWSuSFpCFj7BpeefYa+Tp
         xrwVpXhHs5NfHFVXmhGBCczH+dvP56v9QHgkKRdb/eAev6pFb2cMnWqymu5OsyygOfYk
         o69ywSm4QVv6UbDUu605Tt69PORfgGUjc/TP+BHDQmCtENBsOv4XEO9GeUYTrZBa88tI
         VgSFLXhuavgVlODKW+2g/gWCvivX4fkc8ZBCz74j8DZB+bDi0lrvykJJTDqYN9xo8tO4
         4hnA==
X-Gm-Message-State: AOJu0YwjzKKFHr2gxQp6SIGrGQUKoiM+5hoimKVqqQkGOXAw+8fz9/ID
	C7drQ1cMUASmQUl/LcKG+OHBRoA+Ijc7OKU033KdGfJVy+Gkx5fBFk8CQqA3lm6E/XXJIlvePY6
	iIPtdQ6ZPszo41E9aeYn5zU/WPhQw
X-Received: by 2002:a05:6512:214d:b0:507:99fe:3237 with SMTP id s13-20020a056512214d00b0050799fe3237mr541292lfr.41.1697784725943;
        Thu, 19 Oct 2023 23:52:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqzELhpEx22FYwYPhyfWTswvFv2Oj8GyZnrYRmy1SO1OL2VvOAVbm8+PFPWb4VQn5j6eQ7znrwUmrAEcGMPA8=
X-Received: by 2002:a05:6512:214d:b0:507:99fe:3237 with SMTP id
 s13-20020a056512214d00b0050799fe3237mr541278lfr.41.1697784725636; Thu, 19 Oct
 2023 23:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com> <20231016120033.26933-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Oct 2023 14:51:54 +0800
Message-ID: <CACGkMEv7pCQ9mnqBwbGWaoFHJZO06Q=SCPvihDbSb+7cEfD0ag@mail.gmail.com>
Subject: Re: [PATCH net-next v1 10/19] virtio_net: xsk: prevent disable tx napi
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 8:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
> we must stop tx napi from being disabled.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/net/virtio/main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index 38733a782f12..b320770e5f4e 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -3203,7 +3203,7 @@ static int virtnet_set_coalesce(struct net_device *=
dev,
>                                 struct netlink_ext_ack *extack)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> -       int ret, queue_number, napi_weight;
> +       int ret, queue_number, napi_weight, i;
>         bool update_napi =3D false;
>
>         /* Can't change NAPI weight if the link is up */
> @@ -3232,6 +3232,14 @@ static int virtnet_set_coalesce(struct net_device =
*dev,
>                 return ret;
>
>         if (update_napi) {
> +               /* xsk xmit depends on the tx napi. So if xsk is active,
> +                * prevent modifications to tx napi.
> +                */
> +               for (i =3D queue_number; i < vi->max_queue_pairs; i++) {
> +                       if (rtnl_dereference(vi->sq[i].xsk.pool))
> +                               return -EBUSY;
> +               }
> +
>                 for (; queue_number < vi->max_queue_pairs; queue_number++=
)
>                         vi->sq[queue_number].napi.weight =3D napi_weight;
>         }
> --
> 2.32.0.3.g01195cf9f
>


