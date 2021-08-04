Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265323E0AF3
	for <lists+bpf@lfdr.de>; Thu,  5 Aug 2021 01:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhHDXqG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Aug 2021 19:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbhHDXqF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Aug 2021 19:46:05 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC7C0613D5
        for <bpf@vger.kernel.org>; Wed,  4 Aug 2021 16:45:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r1so3295250iln.6
        for <bpf@vger.kernel.org>; Wed, 04 Aug 2021 16:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ouA2CMPSPUYvZFZEcksl0J8EwjKv+2T7GwvkDONFrpE=;
        b=RBRfqJ1UL07AvrbGqOqUqLT645Q9Xi5OxLwQxKjrOt6ErFhGOC5sdqpSTnG5NxszDp
         BucMTHLaRs+amPkD11cYjblRPygK+MmwvYwNWRmWOMdE/n2bD3UClffpO5E84q9co/RP
         WsvgkDgoL+XQfG72k85c8ngePrD3jDvbf0INHUTr3GWnl8OQ/+gmi/Kp4el2765tkOeS
         gQ8UkdtcJek4gnrTHhSax7prc7hcOazQU0BSL2CIe9Hr4cU8IKhmb4V+lu3tDea2HFB0
         s3WGZW3/YBWg99F8eSE56gET5x0PUc3mKEk1RC9l50yeGmUehJJ6umgT61/4IP3wpOU7
         7VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ouA2CMPSPUYvZFZEcksl0J8EwjKv+2T7GwvkDONFrpE=;
        b=Bo03gKP+6tQnnFMFKpf+0T4tgtLFwO2jCAoJHzH0T6+EM5qqIMjdRU1Dw0NdMQFQbG
         nASeGc8sScG6yUSJEexWUUcaV8bsGaZgse2Gxv0JDSzgaHqFH1B8WIS2B/Ax6auXXk2y
         g9ef5wHQI6uZrhsFYqTDY2d5y6dTckZLis/EjgqLuvBld67CNyHKmxFWPtqUIAIJRuga
         vWu/a8xjqwiwEE/kj0uUu23iFXtsCVZw6F+R4dfBCrX5JlrF4Sj2KxhSe2dS/uJtd7t9
         k38A/RU85riwHpBAHsWW7BgsAD1RzVgTjHOp6jY9/YmDuP8yjUE/t8hUdaVkfXPELZOX
         bSzQ==
X-Gm-Message-State: AOAM531CuptC+9ZC565o6Sp8ycmZh2BAEwas35ySRMU1Ev+lbX4C3dZG
        BDRhXZqRYPLj5O6dmTmmGfg=
X-Google-Smtp-Source: ABdhPJyrkMHxRULQ46Tsg1Tlp7466gKq4qkah9vjiTYNBs58veW5ObkdGrTiRElkpf2kLPn1IYfqtA==
X-Received: by 2002:a05:6e02:1a05:: with SMTP id s5mr407317ild.232.1628120752031;
        Wed, 04 Aug 2021 16:45:52 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id j10sm2369147iop.16.2021.08.04.16.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:45:51 -0700 (PDT)
Date:   Wed, 04 Aug 2021 16:45:45 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Marcin Kubiak <marcin.kubiak@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@intel.com>,
        Ederson de Souza <ederson.desouza@intel.com>,
        xdp-hints@xdp-project.net, bpf@vger.kernel.org
Message-ID: <610b26a97231f_10ef420863@john-XPS-13-9370.notmuch>
In-Reply-To: <20210804151555.287-1-alexandr.lobakin@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
 <20210803091238.102-1-alexandr.lobakin@intel.com>
 <61095f7843aaa_66240208e6@john-XPS-13-9370.notmuch>
 <20210804151555.287-1-alexandr.lobakin@intel.com>
Subject: Re: [[RFC xdp-hints] 00/16] XDP hints and AF_XDP support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexander Lobakin wrote:
> From: John Fastabend <john.fastabend@gmail.com>
> Date: Tue, 03 Aug 2021 08:23:36 -0700
> 
> > Alexander Lobakin wrote:
> > > From: Ederson de Souza <ederson.desouza@intel.com>
> > > Date: Mon,  2 Aug 2021 18:03:15 -0700
> > >
> > > > While there's some work going on different aspects of the XDP hints, I'd like
> > > > to present and ask for comments on this patch series.
> > > >
> > > > XDP hints/metadata is a way for the driver to transmit information regarding a
> > > > specific XDP frame along with the frame. Following current discussions and
> > > > based on top of Saeed's early patches, this series provides the XDP hints with
> > > > one (or two, depending on how you view it) use case: RX/TX timestamps for the
> > > > igc driver.
> > > >
> > > > Keeping with Saeed's patches, to enable XDP hints usage, one has to first
> > > > enable it with bpftool like:
> > > >
> > > >   bpftool net xdp set dev <iface> md_btf on
> > > >
> > > > >From the driver perspective, support for XDP hints is achieved by:
> > > >
> > > >  - Adding support for XDP_SETUP_MD_BTF operation, where it can register the BTF.
> > > >
> > > >  - Adding support for XDP_QUERY_MD_BTF so user space can retrieve the BTF id.

