Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290BE6C5F12
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 06:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCWFjf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 01:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCWFje (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 01:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F15522020
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679549926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jri6+NrCPtekgZqOyxyD0WomJ0of3wHnx2G0FZIYbvw=;
        b=LS3FMEy35gIDHyO+O2fffOejaKkYQEsDeXetme+W5JIKmGzASMy2T76/5MIF6RS/I4CD0P
        bo9oLfLm5JVkdg20PDFdXYt/F89vh+jCay2dJFnfdb0VDjoZCqJ04H5e8v/qRLPc10KGcv
        Xam8SGq691rWdCDGPPMR6TofvyTdRXA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-i64yjtm-PSqKi3MpM8T5SA-1; Thu, 23 Mar 2023 01:38:43 -0400
X-MC-Unique: i64yjtm-PSqKi3MpM8T5SA-1
Received: by mail-ot1-f71.google.com with SMTP id e2-20020a9d5602000000b00694299f6ea9so9577671oti.19
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 22:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679549922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jri6+NrCPtekgZqOyxyD0WomJ0of3wHnx2G0FZIYbvw=;
        b=QEwAIQBxxCRHAN4BvzlNtEl9A+okmOolSe9UVNYqyC0eMJ04nBALSe6w4pWCnFVwiU
         GRi6FjIEY89oun4tJv4+Ve4FJ/S3n7X9rgRFGpzEgc9gMBnoMX9y33Gl12XivOKAF8Bo
         B546Vnai7gX+5tkIBKmQWY3gIRC4ZY4UvdqxF88UsE/kgGyzwxifFcUwxiEMQ2BIxb0n
         zgGldorEVe0Wdw27rhXVAvtoJLODjFWFHePjLBI1YTGzGWmVW0TJU0xlHWMI980kmtzO
         SyhkYpyIa4+YyKMjmwsvhsX4bL6oHfYXtET1izpzl7H6DB+QCFPcAIa6ho1BxvgOy9ts
         VtxQ==
X-Gm-Message-State: AO0yUKUO3Xkmh6nsufB4/jw3wdhWG1dj5TJ2DVDo/NiDNPWYHVTeQKx+
        yoBjYYLocrpOxyCLAGmhyHtWmza3yuRM7JqtCW/e6ORqKvnSfOY93OHZtjTbHdhQ0qsOvIhHADz
        5MGSjhr/zJk+Wod2s9SX+YUMcxxbV
X-Received: by 2002:a54:4189:0:b0:384:c4a:1b49 with SMTP id 9-20020a544189000000b003840c4a1b49mr1724138oiy.9.1679549922159;
        Wed, 22 Mar 2023 22:38:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set9edpIRb55hBUWyafl2NYnWiJJoCRnUZ/SSVGI/aYqPK/FO76woi7mOTZOqxI9TFyPNpDP1uoPL8mvJSXFe5hc=
X-Received: by 2002:a54:4189:0:b0:384:c4a:1b49 with SMTP id
 9-20020a544189000000b003840c4a1b49mr1724117oiy.9.1679549921765; Wed, 22 Mar
 2023 22:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230322030308.16046-2-xuanzhuo@linux.alibaba.com> <4bd07874-b1ad-336b-b15e-ba56a10182e9@huawei.com>
 <1679535365.5410192-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1679535365.5410192-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 23 Mar 2023 13:38:30 +0800
Message-ID: <CACGkMEvS7N1tXFD2-2n2upY15JF6=0uaAebewsP8=K+Cwbtgsg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] virtio_net: mergeable xdp: put old page immediately
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        virtualization@lists.linux-foundation.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org
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

On Thu, Mar 23, 2023 at 9:43=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 22 Mar 2023 16:22:18 +0800, Yunsheng Lin <linyunsheng@huawei.com>=
 wrote:
