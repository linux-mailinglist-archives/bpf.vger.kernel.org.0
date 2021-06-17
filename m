Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114513ABF15
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 00:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbhFQWtY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Jun 2021 18:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhFQWtY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 18:49:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11172C061574
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 15:47:15 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t7so5930670edd.5
        for <bpf@vger.kernel.org>; Thu, 17 Jun 2021 15:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3CtJA0JJwzBHXRKT3dNWYUHX1OMryHt5sBiflFXW2Y=;
        b=NSH69NFh7jBz/94/lSe0hkBmsiDBv+zdS62EwcdbbYibZBleN2v/UdJXSzJq+C/8ky
         yAGsUS6f08Zz5WxthFQehZ8DWsRtNlAi6YrIouF15i30hEsfJqGdMkREiTxD2xW4BIZl
         BLl+rShyU+s/eVMRweX+Gf88es0xH0UjTg0ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3CtJA0JJwzBHXRKT3dNWYUHX1OMryHt5sBiflFXW2Y=;
        b=qB61PJGcDZQMIliI5NUga6i2AeRY3VZo72QvhoWCKs96mQj0JETZOM2W7GC/YhZncC
         miS+kfdVc98vpFXzOngFSmmgfCVBYBpsND4pX9akofEqwsYH+WYCyHKzK5Gk2mij+596
         FzTV/hu6rbPiApxrWi3AXxgMTzCI8teDPT5aP82APMs0CHlcV3EW4Nc5wyNiauDVQvoY
         UEZyt/tzRjDB6iNHho6YYoVPNZ1TFXFFIZcpLz8XzLKrIfjuVP56nTCSIrcvTsj/Hqrl
         yHIdINSvmvJ2k39SrPVtpTZ24RChGFN+A2OnYOZI3je6RBvsd7LheOXphFCXj2Z/PfnS
         d4+g==
X-Gm-Message-State: AOAM531OFSaEkXde3mXI8FsK561A/qP00c32/ouYFR8kwCPNLTtwagi4
        pAVGeT1dZxqYdV0e6GirYmSxwvLfQn+OCFD7NBytdA==
X-Google-Smtp-Source: ABdhPJyH14dwVANgXw1VTnE9ziEnPes/V+VMitHGdavpdSSOYlQzjJKeGLOJO5cFMDQ23vyCg+Yc80rM5tP4+HNJVw0=
X-Received: by 2002:a50:ee18:: with SMTP id g24mr862501eds.11.1623970033431;
 Thu, 17 Jun 2021 15:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210616224712.3243-1-zeffron@riotgames.com> <20210616224712.3243-4-zeffron@riotgames.com>
 <039ecbf0-c08b-8c18-b030-e902a1ded9f0@fb.com>
In-Reply-To: <039ecbf0-c08b-8c18-b030-e902a1ded9f0@fb.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Thu, 17 Jun 2021 17:47:02 -0500
Message-ID: <CAC1LvL2K+8UNxARLsrhDC0dFtSigQkkKjrGp7kxJBJTeHnFBZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] bpf: support specifying ingress via
 xdp_md context in BPF_PROG_TEST_RUN
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Cody Haas <chaas@riotgames.com>,
        Lisa Watanabe <lwatanabe@riotgames.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 1:55 AM Yonghong Song <yhs@fb.com> wrote:
>
> On 6/16/21 3:47 PM, Zvi Effron wrote:
> > Support specifying the ingress_ifindex and rx_queue_index of xdp_md
> > contexts for BPF_PROG_TEST_RUN.
> >
> > The intended use case is to allow testing XDP programs that make decisions
> > based on the ingress interface or RX queue.
> >
> > If ingress_ifindex is specified, look up the device by the provided index
> > in the current namespace and use its xdp_rxq for the xdp_buff. If the
> > rx_queue_index is out of range, or is non-zero when the ingress_ifindex is
> > 0, return EINVAL.
>
> Let us match actual implementation.
>     EINVAL => -EINVAL
>
> >
> > Co-developed-by: Cody Haas <chaas@riotgames.com>
> > Signed-off-by: Cody Haas <chaas@riotgames.com>
> > Co-developed-by: Lisa Watanabe <lwatanabe@riotgames.com>
> > Signed-off-by: Lisa Watanabe <lwatanabe@riotgames.com>
> > Signed-off-by: Zvi Effron <zeffron@riotgames.com>
> > ---
> >   net/bpf/test_run.c | 23 ++++++++++++++++++++++-
> >   1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index f3054f25409c..0183fefd165c 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -690,15 +690,36 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
> >
> >   static int xdp_convert_md_to_buff(struct xdp_md *xdp_md, struct xdp_buff *xdp)
> >   {
> > +     unsigned int ingress_ifindex;
> > +     unsigned int rx_queue_index;
>
> nit: the above two definitions have the same type, let us merge them
> into one line.
>
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
> > +             if (!device)
> > +                     return -EINVAL;
> > +
> > +             if (rx_queue_index >= device->real_num_rx_queues)
> > +                     return -EINVAL;
>
> Does rx_queue_index = 0 is valid? I don't know whether it is valid
> or not, just asking.

Yes. RX queues are 0 indexed.

>
> > +
> > +             rxqueue = __netif_get_rx_queue(device, rx_queue_index);
> > +             xdp->rxq = &rxqueue->xdp_rxq;
> > +     }
> > +
> >       xdp->data = xdp->data_meta + xdp_md->data;
> >
> >       return 0;
> >
