Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E903DF151
	for <lists+bpf@lfdr.de>; Tue,  3 Aug 2021 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhHCPX4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Aug 2021 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbhHCPXz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Aug 2021 11:23:55 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6E4C061757
        for <bpf@vger.kernel.org>; Tue,  3 Aug 2021 08:23:44 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h1so24669405iol.9
        for <bpf@vger.kernel.org>; Tue, 03 Aug 2021 08:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uaKSPJ+qaNNa7hrbMYaC3dBqH7DJkJzltJfxtMmep60=;
        b=m06/VBGc41Y7uk+R/BfIlZQMh+TERoD81cRzAqZaKxTm7OEBAR5Uwy6P8E07qaaJr1
         uQ+5sVm2mD8KY00Xl9KTz9vZ+ipRsyDnnwP0Jqr+V7PexL/TU6gOY5oGfFlDtpzDTrsK
         tHdtNeAOUhCjSSxQikBoaxBPqojSWkPZWXwPcJSY+Nn2SbijB6gKe43V2EzjsW9nZmt4
         FW5/IRR+94+iGp2zRQAuAZN4+YCIZeQG2T25RxU1bagjxrwq2KFav/+1mRF9otPkt3XV
         duISxvvwerGIAJupZonF7ZIrKDmcxp5dJUgOG0ivhdZJ93KXBFFQOId06WW6MbB9ZvyZ
         eCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uaKSPJ+qaNNa7hrbMYaC3dBqH7DJkJzltJfxtMmep60=;
        b=cMCkAvkz+oiM39HQEXxYX8qqizKJRk1d6U5MD9BhjX79iYmqom4UYg4L97o7+Uu25F
         jFb6LUXrTJ2WR+LNBMk/dFaFHUw11w61AtMxiJie1/fTApmHu1sIH8yn2KRgneKeFXgb
         WYR+D5HRu+HYomJMzLP/mQ38sjPdHZI+Xi3c41FEBOyV2yfjlrLMslTBXqnsV7yM9KK0
         d2n2sL2EcpNmwGebiIuacP8tUjw5/mNVoJrqS+GGAxz35W/73K/m+Yj4VI9Phs01XXjR
         SD9jA3vKa0CI8JBHf9cOxv8bEnqCq4kDaXfcG63EU4S2WSvrW/P2VOQmNOHLWJbBGmr0
         acvA==
X-Gm-Message-State: AOAM532PJxYgE/bHRC9dJn2boB3AptmQT8Hx0CgZeckBz02ayO4kajYV
        zflqqlfRoF9secDIkSGRLlo=
X-Google-Smtp-Source: ABdhPJzxuRW1u47+imiT+kZPiHY9jh/urCspJloAvMVtGhjcqWOpu1tMQAqUAHJ4U7Zq4CuMnlGz8g==
X-Received: by 2002:a05:6638:e92:: with SMTP id p18mr3058779jas.57.1628004223606;
        Tue, 03 Aug 2021 08:23:43 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id t11sm7591893ilp.66.2021.08.03.08.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:23:43 -0700 (PDT)
Date:   Tue, 03 Aug 2021 08:23:36 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Ederson de Souza <ederson.desouza@intel.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        xdp-hints@xdp-project.net, bpf@vger.kernel.org
Message-ID: <61095f7843aaa_66240208e6@john-XPS-13-9370.notmuch>
In-Reply-To: <20210803091238.102-1-alexandr.lobakin@intel.com>
References: <20210803010331.39453-1-ederson.desouza@intel.com>
 <20210803091238.102-1-alexandr.lobakin@intel.com>
Subject: Re: [[RFC xdp-hints] 00/16] XDP hints and AF_XDP support
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexander Lobakin wrote:
> From: Ederson de Souza <ederson.desouza@intel.com>
> Date: Mon,  2 Aug 2021 18:03:15 -0700
> =

> > While there's some work going on different aspects of the XDP hints, =
I'd like
> > to present and ask for comments on this patch series.
> > =

> > XDP hints/metadata is a way for the driver to transmit information re=
garding a
> > specific XDP frame along with the frame. Following current discussion=
s and
> > based on top of Saeed's early patches, this series provides the XDP h=
ints with
> > one (or two, depending on how you view it) use case: RX/TX timestamps=
 for the
> > igc driver.
> > =

> > Keeping with Saeed's patches, to enable XDP hints usage, one has to f=
irst
> > enable it with bpftool like:
> > =

> >   bpftool net xdp set dev <iface> md_btf on
> > =

> > >From the driver perspective, support for XDP hints is achieved by:
> > =

