Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9173E03FD
	for <lists+bpf@lfdr.de>; Wed,  4 Aug 2021 17:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbhHDPQQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Aug 2021 11:16:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:10195 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237114AbhHDPQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Aug 2021 11:16:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="194219633"
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="194219633"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 08:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,294,1620716400"; 
   d="scan'208";a="585487684"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2021 08:15:58 -0700
Received: from alobakin-mobl.ger.corp.intel.com (kswiecic-MOBL.ger.corp.intel.com [10.213.28.10])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 174FFv6Z011045;
        Wed, 4 Aug 2021 16:15:57 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Marcin Kubiak <marcin.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Ederson de Souza <ederson.desouza@intel.com>,
        xdp-hints@xdp-project.net, bpf@vger.kernel.org
Subject: Re: [[RFC xdp-hints] 00/16] XDP hints and AF_XDP support
Date:   Wed,  4 Aug 2021 17:15:55 +0200
Message-Id: <20210804151555.287-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <61095f7843aaa_66240208e6@john-XPS-13-9370.notmuch>
References: <20210803010331.39453-1-ederson.desouza@intel.com> <20210803091238.102-1-alexandr.lobakin@intel.com> <61095f7843aaa_66240208e6@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>
Date: Tue, 03 Aug 2021 08:23:36 -0700

