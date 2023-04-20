Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312996E89F0
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 07:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjDTF7H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 01:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTF7G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 01:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA87840E8
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 22:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681970301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDV3yafaPrHE5WteGqoaeYdm3a/lYP8GCinXA0DuwSA=;
        b=BM0cKjpK4Z4bkrY+PEJfoU/E07nPDCBAp9QrLltuHQQRfiBQuhOwG+TcPe17+4JilQylBs
        pDSHjYBVBK8WEueEuwGMQSxHiicww3BAgA7lo3bY3XcDK5IWMAklC8p8hz7spP/NHnt/JI
        o9vzCQ75AW6cQK+2EnXeWhbhWh05Z8w=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-uUePboLmOumQzhpilxWeIA-1; Thu, 20 Apr 2023 01:58:20 -0400
X-MC-Unique: uUePboLmOumQzhpilxWeIA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-18799a4ca81so406347fac.3
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 22:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681970299; x=1684562299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDV3yafaPrHE5WteGqoaeYdm3a/lYP8GCinXA0DuwSA=;
        b=iDPrKWPloy99EtlOA3U8/fMMe4XifdwsIZ7F4jVPxNViuabwMxY/JMC2MmWzImL9/g
         G0gpfm5EfDxw6EbU3JLBiAGP9T/cgzlVOOHkHxf1WSRXAYuOgxwHmIp82FGW3wGH5f48
         oK1C3ZpGeFCEK05PBtKK9Ag959ycOf0LrfcvpfObtrqfZgzfMKd/5XHSv+YdU6wryQpx
         S5ncGK2yCBvfmcVnZ8pdWmMZ0qOTWkHAOax/hLqqt10UzeVVR+4Z7EX2S2DCy/97S+mB
         iQhCbz99UIlywjVKzuhebEkogYJ75vGzsQZCdv7LnKtFJVDIr5GHMCccRmCFh3oPi25q
         6zEQ==
X-Gm-Message-State: AAQBX9cPobL4tSd4vmTffLYGSlR91J1frX6H8rNz2VcCU7l6vBMMUzau
        bulV0zlAS7pYblbKBWfRJSKC9Dng4s9fD2mOOSut0rkfq4D03w9Oka1vaSwP0sk15ZCehtisyVq
        pHIU6ECPCJA9GbDab6dcO8QnG85e+
X-Received: by 2002:a05:6870:560e:b0:177:9993:ef49 with SMTP id m14-20020a056870560e00b001779993ef49mr505331oao.47.1681970299284;
        Wed, 19 Apr 2023 22:58:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZtThImGOfE95fE0KP5RosszYStuOo6lFXvQjEv2nKTu41bm7fHHVwxbyMTVC0STYuo4yyIpJvubzuq3mucPBQ=
X-Received: by 2002:a05:6870:560e:b0:177:9993:ef49 with SMTP id
 m14-20020a056870560e00b001779993ef49mr505324oao.47.1681970299086; Wed, 19 Apr
 2023 22:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com> <20230418065327.72281-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230418065327.72281-3-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 20 Apr 2023 13:58:07 +0800
Message-ID: <CACGkMEvBFfFUmUoYxKMiqLiOOZPNKV9gZp1bv0JzfpMwKT-EKw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/14] virtio_net: introduce mergeable_xdp_prepare()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 18, 2023 at 2:53=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Separating the logic of preparation for xdp from receive_mergeable.
>
> The purpose of this is to simplify the logic of execution of XDP.
>
> The main logic here is that when headroom is insufficient, we need to
> allocate a new page and calculate offset. It should be noted that if
> there is new page, the variable page will refer to the new page.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 135 +++++++++++++++++++++++----------------
>  1 file changed, 79 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 42435e762d72..12559062ffb6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1162,6 +1162,81 @@ static int virtnet_build_xdp_buff_mrg(struct net_d=
evice *dev,
>         return 0;
>  }
>
> +static void *mergeable_xdp_prepare(struct virtnet_info *vi,
> +                                  struct receive_queue *rq,
> +                                  struct bpf_prog *xdp_prog,
> +                                  void *ctx,
> +                                  unsigned int *frame_sz,
> +                                  int *num_buf,
> +                                  struct page **page,
> +                                  int offset,
> +                                  unsigned int *len,
> +                                  struct virtio_net_hdr_mrg_rxbuf *hdr)

Nit: I think we probably need a better name. (mergeable_xdp_get_buf()?)

