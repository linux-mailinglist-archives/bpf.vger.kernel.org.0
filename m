Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE7F390FD0
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 06:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhEZExF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 00:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhEZExF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 00:53:05 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F7C061574
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 21:51:33 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o9so30254846ilh.6
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 21:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=JCuLQv8Odz3nBc9uNZ15g4jd4QuHS8/CACXRAnQEQC8=;
        b=RZwBnsTlulhvF1zDt5DXfUVwR5fwvbFzT9DXoPhzA4uZBkCLhFmT59GIFlKysM+dxR
         GYaiKyOvezr3t+5MSMTFHQ0aYqIukruQz7oJAwSVDdiQpwLe4efw/WfCkYx27GsB41D7
         oxoKcVroyN4jJHXM73B7kAvTD0LXUIX2ajD4CipzK1WNyVlgbMuoFRMmaG2UfSAoFo1A
         7rrZRvgEZitcDaBKgl++Mac0fTmM0esOvHOp8//yyQaur/tNsgVtKAhzfc2yudu8MnFA
         ry0uCTbJw//kDTgM1Zx63GSrJllydv7AeUU9fe6bkeYDfFxTw+TdOih1hg/EMAP3aaGV
         BzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=JCuLQv8Odz3nBc9uNZ15g4jd4QuHS8/CACXRAnQEQC8=;
        b=sKU5MY7nGMUGyLM3B2cTEkcj6Ab/ad4J7CZUJ/NEEHNO9Eyy/uYqy+oFAbo2esdrcV
         qO1r6Di+1n6iJ/cYlIz4p4eRhcbl01miPs8rOCNqjxnQBshT8o6I62iGwZtuB303aS0M
         llR4YFTNrEwWvmvyEoAh9P8yg9AgOHVUIJ9vQUEsmGUsDG5Dzm4Om8gLSY4H5YaIzk10
         7ldakdww5Yg29Fwo2zAVwAcbEh6tq/ZtAX1NmsFhLN479S8HVCgZUgKpeA57x/+cSb8q
         hRes1rFk23wZtiFKCYjBSA9S4e8myp27Ste2DtQK5jH3ZGYgpBAvZLDNx7f19jUcb02C
         tM6Q==
X-Gm-Message-State: AOAM530mOIRD14eC/WnwP2g03F05pnyNLsrDybLEUKLOPhaYe7pC4376
        mGL83uAqzUjultlMoG2NRbg=
X-Google-Smtp-Source: ABdhPJzdDPBqP6elOR5wML2Vdh5qNDBLJHnRJhaD/Tta7v5P1udDVtNgjTKXFvOAnO063ncAK7tXaw==
X-Received: by 2002:a92:d38d:: with SMTP id o13mr21581082ilo.45.1622004692258;
        Tue, 25 May 2021 21:51:32 -0700 (PDT)
Received: from localhost ([172.242.244.146])
        by smtp.gmail.com with ESMTPSA id y15sm14153609ila.3.2021.05.25.21.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 21:51:31 -0700 (PDT)
Date:   Tue, 25 May 2021 21:51:22 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Saeed Mahameed <saeed@kernel.org>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
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
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, bpf@vger.kernel.org
Message-ID: <60add3cad4ef0_3b75f2086@john-XPS-13-9370.notmuch>
In-Reply-To: <20210525142027.1432-1-alexandr.lobakin@intel.com>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com>
 <DM6PR11MB2780A8C5410ECB3C9700EAB5CA579@DM6PR11MB2780.namprd11.prod.outlook.com>
 <PH0PR11MB487034313697F395BB5BA3C5E4579@PH0PR11MB4870.namprd11.prod.outlook.com>
 <DM4PR11MB5422733A87913EFF8904C17184579@DM4PR11MB5422.namprd11.prod.outlook.com>
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
Subject: Re: AF_XDP metadata/hints
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexander Lobakin wrote:
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Date: Sun, 23 May 2021 13:54:47 +0200
> =

> > Saeed Mahameed <saeed@kernel.org> writes:
> > =

