Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF8B5754D0
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 20:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbiGNSUe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 14:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiGNSUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 14:20:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107768DFB
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:20:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v12so3465630edc.10
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f4W/qeCSIdFVmQjum+LnLMFufEtNWY3ODD9/lqPc2F0=;
        b=UznVnGbksd/w1jMmT/sI3EaeliZBNFgyuIeeekS/qgsCRFNughQiA+PU8pckUwfEvs
         p7B7fqAIZ8T9yGqJ7fcIVuliqgYC+iDSmfQh5HJ21KqStMwkw1zNK0EcKv83XtLAIAut
         mkdTUZnE7Xi5VLnXddnZmMcxTu3GSYBFTye+Ftf1l7EqeKNkhJ0/q7zQJddXHBSS2ffH
         Qwed2O9BwNJ5B+OI/v3pZFWJGjIKSy0jh0cTHxFiIOoLn8VXAwVZQw2q1t4HqYu8+pOV
         zrmMLAmlwq20I4B3wF9d3sEpqr599/dEV1mqVfE/YVYFbWNUtUBwN1KZSuSOhvSoUGC4
         G00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f4W/qeCSIdFVmQjum+LnLMFufEtNWY3ODD9/lqPc2F0=;
        b=hOUaCBADSyOZwBvLmJRqNH+KvbUXuV51dX77TvQ0C0HOpYpuSSZFQp19GIooKZN8mk
         Aq3NKZdv2JUGEyZZwwF+8aYppz3gt8TqzYKlXwKrJOZN2P5htFRIO/2bfoDLtfguGeG8
         ZeQdSqkrhS93Mvlm6gatcSdKmqE7Tbjf1tg00L9S/r5Z0Z7OoE09xsOTyIOWmKT9AhAy
         +RYbyUDxRDbsGe/9wjqGAzU75pI9YQbp1+5HKsAUNpG4c+Dhc4CMtaEr8QFwqdC3uZTD
         Mu5rPiMfUUPDAML9LlJlz7Kg69GpsxWVo8WWkTQLWut5flpMDwnm5xit9rCd2vaTVlUs
         2ATA==
X-Gm-Message-State: AJIora8UwcpC7VkrJsFWIEIshcu+1gE664H5cTMLcadm5gVT1GnUJYU5
        JKbJpuyXOqzqh37/lQ0THuriWcdCPflBMMYT5Bs=
X-Google-Smtp-Source: AGRyM1uTuoC0mBB4MCgp6jgRq4nXt0csQiWCOAy4oeF+x9u68fPaZSurlkGN/urbmsE+nK/nR2BpbykmZWztDCA82pM=
X-Received: by 2002:a05:6402:50d2:b0:43a:8487:8a09 with SMTP id
 h18-20020a05640250d200b0043a84878a09mr14013705edb.232.1657822830975; Thu, 14
 Jul 2022 11:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220712212124.3180314-1-deso@posteo.net> <20220712212124.3180314-2-deso@posteo.net>
 <CAADnVQLLNQHHJuqd-pKzU09Uw3N-kBsztPy0ysYEKVipP=yMqw@mail.gmail.com>
 <20220712215322.rw3z6eoix3yagi2q@muellerd-fedora-MJ0AC3F3>
 <Ys32tgTtkfeECzLc@google.com> <20220712230138.mmdw323h5dop5abe@muellerd-fedora-MJ0AC3F3>
 <CAEf4Bzb-=jPqApbHnN6xX5XR0eXs5kGS8pAxzOQuR95b5kXYSg@mail.gmail.com> <20220714143608.cuilkiirxo4f6bhz@nuc>
In-Reply-To: <20220714143608.cuilkiirxo4f6bhz@nuc>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Jul 2022 11:20:19 -0700
Message-ID: <CAEf4BzbENk8szUM-pgdsxtOQaGseehxA5OwEDFAD-dOxFAUgsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Copy over libbpf configs
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 14, 2022 at 7:36 AM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Wed, Jul 13, 2022 at 09:48:32PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jul 12, 2022 at 4:01 PM Daniel M=C3=BCller <deso@posteo.net> wr=
ote:
> > >
> > > On Tue, Jul 12, 2022 at 03:33:26PM -0700, sdf@google.com wrote:
> > > > On 07/12, Daniel M=EF=BF=BDller wrote:
> > > > > On Tue, Jul 12, 2022 at 02:27:47PM -0700, Alexei Starovoitov wrot=
e:
> > > > > > On Tue, Jul 12, 2022 at 2:21 PM Daniel M=EF=BF=BDller <deso@pos=
teo.net> wrote:
> > > > > > >
> > > > > > > This change integrates the libbpf maintained configurations a=
nd
> > > > > > > black/white lists [0] into the repository, co-located with th=
e BPF
> > > > > > > selftests themselves. The only differences from the source is=
 that we
