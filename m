Return-Path: <bpf+bounces-49514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6C3A197FA
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7916816CEC1
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF721ADD1;
	Wed, 22 Jan 2025 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SGTCrUs0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314121A94D
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567825; cv=none; b=p103MpOtEtAYdg8BqsfteJ49IhP33lXchrUYT1jlILTiZWWT+6v1F/HXYJn2SOEXtQa4vrdUOpy+JDaFW3hjCNyGeolZMuxmsU2SmFoWqc8oLacKo8YYQGa7B8KHDks9PKCmEumk6qohFlL5NNrJnYQIFL44mIKEYougPClr3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567825; c=relaxed/simple;
	bh=i514ZousHHKYN3+yl7tlDDJu1ae640yR3xPwcvvidfA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jir+ngWqxYBH/kz0cX6CqE8Xunq3eqsj8No2rgDeO7ldR1xDijeg3d0TA22cpshHqvs3QqIHeAooqGFUg2O7IVVC9wdy/eqCK6Cy1DCOBT6YQ1y3RUlnobhOsbLftYbcdiOwqGmjK25CmdRPGeU5LKFfPdlWZ5CzuHhrQ23yG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SGTCrUs0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e5742f52896so18076479276.3
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567821; x=1738172621; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8HXr8SgI+r6UhCYT+MAd6kxqHaYccFEHkeR1L5m1fY=;
        b=SGTCrUs0bADwo8kA1xO7KjrUixliGWlzWmJrrpaRPeIdNv20OOFiqw6UDfr1fnxk9c
         hBqBZIg2OhvWgFwjvCRqqVlvOOmaC6tZUcnjlITBMIlv/WmBkLlDd8DeJI8mpH2ISuIE
         klfeExtpZcizD/bMSC7jrv9pYt+MLr2fFHlEPphFYVGwtlHKaNWKCF5u1pgj2JFUgFQH
         FrhmhcDStgdpz4iyj92OZAGmPyDePZAl/DKl/BaYp5GhE+yiIYMAQGq80qWwaj8FPeut
         augtBCbCCl//RnodnpvCALMhyAag2DDw1jd0F3yQdi/0vWrMJbt3/74k8s6mLoktx2kI
         dKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567821; x=1738172621;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8HXr8SgI+r6UhCYT+MAd6kxqHaYccFEHkeR1L5m1fY=;
        b=GyHp7Qm7+rbZcOnwUzhPAi3j2mr29eJMfbvShLjCy72F477q/dEnC1ekRgbaGF4yMX
         1fxq9BM/XSIczCrlxc1nucV8rVgKs8w4bDmWXTg2BJELuRhECmJjBDEWbszOY/XcZC+W
         SDkpznOvgTh4q2nE8P6c6iN39O6A7fbWT/hnngP3jeAGJ4yaheUowHl5v8Rzj1kt29Wa
         AuibFdvnlo0fGpMOE6ustl/mMiUbmK6LCIOPBjOM4SWSlub3LihLd/QjQIaQEecXL2UA
         tXWQFi3qgiIDEIMWrDHJ5q+oEkBviDysm+pIt42jZk/INuhYYSFrMOpQKMaMDHhu3vpz
         NUhA==
X-Forwarded-Encrypted: i=1; AJvYcCV1YxUfiLaKkWiWJbQ4dsdNDK0mpG4MA/+2di1otNwPkIcFex4eQYsXZSi3k9z23PM/niI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaWwmbO/HXyJk5WJUmO9q36w7SjRFJmEC4pRUuDL0ldt+iJqyH
	ES71CumW5mJCOTtWJ14mGRx9T56wtT6bReNGbkEO80XSzRnmQlnZ5ymlibfw57Sl5mrSkb0ToNz
	wjW4Pcw==
X-Google-Smtp-Source: AGHT+IGhCPmjvfGdPiyXd9giBMKNKrOXwybaQdAefSbrhuN2Yt8JMfByLosaj4pwSqxurxraV2JY+jirZrqi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:9e90:0:b0:e4a:9d0a:4e51 with SMTP id
 3f1490d57ef6-e57b13b42d1mr54175276.8.1737567821529; Wed, 22 Jan 2025 09:43:41
 -0800 (PST)
Date: Wed, 22 Jan 2025 09:43:03 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 13/18] perf build: Remove libbfd support
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

