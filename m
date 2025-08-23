Return-Path: <bpf+bounces-66345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCDB325EF
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2D31895548
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FB0143C61;
	Sat, 23 Aug 2025 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="17UiCe2H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CA214818
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909181; cv=none; b=kwOSvbKt5lHLB156aLHLVcQ9F3YOSDi7NjVnVdoswu9iJWnRUBop+q7drIaYaOlni+OALd5DVF1oIZDINsxyUIxSseMOg0zK/JZNwFGq+AYXJn0AyLEabODS1bvAXjvMIBGLJFDbxwYWvRTGRtiaS39/Vw+qB/HLNxxqGUBZ/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909181; c=relaxed/simple;
	bh=g7UHYRQzT6TJ0K4ws4E7uvCzyWUH1uer7yeVDKc62TM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=T/vJQ78d5qNd3M9UEMZJ6Kt8DLZQWfF7NBY/aHZJWfCIFsj31mJ/pXbx+Df2+C9gq2x8oj14NFNcb5PgsqhoqIiq4++EWOfmZ8vOLh+hz0ApOqNl/Pnixewg0zQAC2/FYk+9krlwkLPuaredXJoLaCkcRu0CMqukTTdRjN+0el8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=17UiCe2H; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-323267b6c8eso4907764a91.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909179; x=1756513979; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pr+YzJEOiZBk1DqLtdd5jyeBvbBwpDDHugVBvTRT2R0=;
        b=17UiCe2HXbzo20ITKfQ1h6fsQxefRhXmazksNKB8mEaYa0mIUKTP4DSCTS2eqKOYQO
         cMWcpQZTMgM+PvT9DH/GzVMWs0rYzZFkJGis1w7w2/QqJBOnzRgTnct9aoHW8GWEmBFs
         cbv3itNElabw1i2l/+ikPIrg9MqnSHDAsBaQiopxXs4g3VfZ/HPkSWTrgf55hYESWK42
         77OsXvF59yUMAoiLXRnV3IphSthz0kyfpLyPRC0WYfs8FPxpaIj2BpM+4oh0wODj2L3z
         7BhsGRPQc+sQeVfSjV0VnqxlRNV1OSHUm+eRVKq7Te/NKZuzm/mTxwKUIrvzqcFboU/D
         JWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909179; x=1756513979;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pr+YzJEOiZBk1DqLtdd5jyeBvbBwpDDHugVBvTRT2R0=;
        b=uFsZn0kphznUzjG8CHUK6JiRT9GicHo657zBhIrpqX7SUcXfSVXhirnkAbgdWL4/LT
         5OlNtdkUnK4F0A0G7rUs0VbIy++CF9riK8HdnBiiZmBQxIk7bC+f1nGO7EMGTQkrml+z
         m81Yx+IeZWVU9CEEL49xXKSq7kOrVROX9i0S5cYNrgmDXPHW3JjcBYkGSkpiWt8q286W
         WBhKDynt4IfTb3aFsZhdIB4n11pHXCXm151D8DmMDdDiGS0PRaFiEh5M93k45lU+WQJI
         wB4tIvyR82yTVWByRf7+uulkJilX3WH3pdd1RRvmvetZ2Dmr+Tql9gvsXXBtb1FfC6iI
         4w2A==
X-Forwarded-Encrypted: i=1; AJvYcCXxoG5+Gz9/nUwX2UvyDurNap1NVqmztpm1xeth6KfnAfl5Lc12CC2PqryvZup+lwuGhFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaT/PWXCxyh2zMDimR/FJUtYNsGe3oqZzYtfUsoswUYHI958ue
	uteomFAWP3qFkarr2BrdBfk7WO7uK5Xw4GHl1rY37UVaFmylZRfCOyFbdiK9/JaQ3p8jxVODgw8
	UvAncyu6Vlg==
X-Google-Smtp-Source: AGHT+IEbSD5mmkspsxqOZVgLSCc0+j+3G8FLHaIvccK+/ream/4V/PzNJvjxA86FmsXlTbxlRKOojRGqZbFG
X-Received: from pjbdy6.prod.google.com ([2002:a17:90b:6c6:b0:31f:3227:1724])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:56c3:b0:321:c0e3:a8ce
 with SMTP id 98e67ed59e1d1-3251774b8edmr6687634a91.22.1755909179167; Fri, 22
 Aug 2025 17:32:59 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:10 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-15-irogers@google.com>
Subject: [PATCH v5 14/19] perf build: Remove libiberty support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libiberty is license incompatible with perf and building requires the
BUILD_NONDISTRO=1 build flag. libiberty is used for
HAVE_CPLUS_DEMANGLE_SUPPORT. Remove the code to simplify the code base
as it can't be distributed. Remove the BUILD_NONDISTRO build flag and
test as they no longer enable/disable support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config       | 12 ------------
 tools/perf/Makefile.perf         | 11 ++++-------
 tools/perf/tests/make            |  2 --
 tools/perf/util/demangle-cxx.cpp | 13 +------------
 tools/perf/util/symbol-elf.c     |  7 -------
 tools/perf/util/symbol.c         |  6 ------
 6 files changed, 5 insertions(+), 46 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b63c952b10ce..7bc9985264a7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -954,18 +954,6 @@ ifndef NO_DEMANGLE
     CXXFLAGS += -DHAVE_CXA_DEMANGLE_SUPPORT
     $(call detected,CONFIG_CXX_DEMANGLE)
   endif
