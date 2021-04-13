Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A858C35E912
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 00:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbhDMWfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 18:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242024AbhDMWfS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 18:35:18 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1E5C061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:34:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c1so12895462ljd.7
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJF6w+JMTuSZop9MJMz4VsonUaLscE7+OcJe1MsA8rs=;
        b=mrN0gs90E2s0BVMUOyeWeaGz1g8mVcNUJCd+5Gyy0lQB52oynNlljqHL5R0IE7XHID
         h76cr16sVfJzHCMoGA+Jfw2fTlcV8/MLikLzQ1WWExYh399Qat6jYXlaCd33GSg7LH82
         EB5OMC81jUNotlwWuwD61uusbcT86UdE+5BsuI0y9sa1m/IcmUGy7SE8b7ZIHgdGDbP1
         Y+kuQNl8IAgi853zsyiGp0Estdzgl6V1ewNNt2KMHPtfd9YklAtdDvBT6879mW3NoxVQ
         QFbOvpe3uiHTDMwKei2FppUZVbb4CxBCOWQGEL2GMQJzvUfHSkivgdO2Iu9bMwdnoAXn
         D/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJF6w+JMTuSZop9MJMz4VsonUaLscE7+OcJe1MsA8rs=;
        b=XCUa8N02JdxEH5RXcx09TvaDaTPhYyiZ0ZcJ+mPcF6ttdDL1sdPSdVfqPcImXnEVEW
         glQvWrXcU8872QRK8M0yTvWBYD4yuxJdnfoypA7bkgfXyQq3XjbOpsrvcPLiXH8iKkbh
         N4R3ZLa1cE+n+8FcraVM/9snEeQSB03NAmkFCLKxTc1hH9TtJaZxEzQsQ6B4aSQsk528
         j2RD10KJ+nRqy3QDFD38nvBR87Df0EtEB7sSkzXv2mf4b7zX7/aY94+93E0msYitdkUj
         yYfNBGLsd0dom8D25hgeZ5Ky352fUy2n5gT9Err0gG0MxRCDQf1XIYWOgr4xqznKItrM
         5kPg==
X-Gm-Message-State: AOAM530ZdEoKyY7XX59b5frVpOP8kqnmVBhXD+vZ/UKMxjhKh/7bNFDZ
        cXYEfAaitaS9Kelo7bCINZXyWnwteLhKpL+O9FJqcw==
X-Google-Smtp-Source: ABdhPJywJvJykScNB0Pa4H5oDn8OG/n14hS5yH9qaZ5p8dkYGYO69v0m2ikASEzrYT/xSTPFumMxKwkSLU1X4CJ+ZL0=
X-Received: by 2002:a2e:b817:: with SMTP id u23mr4995069ljo.116.1618353295626;
 Tue, 13 Apr 2021 15:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210413153408.3027270-1-yhs@fb.com> <20210413153413.3027426-1-yhs@fb.com>
 <CAEf4BzZM3bLp=zFJ99ZX6iyM1D5gfB6eyweurVjn6iVOLdsrow@mail.gmail.com>
 <CAKwvOdnJYbBs=F2yZLqKvZX5_iHv_X_zCfQXSS3sv=iVDejL=w@mail.gmail.com> <e07d9794-75c1-f554-d827-26a02a6b09f1@fb.com>
In-Reply-To: <e07d9794-75c1-f554-d827-26a02a6b09f1@fb.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 13 Apr 2021 15:34:44 -0700
Message-ID: <CAKwvOdmFkDBawqHmnM11jB=4SaxonrAAv2m4oFx_PEMaYuBfog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests: set CC to clang in lib.mk if
 LLVM is set
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
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

Right, then later in the top level Makefile to achieve cross compilation support
 569 ifneq ($(CROSS_COMPILE),)
 570 CLANG_FLAGS += --target=$(notdir $(CROSS_COMPILE:%-=%))
...

The top level Makefile has this all wired up correctly; I wonder if
tools/ could make use of the existing exports, rather than redoing all
of that work?

>
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



-- 
Thanks,
~Nick Desaulniers