libbfd is license incompatible with perf and building requires the
BUILD_NONDISTRO=1 build flag. Remove the code to simplify the code
base.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-check.txt |   1 -
 tools/perf/Makefile.config              |  38 +---
 tools/perf/builtin-check.c              |   1 -
 tools/perf/tests/Build                  |   1 -
 tools/perf/tests/builtin-test.c         |   1 -
 tools/perf/tests/pe-file-parsing.c      | 101 ----------
 tools/perf/tests/tests.h                |   1 -
 tools/perf/util/demangle-cxx.cpp        |  13 +-
 tools/perf/util/disasm_bpf.c            | 166 ----------------
 tools/perf/util/srcline.c               | 243 +-----------------------
 tools/perf/util/symbol-elf.c            |  86 +--------
 tools/perf/util/symbol.c                | 135 -------------
 tools/perf/util/symbol.h                |   4 -
 13 files changed, 7 insertions(+), 784 deletions(-)
 delete mode 100644 tools/perf/tests/pe-file-parsing.c

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index a764a4629220..f6ec81ad87b2 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -51,7 +51,6 @@ feature::
                 dwarf_getlocations      /  HAVE_LIBDW_SUPPORT
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
-                libbfd                  /  HAVE_LIBBFD_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
                 libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5c2814acc5d5..900be0349de9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -911,42 +911,6 @@ ifneq ($(NO_JEVENTS),1)
   endif
 endif
 
-ifdef BUILD_NONDISTRO
-  ifeq ($(feature-libbfd), 1)
-    EXTLIBS += -lbfd -lopcodes
-  else
-    # we are on a system that requires -liberty and (maybe) -lz
-    # to link against -lbfd; test each case individually here
-
-    # call all detections now so we get correct
-    # status in VF output
-    $(call feature_check,libbfd-liberty)
-    $(call feature_check,libbfd-liberty-z)
-
-    ifeq ($(feature-libbfd-liberty), 1)
-      EXTLIBS += -lbfd -lopcodes -liberty
-      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
-      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -ldl
-    else
-      ifeq ($(feature-libbfd-liberty-z), 1)
-        EXTLIBS += -lbfd -lopcodes -liberty -lz
-        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
-        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
-      endif
-    endif
-    $(call feature_check,disassembler-four-args)
-    $(call feature_check,disassembler-init-styled)
-  endif
-
-  CFLAGS += -DHAVE_LIBBFD_SUPPORT
-  CXXFLAGS += -DHAVE_LIBBFD_SUPPORT
-  ifeq ($(feature-libbfd-buildid), 1)
-    CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
-  else
-    $(warning Old version of libbfd/binutils things like PE executable profiling will not be available)
-  endif
-endif
-
 ifndef NO_LIBLLVM
   $(call feature_check,llvm-perf)
   ifeq ($(feature-llvm-perf), 1)
@@ -1334,6 +1298,6 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about libbfd, disassembler-four-args, for instance.
+# tests, see the block about disassembler-four-args, for instance.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 61a11a9b4e75..046956ebf816 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -31,7 +31,6 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
-	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 4bf8d3f5eae7..165ba84dc93f 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -58,7 +58,6 @@ perf-test-y += demangle-java-test.o
 perf-test-y += demangle-ocaml-test.o
 perf-test-y += pfm.o
 perf-test-y += parse-metric.o
