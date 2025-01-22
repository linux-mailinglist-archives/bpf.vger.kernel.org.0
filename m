Return-Path: <bpf+bounces-49454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A839A18C01
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 07:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7851016BB38
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 06:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95571C5F2F;
	Wed, 22 Jan 2025 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="werHbYdS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AD71C5F1A
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527147; cv=none; b=Fy1wyBl24c9KXCBWHYHgKTC/Y61cPWkVcpXYWAawWt5g7gkz5ySxbL1FzrekaUl42F86FUDb5YzjghDi4So+pXWwFdH2MAjkZbR6lEX1MxvAjv7zLp5CgT4g1MgiAHGwczKDs2vGUQENq4uEXbb2LNfnp9/9Yc3FnBbHHR/1Z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527147; c=relaxed/simple;
	bh=8YdK72iZdR17owyBQbQB5b4SQ6Ubblw50VG+kDokyoA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=elH11thov5azH3KeR/GLbO8mXNm0gfPC5FAc60yy7eiXD8W0UySJP9dpN+wECcnCZCqi2og5vFGCmjFCKTy9cs54hkRKyTQnE4YhQ5vYpLfuk4VyatuYVhnD7DCiPTONRoIAeoA3LVEgubAmSZATNMnsAXlJmRHWRjAa1ldGrD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=werHbYdS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e39993d8594so16203426276.3
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2025 22:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737527144; x=1738131944; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifrzx08xgFVVOvnuD1mbePIHPYzVbA5mBaTsSvEVMM8=;
        b=werHbYdSXVOXsor5ScmwWjCIKaKexRTdbCU2/5P0gwefctanX8ZYKQOfibNL3eSRxh
         oAoP/JG26pKWuCXNlZ1ItLDYgXcwNnM78bOSnPMoC2bvevJAVE9Zq2zDqkPGaj6XqTSQ
         Rw2WrQde+uf/SrhvwiMR45TDyPyi211Mya8NeSw01eYLe8dWVroTtJoLT93uQrHb8wry
         UqrRuHgG76X2R4iW740tXvRvR1K9rLguI/Do7eBHsxb7jIjqw2hbibkC3uxB50+orVsc
         U+t+HnQrcyoqpn9cZdDiQncBNDJbSSlXbAsbA9XAOQN4WaPTL6jS2rBv35Iz3f+Ep7BU
         u/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737527144; x=1738131944;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifrzx08xgFVVOvnuD1mbePIHPYzVbA5mBaTsSvEVMM8=;
        b=RgXYwpeJRWkJzXhegDrGhVlAsh74hN1HjgfXb/NpXx+iWXIAkjo2GnzcNDapAS19M8
         Y+g20c1PbcIxMoQ8rFiMpsgWJl5cWG0iR8w/6IDBuuP/jiR73vO9x/hbPO+pbAANEcMr
         E+xfE30eNW0mBor/QdLNL/hJ5g9nz2olQn4JIVJBrzBEIHWgme8enlp7VDvHZWfpWcju
         dGzWS+InnRBMLCnZZuIlzEprH95Sg82aI8kXCnVtZxmtJVTqToGZcmYJ/OYdyEw4B9nr
         j2Tx+8iDhGKZrDU0SHjwkfa1st7q+ml8xjfdGUP/9i1pxRY7HXUo1Sv8XLMCBfuFeY5P
         UObw==
X-Forwarded-Encrypted: i=1; AJvYcCXPIx9wRejkhJDfzAozdyn2Yt1wLY7ueMv26p17gLiB2vIYBN/+HK0gxBIQVDNOAePBJ9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Jzp+2StMXhr+hrhBfivnfCCzNzORz8HGs8fnIn/n4yZGbFaB
	M4zmdvQroTgReUr9Sv8iarbjMHamVdyuK8/+QucsJcIMaZA7h8LRoneH4XZgRmzkJvxUY7OoVUn
	07vRtCg==
X-Google-Smtp-Source: AGHT+IEUzUAkofeuVvAtDYMZZaTprBavOTBiC/v5bGjwuLSAhbX6+dOAwBIHHcktV1WdUK0vxmNle87xnyEI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a81:a907:0:b0:62c:f976:a763 with SMTP id
 00721157ae682-6f6eb65eeadmr431097b3.1.1737527144144; Tue, 21 Jan 2025
 22:25:44 -0800 (PST)
Date: Tue, 21 Jan 2025 22:23:29 -0800
In-Reply-To: <20250122062332.577009-1-irogers@google.com>
Message-Id: <20250122062332.577009-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 14/17] perf build: Remove libiberty support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
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
 tools/perf/util/symbol-elf.c     | 13 -------------
 5 files changed, 5 insertions(+), 46 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 900be0349de9..513dd5cab605 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -949,18 +949,6 @@ ifndef NO_DEMANGLE
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
index a2886abd4f02..398c30b6bdce 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -123,9 +123,6 @@ include ../scripts/utilities.mak
 #
 # Set BUILD_BPF_SKEL to 0 to override BUILD_BPF_SKEL and not build BPF skeletons
 #
-# Define BUILD_NONDISTRO to enable building an linking against libbfd and
-# libiberty distribution license incompatible libraries.
-#
 # Define EXTRA_TESTS to enable building extra tests useful mainly to perf
 # developers, such as:
 #	x86 instruction decoder - new instructions test
@@ -329,10 +326,10 @@ LIBSYMBOL_DIR   = $(srctree)/tools/lib/symbol/
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
index 44d76eacce49..4a1ed20bff7e 100644
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
index 8140f60af1e5..121db55b9709 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -27,13 +27,6 @@
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
@@ -286,13 +279,7 @@ static bool want_demangle(bool is_kernel_sym)
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
2.48.0.rc2.279.g1de40edade-goog


