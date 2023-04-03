Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B16D3BE8
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 04:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjDCCrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 22:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDCCru (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 22:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C893AF2B
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 19:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680490020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXT/6aJaAFqn+Kdcq/fX5XU9hNNDC+uvyYrVFSSigv8=;
        b=eX6y9xu2FyyLf/qEpRdSKshu6fv4/GSQ9VUqM/fDUgYDgjxZkfJc3hZk78evuK1Tx4ZHem
        dO4xOdvcj84WluUC3GPdWuhlWwqH/wwu9Fp4JiuYFbAEQOTuF2JFVwgi1aIjeQ/bNYQZwl
        UjWwzLL8fimbCZdJlEovIvnjkDMkJjs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-iBXuy9o0PAeuSqlJjl0NYw-1; Sun, 02 Apr 2023 22:46:51 -0400
X-MC-Unique: iBXuy9o0PAeuSqlJjl0NYw-1
Received: by mail-oi1-f197.google.com with SMTP id b7-20020aca3407000000b00386d0eeb190so6584036oia.18
        for <bpf@vger.kernel.org>; Sun, 02 Apr 2023 19:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680490011; x=1683082011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXT/6aJaAFqn+Kdcq/fX5XU9hNNDC+uvyYrVFSSigv8=;
        b=sNxn50VV/WO/7IJRInlMYPbn1PFgJ6HQM333wsESasT8atM41bWj8UASQ+R7CFatLS
         jQsUtL5ot5P2hQix5Znexyen4Qai6aTfEh3CqeSUDwsBft9Wyqt9/TGhXzRe5OSytHN8
         jgtcgziPBFboOixBprOmwqdRKejvYedo1kgTSQm1uomhy4FlAH0LH/u5wllJ+bzhuv26
         gUIpoRHruoiZuIZqTuQl8lZ5EQNJSfghs+grzAD/mB+1Aahqufra+NrGe1qtNqh5ZUZh
         wdgNEhj3tf3C+1HSZAE8ygvXlVz4A0uOCMsDW2jPt+Ymh5BjhF+nT+cni/72WP0Cq+YQ
         nhgg==
X-Gm-Message-State: AO0yUKX96gnA1ETwho0JU+ksa7TIoLBaIBShWcZH546Nf71bC9mBgau9
        Ey4ViR9b8QTcyX+Q7sR1KSAMkyXJEzBJqbiQsb1lobTYq4p4KMH/3WuhmtftJoSEOr8ayUlQTNi
        wfEqaheOwZZ4Y5KbZO7gBv+SbjZO4
X-Received: by 2002:a4a:a28a:0:b0:525:2b3b:7453 with SMTP id h10-20020a4aa28a000000b005252b3b7453mr10890517ool.0.1680490010932;
        Sun, 02 Apr 2023 19:46:50 -0700 (PDT)
X-Google-Smtp-Source: AK7set9dweL2R/ZOkTjHu4vsan6RXJ8ez4+ot09bhRJuDhHtHDmXSGAsQ+yY1sL/XLcZP8/opt6udhmUV8gRh09VAYo=
X-Received: by 2002:a4a:a28a:0:b0:525:2b3b:7453 with SMTP id
 h10-20020a4aa28a000000b005252b3b7453mr10890503ool.0.1680490010690; Sun, 02
 Apr 2023 19:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230328120412.110114-1-xuanzhuo@linux.alibaba.com> <20230328120412.110114-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230328120412.110114-6-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 3 Apr 2023 10:46:39 +0800
Message-ID: <CACGkMEurBLHds7Am=pBm9vTWvWczVfQoOJ_wCJWVBxuyHXzsfA@mail.gmail.com>
Subject: Re: [PATCH net-next 5/8] virtio_net: separate the logic of freeing
 the rest mergeable buf
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 8:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This patch introduce a new function that frees the rest mergeable buf.
> The subsequent patch will reuse this function.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 09aed60e2f51..a3f2bcb3db27 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1076,6 +1076,28 @@ static struct sk_buff *receive_big(struct net_devi=
ce *dev,
>         return NULL;
>  }
>
> +static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
> +                              struct net_device *dev,
> +                              struct virtnet_rq_stats *stats)
> +{
> +       struct page *page;
> +       void *buf;
> +       int len;
> +
> +       while (num_buf-- > 1) {
> +               buf =3D virtqueue_get_buf(rq->vq, &len);
> +               if (unlikely(!buf)) {
> +                       pr_debug("%s: rx error: %d buffers missing\n",
> +                                dev->name, num_buf);
> +                       dev->stats.rx_length_errors++;
> +                       break;
> +               }
> +               stats->bytes +=3D len;
> +               page =3D virt_to_head_page(buf);
> +               put_page(page);
> +       }
> +}
> +
>  /* Why not use xdp_build_skb_from_frame() ?
>   * XDP core assumes that xdp frags are PAGE_SIZE in length, while in
>   * virtio-net there are 2 points that do not match its requirements:
> @@ -1436,18 +1458,8 @@ static struct sk_buff *receive_mergeable(struct ne=
t_device *dev,
>         stats->xdp_drops++;
>  err_skb:
>         put_page(page);
> -       while (num_buf-- > 1) {
> -               buf =3D virtqueue_get_buf(rq->vq, &len);
> -               if (unlikely(!buf)) {
> -                       pr_debug("%s: rx error: %d buffers missing\n",
> -                                dev->name, num_buf);
> -                       dev->stats.rx_length_errors++;
> -                       break;
> -               }
> -               stats->bytes +=3D len;
> -               page =3D virt_to_head_page(buf);
> -               put_page(page);
> -       }
> +       mergeable_buf_free(rq, num_buf, dev, stats);
> +
>  err_buf:
>         stats->drops++;
>         dev_kfree_skb(head_skb);
> --
> 2.32.0.3.g01195cf9f
>