-perf-test-y += pe-file-parsing.o
 perf-test-y += expand-cgroup.o
 perf-test-y += perf-time-to-tsc.o
 perf-test-y += dlfilter-test.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 14d30a5053be..e77bf446e821 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -127,7 +127,6 @@ static struct test_suite *generic_tests[] = {
 	&suite__demangle_java,
 	&suite__demangle_ocaml,
 	&suite__parse_metric,
-	&suite__pe_file_parsing,
 	&suite__expand_cgroup_events,
 	&suite__perf_time_to_tsc,
 	&suite__dlfilter,
diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
deleted file mode 100644
index fff58b220c07..000000000000
--- a/tools/perf/tests/pe-file-parsing.c
+++ /dev/null
@@ -1,101 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdbool.h>
-#include <inttypes.h>
-#include <stdlib.h>
-#include <string.h>
-#include <linux/bitops.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-#include <subcmd/exec-cmd.h>
-
-#include "debug.h"
-#include "util/build-id.h"
-#include "util/symbol.h"
-#include "util/dso.h"
-
-#include "tests.h"
-
-#ifdef HAVE_LIBBFD_SUPPORT
-
-static int run_dir(const char *d)
-{
-	char filename[PATH_MAX];
-	char debugfile[PATH_MAX];
-	struct build_id bid;
-	char debuglink[PATH_MAX];
-	char expect_build_id[] = {
-		0x5a, 0x0f, 0xd8, 0x82, 0xb5, 0x30, 0x84, 0x22,
-		0x4b, 0xa4, 0x7b, 0x62, 0x4c, 0x55, 0xa4, 0x69,
-	};
-	char expect_debuglink[PATH_MAX] = "pe-file.exe.debug";
-	struct dso *dso;
-	struct symbol *sym;
-	int ret;
-	size_t idx;
-
-	scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
-	ret = filename__read_build_id(filename, &bid);
-	TEST_ASSERT_VAL("Failed to read build_id",
-			ret == sizeof(expect_build_id));
-	TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
-						  sizeof(expect_build_id)));
-
-	ret = filename__read_debuglink(filename, debuglink, PATH_MAX);
-	TEST_ASSERT_VAL("Failed to read debuglink", ret == 0);
-	TEST_ASSERT_VAL("Wrong debuglink",
-			!strcmp(debuglink, expect_debuglink));
-
-	scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
-	ret = filename__read_build_id(debugfile, &bid);
-	TEST_ASSERT_VAL("Failed to read debug file build_id",
-			ret == sizeof(expect_build_id));
-	TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_id,
-						  sizeof(expect_build_id)));
-
-	dso = dso__new(filename);
-	TEST_ASSERT_VAL("Failed to get dso", dso);
-
-	ret = dso__load_bfd_symbols(dso, debugfile);
-	TEST_ASSERT_VAL("Failed to load symbols", ret == 0);
-
-	dso__sort_by_name(dso);
-	sym = dso__find_symbol_by_name(dso, "main", &idx);
-	TEST_ASSERT_VAL("Failed to find main", sym);
-	dso__delete(dso);
-
-	return TEST_OK;
-}
-
-static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
-			  int subtest __maybe_unused)
-{
-	struct stat st;
-	char path_dir[PATH_MAX];
-
-	/* First try development tree tests. */
-	if (!lstat("./tests", &st))
-		return run_dir("./tests");
-
-	/* Then installed path. */
-	snprintf(path_dir, PATH_MAX, "%s/tests", get_argv_exec_path());
-
-	if (!lstat(path_dir, &st))
-		return run_dir(path_dir);
-
-	return TEST_SKIP;
-}
-
-#else
-
-static int test__pe_file_parsing(struct test_suite *test __maybe_unused,
-			  int subtest __maybe_unused)
-{
-	return TEST_SKIP;
-}
-
-#endif
-
-DEFINE_SUITE("PE file support", pe_file_parsing);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8aea344536b8..751c8489059a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -159,7 +159,6 @@ DECLARE_SUITE(demangle_java);
 DECLARE_SUITE(demangle_ocaml);
 DECLARE_SUITE(pfm);
 DECLARE_SUITE(parse_metric);
-DECLARE_SUITE(pe_file_parsing);
 DECLARE_SUITE(expand_cgroup_events);
 DECLARE_SUITE(perf_time_to_tsc);
 DECLARE_SUITE(dlfilter);
diff --git a/tools/perf/util/demangle-cxx.cpp b/tools/perf/util/demangle-cxx.cpp
index 85b706641837..bd657eb37efc 100644
--- a/tools/perf/util/demangle-cxx.cpp
+++ b/tools/perf/util/demangle-cxx.cpp
@@ -4,16 +4,11 @@
 #include <string.h>
 #include <linux/compiler.h>
 
-#ifdef HAVE_LIBBFD_SUPPORT
-#define PACKAGE 'perf'
-#include <bfd.h>
-#endif
-
 #ifdef HAVE_CXA_DEMANGLE_SUPPORT
 #include <cxxabi.h>
 #endif
 
-#if defined(HAVE_LIBBFD_SUPPORT) || defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
+#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
 #ifndef DMGL_PARAMS
 #define DMGL_PARAMS     (1 << 0)  /* Include function args */
 #define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
