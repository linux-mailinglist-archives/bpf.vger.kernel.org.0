Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146706EEC98
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 05:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjDZDOg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 23:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjDZDOe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 23:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE6210E
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 20:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682478825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBu915H8CYkTjrtvIiCsbssLWyRdiWGP5IQleYTqxXw=;
        b=bAxz74bhVfejzFzwaNO/OoaTijmC6aVMrql6ZCuE7MN41RXSV1RZxF6DiZkniQ9afRMC85
        BiZtbqvFPQF/jJgOJ+or4loyez3Z44HyRBjuwK5eihBT9XYwvA+ZdbbdHE5+HtbpzK9X9V
        iEEvhgTejE0SKCfG6WHx7OkzKEbS+Jw=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-LcMSDmJqOEqeKHq2W44trg-1; Tue, 25 Apr 2023 23:13:44 -0400
X-MC-Unique: LcMSDmJqOEqeKHq2W44trg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4edd5a7cddeso7918303e87.0
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 20:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682478823; x=1685070823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBu915H8CYkTjrtvIiCsbssLWyRdiWGP5IQleYTqxXw=;
        b=Sovfky+QiUfk3+2WvFlKvqWKPIw3cgLBn546A2peR/lDgt8mxwm60z85zrDha8346B
         SJBUNK/acYsYc88dwDeijbtBLIrro1+aIPvSACgHGC3mx6J3Sf8pc7bQsmvIwRpqL8Lg
         MHx9kd79Y5QOG2H6MkX3qSAh9aThHDfxZ2c46gErzhVac8eL8J9lL11y6d6g0QaSXepd
         RWjU38kmWPTDOXwktudEqiIOq4+FYm3d9wCEFk5amnqW1HbcfirT9xdJWCM9JlsOR89r
         hbs/11T0Jn5JE8+R+UtJ/U9m2liDTgYRjNQpdfsh1+Zw4W/ghjnpUZMZaP5W1f35vs5l
         vZAw==
X-Gm-Message-State: AC+VfDzycZzTTZ/OsQyRnXdk4PCH+ZD3uiTHndlQJS56g/hISnTOmDXr
        K9pDs/oZjyPbRrhcfgawkqLk6Yk80IRHEw0gCUUgy9e0MC7QNJOTum0DgIbadINzpOw4fggPqKv
        2+3ot7c3aoLSXFbyCS0WPv1H2Kudd
X-Received: by 2002:ac2:4f01:0:b0:4ed:c758:6b5a with SMTP id k1-20020ac24f01000000b004edc7586b5amr221572lfr.4.1682478822789;
        Tue, 25 Apr 2023 20:13:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bzDuPAoLkRvJ6hXcx6xfJgVJ4CQKsoGORFUb4ySVnfNMcZWlRncRle3bnaBr2mCupDi+qJ0ruKkuAQvpkksQ=
X-Received: by 2002:ac2:4f01:0:b0:4ed:c758:6b5a with SMTP id
 k1-20020ac24f01000000b004edc7586b5amr221565lfr.4.1682478822513; Tue, 25 Apr
 2023 20:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com> <20230423105736.56918-14-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230423105736.56918-14-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 26 Apr 2023 11:13:31 +0800
Message-ID: <CACGkMEuL8nACFdFQamOm-u+iDiMPHL9X8Dta86OtVvOV-u0P0A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 13/15] virtio_net: small: remove skip_xdp
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 23, 2023 at 6:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> now, the process of xdp is simple, we can remove the skip_xdp.

I would say the reason why xdp is simple, I think it is because the
skb build path is not shared between XDP and non-XDP case.

Other than this

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 601c0e7fc32b..d2973c8fa48c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1028,13 +1028,12 @@ static struct sk_buff *receive_small(struct net_d=
evice *dev,
>                                      unsigned int *xdp_xmit,
>                                      struct virtnet_rq_stats *stats)
>  {
> -       struct sk_buff *skb;
> -       struct bpf_prog *xdp_prog;
>         unsigned int xdp_headroom =3D (unsigned long)ctx;
>         struct page *page =3D virt_to_head_page(buf);
>         unsigned int header_offset;
>         unsigned int headroom;
>         unsigned int buflen;
> +       struct sk_buff *skb;
>
>         len -=3D vi->hdr_len;
>         stats->bytes +=3D len;
> @@ -1046,22 +1045,21 @@ static struct sk_buff *receive_small(struct net_d=
evice *dev,
>                 goto err;
>         }
>
> -       if (likely(!vi->xdp_enabled)) {
> -               xdp_prog =3D NULL;
> -               goto skip_xdp;
> -       }
> +       if (unlikely(vi->xdp_enabled)) {
> +               struct bpf_prog *xdp_prog;
>
> -       rcu_read_lock();
> -       xdp_prog =3D rcu_dereference(rq->xdp_prog);
> -       if (xdp_prog) {
> -               skb =3D receive_small_xdp(dev, vi, rq, xdp_prog, buf, xdp=
_headroom,
> -                                       len, xdp_xmit, stats);
> +               rcu_read_lock();
> +               xdp_prog =3D rcu_dereference(rq->xdp_prog);
> +               if (xdp_prog) {
> +                       skb =3D receive_small_xdp(dev, vi, rq, xdp_prog, =
buf,
> +                                               xdp_headroom, len, xdp_xm=
it,
> +                                               stats);
> +                       rcu_read_unlock();
> +                       return skb;
> +               }
>                 rcu_read_unlock();
> -               return skb;
>         }
> -       rcu_read_unlock();
>
> -skip_xdp:
>         header_offset =3D VIRTNET_RX_PAD + xdp_headroom;
>         headroom =3D vi->hdr_len + header_offset;
>         buflen =3D SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> --
> 2.32.0.3.g01195cf9f
>

