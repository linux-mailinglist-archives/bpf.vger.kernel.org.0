Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044E66AFE3D
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 06:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCHFVQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 00:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCHFVP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 00:21:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46B19B2F9
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 21:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678252828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5GGVFABESW8V/hPXxolD/QL4B7cjVpVheaDk83W/kE=;
        b=DNAP6pxlFIVkx9LC0/K3o7TZrM+gv6LRmNfUDK6v732ljpuzRKh+mAWuHo1tAppNbulO9u
        O8IfPxY4nXw7PHT23s2IEDRZqJSwhoY1sXxUkFYg7h2u+x2JL5j/d+HeniDFsF/daiQzzm
        wd7NsGwS4GmAMD8fgSa5DP6DXT7iWzk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Ph020Sz1NSmX6e7BFUjwwA-1; Wed, 08 Mar 2023 00:20:27 -0500
X-MC-Unique: Ph020Sz1NSmX6e7BFUjwwA-1
Received: by mail-ot1-f70.google.com with SMTP id y14-20020a056830208e00b006943ddbfb7eso6666024otq.5
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 21:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678252827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5GGVFABESW8V/hPXxolD/QL4B7cjVpVheaDk83W/kE=;
        b=iumLAJVpWOo1OX15JN+3NoIvzJoo/9LUAR4bbrZ4A608AOb3Iv3yFtazFuify5iwPA
         xMPCsw5YG1LtPrZTDUQJ5F0uQAFsyVUJhjbgERrETmqDLJ+hV2Y4OmTfF4HhP89Ms+z9
         KEKzqG6WkG/94NhlWO+XaB4LbcW14FJDW5imqT+4Ch/NAZNBZbam5SRLBpeimQeRMAMJ
         ggIbkMipmcPsQeQDZI36JadXTzTAH4zgnIF6QobcjW7v+rcqWe/WFVOZ/UvRO/hSCppm
         0iPTr1SZqFz0vLQJLMDy3kmLjhX+se6Iwh2kixobFGGlV7VaA8LfiWgdmpy8VshvCnu4
         Y2ww==
X-Gm-Message-State: AO0yUKUSK1CIugw7Hn719WY/vq8kptggMmOSE+YPyaE0oROXSCxS/7Zo
        PJlWaFfkdwF6AHC5+TI+rulriIv7Hd/Q4wCvS8ePuatqcI7dE3igeddgTOhkyh6Ys6lb4BdskYB
        TpwtKP9U23IS0KcdSok9oW50aILIH
X-Received: by 2002:a54:4102:0:b0:37f:ab56:ff42 with SMTP id l2-20020a544102000000b0037fab56ff42mr5661465oic.9.1678252826881;
        Tue, 07 Mar 2023 21:20:26 -0800 (PST)
X-Google-Smtp-Source: AK7set/WmF3rrnuaCT+mrkYDjoeqmr/WPCyXrpNTYNmxVQ7YSnB5l9thIGvO471/Qfv+ZuKpJRfF0rFXbg/UZX05cmI=
X-Received: by 2002:a54:4102:0:b0:37f:ab56:ff42 with SMTP id
 l2-20020a544102000000b0037fab56ff42mr5661453oic.9.1678252826693; Tue, 07 Mar
 2023 21:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20230308024935.91686-1-xuanzhuo@linux.alibaba.com> <20230308024935.91686-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230308024935.91686-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 8 Mar 2023 13:20:15 +0800
Message-ID: <CACGkMEsp+2GhUO9cXHuet4AAhV-CdDrScUJdvbEcAoxacdBLzw@mail.gmail.com>
Subject: Re: [PATCH net, stable v1 1/3] virtio_net: reorder some funcs
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
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        Yichun Zhang <yichun@openresty.com>,
        Alexander Duyck <alexanderduyck@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 8, 2023 at 10:49=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The purpose of this is to facilitate the subsequent addition of new
> functions without introducing a separate declaration.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Not sure such reordering is suitable for -stable.

Thanks

> ---
>  drivers/net/virtio_net.c | 92 ++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fb5e68ed3ec2..8b31a04052f2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -545,6 +545,52 @@ static struct sk_buff *page_to_skb(struct virtnet_in=
fo *vi,
>         return skb;
>  }
>
> +static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
> +{
> +       unsigned int len;
> +       unsigned int packets =3D 0;
> +       unsigned int bytes =3D 0;
> +       void *ptr;
> +
> +       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> +               if (likely(!is_xdp_frame(ptr))) {
> +                       struct sk_buff *skb =3D ptr;
> +
> +                       pr_debug("Sent skb %p\n", skb);
> +
> +                       bytes +=3D skb->len;
> +                       napi_consume_skb(skb, in_napi);
> +               } else {
> +                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> +
> +                       bytes +=3D xdp_get_frame_len(frame);
> +                       xdp_return_frame(frame);
> +               }
> +               packets++;
> +       }
> +
> +       /* Avoid overhead when no packets have been processed
> +        * happens when called speculatively from start_xmit.
> +        */
> +       if (!packets)
> +               return;
> +
> +       u64_stats_update_begin(&sq->stats.syncp);
> +       sq->stats.bytes +=3D bytes;
> +       sq->stats.packets +=3D packets;
> +       u64_stats_update_end(&sq->stats.syncp);
> +}
> +
> +static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> +{
> +       if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> +               return false;
> +       else if (q < vi->curr_queue_pairs)
> +               return true;
> +       else
> +               return false;
> +}
> +
>  static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
>                                    struct send_queue *sq,
>                                    struct xdp_frame *xdpf)
> @@ -1714,52 +1760,6 @@ static int virtnet_receive(struct receive_queue *r=
q, int budget,
>         return stats.packets;
>  }
>
> -static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
> -{
> -       unsigned int len;
> -       unsigned int packets =3D 0;
> -       unsigned int bytes =3D 0;
> -       void *ptr;
> -
> -       while ((ptr =3D virtqueue_get_buf(sq->vq, &len)) !=3D NULL) {
> -               if (likely(!is_xdp_frame(ptr))) {
> -                       struct sk_buff *skb =3D ptr;
> -
> -                       pr_debug("Sent skb %p\n", skb);
> -
> -                       bytes +=3D skb->len;
> -                       napi_consume_skb(skb, in_napi);
> -               } else {
> -                       struct xdp_frame *frame =3D ptr_to_xdp(ptr);
> -
> -                       bytes +=3D xdp_get_frame_len(frame);
> -                       xdp_return_frame(frame);
> -               }
> -               packets++;
> -       }
> -
> -       /* Avoid overhead when no packets have been processed
> -        * happens when called speculatively from start_xmit.
> -        */
> -       if (!packets)
> -               return;
> -
> -       u64_stats_update_begin(&sq->stats.syncp);
> -       sq->stats.bytes +=3D bytes;
> -       sq->stats.packets +=3D packets;
> -       u64_stats_update_end(&sq->stats.syncp);
> -}
> -
> -static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
> -{
> -       if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> -               return false;
> -       else if (q < vi->curr_queue_pairs)
> -               return true;
> -       else
> -               return false;
> -}
> -
>  static void virtnet_poll_cleantx(struct receive_queue *rq)
>  {
>         struct virtnet_info *vi =3D rq->vq->vdev->priv;
> --
> 2.32.0.3.g01195cf9f
>