@@ -29,11 +24,7 @@ extern "C"
 char *cxx_demangle_sym(const char *str, bool params __maybe_unused,
                        bool modifiers __maybe_unused)
 {
-#ifdef HAVE_LIBBFD_SUPPORT
-        int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
-
-        return bfd_demangle(NULL, str, flags);
-#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
+#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
         int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
 
         return cplus_demangle(str, flags);
diff --git a/tools/perf/util/disasm_bpf.c b/tools/perf/util/disasm_bpf.c
index 1fee71c79b62..a891a0b909a7 100644
--- a/tools/perf/util/disasm_bpf.c
+++ b/tools/perf/util/disasm_bpf.c
@@ -6,176 +6,10 @@
 #include <linux/zalloc.h>
 #include <string.h>
 
-#if defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
-#define PACKAGE "perf"
-#include <bfd.h>
-#include <bpf/bpf.h>
-#include <bpf/btf.h>
-#include <bpf/libbpf.h>
-#include <dis-asm.h>
-#include <errno.h>
-#include <linux/btf.h>
-#include <tools/dis-asm-compat.h>
-
-#include "util/bpf-event.h"
-#include "util/bpf-utils.h"
-#include "util/debug.h"
-#include "util/dso.h"
-#include "util/map.h"
-#include "util/env.h"
-#include "util/util.h"
-
-int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args)
-{
-	struct annotation *notes = symbol__annotation(sym);
-	struct bpf_prog_linfo *prog_linfo = NULL;
-	struct bpf_prog_info_node *info_node;
-	int len = sym->end - sym->start;
-	disassembler_ftype disassemble;
-	struct map *map = args->ms.map;
-	struct perf_bpil *info_linear;
-	struct disassemble_info info;
-	struct dso *dso = map__dso(map);
-	int pc = 0, count, sub_id;
-	struct btf *btf = NULL;
-	char tpath[PATH_MAX];
-	size_t buf_size;
-	int nr_skip = 0;
-	char *buf;
-	bfd *bfdf;
-	int ret;
-	FILE *s;
-
-	if (dso__binary_type(dso) != DSO_BINARY_TYPE__BPF_PROG_INFO)
-		return SYMBOL_ANNOTATE_ERRNO__BPF_INVALID_FILE;
-
-	pr_debug("%s: handling sym %s addr %" PRIx64 " len %" PRIx64 "\n", __func__,
-		  sym->name, sym->start, sym->end - sym->start);
-
-	memset(tpath, 0, sizeof(tpath));
-	perf_exe(tpath, sizeof(tpath));
-
-	bfdf = bfd_openr(tpath, NULL);
-	if (bfdf == NULL)
-		abort();
-
-	if (!bfd_check_format(bfdf, bfd_object))
-		abort();
-
-	s = open_memstream(&buf, &buf_size);
-	if (!s) {
-		ret = errno;
-		goto out;
-	}
-	init_disassemble_info_compat(&info, s,
-				     (fprintf_ftype) fprintf,
-				     fprintf_styled);
-	info.arch = bfd_get_arch(bfdf);
-	info.mach = bfd_get_mach(bfdf);
-
-	info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
-						 dso__bpf_prog(dso)->id);
-	if (!info_node) {
-		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
-		goto out;
-	}
-	info_linear = info_node->info_linear;
-	sub_id = dso__bpf_prog(dso)->sub_id;
-
-	info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
-	info.buffer_length = info_linear->info.jited_prog_len;
-
-	if (info_linear->info.nr_line_info)
-		prog_linfo = bpf_prog_linfo__new(&info_linear->info);
-
-	if (info_linear->info.btf_id) {
-		struct btf_node *node;
-
-		node = perf_env__find_btf(dso__bpf_prog(dso)->env,
-					  info_linear->info.btf_id);
-		if (node)
-			btf = btf__new((__u8 *)(node->data),
-				       node->data_size);
-	}
-
-	disassemble_init_for_target(&info);
-
-#ifdef DISASM_FOUR_ARGS_SIGNATURE
-	disassemble = disassembler(info.arch,
-				   bfd_big_endian(bfdf),
-				   info.mach,
-				   bfdf);
-#else
-	disassemble = disassembler(bfdf);
-#endif
-	if (disassemble == NULL)
-		abort();
-
-	fflush(s);
-	do {
-		const struct bpf_line_info *linfo = NULL;
-		struct disasm_line *dl;
-		size_t prev_buf_size;
-		const char *srcline;
-		u64 addr;
-
-		addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
-		count = disassemble(pc, &info);
-
-		if (prog_linfo)
-			linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
-								addr, sub_id,
-								nr_skip);
-
-		if (linfo && btf) {
-			srcline = btf__name_by_offset(btf, linfo->line_off);
-			nr_skip++;
-		} else
-			srcline = NULL;
-
-		fprintf(s, "\n");
-		prev_buf_size = buf_size;
-		fflush(s);
-
-		if (!annotate_opts.hide_src_code && srcline) {
-			args->offset = -1;
-			args->line = strdup(srcline);
-			args->line_nr = 0;
-			args->fileloc = NULL;
-			args->ms.sym  = sym;
-			dl = disasm_line__new(args);
-			if (dl) {
-				annotation_line__add(&dl->al,
-						     &notes->src->source);
-			}
-		}
-
-		args->offset = pc;
-		args->line = buf + prev_buf_size;
-		args->line_nr = 0;
-		args->fileloc = NULL;
-		args->ms.sym  = sym;
-		dl = disasm_line__new(args);
-		if (dl)
-			annotation_line__add(&dl->al, &notes->src->source);
-
-		pc += count;
-	} while (count > 0 && pc < len);
-
-	ret = 0;
-out:
-	free(prog_linfo);
-	btf__free(btf);
-	fclose(s);
-	bfd_close(bfdf);
-	return ret;
-}
-#else // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
 int symbol__disassemble_bpf(struct symbol *sym __maybe_unused, struct annotate_args *args __maybe_unused)
 {
 	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
 }
