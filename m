Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F692623C0E
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 07:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiKJGoe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 01:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKJGo0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 01:44:26 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BAB2A71D
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 22:44:25 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 63so576434iov.8
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 22:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZWmNl+s6/+ylHCRYLaklnEjUiNAAHp+iYnGFNfbckI=;
        b=jqGCrUUeORBVFvIhuhYXguszWe3kzU+uRddjl4wfCsd5FUpX9G3AsfXU8kW3L7niLM
         Q/H0jOz6lwyvwZ2Xfrb/c4lk8K/cyY7wIQE9HtUxguZUd8g5cveme+DgbYoThaVmKRsA
         ozuLwBCfYf0q90R/BMt+g/lHDbdmJKLD6Y29Y8YCNUO8QcS5f1oomHaWwfBNMq6oIU0i
         2KTzdK9StUoDhDp9XSSvh5YAc8P+C3USV3URKUlDP7bSyWPGsvHZejCmphblhUYmD5nS
         yPJkxpq54M1yCk+k395mmx9zQLuqT6t8ShFtF2ycBKKB68Pihjgj/oQc4tHMranNROxs
         mREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZWmNl+s6/+ylHCRYLaklnEjUiNAAHp+iYnGFNfbckI=;
        b=LIVcvGbwFryrYolOKa8qGA7lfMPOP9e3I8PK87B7Tz2WRZnqABs75xkz8WLd+VcxzO
         hW8DWH/mwBFs+Wupd4uga/TC8mKzGU3Jq0o/gUp8+9gnG8XAgQ6SM/xRz22iXpWZ90rt
         XL0pkqQYpwo3SnmG74TqnOdiQZRskpzbtvakByPSqPf+LG032QnwcSw13IWB3WYy6unP
         KdGDD2mumiEatQxHkeu7Ue7XIrCKMN/j3SPMBLkWCiDGzsjnGVBeDe1kxrbCIdhOxIPL
         zOGZtR6JozYs7wWYjo1XbNLWaissdQ4NxjyRGATmBFKLTgGDLX5ydpND2gL46pBamzFZ
         7V9w==
X-Gm-Message-State: ACrzQf2Bbw8nWSNcdCVQ8wO2Bm146eJ1cLNjZ93NGZyqe0r8dgLRymD2
        BooobhwO7ZJGKGV1Bi+E0dZ/tz/XO5jHZHCQ2Rv2vamndbHHICDk
X-Google-Smtp-Source: AMsMyM5B7R9Y20dOwR14OA9MjHTec76QNVAumQfhA5+n1UZkrhpfHgz4ZoJdt+WYkbHF88uHjHXDl8kt0ZRQm4DVbxM=
X-Received: by 2002:a6b:580e:0:b0:6c0:db74:7be1 with SMTP id
 m14-20020a6b580e000000b006c0db747be1mr2414409iob.92.1668062665318; Wed, 09
 Nov 2022 22:44:25 -0800 (PST)
MIME-Version: 1.0
References: <20221104032532.1615099-1-sdf@google.com> <20221104032532.1615099-5-sdf@google.com>
 <636c4514917fa_13c168208d0@john.notmuch> <CAKH8qBvS9C5Z2L2dT4Ze-dz7YBSpw52VF6iZK5phcU2k4azN5A@mail.gmail.com>
 <636c555942433_13ef3820861@john.notmuch>
In-Reply-To: <636c555942433_13ef3820861@john.notmuch>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 9 Nov 2022 22:44:14 -0800
Message-ID: <CAKH8qBtiNiwbupP-jvs5+nSJRJS4DfZGEPsaYFdQcPKu+8G30g@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 04/14] veth: Support rx timestamp metadata for xdp
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 9, 2022 at 5:35 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Stanislav Fomichev wrote:
> > On Wed, Nov 9, 2022 at 4:26 PM John Fastabend <john.fastabend@gmail.com> wrote:
> > >
> > > Stanislav Fomichev wrote:
> > > > xskxceiver conveniently setups up veth pairs so it seems logical
> > > > to use veth as an example for some of the metadata handling.
> > > >
> > > > We timestamp skb right when we "receive" it, store its
> > > > pointer in new veth_xdp_buff wrapper and generate BPF bytecode to
> > > > reach it from the BPF program.
> > > >
> > > > This largely follows the idea of "store some queue context in
> > > > the xdp_buff/xdp_frame so the metadata can be reached out
> > > > from the BPF program".
> > > >
> > >
> > > [...]
> > >
> > > >       orig_data = xdp->data;
> > > >       orig_data_end = xdp->data_end;
> > > > +     vxbuf.skb = skb;
> > > >
> > > >       act = bpf_prog_run_xdp(xdp_prog, xdp);
> > > >
> > > > @@ -942,6 +946,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
> > > >                       struct sk_buff *skb = ptr;
> > > >
> > > >                       stats->xdp_bytes += skb->len;
> > > > +                     __net_timestamp(skb);
> > >
> > > Just getting to reviewing in depth a bit more. But we hit veth with lots of
> > > packets in some configurations I don't think we want to add a __net_timestamp
> > > here when vast majority of use cases will have no need for timestamp on veth
> > > device. I didn't do a benchmark but its not free.
> > >
> > > If there is a real use case for timestamping on veth we could do it through
> > > a XDP program directly? Basically fallback for devices without hw timestamps.
> > > Anyways I need the helper to support hardware without time stamping.
> > >
> > > Not sure if this was just part of the RFC to explore BPF programs or not.
> >
> > Initially I've done it mostly so I can have selftests on top of veth
> > driver, but I'd still prefer to keep it to have working tests.
>
> I can't think of a use for it though so its just extra cycles. There
> is a helper to read the ktime.

As I mentioned in another reply, I wanted something SW-only to test
this whole metadata story.
The idea was:
- veth rx sets skb->tstamp (otherwise it's 0 at this point)
- veth kfunc to access rx_timestamp returns skb->tstamp
- xsk bpf program verifies that the metadata is non-zero
- the above shows end-to-end functionality with a software driver

> > Any way I can make it configurable? Is there some ethtool "enable tx
> > timestamping" option I can reuse?
>
> There is a -T option for timestamping in ethtool. There are also the
> socket controls for it. So you could spin up a socket and use it.
> But that is a bit broken as well I think it would be better if the
> timestamp came from the receiving physical nic?
>
> I have some mlx nics here and a k8s cluster with lots of veth
> devices so I could think a bit more. I'm just not sure why I would
> want the veth to timestamp things off hand?

-T is for dumping only it seems?

I'm probably using skb->tstamp in an unconventional manner here :-/
Do you know if enabling timestamping on the socket, as you suggest,
will get me some non-zero skb_hwtstamps with xsk?
I need something to show how the kfunc can return this data and how
can this data land in xdp prog / af_xdp chunk..


> >
> > > >                       skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
> > > >                       if (skb) {
> > > >                               if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
>
>
