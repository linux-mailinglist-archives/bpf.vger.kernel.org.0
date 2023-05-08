Return-Path: <bpf+bounces-209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136FD6FA019
	for <lists+bpf@lfdr.de>; Mon,  8 May 2023 08:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D161C20953
	for <lists+bpf@lfdr.de>; Mon,  8 May 2023 06:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04771548A;
	Mon,  8 May 2023 06:46:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF6C320A
	for <bpf@vger.kernel.org>; Mon,  8 May 2023 06:46:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E9D902E
	for <bpf@vger.kernel.org>; Sun,  7 May 2023 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683528376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3fs6RPd+rpkyqQt3khyJ527IXYfeK7UBkSfPv276PM=;
	b=EEVOXMmu4l47shqTmcKg0VQPE1GhDO06EboJSL5P15VhgbGmHbUb+fTrOl7Zntkqvv8hhB
	ueVh7WR7mgXDD7aLL/76MjeeIbTl6y8yxiDqGKPf2yh8pPXNVqlGPV6ONoWLgrh0QB6xoZ
	LZtnvTfJCkMPbgnx4O1vC8XLyJi3spw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-fBwC6aPYMMmXRcTQxTxtRg-1; Mon, 08 May 2023 02:46:14 -0400
X-MC-Unique: fBwC6aPYMMmXRcTQxTxtRg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ac7d0a8269so19866941fa.0
        for <bpf@vger.kernel.org>; Sun, 07 May 2023 23:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683528373; x=1686120373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3fs6RPd+rpkyqQt3khyJ527IXYfeK7UBkSfPv276PM=;
        b=GA2+21Ktf8yJxhlLe+oehZbNM/i8GMJVoyKSw6N4bxtc7z2KiiFgUzAXDemwOjLsf8
         oFQ0oM9131z2Di6HPOjGecvIqh+EqOgrzuGhi2zzsiQF+WZ8s4Si6Nvzg2sDIiNp6DEi
         ge+OVGkhRgkXUfYge1GUGP2/et/pdbwH0bIzr6wmldSUQMipNPQV1QmSbfHz3SkCgP2D
         aEvVFvSuTyeQgYrQfw2ARkavnrZ5UynAZnwz9wy8NzF+QtSS9pbPNGyFsADLy6wfmvEt
         ivVfikoJAJ+y8CxK4h5N3lJIEccCJP3Xcr3oyDG157if6T1pNlMEeIvN+n3k/7lk4/bl
         iaUw==
X-Gm-Message-State: AC+VfDx2fKiY+zzo05I5JRqvV01RMvDeR768+cZhLbC/c0LRdWbADy7M
	bp6wUy5tqeLBC7lx0f+w7TOMyT42wO5phLs7xjBuFX5TsyaStHEoDcaSF7tnJcdbeWOV+zK45+G
	50nkiHLj3EgC5hnsoCrUBCbBh6X7x
X-Received: by 2002:a2e:87c7:0:b0:2ab:51ce:649d with SMTP id v7-20020a2e87c7000000b002ab51ce649dmr2423165ljj.37.1683528373279;
        Sun, 07 May 2023 23:46:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50J/yunbHFbeBJhY0AaPZdF9nZ2vK5gM3Exi7uCH8wGtCV8GnhhqTg9TvrQVh2X8Qm8JLQRjWgVfuMQMwVrW0=
X-Received: by 2002:a2e:87c7:0:b0:2ab:51ce:649d with SMTP id
 v7-20020a2e87c7000000b002ab51ce649dmr2423156ljj.37.1683528372991; Sun, 07 May
 2023 23:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230508061417.65297-1-xuanzhuo@linux.alibaba.com> <20230508061417.65297-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230508061417.65297-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 May 2023 14:46:01 +0800
Message-ID: <CACGkMEvZaehjDEH4rb7F-Gg_88W_AOXFockMxBLcGZqS9DLAWg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/15] virtio_net: virtnet_build_xdp_buff_mrg()
 auto release xdp shinfo
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, May 8, 2023 at 2:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> virtnet_build_xdp_buff_mrg() auto release xdp shinfo then the caller no
> need to careful the xdp shinfo.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b26e95c96141..2d1329c32751 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1194,7 +1194,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>                                  dev->name, *num_buf,
>                                  virtio16_to_cpu(vi->vdev, hdr->num_buffe=
rs));
>                         dev->stats.rx_length_errors++;
> -                       return -EINVAL;
> +                       goto err;
>                 }
>
>                 stats->bytes +=3D len;
> @@ -1213,7 +1213,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_de=
vice *dev,
>                         pr_debug("%s: rx error: len %u exceeds truesize %=
lu\n",
>                                  dev->name, len, (unsigned long)(truesize=
 - room));
>                         dev->stats.rx_length_errors++;
> -                       return -EINVAL;
> +                       goto err;
>                 }
>
>                 frag =3D &shinfo->frags[shinfo->nr_frags++];
> @@ -1228,6 +1228,10 @@ static int virtnet_build_xdp_buff_mrg(struct net_d=
evice *dev,
>
>         *xdp_frags_truesize =3D xdp_frags_truesz;
>         return 0;
> +
> +err:
> +       put_xdp_frags(xdp);
> +       return -EINVAL;
>  }
>
>  static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
> @@ -1357,7 +1361,7 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>                 err =3D virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, dat=
a, len, frame_sz,
>                                                  &num_buf, &xdp_frags_tru=
esz, stats);
>                 if (unlikely(err))
> -                       goto err_xdp_frags;
> +                       goto err_xdp;
>
>                 act =3D virtnet_xdp_handler(xdp_prog, &xdp, dev, xdp_xmit=
, stats);
>
> --
> 2.32.0.3.g01195cf9f
>