-#endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
 
 int symbol__disassemble_bpf_image(struct symbol *sym, struct annotate_args *args)
 {
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 26fd55455efd..797e78826508 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -146,247 +146,8 @@ void dso__free_a2l(struct dso *dso)
 {
 	dso__free_a2l_llvm(dso);
 }
-#elif defined(HAVE_LIBBFD_SUPPORT)
 
-/*
- * Implement addr2line using libbfd.
- */
-#define PACKAGE "perf"
-#include <bfd.h>
-
-struct a2l_data {
-	const char 	*input;
-	u64	 	addr;
-
-	bool 		found;
-	const char 	*filename;
-	const char 	*funcname;
-	unsigned 	line;
-
-	bfd 		*abfd;
-	asymbol 	**syms;
-};
-
-static int bfd_error(const char *string)
-{
-	const char *errmsg;
-
-	errmsg = bfd_errmsg(bfd_get_error());
-	fflush(stdout);
-
-	if (string)
-		pr_debug("%s: %s\n", string, errmsg);
-	else
-		pr_debug("%s\n", errmsg);
-
-	return -1;
-}
-
-static int slurp_symtab(bfd *abfd, struct a2l_data *a2l)
-{
-	long storage;
-	long symcount;
-	asymbol **syms;
-	bfd_boolean dynamic = FALSE;
-
-	if ((bfd_get_file_flags(abfd) & HAS_SYMS) == 0)
-		return bfd_error(bfd_get_filename(abfd));
-
-	storage = bfd_get_symtab_upper_bound(abfd);
-	if (storage == 0L) {
-		storage = bfd_get_dynamic_symtab_upper_bound(abfd);
-		dynamic = TRUE;
-	}
-	if (storage < 0L)
-		return bfd_error(bfd_get_filename(abfd));
-
-	syms = malloc(storage);
-	if (dynamic)
-		symcount = bfd_canonicalize_dynamic_symtab(abfd, syms);
-	else
-		symcount = bfd_canonicalize_symtab(abfd, syms);
-
-	if (symcount < 0) {
-		free(syms);
-		return bfd_error(bfd_get_filename(abfd));
-	}
-
-	a2l->syms = syms;
-	return 0;
-}
-
-static void find_address_in_section(bfd *abfd, asection *section, void *data)
-{
-	bfd_vma pc, vma;
-	bfd_size_type size;
-	struct a2l_data *a2l = data;
-	flagword flags;
-
-	if (a2l->found)
-		return;
-
-#ifdef bfd_get_section_flags
-	flags = bfd_get_section_flags(abfd, section);
-#else
-	flags = bfd_section_flags(section);
-#endif
-	if ((flags & SEC_ALLOC) == 0)
-		return;
-
-	pc = a2l->addr;
-#ifdef bfd_get_section_vma
-	vma = bfd_get_section_vma(abfd, section);
-#else
-	vma = bfd_section_vma(section);
-#endif
-#ifdef bfd_get_section_size
-	size = bfd_get_section_size(section);
-#else
-	size = bfd_section_size(section);
-#endif
-
-	if (pc < vma || pc >= vma + size)
-		return;
-
-	a2l->found = bfd_find_nearest_line(abfd, section, a2l->syms, pc - vma,
-					   &a2l->filename, &a2l->funcname,
-					   &a2l->line);
-
-	if (a2l->filename && !strlen(a2l->filename))
-		a2l->filename = NULL;
-}
-
-static struct a2l_data *addr2line_init(const char *path)
-{
-	bfd *abfd;
-	struct a2l_data *a2l = NULL;
-
-	abfd = bfd_openr(path, NULL);
-	if (abfd == NULL)
-		return NULL;
-
-	if (!bfd_check_format(abfd, bfd_object))
-		goto out;
-
-	a2l = zalloc(sizeof(*a2l));
-	if (a2l == NULL)
-		goto out;
-
-	a2l->abfd = abfd;
-	a2l->input = strdup(path);
-	if (a2l->input == NULL)
-		goto out;
-
-	if (slurp_symtab(abfd, a2l))
-		goto out;
-
-	return a2l;
-
-out:
-	if (a2l) {
-		zfree((char **)&a2l->input);
-		free(a2l);
-	}
-	bfd_close(abfd);
-	return NULL;
-}
-
-static void addr2line_cleanup(struct a2l_data *a2l)
-{
-	if (a2l->abfd)
-		bfd_close(a2l->abfd);
-	zfree((char **)&a2l->input);
-	zfree(&a2l->syms);
-	free(a2l);
-}
-
-static int inline_list__append_dso_a2l(struct dso *dso,
-				       struct inline_node *node,
-				       struct symbol *sym)
-{
-	struct a2l_data *a2l = dso__a2l(dso);
-	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
-	char *srcline = NULL;
-
-	if (a2l->filename)
-		srcline = srcline_from_fileline(a2l->filename, a2l->line);
-
-	return inline_list__append(inline_sym, srcline, node);
-}
-
-static int addr2line(const char *dso_name, u64 addr,
-		     char **file, unsigned int *line, struct dso *dso,
-		     bool unwind_inlines, struct inline_node *node,
-		     struct symbol *sym)
-{
-	int ret = 0;
-	struct a2l_data *a2l = dso__a2l(dso);
-
-	if (!a2l) {
-		a2l = addr2line_init(dso_name);
-		dso__set_a2l(dso, a2l);
-	}
-
-	if (a2l == NULL) {
-		if (!symbol_conf.disable_add2line_warn)
-			pr_warning("addr2line_init failed for %s\n", dso_name);
-		return 0;
-	}
-
-	a2l->addr = addr;
-	a2l->found = false;
-
-	bfd_map_over_sections(a2l->abfd, find_address_in_section, a2l);
-
-	if (!a2l->found)
-		return 0;
-
-	if (unwind_inlines) {
-		int cnt = 0;
-
-		if (node && inline_list__append_dso_a2l(dso, node, sym))
-			return 0;
-
-		while (bfd_find_inliner_info(a2l->abfd, &a2l->filename,
-					     &a2l->funcname, &a2l->line) &&
-		       cnt++ < MAX_INLINE_NEST) {
-
-			if (a2l->filename && !strlen(a2l->filename))
-				a2l->filename = NULL;
-
-			if (node != NULL) {
-				if (inline_list__append_dso_a2l(dso, node, sym))
-					return 0;
-				// found at least one inline frame
-				ret = 1;
-			}
-		}
-	}
-
-	if (file) {
-		*file = a2l->filename ? strdup(a2l->filename) : NULL;
-		ret = *file ? 1 : 0;
-	}
-
-	if (line)
-		*line = a2l->line;
-
-	return ret;
-}
-
-void dso__free_a2l(struct dso *dso)
-{
-	struct a2l_data *a2l = dso__a2l(dso);
-
-	if (!a2l)
-		return;
-
-	addr2line_cleanup(a2l);
-
-	dso__set_a2l(dso, NULL);
-}
-
-#else /* HAVE_LIBBFD_SUPPORT */
+#else /* HAVE_LIBLLVM_SUPPORT */
 
 static int filename_split(char *filename, unsigned int *line_nr)
 {
@@ -805,7 +566,7 @@ void dso__free_a2l(struct dso *dso)
 	dso__set_a2l(dso, NULL);
 }
 
-#endif /* HAVE_LIBBFD_SUPPORT */
+#endif /* HAVE_LIBLLVM_SUPPORT */
 
 static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 					struct dso *dso, struct symbol *sym)
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66fd1249660a..8140f60af1e5 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -27,12 +27,7 @@
 #include <symbol/kallsyms.h>
 #include <internal/lib.h>
 
