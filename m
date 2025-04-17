Return-Path: <bpf+bounces-56193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAECBA92DBB
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 01:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F5D4A2520
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 23:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B3226D03;
	Thu, 17 Apr 2025 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usBHnLUB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965F225404
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931294; cv=none; b=brDUC/JMrfjWVnaWVTISeR1/C12J+88mtLjdPeuABS1teeqmxY2K9mPjvgEwrIDWJJiUggyvtROvDMg9Xl6t4Zo8XMYuXZ65lo3FnXKIg3F9Z6SBdTL6B+dTT/zu5xPxxaMNFerH0AWm8CIe6oKo6mBr3VsF10GmLkYgquGBUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931294; c=relaxed/simple;
	bh=vo0fATWMVyyAZc0aPQcFuWHRfsLIbRMrgnl393mZOuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YcuroOJtshk4DfevGnUUK12h39jXPY2JtetpIL8Zq3RhkWm1TK4RlvQ/M5lX6DVaA3/WRc+VTv4Sx9n2qUiQlrhnGGGqGxMJvExoy2eFmvoLhNkEucQv9GRcb7dUNRoUN/UYXNjFlFbvXpWVl9wuY8O7MoE1BbA9KGU52KkQ4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usBHnLUB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2262051205aso10072715ad.3
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 16:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931291; x=1745536091; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOWuhbgsGhCOfYjY+PJ0Yf970aP5bSbLzlrRNECM4Bs=;
        b=usBHnLUBrWTJ8yjuWfvOO0v5CrlxV/C3ynD6XYXH/vlUHEKhcXVkAuADsIBOtTySmW
         2kgSLvCrtLO+Q9Feott/QOSlHOcnlbvvqHrRufFaS/EXGtP70PSSN1NbqX92cOyvpJhC
         JIpEBFkWGTcXZN4DK9XsqHY/dkDS9odEClKcj721MQCCwIBl3XhRUGp0+IvMDePLBnR+
         shrmaZU6xA+YKfV4M1nzcUOglsDiJ2pQSLuPgLtpvD5idLK2qM45rwpUW/CRpeNyCckj
         D1st6J7kyJOEW/NeMHvb068f0Vrm28FcHZkgDEJSfmGpXadHsIZb5JdqP+JrNO+0uGc/
         XifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931291; x=1745536091;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOWuhbgsGhCOfYjY+PJ0Yf970aP5bSbLzlrRNECM4Bs=;
        b=XkKZxIpcqanl1E1M52yvNrMCuXJyn7PWNpNdWIFKCBmh4BpEeDmav+C82g6z9FDKe4
         c+ztoxGhicO1vkViB74e+i7dAaQ6e3lNK93W2FJyG7kP7n/Sn3fuE829ighJfcEzl15p
         6ypwQ0K9oWgKG3RE/957e7g0ARuAXAFUK7uXIwrxGGszqx9sWgnIarucOoRRxvBfsicN
         GfFAOL1Sk8rXyx0pyjTnpsr6qvujf3S8SN1zuzoqEjag4FVB8lb5WIfODMLmJ4OTfxVB
         PwGREUVN0EosG1uwZjnyX3scP3o4r8zqbUSmlMtmQl2JhrK5y1FjdK9o/+Zub7tGLaat
         rD4A==
X-Forwarded-Encrypted: i=1; AJvYcCWqpr5HmTRNk/l2n6Aex/tcUifkKPThdqnIxyE79eJYCbl+vJucx2vOqHXdqhFDF4Ml+Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKhEprWR59j/wJ0Em/U+YmV9qIe6IByt/iuBPNwLrqpFMZ9oe
	0yA1V+Sn+TtLgpSfn/znsif4X+CBMFDYkRyyN0PvM9RtauaH6jPuyJ22wwcCYDFlQ3Fp9ne7Aq3
	TjPof+A==
X-Google-Smtp-Source: AGHT+IHoEc6jQbq8HuRmqmXiqrWdB4nYrkkSkauIGXEi8gW5l81eNAz3y+nJ3Ah8XzFLGgTQsEEewT4YwJxl
X-Received: from pljs6.prod.google.com ([2002:a17:903:3ba6:b0:216:25a2:2ecf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d0d:b0:224:c76:5e56
 with SMTP id d9443c01a7336-22c535acd99mr8848435ad.27.1744931291201; Thu, 17
 Apr 2025 16:08:11 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:29 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-9-irogers@google.com>
Subject: [PATCH v4 08/19] perf llvm: Mangle libperf-llvm.so function names
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
index 6833dda27ffb..fc65537d5821 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1003,7 +1003,8 @@ $(LIBSYMBOL)-clean:
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
2.49.0.805.g082f7c87e0-goog


