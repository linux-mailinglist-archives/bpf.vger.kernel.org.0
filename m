Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C54B473B53
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 04:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhLNDNV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 22:13:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53836 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235407AbhLNDNV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 22:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639451600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99hHa+R8DxpGc57uFm6oCLjvQUYhFLts8EwSb1a/bxk=;
        b=i98HusjQARCC5iXS0/CA/19lKvRRlbvvSg347gmDb2uCXUc/A0uhcpX+JdTnelivBLesyp
        hDg5Gt2bB82trC0SFMjL2RC1E37MD0Gotq0i9BBQ7oc7RO4FxkU/oIvAyFmjT4DT9K7zMb
        hwVA+Hfo9ahXCuiUkNi2aS3MD/eroZY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-dJvq8BNTOpSxGS7rUWAH0Q-1; Mon, 13 Dec 2021 22:13:19 -0500
X-MC-Unique: dJvq8BNTOpSxGS7rUWAH0Q-1
Received: by mail-lf1-f72.google.com with SMTP id m1-20020ac24281000000b004162863a2fcso8351199lfh.14
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 19:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=99hHa+R8DxpGc57uFm6oCLjvQUYhFLts8EwSb1a/bxk=;
        b=zgXBBL4RH5JaaK1OdzfiKAMUaj/DV+yjAHEoLFhIJUdRJtw80kfl8ujbN9HykWFr26
         9myTdtDu2YmNpR9hGph2RzZs1uS4pri2p2lsNp58V+1feZ4C10IA77uwQGaqd8wkX4+e
         P9+uhSvYh+6d/vSUXSg6wcE8ic2IazqJ82rbde7Xn6+Us1DZGiItDYqPe5fyWSCAwu7S
         Db19VGKrzuwFw5V99moDoNz8ce2M8H8znhBBhryP0JTsgV15pXfft/grj5aCuEl19RF7
         YQ4gZyMGlUr+zNY7bloDV6gBpZ4nB3o3an3/WtaRVFbk+tFUqJh0N22KqIG7+xvweLUM
         6GDw==
X-Gm-Message-State: AOAM531X4KfvfcnA9dkgcbSSBjxMIPXauL+R0aYX0hGxE79iBdT6fwux
        ySPzkhIoJI1QSCfk3TNMT7rMSDkEuIxqd0GM6liksjzfVApbt/x6oAo05ALB/kY9zrDXOK1V96u
        qygvtMmuNmDzG3meGzJxtPpmzCXZo
X-Received: by 2002:ac2:518b:: with SMTP id u11mr2321121lfi.498.1639451597761;
        Mon, 13 Dec 2021 19:13:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZ1HCIVLCKmLXdf3Yl2yAjouNx1OCPxPcR7jWZs3VxYTOSPUyURuqCGeB00yGBqOXmIWH1kqW4dvobsBNeN9Y=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr2321107lfi.498.1639451597577;
 Mon, 13 Dec 2021 19:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20211213045012.12757-1-mengensun@tencent.com> <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
In-Reply-To: <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 14 Dec 2021 11:13:06 +0800
Message-ID: <CACGkMEukGbDcxJe3nGFkeBNenniJdMkFMRnrN4OOfDsCb7ZPuA@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: make copy len check in xdp_linearize_page
To:     mengensun8801@gmail.com
Cc:     davem <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        mengensun <mengensun@tencent.com>,
        MengLong Dong <imagedong@tencent.com>,
        ZhengXiong Jiang <mungerjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 13, 2021 at 5:14 PM =E5=AD=99=E8=92=99=E6=81=A9 <mengensun8801@=
gmail.com> wrote:
>
> Jason Wang <jasowang@redhat.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=B8=80 15:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Mon, Dec 13, 2021 at 12:50 PM <mengensun8801@gmail.com> wrote:
> > >
> > > From: mengensun <mengensun@tencent.com>
> > >
> > > xdp_linearize_page asume ring elem size is smaller then page size
> > > when copy the first ring elem, but, there may be a elem size bigger
> > > then page size.
> > >
> > > add_recvbuf_mergeable may add a hole to ring elem, the hole size is
> > > not sure, according EWMA.
> >
> > The logic is to try to avoid dropping packets in this case, so I
> > wonder if it's better to "fix" the add_recvbuf_mergeable().
>

Adding lists back.

> turn to XDP generic is so difficulty for me, here can "fix" the
> add_recvbuf_mergeable link follow:
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 36a4b7c195d5..06ce8bb10b47 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1315,6 +1315,7 @@ static int add_recvbuf_mergeable(struct virtnet_inf=
o *vi,
>                 alloc_frag->offset +=3D hole;
>         }
> +       len =3D min(len, PAGE_SIZE - room);
>         sg_init_one(rq->sg, buf, len);
>         ctx =3D mergeable_len_to_ctx(len, headroom);

Then the truesize here is wrong.

>         err =3D virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp)=
;
>
> it seems a rule that, length of elem giving to vring is away smaller
> or equall then PAGE_SIZE

It aims to be consistent to what EWMA tries to do:

        len =3D hdr_len + clamp_t(unsigned int, ewma_pkt_len_read(avg_pkt_l=
en),
                        rq->min_buf_len, PAGE_SIZE - hdr_len);

Thanks

>
> >
> > Or another idea is to switch to use XDP generic here where we can use
> > skb_linearize() which should be more robust and we can drop the
> > xdp_linearize_page() logic completely.
> >
> > Thanks
> >
> > >
> > > so, fix it by check copy len,if checked failed, just dropped the
> > > whole frame, not make the memory dirty after the page.
> > >
> > > Signed-off-by: mengensun <mengensun@tencent.com>
> > > Reviewed-by: MengLong Dong <imagedong@tencent.com>
> > > Reviewed-by: ZhengXiong Jiang <mungerjiang@tencent.com>
> > > ---
> > >  drivers/net/virtio_net.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 36a4b7c195d5..844bdbd67ff7 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -662,8 +662,12 @@ static struct page *xdp_linearize_page(struct re=
ceive_queue *rq,
> > >                                        int page_off,
> > >                                        unsigned int *len)
> > >  {
> > > -       struct page *page =3D alloc_page(GFP_ATOMIC);
> > > +       struct page *page;
> > >
> > > +       if (*len > PAGE_SIZE - page_off)
> > > +               return NULL;
> > > +
> > > +       page =3D alloc_page(GFP_ATOMIC);
> > >         if (!page)
> > >                 return NULL;
> > >
> > > --
> > > 2.27.0
> > >
> >
>

