Return-Path: <bpf+bounces-12757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59A57D04FD
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 00:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9591C20F29
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 22:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BC44293A;
	Thu, 19 Oct 2023 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHalHtrp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC2619440;
	Thu, 19 Oct 2023 22:50:17 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA403131;
	Thu, 19 Oct 2023 15:50:13 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6b1ef786b7fso222037b3a.3;
        Thu, 19 Oct 2023 15:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697755751; x=1698360551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XeuxhbL7vpdq+m2OoRWGrD8WFTUXTNIau8KjCs7qNc8=;
        b=AHalHtrp5gLiiXNrDCkL9pCtk95NaAv6gcUOjvJ4CrzzFK69/nHVT9IyVHsmRli9cU
         FMaStCTQasevbY2Q6YS5jlC+4wL8Vfd/cM1r8qClQ/fBd/JHh6j84GVA2mhQaxMltgVp
         W4+nkDlnW4qlLGrcdFSPT2BCwZzilMcUsFLT42d0BOG2YnIKooebNdLi2+Q1hJG4DJa5
         btvZTu+ajOepbgSit7WLSy7+JvDMGuVhXiQnAEPbZyJ1dvDt3BKtDjm9fQUI8bvwzsBW
         08hzYqxaMYZ3WTU6uKwRYSv2Un0kvaDcNT7QnUTL263T26BZN1gat/8BDvnBngiTHaAX
         0Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697755751; x=1698360551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeuxhbL7vpdq+m2OoRWGrD8WFTUXTNIau8KjCs7qNc8=;
        b=vHXxEm93XVPoN7eLcxcDzm8/GMmvi/UinDzSrTwTJ1WupZ/R/emwqeK366bOeLzA26
         Jemais0t7bcAqu2MEDFrKgWjHywOo8tjt8R7H1y2Bvb8hR1a4uM5I2jSOD6Ld9pvddzn
         6QtzPbhwS76Ovz3JyqUH5q2OuB4HSjmjduTbC7hLW/ppHbo89ZETZqsSEZfmCKZnl1qc
         HCGE2/zNaJgKssvMNyzRvgwEZ5WT/r8hsCE+fkM3nmsaJsX6ONiz2l8Ttkf2kAVEOOtN
         n3DgO9834HXoLmNjeK+tjAIgWU3GxdUlL1O0RH0hA5mQyD8z19jYsCemCkm9cCGwO8D0
         i9vw==
X-Gm-Message-State: AOJu0YyRMBifPTigDjptZaT2jjNWlTgiw0LBw6iTeJL/UR2kAJXl4Pi1
	xhvhXuLr7o9hZIckGpRL5BQ=
X-Google-Smtp-Source: AGHT+IGacodOwEc5GMYnlTMgTwLHFrtILIADBX9EYP3gkcPuNLWFI7S0yOulRoIvnrvFl2gPl7QFRQ==
X-Received: by 2002:aa7:93c9:0:b0:6b8:828:d934 with SMTP id y9-20020aa793c9000000b006b80828d934mr116442pff.6.1697755750502;
        Thu, 19 Oct 2023 15:49:10 -0700 (PDT)
Received: from surya ([2600:1700:3ec2:2011:b14a:c750:3938:f592])
        by smtp.gmail.com with ESMTPSA id y13-20020aa79e0d000000b0068aca503b9fsm278544pfq.114.2023.10.19.15.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 15:49:10 -0700 (PDT)
Date: Thu, 19 Oct 2023 15:48:56 -0700
From: Manu Bretelle <chantr4@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	James Clark <james.clark@arm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, Wang Nan <wangnan0@huawei.com>,
	Wang ShaoBo <bobo.shaobowang@huawei.com>,
	YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>,
	Brendan Gregg <brendan.d.gregg@gmail.com>,
	Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v1 1/4] perf parse-events: Remove BPF event support
Message-ID: <ZTGyWHTOE8OEhQWq@surya>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-2-irogers@google.com>
 <ZNZJCWi9MT/HZdQ/@kernel.org>
 <ZNZWsAXg2px1sm2h@kernel.org>
 <ZTGHRAlQtF7Fq8vn@surya>
 <ZTGa0Ukt7QyxWcVy@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTGa0Ukt7QyxWcVy@kernel.org>