-#ifdef HAVE_LIBBFD_SUPPORT
-#define PACKAGE 'perf'
-#include <bfd.h>
-#endif
-
-#if defined(HAVE_LIBBFD_SUPPORT) || defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
+#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
 #ifndef DMGL_PARAMS
 #define DMGL_PARAMS     (1 << 0)  /* Include function args */
 #define DMGL_ANSI       (1 << 1)  /* Include const, volatile, etc */
@@ -291,11 +286,7 @@ static bool want_demangle(bool is_kernel_sym)
 char *cxx_demangle_sym(const char *str __maybe_unused, bool params __maybe_unused,
 		       bool modifiers __maybe_unused)
 {
-#ifdef HAVE_LIBBFD_SUPPORT
-	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
-
-	return bfd_demangle(NULL, str, flags);
-#elif defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
+#if defined(HAVE_CPLUS_DEMANGLE_SUPPORT)
 	int flags = (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI : 0);
 
 	return cplus_demangle(str, flags);
@@ -935,37 +926,6 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 	return err;
 }
 
-#ifdef HAVE_LIBBFD_BUILDID_SUPPORT
-
-static int read_build_id(const char *filename, struct build_id *bid)
-{
-	size_t size = sizeof(bid->data);
-	int err = -1;
-	bfd *abfd;
-
-	abfd = bfd_openr(filename, NULL);
-	if (!abfd)
-		return -1;
-
-	if (!bfd_check_format(abfd, bfd_object)) {
-		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
-		goto out_close;
-	}
-
-	if (!abfd->build_id || abfd->build_id->size > size)
-		goto out_close;
-
-	memcpy(bid->data, abfd->build_id->data, abfd->build_id->size);
-	memset(bid->data + abfd->build_id->size, 0, size - abfd->build_id->size);
-	err = bid->size = abfd->build_id->size;
-
-out_close:
-	bfd_close(abfd);
-	return err;
-}
-
-#else // HAVE_LIBBFD_BUILDID_SUPPORT
-
 static int read_build_id(const char *filename, struct build_id *bid)
 {
 	size_t size = sizeof(bid->data);
@@ -996,8 +956,6 @@ static int read_build_id(const char *filename, struct build_id *bid)
 	return err;
 }
 