> > On 2023/3/22 11:03, Xuan Zhuo wrote:
> > > In the xdp implementation of virtio-net mergeable, it always checks
> > > whether two page is used and a page is selected to release. This is
> > > complicated for the processing of action, and be careful.
> > >
> > > In the entire process, we have such principles:
> > > * If xdp_page is used (PASS, TX, Redirect), then we release the old
> > >   page.
> > > * If it is a drop case, we will release two. The old page obtained fr=
om
> > >   buf is release inside err_xdp, and xdp_page needs be relased by us.
> > >
> > > But in fact, when we allocate a new page, we can release the old page
> > > immediately. Then just one is using, we just need to release the new
> > > page for drop case. On the drop path, err_xdp will release the variab=
le
> > > "page", so we only need to let "page" point to the new xdp_page in
> > > advance.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio_net.c | 15 ++++++---------
> > >  1 file changed, 6 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index e2560b6f7980..4d2bf1ce0730 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -1245,6 +1245,9 @@ static struct sk_buff *receive_mergeable(struct=
 net_device *dev,
> > >                     if (!xdp_page)
> > >                             goto err_xdp;
> > >                     offset =3D VIRTIO_XDP_HEADROOM;
> > > +
> > > +                   put_page(page);
> >
> > the error handling of xdp_linearize_page() does not seems self containe=
d.
> > Does it not seem better=EF=BC=9A
> > 1. if xdp_linearize_page() succesed, call put_page() for first buffer j=
ust
> >    as put_page() is call for other buffer
> > 2. or call virtqueue_get_buf() and put_page() for all the buffer of the=
 packet
> >    so the error handling is not needed outside the virtqueue_get_buf().
> >
> > In that case, it seems we can just do below without xdp_page:
> > page =3D xdp_linearize_page(rq, num_buf, page, ...);
>
>
> This does look better.
>
> In fact, we already have vq reset, we can load XDP based on vq reset.
> In this way, we can run without xdp_linearize_page.

The goal is to try our best not to drop packets, so I think it's
better to keep it.

Thanks

>
>
> >
> >
> > > +                   page =3D xdp_page;
> > >             } else if (unlikely(headroom < virtnet_get_headroom(vi)))=
 {
> > >                     xdp_room =3D SKB_DATA_ALIGN(VIRTIO_XDP_HEADROOM +
> > >                                               sizeof(struct skb_share=
d_info));
> > > @@ -1259,6 +1262,9 @@ static struct sk_buff *receive_mergeable(struct=
 net_device *dev,
> > >                            page_address(page) + offset, len);
> > >                     frame_sz =3D PAGE_SIZE;
> > >                     offset =3D VIRTIO_XDP_HEADROOM;
> > > +
> > > +                   put_page(page);
> > > +                   page =3D xdp_page;
> >
> > It seems we can limit the scope of xdp_page in this "else if" block.
> >
> > >             } else {
> > >                     xdp_page =3D page;
> > >             }
> >
> > It seems the above else block is not needed anymore.
>
> Yes, the follow-up patch has this optimization.
>
>
> >
> > > @@ -1278,8 +1284,6 @@ static struct sk_buff *receive_mergeable(struct=
 net_device *dev,
> > >                     if (unlikely(!head_skb))
> > >                             goto err_xdp_frags;
> > >
> > > -                   if (unlikely(xdp_page !=3D page))
> > > -                           put_page(page);
> > >                     rcu_read_unlock();
> > >                     return head_skb;
> > >             case XDP_TX:
> > > @@ -1297,8 +1301,6 @@ static struct sk_buff *receive_mergeable(struct=
 net_device *dev,
> > >                             goto err_xdp_frags;
> > >                     }
> > >                     *xdp_xmit |=3D VIRTIO_XDP_TX;
> > > -                   if (unlikely(xdp_page !=3D page))
> > > -                           put_page(page);
> > >                     rcu_read_unlock();
> > >                     goto xdp_xmit;
> > >             case XDP_REDIRECT:
> > > @@ -1307,8 +1309,6 @@ static struct sk_buff *receive_mergeable(struct=
 net_device *dev,
> > >                     if (err)
> > >                             goto err_xdp_frags;
> > >                     *xdp_xmit |=3D VIRTIO_XDP_REDIR;
> > > -                   if (unlikely(xdp_page !=3D page))
> > > -                           put_page(page);
> > >                     rcu_read_unlock();
> > >                     goto xdp_xmit;
> > >             default:
> > > @@ -1321,9 +1321,6 @@ static struct sk_buff *receive_mergeable(struct=
 net_device *dev,
> > >                     goto err_xdp_frags;
> > >             }
> > >  err_xdp_frags:
> > > -           if (unlikely(xdp_page !=3D page))
> > > -                   __free_pages(xdp_page, 0);
> >
> > It seems __free_pages() and put_page() is used interchangeably here.
> > Perhaps using __free_pages() have performance reason? As the comment be=
low:
> >
> > https://elixir.bootlin.com/linux/v6.3-rc3/source/net/core/page_pool.c#L=
500
>
>
> Yes, but now we don't seem to be very good to distinguish it. But I think
> it doesn't matter. This logic is rare under actual situation.
>
> Thanks.
>
>
> >
> > > -
> > >             if (xdp_buff_has_frags(&xdp)) {
> > >                     shinfo =3D xdp_get_shared_info_from_buff(&xdp);
> > >                     for (i =3D 0; i < shinfo->nr_frags; i++) {
> > >
>

