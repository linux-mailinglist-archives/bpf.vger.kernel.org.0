Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ECC367F22
	for <lists+bpf@lfdr.de>; Thu, 22 Apr 2021 12:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhDVK74 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 06:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230285AbhDVK7y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Apr 2021 06:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619089158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXNqgpkvJIOW6Rt8kqHFZkkNxiI31FFU9sMkTfD7ohA=;
        b=CVLojpTDZ6SE3vOIRWQqhRIpC8JJHyfbK4CcMsQKwBTdGuW3IBTBxamRY1JTggnxcHnO4F
        nwD2yoGwNVTFU8X5eDDME4MBFH5QscfoK0YinOAjOJZ19c3zTfkxMN3Y5bO6OUZ65KMoED
        TpoZvlRnWpxO4ZTcq7il9XFISw8Ioyk=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-l9lGJq5oOSC6rYxqLeidxQ-1; Thu, 22 Apr 2021 06:59:16 -0400
X-MC-Unique: l9lGJq5oOSC6rYxqLeidxQ-1
Received: by mail-yb1-f200.google.com with SMTP id n129-20020a2527870000b02904ed02e1aab5so7841119ybn.21
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 03:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXNqgpkvJIOW6Rt8kqHFZkkNxiI31FFU9sMkTfD7ohA=;
        b=JkhrOi7XislZdsEbT4oQRbbs3IggMnFVPTrCid1exMEeGaA5ltny40BtyYQ8L9teC3
         OsFOYeJK6tskB/KP+/+tN72ISZLr9DEPIT0TIDHSKm+IcqvcOxZ1ybr6WiOcRFEFCLOw
         buZ21VLzTeyEQjS0iygDuc+czVqva66ti5FUNLjkjfVAuGUGKNtOWfCo9WUfQc0XwSCY
         lNxPP+o9EZccghULUk1jVdJeFPBGA76O3G3AoZWhN8Kzw88TLkNByWSUQ29uQq3tQHIu
         WZQo4PV6ORCjj6T1mINSBdKJll5XmAzEZk1/wkIBTa9g0TRAmXC6Id+r5ziE/DcReECC
         xY+g==
X-Gm-Message-State: AOAM530lJVzMPpQpuNZkIVDcysLBPkijEe6VkFF0pNP2Bsx2zWWrkHGf
        dK4VUZg+ybV5J+1Vdo9NtopOUXP25R4dDC1yPkaVYKbNJ5nMaeDbb6oaW6wut2J8UOqPNIV5R7x
        fymoHbMYEmrxQIIIU1Zw/7gce1bVC
X-Received: by 2002:a25:3585:: with SMTP id c127mr3926065yba.494.1619089155923;
        Thu, 22 Apr 2021 03:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbSavXiKuXISIWG4lDMx1DpdqRbDapWghhX7SXS7dMcL+73FMg0jHtgYPGDi4OvA7FZTXtYyB2luur95DYKP8=
X-Received: by 2002:a25:3585:: with SMTP id c127mr3926032yba.494.1619089155577;
 Thu, 22 Apr 2021 03:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <01cd8afa22786b2c8a4cd7250d165741e990a771.1618927173.git.lorenzo@kernel.org>
 <20210420185440.1dfcf71c@carbon> <YH8K0gkYoZVfq0FV@lore-desk>
In-Reply-To: <YH8K0gkYoZVfq0FV@lore-desk>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Thu, 22 Apr 2021 12:59:31 +0200
Message-ID: <CAJ0CqmVozWi5uCnzWCpkc5kccnEJWRNbLMb-5YmWe7te9E_Odg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] cpumap: bulk skb using netif_receive_skb_list
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <song@kernel.org>,
        Toke Hoiland Jorgensen <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>
> [...]
> > > +   TP_ARGS(map_id, processed, sched, xdp_stats),
> > >
> > >     TP_STRUCT__entry(
> > >             __field(int, map_id)
> > >             __field(u32, act)
> > >             __field(int, cpu)
> > > -           __field(unsigned int, drops)
> > >             __field(unsigned int, processed)
> >
> > So, struct member @processed will takeover the room for @drops.
> >
> > Can you please test how an old xdp_monitor program will react to this?
> > Will it fail, or extract and show wrong values?
>
> Ack, right. I think we should keep the struct layout in order to maintain
> back-compatibility. I will fix it in v4.
>
> >
> > The xdp_mointor tool is in several external git repos:
> >
> >  https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/samples/bpf/xdp_monitor_kern.c
> >  https://github.com/xdp-project/xdp-tutorial/tree/master/tracing02-xdp-monitor

Running an old version of xdp_monitor with a patched kernel, I
verified the xdp sample does not crash but it reports wrong values
(e.g. pps are reported as drops for tracepoint disagliment).
I think we have two possibilities here:
- assuming tracepoints are not a stable ABI, we can just fix xdp
samples available in the kernel tree and provide a patch for
xdp-project
- keep current tracepoint layout and just rename current drop variable
in bpf/cpumap.c in something like skb_alloc_drop.

I am not against both of them. What do you think?

Regards,
Lorenzo

> >
> > Do you have any plans for fixing those tools?
>
> I update xdp_monitor_{kern,user}.c and xdp_redirect_cpu_{kern,user}.c in the
> patch. Do you mean to post a dedicated patch for xdp-project tutorial?
>
> Regards,
> Lorenzo
>
> >
> >
> >
> >
> > --
> > Best regards,
> >   Jesper Dangaard Brouer
> >   MSc.CS, Principal Kernel Engineer at Red Hat
> >   LinkedIn: http://www.linkedin.com/in/brouer
> >

