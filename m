Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892926E89F9
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 08:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjDTGAZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 02:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjDTGAY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 02:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35340E7
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 22:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681970373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hveHIV0W/0tavurLqEiHz1ZtN9TlgvI4rK8vvrCevO8=;
        b=Fs2HOu78/GvJJ7PziubTyx4FKuQ82kg/ZST8zGZp77z992KrfC5VYleZF0aHCLK3tZUrrT
        ZPICwAH/isXxbwT7I1hvfmDlIQcyVaMz69j+2G+GfdT6CtHy5iIe/q+PoLcap5DlIqNb1v
        zi/X1DBmrt//A22mdqtR0jOQoF/ZoHk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450--B0Uzx5cPtuRaOAf6qj0zQ-1; Thu, 20 Apr 2023 01:59:32 -0400
X-MC-Unique: -B0Uzx5cPtuRaOAf6qj0zQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-38e279dfb65so441227b6e.1
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 22:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681970371; x=1684562371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hveHIV0W/0tavurLqEiHz1ZtN9TlgvI4rK8vvrCevO8=;
        b=aNdxn4bOBbxSa9YVpKsYTp4F1RhcCa/Rb0P7XNYJ9CBb3fWqXTgZYUp1OfpQIUfSx1
         LF59H5FNCDJ4Nf6SQGjBw+Xl/vRWnzuCBx+KFgfQ1i0HjMkxpRzQv/KvYckWLcy8ndLx
         Fit8Vz8eZG40qLzzpw8IQrOrqy2RNdKC+HHrOmn6tJuE0a3rF4OhDuKlZIW8Z5TTliAS
         XVWV6Jdj1+dbYBQ1SkQ1DJlshSnKfmU8ZBwrguIi7Kwubxkf2WRZZSrvkUvX4/Q5DKMe
         86cYvcolhJocneUFTnqxrnDYKbjxD4GtAzlx5YfYrO0wJdaQBxOnt5Dhvm8eVpz1Rx2p
         qiIQ==
X-Gm-Message-State: AAQBX9fhURWqWxgyeVAqXuUn5iysdg7xJtm9a7gdpYDZEqBlhNBLpZfc
        Bi+amx8PD1VVuNxe4ilmoh/a+Ez7qx2R0vOOMYrLMwvABYNyz/fvtBqqRqvbf8qsQYEVUZKim2J
        WbKEgL8Nb9wMFsDm4fgV2Y7TYbBHg
X-Received: by 2002:a05:6808:dc4:b0:38e:76b7:373b with SMTP id g4-20020a0568080dc400b0038e76b7373bmr122685oic.53.1681970371346;
        Wed, 19 Apr 2023 22:59:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZvYzMl2Q/fTCVElfs5rQv18o8xDGYLuKKRqRJEJpB7Hd9k4LnatLfEPLyfUP2jvZRreRukLvonhHp+BHD/cgY=
X-Received: by 2002:a05:6808:dc4:b0:38e:76b7:373b with SMTP id
 g4-20020a0568080dc400b0038e76b7373bmr122660oic.53.1681970370934; Wed, 19 Apr
 2023 22:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com> <20230418065327.72281-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-4-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 20 Apr 2023 13:59:19 +0800
Message-ID: <CACGkMEu6Bqcskv1wtXGFrMMxx2ALLq3M9-6fOnnbR0ph7FtqNA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 03/14] virtio_net: optimize mergeable_xdp_prepare()
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 18, 2023 at 2:53=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The previous patch, in order to facilitate review, I do not do any
> modification. This patch has made some optimization on the top.
>
> * remove some repeated logics in this function.
> * add fast check for passing without any alloc.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/net/virtio_net.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 12559062ffb6..50dc64d80d3b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1192,6 +1192,11 @@ static void *mergeable_xdp_prepare(struct virtnet_=
info *vi,
>          */
>         *frame_sz =3D truesize;
>
> +       if (likely(headroom >=3D virtnet_get_headroom(vi) &&
> +                  (*num_buf =3D=3D 1 || xdp_prog->aux->xdp_has_frags))) =
{
> +               return page_address(*page) + offset;
> +       }
> +
>         /* This happens when headroom is not enough because
>          * of the buffer was prefilled before XDP is set.
>          * This should only happen for the first several packets.
> @@ -1200,22 +1205,15 @@ static void *mergeable_xdp_prepare(struct virtnet=
_info *vi,
>          * support it, and we don't want to bother users who are
>          * using xdp normally.
>          */
> -       if (!xdp_prog->aux->xdp_has_frags &&
> -           (*num_buf > 1 || headroom < virtnet_get_headroom(vi))) {
> +       if (!xdp_prog->aux->xdp_has_frags) {
>                 /* linearize data for XDP */
>                 xdp_page =3D xdp_linearize_page(rq, num_buf,
>                                               *page, offset,
>                                               VIRTIO_XDP_HEADROOM,
>                                               len);
> -               *frame_sz =3D PAGE_SIZE;
> -
>                 if (!xdp_page)
>                         return NULL;
> -               offset =3D VIRTIO_XDP_HEADROOM;
> -
> -               put_page(*page);
> -               *page =3D xdp_page;
> -       } else if (unlikely(headroom < virtnet_get_headroom(vi))) {
> +       } else {
>                 xdp_room =3D SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
>                                           sizeof(struct skb_shared_info))=
;
>                 if (*len + xdp_room > PAGE_SIZE)
> @@ -1227,14 +1225,15 @@ static void *mergeable_xdp_prepare(struct virtnet=
_info *vi,
>
>                 memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
>                        page_address(*page) + offset, *len);
> -               *frame_sz =3D PAGE_SIZE;
> -               offset =3D VIRTIO_XDP_HEADROOM;
> -
> -               put_page(*page);
> -               *page =3D xdp_page;
>         }
>
> -       return page_address(*page) + offset;
> +       *frame_sz =3D PAGE_SIZE;
> +
> +       put_page(*page);
> +
> +       *page =3D xdp_page;
> +
> +       return page_address(*page) + VIRTIO_XDP_HEADROOM;
>  }
>
>  static struct sk_buff *receive_mergeable(struct net_device *dev,
> --
> 2.32.0.3.g01195cf9f
>

