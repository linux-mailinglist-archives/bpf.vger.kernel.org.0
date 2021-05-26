Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473A5391880
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 15:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhEZNIe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 09:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231189AbhEZNId (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 May 2021 09:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622034421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aC2zb6ZaSeri5IubWAHQ5M3NodeZP0d72Zj+ohhsyuY=;
        b=L0xoZnkIrKnV4Z7Y2voolabqps66nb2TDqv2tM31adqu35n9LsRYQSDaewzvpNjEbH7B4L
        jowo0lH2RT66JsdRooWUTCJzUiUpAA5I64FefpPPRhixS7Mp7VI2vrEeZfYXt3K7EcNvtq
        XppACpj3nIu/STStmO717o1C46VPJpI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-GPzcX2ubMxeUtsCg-DsOYQ-1; Wed, 26 May 2021 09:06:59 -0400
X-MC-Unique: GPzcX2ubMxeUtsCg-DsOYQ-1
Received: by mail-ed1-f72.google.com with SMTP id cy15-20020a0564021c8fb029038d26976787so575851edb.0
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 06:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aC2zb6ZaSeri5IubWAHQ5M3NodeZP0d72Zj+ohhsyuY=;
        b=fO4QV3aFtc4dosoh/uHrFrNkZtMaY4x6Ko3Ic+oEW2dw0jwoXssnVf7hFJ01a4mMNq
         4mDKCr+oSWDDbJ8vrVyUtEUx77odhW9/oAZ2/H/sNR1NYXMnGFKgJ90uyBwV2kgeDVVs
         CrMAnCzxcdIA/LzaQZp7JnycH0eOLVUftOmC8XiH944778/qcx03gzuVLtg9zyNNcxmY
         K3VMer2+u8JimUBrLwq2S2BxCJ+oAZhws3j8+/KMX4CT7nznZWK20hJY9o6B0SloG+wo
         kpJsddDqezWdSslmqjAX4ehcefxs2jMGxOWM3qVGXYCXMz7A2X6STu/xpI8lA90W82wa
         EHSA==
X-Gm-Message-State: AOAM531XxyOBiJQKzWu4ubfoW0mR0s6tvs3VKj7uNj4E31HZ27IWPkO2
        NLD54x8foo0QYx14zSCff7jXBu4MWPDHMoQy6MDb2NdpnePd5mpnf+vUVSHCfulqzxkKUBItsnF
        V2cj6LPrZgI3D
X-Received: by 2002:a17:906:f996:: with SMTP id li22mr33238481ejb.255.1622034418131;
        Wed, 26 May 2021 06:06:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG3WeQ6PnIFZY0DfO17IvBycIsEXS+ngsorswAwb/Mg4fFHZlfjXg6PBeXMptq8y7YLrF7qA==
X-Received: by 2002:a17:906:f996:: with SMTP id li22mr33238440ejb.255.1622034417719;
        Wed, 26 May 2021 06:06:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id j1sm4962697edv.14.2021.05.26.06.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 06:06:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0E21918071B; Wed, 26 May 2021 15:06:56 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Saeed Mahameed <saeed@kernel.org>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Kubiak, Marcin" <marcin.kubiak@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, bpf@vger.kernel.org,
        brouer@redhat.com
Subject: Re: AF_XDP metadata/hints
In-Reply-To: <20210526134910.1c06c5d8@carbon>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com>
 <20210507131034.5a62ce56@carbon>
 <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com>
 <20210510185029.1ca6f872@carbon>
 <DM4PR11MB54227C25DFD4E882CB03BD3884539@DM4PR11MB5422.namprd11.prod.outlook.com>
 <20210512102546.5c098483@carbon>
 <DM4PR11MB542273C9D8BF63505DC6E21784519@DM4PR11MB5422.namprd11.prod.outlook.com>
 <7b347a985e590e2a422f837971b30bd83f9c7ac3.camel@nvidia.com>
 <DM4PR11MB5422762E82C0531B92BDF09A842B9@DM4PR11MB5422.namprd11.prod.outlook.com>
 <DM4PR11MB5422269F6113268172B9E26A842A9@DM4PR11MB5422.namprd11.prod.outlook.com>
 <DM4PR11MB54224769926B06EE76635A6484299@DM4PR11MB5422.namprd11.prod.outlook.com>
 <20210521153110.207cb231@carbon>
 <1426bc91c6c6ee3aaf3d85c4291a12968634e521.camel@kernel.org>
 <87lf85zmuw.fsf@toke.dk>
 <20210525142027.1432-1-alexandr.lobakin@intel.com>
 <60add3cad4ef0_3b75f2086@john-XPS-13-9370.notmuch>
 <20210526134910.1c06c5d8@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 26 May 2021 15:06:55 +0200
Message-ID: <87y2c1iqz4.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> On Tue, 25 May 2021 21:51:22 -0700
> John Fastabend <john.fastabend@gmail.com> wrote:
>
>> Separate the config of hardware from the BPF infrastructure these
>> are two separate things.
>
> I fully agree.

+1. Another reason why is the case of multiple XDP programs on a single
interface: When attaching these (using freplace as libxdp does it), the
kernel can just check the dest interface when verifying the freplace
program and any rewriting of the bytecode from the BTF format can happen
at that point. Whereas if the BPF attach needs to have side effects,
suddenly we have to copy over all the features to the dispatcher program
and do some kind of set union operation; and what happens if an freplace
program is attached after the fact (same thing with tail calls)?

So in my mind there's no doubt this needs to be:

driver is config'ed -> it changes its exposed BTF metadata -> program is
attached -> verifier rewrites program to access metadata correctly

> How should we handle existing config interfaces?
>
> Let me give some concrete examples. Today there are multiple existing
> interfaces to enable/disable NIC hardware features that change what is
> available to put in our BTF-layout.
>
> E.g. changing if VLAN is in descriptor:
>  # ethtool -K ixgbe1 rx-vlan-offload off
>  # ethtool -k ixgbe1 | grep vlan-offload
>  rx-vlan-offload: off
>  tx-vlan-offload: on
>
> The timestamping features can be listed by ethtool -T (see below
> signature), but it is a socket option that enable[1] these
> (see SO_TIMESTAMPNS or SOF_TIMESTAMPING_RX_HARDWARE).
>
> Or tuning RSS hash fields:
>  [2] https://github.com/stackpath/rxtxcpu/blob/master/Documentation/case-studies/observing-rss-on-ixgbe-advanced-rss-configuration-rss-hash-fields.md
>
> I assume we need to stay compatible and respect the existing config
> interfaces, right?
>
> Should we simple leverage existing interfaces?

Now that ethtool has moved to netlink it should be quite
straight-forward to add a separate subset of commands for configuring
metadata fields; and internally the kernel can map those to the existing
config knobs, no?

E.g., if you tell the kernel you'd like to have the VLAN field as a
metadata field that kinda implies that rx-vlan-offload should be turned
on; etc. Any reason this would break down?

-Toke

