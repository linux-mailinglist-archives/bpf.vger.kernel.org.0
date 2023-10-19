Return-Path: <bpf+bounces-12750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB08A7D0383
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 23:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08A928237E
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 21:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2B5374E6;
	Thu, 19 Oct 2023 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cX+nY9t/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D978208B8;
	Thu, 19 Oct 2023 21:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7034BC433C8;
	Thu, 19 Oct 2023 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697749716;
	bh=H0JSXdQwr27GBoH0/fMX6fSYgLkqdrKVJuYB9tG8i1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cX+nY9t/ak6xNjlOvV4hpYu77dyqggBi89tcXakzQrYV72t18gsnOwENnXitGzCkw
	 qpCpVU/7P6x5FbQMa+C9FU+xcsps4cwI0R+EtLsdfTnOoatS9j9tClJUl7WOeQEns5
	 f5DeHRyLdl8oyH+hGtrJlsDLOC3z+tvpoevyjswTuQQgeEd/sUiINrSKYIahsobPqe
	 V7qX8dw6jnwjgwkwtEM2gl+B6wYkrcpCfhRKUdDNbUtex8jOB1NFkz7t6tCgDCbnrD
	 nFVjeNdN0iYFRcTQ7vwtukdTDtRhd9ebZw969VY2lVlA0/rmuJ/rOm4YmcsIwjzO7S
	 OLFyN1urnAVUQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id C43D740016; Thu, 19 Oct 2023 18:08:33 -0300 (-03)
Date: Thu, 19 Oct 2023 18:08:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Manu Bretelle <chantr4@gmail.com>
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
Message-ID: <ZTGa0Ukt7QyxWcVy@kernel.org>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-2-irogers@google.com>
 <ZNZJCWi9MT/HZdQ/@kernel.org>
 <ZNZWsAXg2px1sm2h@kernel.org>
 <ZTGHRAlQtF7Fq8vn@surya>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTGHRAlQtF7Fq8vn@surya>
X-Url: http://acmel.wordpress.com

Em Thu, Oct 19, 2023 at 12:45:08PM -0700, Manu Bretelle escreveu:
> cc @quentin
> 
> On Fri, Aug 11, 2023 at 12:41:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Aug 11, 2023 at 11:43:22AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Right now it is not applying due to some clash with other changes and
> > > when I tried to apply it manually there were some formatting issues:
> > > 
> > > ⬢[acme@toolbox perf-tools-next]$ head ~/wb/1.patch
> > > From SRS0=EALy=D3=flex--irogers.bounces.google.com=3IDHVZAcKBAUnwtljwxlttlqj.htrfhrjpjwsjq.twl@kernel.org Thu Aug 10 17:53:46 2023
> > > Delivered-To: arnaldo.melo@gmail.com
> > > Received: from imap.gmail.com [64.233.186.109]
> > > 	by quaco with IMAP (fetchmail-6.4.37)
> > > 	for <acme@localhost> (single-drop); Thu, 10 Aug 2023 17:53:46 -0300 (-03)
> > > Received: by 2002:a0c:ab03:0:b0:63d:780e:9480 with SMTP id h3csp908198qvb;
> > >  Thu, 10 Aug 2023 11:49:52 -0700 (PDT)
> > > X-Google-Smtp-Source: AGHT+IH9N/knUCyQ0tQ2Q0XBH0gqf8A8DB8/37YHWAJDKBmz7AGSV9CvCKYDuE3EwxriZFBwtZMs
> > > X-Received: by 2002:a4a:6b4f:0:b0:56c:b2ab:9820 with SMTP id
> > >  h15-20020a4a6b4f000000b0056cb2ab9820mr2695332oof.8.1691693392493; Thu, 10 Aug
> > > ⬢[acme@toolbox perf-tools-next]$ patch -p1 < ~/wb/1.patch
> > > patching file tools/perf/Documentation/perf-config.txt
> > > patch: **** malformed patch at line 234: ith
> > > 
> > > ⬢[acme@toolbox perf-tools-next]$
> > > 
> > > I'm trying to apply it manually.
> > 
> > I have this extracted from this patch as the first patch in the series:
> > 
> > >From adc61b5774a9de62f34d593f164ca02daa6fb44c Mon Sep 17 00:00:00 2001
> > From: Ian Rogers <irogers@google.com>
> > Date: Fri, 11 Aug 2023 12:19:48 -0300
> > Subject: [PATCH 1/1] perf bpf: Remove support for embedding clang for
> >  compiling BPF events (-e foo.c)
> > 
> > This never was in the default build for perf, is difficult to maintain
> > as it uses clang/llvm internals so ditch it, keeping, for now, the
> > external compilation of .c BPF into .o bytecode and its subsequent
> > loading, that is also going to be removed, do it separately to help
> > bisection and to properly document what is being removed and why.
> > 
> > Committer notes:
> > 
> > Extracted from a larger patch and removed some leftovers, namely
> > deleting these now unused feature tests:
> > 
> >     tools/build/feature/test-clang.cpp
> >     tools/build/feature/test-cxx.cpp
> >     tools/build/feature/test-llvm-version.cpp
> >     tools/build/feature/test-llvm.cpp
> > 
> 
> This seem to have broken `llvm` feature detection for `bpftool`.
> 
> The feature detections are still available in `tools/build/Makefile.feature` [0]
> but the .cpp files are gone.
> 
> `bpftool` still rely on the `llvm` feature:
> 
>     $ git --no-pager grep 'feature-llvm'
>     tools/bpf/bpftool/Makefile:ifeq ($(feature-llvm),1)
> 
> The result of testing llvm feature is:
> 
>     $ cat tools/build/feature/test-llvm.make.output
>     cc1plus: fatal error: test-llvm.cpp: No such file or directory
>     compilation terminated.
> 
> With current head:
> 
>     make -j $((4*$(nproc))) -C tools/bpf/bpftool && ./tools/bpf/bpftool/bpftool --version
>     ...
>     Auto-detecting system features:
>     ...                         clang-bpf-co-re: [ on  ]
>     ...                                    llvm: [ OFF ]
>     ...                                  libcap: [ on  ]
>     ...                                  libbfd: [ on  ]
>     ...
>     ...
>     ...
>     bpftool v7.3.0
>     using libbpf v1.3
>     features: libbfd, skeletons
> 
> After applying
> 
>     git show 56b11a2126bf2f422831ecf6112b87a4485b221b  tools/build/feature | \
>         patch -p1 -R


