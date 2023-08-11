Return-Path: <bpf+bounces-7558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F1077935F
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BA32821AC
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367422AB3C;
	Fri, 11 Aug 2023 15:41:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB7863B6;
	Fri, 11 Aug 2023 15:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC65C433C8;
	Fri, 11 Aug 2023 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691768499;
	bh=0Gkze0+TJn9weTx+JArfCPiygQFQZCsnN4AG4BOvgDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXE8mbJCGtR7FmwL6X0b6CMNx9zV6pXRdmHrVb2uWFmq5C9Zn/uH6wW7uwI3yLTF9
	 P/oN86d7quT0kLdppJXSnlr2kMl1M0/ZLcc4D7rRwGKC6klUa8rF5JAC1+13tYbak/
	 EFT37Wd7viRBirCtPngXn8r8PDFIOPfJ5n0rDneVeIojGYThrZZgx8Pvt6QQufFcof
	 w8aCX6qQ1RYYxaTVwOM+OCW+wLX8Qe/RgbR/panygrF9kNkWh05U3xQtPyDcpli+5C
	 l6Ze5OFyV0ZXpFxRVSgKYRHbxe5PAsKoJCZF9s6yX8CXPcAWuUteumhY7olBn+21F3
	 CrmAg2NUvLflw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 5CB56404DF; Fri, 11 Aug 2023 12:41:36 -0300 (-03)
Date: Fri, 11 Aug 2023 12:41:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v1 1/4] perf parse-events: Remove BPF event support
Message-ID: <ZNZWsAXg2px1sm2h@kernel.org>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-2-irogers@google.com>
 <ZNZJCWi9MT/HZdQ/@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNZJCWi9MT/HZdQ/@kernel.org>
X-Url: http://acmel.wordpress.com

Em Fri, Aug 11, 2023 at 11:43:22AM -0300, Arnaldo Carvalho de Melo escreveu:
> Right now it is not applying due to some clash with other changes and
> when I tried to apply it manually there were some formatting issues:
> 
> ⬢[acme@toolbox perf-tools-next]$ head ~/wb/1.patch
> From SRS0=EALy=D3=flex--irogers.bounces.google.com=3IDHVZAcKBAUnwtljwxlttlqj.htrfhrjpjwsjq.twl@kernel.org Thu Aug 10 17:53:46 2023
> Delivered-To: arnaldo.melo@gmail.com
> Received: from imap.gmail.com [64.233.186.109]
> 	by quaco with IMAP (fetchmail-6.4.37)
> 	for <acme@localhost> (single-drop); Thu, 10 Aug 2023 17:53:46 -0300 (-03)
> Received: by 2002:a0c:ab03:0:b0:63d:780e:9480 with SMTP id h3csp908198qvb;
>  Thu, 10 Aug 2023 11:49:52 -0700 (PDT)
> X-Google-Smtp-Source: AGHT+IH9N/knUCyQ0tQ2Q0XBH0gqf8A8DB8/37YHWAJDKBmz7AGSV9CvCKYDuE3EwxriZFBwtZMs
> X-Received: by 2002:a4a:6b4f:0:b0:56c:b2ab:9820 with SMTP id
>  h15-20020a4a6b4f000000b0056cb2ab9820mr2695332oof.8.1691693392493; Thu, 10 Aug
> ⬢[acme@toolbox perf-tools-next]$ patch -p1 < ~/wb/1.patch
> patching file tools/perf/Documentation/perf-config.txt
> patch: **** malformed patch at line 234: ith
> 
> ⬢[acme@toolbox perf-tools-next]$
> 
> I'm trying to apply it manually.

I have this extracted from this patch as the first patch in the series:

From adc61b5774a9de62f34d593f164ca02daa6fb44c Mon Sep 17 00:00:00 2001
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Aug 2023 12:19:48 -0300
Subject: [PATCH 1/1] perf bpf: Remove support for embedding clang for
 compiling BPF events (-e foo.c)

This never was in the default build for perf, is difficult to maintain
as it uses clang/llvm internals so ditch it, keeping, for now, the
external compilation of .c BPF into .o bytecode and its subsequent
loading, that is also going to be removed, do it separately to help
bisection and to properly document what is being removed and why.