> > > > > > > replaced the terms blacklist & whitelist with denylist and al=
lowlist,
> > > > > > > respectively.
> > > > > > >
> > > > > > > [0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825=
cedcbd210c4d7112c1898/travis-ci/vmtest/configs
> > > > > > >
> > > > > > > Signed-off-by: Daniel M=EF=BF=BDller <deso@posteo.net>
> > > > > > > ---
> > > > > > >  .../bpf/configs/allowlist/ALLOWLIST-4.9.0     |    8 +
> > > > > > >  .../bpf/configs/allowlist/ALLOWLIST-5.5.0     |   55 +
> > > > > > >  .../selftests/bpf/configs/config-latest.s390x | 2711 +++++++=
++++++++
> > > > > > >  .../bpf/configs/config-latest.x86_64          | 3073
> > > > > +++++++++++++++++
> > > > > >
> > > > > > Instead of checking in the full config please trim it to
> > > > > > relevant dependencies like existing selftests/bpf/config.
> > > > > > Otherwise every update/addition would trigger massive patches.
> > > >
> > > > > Thanks for taking a look. Sure. Do we have some kind of tooling f=
or that
> > > > > or are
> > > > > there any suggestions on the best approach to minimize?
> > > >
> > > > I would be interested to know as well if somebody knows some tricks=
 on
> > > > how to deal with kconfig. I've spent some time yesterday manually
> > > > crafting various minimal bpf configs (for build tests), running mak=
e
> > > > olddefconfig and then verifying that all my options are still prese=
nt in
> > > > the final config file.
> > > >
> > > > It seems like kconfig tool can resolve some of the dependencies,
> > > > but there is a lot of if/endif that can break in non-obvious ways.
> > > > For example, putting CONFIG_TRACING=3Dy and doing 'make olddefconfi=
g'
> > > > won't get you CONFIG_TRACING=3Dy in the final .config
> > > >
> > > > So the only thing, for me, that helped, was to manually go through
> > > > the kconfig files trying to see what the dependencies are.
> > > > I've tried scripts/kconfig/merge_config.sh, but it doesn't
> > > > seem to bring anything new to the table..
> > > >
> > > > So here is what I ended up with, I don't think it will help you tha=
t
> > > > much, but at least can highlight the moving parts (I was thinking t=
hat
> > > > maybe we can eventually put them in the CI as well to make sure all=
 weird
> > > > configurations are build-tested?):
> > >
> > > [...]
> > >
> > > I *think* that make savedefconfig [0] is the way to go, at least for =
my use
> > > case. That cuts down the config file to <350 lines. However, it does =
change some
> > > configurations from 'm' to 'y', which I can't say I quite understand =
or would
> > > have expected (but perhaps minimal implies no modules or similar; I h=
aven't
> > > investigated).
> > > I am still verifying that the result is working as expected, though.
> >
> > I think ideally we'd do defconfig first, then append whatever is in
> > selftests/bpf/config, do olddefconfig to fill in all the unspecified
> > options, and then use the result as the config. Yes, that requires
> > that selftests/bpf/config has some of the dependent values specified,
> > which is an annoying mostly one-time thing, but I think it's
> > beneficial to all the new BPF users, because it *really* shows what
> > needs to be added to kernel config to make everything work. We can
> > also split it into BPF-specific and non-BPF (dependencies) configs, if
> > that is cleaner.
>
> Agreed, we should do that eventually. But let's not put everything into
> this patch set, which was never intended to rework everything we have,
> okay? It contains a few steps towards where we want to head.
>
> If we start diverging massively now, while also moving configurations
> between multiple repositories, we end up with a mess of a history that
> will be hard to follow.
>
> So unless there exist very strong arguments forcing us to do that here
> and now (such as us regressing on one front, which I don't see here),
> I'd rather we go about it at a later point after other check boxes have
> been ticked. What do you think?
>

You mean the part about checking in huge Kconfigs for x86 and s390x? I
don't think we should do that as a first step. Yes it's an annoying
(but also very important) part to figure out the minimal set of added
configs on top of default config, but I think we should do that from
the beginning instead of polluting Git history with massive configs.
It will also keep selftests/bpf/config "honest" instead of putting it
on new users to figure out other missed or dependent configs by
themselves.

With s390x config, at least, I hope that Ilya can ease the pain,
especially that he was the one who came up with that config in the
first place (cc'ed Ilya).


> > Also, I don't think we should move 4.9.0 and 5.5.0 lists here, let's
> > keep them in libbpf CI, they are very specific there. Here we should
> > only maintain the latest per-arch configs and allow/deny lists only.
>
> Sounds good, will remove them.
>
> Thanks,
> Daniel
