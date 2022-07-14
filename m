Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B77E5750EF
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 16:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbiGNOgU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 10:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbiGNOgT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 10:36:19 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3C5FAF3
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 07:36:17 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 4C5CC240108
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 16:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657809375; bh=ID3astSQ+A//PC/2gowYkU5LWKIhthx2qUz36DDoMzY=;
        h=Date:From:To:Cc:Subject:From;
        b=A7cKe7iqfVtn9s4juNkFOFSh3QluwpzbCotmQZ7qQMG+SXBIZ+MsCGS+uBMLKxVNj
         /1jE98283rUBFLJ7hXfpNfQBW5kj0AimOs6v5eo7JOHdneXQOn7puqtmRwU6s7OUHM
         CLEnOIlP5MMkIWYs4L/jA9mrqXdrUjnfWcFYNEPfl1F8PilgZb0SPA9IGAtryRlbVT
         qw2i3/gmuYz2cqEis1MBvJEI8BX6daF9uHzu7AOprQhjyZ+/jXczNbsr/AE54K5Hdm
         C0iOcotxf/Occ4TaobQHCz+GZ2wELvmMUvKWmxrEoUBwcGlW0Kfv25DpH98ncpokd7
         Tv4yL+EKTSplA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LkH9R5nHKz6tpZ;
        Thu, 14 Jul 2022 16:36:11 +0200 (CEST)
Date:   Thu, 14 Jul 2022 14:36:08 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Copy over libbpf configs
Message-ID: <20220714143608.cuilkiirxo4f6bhz@nuc>
References: <20220712212124.3180314-1-deso@posteo.net>
 <20220712212124.3180314-2-deso@posteo.net>
 <CAADnVQLLNQHHJuqd-pKzU09Uw3N-kBsztPy0ysYEKVipP=yMqw@mail.gmail.com>
 <20220712215322.rw3z6eoix3yagi2q@muellerd-fedora-MJ0AC3F3>
 <Ys32tgTtkfeECzLc@google.com>
 <20220712230138.mmdw323h5dop5abe@muellerd-fedora-MJ0AC3F3>
 <CAEf4Bzb-=jPqApbHnN6xX5XR0eXs5kGS8pAxzOQuR95b5kXYSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb-=jPqApbHnN6xX5XR0eXs5kGS8pAxzOQuR95b5kXYSg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 09:48:32PM -0700, Andrii Nakryiko wrote:
> On Tue, Jul 12, 2022 at 4:01 PM Daniel Müller <deso@posteo.net> wrote:
> >
> > On Tue, Jul 12, 2022 at 03:33:26PM -0700, sdf@google.com wrote:
> > > On 07/12, Daniel M�ller wrote:
> > > > On Tue, Jul 12, 2022 at 02:27:47PM -0700, Alexei Starovoitov wrote:
> > > > > On Tue, Jul 12, 2022 at 2:21 PM Daniel M�ller <deso@posteo.net> wrote:
> > > > > >
> > > > > > This change integrates the libbpf maintained configurations and
> > > > > > black/white lists [0] into the repository, co-located with the BPF
> > > > > > selftests themselves. The only differences from the source is that we
> > > > > > replaced the terms blacklist & whitelist with denylist and allowlist,
> > > > > > respectively.
> > > > > >
> > > > > > [0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedcbd210c4d7112c1898/travis-ci/vmtest/configs
> > > > > >
> > > > > > Signed-off-by: Daniel M�ller <deso@posteo.net>
> > > > > > ---
> > > > > >  .../bpf/configs/allowlist/ALLOWLIST-4.9.0     |    8 +
> > > > > >  .../bpf/configs/allowlist/ALLOWLIST-5.5.0     |   55 +
> > > > > >  .../selftests/bpf/configs/config-latest.s390x | 2711 +++++++++++++++
> > > > > >  .../bpf/configs/config-latest.x86_64          | 3073
> > > > +++++++++++++++++
> > > > >
> > > > > Instead of checking in the full config please trim it to
> > > > > relevant dependencies like existing selftests/bpf/config.
> > > > > Otherwise every update/addition would trigger massive patches.
> > >
> > > > Thanks for taking a look. Sure. Do we have some kind of tooling for that
> > > > or are
> > > > there any suggestions on the best approach to minimize?
> > >
> > > I would be interested to know as well if somebody knows some tricks on
> > > how to deal with kconfig. I've spent some time yesterday manually
> > > crafting various minimal bpf configs (for build tests), running make
> > > olddefconfig and then verifying that all my options are still present in
> > > the final config file.
> > >
> > > It seems like kconfig tool can resolve some of the dependencies,
> > > but there is a lot of if/endif that can break in non-obvious ways.
> > > For example, putting CONFIG_TRACING=y and doing 'make olddefconfig'
> > > won't get you CONFIG_TRACING=y in the final .config
> > >
> > > So the only thing, for me, that helped, was to manually go through
> > > the kconfig files trying to see what the dependencies are.
> > > I've tried scripts/kconfig/merge_config.sh, but it doesn't
> > > seem to bring anything new to the table..
> > >
> > > So here is what I ended up with, I don't think it will help you that
> > > much, but at least can highlight the moving parts (I was thinking that
> > > maybe we can eventually put them in the CI as well to make sure all weird
> > > configurations are build-tested?):
> >
> > [...]
> >
> > I *think* that make savedefconfig [0] is the way to go, at least for my use
> > case. That cuts down the config file to <350 lines. However, it does change some
> > configurations from 'm' to 'y', which I can't say I quite understand or would
> > have expected (but perhaps minimal implies no modules or similar; I haven't
> > investigated).
> > I am still verifying that the result is working as expected, though.
> 
> I think ideally we'd do defconfig first, then append whatever is in
> selftests/bpf/config, do olddefconfig to fill in all the unspecified
> options, and then use the result as the config. Yes, that requires
> that selftests/bpf/config has some of the dependent values specified,
> which is an annoying mostly one-time thing, but I think it's
> beneficial to all the new BPF users, because it *really* shows what
> needs to be added to kernel config to make everything work. We can
> also split it into BPF-specific and non-BPF (dependencies) configs, if
> that is cleaner.

Agreed, we should do that eventually. But let's not put everything into
this patch set, which was never intended to rework everything we have,
okay? It contains a few steps towards where we want to head.

If we start diverging massively now, while also moving configurations
between multiple repositories, we end up with a mess of a history that
will be hard to follow.

So unless there exist very strong arguments forcing us to do that here
and now (such as us regressing on one front, which I don't see here),
I'd rather we go about it at a later point after other check boxes have
been ticked. What do you think?

> Also, I don't think we should move 4.9.0 and 5.5.0 lists here, let's
> keep them in libbpf CI, they are very specific there. Here we should
> only maintain the latest per-arch configs and allow/deny lists only.

Sounds good, will remove them.

Thanks,
Daniel
