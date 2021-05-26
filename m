Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549CC391C83
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbhEZP5X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 11:57:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:8219 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232769AbhEZP5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 11:57:21 -0400
IronPort-SDR: bmOGB4xB+/HESyVdUPeogMyjKpb/tIunoDPCHFZs2NuBXKHzfaWHGUdK/EGNQOa/jy5decwgle
 LmomGqc+0qIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="288078719"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="288078719"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 08:54:12 -0700
IronPort-SDR: kHrzN6nExjX7QqJ0Dfsdp4eufx2y65Ec47L0quvMCjtGretGKPZuZ13xh9fSprg0KREjrg/zqa
 KcZuHjCH8GUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="615009193"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2021 08:54:07 -0700
Received: from alobakin-mobl.ger.corp.intel.com (pglomski-mobl.ger.corp.intel.com [10.213.8.24])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 14QFs46Z004818;
        Wed, 26 May 2021 16:54:05 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
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
        xdp-hints@xdp-project.net
Subject: Re: AF_XDP metadata/hints
Date:   Wed, 26 May 2021 17:54:02 +0200
Message-Id: <20210526155402.172-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <60ae6ad5a2e04_18bf20819@john-XPS-13-9370.notmuch>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com> <20210507131034.5a62ce56@carbon> <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com> <20210510185029.1ca6f872@carbon> <DM4PR11MB54227C25DFD4E882CB03BD3884539@DM4PR11MB5422.namprd11.prod.outlook.com> <20210512102546.5c098483@carbon> <DM4PR11MB542273C9D8BF63505DC6E21784519@DM4PR11MB5422.namprd11.prod.outlook.com> <7b347a985e590e2a422f837971b30bd83f9c7ac3.camel@nvidia.com> <DM4PR11MB5422762E82C0531B92BDF09A842B9@DM4PR11MB5422.namprd11.prod.outlook.com> <DM4PR11MB5422269F6113268172B9E26A842A9@DM4PR11MB5422.namprd11.prod.outlook.com> <DM4PR11MB54224769926B06EE76635A6484299@DM4PR11MB5422.namprd11.prod.outlook.com> <20210521153110.207cb231@carbon> <1426bc91c6c6ee3aaf3d85c4291a12968634e521.camel@kernel.org> <87lf85zmuw.fsf@toke.dk> <20210525142027.1432-1-alexandr.lobakin@intel.com> <60add3cad4ef0_3b75f2086@john-XPS-13-9370.notmuch> <20210526134910.1c06c5d8@carbon> <87y2c1iqz4.fsf@toke.dk> <60ae6ad5a2e04_18bf20819@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 26 May 2021 08:35:49 -0700

Hi all,

>Toke Høiland-Jørgensen wrote:
>> Jesper Dangaard Brouer <brouer@redhat.com> writes:
>> 
>> > On Tue, 25 May 2021 21:51:22 -0700
>> > John Fastabend <john.fastabend@gmail.com> wrote:
>> >
>> >> Separate the config of hardware from the BPF infrastructure these
>> >> are two separate things.
>> >
>> > I fully agree.

It was not about hardware feature reprogramming like csumming and
stuff, only about composing the medatada according to the prog's
request.

>> +1. Another reason why is the case of multiple XDP programs on a single
>> interface: When attaching these (using freplace as libxdp does it), the
>> kernel can just check the dest interface when verifying the freplace
>> program and any rewriting of the bytecode from the BTF format can happen
>> at that point. Whereas if the BPF attach needs to have side effects,
>> suddenly we have to copy over all the features to the dispatcher program
>> and do some kind of set union operation; and what happens if an freplace
>> program is attached after the fact (same thing with tail calls)?
>> 
>> So in my mind there's no doubt this needs to be:
>> 
>> driver is config'ed -> it changes its exposed BTF metadata -> program is
>> attached -> verifier rewrites program to access metadata correctly
>
>Well likely libbpf would do the rewrite I think.

So your proposal is to not compose metadata according to the prog's
request, but rather reprogram the prog itself to access metadata
accordingly? Sounds very nice.

