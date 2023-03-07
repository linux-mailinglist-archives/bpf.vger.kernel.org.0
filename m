Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9346D6AD94C
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 09:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCGIfY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 03:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCGIfX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 03:35:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4232CD9
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 00:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678178078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LmY2wPnO87rx3RbzrpQdOXyZOLLC9c+tSZr18MF9Js=;
        b=dn87CdamkPkq8r7FLo36YORaeEbUTY8NCTRDw7wGlpUPvRG6JUatWPwAWOF8OYwLWpmYcy
        wB9hLn7SpafFi14O4exuHBgwOM+zpRNDKpAcoyk0vQisxO/gZhvanVCu39Yu0AFHzqIiy+
        TQHSRzD9lQIp36GexNgEViKy0W/+Q1k=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-pvDS90MRO-envL1toBj8hg-1; Tue, 07 Mar 2023 03:34:37 -0500
X-MC-Unique: pvDS90MRO-envL1toBj8hg-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-172c14fe3d4so7846239fac.4
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 00:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678178076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LmY2wPnO87rx3RbzrpQdOXyZOLLC9c+tSZr18MF9Js=;
        b=ECIdKCscPAhsUCFl97J3s55k9ExbzVmVsQS/Eh9/ZCMkczY2682AQaUfD7C0t77j6t
         AQuGKdD3U4cGN/uq56en4BcVQEzWkmn9/1MKO/zXyQl4ocFG7SDi1i+0NOEktbvH33s3
         s2v8vkq7Soyan1B0ueJD/OpwovhZxyMNjr/LiEf9VXsQri9LkVw24d3kQDM4IxawVmog
         RWFArWXxchpReS542/fNGb2RO7hgNQgVJV4P07U5QzSMyuEF2rlHWCxXhAGWCebrPfde
         uqk4UmYjmmDAT9AUriluzWT5Jnay1Ohc9Z5Cg4MfQp2Hwnvabb11jO/exreRAcHj68EJ
         qGgw==
X-Gm-Message-State: AO0yUKWVT1EzSohagb7Rv93MGqqiIYjBGVao6fCK/rQTHZhC0oR2HZnY
        eyzW+tEaVocg7wZAtyMTDZmhflktUMaXIYNHOnfUUn2iM8VBXsySbWRXx/EqpkMmFLF5BAEe0YW
        bzsTAOqCXCnnrKecQpsqKTJWLz2sE
X-Received: by 2002:a54:4612:0:b0:383:fad3:d19 with SMTP id p18-20020a544612000000b00383fad30d19mr4407522oip.9.1678178076744;
        Tue, 07 Mar 2023 00:34:36 -0800 (PST)
X-Google-Smtp-Source: AK7set9mdrdqs3J1EBK7p75F53bJ40P5FZgubP3hrPid3SD0+q5ZXZPN0rFwSbcEIpltgRrHZixRWmlvTVaOJBCBxV4=
X-Received: by 2002:a54:4612:0:b0:383:fad3:d19 with SMTP id
 p18-20020a544612000000b00383fad30d19mr4407515oip.9.1678178076533; Tue, 07 Mar
 2023 00:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com> <20230306041535.73319-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230306041535.73319-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 7 Mar 2023 16:34:25 +0800
Message-ID: <CACGkMEsyDvtTnUAUsv4Mg9sNnjthUuPaHsXbSs0vxGuQTAJPrQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] virtio_net: separate the logic of checking
 whether sq is full
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 6, 2023 at 12:15=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Separate the logic of checking whether sq is full. The subsequent patch
> will reuse this func.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 59 ++++++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fb5e68ed3ec2..777de0ec0b1b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1750,6 +1750,40 @@ static void free_old_xmit_skbs(struct send_queue *=
sq, bool in_napi)
>         u64_stats_update_end(&sq->stats.syncp);
>  }
>
> +static void check_sq_full(struct virtnet_info *vi, struct net_device *de=
v,
> +                         struct send_queue *sq)
> +{

Nit: we need a better name, it's not only the check but also can disable TX=
.

Thanks

> +       bool use_napi =3D sq->napi.weight;
> +       int qnum;
> +
> +       qnum =3D sq - vi->sq;
> +
> +       /* If running out of space, stop queue to avoid getting packets t=
hat we
> +        * are then unable to transmit.
> +        * An alternative would be to force queuing layer to requeue the =
skb by
> +        * returning NETDEV_TX_BUSY. However, NETDEV_TX_BUSY should not b=
e
> +        * returned in a normal path of operation: it means that driver i=
s not
> +        * maintaining the TX queue stop/start state properly, and causes
> +        * the stack to do a non-trivial amount of useless work.
> +        * Since most packets only take 1 or 2 ring slots, stopping the q=
ueue
> +        * early means 16 slots are typically wasted.
> +        */
> +       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> +               netif_stop_subqueue(dev, qnum);
> +               if (use_napi) {
> +                       if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
))
> +                               virtqueue_napi_schedule(&sq->napi, sq->vq=
);
> +               } else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))=
) {
> +                       /* More just got used, free them then recheck. */
> +                       free_old_xmit_skbs(sq, false);
> +                       if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
> +                               netif_start_subqueue(dev, qnum);
> +                               virtqueue_disable_cb(sq->vq);
> +                       }
> +               }
> +       }
> +}
> +
>  static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
>  {
>         if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
> @@ -1989,30 +2023,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb,=
 struct net_device *dev)
>                 nf_reset_ct(skb);
>         }
>
> -       /* If running out of space, stop queue to avoid getting packets t=
hat we
> -        * are then unable to transmit.
> -        * An alternative would be to force queuing layer to requeue the =
skb by
> -        * returning NETDEV_TX_BUSY. However, NETDEV_TX_BUSY should not b=
e
> -        * returned in a normal path of operation: it means that driver i=
s not
> -        * maintaining the TX queue stop/start state properly, and causes
> -        * the stack to do a non-trivial amount of useless work.
> -        * Since most packets only take 1 or 2 ring slots, stopping the q=
ueue
> -        * early means 16 slots are typically wasted.
> -        */
> -       if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> -               netif_stop_subqueue(dev, qnum);
> -               if (use_napi) {
> -                       if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)=
))
> -                               virtqueue_napi_schedule(&sq->napi, sq->vq=
);
> -               } else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))=
) {
> -                       /* More just got used, free them then recheck. */
> -                       free_old_xmit_skbs(sq, false);
> -                       if (sq->vq->num_free >=3D 2+MAX_SKB_FRAGS) {
> -                               netif_start_subqueue(dev, qnum);
> -                               virtqueue_disable_cb(sq->vq);
> -                       }
> -               }
> -       }
> +       check_sq_full(vi, dev, sq);
>
>         if (kick || netif_xmit_stopped(txq)) {
>                 if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq=
->vq)) {
> --
> 2.32.0.3.g01195cf9f
>

