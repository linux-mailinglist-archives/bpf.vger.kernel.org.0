Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC22D567DA0
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 07:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiGFFO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 01:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGFFO0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 01:14:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D71F632
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 22:14:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id d2so25122786ejy.1
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 22:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A21QWqCeopOwDguxG3z7yjXPx4ps0zJoF0UvrchxLRU=;
        b=Sxk2eVPsCCBHjDH4WZyqKpg77nAEtysasc909TQrnDf/p8cLtbYT6PEHnEWrm16/zq
         IP4hQoCMD3FMMCRJcslZioYuyDHjtxI3eMAo/JS/6VbL/wUWsKTDtJaKW7tcttUZ4bRQ
         +rH5XE1uYiZ1P1UIBFVFZpQiTTtgJuveHVIYEPucOUznrzfLSGU58bFjsRdABYECJdMo
         LXNf5a5dc9FMRHQVW6H3Rd8YSXnthCbXVLkhkIYyvSJIWflZfSuPzUNtfVFJDtRj6yrd
         S4Z9ZOwCeQ1+Bl71bYjWi9IGI0Ouvi0rJtX6J3fMtHBmEILOXH7qqltSA1XHekBayyfc
         GnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A21QWqCeopOwDguxG3z7yjXPx4ps0zJoF0UvrchxLRU=;
        b=P4Xzi5QuTa/aSy1rGJn+6fYJmYTHC/Ib3VEvhPG4WrSZsndDMy/TWScXxqRMVn/Y4L
         HB5qiG3HWk8n1R+UOsJMiSA4m7L9iGJ/N3AKafCRJRuvltyEyOppsgs4BCRaUt5aBQWa
         5uh2rprcjl6Wc9c2NzYXZlctWnyp0SwAu6w37MrY5ytpOXgzfbmIuANu+2gqsQYU1ccb
         n1uW/cQO6s5Uc/D9WbO2j5N3sasyK+aNr4WtRILBrpULn9UTwird9G3ggDfnkSNs1TwV
         JwXdALYkB7jbdr29MaV+m9CJm1SKDHZePVb/rGrpL5uV4OBW9b4HBE1PkIiMkF5DzF/g
         YW7Q==
X-Gm-Message-State: AJIora9rA176Z0TNHXJd/DL9MmcYU0OH2Jj8DFiKlYfecPgEZP4o2R7q
        gMtdQR2nToimhdtqpW8vxtQrRqeMuyD+sbexJx8=
X-Google-Smtp-Source: AGRyM1tTBkz1Mo8qVbf4CBJ+gr2+Ajs6BQUxpHO2weQiMlYDhTJy/S6oKEHsKqupIFDfUyJHfngh2kXZmtRj/WIgrsY=
X-Received: by 2002:a17:906:a3ca:b0:726:2bd2:87bc with SMTP id
 ca10-20020a170906a3ca00b007262bd287bcmr37320624ejb.226.1657084463635; Tue, 05
 Jul 2022 22:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <aa98e9e1a7f440779d509046021d0c1c@huawei.com> <CA+khW7i39MXy4aTFCGeu+85Shyd47A+0w5EAA5qL7v+n4S74dA@mail.gmail.com>
 <6f501b451d4a4f3882ee9aa662964310@huawei.com> <ae8feec0-3c0f-d4f4-64e9-588df2d02d24@isovalent.com>
In-Reply-To: <ae8feec0-3c0f-d4f4-64e9-588df2d02d24@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Jul 2022 22:14:12 -0700
Message-ID: <CAEf4BzbPdXgDiTTpw1F79ym=k=Y6GS8EoW_Vtgu30Lv9PaV4kg@mail.gmail.com>
Subject: Re: libbfd feature autodetection
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Hao Luo <haoluo@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 5, 2022 at 7:46 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On 01/07/2022 08:10, Roberto Sassu wrote:
> >> From: Hao Luo [mailto:haoluo@google.com]
> >> Sent: Thursday, June 30, 2022 7:29 PM
> >> Hi Roberto,
> >>
> >> On Thu, Jun 30, 2022 at 6:55 AM Roberto Sassu <roberto.sassu@huawei.com>
> >> wrote:
> >>>
> >>> Hi everyone
> >>>
> >>> I'm testing a modified version of bpftool with the CI.
> >>>
> >>> Unfortunately, it does not work due to autodetection
> >>> of libbfd in the build environment, but not in the virtual
> >>> machine that actually executes the tests.
> >>>
> >>> What the proper solution should be?
> >>
> >> Can you elaborate by not working? do you mean bpftool doesn't build?
> >> or bpftool builds, but doesn't behave as you expect when it runs. On
> >> my side, when I built bpftool, libbfd was not detected, but I can
> >> still bpftool successfully.
> >
> > Hi Hao
> >
> > in Github Actions, the build environment has support for
> > libbfd. When bpftool is compiled, libbfd is linked to it.
> >
> > However, the run-time environment is different, is an ad hoc
> > image made by the eBPF maintainers, which does not have
> > libbfd.
> >
> > When a test executes bpftool, I get the following message:
> >
> > 2022-06-28T16:15:14.8548432Z ./bpftool_nobootstrap: error while loading shared libraries: libbfd-2.34-system.so: cannot open shared object file: No such file or directory
> >
> > I solved with this:
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index e32a28fe8bc1..d44f4d34f046 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -242,7 +242,9 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
> >                   OUTPUT=$(HOST_BUILD_DIR)/bpftool/                          \
> >                   LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/                    \
> >                   LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/                        \
> > -                 prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
> > +                 prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin           \
> > +                 FEATURE_TESTS='disassembler-four-args zlib libcap clang-bpf-co-re'  \
>
> (disassembler-four-args can probably be removed too, the file using it
> shouldn't be compiled if libbfd support if not present.)
>
> > +                 FEATURE_DISPLAY='disassembler-four-args zlib libcap clang-bpf-co-re'
> >
> > but I'm not sure it is the right approach.
>
> Hi Roberto,
>
> I don't think we have another solution for intentionally disabling
> bpftool's feature at build time at the moment. For the context: I
> submitted a patch last week to do just this [0], but in the end we
> preferred to avoid encouraging distributions to remove features.
>
> But I agree it's not ideal. We shouldn't have to pass all existing
> bpftool's features to the selftests Makefile.
>
> Daniel, what would you think of an alternative approach: instead of
> having variables with obvious names like BPFTOOL_FEATURE_NO_LIBCAP, we
> could maybe have a FEATURE_IGNORE in bpftool's Makefile and filter out
> its contents from FEATURE_TESTS/FEATURE_DISPLAY before running the
> tests? Given that features can already be edited as in the above patch,
> it wouldn't change much what we can do but would be cleaner here?
>

Is statically linking all such dependencies into bpftool an option? If
build environment has libbfd, we compile and statically link against
it. Then no matter what environment bpftool runs in, we have libbfd
inside.

> Quentin
>
> [0]
> https://lore.kernel.org/bpf/CACdoK4LTgpcuS9Sgk6F-9=cP09aACxJN4iTXJ=39OohPcBKXAg@mail.gmail.com/T/#t