Ouch, so probably we need just to reintroduce that one
tools/build/feature/test-llvm.cpp file.

Building perf these days ends up using bpftool, and the end result as
noticed with me testing perf, perf trace with bpf, etc didn't change, so
I didn't notice :-\

And:

ifeq ($(feature-llvm),1)
  # If LLVM is available, use it for JIT disassembly
  CFLAGS  += -DHAVE_LLVM_SUPPORT
  LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs $(LLVM_CONFIG_LIB_COMPONENTS))
  LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
  ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
    LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
    LIBS += -lstdc++
  endif
  LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
else
  # Fall back on libbfd
  ifeq ($(feature-libbfd),1)
    LIBS += -lbfd -ldl -lopcodes
  else ifeq ($(feature-libbfd-liberty),1)
    LIBS += -lbfd -ldl -lopcodes -liberty
  else ifeq ($(feature-libbfd-liberty-z),1)
    LIBS += -lbfd -ldl -lopcodes -liberty -lz
  endif

  # If one of the above feature combinations is set, we support libbfd
  ifneq ($(filter -lbfd,$(LIBS)),)
    CFLAGS += -DHAVE_LIBBFD_SUPPORT

    # Libbfd interface changed over time, figure out what we need
    ifeq ($(feature-disassembler-four-args), 1)
      CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
    endif
    ifeq ($(feature-disassembler-init-styled), 1)
      CFLAGS += -DDISASM_INIT_STYLED
    endif
  endif
endif

And there is a fallback to using binutils, so most people ended up not
noticing.

I wonder how to improve the current situation to detect these kinds of
problems in the future, i.e. how to notice that some file needed by some
Makefile, etc got removed or that some feature test fails because some
change in the test .c files makes them fail and thus activates fallbacks
like the one above :-\


So if I just get this back:

⬢[acme@toolbox perf-tools-next]$ cat tools/build/feature/test-llvm.cpp
// SPDX-License-Identifier: GPL-2.0
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/raw_ostream.h"
#define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR << 8) + LLVM_VERSION_PATCH)

#if NUM_VERSION < 0x030900
# error "LLVM version too low"
#endif
int main()
{
	llvm::errs() << "Hello World!\n";
	llvm::llvm_shutdown();
	return 0;
}
⬢[acme@toolbox perf-tools-next]$

And install the llvm-devel package then it back working:

⬢[acme@toolbox perf-tools-next]$ make -C tools/bpf/bpftool
make: Entering directory '/home/acme/git/perf-tools-next/tools/bpf/bpftool'

Auto-detecting system features:
...                         clang-bpf-co-re: [ on  ]
...                                    llvm: [ on  ]
...                                  libcap: [ on  ]
...                                  libbfd: [ on  ]
<SNIP>
⬢[acme@toolbox perf-tools-next]$ cat tools/build/feature/test-llvm.make.output
⬢[acme@toolbox perf-tools-next]$ ls -la tools/build/feature/test-llvm.
test-llvm.bin          test-llvm.cpp          test-llvm.d            test-llvm.make.output
⬢[acme@toolbox perf-tools-next]$ ls -la tools/build/feature/test-llvm.bin
-rwxr-xr-x. 1 acme acme 17712 Oct 19 18:04 tools/build/feature/test-llvm.bin
⬢[acme@toolbox perf-tools-next]$ ldd tools/build/feature/test-llvm.bin
	linux-vdso.so.1 (0x00007ffcaf5d9000)
	libLLVM-16.so => /lib64/libLLVM-16.so (0x00007fc4faefa000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007fc4faca6000)
	libm.so.6 => /lib64/libm.so.6 (0x00007fc4fabc5000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007fc4faba1000)
	libc.so.6 => /lib64/libc.so.6 (0x00007fc4fa9c3000)
	libffi.so.8 => /lib64/libffi.so.8 (0x00007fc4fa9b7000)
	libedit.so.0 => /lib64/libedit.so.0 (0x00007fc4fa978000)
	libz.so.1 => /lib64/libz.so.1 (0x00007fc4fa95e000)
	libtinfo.so.6 => /lib64/libtinfo.so.6 (0x00007fc4fa92b000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fc502404000)
⬢[acme@toolbox perf-tools-next]$ sudo dnf install llvm-devel

I'll get this merged in my perf-tools-fixes-for-v6.6 that I'll submit
tomorrow to Linus, thanks for reporting!

I'll add your:

Reported-by: Manu Bretelle <chantr4@gmail.com>

And:

Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")

Ok?

- Arnaldo

