Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C308D35388D
	for <lists+bpf@lfdr.de>; Sun,  4 Apr 2021 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhDDPAO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Apr 2021 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhDDPAN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Apr 2021 11:00:13 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D419C061756;
        Sun,  4 Apr 2021 08:00:09 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id f5so4361342ilr.9;
        Sun, 04 Apr 2021 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9FrXMbErno7+UYPolFaJfl1BWKDlG9+WhG9WCIdSW3Y=;
        b=onvXjgrBqg12q0WD25RWxGBE6z4XpdAN/W674nyzW+tqaZt03LW8VeZBpi9Fg6L+EC
         P/kadJcTybKoLavNo7fkP8w2fqke1pRvxPu9MQYAxESLZqtuwv2cZJwR6ZUGVI2HiuUW
         uKxuG7lJDzJ1RCWgTrXGGCk4jTBL1nXPyZ/X7mpsrJVLxsxd43RktbFouwmiN94OlbHQ
         L0rsl915ydoh1YO74xQR45FlIJoz7rOKgKV1KL1v75iLRayADwmdgNXTQLeHN6zXImZy
         /M5KzVkEcTkLKvltNfCMwLVlVEHmVgng3jk0rVK/czUdRFkD7L1tnp9HRQsFCbub6XNd
         GD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9FrXMbErno7+UYPolFaJfl1BWKDlG9+WhG9WCIdSW3Y=;
        b=mplG8fFs3mxuWD17uRf7curWyLXAuhn9k44I4GDbwCvS65XYrDPqtoxXhhCZcIvSrJ
         bdBUCgLmisATEc9XY2UOAB64Ntuy2J61+HETBqiSW6M3XCQ61NYlCX18rrobBKDhU6/U
         AgjytXhX+jcq1zoGSmJJrhPKMwRMiBEq1qjunbfdS5XWguw8obqKhd7o5eHhjzyQ6y5F
         I6qq2QyCm7rlbt8dhq5nD2ut/ePJlu4l7x+uyOOSm62QSANdbuaes6FEA61H0K2n8Gg1
         Vv6hzmIUtFG6f5KBwJlbWWi8C06WfERFzD4SplbTHKV0wF59fhECrTIn1S1KUHhRzZfb
         AeJA==
X-Gm-Message-State: AOAM530Od8Nf6X7R8nLNwYXyr3khp2DAZyA8yp9glYG4gaTm+Qzli4On
        6iIh/NpjeQN7P7OMny08Ua18vTgySGoo3OIvTd0=
X-Google-Smtp-Source: ABdhPJxUTt+pEOsKbPqgbHjkw0y9uyAGt6YEvM5dlBAPGx/1R+pdO8shyQsqjSkZ/v6Hdk/Xbog9PnM7LoJim+SjGi4=
X-Received: by 2002:a05:6e02:12cc:: with SMTP id i12mr17423767ilm.10.1617548408261;
 Sun, 04 Apr 2021 08:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com>
In-Reply-To: <20210403184158.2834387-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 4 Apr 2021 16:59:33 +0200
Message-ID: <CA+icZUVxpkCJVnibqm3+OYdfdh5U=eU_u7pPKUZMoPm3XzZWPQ@mail.gmail.com>
Subject: Usage of CXX in tools directory
To:     Masahiro Yamada <masahiroy@kernel.org>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[ Please CC me I am not subscribed to all mailing-lists ]
[ Please CC some more folks if you like ]

Hi,

when dealing/experimenting with BPF together with pahole/dwarves and
dwarf-v5 and clang-lto I fell over that there is usage of CXX in tools
directory.
Especially,  I wanted to build and run test_progs from BPF selftests.
One BPF selftest called "test_cpp" used GNU/g++ (and even /usr/bin/ld)
and NOT LLVM/clang++.

For details see the linux-bpf/dwarves thread "[PATCH dwarves]
dwarf_loader: handle DWARF5 DW_OP_addrx properly" in [1].

