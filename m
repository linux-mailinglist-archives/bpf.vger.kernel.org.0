Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5693A1F83
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 23:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhFIV7I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Jun 2021 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhFIV7H (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Jun 2021 17:59:07 -0400
Received: from mail-oo1-xc64.google.com (mail-oo1-xc64.google.com [IPv6:2607:f8b0:4864:20::c64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B25C061574
        for <bpf@vger.kernel.org>; Wed,  9 Jun 2021 14:57:12 -0700 (PDT)
Received: by mail-oo1-xc64.google.com with SMTP id j17-20020a0568200231b029024900620310so5026288oob.7
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 14:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=gT9SQ1Bbcn8nCwstUAaRzZb2c6qcr9VYqyk7o8ckMs0=;
        b=ICdT//XIts/yV9bMHKhkq405+ME+4/CywnVfJ4wXMR57e62AZ/+IS3epMF+saiuDtb
         xw28hpVQ3LTaxfTYjSVrNbqnYEQN8zlvzv9rS3mAo9wuuXevnOxPmyFSqz3NPa9MbDWm
         Fdt0PrFmiKiESGm37eyLdqXvgAh/sUAMG66udcXVpo+UC71E6VZy2RfgEdAMq39VOSbf
         w9rQVKUb1bhNAdBM863BdnxaCfECzAvpTGnxTRayRSANPaewPjH2J3rrToekOwywOjOG
         20boTSoID9n4CCUPQ8bFjPLbqr+I42hzzW7yPehbRAlbTKL+yIxFw+UVJLPrFpS76z1G
         6bBA==
X-Gm-Message-State: AOAM531/P8F+/3QXXrkDkmo4X4dkPrVekmwp8IiLIGXLojpWg6SknGpf
        1o3uy3qrJJgumBgoD4kYG2HtR8T+GQlUSCa3NjFHeMPzy3sspA==
X-Google-Smtp-Source: ABdhPJyOu4J0fPHUsevB68IRue7A9rZ0z1snqcV3k/hkGeTa9CMGW968c2dzyGVscYFCQXjHH/+XAnU9g0dt
X-Received: by 2002:a4a:b085:: with SMTP id k5mr1760577oon.20.1623275832141;
        Wed, 09 Jun 2021 14:57:12 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.46])
        by smtp-relay.gmail.com with ESMTPS id y13sm510115ooq.23.2021.06.09.14.57.11
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:57:12 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.47)
    by restore.menlosecurity.com (13.56.32.46)
    with SMTP id a42309b0-c96d-11eb-9331-a52fa8de88a6;
    Wed, 09 Jun 2021 21:57:12 GMT
Received: from mail-ej1-f72.google.com (209.85.218.72)
    by safemail-prod-02780031cr-re.menlosecurity.com (13.56.32.47)
    with SMTP id a42309b0-c96d-11eb-9331-a52fa8de88a6;
    Wed, 09 Jun 2021 21:57:12 GMT
Received: by mail-ej1-f72.google.com with SMTP id f1-20020a1709064941b02903f6b5ef17bfso8436553ejt.20
        for <bpf@vger.kernel.org>; Wed, 09 Jun 2021 14:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gT9SQ1Bbcn8nCwstUAaRzZb2c6qcr9VYqyk7o8ckMs0=;
        b=ZkqMP0+VC/Y1WTPWu9JSbMDSqqbnKy9eokyp7plF+cY6+BLGVmGrnprb1xKpG6RRwz
         +mJ04L9HznDylg0NGHlSBZKmu8P+3j32aJAf/kllTE5pI/pmo2vptCy0kae4q8zDT6m9
         7LW/wpaZTpqekiY77AnELJuyuHh+aKivJ15eQ=
X-Received: by 2002:a05:6402:3134:: with SMTP id dd20mr1407808edb.59.1623275829056;
        Wed, 09 Jun 2021 14:57:09 -0700 (PDT)
X-Received: by 2002:a05:6402:3134:: with SMTP id dd20mr1407800edb.59.1623275828966;
 Wed, 09 Jun 2021 14:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FoirDxh7AhApwWVG_19j5RWT1dp23ab1h0P1nTjhhWpRC5Ow@mail.gmail.com>
 <3e6ba294-12ca-3a2f-d17c-9588ae221dda@gmail.com> <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
In-Reply-To: <CA+FoirCt1TXuBpyayTnRXC2MfW-taN9Ob-3mioPojfaWvwjqqg@mail.gmail.com>
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Wed, 9 Jun 2021 14:56:58 -0700
Message-ID: <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
Subject: Re: bpf_fib_lookup support for firewall mark
To:     David Ahern <dsahern@gmail.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

List,

For what it's worth I patched the structure locally by introducing a
new __u32 mark field
to the structure and adding the proper assignment of the field in
filter.c. Recompiled without any issues.
With that patch a bpf lookup matches ip rule that contains fwmark.

Still interested to know how much of a performance penalty adding an 4
bytes to the
structure brings. I'd certainly vote for adding at least the firewall
mark to the set of fields used in the lookup.

Cheers

On Wed, Jun 9, 2021 at 11:30 AM Rumen Telbizov
<rumen.telbizov@menlosecurity.com> wrote:
>
> Hi David,
>
> Thanks for the quick response. I appreciate it.
> A couple of quick follow up questions:
> 1. Do you have any performance data that would indicate how much of a
> performance drop adding an extra 4 or 8 bytes to the structure would
> cause?
> 2. If I patch locally the structure in libc and the kernel by adding
> an extra _u32 mark member is there anything that such a modification
> would break?
>
> Regards,
> Rumen Telbizov
>
>
> On Tue, Jun 8, 2021 at 6:21 PM David Ahern <dsahern@gmail.com> wrote:
> >
> > On 6/8/21 4:59 PM, Rumen Telbizov wrote:
> > > Dear BPF list,
> > >
> > > I am new to eBPF so go easy on me.
> > > It seems to me that currently eBPF has no support for route table
> > > lookups including firewall marks. The bpf_fib_lookup structure itself
> > > has no mark field as per
> > > https://elixir.bootlin.com/linux/v5.10.28/source/include/uapi/linux/bpf.h#L4864
> > >
> > > Additionally bpf_fib_lookup() function does not incorporate the
> > > firewall mark in its route lookup. It explicitly sets it to 0 as per
> > > https://elixir.bootlin.com/linux/v5.10.28/source/net/core/filter.c#L5329
> > > along with other fields which are used during the regular routing
> > > policy database lookup.
> > >
> > > Thus lookups from within eBPF and outside of it result in different
> > > outcomes if there are rules directing traffic based on fwmark.
> > > Can you please advise what the rationale for this is or if there
> > > anything that I might be missing.
> > >
> > > Let me know if I can provide any further information.
> > >
> >
> > The API (struct bpf_fib_lookup) is constrained to 64B for performance.
> > It is not possible to support all of the policy routing options that
> > Linux has in 64B. Choices had to be made.