Committer notes:

Extracted from a larger patch and removed some leftovers, namely
deleting these now unused feature tests:

    tools/build/feature/test-clang.cpp
    tools/build/feature/test-cxx.cpp
    tools/build/feature/test-llvm-version.cpp
    tools/build/feature/test-llvm.cpp

Testing the use of BPF events after applying this patch:

To use the external clang/llvm toolchain to compile a .c event and then
use libbpf to load it, to get the syscalls:sys_enter_open* tracepoints
and read the filename pointer, putting it into the ring buffer right
after the usual tracepoint payload for 'perf trace' to then print it:

  [root@quaco ~]# perf trace -e /home/acme/git/perf-tools-next/tools/perf/examples/bpf/augmented_raw_syscalls.c,open* --max-events=10
     0.000 systemd-oomd/959 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC) = 12
     0.083 abrt-dump-jour/1453 openat(dfd: CWD, filename: "/var/log/journal/d6a97235307247e09f13f326fb607e3c/system.journal", flags: RDONLY|CLOEXEC|NONBLOCK) = 4
     0.063 abrt-dump-jour/1454 openat(dfd: CWD, filename: "/var/log/journal/d6a97235307247e09f13f326fb607e3c/system.journal", flags: RDONLY|CLOEXEC|NONBLOCK) = 4
     0.082 abrt-dump-jour/1455 openat(dfd: CWD, filename: "/var/log/journal/d6a97235307247e09f13f326fb607e3c/system.journal", flags: RDONLY|CLOEXEC|NONBLOCK) = 4
   250.124 systemd-oomd/959 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC) = 12
   250.521 systemd-oomd/959 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.pressure", flags: RDONLY|CLOEXEC) = 12
   251.047 systemd-oomd/959 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.current", flags: RDONLY|CLOEXEC) = 12
   251.162 systemd-oomd/959 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.min", flags: RDONLY|CLOEXEC) = 12
   251.242 systemd-oomd/959 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.low", flags: RDONLY|CLOEXEC) = 12
   251.353 systemd-oomd/959 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.swap.current", flags: RDONLY|CLOEXEC) = 12
  [root@quaco ~]#

