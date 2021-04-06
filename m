Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B93355B8E
	for <lists+bpf@lfdr.de>; Tue,  6 Apr 2021 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhDFSks (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Apr 2021 14:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347118AbhDFSjb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Apr 2021 14:39:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F01C061760
        for <bpf@vger.kernel.org>; Tue,  6 Apr 2021 11:39:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 12so24191863lfq.13
        for <bpf@vger.kernel.org>; Tue, 06 Apr 2021 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQMr+myNry7kMYJRVZWeSVgVa7oM6pbfeSZSl/6u29k=;
        b=Pejc/BsA8L+TrZPdOwGHEPycuL6xNz5a8xRww8TuUSCgKj81lbNaCMvZ5AezmAQOo3
         iHffyxnvTmFH7xH1zeco1pel6rsL9/SLE7+vYfV8Q2byaIXSP/WyDIdz4/JhkoV6E8ao
         C196PK+sW2SGOEDgD4CihqKsl+i2l6NvINN+hzneYJZhSlabo9suuKlOcZ/teKY+epXk
         kIrWCtpa0jSvxVILeR85ZnCyHpvG4AZhXKnFjw+GO3gN/C1spLIA7WFl6kUWAMxToRRh
         SaeHhHZntayiEUo9dRoaT4nPrF2Hy/fyJdSa6aJCTo3TUuTtNphN9MjO2NCNY3GDLRf8
         vZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQMr+myNry7kMYJRVZWeSVgVa7oM6pbfeSZSl/6u29k=;
        b=XY7zWare4zCsqbDBH1RJUY0W1ldGLRTF/LiOJ5L/Ss+mfrNHgKmC4sf5j6j65NT0hm
         g2Ptn+UQeDaes84+eZzeSif+5bhmgzK7WVntxJyet75jnhd6yOC0QzrhT10s2NF+9uO6
         we9uCau7HxLkhGCmttutdVExthqmeoxNo1uF2JezEnjef6YYv9a0KY7O/2OQ4ngazKDh
         DFYuFQLn5J0nBBmadi0YtoJYkKAOxGNj2aK15v2h9NOamjFyVodrtD1DzSrUzjOYlywz
         nARvp6j2jPhGWzsn6jJpMKQnXoTfIMvOpbbfN1w64qdrGGexuoxj7ksnfTiw6PFRzPSO
         CriA==
X-Gm-Message-State: AOAM530GogRHqR1a1Ve2OKdcA+d+aoDczjOO/hAGMzbiU74nfjKJVNW+
        SaSpt7ImdPLScICKN1iaiHj0BdsPHAdwBK89QbIFNA==
X-Google-Smtp-Source: ABdhPJwfF8QTg6t910CMAqJ9lPp1gWVxBDXydZblUn3PzjSJ4R76U4j8NWJdIQODLYvQGTNNGH20bVl5J4NuLLVRId0=
X-Received: by 2002:a19:8c19:: with SMTP id o25mr22129544lfd.547.1617734360307;
 Tue, 06 Apr 2021 11:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <CA+icZUVxpkCJVnibqm3+OYdfdh5U=eU_u7pPKUZMoPm3XzZWPQ@mail.gmail.com>
In-Reply-To: <CA+icZUVxpkCJVnibqm3+OYdfdh5U=eU_u7pPKUZMoPm3XzZWPQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Apr 2021 11:39:09 -0700
Message-ID: <CAKwvOdn+ScOD=LyU+4CxL6AOpfjXuzzQD-=TuM9ER-Q8Wposuw@mail.gmail.com>
Subject: Re: Usage of CXX in tools directory
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, kernel-team@fb.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 4, 2021 at 8:00 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> [ Please CC me I am not subscribed to all mailing-lists ]
> [ Please CC some more folks if you like ]
>
> Hi,
>
> when dealing/experimenting with BPF together with pahole/dwarves and
> dwarf-v5 and clang-lto I fell over that there is usage of CXX in tools
> directory.
> Especially,  I wanted to build and run test_progs from BPF selftests.
> One BPF selftest called "test_cpp" used GNU/g++ (and even /usr/bin/ld)
> and NOT LLVM/clang++.
>
> For details see the linux-bpf/dwarves thread "[PATCH dwarves]
> dwarf_loader: handle DWARF5 DW_OP_addrx properly" in [1].
>
> Lemme check:
>
> $ git grep CXX tools/
> tools/build/Build.include:cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@
> $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXXFLAGS_$(basetarget).o)
> $(CXXFLAGS_$(obj))
> tools/build/Makefile.build:quiet_cmd_cxx_o_c = CXX      $@
> tools/build/Makefile.build:      cmd_cxx_o_c = $(CXX) $(cxx_flags) -c -o $@ $<
> tools/build/Makefile.feature:  feature-$(1) := $(shell $(MAKE)
> OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)"
> CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))"
> CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))"
> LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir)
> $(OUTPUT_FEATURES)test-$1.bin >/dev/nu
> ll 2>/dev/null && echo 1 || echo 0)
> tools/build/feature/Makefile:__BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall
> -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
> ...
> tools/perf/Makefile.config:USE_CXX = 0
> tools/perf/Makefile.config:        CXXFLAGS +=
> -DHAVE_LIBCLANGLLVM_SUPPORT -I$(shell $(LLVM_CONFIG) --includedir)
> tools/perf/Makefile.config:        $(call detected,CONFIG_CXX)
> tools/perf/Makefile.config:     USE_CXX = 1
> tools/perf/Makefile.perf:export srctree OUTPUT RM CC CXX LD AR CFLAGS
> CXXFLAGS V BISON FLEX AWK
> tools/perf/Makefile.perf:ifeq ($(USE_CXX), 1)
> tools/perf/util/Build:perf-$(CONFIG_CXX) += c++/
> ...
> tools/scripts/Makefile.include:$(call allow-override,CXX,$(CROSS_COMPILE)g++)
> ...
> tools/testing/selftests/bpf/Makefile:CXX ?= $(CROSS_COMPILE)g++
> tools/testing/selftests/bpf/Makefile:   $(call msg,CXX,,$@)
> tools/testing/selftests/bpf/Makefile:   $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
>
> The problem is if you pass LLVM=1 there is no clang(++) assigned to
> CXX automagically.
>
> [2] says:
>
> LLVM has substitutes for GNU binutils utilities. Kbuild supports
> LLVM=1 to enable them.
>
> make LLVM=1
> They can be enabled individually. The full list of the parameters:
>
> make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
>   OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
>   HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld
>
> [ EndOfQuote  ]
>
> So you need to pass CXX=clang++ manually when playing in tools directory:

