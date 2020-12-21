Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4BA2DFABA
	for <lists+bpf@lfdr.de>; Mon, 21 Dec 2020 11:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLUKFr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Dec 2020 05:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgLUKFq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Dec 2020 05:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608545059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nna0WyFAUg/twizuTevbFjazTbDOQamogbH2vekU5NI=;
        b=VZ3lT/jvz0GBsAYSrkz3zMS7giKhQXgZi/CM6Gjzyf4oa+xF59FDGyhUUCq/iJFCyOjbZM
        4W5Dg8P/nQbhzV0qiW17bJUUv8+pABQDeovjMwOHx0CLJTSKIMu0P3CkyyCSmwoBZp9MDy
        ZrtBq+AswO/BZdGP5GnnlNWxujUV2RE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-8XStAuamPiCpO_xPpkQsBQ-1; Mon, 21 Dec 2020 03:58:05 -0500
X-MC-Unique: 8XStAuamPiCpO_xPpkQsBQ-1
Received: by mail-yb1-f199.google.com with SMTP id g67so13214563ybb.9
        for <bpf@vger.kernel.org>; Mon, 21 Dec 2020 00:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nna0WyFAUg/twizuTevbFjazTbDOQamogbH2vekU5NI=;
        b=o0J1cdp3J3zYQz7Iz6CNsltXJO6SQfORfSOo0TwXUh73aUm0kYDlTTJSC10/JBbrma
         QC3ZGOxEd4Qc3yRHuVmp9i4CPCSrnvMK4cI0AcWOCuEcgH2B788G014DTXCZi1mxBF7M
         PcJ1tLl/nIdbijAlFRuWfdeMULhJOrsqmI1Wo8EBh7ZZzTbWDdqay4+CqEdYr+VHBLjX
         dOrf6NTu039n5VTW5F0kTasAaP16bBrp4m1tnK1hajbWJEqIiwwJIlSh3oj7yXfehx5d
         gNPSX8TnILPMJ7G/8uRPYMtSiG9qr2mzENM/b2psmDjFNz1KutWchaMgJKZqPCmZrBH6
         1GqA==
X-Gm-Message-State: AOAM533X3eGdkmQuWTAXHlLc5927JBJdTpT4WUlhIXmjG/GcelQ+YwSa
        Yn8txSXdivb1uhJ/6p0emLsN7UFZfaTR95b5C7jzwzzgV76kdNtZmqMtltWquoNZYQKPb18CzAl
        S5wMgBnCkgiCEgg9vCWNwIHcJik3j
X-Received: by 2002:a25:3a04:: with SMTP id h4mr4979012yba.285.1608541084801;
        Mon, 21 Dec 2020 00:58:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7Grd39SHBvfVHkJSNoRoyV+tt/RVvmmcNPisLAhXi1kiHqXtzG3oeuoxkY87t7gthMnmnxpRmTUR5VL05sMo=
X-Received: by 2002:a25:3a04:: with SMTP id h4mr4979002yba.285.1608541084601;
 Mon, 21 Dec 2020 00:58:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608399672.git.lorenzo@kernel.org> <7f8329b6da1434dc2b05a77f2e800b29628a8913.1608399672.git.lorenzo@kernel.org>
 <20201221093651.44ff4195@carbon>
In-Reply-To: <20201221093651.44ff4195@carbon>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Mon, 21 Dec 2020 09:58:18 +0100
Message-ID: <CAJ0CqmWaE67g7BZ2r0ephBrUL9YGur==J9ryW6nSxAHCUYAdbw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] net: xdp: introduce xdp_init_buff utility routine
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Saeed Mahameed <saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 21, 2020 at 9:37 AM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Sat, 19 Dec 2020 18:55:00 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > index 11ec93f827c0..323340caef88 100644
> > --- a/include/net/xdp.h
> > +++ b/include/net/xdp.h
> > @@ -76,6 +76,13 @@ struct xdp_buff {
> >       u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
> >  };
> >
> > +static __always_inline void
> > +xdp_init_buff(struct xdp_buff *xdp, u32 frame_sz, struct xdp_rxq_info *rxq)
> > +{
> > +     xdp->frame_sz = frame_sz;
> > +     xdp->rxq = rxq;
>
> Later you will add 'xdp->mb = 0' here.

right

>
> > +}
>
> Via the names of your functions, I assume that xdp_init_buff() is
> called before xdp_prepare_buff(), right?
> (And your pending 'xdp->mb = 0' also prefer this.)
>
> Below in bpf_prog_test_run_xdp() and netif_receive_generic_xdp() you
> violate this order... which will give you headaches when implementing
> the multi-buff support.  It is also a bad example for driver developer
> that need to figure out this calling-order from the function names.
>
> Below, will it be possible to have 'init' before 'prepare'?
>

ack, right. Looking at the code we can fix it and have xdp_init_buff()
before xdp_prepare_buff(). I will fix it in v5.

Regards,
Lorenzo

>
> > +
> >  /* Reserve memory area at end-of data area.
> >   *
> >   * This macro reserves tailroom in the XDP buffer by limiting the
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index c1c30a9f76f3..a8fa5a9e4137 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -640,10 +640,10 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
> >       xdp.data = data + headroom;
> >       xdp.data_meta = xdp.data;
> >       xdp.data_end = xdp.data + size;
> > -     xdp.frame_sz = headroom + max_data_sz + tailroom;
> >
> >       rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
> > -     xdp.rxq = &rxqueue->xdp_rxq;
> > +     xdp_init_buff(&xdp, headroom + max_data_sz + tailroom,
> > +                   &rxqueue->xdp_rxq);
> >       bpf_prog_change_xdp(NULL, prog);
> >       ret = bpf_test_run(prog, &xdp, repeat, &retval, &duration, true);
> >       if (ret)
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index a46334906c94..b1a765900c01 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4588,11 +4588,11 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
> >       struct netdev_rx_queue *rxqueue;
> >       void *orig_data, *orig_data_end;
> >       u32 metalen, act = XDP_DROP;
> > +     u32 mac_len, frame_sz;
> >       __be16 orig_eth_type;
> >       struct ethhdr *eth;
> >       bool orig_bcast;
> >       int hlen, off;
> > -     u32 mac_len;
> >
> >       /* Reinjected packets coming from act_mirred or similar should
> >        * not get XDP generic processing.
> > @@ -4631,8 +4631,8 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
> >       xdp->data_hard_start = skb->data - skb_headroom(skb);
> >
> >       /* SKB "head" area always have tailroom for skb_shared_info */
> > -     xdp->frame_sz  = (void *)skb_end_pointer(skb) - xdp->data_hard_start;
> > -     xdp->frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +     frame_sz = (void *)skb_end_pointer(skb) - xdp->data_hard_start;
> > +     frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> >
> >       orig_data_end = xdp->data_end;
> >       orig_data = xdp->data;
> > @@ -4641,7 +4641,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
> >       orig_eth_type = eth->h_proto;
> >
> >       rxqueue = netif_get_rxqueue(skb);
> > -     xdp->rxq = &rxqueue->xdp_rxq;
> > +     xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
> >
> >       act = bpf_prog_run_xdp(xdp_prog, xdp);
>
>
>
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>