On Thu, Oct 19, 2023 at 06:08:33PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 19, 2023 at 12:45:08PM -0700, Manu Bretelle escreveu:
> > cc @quentin
> > 
> > On Fri, Aug 11, 2023 at 12:41:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Aug 11, 2023 at 11:43:22AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Right now it is not applying due to some clash with other changes and
> > > > when I tried to apply it manually there were some formatting issues:
> > > > 
> > > > ⬢[acme@toolbox perf-tools-next]$ head ~/wb/1.patch
> > > > From SRS0=EALy=D3=flex--irogers.bounces.google.com=3IDHVZAcKBAUnwtljwxlttlqj.htrfhrjpjwsjq.twl@kernel.org Thu Aug 10 17:53:46 2023
> > > > Delivered-To: arnaldo.melo@gmail.com
> > > > Received: from imap.gmail.com [64.233.186.109]
> > > > 	by quaco with IMAP (fetchmail-6.4.37)
> > > > 	for <acme@localhost> (single-drop); Thu, 10 Aug 2023 17:53:46 -0300 (-03)
> > > > Received: by 2002:a0c:ab03:0:b0:63d:780e:9480 with SMTP id h3csp908198qvb;
> > > >  Thu, 10 Aug 2023 11:49:52 -0700 (PDT)
> > > > X-Google-Smtp-Source: AGHT+IH9N/knUCyQ0tQ2Q0XBH0gqf8A8DB8/37YHWAJDKBmz7AGSV9CvCKYDuE3EwxriZFBwtZMs
> > > > X-Received: by 2002:a4a:6b4f:0:b0:56c:b2ab:9820 with SMTP id
> > > >  h15-20020a4a6b4f000000b0056cb2ab9820mr2695332oof.8.1691693392493; Thu, 10 Aug
> > > > ⬢[acme@toolbox perf-tools-next]$ patch -p1 < ~/wb/1.patch
> > > > patching file tools/perf/Documentation/perf-config.txt
> > > > patch: **** malformed patch at line 234: ith
> > > > 
> > > > ⬢[acme@toolbox perf-tools-next]$
> > > > 
> > > > I'm trying to apply it manually.
> > > 
> > > I have this extracted from this patch as the first patch in the series:
> > > 
> > > >From adc61b5774a9de62f34d593f164ca02daa6fb44c Mon Sep 17 00:00:00 2001
> > > From: Ian Rogers <irogers@google.com>
> > > Date: Fri, 11 Aug 2023 12:19:48 -0300
> > > Subject: [PATCH 1/1] perf bpf: Remove support for embedding clang for
> > >  compiling BPF events (-e foo.c)
> > > 
> > > This never was in the default build for perf, is difficult to maintain
> > > as it uses clang/llvm internals so ditch it, keeping, for now, the
> > > external compilation of .c BPF into .o bytecode and its subsequent
> > > loading, that is also going to be removed, do it separately to help
> > > bisection and to properly document what is being removed and why.
> > > 
> > > Committer notes:
> > > 
> > > Extracted from a larger patch and removed some leftovers, namely
> > > deleting these now unused feature tests:
> > > 
> > >     tools/build/feature/test-clang.cpp
> > >     tools/build/feature/test-cxx.cpp
> > >     tools/build/feature/test-llvm-version.cpp
> > >     tools/build/feature/test-llvm.cpp
> > > 
> > 
> > This seem to have broken `llvm` feature detection for `bpftool`.
> > 
> > The feature detections are still available in `tools/build/Makefile.feature` [0]
> > but the .cpp files are gone.
> > 
> > `bpftool` still rely on the `llvm` feature:
> > 
> >     $ git --no-pager grep 'feature-llvm'
> >     tools/bpf/bpftool/Makefile:ifeq ($(feature-llvm),1)
> > 
> > The result of testing llvm feature is:
> > 
> >     $ cat tools/build/feature/test-llvm.make.output
> >     cc1plus: fatal error: test-llvm.cpp: No such file or directory
> >     compilation terminated.
> > 
> > With current head:
> > 
> >     make -j $((4*$(nproc))) -C tools/bpf/bpftool && ./tools/bpf/bpftool/bpftool --version
> >     ...
> >     Auto-detecting system features:
> >     ...                         clang-bpf-co-re: [ on  ]
> >     ...                                    llvm: [ OFF ]
> >     ...                                  libcap: [ on  ]
> >     ...                                  libbfd: [ on  ]
> >     ...
> >     ...
> >     ...
> >     bpftool v7.3.0
> >     using libbpf v1.3
> >     features: libbfd, skeletons
> > 
> > After applying
> > 
> >     git show 56b11a2126bf2f422831ecf6112b87a4485b221b  tools/build/feature | \
> >         patch -p1 -R
> 
> 
> Ouch, so probably we need just to reintroduce that one
> tools/build/feature/test-llvm.cpp file.

Yes, I believe so. From git-grepping `feature-<feature>`, only `feature-llvm` came up.

I suppose as part of the cleanup the features should have been
removed from tools/build/Makefile.feature too.
 
