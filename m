Return-Path: <bpf+bounces-49509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77861A197EE
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7D61883220
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F4D218AC3;
	Wed, 22 Jan 2025 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jHO/iq7I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B7215789
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 17:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567813; cv=none; b=G5WInRlB1finMBQqpForxmQVfjW4YTHYvqgN3LW8FLSuum8GJfqbqvUcmef5UpsG+CaT0ClvNdDL87O4Tgv7X+0mOjst03jZMmspkWsa4HMtBKEWlwUcfV83ZgoOmrqRduwOHVhsRy6JBVInPDqVbOzum1arM/Bq5u7pHBH/lf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567813; c=relaxed/simple;
	bh=RzJ/ZM/6rJso/mbGk/udYiXtIsWi/jiXbJPZ5tRdElQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SAHaknd6YMuG5qgjVMOOTLAyMT8bsBcUvSAmNJ+k5VlWSnTjLFORDyeFmIcmzuJ3v34n4ElG6M14o+NUUDXYwPS4Mz9ZLkX07RVr1ipPT4RH/iIHyfkSB4bYeJkovIwycpdSBO9KsB8q+xkGkD8M5YmoUJW4cVUYegKVyl4vdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jHO/iq7I; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a1bc0c875so15706444276.2
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 09:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737567810; x=1738172610; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mI/NwUxxJipphG4Kl40p06npMBnTCon8aWqRtugXpaw=;
        b=jHO/iq7IHi7mDLdbsYvMZHm2WTGy6nq6GS9jolSpAMXz2WFJ0yvO0FtlZZBuNheP4z
         qrgPswMPmziZeeXlK9gpmuvXQN4YxBZYKEiPD+iZWLVhI2Nf6sFXS0aiihPGffkqVfn5
         a3ImYTEdsL6l4QwBJszQ0BOQnIHwbFHEOy+NFiKQ7kht+KJ3k+5xWxuhtf9F8LZ5b93S
         c71MDaiBL/+c7GK73IntY5LYjFYuNdOmoIZhri4PyEZlsYPuRSPLD3KPaYFFqZI9wJiN
         itLidanLYjA2EJd9xCu6JXBIjMBIbpKKfjhPaLd0g8UsFP5T08zDC0s2SjA93o8qafDj
         OUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737567810; x=1738172610;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mI/NwUxxJipphG4Kl40p06npMBnTCon8aWqRtugXpaw=;
        b=H9zRbHkDMO+nunL1xsTTfij2V0IxCTWSgpadUR/sQOckMVe/4fE7oGEYmxCFGOM+UQ
         /k1+sxcRWK/9UWe0O16GRmnRU8TEKVHm82Ga9uu87lquB4uHyCLy+yzdtvF2T+WwMS7r
         uEgtmnMAzbwjzLre4WO2y8Rd6S3ai0t5j66un2o/aPaMwjOQQUMhWNXsrG8KcDJa6xMl
         9xyVpuG0L66TrUV9kmnijaViMXwKpBDWHA5l4raKhCkE/hdW7kMPfM1BkQIVacTnl/RY
         UcEhfVWr3yMNCiewLY46cyZnObd3jXylPRM/1cKG1ppZ+4C1PTeV/w2Haxp/qaS/6/py
         542A==
X-Forwarded-Encrypted: i=1; AJvYcCUAGBHIbbG8qJ4H/P1eDqgcKA5Yb7YbQHob5Q90KFGt2C7LtVUBZXYiXBXvom1oj7AB258=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7/+VYvcvR+GPxS/NoelhoDFLVHUgtEtNnHot+DVp1LCTn4BR
	ykKMb0A/RnfSqQxez319H/TqCtTUm3z82dR5Jfu8Nqb298xHX7d2c49QotC4KLk76sfz8bTjp2e
	H40GorQ==
