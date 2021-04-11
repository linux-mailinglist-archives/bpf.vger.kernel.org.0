Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3835B64A
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhDKRL1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 13:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKRL1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Apr 2021 13:11:27 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01E0C061574
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 10:11:10 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id b10so11023887iot.4
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=4a63NpXNWAFDFa7yL9iq9bYB2QpG7WHimJG4F6v9UCk=;
        b=pP5FdiJhZelXhpzsoQgVzd2mb5kOds+mlWXM2UIgBpeRoG4w1HYF8aTyxmOYDyblBR
         aYi5IElc6zgF7PaV0PR7Mw1XxQFuEDGAFvZS6K6WJMwsjrAev+mVbdf7sKGfEwIWHzTT
         FNAyszU06QrmyRgrzaCSpKjkeXrKGzCZU7g4M1Um9kyFZGT9PJHVER9kr4U9FGe345G8
         mdlOARVtSgKYAvzEwZ9qq9Q9/mh4MpLs5zwNKFkRDf389XeT3dJff9tvgkqIJHHDsyNg
         riOoVHbogCWRbp6DD2Zt4uiLxB4CD+R/n1tr6loEHrorg5bQN45ySTIFUpYGTlXt46tw
         BiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=4a63NpXNWAFDFa7yL9iq9bYB2QpG7WHimJG4F6v9UCk=;
        b=r80mfdRZW2LNUgpSifZaeCdX/20IkxHx0uImDvyFpB6KficiinYN9eoOE8VLwz/aED
         FI8vRzPFHQSyOtmw3EeMNYac0SPzkl7l/gm+/3mRv8ViiRkWu8AC+Uq+5Z6ax7VsCKKh
         v/Ay0xaJ58aXV2BqaZcI9KQgMTQY9A7PtMekzvZpFH7g9kt303aHnd2FrJDYU9kg/Be4
         y/UgNxnxVA3P5XCOmWkEtQgjFz2QxDkb3rHAu+UEqikFQs0IQSiJFlUmpddLjzyiU6w4
         JPQzLjDK7w9NXKxewEQa+Gw99JAUuT9owxdRlB09L2pua/ScyV40ApyytTOkILzXIkgW
         mR1g==
X-Gm-Message-State: AOAM533j1AUIhMJLx3ZhidqPf3JULJfT5LAqcpQVywl+FmnJi6ktjIb7
        a6n/XUxL9oovOqttLC2lSfQ4bZO/4mlHtnktWpE=
X-Google-Smtp-Source: ABdhPJxu0Y1+B6NY5ptdaFzF6gwyTPQ107UrpF6OGfC5/yl54necR0uxrldN+bsFo8W6wKSPo8qGZ2BxIe0R/WRcwHI=
X-Received: by 2002:a05:6638:35ab:: with SMTP id v43mr24409503jal.65.1618161070093;
 Sun, 11 Apr 2021 10:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164930.769251-1-yhs@fb.com>
 <CA+icZUVf9RPxBHZvTaEK0scNoPkF3pf__wWCy3K=TeacgBq98g@mail.gmail.com> <b161ef91-8f3b-9f09-660e-69ee33982334@fb.com>
In-Reply-To: <b161ef91-8f3b-9f09-660e-69ee33982334@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 11 Apr 2021 19:10:34 +0200
Message-ID: <CA+icZUVoq+Sf6WiHtK8mw_kn0_Q86c7czgBkqR2N58BQJE2gFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] selftests: set CC to clang in lib.mk if LLVM
 is set
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 11, 2021 at 6:51 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/11/21 3:22 AM, Sedat Dilek wrote:
> > On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> selftests/bpf/Makefile includes lib.mk. With the following command
> >>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
> >>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
> >> some files are still compiled with gcc. This patch
> >> fixed lib.mk issue which sets CC to gcc in all cases.
> >>
> >> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/testing/selftests/lib.mk | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> >> index a5ce26d548e4..9a41d8bb9ff1 100644
> >> --- a/tools/testing/selftests/lib.mk
> >> +++ b/tools/testing/selftests/lib.mk
> >> @@ -1,6 +1,10 @@
> >>   # This mimics the top-level Makefile. We do it explicitly here so that this
> >>   # Makefile can operate with or without the kbuild infrastructure.
> >> +ifneq ($(LLVM),)
> >> +CC := clang
> >> +else
> >>   CC := $(CROSS_COMPILE)gcc
> >> +endif
> >>
> >
> > Why not use include "include ../../../scripts/Makefile.include" here
> > and include CC and GNU or LLVM (bin)utils from there?
>
> There is a comment above my change,
>
>  >>   # This mimics the top-level Makefile. We do it explicitly here so
> that this
>  >>   # Makefile can operate with or without the kbuild infrastructure.
>
> It is intentionally not depending on kbuild
> (../../../scripts/Makefile.include).
>
> >
> > Should the CC line have a $(CROSS_COMPILE) for people doing cross-compilation?
> >
> > CC := $(CROSS_COMPILE)clang
>
> The top linux/Makefile has
>
> ifneq ($(LLVM),)
> CC              = clang
> LD              = ld.lld
> AR              = llvm-ar
> NM              = llvm-nm
> OBJCOPY         = llvm-objcopy
> OBJDUMP         = llvm-objdump
> READELF         = llvm-readelf
> STRIP           = llvm-strip
> else
> CC              = $(CROSS_COMPILE)gcc
> LD              = $(CROSS_COMPILE)ld
> AR              = $(CROSS_COMPILE)ar
> NM              = $(CROSS_COMPILE)nm
> OBJCOPY         = $(CROSS_COMPILE)objcopy
> OBJDUMP         = $(CROSS_COMPILE)objdump
> READELF         = $(CROSS_COMPILE)readelf
> STRIP           = $(CROSS_COMPILE)strip
> endif
>
> There is no CROSS_COMPILE prefix for llvm.
> Also see here:
>    https://clang.llvm.org/docs/CrossCompilation.html
> for clang, cross compilation is mostly related to
> tweaking compiler options than building a different
> compiler.
>
> Hence, I didn't add $(CROSS_COMPILER) prefix.
>

OK, I see.

My last cross-compilation for a linux-kernel is very long ago.
I never used it with LLVM toolchain - might be $(CROSS_COMPILE) is
only necessary with GNU toolchain.

- Sedat -

> >
> > - Sedat -
> >
> >
> >>   ifeq (0,$(MAKELEVEL))
> >>       ifeq ($(OUTPUT),)
> >> --
> >> 2.30.2
> >>