Yes, CXX is not set by LLVM=1 in the top level Makefile.  CXX is not
exported by the top level Makefile.  I suspect that
tools/scripts/Mafefile.include (and possible
testing/selftests/bpf/Makefile) needs to check for LLVM=1 and set
CXX=clang++ explicitly.

>
> MAKE="make V=1
> MAKE_OPTS="HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
> CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1"
> MAKE_OPTS="MAKE_OPTS $PAHOLE=/opt/pahole/bin/pahole"
>
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ clean
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/
>
> Unsure, if tools needs a special treatment in things of CXX or LLVM=1
> needs to be enhanced with CCX=clang++.
> If we have HOSTCXX why not have a CXX in toplevel Makefile?
>
> In "tools: Factor Clang, LLC and LLVM utils definitions" (see [3]) I
> did some factor-ing.
>
> For the records: Here Linus Git is my base.
>
> Ideas?
>
> Thanks.
>
> Regards,
> - Sedat -
>
> P.S.: Just a small note: I know there is less usage of CXX code in the
> linux-kernel.
>
> [1] https://lore.kernel.org/bpf/CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com/T/#m22907f838d2d27be24e8959a53473a62f21cecea
> [2] https://www.kernel.org/doc/html/latest/kbuild/llvm.html#llvm-utilities
> [3] https://git.kernel.org/linus/211a741cd3e124bffdc13ee82e7e65f204e53f60



-- 
Thanks,
~Nick Desaulniers