-#endif // HAVE_LIBBFD_BUILDID_SUPPORT
-
 int filename__read_build_id(const char *filename, struct build_id *bid)
 {
 	struct kmod_path m = { .name = NULL, };
@@ -1081,44 +1039,6 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 	return err;
 }
 
-#ifdef HAVE_LIBBFD_SUPPORT
-
-int filename__read_debuglink(const char *filename, char *debuglink,
-			     size_t size)
-{
-	int err = -1;
-	asection *section;
-	bfd *abfd;
-
-	abfd = bfd_openr(filename, NULL);
-	if (!abfd)
-		return -1;
-
-	if (!bfd_check_format(abfd, bfd_object)) {
-		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
-		goto out_close;
-	}
-
-	section = bfd_get_section_by_name(abfd, ".gnu_debuglink");
-	if (!section)
-		goto out_close;
-
-	if (section->size > size)
-		goto out_close;
-
-	if (!bfd_get_section_contents(abfd, section, debuglink, 0,
-				      section->size))
-		goto out_close;
-
-	err = 0;
-
-out_close:
-	bfd_close(abfd);
-	return err;
-}
-
-#else
-
 int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size)
 {
@@ -1171,8 +1091,6 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 	return err;
 }
 
-#endif
-
 static int dso__swap_init(struct dso *dso, unsigned char eidata)
 {
 	static unsigned int const endian = 1;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 49b08adc6ee3..7c24e88f444f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1573,137 +1573,6 @@ static int dso__load_perf_map(const char *map_path, struct dso *dso)
 	return -1;
 }
 