> Alexander Lobakin wrote:
> > From: Ederson de Souza <ederson.desouza@intel.com>
> > Date: Mon,  2 Aug 2021 18:03:15 -0700
> >
> > > While there's some work going on different aspects of the XDP hints, I'd like
> > > to present and ask for comments on this patch series.
> > >
> > > XDP hints/metadata is a way for the driver to transmit information regarding a
> > > specific XDP frame along with the frame. Following current discussions and
> > > based on top of Saeed's early patches, this series provides the XDP hints with
> > > one (or two, depending on how you view it) use case: RX/TX timestamps for the
> > > igc driver.
> > >
> > > Keeping with Saeed's patches, to enable XDP hints usage, one has to first
> > > enable it with bpftool like:
> > >
> > >   bpftool net xdp set dev <iface> md_btf on
> > >
> > > >From the driver perspective, support for XDP hints is achieved by:
> > >
> > >  - Adding support for XDP_SETUP_MD_BTF operation, where it can register the BTF.
> > >
> > >  - Adding support for XDP_QUERY_MD_BTF so user space can retrieve the BTF id.
> > >
> > >  - Adding the relevant data to the metadata area of the XDP frame.
> > >
> > >     - One of this relevant data is the BTF id of the BTF in use.
> > >
> > > In order to make use of the BPF CO-RE mechanism, this series makes the driver
> > > name of the struct for the XDP hints be called `xdp_hints___<driver_name>` (in
> > > this series, as I'm using igc driver, it becomes `xdp_hints___igc`). This
> > > should help BPF programs, as they can simply refer to the struct as `xdp_hints`.
> > >
> > > A common issue is how to standardize the names of the fields in the BTF. Here,
> > > a series of macros is provided on the `include/net/xdp.h`, that goes by
> > > `XDP_GENERIC_` prefixes. In there, the `btf_id` field was added, that needs
> > > to be strategically positioned at the end of the struct. Also added are the
> > > `rx_timestamp` and  `tx_timestamp` fields, as I believe they're generic as
> > > well. The macros also provide `u32` and `u64` types. Besides, I also ended
> > > up adding a `valid_map` field. It should help whoever is using the XDP hints
> > > to be sure of what is valid in that hints. It also makes the driver life
> > > simple, as it just uses a single struct and validates fields as it fills
> > > them.
> > >
> > > The BPF sample `xdp_sample_pkts` was modified to demonstrate the usage of XDP
> > > hints on BPF programs. It's a very simple example, but it shows some nice
> > > things about it. For instance, instead of getting the struct somehow before,
> > > it uses CO-RE to simply name the XDP hint field it's interested in and
> > > read it using `BPF_CORE_READ`. (I also tried to use `bpf_core_field_exists` to
> > > make it even more dynamic, but couldn't get to build it. I mention why in the
> > > example.)
> > >
> > > Also, as much of my interest lies in the user space side, the one using
> > > AF_XDP, to support it a few additional things were done.
> > >
> > > Firstly, a new "driver info" is provided, to be obtained via
> > > `ioctl(SIOCETHTOOL)`: "xdp_headroom". This is how much XDP headroom is
> > > required by the driver. While not really important for the RX path (as the
> > > driver already applies that headroom to the XDP frame), it's
> > > important for the TX path, as here, it's the application responsibility to
> > > factor in the XDP headroom area. (Note that the TX timestamp is obtained from
> > > the XDP frame of the transmitted packet, when that frame goes back to the
> > > completion queue.)
> > >
> > > A series of helpers was also added to libbpf to help manage this headroom
> > > area. They go by the prefix " xsk_umem__adjust_", to adjust consumer and
> > > producer data and metadata.
> > >
> > > In order to read the XDP hints from the memory, another series of helpers was
> > > added. They read the BTF from the BTF id, and create a hashmap of the offsets
> > > and sizes of the fields, that is then used to actually retrieve the data.
> > >
> > > I modified the "xdpsock" example to show the use of XDP hints on the AF_XDP
> > > world, along with the proposed API.
> > >
> > > Finally, I know that Michal and Alexandr (and probably others that I don't
> > > know) are working in this same front. This RFC is not to race any other work,
> > > instead I hope it can help in the discussion of the best solution for the
> > > XDP hints and I truly think it brings value, specifically for the AF_XDP
> > > usages.
> >
> > XDP Hints have been discussed on Netdev 0x15, and we kinda
> > established the optimal way for doing it. This RFC's approach
> > is not actual anymore.
> 
> Its great it was discussed, but you need to also summarize it
> on the list. Give us the conclusion, who came to it, and why
> its better then this proposal or whats wrong with this proposal.
> Not everyone was in the discussion and here we
> have a concrete proposal _with_ code. You can't just out of hand
> throw it out based on a conference discussion.

The conclusion was:
 * no need to register BTF from drivers themselves, they can be
   obtained through sysfs interface;
 * the verifier has nothing to do with Hints and stuff, BTF ID
   just gets passed along with the other XDP Prog setup flags;
 * no if-else ladders or loops when preparing a metadata, only
   a couple of paths to satisfy generic needs (first of all)
   and some sort of extended structure if needed;
 * the first two users of the feature will be veth and cpumap.

This greatly simplifies the code and the hotpath.

It was decided by Jesper, Toke, Lorenzo, Michal, me, and several
more attendees (sorree if I forgot someone).

> > You could just write to me and request write perms on our open
> > GitHub repo (which was mentioned here several times) for Hints
> > to do things if not together, then in one place at least.
> > I'll be off for two weeks since next Monday, Michal could get
> > you into things if you decide to join after than point
> > (if at all).
> 
> I'll review code thats posted on the list. Please
> do the same or give us a _reason_ to skip it. It has a nice commit
> message that on the face looks like a reasonable starting point
> even if I have a few issues with the aproach in a couple spots.

There's almost nothing to review for me because I saw most of this
code because we were working on it, and it's available in my open
GitHub repo.
I mean, AF_XDP parts are new, that's for sure, but firstly we need
to stop {doing,rushing} things somewhere in the closets. For now,
we have THREE almost identical implementations of XDP Hints even
inside Intel, and they were born just because everyone was doing
something without any discussion or whatever, and I see no good
in such a fragmentation.
At least, that was the reason why XDP Hints mailing list and
XDP Hints workshop topic were created.

For sure, anyone is free to do whatever he wants, but I believe
letting us firstly finish the things discussed and established
and then starting to expand them to support AF_XDP and whatnot
can prevent wasting a lot of everyone's time and resources, and
keeping on reinventing the wheel again and again doesn't help
there. At all.

> Time to get coffee on my side.

I'm a tea man[iac], meh.

> Thanks,
> John

Thanks,
Al

> >
> > Thanks,
> > Al
