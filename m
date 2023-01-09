Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448656620E7
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 10:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbjAIJFQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 04:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236758AbjAIJEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 04:04:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E315FE1
        for <bpf@vger.kernel.org>; Mon,  9 Jan 2023 00:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673254615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hsuF/hrJH5PRFQt/Oi/KlNkJwLFWZO04nt6xbiKMi14=;
        b=ESG7F64OygFT9gxauA9bn/ymn622t7P8VSY1xtLbcAq4EL1RFyExaTKFq2d0cqcxw+f9Lh
        CQG+GrJz3BbnnIlFg4nsV9psk+FZWLckaRjrgHnd5Oe2XEMMm2C2Vo//SjmgHkhkedDU31
        Cr5Kz1iT62a5qSlv6vI6VphHCdF3PZQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-Fs-2IKhmNyKyM6ydb-Iu3Q-1; Mon, 09 Jan 2023 03:56:49 -0500
X-MC-Unique: Fs-2IKhmNyKyM6ydb-Iu3Q-1
Received: by mail-ot1-f71.google.com with SMTP id bx22-20020a056830601600b00684958cb0b9so42961otb.1
        for <bpf@vger.kernel.org>; Mon, 09 Jan 2023 00:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsuF/hrJH5PRFQt/Oi/KlNkJwLFWZO04nt6xbiKMi14=;
        b=6IfNV2CsSwQJulQ+IIJyX/dl4osGvBSqtFsxO9KeO/9YnSTPQYh6TKkZRiwvjcLCij
         GWWY26dCHdhLQoigLnouO23NYjuSYIEm2fnfCmv9pBhf+rNuIy+DscorhC6M2U23bfNo
         naRfOCJYNQHkbgI05GPYrjGrOZEwR7v4CSdOSlT6QUMt7ip0Vjtz7P0rmVG3UChl3BT0
         e0UlrBduha+cnyLWzkKOUkvJwizCjuM7OvcBIMl0q1VLMBx1g2eyV9HvN0Kz2jaxVBiu
         v5ouTwMTEILfIvqrjwMzCi/iG5eb1xxIzQ4rwybV7QZ/RyUTH8kL/KKxMCXjeY6LSFyk
         a/3Q==
X-Gm-Message-State: AFqh2kpuWkdNwOd2ETtXdIQWMcLYCqWxUr9GEQxB7bPAjAQbS4d4g+3f
        WauGhshv07E1p+SAKCuigP2MEQdII6Mftd6zknnCzJdJyOZR0qYgue4YuTijkAWqDdZASjddV6L
        dHXh014CufUWikKLLS2iKH+JOyD9L
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id c9-20020a544e89000000b0035c303dfe37mr2719687oiy.35.1673254608715;
        Mon, 09 Jan 2023 00:56:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvbHT4MrqFm9F33/AyLDVtlaiEWYFvCG4dE2fg5riyp/5GEmnQH1wPX2PuqW4SyjlD7y7PCY2iwH9wfkZ3t4YI=
X-Received: by 2002:a54:4e89:0:b0:35c:303d:fe37 with SMTP id
 c9-20020a544e89000000b0035c303dfe37mr2719685oiy.35.1673254608466; Mon, 09 Jan
 2023 00:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20230103064012.108029-1-hengqi@linux.alibaba.com>
 <20230103064012.108029-3-hengqi@linux.alibaba.com> <8ae89098-594f-b28b-4040-b0625b816e14@linux.alibaba.com>
In-Reply-To: <8ae89098-594f-b28b-4040-b0625b816e14@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 9 Jan 2023 16:56:37 +0800
Message-ID: <CACGkMEsBe=_uNFB_6K_obqcnnaJi6ME22-j7cgXwSCTV85BKQw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] virtio-net: set up xdp for multi buffer packets
To:     Heng Qi <hengqi@linux.alibaba.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 9, 2023 at 10:48 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>
>
>
> =E5=9C=A8 2023/1/3 =E4=B8=8B=E5=8D=882:40, Heng Qi =E5=86=99=E9=81=93:
> > When the xdp program sets xdp.frags, which means it can process
> > multi-buffer packets over larger MTU, so we continue to support xdp.
> > But for single-buffer xdp, we should keep checking for MTU.
> >
> > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   drivers/net/virtio_net.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 443aa7b8f0ad..60e199811212 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3074,7 +3074,9 @@ static int virtnet_restore_guest_offloads(struct =
virtnet_info *vi)
> >   static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *p=
rog,
> >                          struct netlink_ext_ack *extack)
> >   {
> > -     unsigned long int max_sz =3D PAGE_SIZE - sizeof(struct padded_vne=
t_hdr);
> > +     unsigned int room =3D SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
> > +                                        sizeof(struct skb_shared_info)=
);
> > +     unsigned int max_sz =3D PAGE_SIZE - room - ETH_HLEN;
>
> Hi Jason, I've updated the calculation of 'max_sz' in this patch instead
> of a separate bugfix, since doing so also seemed clear.

Sure, I will review it with this series no later than the end of this week.

Thanks

>
> Thanks.
>
> >       struct virtnet_info *vi =3D netdev_priv(dev);
> >       struct bpf_prog *old_prog;
> >       u16 xdp_qp =3D 0, curr_qp;
> > @@ -3095,9 +3097,9 @@ static int virtnet_xdp_set(struct net_device *dev=
, struct bpf_prog *prog,
> >               return -EINVAL;
> >       }
> >
> > -     if (dev->mtu > max_sz) {
> > -             NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable XDP")=
;
> > -             netdev_warn(dev, "XDP requires MTU less than %lu\n", max_=
sz);
> > +     if (prog && !prog->aux->xdp_has_frags && dev->mtu > max_sz) {
> > +             NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable XDP w=
ithout frags");
> > +             netdev_warn(dev, "single-buffer XDP requires MTU less tha=
n %u\n", max_sz);
> >               return -EINVAL;
> >       }
> >
>