X-Google-Smtp-Source: AGHT+IHll/xav+3HBIuxK4Ms0OI0nozuQYDkqHYweMKRdst6L7cJHGaszX6h7Hxo1UgQMjl4lduKtdBhLaMz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:807b:be79:d5c3:ee5c])
 (user=irogers job=sendgmr) by 2002:a25:3fc3:0:b0:e57:faeb:8871 with SMTP id
 3f1490d57ef6-e57faeb8974mr16239276.4.1737567810198; Wed, 22 Jan 2025 09:43:30
 -0800 (PST)
Date: Wed, 22 Jan 2025 09:42:58 -0800
In-Reply-To: <20250122174308.350350-1-irogers@google.com>
Message-Id: <20250122174308.350350-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Subject: [PATCH v3 08/18] perf llvm: Mangle libperf-llvm.so function names
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

For a function like llvm_addr2line having the libperf-llvm.so exported
symbol named llvm_addr2line meant that the perf llvm_addr2line could
sometimes erroneously be returned. This led to infinite recursion and
eventual stack overflow. To avoid this conflict add a new
BUILDING_PERF_LLVMSO when libperf-llvm.so is being built and use it to
alter the behavior of MANGLE_PERF_LLVM_API, a macro that prefixes the
name when libperf-llvm.so is being built. The prefixed named avoids
the name collision.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf           |  3 ++-
 tools/perf/util/llvm-c-helpers.cpp | 29 ++++++++++++++++++-----------
 tools/perf/util/llvm-c-helpers.h   | 24 ++++++++++++++++--------
 3 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index eae77f6af59d..a2886abd4f02 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1026,7 +1026,8 @@ $(LIBSYMBOL)-clean:
 	$(Q)$(RM) -r -- $(LIBSYMBOL_OUTPUT)
 
 ifdef LIBLLVM_DYNAMIC
-LIBPERF_LLVM_CXXFLAGS := $(call filter-out,-DHAVE_LIBLLVM_DYNAMIC,$(CXXFLAGS)) -DHAVE_LIBLLVM_SUPPORT
+LIBPERF_LLVM_CXXFLAGS := $(call filter-out,-DHAVE_LIBLLVM_DYNAMIC,$(CXXFLAGS))
+LIBPERF_LLVM_CXXFLAGS += -DHAVE_LIBLLVM_SUPPORT -DBUILDING_PERF_LLVMSO
 LIBPERF_LLVM_LIBS = -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM) -lstdc++
 
 $(OUTPUT)$(LIBPERF_LLVM): util/llvm-c-helpers.cpp
diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
index 5a6f76e6b705..8cea380be5c2 100644
--- a/tools/perf/util/llvm-c-helpers.cpp
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -99,10 +99,12 @@ static int extract_file_and_line(const DILineInfo &line_info, char **file,
 #endif
 
 extern "C"
-int llvm_addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused,
-		   char **file __maybe_unused, unsigned int *line __maybe_unused,
-		   bool unwind_inlines __maybe_unused,
-		   llvm_a2l_frame **inline_frames __maybe_unused)
+int MANGLE_PERF_LLVM_API(llvm_addr2line)(const char *dso_name __maybe_unused,
+                                         u64 addr __maybe_unused,
+                                         char **file __maybe_unused,
+                                         unsigned int *line __maybe_unused,
+                                         bool unwind_inlines __maybe_unused,
+                                         llvm_a2l_frame **inline_frames __maybe_unused)
 {
 #if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 	LLVMSymbolizer *symbolizer = get_symbolizer();
@@ -177,7 +179,8 @@ int llvm_addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused,
 		if (!handle)
 			return 0;
 
-		fn = reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm_addr2line"));
+		fn = reinterpret_cast<decltype(fn)>(
+			dlsym(handle, MANGLE_PERF_LLVM_API_STR(llvm_addr2line)));
 		if (!fn)
 			pr_debug("dlsym failed for llvm_addr2line\n");
 		fn_init = true;
@@ -215,8 +218,9 @@ make_symbol_relative_string(struct dso *dso, const char *sym_name,
 #endif
 
 extern "C"
-char *llvm_name_for_code(struct dso *dso __maybe_unused, const char *dso_name __maybe_unused,
-			 u64 addr __maybe_unused)
+char *MANGLE_PERF_LLVM_API(llvm_name_for_code)(struct dso *dso __maybe_unused,
+					       const char *dso_name __maybe_unused,
+					       u64 addr __maybe_unused)
 {
 #if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 	LLVMSymbolizer *symbolizer = get_symbolizer();
@@ -242,7 +246,8 @@ char *llvm_name_for_code(struct dso *dso __maybe_unused, const char *dso_name __
 		if (!handle)
 			return NULL;
 
-		fn = reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm_name_for_code"));
+		fn = reinterpret_cast<decltype(fn)>(
+			dlsym(handle, MANGLE_PERF_LLVM_API_STR(llvm_name_for_code)));
 		if (!fn)
 			pr_debug("dlsym failed for llvm_name_for_code\n");
 		fn_init = true;
@@ -256,8 +261,9 @@ char *llvm_name_for_code(struct dso *dso __maybe_unused, const char *dso_name __
 }
 
 extern "C"
-char *llvm_name_for_data(struct dso *dso __maybe_unused, const char *dso_name __maybe_unused,
-			 u64 addr __maybe_unused)
+char *MANGLE_PERF_LLVM_API(llvm_name_for_data)(struct dso *dso __maybe_unused,
+					       const char *dso_name __maybe_unused,
+					       u64 addr __maybe_unused)
 {
 #if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 	LLVMSymbolizer *symbolizer = get_symbolizer();
@@ -283,7 +289,8 @@ char *llvm_name_for_data(struct dso *dso __maybe_unused, const char *dso_name __
 		if (!handle)
 			return NULL;
 
-		fn = reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm_name_for_data"));
+		fn = reinterpret_cast<decltype(fn)>(
+			dlsym(handle, MANGLE_PERF_LLVM_API_STR(llvm_name_for_data)));
 		if (!fn)
 			pr_debug("dlsym failed for llvm_name_for_data\n");
 		fn_init = true;
diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-helpers.h
index d2b99637a28a..cfcfd540cdae 100644
--- a/tools/perf/util/llvm-c-helpers.h
+++ b/tools/perf/util/llvm-c-helpers.h
@@ -13,6 +13,14 @@
 extern "C" {
 #endif
 
+/* Support name mangling so that libperf_llvm.so's names don't match those in perf. */
+#ifdef BUILDING_PERF_LLVMSO
+#define MANGLE_PERF_LLVM_API(x) PERF_LLVM_SO_ ## x
+#else
+#define MANGLE_PERF_LLVM_API(x) x
+#endif
+#define MANGLE_PERF_LLVM_API_STR(x) "PERF_LLVM_SO_" #x
+
 struct dso;
 
 struct llvm_a2l_frame {
@@ -37,12 +45,12 @@ struct llvm_a2l_frame {
  * a newly allocated array with that length. The caller is then responsible
  * for freeing both the strings and the array itself.
  */
-int llvm_addr2line(const char* dso_name,
-                   u64 addr,
-                   char** file,
-                   unsigned int* line,
-                   bool unwind_inlines,
-                   struct llvm_a2l_frame** inline_frames);
+int MANGLE_PERF_LLVM_API(llvm_addr2line)(const char *dso_name,
+					 u64 addr,
+					 char **file,
+					 unsigned int *line,
+					 bool unwind_inlines,
+					 struct llvm_a2l_frame **inline_frames);
 
 /*
  * Simple symbolizers for addresses; will convert something like
@@ -50,8 +58,8 @@ int llvm_addr2line(const char* dso_name,
  *
  * The returned value must be freed by the caller, with free().
  */
-char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr);
-char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr);
+char *MANGLE_PERF_LLVM_API(llvm_name_for_code)(struct dso *dso, const char *dso_name, u64 addr);
+char *MANGLE_PERF_LLVM_API(llvm_name_for_data)(struct dso *dso, const char *dso_name, u64 addr);
 
 #ifdef __cplusplus
 }
-- 
2.48.1.262.g85cc9f2d1e-goog