Lemme check:

$ git grep CXX tools/
tools/build/Build.include:cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@
$(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXXFLAGS_$(basetarget).o)
$(CXXFLAGS_$(obj))
tools/build/Makefile.build:quiet_cmd_cxx_o_c = CXX      $@
tools/build/Makefile.build:      cmd_cxx_o_c = $(CXX) $(cxx_flags) -c -o $@ $<
tools/build/Makefile.feature:  feature-$(1) := $(shell $(MAKE)
OUTPUT=$(OUTPUT_FEATURES) CC="$(CC)" CXX="$(CXX)"
CFLAGS="$(EXTRA_CFLAGS) $(FEATURE_CHECK_CFLAGS-$(1))"
CXXFLAGS="$(EXTRA_CXXFLAGS) $(FEATURE_CHECK_CXXFLAGS-$(1))"
LDFLAGS="$(LDFLAGS) $(FEATURE_CHECK_LDFLAGS-$(1))" -C $(feature_dir)
$(OUTPUT_FEATURES)test-$1.bin >/dev/nu
ll 2>/dev/null && echo 1 || echo 0)
tools/build/feature/Makefile:__BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall
-Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
...
tools/perf/Makefile.config:USE_CXX = 0
tools/perf/Makefile.config:        CXXFLAGS +=
-DHAVE_LIBCLANGLLVM_SUPPORT -I$(shell $(LLVM_CONFIG) --includedir)
tools/perf/Makefile.config:        $(call detected,CONFIG_CXX)
tools/perf/Makefile.config:     USE_CXX = 1
tools/perf/Makefile.perf:export srctree OUTPUT RM CC CXX LD AR CFLAGS
CXXFLAGS V BISON FLEX AWK
tools/perf/Makefile.perf:ifeq ($(USE_CXX), 1)
tools/perf/util/Build:perf-$(CONFIG_CXX) += c++/
...
tools/scripts/Makefile.include:$(call allow-override,CXX,$(CROSS_COMPILE)g++)
...
tools/testing/selftests/bpf/Makefile:CXX ?= $(CROSS_COMPILE)g++
tools/testing/selftests/bpf/Makefile:   $(call msg,CXX,,$@)
tools/testing/selftests/bpf/Makefile:   $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@

The problem is if you pass LLVM=1 there is no clang(++) assigned to
CXX automagically.

[2] says:

LLVM has substitutes for GNU binutils utilities. Kbuild supports
LLVM=1 to enable them.

make LLVM=1
They can be enabled individually. The full list of the parameters:

make CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm STRIP=llvm-strip \
  OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf \
  HOSTCC=clang HOSTCXX=clang++ HOSTAR=llvm-ar HOSTLD=ld.lld

[ EndOfQuote  ]

So you need to pass CXX=clang++ manually when playing in tools directory:

MAKE="make V=1
MAKE_OPTS="HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1"
MAKE_OPTS="MAKE_OPTS $PAHOLE=/opt/pahole/bin/pahole"

$ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ clean
$ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/

Unsure, if tools needs a special treatment in things of CXX or LLVM=1
needs to be enhanced with CCX=clang++.
If we have HOSTCXX why not have a CXX in toplevel Makefile?

In "tools: Factor Clang, LLC and LLVM utils definitions" (see [3]) I
did some factor-ing.

For the records: Here Linus Git is my base.

Ideas?

Thanks.

Regards,
- Sedat -

P.S.: Just a small note: I know there is less usage of CXX code in the
linux-kernel.

[1] https://lore.kernel.org/bpf/CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com/T/#m22907f838d2d27be24e8959a53473a62f21cecea
[2] https://www.kernel.org/doc/html/latest/kbuild/llvm.html#llvm-utilities
[3] https://git.kernel.org/linus/211a741cd3e124bffdc13ee82e7e65f204e53f60
