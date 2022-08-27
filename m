Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644365A3980
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 20:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiH0SeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiH0Sd7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 14:33:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B135D0E8;
        Sat, 27 Aug 2022 11:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 691E3B80954;
        Sat, 27 Aug 2022 18:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029E9C433D6;
        Sat, 27 Aug 2022 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661625236;
        bh=/NvqMNlMMMZh2DEN0iNd6M5/LOZOI2/sUhRc7iJiwjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yw1so9lv46qaHCIQ6XSOTWHoL4ddxIVpCEh9Z6NmyoKw7ID0TEhS+K6hEh2qPNZQ7
         fNGXra5LUK7lGjB//e29fxFU9p84tEv6gCsHrNp4GV+/FSoNUTn826+R+H3FpRLoc4
         bwrjnAUwBkkn46bGT6xEorbbB01i30psE6Jyg7YuHrbhEXB5i1EWUzjFJJOF96Qj3D
         405TJblArwjb7wKtsz1CkdE+4XsKmte9YW6jSG7jpHDKax2fY69KlHoFFkHt2XKTCs
         EAunn4A7kcDX1RpIEjS/AXhHfsoX4Kiw6TtiIksVs1F7hL63S4tyE31s4vubgpFe0D
         RJWP/hQZMX7tw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42D48404A1; Sat, 27 Aug 2022 15:33:53 -0300 (-03)
Date:   Sat, 27 Aug 2022 15:33:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pahole v1.24: FAILED: load BTF from vmlinux: Invalid argument
Message-ID: <YwpjkbMkgDIufjtO@kernel.org>
References: <20220825163538.vajnsv3xcpbhl47v@altlinux.org>
 <CA+JHD904e2TPpz1ybsaaqD+qMTDcueXu4nVcmotEPhxNfGN+Gw@mail.gmail.com>
 <20220825171620.cioobudss6ovyrkc@altlinux.org>
 <20220826025220.cxfwwpem2ycpvrmm@altlinux.org>
 <20220826025944.hd7htqqwljhse6ht@altlinux.org>
 <YwjQDBovX+cX/JDJ@krava>
 <Ywj2xCPATz1qb0lC@kernel.org>
 <20220827173310.o6sv2ugl6taul6og@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827173310.o6sv2ugl6taul6og@altlinux.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sat, Aug 27, 2022 at 08:33:10PM +0300, Vitaly Chikunov escreveu:
> On Fri, Aug 26, 2022 at 01:37:24PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Aug 26, 2022 at 03:52:12PM +0200, Jiri Olsa escreveu:
> > > On Fri, Aug 26, 2022 at 05:59:44AM +0300, Vitaly Chikunov wrote:
> > > > >   [    0.767649] Run /init as init process
> > > > >   [    0.770858] BPF:[593] ENUM perf_event_task_context
> > > > >   [    0.771262] BPF:size=4 vlen=4
> > > > >   [    0.771511] BPF:
> > > > >   [    0.771680] BPF:Invalid btf_info kind_flag
> > > > >   [    0.772016] BPF:

> > > I can see the same on 5.15, it looks like the libbpf change that
> > > pahole is compiled with is setting the type's kflag for values < 0:
> > > (which is the case for perf_event_task_context enum first value)

> > >   dffbbdc2d988 libbpf: Add enum64 parsing and new enum64 public API

> > > but IIUC kflag should stay zero for normal enum otherwise the btf meta
> > > verifier screams

> > > if I compile pahole with the libbpf change below I can boot 5.15 kernel
> > > normally

> > > Yonghong, any idea?

> > This made me try to build pahole with the system libbpf instead of with
> > the one that goes with it, here, testing with libbpf 0.7.0 it wasn't
> > building as BTF_KIND_ENUM64 came with libbpf 1.0 so I added the
> > following patch to again allow with the system libbpf, i.e. using:

> >   $ cmake -DCMAKE_BUILD_TYPE=Release -DLIBBPF_EMBEDDED=Off

> > This will return errors if trying to encode or load enum64 tags, but
> > disabling it, as done with kernels not supporting BTF_KIND_ENUM64 should
> > now work, can you please test and report results?

> > Vitaly I checked and alt:p9 has libbpf 0.2, which is really old, unsure
> > if it would build there, but alt:sisyphus has 0.8.0, so should work
> > there, please try.

> Perhaps this does not need to be tested since Jiri found the solution?

Right, what I suggested was just an alternative, to use the system
libbpf package instead of the one that ships with pahole, as the older
libbpf woudln't have the problem hypothesized by Jiri.

But it has already been determined that the problem is elsewhere, so
this just was useful to make me realize building with libbpf-devel was
broken due to BTF_KIND_ENUM64, which should be fixed with this patch.
 
> BTW, alt:p9 is older ALT branch only for security updates, current
> branch is alt:p10, so it's relevant to replace p9 testing with p10, for
> new features.

Sure, I go on adding containers and drop them when it is not possible to
build with them, so far this is what I have for alt:

   9    25.26 alt:p8       : Ok  x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1)
  10    81.96 alt:p9       : Ok  x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
  11    94.60 alt:p10      : Ok  x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  12    77.53 alt:sisyphus : Ok  x86_64-alt-linux-gcc (GCC) 12.1.1 20220518 (ALT Sisyphus 12.1.1-alt1) , ALT Linux Team clang version 13.0.1

p8's clang is too old, disabled, p9 also has:

ENV NO_BUILD_BPF_SKEL=1

clang also too old to build BPF skels, but still good to build perf
proper.

> I was building dwarves with -DLIBBPF_EMBEDDED=ON, thinking it would be
> more stable (since they updated not independently from each other), is
> it recommended to turn in OFF?

What most distros are doing is to ship a libbpf and they expect and work
to make tools use it, which isn't always possible, like the patch I sent
shows.

Its a balance on having the latest and greatest libbpf that is needed
for some feature pahole uses and the desire to not link anything
statically due to security concerns (having to fix all things linking
statically with a faulty library).
 
> ps. I think something needs to be changed somewhere (in kernel src?) or
> more users will report build failures when switching to the new pahole.

Right, I voiced concerns already about having enum64 encoded by default,
but its not so simple to solve.

People living on the bleeding edge should not have problems, as recent
kernels support the new BTF encodings, its just people building older
kernels with new pahole that will have problems, right?

By test building against alt:p8 you see that I care about such version
mismatches, but its a burden, really, to try and cover all cases.

- Arnaldo