Same thing, but with a prebuilt .o BPF bytecode:

  [root@quaco ~]# perf trace -e /home/acme/git/perf-tools-next/tools/perf/examples/bpf/augmented_raw_syscalls.o,open* --max-events=10
     0.000 systemd-oomd/959 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC) = 12
     0.083 abrt-dump-jour/1453 openat(dfd: CWD, filename: "/var/log/journal/d6a97235307247e09f13f326fb607e3c/system.journal", flags: RDONLY|CLOEXEC|NONBLOCK) = 4
     0.083 abrt-dump-jour/1455 openat(dfd: CWD, filename: "/var/log/journal/d6a97235307247e09f13f326fb607e3c/system.journal", flags: RDONLY|CLOEXEC|NONBLOCK) = 4
     0.062 abrt-dump-jour/1454 openat(dfd: CWD, filename: "/var/log/journal/d6a97235307247e09f13f326fb607e3c/system.journal", flags: RDONLY|CLOEXEC|NONBLOCK) = 4
   249.985 systemd-oomd/959 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC) = 12
   466.763 thermald/1234 openat(dfd: CWD, filename: "/sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:2/energy_uj") = 13
   467.145 thermald/1234 openat(dfd: CWD, filename: "/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj") = 13
   467.311 thermald/1234 openat(dfd: CWD, filename: "/sys/class/thermal/thermal_zone2/temp") = 13
   500.040 cgroupify/24006 openat(dfd: 4, filename: ".", flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 5
   500.295 cgroupify/24006 openat(dfd: 4, filename: "24616/cgroup.procs") = 5
  [root@quaco ~]#

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Carsten Haitzler <carsten.haitzler@arm.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Fangrui Song <maskray@google.com>
Cc: He Kuang <hekuang@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Tom Rix <trix@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc: Yang Jihong <yangjihong1@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-clang.cpp        |  28 ---
 tools/build/feature/test-cxx.cpp          |  16 --
 tools/build/feature/test-llvm-version.cpp |  12 --
 tools/build/feature/test-llvm.cpp         |  14 --
 tools/perf/Makefile.config                |  31 ---
 tools/perf/Makefile.perf                  |  17 --
 tools/perf/tests/Build                    |   1 -
 tools/perf/tests/builtin-test.c           |   1 -
 tools/perf/tests/clang.c                  |  32 ---
 tools/perf/tests/make                     |   1 -
 tools/perf/util/Build                     |   2 -
 tools/perf/util/bpf-loader.c              |  15 +-
 tools/perf/util/c++/Build                 |   5 -
 tools/perf/util/c++/clang-c.h             |  43 -----
 tools/perf/util/c++/clang-test.cpp        |  67 -------
 tools/perf/util/c++/clang.cpp             | 225 ----------------------
 tools/perf/util/c++/clang.h               |  27 ---
 17 files changed, 4 insertions(+), 533 deletions(-)
 delete mode 100644 tools/build/feature/test-clang.cpp
 delete mode 100644 tools/build/feature/test-cxx.cpp
 delete mode 100644 tools/build/feature/test-llvm-version.cpp
 delete mode 100644 tools/build/feature/test-llvm.cpp
 delete mode 100644 tools/perf/tests/clang.c
 delete mode 100644 tools/perf/util/c++/Build
 delete mode 100644 tools/perf/util/c++/clang-c.h
 delete mode 100644 tools/perf/util/c++/clang-test.cpp
 delete mode 100644 tools/perf/util/c++/clang.cpp
 delete mode 100644 tools/perf/util/c++/clang.h

diff --git a/tools/build/feature/test-clang.cpp b/tools/build/feature/test-clang.cpp
deleted file mode 100644
index 7d87075cd1c5dd6e..0000000000000000
--- a/tools/build/feature/test-clang.cpp
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "clang/Basic/Version.h"
-#if CLANG_VERSION_MAJOR < 8
-#include "clang/Basic/VirtualFileSystem.h"
-#endif
-#include "clang/Driver/Driver.h"
-#include "clang/Frontend/TextDiagnosticPrinter.h"
-#include "llvm/ADT/IntrusiveRefCntPtr.h"
-#include "llvm/Support/ManagedStatic.h"
-#if CLANG_VERSION_MAJOR >= 8
-#include "llvm/Support/VirtualFileSystem.h"
-#endif
-#include "llvm/Support/raw_ostream.h"
-
-using namespace clang;
-using namespace clang::driver;
-
-int main()
-{
-	IntrusiveRefCntPtr<DiagnosticIDs> DiagID(new DiagnosticIDs());
-	IntrusiveRefCntPtr<DiagnosticOptions> DiagOpts = new DiagnosticOptions();
-
-	DiagnosticsEngine Diags(DiagID, &*DiagOpts);
-	Driver TheDriver("test", "bpf-pc-linux", Diags);
-
-	llvm::llvm_shutdown();
-	return 0;
-}
diff --git a/tools/build/feature/test-cxx.cpp b/tools/build/feature/test-cxx.cpp
deleted file mode 100644
index 396aaedd2418dd65..0000000000000000
--- a/tools/build/feature/test-cxx.cpp
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <iostream>
-#include <memory>
-
-static void print_str(std::string s)
-{
-	std::cout << s << std::endl;
-}
-
-int main()
-{
-	std::string s("Hello World!");
-	print_str(std::move(s));
-	std::cout << "|" << s << "|" << std::endl;
-	return 0;
-}
diff --git a/tools/build/feature/test-llvm-version.cpp b/tools/build/feature/test-llvm-version.cpp
deleted file mode 100644
index 8a091625446af985..0000000000000000
--- a/tools/build/feature/test-llvm-version.cpp
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <cstdio>
-#include "llvm/Config/llvm-config.h"
-
-#define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR << 8) + LLVM_VERSION_PATCH)
-#define pass int main() {printf("%x\n", NUM_VERSION); return 0;}
-
-#if NUM_VERSION >= 0x030900
-pass
-#else
-# error This LLVM is not tested yet.
-#endif
diff --git a/tools/build/feature/test-llvm.cpp b/tools/build/feature/test-llvm.cpp
deleted file mode 100644
index 88a3d1bdd9f6978e..0000000000000000
--- a/tools/build/feature/test-llvm.cpp
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "llvm/Support/ManagedStatic.h"
-#include "llvm/Support/raw_ostream.h"
-#define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR << 8) + LLVM_VERSION_PATCH)
-
-#if NUM_VERSION < 0x030900
-# error "LLVM version too low"
-#endif
-int main()
-{
-	llvm::errs() << "Hello World!\n";
-	llvm::llvm_shutdown();
-	return 0;
-}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1bf8dc53641fa093..e0592ed4c10f5904 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1127,37 +1127,6 @@ ifndef NO_JVMTI
   endif
 endif
 
-USE_CXX = 0
-USE_CLANGLLVM = 0
-ifdef LIBCLANGLLVM
-  $(call feature_check,cxx)
-  ifneq ($(feature-cxx), 1)
-    msg := $(warning No g++ found, disable clang and llvm support. Please install g++)
-  else
-    $(call feature_check,llvm)
-    $(call feature_check,llvm-version)
-    ifneq ($(feature-llvm), 1)
-      msg := $(warning No suitable libLLVM found, disabling builtin clang and LLVM support. Please install llvm-dev(el) (>= 3.9.0))
-    else
-      $(call feature_check,clang)
-      ifneq ($(feature-clang), 1)
-        msg := $(warning No suitable libclang found, disabling builtin clang and LLVM support. Please install libclang-dev(el) (>= 3.9.0))
-      else
-        CFLAGS += -DHAVE_LIBCLANGLLVM_SUPPORT
-        CXXFLAGS += -DHAVE_LIBCLANGLLVM_SUPPORT -I$(shell $(LLVM_CONFIG) --includedir)
-        $(call detected,CONFIG_CXX)
-        $(call detected,CONFIG_CLANGLLVM)
-	USE_CXX = 1
-	USE_LLVM = 1
-	USE_CLANG = 1
-        ifneq ($(feature-llvm-version),1)
-          msg := $(warning This version of LLVM is not tested. May cause build errors)
-        endif
-      endif
-    endif
-  endif
-endif
-
 ifndef NO_LIBPFM4
   $(call feature_check,libpfm4)
   ifeq ($(feature-libpfm4), 1)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 0ed7ee0c1665a8cf..5370d7bf123e76af 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -99,10 +99,6 @@ include ../scripts/utilities.mak
 # Define NO_JVMTI_CMLR (debug only) if you do not want to process CMLR
 # data for java source lines.
 #
-# Define LIBCLANGLLVM if you DO want builtin clang and llvm support.
-# When selected, pass LLVM_CONFIG=/path/to/llvm-config to `make' if
-# llvm-config is not in $PATH.
-#
 # Define CORESIGHT if you DO WANT support for CoreSight trace decoding.
 #
 # Define NO_AIO if you do not want support of Posix AIO based trace
@@ -425,19 +421,6 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
-ifeq ($(USE_CLANG), 1)
-  LIBS += -L$(shell $(LLVM_CONFIG) --libdir) -lclang-cpp
-endif
-
-ifeq ($(USE_LLVM), 1)
-  LIBLLVM = $(shell $(LLVM_CONFIG) --libs all) $(shell $(LLVM_CONFIG) --system-libs)
-  LIBS += -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM)
-endif
-
-ifeq ($(USE_CXX), 1)
-  LIBS += -lstdc++
-endif
-
 export INSTALL SHELL_PATH
 
 ### Build rules
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index fb9ac5dc4079dab8..52df5923a8b9cc20 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -51,7 +51,6 @@ perf-y += sdt.o
 perf-y += is_printable_array.o
 perf-y += bitmap.o
 perf-y += perf-hooks.o