> >  - Adding support for XDP_SETUP_MD_BTF operation, where it can regist=
er the BTF.
> > =

> >  - Adding support for XDP_QUERY_MD_BTF so user space can retrieve the=
 BTF id.
> > =

> >  - Adding the relevant data to the metadata area of the XDP frame.
> > =

> >     - One of this relevant data is the BTF id of the BTF in use.
> > =

> > In order to make use of the BPF CO-RE mechanism, this series makes th=
e driver
> > name of the struct for the XDP hints be called `xdp_hints___<driver_n=
ame>` (in
> > this series, as I'm using igc driver, it becomes `xdp_hints___igc`). =
This
> > should help BPF programs, as they can simply refer to the struct as `=
xdp_hints`.
> > =

> > A common issue is how to standardize the names of the fields in the B=
TF. Here,
> > a series of macros is provided on the `include/net/xdp.h`, that goes =
by
> > `XDP_GENERIC_` prefixes. In there, the `btf_id` field was added, that=
 needs
> > to be strategically positioned at the end of the struct. Also added a=
re the
> > `rx_timestamp` and  `tx_timestamp` fields, as I believe they're gener=
ic as
> > well. The macros also provide `u32` and `u64` types. Besides, I also =
ended
> > up adding a `valid_map` field. It should help whoever is using the XD=
P hints
> > to be sure of what is valid in that hints. It also makes the driver l=
ife
> > simple, as it just uses a single struct and validates fields as it fi=
lls
> > them.
> > =

> > The BPF sample `xdp_sample_pkts` was modified to demonstrate the usag=
e of XDP
> > hints on BPF programs. It's a very simple example, but it shows some =
nice
> > things about it. For instance, instead of getting the struct somehow =
before,
> > it uses CO-RE to simply name the XDP hint field it's interested in an=
d
> > read it using `BPF_CORE_READ`. (I also tried to use `bpf_core_field_e=
xists` to
> > make it even more dynamic, but couldn't get to build it. I mention wh=
y in the
> > example.)
> > =

> > Also, as much of my interest lies in the user space side, the one usi=
ng
> > AF_XDP, to support it a few additional things were done.
> > =

> > Firstly, a new "driver info" is provided, to be obtained via
> > `ioctl(SIOCETHTOOL)`: "xdp_headroom". This is how much XDP headroom i=
s
> > required by the driver. While not really important for the RX path (a=
s the
> > driver already applies that headroom to the XDP frame), it's
> > important for the TX path, as here, it's the application responsibili=
ty to
> > factor in the XDP headroom area. (Note that the TX timestamp is obtai=
ned from
> > the XDP frame of the transmitted packet, when that frame goes back to=
 the
> > completion queue.)
> > =

> > A series of helpers was also added to libbpf to help manage this head=
room
> > area. They go by the prefix " xsk_umem__adjust_", to adjust consumer =
and
> > producer data and metadata.
> > =

> > In order to read the XDP hints from the memory, another series of hel=
pers was
> > added. They read the BTF from the BTF id, and create a hashmap of the=
 offsets
> > and sizes of the fields, that is then used to actually retrieve the d=
ata.
> > =

> > I modified the "xdpsock" example to show the use of XDP hints on the =
AF_XDP
> > world, along with the proposed API.
> > =

> > Finally, I know that Michal and Alexandr (and probably others that I =
don't
> > know) are working in this same front. This RFC is not to race any oth=
er work,
> > instead I hope it can help in the discussion of the best solution for=
 the
> > XDP hints =E2=80=93 and I truly think it brings value, specifically f=
or the AF_XDP
> > usages.
> =

> XDP Hints have been discussed on Netdev 0x15, and we kinda
> established the optimal way for doing it. This RFC's approach
> is not actual anymore.

Its great it was discussed, but you need to also summarize it
on the list. Give us the conclusion, who came to it, and why
its better then this proposal or whats wrong with this proposal.
Not everyone was in the discussion and here we
have a concrete proposal _with_ code. You can't just out of hand
throw it out based on a conference discussion.

> You could just write to me and request write perms on our open
> GitHub repo (which was mentioned here several times) for Hints
> to do things if not together, then in one place at least.
> I'll be off for two weeks since next Monday, Michal could get
> you into things if you decide to join after than point
> (if at all).

I'll review code thats posted on the list. Please
do the same or give us a _reason_ to skip it. It has a nice commit
message that on the face looks like a reasonable starting point
even if I have a few issues with the aproach in a couple spots.

Time to get coffee on my side.

Thanks,
John

> =

> Thanks,
> Al=