Other than this:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> +{
> +       unsigned int truesize =3D mergeable_ctx_to_truesize(ctx);
> +       unsigned int headroom =3D mergeable_ctx_to_headroom(ctx);
> +       struct page *xdp_page;
> +       unsigned int xdp_room;
> +
> +       /* Transient failure which in theory could occur if
> +        * in-flight packets from before XDP was enabled reach
> +        * the receive path after XDP is loaded.
> +        */
> +       if (unlikely(hdr->hdr.gso_type))
> +               return NULL;
> +
> +       /* Now XDP core assumes frag size is PAGE_SIZE, but buffers
> +        * with headroom may add hole in truesize, which
> +        * make their length exceed PAGE_SIZE. So we disabled the
> +        * hole mechanism for xdp. See add_recvbuf_mergeable().
> +        */
> +       *frame_sz =3D truesize;
> +
> +       /* This happens when headroom is not enough because
> +        * of the buffer was prefilled before XDP is set.
> +        * This should only happen for the first several packets.
> +        * In fact, vq reset can be used here to help us clean up
> +        * the prefilled buffers, but many existing devices do not
> +        * support it, and we don't want to bother users who are
> +        * using xdp normally.
> +        */
> +       if (!xdp_prog->aux->xdp_has_frags &&
> +           (*num_buf > 1 || headroom < virtnet_get_headroom(vi))) {
> +               /* linearize data for XDP */
> +               xdp_page =3D xdp_linearize_page(rq, num_buf,
> +                                             *page, offset,
> +                                             VIRTIO_XDP_HEADROOM,
> +                                             len);
> +               *frame_sz =3D PAGE_SIZE;
> +
> +               if (!xdp_page)
> +                       return NULL;
> +               offset =3D VIRTIO_XDP_HEADROOM;
> +
> +               put_page(*page);
> +               *page =3D xdp_page;
> +       } else if (unlikely(headroom < virtnet_get_headroom(vi))) {
> +               xdp_room =3D SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
> +                                         sizeof(struct skb_shared_info))=
;
> +               if (*len + xdp_room > PAGE_SIZE)
> +                       return NULL;
> +
> +               xdp_page =3D alloc_page(GFP_ATOMIC);
> +               if (!xdp_page)
> +                       return NULL;
> +
> +               memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADROOM,
> +                      page_address(*page) + offset, *len);
> +               *frame_sz =3D PAGE_SIZE;
> +               offset =3D VIRTIO_XDP_HEADROOM;
> +
> +               put_page(*page);
> +               *page =3D xdp_page;
> +       }
> +
> +       return page_address(*page) + offset;
> +}
> +
>  static struct sk_buff *receive_mergeable(struct net_device *dev,
>                                          struct virtnet_info *vi,
>                                          struct receive_queue *rq,
> @@ -1181,7 +1256,7 @@ static struct sk_buff *receive_mergeable(struct net=
_device *dev,
>         unsigned int headroom =3D mergeable_ctx_to_headroom(ctx);
>         unsigned int tailroom =3D headroom ? sizeof(struct skb_shared_inf=
o) : 0;
>         unsigned int room =3D SKB_DATA_ALIGN(headroom + tailroom);
> -       unsigned int frame_sz, xdp_room;
> +       unsigned int frame_sz;
>         int err;
>
>         head_skb =3D NULL;
> @@ -1211,63 +1286,11 @@ static struct sk_buff *receive_mergeable(struct n=
et_device *dev,
>                 u32 act;
>                 int i;
>
> -               /* Transient failure which in theory could occur if
> -                * in-flight packets from before XDP was enabled reach
> -                * the receive path after XDP is loaded.
> -                */
> -               if (unlikely(hdr->hdr.gso_type))
> +               data =3D mergeable_xdp_prepare(vi, rq, xdp_prog, ctx, &fr=
ame_sz,
> +                                            &num_buf, &page, offset, &le=
n, hdr);
> +               if (unlikely(!data))
>                         goto err_xdp;
>
> -               /* Now XDP core assumes frag size is PAGE_SIZE, but buffe=
rs
> -                * with headroom may add hole in truesize, which
> -                * make their length exceed PAGE_SIZE. So we disabled the
> -                * hole mechanism for xdp. See add_recvbuf_mergeable().
> -                */
> -               frame_sz =3D truesize;
> -
> -               /* This happens when headroom is not enough because
> -                * of the buffer was prefilled before XDP is set.
> -                * This should only happen for the first several packets.
> -                * In fact, vq reset can be used here to help us clean up
> -                * the prefilled buffers, but many existing devices do no=
t
> -                * support it, and we don't want to bother users who are
> -                * using xdp normally.
> -                */
> -               if (!xdp_prog->aux->xdp_has_frags &&
> -                   (num_buf > 1 || headroom < virtnet_get_headroom(vi)))=
 {
> -                       /* linearize data for XDP */
> -                       xdp_page =3D xdp_linearize_page(rq, &num_buf,
> -                                                     page, offset,
> -                                                     VIRTIO_XDP_HEADROOM=
,
> -                                                     &len);
> -                       frame_sz =3D PAGE_SIZE;
> -
> -                       if (!xdp_page)
> -                               goto err_xdp;
> -                       offset =3D VIRTIO_XDP_HEADROOM;
> -
> -                       put_page(page);
> -                       page =3D xdp_page;
> -               } else if (unlikely(headroom < virtnet_get_headroom(vi)))=
 {
> -                       xdp_room =3D SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
> -                                                 sizeof(struct skb_share=
d_info));
> -                       if (len + xdp_room > PAGE_SIZE)
> -                               goto err_xdp;
> -
> -                       xdp_page =3D alloc_page(GFP_ATOMIC);
> -                       if (!xdp_page)
> -                               goto err_xdp;
> -
> -                       memcpy(page_address(xdp_page) + VIRTIO_XDP_HEADRO=
OM,
> -                              page_address(page) + offset, len);
> -                       frame_sz =3D PAGE_SIZE;
> -                       offset =3D VIRTIO_XDP_HEADROOM;
> -
> -                       put_page(page);
> -                       page =3D xdp_page;
> -               }
> -
> -               data =3D page_address(page) + offset;
>                 err =3D virtnet_build_xdp_buff_mrg(dev, vi, rq, &xdp, dat=
a, len, frame_sz,
>                                                  &num_buf, &xdp_frags_tru=
esz, stats);
>                 if (unlikely(err))
> --
> 2.32.0.3.g01195cf9f
>

