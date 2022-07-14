Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9F1574403
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 06:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiGNE6o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 00:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiGNE6M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 00:58:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8836BCB6
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 21:48:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id va17so1385026ejb.0
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 21:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jTZxyMsxziTRxGzq5+M9COi5T0mi4WQAEFKejkKyLdM=;
        b=ARBDKGz3HEhp33CTYamIXhJYe7Hmz7k2fl0qEmckwqhfrizH1DnZcXLT/kjbP5A7la
         wo2pRVSF7RpS89bzeefwXOBVypBq78+ILV1G03oUmqd/xHgzqXXZKmPsjoa5EkwB0uh6
         hVn5071BlRZAj6HtSNAoGA7RJc8zMKV2B7PGINPqhr44MjrxnBSEGlTaaW0UH7mkJiOd
         nZI9htH7rCBvWBRNm/qBQH7b8jqTrT6a1pkUUXXttPeyNXqo9it5x6vPQwOE/5kbUhts
         i+HZ+jf/ym+SbeDdhgIlICSFol4ILMVWFhwZykf9HURtk1LzpfTh+fkGapIFw61bNPHq
         NOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jTZxyMsxziTRxGzq5+M9COi5T0mi4WQAEFKejkKyLdM=;
        b=oiKqgKE2fRt7ONZo7ZWcGeZHILq8LkRwYD0E0C2XJiCcn6N7ZLnKr1yXniMjSk6Ar5
         et+7LwQmY332ZFZMkGub8rfB5SO/eA/DDijc/WA3zfN3yJJre1q3VSlziThQBSOkZm8A
         dMRzvGmZclruXy8x51GD9ureibzVxasnRM5hd2GhMcw8/70QjdMQ5+XlJirJN5U4kkYY
         rws90fdV0PGm4+Ri7Q/Gp6g75zrdDZBjXKWR4U6it5NJIGGNMgxGcS93wzNxY2VT82cv
         4TsCVJSEKl//N28U4Nc9dsSY4hAki830Gz+DS5OO3Z+wIpy1UbnRbt0pP8hJ+R/fJgvC
         vTRw==
X-Gm-Message-State: AJIora8mP/NzZzIVXtAev80T2r2vHSCRzM5U5fhIa77lHQM8mBAoS9l4
        uIvVoXLwRkXzh34sTwarTde8BFKNqmfpvsR8qfU=
X-Google-Smtp-Source: AGRyM1v1YinYDtzloaqv8pD15assYHDmQIVgNOD+y2IkZGupvlXvDYhLzKa+cjksFMD38ptfdG69cm5oPv/kz+Yh8/k=
X-Received: by 2002:a17:907:75ef:b0:72b:2fd:1a92 with SMTP id
 jz15-20020a17090775ef00b0072b02fd1a92mr6754014ejc.745.1657774123383; Wed, 13
 Jul 2022 21:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220712212124.3180314-1-deso@posteo.net> <20220712212124.3180314-2-deso@posteo.net>
 <CAADnVQLLNQHHJuqd-pKzU09Uw3N-kBsztPy0ysYEKVipP=yMqw@mail.gmail.com>
 <20220712215322.rw3z6eoix3yagi2q@muellerd-fedora-MJ0AC3F3>
 <Ys32tgTtkfeECzLc@google.com> <20220712230138.mmdw323h5dop5abe@muellerd-fedora-MJ0AC3F3>
In-Reply-To: <20220712230138.mmdw323h5dop5abe@muellerd-fedora-MJ0AC3F3>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 21:48:32 -0700
Message-ID: <CAEf4Bzb-=jPqApbHnN6xX5XR0eXs5kGS8pAxzOQuR95b5kXYSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] selftests/bpf: Copy over libbpf configs
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
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

