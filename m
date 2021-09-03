Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256F44003F8
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 19:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350139AbhICROc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 13:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349049AbhICROc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 3 Sep 2021 13:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630689211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHJyQTuhQ2rUo4HEpkrQXS+C/jFPNpqCCL4OYhPvFJs=;
        b=P+MrMyKce4Q+zsN6ckx3kh8yefQPpAD2LkLgVJd1yMRenRyqwyO8MmNTOc6nlpp4nPikqh
        JPSDa0XDUhg2FyTkLEh5Lp89n9qX7StvVVwpcxtEJeUp3VLkLfsOEWjCcpW7peEwz/9vpA
        LJzcvCSc+6g3qJDyH8UcRYgfolNPcJE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-brwS3-l1M82oja81deqMcA-1; Fri, 03 Sep 2021 13:13:30 -0400
X-MC-Unique: brwS3-l1M82oja81deqMcA-1
Received: by mail-yb1-f199.google.com with SMTP id h143-20020a25d095000000b0059c2e43cd3eso7145607ybg.12
        for <bpf@vger.kernel.org>; Fri, 03 Sep 2021 10:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHJyQTuhQ2rUo4HEpkrQXS+C/jFPNpqCCL4OYhPvFJs=;
        b=lbo7DJ1c2rwYixXYzvO3cpqkQvZNTeiDnEKhKbSHoiZbAWz6Mc+Dnad9y5H7rBnkCh
         4q/ZgbCOpUQ0J5pMVvxJ52O158N3Ji0I6vJEf9LT8QzNbHyXbdSKVepyTZiwDz6/epQ+
         B3Wo2YmCzCBqA8QcXGKpV3wNTV9OnKYxM3s4TQ9nnv+xRMsW3UuMQCySgn/6lKtiZvJH
         wNvk3oYXxDley2coaBvNYpSkdSDydwlBPrHxKo4UE8xYxWtmDuGd++cUFqBbAr9eFT8U
         3U5+gxHYtADfEFgS404pVui6yCFKhGPuHOrgLmuGRCmE9f78qDrL5oQvlycnEMe7jlTi
         zi1w==
X-Gm-Message-State: AOAM5327UalpdR+MlJUCpATaC3lHwP/GtG0h7bpD2VaPxNlM3os6Jpck
        1NHmCZykzoIia7wvZoXL4zrjNCoYuSo29GjqP+2PaahVVjbcAzE54wrRKIscYw+JXB9tUawMrcc
        22fY/QmjRk8bN1/O26Z0BZtcoXHP4
X-Received: by 2002:a25:c005:: with SMTP id c5mr158245ybf.168.1630689210020;
        Fri, 03 Sep 2021 10:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn64tX3wVU8FQE/8IxOa46/3bOs07liCcjapLECaEcqfxtXRfkxmGyJeh0V2xmOGq4e8Mife4ldeUUuZVuHq4=
X-Received: by 2002:a25:c005:: with SMTP id c5mr158209ybf.168.1630689209747;
 Fri, 03 Sep 2021 10:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629473233.git.lorenzo@kernel.org> <ab0c64f1543239256ef63ec9b40f35a7491812c6.1629473233.git.lorenzo@kernel.org>
 <612eb79343225_6b872087a@john-XPS-13-9370.notmuch>
In-Reply-To: <612eb79343225_6b872087a@john-XPS-13-9370.notmuch>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Fri, 3 Sep 2021 19:13:18 +0200
Message-ID: <CAJ0CqmWGNapcmVae52UJNAg7XKS7f0F2dmQMoO+1sL3zp=oFTw@mail.gmail.com>
Subject: Re: [PATCH v12 bpf-next 01/18] net: skbuff: add size metadata to
 skb_shared_info for xdp
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Agroskin, Shay" <shayagr@amazon.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>,
        Toke Hoiland Jorgensen <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
> Lorenzo Bianconi wrote:
> > Introduce xdp_frags_tsize field in skb_shared_info data structure
> > to store xdp_buff/xdp_frame truesize (xdp_frags_tsize will be used
> > in xdp multi-buff support). In order to not increase skb_shared_info
> > size we will use a hole due to skb_shared_info alignment.
> > Introduce xdp_frags_size field in skb_shared_info data structure
> > reusing gso_type field in order to store xdp_buff/xdp_frame paged size.
> > xdp_frags_size will be used in xdp multi-buff support.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> I assume we can use xdp_frags_tsize for anything else above XDP later?
> Other than simple question looks OK to me.

yes, right as we did for gso_type/xdp_frags_size.

Regards,
Lorenzo

>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
>
> > ---
> >  include/linux/skbuff.h | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 6bdb0db3e825..1abeba7ef82e 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -522,13 +522,17 @@ struct skb_shared_info {
> >       unsigned short  gso_segs;
> >       struct sk_buff  *frag_list;
> >       struct skb_shared_hwtstamps hwtstamps;
> > -     unsigned int    gso_type;
> > +     union {
> > +             unsigned int    gso_type;
> > +             unsigned int    xdp_frags_size;
> > +     };
> >       u32             tskey;
> >
> >       /*
> >        * Warning : all fields before dataref are cleared in __alloc_skb()
> >        */
> >       atomic_t        dataref;
> > +     unsigned int    xdp_frags_tsize;
> >
> >       /* Intermediate layers must ensure that destructor_arg
> >        * remains valid until skb destructor */
> > --
> > 2.31.1
> >
>
>

