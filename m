Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5459E35E9AA
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 01:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbhDMXX1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 19:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMXX1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 19:23:27 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4BFC061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 16:23:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id z1so20035089ybf.6
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 16:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdbcAB2zvD5KKWZy3dykqNb02C2FtPGsMKkvUj2cKb8=;
        b=JhU0euEuY9U/NSdLRamsajWBeXe8+9uxeO3FUloRWYKQ13KYwS4SJGObBSQRKovfpG
         FZqt87TbJheWLklSlC7ip8X9IhQDmbCoTCm0mNtsMgyBQM/fT/4wAYqr+cranRKrndpb
         UQ2q8vtYKZR3Yh497tYblx1SqwLSjihgDQg9GWsELmDFHGc/sQtgRUXMz05fJUEY8qt2
         UJpdl5LImwrpGl21NXnEnX3/+SKfechhnvy68YZTEcBMLZAWjLQKK0ZoWSAYjWgNBRMA
         sHetEouE32RMOUG5BzCO62XxkVZwwBMlM7nOX59Hm4wMTxEgvBG/FMJwoBmuaWkPSlJp
         VnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdbcAB2zvD5KKWZy3dykqNb02C2FtPGsMKkvUj2cKb8=;
        b=qAFEGMTXLV/cva8ReASTOd7yWwbdasW10fCz1E8y+0odBMW98rgaa0W/QySU/wfPkG
         TbwKNddC1KlOUu8s2hMHVn0rs3g/X07CJycr8KNZ8zrU1paqWw17V56+wGub9729qBLw
         AgCWGC8BRq8DWxCWio0U/5CWJlODneJN8P99HcfUJ/kO3sApdSG6cihStmXjCZBkz+ht
         GNY4QihcivqG/MScuqNxFRxnpRfIRGqakyGvonEhThF1LontHeK0L5RXbtB8mPWkTw1o
         qin9XCS3XYTFcG2XxFkhjI4tJ9MUpuzr18M0Mm+SR0E+egprLUR0GU6RsH2uAnThDpZp
         cA0w==
X-Gm-Message-State: AOAM532CdfO7VzE/apz1GtTOcKflELt4zoS2iWbRgdV/m/vyGhvCs3DL
        qTJmUcDgZPmV+k98o9mWsrgjy3GlA1GyB/ystCc=
X-Google-Smtp-Source: ABdhPJxTS5t7Zxr36488S2we44D2aF03ZMaum8rhJ9CezFnUaQeiQQ2bOWc68oryZmg+o6NvT0OT8CxXQDSHJB01yvk=
X-Received: by 2002:a25:9942:: with SMTP id n2mr47570148ybo.230.1618356186288;
 Tue, 13 Apr 2021 16:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210413153408.3027270-1-yhs@fb.com> <20210413153413.3027426-1-yhs@fb.com>
 <CAEf4BzZM3bLp=zFJ99ZX6iyM1D5gfB6eyweurVjn6iVOLdsrow@mail.gmail.com>
 <CAKwvOdnJYbBs=F2yZLqKvZX5_iHv_X_zCfQXSS3sv=iVDejL=w@mail.gmail.com> <e07d9794-75c1-f554-d827-26a02a6b09f1@fb.com>
In-Reply-To: <e07d9794-75c1-f554-d827-26a02a6b09f1@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 16:22:55 -0700
Message-ID: <CAEf4Bzb46saNHyYbmyu8zgnx3SBHq_n5q-rQVviY5DsDnJPL8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests: set CC to clang in lib.mk if
 LLVM is set
To:     Yonghong Song <yhs@fb.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 3:27 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/13/21 3:13 PM, Nick Desaulniers wrote:
> > On Tue, Apr 13, 2021 at 3:05 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Tue, Apr 13, 2021 at 8:34 AM Yonghong Song <yhs@fb.com> wrote:
> >>>
> >>> selftests/bpf/Makefile includes lib.mk. With the following command
> >>>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
> >>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
> >>> some files are still compiled with gcc. This patch
> >>> fixed lib.mk issue which sets CC to gcc in all cases.
> >>>
> >>> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> >>> Signed-off-by: Yonghong Song <yhs@fb.com>
> >>> ---
> >>>   tools/testing/selftests/lib.mk | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> >>> index a5ce26d548e4..9a41d8bb9ff1 100644
> >>> --- a/tools/testing/selftests/lib.mk
> >>> +++ b/tools/testing/selftests/lib.mk
> >>> @@ -1,6 +1,10 @@
> >>>   # This mimics the top-level Makefile. We do it explicitly here so that this
> >>>   # Makefile can operate with or without the kbuild infrastructure.
> >>> +ifneq ($(LLVM),)
> >>> +CC := clang
> >>
> >> Does this mean that cross-compilation with Clang doesn't work at all
> >> or is achieved in some other way?
> >
> > Right, this probably doesn't support cross compilation w/ Clang.
> > Rather than invoke `$(CROSS_COMPILE) clang`, you'd do `clang
> > --target=$(CROSS_COMPILE)`.  Even then, cross linking executables is
> > hairy.  But at least this should enable native compilation, which is a
> > start.
>
> See https://clang.llvm.org/docs/CrossCompilation.html.
> As Nick said, clang prefers --target=$(CROSS_COMPILE) to
> indicate cross compilation. User can pass additional
> flags (CFLAGS) for cross compilation for the time being.
> This is the same as main kernel Makefile.
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

Ok, sounds good. We can improve cross-compilation separately.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> >>
> >>
> >>> +else
> >>>   CC := $(CROSS_COMPILE)gcc
> >>> +endif
> >>>
> >>>   ifeq (0,$(MAKELEVEL))
> >>>       ifeq ($(OUTPUT),)
> >>> --
> >>> 2.30.2
> >>>
> >
> >
> >