On Tue, Jul 12, 2022 at 4:01 PM Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> On Tue, Jul 12, 2022 at 03:33:26PM -0700, sdf@google.com wrote:
> > On 07/12, Daniel M=EF=BF=BDller wrote:
> > > On Tue, Jul 12, 2022 at 02:27:47PM -0700, Alexei Starovoitov wrote:
> > > > On Tue, Jul 12, 2022 at 2:21 PM Daniel M=EF=BF=BDller <deso@posteo.=
net> wrote:
> > > > >
> > > > > This change integrates the libbpf maintained configurations and
> > > > > black/white lists [0] into the repository, co-located with the BP=
F
> > > > > selftests themselves. The only differences from the source is tha=
t we
> > > > > replaced the terms blacklist & whitelist with denylist and allowl=
ist,
> > > > > respectively.
> > > > >
> > > > > [0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedc=
bd210c4d7112c1898/travis-ci/vmtest/configs
> > > > >
> > > > > Signed-off-by: Daniel M=EF=BF=BDller <deso@posteo.net>
> > > > > ---
> > > > >  .../bpf/configs/allowlist/ALLOWLIST-4.9.0     |    8 +
> > > > >  .../bpf/configs/allowlist/ALLOWLIST-5.5.0     |   55 +
> > > > >  .../selftests/bpf/configs/config-latest.s390x | 2711 +++++++++++=
++++
> > > > >  .../bpf/configs/config-latest.x86_64          | 3073
> > > +++++++++++++++++
> > > >
> > > > Instead of checking in the full config please trim it to
> > > > relevant dependencies like existing selftests/bpf/config.
> > > > Otherwise every update/addition would trigger massive patches.
> >
> > > Thanks for taking a look. Sure. Do we have some kind of tooling for t=
hat
> > > or are
> > > there any suggestions on the best approach to minimize?
> >
> > I would be interested to know as well if somebody knows some tricks on
> > how to deal with kconfig. I've spent some time yesterday manually
> > crafting various minimal bpf configs (for build tests), running make
> > olddefconfig and then verifying that all my options are still present i=
n
> > the final config file.
> >
> > It seems like kconfig tool can resolve some of the dependencies,
> > but there is a lot of if/endif that can break in non-obvious ways.
> > For example, putting CONFIG_TRACING=3Dy and doing 'make olddefconfig'
> > won't get you CONFIG_TRACING=3Dy in the final .config
> >
> > So the only thing, for me, that helped, was to manually go through
> > the kconfig files trying to see what the dependencies are.
> > I've tried scripts/kconfig/merge_config.sh, but it doesn't
> > seem to bring anything new to the table..
> >
> > So here is what I ended up with, I don't think it will help you that
> > much, but at least can highlight the moving parts (I was thinking that
> > maybe we can eventually put them in the CI as well to make sure all wei=
rd
> > configurations are build-tested?):
>
> [...]
>
> I *think* that make savedefconfig [0] is the way to go, at least for my u=
se
> case. That cuts down the config file to <350 lines. However, it does chan=
ge some
> configurations from 'm' to 'y', which I can't say I quite understand or w=
ould
> have expected (but perhaps minimal implies no modules or similar; I haven=
't
> investigated).
> I am still verifying that the result is working as expected, though.

I think ideally we'd do defconfig first, then append whatever is in
selftests/bpf/config, do olddefconfig to fill in all the unspecified
options, and then use the result as the config. Yes, that requires
that selftests/bpf/config has some of the dependent values specified,
which is an annoying mostly one-time thing, but I think it's
beneficial to all the new BPF users, because it *really* shows what
needs to be added to kernel config to make everything work. We can
also split it into BPF-specific and non-BPF (dependencies) configs, if
that is cleaner.

Also, I don't think we should move 4.9.0 and 5.5.0 lists here, let's
keep them in libbpf CI, they are very specific there. Here we should
only maintain the latest per-arch configs and allow/deny lists only.

>
> Thanks,
> Daniel
>
> [0] https://lwn.net/Articles/397363/