> > > On Fri, 2021-05-21 at 15:31 +0200, Jesper Dangaard Brouer wrote:
> > >> On Fri, 21 May 2021 10:53:40 +0000
> > >> "Lobakin, Alexandr" <alexandr.lobakin@intel.com> wrote:
> > >>
> > >> > I've opened two discussions at https://github.com/alobakin/linux=
,
> > >> > feel free to join them and/or create new ones to share your thou=
ghts
> > >> > and concerns.
> > >>
> > >> Thanks Alexandr for keeping the thread/subject alive.
> > >>
> > >> I guess this is a new GitHub features "Discussions".  I've never u=
sed
> > >> that in a project before, lets see how this goes.  The usual appro=
ach
> > >> is discussions over email on netdev (Cc. netdev@vger.kernel.org).
> > >
> > > I agree we need full visibility and transparency, i actually recomm=
end:
> > > bpf@vger.kernel.org
> > =

> > +1, please keep this on the list :)
> =

> Sure, let's keep it the classic way.
> I removed the netdev ML from the CCs and added bpf there.
> =

> Regarding the comments from GitHub discussions:
> =

> alobakin:
> =

> > Since 5.11, it's now possible to obtain a BTF not only for vmlinux,
> > but also for modules.
> > This will eliminate a need for manually composing and registering a
> > BTF inside the driver code, which is 100+ locs for ice for example.
> > =

> > That's obviously not the most straightforward and trivial way, but
> > could help a lot.
> =

> saeedtx:
> =

> > the point of registering BTF directly from the driver is to allow

There is no paticular reason the BTF has to come from the driver it
could also be generated in userspace or elsewhere. The driver is
handy because at least the driver should always have correct BTF so
you avoid versioning to some extent.

> > "Flex metadata" meaning that meta data format can be constructed on
> > the fly according to user demand.

How is flex metadata configured? I believe this is going to need
some user tooling and a hard reset (ucode load?) in the driver to
transition the hardware state.

My original vision was use P4 (or whatever language) to build
your necessary microcode/firmware/blob. Compile that to your
specific hardware backend NIC. That process should give you
two objects. The BTF and the blob to throw at the hardware.
Letting the driver expose the BTF over /sys/fs/btf/driver.btf
makes a lot of sense as well, but is not strictly necessary
as long as you have some way to get the BTF.

Anyways from a design side IMO hardware configuration should be
done independent of any BPF/BTF operations.

> > BTF for modules is constructed only at compilation time and
> > registered only on module load. so there is no way to implement flex
> > metadata with vmlinux BTF. we still need a dynamic registration API
> > for current and future HW where the HW will provide the BTF
> > dynamically.

+1 can we expose it in /sys/fs/btf/ seems like the reasonable
thing to me.

> > =

> > I am sure we can find mutliple ways to reduce the 100+ LOC, but the
> > goal is to have the dynamic btf_register/unregister API
> =

> We initially planned to register just one (or several) predefined
> BTF(s) per module/netdevice that would provide a full list of
> supported fields. The flexibility of metadata then is in that BPF
> core calls for netdevice's ndo_bpf() on BPF program setup and
> provides a metadata layout requested by that BPF prog to the driver,

I don't think this is the right direction. The driver should be
telling us whats supported or we should "just" know because we
configured it. Overloading ndo_bpf with the config step
seems unnecessarily complex. CO-RE is going to happen way before
we even get to the ndo_bpf() so trying to decide layout this
late is likely not going to work. How would you even know what
to do with a load op?

> so it could configure its hotpath (current NICs) or a hardware
> (future NICs) to build metadata accordingly.
> Driver can declare several BTFs (e.g. a "generic" one with things
> like hashes and csums one and a custom one) and it would work either
> through dynamic registering or through /sys approach.

IMO driver needs to expose one single BTF image of what CO-RE ops
need to be done on a object.

Separate the config of hardware from the BPF infrastructure these
are two separate things.

> =

> This is all discussable anyways, we're happy to hear different
> opinions and thoughts to collectively choose the optimal way.
> =

> > -Toke
> =

> Thanks,
> Al=
