Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8165391C3B
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhEZPnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhEZPnH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 11:43:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C8DC061574
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 08:41:35 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k132so1470324iof.4
        for <bpf@vger.kernel.org>; Wed, 26 May 2021 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EuybxrBKe7aI5kyanuixDsOl6UTGiPfKKduvMOgDR9E=;
        b=XwFYG/cLi3EuMHVEDwu7Yt6R0wlWteOXRTdsXekiJkwHuqbM2LG7ztO3WfdzEg0BEE
         Vr3LSbNf/uC/DAIcck9LkxcOkW1OXkZeQNJOk/a+bThgprHq+T7YcKiUtGMqaqum54JW
         Hw7A4X5dM15jmXSyEvNthm47/MNPuKtNIKHZDJrdQQfnB0qpKhwrC/6RbXXtMIDZPzGF
         ejOg53webGaCT1lECwPmKecNy2ECJmyAhTV64JWiX/hJELVh+ar47C6b2DJOETMCNVfC
         4pjMmV1rlJPkcGcJOgL++kb2ORVJnwAbYIta73QFxEOSufnFeaE2vPmu6vSiXdCAlxUA
         r+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EuybxrBKe7aI5kyanuixDsOl6UTGiPfKKduvMOgDR9E=;
        b=UjbL3tDy4bzY6i793cp5DoYRHg4vtNUKubjeDFQk0b6OnUAzbqEalLb53AyxHOJp3v
         SgRAZwKNNduBtAfO56yAl23CTkaIWoHL8YMQyCy5uQS7R9+URJD/CXQmqGlTbAofEcvW
         HFDGeZ3Fy6pBw49QrV8lSoGdU3l72vxX7JnY5hMTAlHy/dJB8rOtFF9+GjS11i6l4/7g
         S1BcdM0+WTMqhXaIJegkSmPQ7V1uslqg1jUZgodOT8E+kslH0T3moMa8+CdlQZ5T7VTK
         50thjSKo5yepmN+uGaSFA/oCguurPmtZjQ68l5vSS+9oznwCDUKPfxLRZN1T0SlnSS95
         lI/A==
X-Gm-Message-State: AOAM5310MtiCSlVI3DE02SbWdF70bVeuYySeWXft9vMilQNgZgZrzpHI
        8pMc4ZpzWVYip6la/712UJY=
X-Google-Smtp-Source: ABdhPJzXytwIpWdFrirF/Dbyp3HZ+48BzSeiM9WN88zeBd2Asl8MqUOVjw7aOSoBKLHm+roFQ17sxQ==
X-Received: by 2002:a02:a316:: with SMTP id q22mr3759904jai.26.1622043693973;
        Wed, 26 May 2021 08:41:33 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id k8sm13442182iov.53.2021.05.26.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 08:41:33 -0700 (PDT)
Date:   Wed, 26 May 2021 08:41:27 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
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
Message-ID: <60ae6c2753a21_18bf208b0@john-XPS-13-9370.notmuch>
In-Reply-To: <60ae6ad5a2e04_18bf20819@john-XPS-13-9370.notmuch>
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
Subject: Re: AF_XDP metadata/hints
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend wrote:
> Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Jesper Dangaard Brouer <brouer@redhat.com> writes:
> > =

> > > On Tue, 25 May 2021 21:51:22 -0700
> > > John Fastabend <john.fastabend@gmail.com> wrote:
> > >
> > >> Separate the config of hardware from the BPF infrastructure these
> > >> are two separate things.
> > >
> > > I fully agree.
> > =

> > +1. Another reason why is the case of multiple XDP programs on a sing=
le
> > interface: When attaching these (using freplace as libxdp does it), t=
he
> > kernel can just check the dest interface when verifying the freplace
> > program and any rewriting of the bytecode from the BTF format can hap=
pen
> > at that point. Whereas if the BPF attach needs to have side effects,
> > suddenly we have to copy over all the features to the dispatcher prog=
ram
> > and do some kind of set union operation; and what happens if an frepl=
ace
> > program is attached after the fact (same thing with tail calls)?
> > =

> > So in my mind there's no doubt this needs to be:
> > =

> > driver is config'ed -> it changes its exposed BTF metadata -> program=
 is
> > attached -> verifier rewrites program to access metadata correctly
> =

> Well likely libbpf would do the rewrite I think.
> =

> > =

> > > How should we handle existing config interfaces?
> > >
> > > Let me give some concrete examples. Today there are multiple existi=
ng
> > > interfaces to enable/disable NIC hardware features that change what=
 is
> > > available to put in our BTF-layout.
> > >
> > > E.g. changing if VLAN is in descriptor:
> > >  # ethtool -K ixgbe1 rx-vlan-offload off
> > >  # ethtool -k ixgbe1 | grep vlan-offload
> > >  rx-vlan-offload: off
> > >  tx-vlan-offload: on
> > >
> > > The timestamping features can be listed by ethtool -T (see below
> > > signature), but it is a socket option that enable[1] these
> > > (see SO_TIMESTAMPNS or SOF_TIMESTAMPING_RX_HARDWARE).
> > >
> > > Or tuning RSS hash fields:
> > >  [2] https://github.com/stackpath/rxtxcpu/blob/master/Documentation=
/case-studies/observing-rss-on-ixgbe-advanced-rss-configuration-rss-hash-=
fields.md
> > >
> > > I assume we need to stay compatible and respect the existing config=

> > > interfaces, right?
> =

> I'm not convinced its a strict requirement, rather its a nice to
> have. These are low level ethtool hooks into the hardware its
> fine IMO if the hardware just reports off and uses a more robust
> configuration channel. In general we should try to get away from
> this model where kernel devs are acting as the gate keepers for
> all hardware offloads and we explicit add checkboxs that driver
> writers can use. The result is the current state of things where
> we have very flexible hardware that are not usable from Linux.
> =

> > >
> > > Should we simple leverage existing interfaces?
> > =

> > Now that ethtool has moved to netlink it should be quite
> > straight-forward to add a separate subset of commands for configuring=

> > metadata fields; and internally the kernel can map those to the exist=
ing
> > config knobs, no?
> =

> Its unclear to me how you simple expose knobs to reconfigure hardware.
> It looks to me that you need to push a blob down to the hardware to
> reconfigure it for new parsers, new actions, etc. But, maybe the
> folks working on current hardware can speak up.
> =

> > =

> > E.g., if you tell the kernel you'd like to have the VLAN field as a
> > metadata field that kinda implies that rx-vlan-offload should be turn=
ed
> > on; etc. Any reason this would break down?
> > =

> > -Toke
> > =

> =

> Agree driver should be able to map these back onto 'legacy' feature
> sets.
> =

> I'll still have a basic question though. I've never invested much time
> into the hints because its still not clear to me what the use case is?
> What would we put in the hints and do we have any data to show it would=
 be
> a performance win.
> =

> If its a simple hash of the headers then how would we use it? The
> map_lookup/updates use IP addrs for keys in Cilium. So I think the
> suggestion is to offload the jhash operation? But that requires some
> program changes to work. Could someone convince me?
> =

> Maybe packet timestamp?
> =

> Thanks,
> John

Also I'll add before we add any code to the kernel for this we should hav=
e
a fully working hardware workflow. We don't actually need any kernel bits=

to do above today.

I driver simply needs to generate a BTF file along with the hardware
configuration (firmware update is fine for hard update) and users could
start to use hints. libbpf knows how to work with BTF and exposing the
BTF through /sys/fs/ is just a nice to have.

.John=