> 
> Building perf these days ends up using bpftool, and the end result as
> noticed with me testing perf, perf trace with bpf, etc didn't change, so
> I didn't notice :-\
> 
> And:
> 
> ifeq ($(feature-llvm),1)
>   # If LLVM is available, use it for JIT disassembly
>   CFLAGS  += -DHAVE_LLVM_SUPPORT
>   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
>   CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>   LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
>     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
>     LIBS += -lstdc++
>   endif
>   LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
> else
>   # Fall back on libbfd
>   ifeq ($(feature-libbfd),1)
>     LIBS += -lbfd -ldl -lopcodes
>   else ifeq ($(feature-libbfd-liberty),1)
>     LIBS += -lbfd -ldl -lopcodes -liberty
>   else ifeq ($(feature-libbfd-liberty-z),1)
>     LIBS += -lbfd -ldl -lopcodes -liberty -lz
>   endif
> 
>   # If one of the above feature combinations is set, we support libbfd
>   ifneq ($(filter -lbfd,$(LIBS)),)
>     CFLAGS += -DHAVE_LIBBFD_SUPPORT
> 
>     # Libbfd interface changed over time, figure out what we need
>     ifeq ($(feature-disassembler-four-args), 1)
>       CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
>     endif
>     ifeq ($(feature-disassembler-init-styled), 1)
>       CFLAGS += -DDISASM_INIT_STYLED
>     endif
>   endif
> endif
> 
> And there is a fallback to using binutils, so most people ended up not
> noticing.

Yes, definitely, the fallback make it harder to easily detect.
I detected it because I was manually building bpftool and it was odd that llvm
was not detected.

> 
> I wonder how to improve the current situation to detect these kinds of
> problems in the future, i.e. how to notice that some file needed by some
> Makefile, etc got removed or that some feature test fails because some
> change in the test .c files makes them fail and thus activates fallbacks
> like the one above :-\

I think it is tricky. Specifically to this situation, some CI could try to build
the different combinaison of bpftool and check the features through the build
`bpftool --version`.
This is actually a test that I run internally to make sure our build has some
feature enabled.
This is actually tested by bpftool in the GH CI:
https://github.com/libbpf/bpftool/blob/main/.github/workflows/build.yaml#L62

As a matter of fact, it would not have been detected because that CI uses a
different Makefile.feature.

Quentin and I were talking offline how we could improve bpftool CI at diff time.
This is an example where it would have helped :)

> 
> 
> So if I just get this back:
> 
> ⬢[acme@toolbox perf-tools-next]$ cat tools/build/feature/test-llvm.cpp
> // SPDX-License-Identifier: GPL-2.0
> #include "llvm/Support/ManagedStatic.h"
> #include "llvm/Support/raw_ostream.h"
> #define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR << 8) + LLVM_VERSION_PATCH)
> 
> #if NUM_VERSION < 0x030900
> # error "LLVM version too low"
> #endif
> int main()
> {
> 	llvm::errs() << "Hello World!\n";
> 	llvm::llvm_shutdown();
> 	return 0;
> }
> ⬢[acme@toolbox perf-tools-next]$
> 
> And install the llvm-devel package then it back working:
> 
> ⬢[acme@toolbox perf-tools-next]$ make -C tools/bpf/bpftool
> make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'
> 
> Auto-detecting system features:
> ...                         clang-bpf-co-re: [ on  ]
> ...                                    llvm: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libbfd: [ on  ]
> <SNIP>
> ⬢[acme@toolbox perf-tools-next]$ cat tools/build/feature/test-llvm.make.output
> ⬢[acme@toolbox perf-tools-next]$ ls -la tools/build/feature/test-llvm.
> test-llvm.bin          test-llvm.cpp          test-llvm.d            test-llvm.make.output
> ⬢[acme@toolbox perf-tools-next]$ ls -la tools/build/feature/test-llvm.bin
> -rwxr-xr-x. 1 acme acme 17712 Oct 19 18:04 tools/build/feature/test-llvm.bin
> ⬢[acme@toolbox perf-tools-next]$ ldd tools/build/feature/test-llvm.bin
> 	linux-vdso.so.1 (0x00007ffcaf5d9000)
> 	libLLVM-16.so => /lib64/libLLVM-16.so (0x00007fc4faefa000)
> 	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007fc4faca6000)
> 	libm.so.6 => /lib64/libm.so.6 (0x00007fc4fabc5000)
> 	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fc4faba1000)
> 	libc.so.6 => /lib64/libc.so.6 (0x00007fc4fa9c3000)
> 	libffi.so.8 => /lib64/libffi.so.8 (0x00007fc4fa9b7000)
> 	libedit.so.0 => /lib64/libedit.so.0 (0x00007fc4fa978000)
> 	libz.so.1 => /lib64/libz.so.1 (0x00007fc4fa95e000)
> 	libtinfo.so.6 => /lib64/libtinfo.so.6 (0x00007fc4fa92b000)
> 	/lib64/ld-linux-x86-64.so.2 (0x00007fc502404000)
> ⬢[acme@toolbox perf-tools-next]$ sudo dnf install llvm-devel
> 
> I'll get this merged in my perf-tools-fixes-for-v6.6 that I'll submit
> tomorrow to Linus, thanks for reporting!
> 
> I'll add your:
> 
> Reported-by: Manu Bretelle <chantr4@gmail.com>
> 
> And:
> 
> Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")
> 
> Ok?

SGTM. Thanks for the quick turnaround.

Reviewed-by: Manu Bretelle <chantr4@gmail.com>

> 
> - Arnaldo