If follow this path, is it something like this?

1. Driver exposes the fields layout (e.g. Rx/Tx descriptor fields)
via BTF to the BPF layer.
2. When an XDP prog is attached, BPF reprograms it to look for the
required fields at the right offset.

>> 
>> > How should we handle existing config interfaces?
>> >
>> > Let me give some concrete examples. Today there are multiple existing
>> > interfaces to enable/disable NIC hardware features that change what is
>> > available to put in our BTF-layout.
>> >
>> > E.g. changing if VLAN is in descriptor:
>> >  # ethtool -K ixgbe1 rx-vlan-offload off
>> >  # ethtool -k ixgbe1 | grep vlan-offload
>> >  rx-vlan-offload: off
>> >  tx-vlan-offload: on
>> >
>> > The timestamping features can be listed by ethtool -T (see below
>> > signature), but it is a socket option that enable[1] these
>> > (see SO_TIMESTAMPNS or SOF_TIMESTAMPING_RX_HARDWARE).
>> >
>> > Or tuning RSS hash fields:
>> >  [2] https://github.com/stackpath/rxtxcpu/blob/master/Documentation/case-studies/observing-rss-on-ixgbe-advanced-rss-configuration-rss-hash-fields.md
>> >
>> > I assume we need to stay compatible and respect the existing config
>> > interfaces, right?

Again, XDP Hints won't change any netdev features and stuff, only
compose provide the hardware provided fields that are currently
inaccessible by the XDP prog and say cpumap code, but that are
highly needed (cpumap builds skbs without csums -> GRO layer
consumes CPU time to calculate it manually, without RSS hash ->
Flow Dissector consumes CPU time to calculate it manually +
possible NAPI bucket misses etc.).

So, neither Ethtool (that doesn't belong to XDP at all) nor anything
else that changes hardware behaviour is involved.

>I'm not convinced its a strict requirement, rather its a nice to
>have. These are low level ethtool hooks into the hardware its
>fine IMO if the hardware just reports off and uses a more robust
>configuration channel. In general we should try to get away from
>this model where kernel devs are acting as the gate keepers for
>all hardware offloads and we explicit add checkboxs that driver
>writers can use. The result is the current state of things where
>we have very flexible hardware that are not usable from Linux.
>
>> >
>> > Should we simple leverage existing interfaces?
>> 
>> Now that ethtool has moved to netlink it should be quite
>> straight-forward to add a separate subset of commands for configuring
>> metadata fields; and internally the kernel can map those to the existing
>> config knobs, no?
>
>Its unclear to me how you simple expose knobs to reconfigure hardware.
>It looks to me that you need to push a blob down to the hardware to
>reconfigure it for new parsers, new actions, etc. But, maybe the
>folks working on current hardware can speak up.
>
>> 
>> E.g., if you tell the kernel you'd like to have the VLAN field as a
>> metadata field that kinda implies that rx-vlan-offload should be turned
>> on; etc. Any reason this would break down?
>> 
>> -Toke
>> 

That's right. If you want to have a VLAN tag in the medatdata, make
sure Rx offloading is enabled. Same with csums and the rest. No
explicit switches on prog insertion/removing.

>Agree driver should be able to map these back onto 'legacy' feature
>sets.
>
>I'll still have a basic question though. I've never invested much time
>into the hints because its still not clear to me what the use case is?
>What would we put in the hints and do we have any data to show it would be
>a performance win.

As I said, currently both XDP Rx and XDP Tx paths suffer from that
they lack some essential info like Rx csums and hashes and e.g.
Tx csum status. XDP Hints are about to place these fields into
the metadata area that is located right before the frame, so either
BPF prog or mentioned cpumap could access it.

>If its a simple hash of the headers then how would we use it? The
>map_lookup/updates use IP addrs for keys in Cilium. So I think the
>suggestion is to offload the jhash operation? But that requires some
>program changes to work. Could someone convince me?
>
>Maybe packet timestamp?
>
>Thanks,
>John

Thanks,
Al