-#ifdef HAVE_LIBBFD_SUPPORT
-#define PACKAGE 'perf'
-#include <bfd.h>
-
-static int bfd_symbols__cmpvalue(const void *a, const void *b)
-{
-	const asymbol *as = *(const asymbol **)a, *bs = *(const asymbol **)b;
-
-	if (bfd_asymbol_value(as) != bfd_asymbol_value(bs))
-		return bfd_asymbol_value(as) - bfd_asymbol_value(bs);
-
-	return bfd_asymbol_name(as)[0] - bfd_asymbol_name(bs)[0];
-}
-
-static int bfd2elf_binding(asymbol *symbol)
-{
-	if (symbol->flags & BSF_WEAK)
-		return STB_WEAK;
-	if (symbol->flags & BSF_GLOBAL)
-		return STB_GLOBAL;
-	if (symbol->flags & BSF_LOCAL)
-		return STB_LOCAL;
-	return -1;
-}
-
-int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
-{
-	int err = -1;
-	long symbols_size, symbols_count, i;
-	asection *section;
-	asymbol **symbols, *sym;
-	struct symbol *symbol;
-	bfd *abfd;
-	u64 start, len;
-
-	abfd = bfd_openr(debugfile, NULL);
-	if (!abfd)
-		return -1;
-
-	if (!bfd_check_format(abfd, bfd_object)) {
-		pr_debug2("%s: cannot read %s bfd file.\n", __func__,
-			  dso__long_name(dso));
-		goto out_close;
-	}
-
-	if (bfd_get_flavour(abfd) == bfd_target_elf_flavour)
-		goto out_close;
-
-	symbols_size = bfd_get_symtab_upper_bound(abfd);
-	if (symbols_size == 0) {
-		bfd_close(abfd);
-		return 0;
-	}
-
-	if (symbols_size < 0)
-		goto out_close;
-
-	symbols = malloc(symbols_size);
-	if (!symbols)
-		goto out_close;
-
-	symbols_count = bfd_canonicalize_symtab(abfd, symbols);
-	if (symbols_count < 0)
-		goto out_free;
-
-	section = bfd_get_section_by_name(abfd, ".text");
-	if (section) {
-		for (i = 0; i < symbols_count; ++i) {
-			if (!strcmp(bfd_asymbol_name(symbols[i]), "__ImageBase") ||
-			    !strcmp(bfd_asymbol_name(symbols[i]), "__image_base__"))
-				break;
-		}
-		if (i < symbols_count) {
-			/* PE symbols can only have 4 bytes, so use .text high bits */
-			u64 text_offset = (section->vma - (u32)section->vma)
-				+ (u32)bfd_asymbol_value(symbols[i]);
-			dso__set_text_offset(dso, text_offset);
-			dso__set_text_end(dso, (section->vma - text_offset) + section->size);
-		} else {
-			dso__set_text_offset(dso, section->vma - section->filepos);
-			dso__set_text_end(dso, section->filepos + section->size);
-		}
-	}
-
-	qsort(symbols, symbols_count, sizeof(asymbol *), bfd_symbols__cmpvalue);
-
-#ifdef bfd_get_section
-#define bfd_asymbol_section bfd_get_section
-#endif
-	for (i = 0; i < symbols_count; ++i) {
-		sym = symbols[i];
-		section = bfd_asymbol_section(sym);
-		if (bfd2elf_binding(sym) < 0)
-			continue;
-
-		while (i + 1 < symbols_count &&
-		       bfd_asymbol_section(symbols[i + 1]) == section &&
-		       bfd2elf_binding(symbols[i + 1]) < 0)
-			i++;
-
-		if (i + 1 < symbols_count &&
-		    bfd_asymbol_section(symbols[i + 1]) == section)
-			len = symbols[i + 1]->value - sym->value;
-		else
-			len = section->size - sym->value;
-
-		start = bfd_asymbol_value(sym) - dso__text_offset(dso);
-		symbol = symbol__new(start, len, bfd2elf_binding(sym), STT_FUNC,
-				     bfd_asymbol_name(sym));
-		if (!symbol)
-			goto out_free;
-
-		symbols__insert(dso__symbols(dso), symbol);
-	}
-#ifdef bfd_get_section
-#undef bfd_asymbol_section
-#endif
-
-	symbols__fixup_end(dso__symbols(dso), false);
-	symbols__fixup_duplicate(dso__symbols(dso));
-	dso__set_adjust_symbols(dso, true);
-
-	err = 0;
-out_free:
-	free(symbols);
-out_close:
-	bfd_close(abfd);
-	return err;
-}
-#endif
-
 static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 					   enum dso_binary_type type)
 {
@@ -1905,10 +1774,6 @@ int dso__load(struct dso *dso, struct map *map)
 			}
 		}
 
-#ifdef HAVE_LIBBFD_SUPPORT
-		if (is_reg)
-			bfdrc = dso__load_bfd_symbols(dso, name);
-#endif
 		if (is_reg && bfdrc < 0)
 			sirc = symsrc__init(ss, dso, name, symtab_type);
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..508fd559a8a1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -174,10 +174,6 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 
 struct symsrc;
 
-#ifdef HAVE_LIBBFD_SUPPORT
-int dso__load_bfd_symbols(struct dso *dso, const char *debugfile);
-#endif
-
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		  struct symsrc *runtime_ss, int kmodule);
 int dso__synthesize_plt_symbols(struct dso *dso, struct symsrc *ss);
-- 
2.48.1.262.g85cc9f2d1e-goog