Its still unclear to me why BTF id is being passed around.

> > > >
> > > >  - Adding the relevant data to the metadata area of the XDP frame.
> > > >
> > > >     - One of this relevant data is the BTF id of the BTF in use.
> > > >
> > > > In order to make use of the BPF CO-RE mechanism, this series makes the driver
> > > > name of the struct for the XDP hints be called `xdp_hints___<driver_name>` (in
> > > > this series, as I'm using igc driver, it becomes `xdp_hints___igc`). This
> > > > should help BPF programs, as they can simply refer to the struct as `xdp_hints`.
> > > >
> > > > A common issue is how to standardize the names of the fields in the BTF. Here,
> > > > a series of macros is provided on the `include/net/xdp.h`, that goes by
> > > > `XDP_GENERIC_` prefixes. In there, the `btf_id` field was added, that needs
> > > > to be strategically positioned at the end of the struct. Also added are the
> > > > `rx_timestamp` and  `tx_timestamp` fields, as I believe they're generic as
> > > > well. The macros also provide `u32` and `u64` types. Besides, I also ended
> > > > up adding a `valid_map` field. It should help whoever is using the XDP hints
> > > > to be sure of what is valid in that hints. It also makes the driver life
> > > > simple, as it just uses a single struct and validates fields as it fills
> > > > them.
> > > >
> > > > The BPF sample `xdp_sample_pkts` was modified to demonstrate the usage of XDP
> > > > hints on BPF programs. It's a very simple example, but it shows some nice
> > > > things about it. For instance, instead of getting the struct somehow before,
> > > > it uses CO-RE to simply name the XDP hint field it's interested in and
> > > > read it using `BPF_CORE_READ`. (I also tried to use `bpf_core_field_exists` to
> > > > make it even more dynamic, but couldn't get to build it. I mention why in the
> > > > example.)
> > > >
> > > > Also, as much of my interest lies in the user space side, the one using
> > > > AF_XDP, to support it a few additional things were done.
> > > >
> > > > Firstly, a new "driver info" is provided, to be obtained via
> > > > `ioctl(SIOCETHTOOL)`: "xdp_headroom". This is how much XDP headroom is
> > > > required by the driver. While not really important for the RX path (as the
> > > > driver already applies that headroom to the XDP frame), it's
> > > > important for the TX path, as here, it's the application responsibility to
> > > > factor in the XDP headroom area. (Note that the TX timestamp is obtained from
> > > > the XDP frame of the transmitted packet, when that frame goes back to the
> > > > completion queue.)
> > > >
> > > > A series of helpers was also added to libbpf to help manage this headroom
> > > > area. They go by the prefix " xsk_umem__adjust_", to adjust consumer and
> > > > producer data and metadata.
> > > >
> > > > In order to read the XDP hints from the memory, another series of helpers was
> > > > added. They read the BTF from the BTF id, and create a hashmap of the offsets
> > > > and sizes of the fields, that is then used to actually retrieve the data.
> > > >
> > > > I modified the "xdpsock" example to show the use of XDP hints on the AF_XDP
> > > > world, along with the proposed API.
> > > >
> > > > Finally, I know that Michal and Alexandr (and probably others that I don't
> > > > know) are working in this same front. This RFC is not to race any other work,
> > > > instead I hope it can help in the discussion of the best solution for the
> > > > XDP hints and I truly think it brings value, specifically for the AF_XDP
> > > > usages.
> > >
> > > XDP Hints have been discussed on Netdev 0x15, and we kinda
> > > established the optimal way for doing it. This RFC's approach
> > > is not actual anymore.
> > 
> > Its great it was discussed, but you need to also summarize it
> > on the list. Give us the conclusion, who came to it, and why
> > its better then this proposal or whats wrong with this proposal.
> > Not everyone was in the discussion and here we
> > have a concrete proposal _with_ code. You can't just out of hand
> > throw it out based on a conference discussion.
> 
> The conclusion was:
>  * no need to register BTF from drivers themselves, they can be
>    obtained through sysfs interface;

This would put the BTF info in '/sys/kernel/btf/driver_name' correct?
Likely good enough for static configs, but this will only work
for static hardware? Dynamic changes would need another mechanism
to learn BTF? My view on this is if you reprogram the hardware that
tooling should also give you a BTF file so its not a kernel
problem. Think P4 compiler spits out a firmware image and BTF file.

>  * the verifier has nothing to do with Hints and stuff, BTF ID
>    just gets passed along with the other XDP Prog setup flags;

Its not clear why the BTF ID needs to be passed at all. Can
someone elaborate? What would XDP do with the ID?

I get on redirect you don't know the xdp hints layout from
where the program came from? Do you plan to write programs
like this,

  if (btf_id == 0xfoo) { do something }
  else if (btf_id == 0xe00) { do other thing}

Other way is to sanitize meta data on input program. But,
OK assume you want to pivot on btf_id.  What does passing
the BTF ID down with the XDP prog setup have to do with the
above? A driver can probably just get its own BTF_ID and
no need to pass it down via XDP prog setup.


>  * no if-else ladders or loops when preparing a metadata, only
>    a couple of paths to satisfy generic needs (first of all)
>    and some sort of extended structure if needed;

Not sure I follow. I assume here the "hints" are put into the
metadata as a first iteration. If this is correct I expect
with BTF info and normal CO-RE logic nothing new should be needed.

If you want to put the metadata in a page somewhere else then
you need some way to patch code to point at that. A map would
work here. But, I think best approach is to first use the
metadata space.

>  * the first two users of the feature will be veth and cpumap.

Sure, I think its sufficient to have a BPF program use the
hints. Getting the connection into veth/cpumap seems like
extra, step 2 after a base driver supports putting hints in
the metadata block.

> 
> This greatly simplifies the code and the hotpath.

Sure I suspect for a first iteration "all" thats needed is a
driver/hardware to populate the metadata with hints and
expose a BTF file for the BPF program can use.

> 
> It was decided by Jesper, Toke, Lorenzo, Michal, me, and several
> more attendees (sorree if I forgot someone).

Great.

> 
> > > You could just write to me and request write perms on our open
> > > GitHub repo (which was mentioned here several times) for Hints
> > > to do things if not together, then in one place at least.
> > > I'll be off for two weeks since next Monday, Michal could get
> > > you into things if you decide to join after than point
> > > (if at all).
> > 
> > I'll review code thats posted on the list. Please
> > do the same or give us a _reason_ to skip it. It has a nice commit
> > message that on the face looks like a reasonable starting point
> > even if I have a few issues with the aproach in a couple spots.
> 
> There's almost nothing to review for me because I saw most of this
> code because we were working on it, and it's available in my open
> GitHub repo.

OK. It looks to me that a feature flag to enable/disable
hints is going to be useful? If this has overhead in the
driver to do the copy or overhead on the bus to push the
data around then we want to turn it on/off. An ethtool feature
flag would be sufficient.

> I mean, AF_XDP parts are new, that's for sure, but firstly we need
> to stop {doing,rushing} things somewhere in the closets. For now,
> we have THREE almost identical implementations of XDP Hints even
> inside Intel, and they were born just because everyone was doing
> something without any discussion or whatever, and I see no good
> in such a fragmentation.
> At least, that was the reason why XDP Hints mailing list and
> XDP Hints workshop topic were created.

My only objection is, off-list discussions need to land eventually
on the list as well. If someone submits a series of patches we
can't/shouldn't tell them its already been decided in some other
private discussion without providing the conclusions of that
discussion giving the sender a chance to debate it. I think above
summary in the initial reply would have been sufficient and I
wouldn't have even commented on it. And by giving the summary
now its clear to me as well whats being worked on.

Thanks,
John

> 
> For sure, anyone is free to do whatever he wants, but I believe
> letting us firstly finish the things discussed and established
> and then starting to expand them to support AF_XDP and whatnot
> can prevent wasting a lot of everyone's time and resources, and
> keeping on reinventing the wheel again and again doesn't help
> there. At all.
> 
> > Time to get coffee on my side.
> 
> I'm a tea man[iac], meh.
> 
> > Thanks,
> > John
> 
> Thanks,
> Al
> 
> > >
> > > Thanks,
> > > Al


