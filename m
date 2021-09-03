Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33351400416
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 19:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhICR2N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 13:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47418 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232937AbhICR2N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 3 Sep 2021 13:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630690033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vypUNeu4j8vtRPkeg58KYPnt2rPCVH7ThBxevYKDRbg=;
        b=GWiLBFwnxVAq502Un9v4ejxx/iIQZgwA8nRWMkPN95xKcRezoHnmNcZWuvl5VO7/1Aa0iN
        J/J+6OqNNUWpfl5B5j5jyfG0qzL1NqVQ4fnxuvPpBr7zJP2im/ld8rogPSYUDSg1bTWMhK
        sNnOvzPRLqt2NK4kkgXppASWrsUhYIQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-qbMOTRnoNKGi2QUfs_Jsvw-1; Fri, 03 Sep 2021 13:27:12 -0400
X-MC-Unique: qbMOTRnoNKGi2QUfs_Jsvw-1
Received: by mail-yb1-f199.google.com with SMTP id f8-20020a2585480000b02905937897e3daso7217179ybn.2
        for <bpf@vger.kernel.org>; Fri, 03 Sep 2021 10:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vypUNeu4j8vtRPkeg58KYPnt2rPCVH7ThBxevYKDRbg=;
        b=k5bAe7+u7FK6hsr0vCINme5WnbR09/eciLutEF9iURbcANuVOkuwGmuUCy53ZbXvD0
         2j0+rtkRBwVFHfh1G/1Wiuk0KnOnGL10U1bEyAQNqzyVRCOdxVW0g2RBTEg9ve/djFBp
         3L+i+JB0yrxBq+MnGAwQZHwQno1Lu3JnfvU/4EZ46vZ7DApauzv5bDi0bUCxGjsN+7/0
         2dyBemW7rOklUhX1fDTQjL3KoF1SrOATHcDcljZ0ES9ksLlq8wf9CWpNcCtgjZKXNkCU
         YXUf4G7oQXzHH7ygjsGFfZ7UkyU7aZzsZ9ni5dIyDj3OG9IgmIKCza/bkZGW/BahSnE0
         b9aA==
X-Gm-Message-State: AOAM532QxbUYlwVbT0A/pAweA2doetKIdlQGqcxEPk98OYuKwV0kSgAU
        WafLsh2ym+IcJ3VSHRQcQ8aa8LLMBIOePjfItuP6uq+v9nsFnD4EP9X4cX4qopBwAQE0Facn1qX
        hzqKosTL7OEW9ocOfFi/P1IqRAW37
X-Received: by 2002:a25:824e:: with SMTP id d14mr176427ybn.179.1630690031474;
        Fri, 03 Sep 2021 10:27:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2p2cdv8mEYoPe6nCStjJ4fbKvrZKTSaom9r22ZjfiwIrAaPVkgTsG/G/DQhTZ3tQ0LzQswc8mEePYjJx8eiQ=
X-Received: by 2002:a25:824e:: with SMTP id d14mr176392ybn.179.1630690031232;
 Fri, 03 Sep 2021 10:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629473233.git.lorenzo@kernel.org> <4f0438cf2a94e539e56b6a291978e08fd2e9c60b.1629473233.git.lorenzo@kernel.org>
 <612ebe4548da_6b87208fa@john-XPS-13-9370.notmuch>
In-Reply-To: <612ebe4548da_6b87208fa@john-XPS-13-9370.notmuch>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Fri, 3 Sep 2021 19:27:00 +0200
Message-ID: <CAJ0CqmX3JtmZk9fKr9tH-SF4=1G8FxuoBLdFQ=3JQ1mOZAuiOg@mail.gmail.com>
Subject: Re: [PATCH v12 bpf-next 06/18] net: marvell: rely on
 xdp_update_skb_shared_info utility routine
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
> > Rely on xdp_update_skb_shared_info routine in order to avoid
> > resetting frags array in skb_shared_info structure building
> > the skb in mvneta_swbm_build_skb(). Frags array is expected to
> > be initialized by the receiving driver building the xdp_buff
> > and here we just need to update memory metadata.
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
>
> >  drivers/net/ethernet/marvell/mvneta.c | 35 +++++++++++++++------------
> >  1 file changed, 20 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index cbf614d6b993..b996eb49d813 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -2304,11 +2304,19 @@ mvneta_swbm_add_rx_fragment(struct mvneta_port *pp,
> >               skb_frag_size_set(frag, data_len);
> >               __skb_frag_set_page(frag, page);
> >
> > -             if (!xdp_buff_is_mb(xdp))
> > +             if (!xdp_buff_is_mb(xdp)) {
> > +                     sinfo->xdp_frags_size = *size;
> >                       xdp_buff_set_mb(xdp);
> > +             }
> > +             if (page_is_pfmemalloc(page))
> > +                     xdp_buff_set_frag_pfmemalloc(xdp);
> >       } else {
> >               page_pool_put_full_page(rxq->page_pool, page, true);
> >       }
> > +
> > +     /* last fragment */
> > +     if (len == *size)
> > +             sinfo->xdp_frags_tsize = sinfo->nr_frags * PAGE_SIZE;
> >       *size -= len;
> >  }
> >
> > @@ -2316,13 +2324,18 @@ static struct sk_buff *
> >  mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
> >                     struct xdp_buff *xdp, u32 desc_status)
> >  {
> > -     struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> > +     unsigned int size, truesize;
> >       struct sk_buff *skb;
> >       u8 num_frags;
> > -     int i;
> >
> > -     if (unlikely(xdp_buff_is_mb(xdp)))
> > +     if (unlikely(xdp_buff_is_mb(xdp))) {
>
> Just curious does the mvneta hardware support header split? If we
> get to that point then we can drop the unlikely.

nope, it does not :(

Regards,
Lorenzo

>
> > +             struct skb_shared_info *sinfo;
> > +
> > +             sinfo = xdp_get_shared_info_from_buff(xdp);
> > +             truesize = sinfo->xdp_frags_tsize;
> > +             size = sinfo->xdp_frags_size;
> >               num_frags = sinfo->nr_frags;
> > +     }
> >
> >       skb = build_skb(xdp->data_hard_start, PAGE_SIZE);
> >       if (!skb)
> > @@ -2334,18 +2347,10 @@ mvneta_swbm_build_skb(struct mvneta_port *pp, struct page_pool *pool,
> >       skb_put(skb, xdp->data_end - xdp->data);
> >       skb->ip_summed = mvneta_rx_csum(pp, desc_status);
> >
> > -     if (likely(!xdp_buff_is_mb(xdp)))
> > -             goto out;
> > -
> > -     for (i = 0; i < num_frags; i++) {
> > -             skb_frag_t *frag = &sinfo->frags[i];
> > -
> > -             skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> > -                             skb_frag_page(frag), skb_frag_off(frag),
> > -                             skb_frag_size(frag), PAGE_SIZE);
> > -     }
> > +     if (unlikely(xdp_buff_is_mb(xdp)))
> > +             xdp_update_skb_shared_info(skb, num_frags, size, truesize,
> > +                                        xdp_buff_is_frag_pfmemalloc(xdp));
> >
> > -out:
> >       return skb;
> >  }
> >
> > --
> > 2.31.1
> >
>
>

