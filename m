Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5235E8EE
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 00:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhDMWSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhDMWSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 18:18:23 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E1CC061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:18:02 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l14so18243789ljb.1
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vI1T++XVMddunMQm6m8+Ept2Pbyb4PuMdjV9WGh6X2k=;
        b=W6w4Vd5ppA+JcaRcEKuDOnKiZQ+9mb7XB1uwX0jMZ/HhT1fI5kBAhMUT7NEarvEF+E
         J1syqD97wKfBlBdssG9C4KliNWCB3XGjtE8E7ymDETR1osbqzkRMkHPl+3VnMsZhcJS8
         kjs75GBdmCUjlGwLswZ3lO8PcCUsBDiolcas+XiAkFjdzXEjPhl4TV18klZfnXCW3dwl
         FcpTPDuhhK2aAX6U0Pc5wDn7xt9aYS21ZDYWNrHqP3dPRLMbC1JPIGR7GMVn36Qvetbd
         VAkp1l0+wqjaVBidC7g5tolV6yxJvMyAczFSIuGMAa6BxyM/27RBiS4umsarK6VpZd6w
         0rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vI1T++XVMddunMQm6m8+Ept2Pbyb4PuMdjV9WGh6X2k=;
        b=cxMPOIsvBMkDn7zHC3atexA9gQ/52Yrnclza1gg1oS4OQ/Klmm6/wPznR5QfMgYX1R
         a4WmvU2S2MDSyhSXwDzs2nvzQWC/+tifG/8MqxYJcGBaWBgP3OeSuCi4o2BFmP9T2jdR
         IxlvJS/wiTwniwklmDjkWN3FrIx8L4nkvcKeH30hR5VO2gby9RYm2b4OLstzWZc8qtkv
         RUt3eb11yotCSizZnLsIYhqmOQbP8OSOJUQPWIAjAi1AjcoHZDbJNHPXYA5i6LnHTLrd
         dLCJTJF67hJ8BA9ZMezaAwg7TsxYTcYjNMPg58G3ak6ahOq85iobjskOtlodby5chZRd
         J3Jw==
X-Gm-Message-State: AOAM531Pc4pkip+aBHdPjQgSa8LNcg0VMBFDkrgVOYqs5G31+Bf7I7Wl
        2a1xRsPgxTfpT4PRTgRwpR/SXf0MhFILebDCmq+epw==
X-Google-Smtp-Source: ABdhPJxn0rbbwtOSInyleVJ9d9m7vZP3dMmAyoteQYX9VeoG1bvChHXvZyDc4L+SsjppQxBrrtW+yF4u1r3EQGV+XhE=
X-Received: by 2002:a2e:b008:: with SMTP id y8mr21360358ljk.233.1618352280935;
 Tue, 13 Apr 2021 15:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210413153408.3027270-1-yhs@fb.com> <20210413153429.3029377-1-yhs@fb.com>
 <CAEf4BzY2qKks5EV2CYZjSHpv3Z-qakfKAw=dA-Uc7kh88_f0AA@mail.gmail.com>
In-Reply-To: <CAEf4BzY2qKks5EV2CYZjSHpv3Z-qakfKAw=dA-Uc7kh88_f0AA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 13 Apr 2021 15:17:49 -0700
Message-ID: <CAKwvOdmgJBV5yv5robxvmpdYhkw1epY6FNYYwiszqZ0zyE0UAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] selftests/bpf: silence clang compilation warnings
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 3:08 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Apr 13, 2021 at 8:34 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > With clang compiler:
> >   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
> >   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> > Some linker flags are not used/effective for some binaries and
> > we have warnings like:
> >   warning: -lelf: 'linker' input unused [-Wunused-command-line-argument]
> >
> > We also have warnings like:
> >   .../selftests/bpf/prog_tests/ns_current_pid_tgid.c:74:57: note: treat the string as an argument to avoid this
> >         if (CHECK(waitpid(cpid, &wstatus, 0) == -1, "waitpid", strerror(errno)))
> >                                                                ^
> >                                                                "%s",
> >   .../selftests/bpf/test_progs.h:129:35: note: expanded from macro 'CHECK'
> >         _CHECK(condition, tag, duration, format)
> >                                          ^
> >   .../selftests/bpf/test_progs.h:108:21: note: expanded from macro '_CHECK'
> >                 fprintf(stdout, ##format);                              \
> >                                   ^
> > The first warning can be silenced with clang option -Wno-unused-command-line-argument.
> > For the second warning, source codes are modified as suggested by the compiler
> > to silence the warning. Since gcc does not support the option
> > -Wno-unused-command-line-argument and the warning only happens with clang
> > compiler, the option -Wno-unused-command-line-argument is enabled only when
> > clang compiler is used.
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
>
> LGTM, please see the question below.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> >  tools/testing/selftests/bpf/Makefile                         | 5 +++++
> >  tools/testing/selftests/bpf/prog_tests/fexit_sleep.c         | 4 ++--
> >  tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 4 ++--
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index dcc2dc1f2a86..c45ae13b88a0 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -28,6 +28,11 @@ CFLAGS += -g -Og -rdynamic -Wall $(GENFLAGS) $(SAN_CFLAGS)           \
> >           -Dbpf_load_program=bpf_test_load_program
> >  LDLIBS += -lcap -lelf -lz -lrt -lpthread
> >
> > +# Silence some warnings when compiled with clang
> > +ifneq ($(LLVM),)
>
> This won't handle the case where someone does `make CC=clang`, right?
> Do we care at all?

Right; it would be better to check CC=clang and have LLVM=1 enable
CC=clang from a higher level Makefile (since tools/build/Makefile
seems to override the top level $CC). See the top level Makefile
L448-456.  Then it should work for CC=clang or LLVM=1.

>
>
> > +CFLAGS += -Wno-unused-command-line-argument
> > +endif
> > +
>
> [...]



-- 
Thanks,
~Nick Desaulniers
