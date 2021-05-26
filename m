Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF2B391D13
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhEZQez (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbhEZQev (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 12:34:51 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99D2C061756
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 09:33:19 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id v9so1631308ion.11
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=BbVftaK48YdaHVtKX9+juu8gEKugExFcrFu6VvKPrJM=;
        b=hsOw9jbhTymrGne7xye7Pb/Avwz9Z0tIjfVUhFaZW5KCTYhjrnGL3M+r/7KwfSASmc
         mohQt4AYljVxvwVjCVJqIuc7mdEVdW4N5WijPu22bUeMjCgF73vmk9RaJICgjLKJkjjD
         tW8r4ufXnVINCqhXltZIVx2cRWqWdfTjqlh7OfgXqebn7/30ZStsze9ptRDvA13ZtPqX
         Ofm1BWU2lwHflqVRCvW7tvGwAgMW6/c2AKW4X0Gga7Tdd7N5bZBGHlMffPV2I/j9ZRhv
         SEXxVL8+gjHHVXWy1Oywh21An3jdPfeizgqpGwhZT3zIC/9yq5RCWFtQz4y6JepjLXjK
         dgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=BbVftaK48YdaHVtKX9+juu8gEKugExFcrFu6VvKPrJM=;
        b=uFF9i/iPeoc3/bb/ICCA8LQSw8wAyG8NWtsTKEaDs5VlNi0xiwTgMrsDr/y6h0ocAp
         zEHGodjhi8QMY5jPBBMOUfRtJ4SsZirIOJNJ5qjG4tadfdM/zrMdyhPPPjKxyPYninBC
         2CW0jlqwztxogyYh5YvRl9idFR6ADXuXBClAvawLoZlgK8Viahf5vuIssie69lo6KA8y
         ryubfpFK+swFj4bMDQ2tz3lwN3XOuQID0WvDWmR57aJ4MwqsBa926DMkvTSztsDoDGjn
         W2OxVg/BgpJlbih20sU4g8y8QeEt7ZNQQWFBM7YI2dRH2Ge9DLb+KpW32RWcGVPhMzSW
         hFWA==
X-Gm-Message-State: AOAM5311jm4a0tBiVyjba+amx38q6t/mnPtd5FP/q/7tlTMRWEksoKfx
        iGd2/3Rc8j6Qb+/LhYQoxR0=
X-Google-Smtp-Source: ABdhPJyGblA7WEQPpV7rerGV1J7Il0L6txSPM0BO/LaPxbsceAFsTPd16B5YJBoYoRMx908nHJ/MNg==
X-Received: by 2002:a5d:914a:: with SMTP id y10mr26417471ioq.156.1622046799135;
        Wed, 26 May 2021 09:33:19 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id f11sm15200090iov.9.2021.05.26.09.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:33:18 -0700 (PDT)
Date:   Wed, 26 May 2021 09:33:11 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        John Fastabend <john.fastabend@gmail.com>
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
Message-ID: <60ae7847b066e_5ff320887@john-XPS-13-9370.notmuch>
In-Reply-To: <20210526155402.172-1-alexandr.lobakin@intel.com>
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
 <87y2c1iqz4.fsf@toke.dk>
 <60ae6ad5a2e04_18bf20819@john-XPS-13-9370.notmuch>
 <20210526155402.172-1-alexandr.lobakin@intel.com>
Subject: Re: AF_XDP metadata/hints
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexander Lobakin wrote:
> From: John Fastabend <john.fastabend@gmail.com>
> Date: Wed, 26 May 2021 08:35:49 -0700
> =

> Hi all,
> =

> >Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> Jesper Dangaard Brouer <brouer@redhat.com> writes:
> >> =

> >> > On Tue, 25 May 2021 21:51:22 -0700
> >> > John Fastabend <john.fastabend@gmail.com> wrote:
> >> >
> >> >> Separate the config of hardware from the BPF infrastructure these=

> >> >> are two separate things.
> >> >
> >> > I fully agree.
> =

> It was not about hardware feature reprogramming like csumming and
> stuff, only about composing the medatada according to the prog's
> request.
> =

> >> +1. Another reason why is the case of multiple XDP programs on a sin=
gle
> >> interface: When attaching these (using freplace as libxdp does it), =
the
> >> kernel can just check the dest interface when verifying the freplace=

> >> program and any rewriting of the bytecode from the BTF format can ha=
ppen
> >> at that point. Whereas if the BPF attach needs to have side effects,=

> >> suddenly we have to copy over all the features to the dispatcher pro=
gram
> >> and do some kind of set union operation; and what happens if an frep=
lace
> >> program is attached after the fact (same thing with tail calls)?
> >> =

> >> So in my mind there's no doubt this needs to be:
> >> =

> >> driver is config'ed -> it changes its exposed BTF metadata -> progra=
m is
> >> attached -> verifier rewrites program to access metadata correctly
> >
> >Well likely libbpf would do the rewrite I think.
> =

> So your proposal is to not compose metadata according to the prog's
> request, but rather reprogram the prog itself to access metadata
> accordingly? Sounds very nice.

Correct, otherwise you end up trying to parse programs and infer what
its trying to access and I don't want that logic in the driver. Or you
have to go into the BPF core and try to get it to pass the driver metadat=
a.
And I don't want to add complexity to the BPF core bits.

> =

> If follow this path, is it something like this?
> =

> 1. Driver exposes the fields layout (e.g. Rx/Tx descriptor fields)
> via BTF to the BPF layer.

Not to the kernel BPF layer but to userspace so we can do CO-RE in
userspace before loading the program. While we learn how to use
this I expect we can just pass around a BTF file its not needed
to have the driver interface expose it as a first step.

Presumably you can generate the BTF when you configure the hardware.
I assume hardware config is close to a firmware update.

> 2. When an XDP prog is attached, BPF reprograms it to look for the
> required fields at the right offset.

User space can rewrite the fields using the existing infrastructure.
Dumb snippit,

  struct my_metadata m =3D (struct my_metadata *) data->metadata

  my_foo =3D m->foo;

Then CO-RE layer will know how to rewrite that m->foo to the right
offset into the metadata if we give it the normal CO-RE annotations.

> =

> >> =

> >> > How should we handle existing config interfaces?
> >> >
> >> > Let me give some concrete examples. Today there are multiple exist=
ing
> >> > interfaces to enable/disable NIC hardware features that change wha=
t is
> >> > available to put in our BTF-layout.
> >> >
> >> > E.g. changing if VLAN is in descriptor:
> >> >  # ethtool -K ixgbe1 rx-vlan-offload off
> >> >  # ethtool -k ixgbe1 | grep vlan-offload
> >> >  rx-vlan-offload: off
> >> >  tx-vlan-offload: on
> >> >
> >> > The timestamping features can be listed by ethtool -T (see below
> >> > signature), but it is a socket option that enable[1] these
> >> > (see SO_TIMESTAMPNS or SOF_TIMESTAMPING_RX_HARDWARE).
> >> >
> >> > Or tuning RSS hash fields:
> >> >  [2] https://github.com/stackpath/rxtxcpu/blob/master/Documentatio=
n/case-studies/observing-rss-on-ixgbe-advanced-rss-configuration-rss-hash=
-fields.md
> >> >
> >> > I assume we need to stay compatible and respect the existing confi=
g
> >> > interfaces, right?
> =

> Again, XDP Hints won't change any netdev features and stuff, only
> compose provide the hardware provided fields that are currently
> inaccessible by the XDP prog and say cpumap code, but that are
> highly needed (cpumap builds skbs without csums -> GRO layer
> consumes CPU time to calculate it manually, without RSS hash ->
> Flow Dissector consumes CPU time to calculate it manually +
> possible NAPI bucket misses etc.).

Thats a specific cpumap problem correct? In general checksums work
as expected?

> =

> So, neither Ethtool (that doesn't belong to XDP at all) nor anything
> else that changes hardware behaviour is involved.

Good.

> =

> >I'm not convinced its a strict requirement, rather its a nice to
> >have. These are low level ethtool hooks into the hardware its
> >fine IMO if the hardware just reports off and uses a more robust
> >configuration channel. In general we should try to get away from
> >this model where kernel devs are acting as the gate keepers for
> >all hardware offloads and we explicit add checkboxs that driver
> >writers can use. The result is the current state of things where
> >we have very flexible hardware that are not usable from Linux.
> >
> >> >
> >> > Should we simple leverage existing interfaces?
> >> =

> >> Now that ethtool has moved to netlink it should be quite
> >> straight-forward to add a separate subset of commands for configurin=
g
> >> metadata fields; and internally the kernel can map those to the exis=
ting
> >> config knobs, no?
> >
> >Its unclear to me how you simple expose knobs to reconfigure hardware.=

> >It looks to me that you need to push a blob down to the hardware to
> >reconfigure it for new parsers, new actions, etc. But, maybe the
> >folks working on current hardware can speak up.
> >
> >> =

> >> E.g., if you tell the kernel you'd like to have the VLAN field as a
> >> metadata field that kinda implies that rx-vlan-offload should be tur=
ned
> >> on; etc. Any reason this would break down?
> >> =

> >> -Toke
> >> =

> =

> That's right. If you want to have a VLAN tag in the medatdata, make
> sure Rx offloading is enabled. Same with csums and the rest. No
> explicit switches on prog insertion/removing.
> =

> >Agree driver should be able to map these back onto 'legacy' feature
> >sets.
> >
> >I'll still have a basic question though. I've never invested much time=

> >into the hints because its still not clear to me what the use case is?=

> >What would we put in the hints and do we have any data to show it woul=
d be
> >a performance win.
> =

> As I said, currently both XDP Rx and XDP Tx paths suffer from that
> they lack some essential info like Rx csums and hashes and e.g.
> Tx csum status. XDP Hints are about to place these fields into
> the metadata area that is located right before the frame, so either
> BPF prog or mentioned cpumap could access it.

I'm not convinced hashes and csum are so interesting but show me some
data. Also my admittedly rough understanding of cpumap is that it helps
the case where hardware RSS is not sufficient. Seeing your coming from
the Intel hardware side why not fix the RSS root problem instead
of using cpumap at all? I think your hardware is flexible enough.

I would really prefer to see example use cases that are more generic
than the cpumap case.

> =

> >If its a simple hash of the headers then how would we use it? The
> >map_lookup/updates use IP addrs for keys in Cilium. So I think the
> >suggestion is to offload the jhash operation? But that requires some
> >program changes to work. Could someone convince me?
> >
> >Maybe packet timestamp?
> >
> >Thanks,
> >John
> =

> Thanks,
> Al


