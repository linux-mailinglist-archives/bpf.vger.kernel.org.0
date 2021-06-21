Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D223AF8C6
	for <lists+bpf@lfdr.de>; Tue, 22 Jun 2021 00:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhFUWsb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Jun 2021 18:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbhFUWsb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Jun 2021 18:48:31 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A52C061574
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 15:46:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id df12so18635481edb.2
        for <bpf@vger.kernel.org>; Mon, 21 Jun 2021 15:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vyo44xshusrqA1yJbr/c25QrvrNBbPbsiuT5o1cgopg=;
        b=UZBWwBOuoiF7nBPVOLyi3M/lAxujGuoKsIwc0dt+gvcuE7i0qiCWUve9+s+c32GW74
         j/UgONEgwKHE/9amfpzph/dXsS32g2kW0n0SWXzAQ4jmrjLbw7eD46CQs2U7DmPEbjcg
         6MD29Y2CJoubYv/0pv7fu2WM+KH6lJ3ohs01c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vyo44xshusrqA1yJbr/c25QrvrNBbPbsiuT5o1cgopg=;
        b=L67lnh41N2oag95pZz2FbnGM0GucEHLiJvWpYhFeHzyA7aU5xINeL8YfP6ss7MZmgX
         R5g5NMGYV2uuyMjx3waOVLTNxbkr9hfAZEJDHAC3V1z4kn5QCKV+BVLQ6do1xVh+eHHg
         KaJwOgGvgo0Etf+zZHqyHaVr7053T1Pv/XjwKhdVdPnfiUoPKCrMWFMjoK5x75HSU+Sj
         6TxsBtUJvEEpW/Bewrlophktcqqw5M32Puj3Iq/FrWIJjqYkC4RXrpDTFkf4QkadRQp4
         8uJtqRM/dvm4Ksk2K0VleRYtWJbaClWnJQXMGVoO+boG6npgIms3NbdXHmq+SfatWdnb
         9eYQ==
X-Gm-Message-State: AOAM531x+edwyCvzW+94tYIxKRBvAZDfpR9b3anM9QQdijTSL8LUvwCs
        B+MS+2PXDkLrgWX+KoINpS8Ookq1ULNerMolBA4esg==
X-Google-Smtp-Source: ABdhPJyJKDO5i7osXEI37awbdGp6HogLExertyCaEYs4Dxe3HlWm2UjAky8VpWTBtDGjUYCwkM64BtP2rVTTDinAxPk=
X-Received: by 2002:a50:b8e6:: with SMTP id l93mr881650ede.25.1624315574237;
 Mon, 21 Jun 2021 15:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210617232904.1899-1-zeffron@riotgames.com> <20210617232904.1899-4-zeffron@riotgames.com>
 <c3332ade-4a7a-b22a-9323-13cf0751888c@iogearbox.net>
In-Reply-To: <c3332ade-4a7a-b22a-9323-13cf0751888c@iogearbox.net>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Mon, 21 Jun 2021 15:46:02 -0700
Message-ID: <CAC1LvL2J5FoTZ_jjNyajNeb1V9jr_p=T67ah4qNJhzZ4xT2TbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 3/4] bpf: support specifying ingress via
 xdp_md context in BPF_PROG_TEST_RUN
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 21, 2021 at 2:26 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 6/18/21 1:29 AM, Zvi Effron wrote:
> > Support specifying the ingress_ifindex and rx_queue_index of xdp_md
> > contexts for BPF_PROG_TEST_RUN.
> >
> > The intended use case is to allow testing XDP programs that make decisions
> > based on the ingress interface or RX queue.
> >
> > If ingress_ifindex is specified, look up the device by the provided index
> > in the current namespace and use its xdp_rxq for the xdp_buff. If the
> > rx_queue_index is out of range, or is non-zero when the ingress_ifindex is
> > 0, return -EINVAL.
> >
> > Co-developed-by: Cody Haas <chaas@riotgames.com>
> > Signed-off-by: Cody Haas <chaas@riotgames.com>
> > Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> > Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> > Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> > ---
> >   net/bpf/test_run.c | 22 +++++++++++++++++++++-
> >   1 file changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index 229c5deb813c..1ba15c741517 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -690,15 +690,35 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >
> >   static int xdp_convert_md_to_buff(struct xdp_md *xdp_md, struct xdp_buff *xdp)
> >   {
> > +     unsigned int ingress_ifindex, rx_queue_index;
> > +     struct netdev_rx_queue *rxqueue;
> > +     struct net_device *device;
> > +
> >       if (!xdp_md)
> >               return 0;
> >
> >       if (xdp_md->egress_ifindex != 0)
> >               return -EINVAL;
> >
> > -     if (xdp_md->ingress_ifindex != 0 || xdp_md->rx_queue_index != 0)
> > +     ingress_ifindex = xdp_md->ingress_ifindex;
> > +     rx_queue_index = xdp_md->rx_queue_index;
> > +
> > +     if (!ingress_ifindex && rx_queue_index)
> >               return -EINVAL;
> >
> > +     if (ingress_ifindex) {
> > +             device = dev_get_by_index(current->nsproxy->net_ns,
> > +                                       ingress_ifindex);
>
> This takes a reference on the device, which seems to be leaked here?

That would be an accurate assessment. Good catch. We'll fix that!

>
> > +             if (!device)
> > +                     return -EINVAL;
> > +
> > +             if (rx_queue_index >= device->real_num_rx_queues)
> > +                     return -EINVAL;
> > +
> > +             rxqueue = __netif_get_rx_queue(device, rx_queue_index);
> > +             xdp->rxq = &rxqueue->xdp_rxq;
> > +     }
> > +
> >       xdp->data = xdp->data_meta + xdp_md->data;
> >
> >       return 0;
> >
>
