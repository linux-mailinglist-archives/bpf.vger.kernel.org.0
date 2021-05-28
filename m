Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D8739410C
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 12:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbhE1KkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 06:40:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:31398 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236312AbhE1Kjz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 06:39:55 -0400
IronPort-SDR: BEXk8wbhMTV9VbzctgDekrsyd2mLeBQWTOuADJnpPpHKOEcB8EGKgNSN7U+4IYEW/4HwPt9FpW
 y2yUmfAyZsXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="264128507"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="264128507"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 03:38:18 -0700
IronPort-SDR: ccSUh2/M9uhkJOwwCGKjFJgh4oy8wAYC9og844L8bHZtf5WImGrYbJPrtXX3j9TTwvHcW4NHZi
 jzbpRHKH1uLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="477881761"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga001.jf.intel.com with ESMTP; 28 May 2021 03:38:13 -0700
Received: from alobakin-mobl.ger.corp.intel.com (pmochock-MOBL.ger.corp.intel.com [10.213.23.107])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 14SAcA9D002896;
        Fri, 28 May 2021 11:38:10 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        BPF-dev-list <bpf@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Desouza, Ederson" <ederson.desouza@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        William Tu <u9012063@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        xdp-hints@xdp-project.net
Subject: Re: XDP-hints: Howto support multiple BTF types per packet basis?
Date:   Fri, 28 May 2021 12:38:10 +0200
Message-Id: <20210528103810.102-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <87fsy7gqv7.fsf@toke.dk>
References: <20210526125848.1c7adbb0@carbon> <CAEf4BzYXUDyQaBjZmb_Q5-z3jw1-Uvdgxm+cfcQjSwb9oRoXnQ@mail.gmail.com> <60aeb01ebcd10_fe49208b8@john-XPS-13-9370.notmuch> <CAEf4Bza3m5dwZ_d0=zAWR+18f5RUjzv9=1NbhTKAO1uzWg_fzQ@mail.gmail.com> <60aeeb5252147_19a622085a@john-XPS-13-9370.notmuch> <CAEf4Bzb1OZHpHYagbVs7s9tMSk4wrbxzGeBCCBHQ-qCOgdu6EQ@mail.gmail.com> <60b08442b18d5_1cf8208a0@john-XPS-13-9370.notmuch> <87fsy7gqv7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>
Date: Fri, 28 May 2021 11:16:44 +0200

> John Fastabend <john.fastabend@gmail.com> writes:
> 
> >> > > union and independent set of BTFs are two different things, I'll let
> >> > > you guys figure out which one you need, but I replied how it could
> >> > > look like in CO-RE world
> >> >
> >> > I think a union is sufficient and more aligned with how the
> >> > hardware would actually work.
> >> 
> >> Sure. And I think those are two orthogonal concerns. You can start
> >> with a single struct mynic_metadata with union inside it, and later
> >> add the ability to swap mynic_metadata with another
> >> mynic_metadata___v2 that will have a similar union but with a
> >> different layout.
> >
> > Right and then you just have normal upgrade/downgrade problems with
> > any struct.
> >
> > Seems like a workable path to me. But, need to circle back to the
> > what we want to do with it part that Jesper replied to.
> 
> So while this seems to be a viable path for getting libbpf to do all the
> relocations (and thanks for hashing that out, I did not have a good grip
> of the details), doing it all in userspace means that there is no way
> for the XDP program to react to changes once it has been loaded. So this
> leaves us with a selection of non-very-attractive options, IMO. I.e.,
> we would have to:
> 
> - have to block any modifications to the hardware config that would
>   change the metadata format; this will probably result in irate users
> 
> - require XDP programs to deal with all possible metadata permutations
>   supported by that driver (by exporting them all via a BTF union or
>   similar); this means a potential for combinatorial explosion of config
>   options and as NICs become programmable themselves I'm not even sure
>   if it's possible for the driver to know ahead of time
> 
> - throw up our hands and just let the user deal with it (i.e., to
>   nothing and so require XDP programs to be reloaded if the NIC config
>   changes); this is not very friendly and is likely to lead to subtle
>   bugs if an XDP program parses the metadata assuming it is in a
>   different format than it is
> 
> Given that hardware config changes are not just done by ethtool, but
> also by things like running `tcpdump -j`, I really think we have to
> assume that they can be quite dynamic; which IMO means we have to solve
> this as part of the initial design. And I have a hard time seeing how
> this is possible without involving the kernel somehow.
> 
> Unless I'm missing something? WDYT?

First of all, thank you all guys for such a huge feedback. The last
proposal about CO-RE is like a game changer.
BTW, I've submitted a Workshop to Netdev 0x15 so we could discuss
these topics (Hints etc.) in a realtime fashion if anyone is
interested.

Second: there really are LOTS of usecases for this, not only cpumap/
veth, and not only for Rx fields, but also to be able to specify Tx
bits for XDP_TX/XDP_REDIRECT actions (like: TCP csum offload, Tx
timestamp offload like Jesper mentioned etc.).

I'm writing it on this particular line because it's one of the
majors I wanted to clarify as Toke does.

> -Toke

Thanks,
Al
