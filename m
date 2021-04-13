Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6535E59E
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 19:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347449AbhDMRvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 13:51:55 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:41855 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347502AbhDMRvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 13:51:49 -0400
Received: by mail-yb1-f175.google.com with SMTP id n12so19057725ybf.8
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJDZhXyJaF2enXuUC+Gg2cbcUdA6lWHqwsQmCwyK6A0=;
        b=Nd/5LPknwzEfbZUvQy2OyOY0BmhlssPGAFOlrRy1r1yWG6P3QMOxhEbA4kMnMcwTuO
         CnAu/sS1gK7W7G+oA2W220BxQCslEyuFd/MLYYc15wlApA0k8zMtaFrHcUmXsN1Y4Lg6
         6MqpRglCshE9ITD8/+k+KIKowxgyKZTaiSfBdy7VVbnRgj+IKtD+xRdBsN8Yw0g4/8lX
         1vMkVWDs+ytn0TxJfqgRr2dbAkuv/1/XyMcvuG4IlUM4uRhqOAaOyZjOhnXVjurXQNoB
         uqR0DAOK1EcuRvti3T1pzflPD5FrFblKUeDwPeqy1bkw5dMKoj1NZv7BlOb6pP5Jp9Va
         Hp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJDZhXyJaF2enXuUC+Gg2cbcUdA6lWHqwsQmCwyK6A0=;
        b=uFo8brPoQ7LcY+h7jKnYsuReGlJB2eSUgNpYxYB/AnM2wler/b45kEoCIBVn1fONk/
         R1vyiTvy2sPa1/U7PW8qW6/qXjlvjpjPJxDqCoAMgCmigzO3NF8Y/Oxgt85EA7uaVbrl
         bDSE0ahRi23mP+caQY46uvJLO4z7g/2447d0a8DhKjI7liVQvz+NYUyjCNcB0NHJyDcF
         m4PVoTccV1H6xjsYl627+zMPSFRciv0xMiuwR0XuW5NcOj/B8UGXC7+biW2SGRDO7ymA
         6YvmPfLBbclH+rRnhXSd/6Mh7y1ZfMyRxkw8XgzyPppva+q7nnEFjPLur38oHufx0n9q
         ucvg==
X-Gm-Message-State: AOAM530NbjyAyxiEnmlaOswQ4pBp6jQP+vuC6twVxVAPzQ2m+JkJAFwJ
        7JCsd/0jNjnN5oCrQT3svKcxK4PZZSXokMir8/c=
X-Google-Smtp-Source: ABdhPJwMqLlwn9VhrqZV/C8/ImHGT7xeKN+NiEcdG0Vsumd/4pgydJvdxWERLjyDZsCimn8RUrszZbYjELoqsWxc1dQ=
X-Received: by 2002:a25:d70f:: with SMTP id o15mr34926453ybg.403.1618336229587;
 Tue, 13 Apr 2021 10:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164940.770304-1-yhs@fb.com>
 <CAEf4BzbhbAhRqfkqrzXODVr=ETm7MmwpTDZ5jKd=bGmFvU9G7A@mail.gmail.com> <0d97da89-4e29-7274-4970-ce6f79a43242@fb.com>
In-Reply-To: <0d97da89-4e29-7274-4970-ce6f79a43242@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 10:50:18 -0700
Message-ID: <CAEf4BzaxPGYvy1y=4Q4fCAwGD7Bzw1Mwz55hpQ6R4kXM8e3V1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 11:12 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/12/21 9:32 PM, Andrii Nakryiko wrote:
> > On Sat, Apr 10, 2021 at 9:49 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> With clang compiler:
> >>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
> >>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> >> the test_cpp build failed due to the failure:
> >>    warning: treating 'c-header' input as 'c++-header' when in C++ mode, this behavior is deprecated [-Wdeprecated]
> >>    clang-13: warning: cannot specify -o when generating multiple output files
> >>
> >> test_cpp compilation flag looks like:
> >>    clang++ -g -Og -rdynamic -Wall -I<...> ... \
> >>    -Dbpf_prog_load=bpf_prog_test_load -Dbpf_load_program=bpf_test_load_program \
> >>    test_cpp.cpp <...>/test_core_extern.skel.h <...>/libbpf.a <...>/test_stub.o \
> >>    -lcap -lelf -lz -lrt -lpthread -o <...>/test_cpp
> >>
> >> The clang++ compiler complains the header file in the command line.
> >> Let us remove the header file from the command line which is not intended
> >> any way, and this fixed the problem.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/testing/selftests/bpf/Makefile | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> >> index 6448c626498f..bbd61cc3889b 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -481,7 +481,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
> >>   # Make sure we are able to include and link libbpf against c++.
> >>   $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
> >>          $(call msg,CXX,,$@)
> >> -       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
> >> +       $(Q)$(CXX) $(CFLAGS) test_cpp.cpp $(BPFOBJ) $(LDLIBS) -o $@
> >
> > see what we do for other binaries:
> >
> > $(filter %.a %.o %.c,$^)
> >
> > It's more generic. Add %.cpp, of course.
>
> Okay, although I will remove %.c.
>
> [yhs@devbig003.ftw2 ~/tmp/tmp2]$ clang++ -c t.c
> clang-13: warning: treating 'c' input as 'c++' when in C++ mode, this
> behavior is deprecated [-Wdeprecated]
> [yhs@devbig003.ftw2 ~/tmp/tmp2]$
>
> clang++ will warn if trying to compile .c file.
> g++ 8.4.1 doesn't warn. Not sure about latest g++. But it is not
> a good practice to compile .c files with c++ compiler any way.

yeah, makes sense

>
> >
> >>
> >>   # Benchmark runner
> >>   $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
> >> --
> >> 2.30.2
> >>