-  ifdef BUILD_NONDISTRO
-    ifeq ($(filter -liberty,$(EXTLIBS)),)
-      $(call feature_check,cplus-demangle)
-      ifeq ($(feature-cplus-demangle), 1)
-        EXTLIBS += -liberty
-      endif
-    endif
-    ifneq ($(filter -liberty,$(EXTLIBS)),)
-      CFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
-      CXXFLAGS += -DHAVE_CPLUS_DEMANGLE_SUPPORT
-    endif
-  endif
 endif
 
 ifndef NO_LZMA
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 116c935c06f7..727b7412aab0 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -120,9 +120,6 @@ include ../scripts/utilities.mak
 #
 # Set BUILD_BPF_SKEL to 0 to override BUILD_BPF_SKEL and not build BPF skeletons
 #
-# Define BUILD_NONDISTRO to enable building an linking against libbfd and
-# libiberty distribution license incompatible libraries.
-#
 # Define EXTRA_TESTS to enable building extra tests useful mainly to perf
 # developers, such as:
 #	x86 instruction decoder - new instructions test
@@ -297,10 +294,10 @@ LIBSYMBOL_DIR   = $(srctree)/tools/lib/symbol/
 LIBPERF_DIR     = $(srctree)/tools/lib/perf/
 DOC_DIR         = $(srctree)/tools/perf/Documentation/
 
-# Set FEATURE_TESTS to 'all' so all possible feature checkers are executed.
-# Without this setting the output feature dump file misses some features, for
-# example, liberty. Select all checkers so we won't get an incomplete feature
-# dump file.
+# Set FEATURE_TESTS to 'all' so all possible feature checkers are
+# executed.  Without this setting the output feature dump file misses
+# some features. Select all checkers so we won't get an incomplete
+# feature dump file.
 ifeq ($(config),1)
 ifdef MAKECMDGOALS
 ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 301cda63a27f..112423076e1c 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -68,7 +68,6 @@ python_perf_so := $(shell $(MAKE) python_perf_target|grep "Target is:"|awk '{pri
 make_clean_all      := clean all
 make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
-make_nondistro      := BUILD_NONDISTRO=1
 make_extra_tests    := EXTRA_TESTS=1
 make_jevents_all    := JEVENTS_ARCH=all
 make_no_bpf_skel    := BUILD_BPF_SKEL=0
@@ -139,7 +138,6 @@ MAKE_F := $(MAKE) -f $(MK)
 endif
 run += make_python_perf_so
 run += make_debug
-run += make_nondistro
 run += make_extra_tests
 run += make_jevents_all
 run += make_no_bpf_skel
diff --git a/tools/perf/util/demangle-cxx.cpp b/tools/perf/util/demangle-cxx.cpp
index bd657eb37efc..36801ea327a6 100644
--- a/tools/perf/util/demangle-cxx.cpp
+++ b/tools/perf/util/demangle-cxx.cpp
@@ -8,13 +8,6 @@
 #include <cxxabi.h>
 #endif
 
-#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-#ifndef DMGL_PARAMS
-#define DMGL_PARAMS     (1 << 0)  /* Include function args */
-#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
-#endif
-#endif
-
 /*
  * Demangle C++ function signature
  *
@@ -24,11 +17,7 @@ extern "C"
 char *cxx_demangle_sym(const char *str, bool params __maybe_unused,
                        bool modifiers __maybe_unused)
 {
-#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-        int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
-
-        return cplus_demangle(str, flags);
-#elif defined(HAVE_CXA_DEMANGLE_SUPPORT)
+#if defined(HAVE_CXA_DEMANGLE_SUPPORT)
         char *output;
         int status;
 
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index c6013f9fdc1a..b17386372882 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -24,13 +24,6 @@
 #include <symbol/kallsyms.h>
 #include <internal/lib.h>
 
-#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-#ifndef DMGL_PARAMS
-#define DMGL_PARAMS     (1 << 0)  /* Include function args */
-#define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
-#endif
-#endif
-
 #ifndef EM_AARCH64
 #define EM_AARCH64	183  /* ARM 64 bit */
 #endif
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index c058d6a01509..0d1220e12205 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2535,13 +2535,7 @@ static bool want_demangle(bool is_kernel_sym)
 char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
 		       bool modifiers __maybe_unused)
 {
-#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
-	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
-
-	return cplus_demangle(str, flags);
-#else
 	return NULL;
-#endif
 }
 #endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