-perf-y += clang.o
 perf-y += unit_number__scnprintf.o
 perf-y += mem2node.o
 perf-y += maps.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 6accb5442a731842..0f3691fd31c2536f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -108,7 +108,6 @@ static struct test_suite *generic_tests[] = {
 	&suite__is_printable_array,
 	&suite__bitmap_print,
 	&suite__perf_hooks,
-	&suite__clang,
 	&suite__unit_number__scnprint,
 	&suite__mem2node,
 	&suite__time_utils,
diff --git a/tools/perf/tests/clang.c b/tools/perf/tests/clang.c
deleted file mode 100644
index a7111005d5b9f481..0000000000000000
--- a/tools/perf/tests/clang.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "tests.h"
-#include "c++/clang-c.h"
-#include <linux/kernel.h>
-
-#ifndef HAVE_LIBCLANGLLVM_SUPPORT
-static int test__clang_to_IR(struct test_suite *test __maybe_unused,
-			     int subtest __maybe_unused)
-{
-	return TEST_SKIP;
-}
-
-static int test__clang_to_obj(struct test_suite *test __maybe_unused,
-			      int subtest __maybe_unused)
-{
-	return TEST_SKIP;
-}
-#endif
-
-static struct test_case clang_tests[] = {
-	TEST_CASE_REASON("builtin clang compile C source to IR", clang_to_IR,
-			 "not compiled in"),
-	TEST_CASE_REASON("builtin clang compile C source to ELF object",
-			 clang_to_obj,
-			 "not compiled in"),
-	{ .name = NULL, }
-};
-
-struct test_suite suite__clang = {
-	.desc = "builtin clang support",
-	.test_cases = clang_tests,
-};
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 58cf96d762d06a68..ea4c341f5af11741 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -95,7 +95,6 @@ make_with_babeltrace:= LIBBABELTRACE=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
 make_no_syscall_tbl := NO_SYSCALL_TABLE=1
-make_with_clangllvm := LIBCLANGLLVM=1
 make_no_libpfm4     := NO_LIBPFM4=1
 make_with_gtk2      := GTK2=1
 make_refcnt_check   := EXTRA_CFLAGS="-DREFCNT_CHECKING=1"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 9699e31ff4c04925..ff3b55c7ed43cdad 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -232,8 +232,6 @@ perf-y += perf-hooks.o
 perf-$(CONFIG_LIBBPF) += bpf-event.o
 perf-$(CONFIG_LIBBPF) += bpf-utils.o
 
-perf-$(CONFIG_CXX) += c++/
-
 perf-$(CONFIG_LIBPFM4) += pfm.o
 
 CFLAGS_config.o   += -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 50e42698cbb721d1..b54e42f17926b17e 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -26,7 +26,6 @@
 #include "strfilter.h"
 #include "util.h"
 #include "llvm-utils.h"
-#include "c++/clang-c.h"
 #include "util/hashmap.h"
 #include "asm/bug.h"
 
@@ -220,16 +219,10 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 		void *obj_buf;
 		size_t obj_buf_sz;
 
-		perf_clang__init();
-		err = perf_clang__compile_bpf(filename, &obj_buf, &obj_buf_sz);
-		perf_clang__cleanup();
-		if (err) {
-			pr_debug("bpf: builtin compilation failed: %d, try external compiler\n", err);
-			err = llvm__compile_bpf(filename, &obj_buf, &obj_buf_sz);
-			if (err)
-				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
-		} else
-			pr_debug("bpf: successful builtin compilation\n");
+		err = llvm__compile_bpf(filename, &obj_buf, &obj_buf_sz);
+		if (err)
+			return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
+
 		obj = bpf_object__open_mem(obj_buf, obj_buf_sz, &opts);
 
 		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
diff --git a/tools/perf/util/c++/Build b/tools/perf/util/c++/Build
deleted file mode 100644
index 8610d032ac19d8c5..0000000000000000
--- a/tools/perf/util/c++/Build
+++ /dev/null
@@ -1,5 +0,0 @@
-perf-$(CONFIG_CLANGLLVM) += clang.o
-perf-$(CONFIG_CLANGLLVM) += clang-test.o
-
-CXXFLAGS_clang.o += -Wno-unused-parameter
-CXXFLAGS_clang-test.o += -Wno-unused-parameter
diff --git a/tools/perf/util/c++/clang-c.h b/tools/perf/util/c++/clang-c.h
deleted file mode 100644
index d3731a876b6c10c5..0000000000000000
--- a/tools/perf/util/c++/clang-c.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef PERF_UTIL_CLANG_C_H
-#define PERF_UTIL_CLANG_C_H
-
-#include <stddef.h>	/* for size_t */
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#ifdef HAVE_LIBCLANGLLVM_SUPPORT
-extern void perf_clang__init(void);
-extern void perf_clang__cleanup(void);
-
-struct test_suite;
-extern int test__clang_to_IR(struct test_suite *test, int subtest);
-extern int test__clang_to_obj(struct test_suite *test, int subtest);
-
-extern int perf_clang__compile_bpf(const char *filename,
-				   void **p_obj_buf,
-				   size_t *p_obj_buf_sz);
-#else
-
-#include <errno.h>
-#include <linux/compiler.h>	/* for __maybe_unused */
-
-static inline void perf_clang__init(void) { }
-static inline void perf_clang__cleanup(void) { }
-
-static inline int
-perf_clang__compile_bpf(const char *filename __maybe_unused,
-			void **p_obj_buf __maybe_unused,
-			size_t *p_obj_buf_sz __maybe_unused)
-{
-	return -ENOTSUP;
-}
-
-#endif
-
-#ifdef __cplusplus
-}
-#endif
-#endif
diff --git a/tools/perf/util/c++/clang-test.cpp b/tools/perf/util/c++/clang-test.cpp
deleted file mode 100644
index a4683ca536973c04..0000000000000000
--- a/tools/perf/util/c++/clang-test.cpp
+++ /dev/null
@@ -1,67 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "clang.h"
-#include "clang-c.h"
-extern "C" {
-#include "../util.h"
-}
-#include "llvm/IR/Function.h"
-#include "llvm/IR/LLVMContext.h"
-
-#include <tests/llvm.h>
-#include <string>
-
-class perf_clang_scope {
-public:
-	explicit perf_clang_scope() {perf_clang__init();}
-	~perf_clang_scope() {perf_clang__cleanup();}
-};
-
-static std::unique_ptr<llvm::Module>
-__test__clang_to_IR(void)
-{
-	unsigned int kernel_version;
-
-	if (fetch_kernel_version(&kernel_version, NULL, 0))
-		return std::unique_ptr<llvm::Module>(nullptr);
-
-	std::string cflag_kver("-DLINUX_VERSION_CODE=" +
-				std::to_string(kernel_version));
-
-	std::unique_ptr<llvm::Module> M =
-		perf::getModuleFromSource({cflag_kver.c_str()},
-					  "perf-test.c",
-					  test_llvm__bpf_base_prog);
-	return M;
-}
-
-extern "C" {
-int test__clang_to_IR(struct test_suite *test __maybe_unused,
-                      int subtest __maybe_unused)
-{
-	perf_clang_scope _scope;
-
-	auto M = __test__clang_to_IR();
-	if (!M)
-		return -1;
-	for (llvm::Function& F : *M)
-		if (F.getName() == "bpf_func__SyS_epoll_pwait")
-			return 0;
-	return -1;
-}
-
-int test__clang_to_obj(struct test_suite *test __maybe_unused,
-                       int subtest __maybe_unused)
-{
-	perf_clang_scope _scope;
-
-	auto M = __test__clang_to_IR();
-	if (!M)
-		return -1;
-
-	auto Buffer = perf::getBPFObjectFromModule(&*M);
-	if (!Buffer)
-		return -1;
-	return 0;
-}
-
-}
diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
deleted file mode 100644
index 1aad7d6d34aaa639..0000000000000000
--- a/tools/perf/util/c++/clang.cpp
+++ /dev/null
@@ -1,225 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * llvm C frontend for perf. Support dynamically compile C file
- *
- * Inspired by clang example code:
- * http://llvm.org/svn/llvm-project/cfe/trunk/examples/clang-interpreter/main.cpp
- *
- * Copyright (C) 2016 Wang Nan <wangnan0@huawei.com>
- * Copyright (C) 2016 Huawei Inc.
- */
-
-#include "clang/Basic/Version.h"
-#include "clang/CodeGen/CodeGenAction.h"
-#include "clang/Frontend/CompilerInvocation.h"
-#include "clang/Frontend/CompilerInstance.h"
-#include "clang/Frontend/TextDiagnosticPrinter.h"
-#include "clang/Tooling/Tooling.h"
-#include "llvm/IR/LegacyPassManager.h"
-#include "llvm/IR/Module.h"
-#include "llvm/Option/Option.h"
-#include "llvm/Support/FileSystem.h"
-#include "llvm/Support/ManagedStatic.h"
-#if CLANG_VERSION_MAJOR >= 14
-#include "llvm/MC/TargetRegistry.h"
-#else
-#include "llvm/Support/TargetRegistry.h"
-#endif
-#include "llvm/Support/TargetSelect.h"
-#include "llvm/Target/TargetMachine.h"
-#include "llvm/Target/TargetOptions.h"
-#include <memory>
-
-#include "clang.h"
-#include "clang-c.h"
-
-namespace perf {
-
-static std::unique_ptr<llvm::LLVMContext> LLVMCtx;
-
-using namespace clang;
-
-static CompilerInvocation *
-createCompilerInvocation(llvm::opt::ArgStringList CFlags, StringRef& Path,
-			 DiagnosticsEngine& Diags)
-{
-	llvm::opt::ArgStringList CCArgs {
-		"-cc1",
-		"-triple", "bpf-pc-linux",
-		"-fsyntax-only",
-		"-O2",
-		"-nostdsysteminc",
-		"-nobuiltininc",
-		"-vectorize-loops",
-		"-vectorize-slp",
-		"-Wno-unused-value",
-		"-Wno-pointer-sign",
-		"-x", "c"};
-
-	CCArgs.append(CFlags.begin(), CFlags.end());
-	CompilerInvocation *CI = tooling::newInvocation(&Diags, CCArgs
-#if CLANG_VERSION_MAJOR >= 11
-                                                        ,/*BinaryName=*/nullptr
-#endif
-                                                        );
-
-	FrontendOptions& Opts = CI->getFrontendOpts();
-	Opts.Inputs.clear();
-	Opts.Inputs.emplace_back(Path,
-			FrontendOptions::getInputKindForExtension("c"));
-	return CI;
-}
-
-static std::unique_ptr<llvm::Module>
-getModuleFromSource(llvm::opt::ArgStringList CFlags,
-		    StringRef Path, IntrusiveRefCntPtr<vfs::FileSystem> VFS)
-{
-	CompilerInstance Clang;
-	Clang.createDiagnostics();
-
-#if CLANG_VERSION_MAJOR < 9
-	Clang.setVirtualFileSystem(&*VFS);
-#else
-	Clang.createFileManager(&*VFS);
-#endif
-
-#if CLANG_VERSION_MAJOR < 4
-	IntrusiveRefCntPtr<CompilerInvocation> CI =
-		createCompilerInvocation(std::move(CFlags), Path,
-					 Clang.getDiagnostics());
-	Clang.setInvocation(&*CI);
-#else
-	std::shared_ptr<CompilerInvocation> CI(
-		createCompilerInvocation(std::move(CFlags), Path,
-					 Clang.getDiagnostics()));
-	Clang.setInvocation(CI);
-#endif
-
-	std::unique_ptr<CodeGenAction> Act(new EmitLLVMOnlyAction(&*LLVMCtx));
-	if (!Clang.ExecuteAction(*Act))
-		return std::unique_ptr<llvm::Module>(nullptr);
-
-	return Act->takeModule();
-}
-
-std::unique_ptr<llvm::Module>
-getModuleFromSource(llvm::opt::ArgStringList CFlags,
-		    StringRef Name, StringRef Content)
-{
-	using namespace vfs;
-
-	llvm::IntrusiveRefCntPtr<OverlayFileSystem> OverlayFS(
-			new OverlayFileSystem(getRealFileSystem()));
-	llvm::IntrusiveRefCntPtr<InMemoryFileSystem> MemFS(
-			new InMemoryFileSystem(true));
-
-	/*
-	 * pushOverlay helps setting working dir for MemFS. Must call
-	 * before addFile.
-	 */
-	OverlayFS->pushOverlay(MemFS);
-	MemFS->addFile(Twine(Name), 0, llvm::MemoryBuffer::getMemBuffer(Content));
-
-	return getModuleFromSource(std::move(CFlags), Name, OverlayFS);
-}
-
-std::unique_ptr<llvm::Module>
-getModuleFromSource(llvm::opt::ArgStringList CFlags, StringRef Path)
-{
-	IntrusiveRefCntPtr<vfs::FileSystem> VFS(vfs::getRealFileSystem());
-	return getModuleFromSource(std::move(CFlags), Path, VFS);
-}
-
-std::unique_ptr<llvm::SmallVectorImpl<char>>
-getBPFObjectFromModule(llvm::Module *Module)
-{
-	using namespace llvm;
-
-	std::string TargetTriple("bpf-pc-linux");
-	std::string Error;
-	const Target* Target = TargetRegistry::lookupTarget(TargetTriple, Error);
-	if (!Target) {
-		llvm::errs() << Error;
-		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
-	}
-
-	llvm::TargetOptions Opt;
-	TargetMachine *TargetMachine =
-		Target->createTargetMachine(TargetTriple,
-					    "generic", "",
-					    Opt, Reloc::Static);
-
-	Module->setDataLayout(TargetMachine->createDataLayout());
-	Module->setTargetTriple(TargetTriple);
-
-	std::unique_ptr<SmallVectorImpl<char>> Buffer(new SmallVector<char, 0>());
-	raw_svector_ostream ostream(*Buffer);
-
-	legacy::PassManager PM;
-	bool NotAdded;
-	NotAdded = TargetMachine->addPassesToEmitFile(PM, ostream
-#if CLANG_VERSION_MAJOR >= 7
-                                                      , /*DwoOut=*/nullptr
-#endif
-#if CLANG_VERSION_MAJOR < 10
-                                                      , TargetMachine::CGFT_ObjectFile
-#else
-                                                      , llvm::CGFT_ObjectFile
-#endif
-                                                      );
-	if (NotAdded) {
-		llvm::errs() << "TargetMachine can't emit a file of this type\n";
-		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
-	}
-	PM.run(*Module);
-
-	return Buffer;
-}
-
-}
-
-extern "C" {
-void perf_clang__init(void)
-{
-	perf::LLVMCtx.reset(new llvm::LLVMContext());
-	LLVMInitializeBPFTargetInfo();
-	LLVMInitializeBPFTarget();
-	LLVMInitializeBPFTargetMC();
-	LLVMInitializeBPFAsmPrinter();
-}
-
-void perf_clang__cleanup(void)
-{
-	perf::LLVMCtx.reset(nullptr);
-	llvm::llvm_shutdown();
-}
-
-int perf_clang__compile_bpf(const char *filename,
-			    void **p_obj_buf,
-			    size_t *p_obj_buf_sz)
-{
-	using namespace perf;
-
-	if (!p_obj_buf || !p_obj_buf_sz)
-		return -EINVAL;
-
-	llvm::opt::ArgStringList CFlags;
-	auto M = getModuleFromSource(std::move(CFlags), filename);
-	if (!M)
-		return  -EINVAL;
-	auto O = getBPFObjectFromModule(&*M);
-	if (!O)
-		return -EINVAL;
-
-	size_t size = O->size_in_bytes();
-	void *buffer;
-
-	buffer = malloc(size);
-	if (!buffer)
-		return -ENOMEM;
-	memcpy(buffer, O->data(), size);
-	*p_obj_buf = buffer;
-	*p_obj_buf_sz = size;
-	return 0;
-}
-}
diff --git a/tools/perf/util/c++/clang.h b/tools/perf/util/c++/clang.h
deleted file mode 100644
index 6ce33e22f23c084a..0000000000000000
--- a/tools/perf/util/c++/clang.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef PERF_UTIL_CLANG_H
-#define PERF_UTIL_CLANG_H
-
-#include "llvm/ADT/StringRef.h"
-#include "llvm/IR/LLVMContext.h"
-#include "llvm/IR/Module.h"
-#include "llvm/Option/Option.h"
-#include <memory>
-
-namespace perf {
-
-using namespace llvm;
-
-std::unique_ptr<Module>
-getModuleFromSource(opt::ArgStringList CFlags,
-		    StringRef Name, StringRef Content);
-
-std::unique_ptr<Module>
-getModuleFromSource(opt::ArgStringList CFlags,
-		    StringRef Path);
-
-std::unique_ptr<llvm::SmallVectorImpl<char>>
-getBPFObjectFromModule(llvm::Module *Module);
-
-}
-#endif
-- 
2.37.1


