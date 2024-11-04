Return-Path: <bpf+bounces-43965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9A09BBFBC
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 22:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BC01F22D76
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 21:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15B41FE115;
	Mon,  4 Nov 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sswPu3Wy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD01FE0F0
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754454; cv=none; b=VK+wEupjhK4by4lVNx+zIo2egz2vSKtdBHg5znFS8479Q5pFkiIg4IJSMUVO2H3Kiovu960zcbHFtVMQKSTr5Cq0KT33W8wRoO8IQiWjIREtlciu8DlXN8VDL2FXp6pkDYKx3D4GmW/CYgCQ09WBlPz2h6/SQ0Bw4t3c4S39Xw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754454; c=relaxed/simple;
	bh=6y7pW6bYatWs4fz6JTfktAE3Hfhz62HJ2j6IOeJjUHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGQ01KtDooS3gi/BBskGj94cI8ZrutuDbjaTMpmXPw6psxXpbRvD7tf9nLchkAScFeB2iloIYFc0SZNBKT88xFX9T6sbIvJUE/aweVugB8+8WlnD2RES2fCdsvBbvCmygoZ+TI9hGu52RucR25n0CfJu7JohKvmmfLcT3z9i0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sswPu3Wy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c767a9c50so44536355ad.1
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 13:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730754451; x=1731359251; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1ySFoC2Gtls3bHo/wztRlUS3fRNstRWKzdIgj1r38o=;
        b=sswPu3Wy6Iq3uuYRn94FFXr1C13zrsA030s5N5E0RbCmDufYcK2R0SMcTflrQYjSvj
         V6sTIJUU/laP/D+PMaBshKjh07CTsLxGQf+kOePS+i2cVmsmGl4hU+912KZiUiTU5Lbz
         UDEK/p7xOiElj9VfjM+lKu6fx+VtI/I7Cht+V+yj5EAAw7mme7kQQltdmBC7rlcgHf1/
         hfaliz88vrni5M1n6mgzYVRtyoJ0O2ngfNXNFAt05k3Yy7l6RXHA6ppyp8FVMUm8MCSj
         Nk+5xLgCILtmZxRw8yhZEcrl5r4fyxqcOMsTDuhGKlM3tKpOHBeYJS+crSjDRKCk1oDb
         omjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754451; x=1731359251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1ySFoC2Gtls3bHo/wztRlUS3fRNstRWKzdIgj1r38o=;
        b=xEml8TLQ7imQBVDSi2cb6h0Ah88qgZ02Txlj/gQdrtElBW2UwDqwESz7q2gxS4RDB9
         wLaoQwWjxWk+B3TTmeoyuP3UXMlhewSKTwYkOl+wyIfyGnSWa1XQsqM9053vwsxQeRVx
         QAEFj/Xuu+fX0WlwmkR4qU6eVnMmKMLOWOFJvdpq0RtwOFWWmILhn4AvnwECoJEo9XUA
         Hb0iQdhDL9K98+k4qnroAh8ZDiqIe+fKfLyeRLWAoWDro8zlzkHtNoscxt7WMuuryuGy
         CrdWNZHE2e4GHoj3FgZvpW3yvtaHuxJnH/jU2eS8zmfgPVFGL9Qzz5tuAJQaigLJeG+X
         AVqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxbxh912xvewRa6mu2Nps+rL1FXiSr1b9NvHY4T3RaX5OvavfEO/e8ozlYZe9kTE1OfuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHbZkoKKudtojhpxPqOD6jWqumzgMaZtBV8AFlVZMnqDbGsDd
	lcaDcwTBJiHlNVZAFwZBpHA8y0FGA/7FHdeCcC7hY/ocqYTxJvb18FFLat8jznQ=
X-Google-Smtp-Source: AGHT+IHZLeSvLWg+c/NrV1mAHttcDSQz0V6uMdp60JV/DKhgnpjHS++3JuhXIce0N0Lwyi3IT2MGOw==
X-Received: by 2002:a17:902:e887:b0:20c:dee0:7256 with SMTP id d9443c01a7336-2111b023916mr190990075ad.58.1730754451077;
        Mon, 04 Nov 2024 13:07:31 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm7248293a12.40.2024.11.04.13.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:07:30 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:06:18 -0800
Subject: [PATCH RFT 16/16] perf tools: Remove dependency on libaudit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-perf_syscalltbl-v1-16-9adae5c761ef@rivosinc.com>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
In-Reply-To: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16980; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=6y7pW6bYatWs4fz6JTfktAE3Hfhz62HJ2j6IOeJjUHM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmebxL5oMlb+IOdLy1/ltSrHsgxZPluHSAJ9Mse8cp+
 c1h07I6SlkYxDgYZMUUWXiuNTC33tEvOypaNgFmDisTyBAGLk4BmEj0BUaGOQ0hzpO67N4q8dn9
 CWQ6m7eoW5Tv38vIYzdSWKprhf4/ZGRYKK724egidt2CqSKaZl4rrmesMWPdItj5pK32EsOeM6l
 MAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

All architectures now support HAVE_SYSCALL_TABLE_SUPPORT, so the flag is
no longer needed. With the removal of the flag, the related
GENERIC_SYSCALL_TABLE can also be removed. libaudit was only used as a
fallback for when HAVE_SYSCALL_TABLE_SUPPORT was not defined, so
libaudit is also no longer needed for any architecture.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/admin-guide/workload-tracing.rst |  2 +-
 tools/build/feature/Makefile                   |  4 --
 tools/build/feature/test-libaudit.c            | 11 ------
 tools/perf/Documentation/perf-check.txt        |  1 -
 tools/perf/Makefile.config                     | 31 +--------------
 tools/perf/Makefile.perf                       | 14 -------
 tools/perf/builtin-check.c                     |  1 -
 tools/perf/builtin-help.c                      |  2 -
 tools/perf/builtin-trace.c                     | 30 ---------------
 tools/perf/perf.c                              |  6 +--
 tools/perf/tests/make                          |  7 +---
 tools/perf/util/env.c                          |  4 +-
 tools/perf/util/generate-cmdlist.sh            |  4 +-
 tools/perf/util/syscalltbl.c                   | 52 --------------------------
 14 files changed, 10 insertions(+), 159 deletions(-)

diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
index b2e254ec8ee8..6be38c1b9c5b 100644
--- a/Documentation/admin-guide/workload-tracing.rst
+++ b/Documentation/admin-guide/workload-tracing.rst
@@ -83,7 +83,7 @@ scripts/ver_linux is a good way to check if your system already has
 the necessary tools::
 
   sudo apt-get build-essentials flex bison yacc
-  sudo apt install libelf-dev systemtap-sdt-dev libaudit-dev libslang2-dev libperl-dev libdw-dev
+  sudo apt install libelf-dev systemtap-sdt-dev libslang2-dev libperl-dev libdw-dev
 
 cscope is a good tool to browse kernel sources. Let's install it now::
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 1658596188bf..728420d3888f 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -15,7 +15,6 @@ FILES=                                          \
          test-gtk2.bin                          \
          test-gtk2-infobar.bin                  \
          test-hello.bin                         \
-         test-libaudit.bin                      \
          test-libbfd.bin                        \
          test-libbfd-buildid.bin		\
          test-disassembler-four-args.bin        \
@@ -236,9 +235,6 @@ $(OUTPUT)test-libunwind-debug-frame-arm.bin:
 $(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
 	$(BUILD) -lelf -llzma -lunwind-aarch64
 
-$(OUTPUT)test-libaudit.bin:
-	$(BUILD) -laudit
-
 $(OUTPUT)test-libslang.bin:
 	$(BUILD) -lslang
 
diff --git a/tools/build/feature/test-libaudit.c b/tools/build/feature/test-libaudit.c
deleted file mode 100644
index f5b0863fa1ec..000000000000
--- a/tools/build/feature/test-libaudit.c
+++ /dev/null
@@ -1,11 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <libaudit.h>
-
-extern int printf(const char *format, ...);
-
-int main(void)
-{
-	printf("error message: %s\n", audit_errno_to_name(0));
-
-	return audit_open();
-}
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 10f69fb6850b..27e6b97961f3 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -51,7 +51,6 @@ feature::
                 dwarf_getlocations      /  HAVE_DWARF_GETLOCATIONS_SUPPORT
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
-                libaudit                /  HAVE_LIBAUDIT_SUPPORT
                 libbfd                  /  HAVE_LIBBFD_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 787be3201eec..352f32f5cb81 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -28,20 +28,7 @@ include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,SRCARCH)
 
-ifneq ($(NO_SYSCALL_TABLE),1)
-  NO_SYSCALL_TABLE := 1
-
-  # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc s390))
-    NO_SYSCALL_TABLE := 0
-    CFLAGS += -DGENERIC_SYSCALL_TABLE
-    CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
-  endif
-
-  ifneq ($(NO_SYSCALL_TABLE),1)
-    CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
-  endif
-endif
+CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
 
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
@@ -784,21 +771,7 @@ ifndef NO_LIBUNWIND
 endif
 
 ifneq ($(NO_LIBTRACEEVENT),1)
-  ifeq ($(NO_SYSCALL_TABLE),0)
-    $(call detected,CONFIG_TRACE)
-  else
-    ifndef NO_LIBAUDIT
-      $(call feature_check,libaudit)
-      ifneq ($(feature-libaudit), 1)
-        $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev)
-        NO_LIBAUDIT := 1
-      else
-        CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
-        EXTLIBS += -laudit
-        $(call detected,CONFIG_TRACE)
-      endif
-    endif
-  endif
+  $(call detected,CONFIG_TRACE)
 endif
 
 ifndef NO_LIBCRYPTO
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 410d850f7b9a..a21d4d0994af 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -59,8 +59,6 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBNUMA if you do not want numa perf benchmark
 #
-# Define NO_LIBAUDIT if you do not want libaudit support
-#
 # Define NO_LIBBIONIC if you do not want bionic support
 #
 # Define NO_LIBCRYPTO if you do not want libcrypto (openssl) support
@@ -119,10 +117,6 @@ include ../scripts/utilities.mak
 #
 # Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
 #
-# Define NO_SYSCALL_TABLE=1 to disable the use of syscall id to/from name tables
-# generated from the kernel .tbl or unistd.h files and use, if available, libaudit
-# for doing the conversions to/from strings/id.
-#
 # Define NO_LIBPFM4 to disable libpfm4 events extension.
 #
 # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
@@ -310,10 +304,7 @@ ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
 FEATURE_TESTS := all
 endif
 endif
-# architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc s390))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
-endif
 include Makefile.config
 endif
 
@@ -1098,11 +1089,6 @@ endif
 		$(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
 	$(call QUIET_INSTALL, perf-iostat) \
 		$(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
-ifndef NO_LIBAUDIT
-	$(call QUIET_INSTALL, strace/groups) \
-		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'; \
-		$(INSTALL) trace/strace/groups/* -m 644 -t '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'
-endif
 ifndef NO_LIBPERL
 	$(call QUIET_INSTALL, perl-scripts) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 0b76b6e42b78..5af0987d7d4c 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -31,7 +31,6 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
-	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
 	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 0854d3cd9f6a..7be6fb6df595 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -447,9 +447,7 @@ int cmd_help(int argc, const char **argv)
 #ifdef HAVE_LIBELF_SUPPORT
 		"probe",
 #endif
-#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
 		"trace",
-#endif
 	NULL };
 	const char *builtin_help_usage[] = {
 		"perf help [--all] [--man|--web|--info] [command]",
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3f11b90d025..0374dedaa2ef 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2069,30 +2069,11 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	const char *name = syscalltbl__name(trace->sctbl, id);
 	int err;
 
-#ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (trace->syscalls.table == NULL) {
 		trace->syscalls.table = calloc(trace->sctbl->syscalls.max_id + 1, sizeof(*sc));
 		if (trace->syscalls.table == NULL)
 			return -ENOMEM;
 	}
-#else
-	if (id > trace->sctbl->syscalls.max_id || (id == 0 && trace->syscalls.table == NULL)) {
-		// When using libaudit we don't know beforehand what is the max syscall id
-		struct syscall *table = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
-
-		if (table == NULL)
-			return -ENOMEM;
-
-		// Need to memset from offset 0 and +1 members if brand new
-		if (trace->syscalls.table == NULL)
-			memset(table, 0, (id + 1) * sizeof(*sc));
-		else
-			memset(table + trace->sctbl->syscalls.max_id + 1, 0, (id - trace->sctbl->syscalls.max_id) * sizeof(*sc));
-
-		trace->syscalls.table	      = table;
-		trace->sctbl->syscalls.max_id = id;
-	}
-#endif
 	sc = trace->syscalls.table + id;
 	if (sc->nonexistent)
 		return -EEXIST;
@@ -2439,18 +2420,7 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 
 	err = -EINVAL;
 
-#ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (id > trace->sctbl->syscalls.max_id) {
-#else
-	if (id >= trace->sctbl->syscalls.max_id) {
-		/*
-		 * With libaudit we don't know beforehand what is the max_id,
-		 * so we let trace__read_syscall_info() figure that out as we
-		 * go on reading syscalls.
-		 */
-		err = trace__read_syscall_info(trace, id);
-		if (err)
-#endif
 		goto out_cant_read;
 	}
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 4def800f4089..9f99c6979409 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -84,7 +84,7 @@ static struct cmd_struct commands[] = {
 #endif
 	{ "kvm",	cmd_kvm,	0 },
 	{ "test",	cmd_test,	0 },
-#if defined(HAVE_LIBTRACEEVENT) && (defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT))
+#if defined(HAVE_LIBTRACEEVENT)
 	{ "trace",	cmd_trace,	0 },
 #endif
 	{ "inject",	cmd_inject,	0 },
@@ -514,10 +514,6 @@ int main(int argc, const char **argv)
 		fprintf(stderr,
 			"trace command not available: missing libtraceevent devel package at build time.\n");
 		goto out;
-#elif !defined(HAVE_LIBAUDIT_SUPPORT) && !defined(HAVE_SYSCALL_TABLE_SUPPORT)
-		fprintf(stderr,
-			"trace command not available: missing audit-libs devel package at build time.\n");
-		goto out;
 #else
 		setup_path();
 		argv[0] = "trace";
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index a5040772043f..0d2b6c85dc03 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -86,7 +86,6 @@ make_no_libdw_dwarf_unwind := NO_LIBDW_DWARF_UNWIND=1
 make_no_backtrace   := NO_BACKTRACE=1
 make_no_libcapstone := NO_CAPSTONE=1
 make_no_libnuma     := NO_LIBNUMA=1
-make_no_libaudit    := NO_LIBAUDIT=1
 make_no_libbionic   := NO_LIBBIONIC=1
 make_no_auxtrace    := NO_AUXTRACE=1
 make_no_libbpf	    := NO_LIBBPF=1
@@ -97,7 +96,6 @@ make_no_libllvm     := NO_LIBLLVM=1
 make_with_babeltrace:= LIBBABELTRACE=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
-make_no_syscall_tbl := NO_SYSCALL_TABLE=1
 make_no_libpfm4     := NO_LIBPFM4=1
 make_with_gtk2      := GTK2=1
 make_refcnt_check   := EXTRA_CFLAGS="-DREFCNT_CHECKING=1"
@@ -122,10 +120,10 @@ make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX3
 # all the NO_* variable combined
 make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
-make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
+make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1
 make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
 make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
-make_minimal        += NO_LIBCAP=1 NO_SYSCALL_TABLE=1 NO_CAPSTONE=1
+make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
 
 # $(run) contains all available tests
 run := make_pure
@@ -158,7 +156,6 @@ run += make_no_libdw_dwarf_unwind
 run += make_no_backtrace
 run += make_no_libcapstone
 run += make_no_libnuma
-run += make_no_libaudit
 run += make_no_libbionic
 run += make_no_auxtrace
 run += make_no_libbpf
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1edbccfc3281..4d915adc7239 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -471,13 +471,13 @@ const char *perf_env__arch(struct perf_env *env)
 
 const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
 {
-#if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#if defined(HAVE_LIBTRACEEVENT)
 	if (env->arch_strerrno == NULL)
 		env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
 
 	return env->arch_strerrno ? env->arch_strerrno(err) : "no arch specific strerrno function";
 #else
-	return "!(HAVE_SYSCALL_TABLE_SUPPORT && HAVE_LIBTRACEEVENT)";
+	return "!HAVE_LIBTRACEEVENT";
 #endif
 }
 
diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
index 1b5140e5ce99..6a73c903d690 100755
--- a/tools/perf/util/generate-cmdlist.sh
+++ b/tools/perf/util/generate-cmdlist.sh
@@ -38,7 +38,7 @@ do
 done
 echo "#endif /* HAVE_LIBELF_SUPPORT */"
 
-echo "#if defined(HAVE_LIBTRACEEVENT) && (defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT))"
+echo "#if defined(HAVE_LIBTRACEEVENT)"
 sed -n -e 's/^perf-\([^ 	]*\)[ 	].* audit*/\1/p' command-list.txt |
 sort |
 while read cmd
@@ -51,7 +51,7 @@ do
 	    p
      }' "Documentation/perf-$cmd.txt"
 done
-echo "#endif /* HAVE_LIBTRACEEVENT && (HAVE_LIBAUDIT_SUPPORT || HAVE_SYSCALL_TABLE_SUPPORT) */"
+echo "#endif /* HAVE_LIBTRACEEVENT */"
 
 echo "#ifdef HAVE_LIBTRACEEVENT"
 sed -n -e 's/^perf-\([^ 	]*\)[ 	].* traceevent.*/\1/p' command-list.txt |
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 9341f0d442fe..7e24e4164da9 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -9,20 +9,12 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
-#ifdef HAVE_SYSCALL_TABLE_SUPPORT
 #include <string.h>
 #include "string2.h"
 
-#if defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl;
-#else
-const int syscalltbl_native_max_id = 0;
-static const char *const syscalltbl_native[] = {
-	[0] = "unknown",
-};
-#endif
 
 struct syscall {
 	int id;
@@ -130,47 +122,3 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
 	*idx = -1;
 	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
 }
-
-#else /* HAVE_SYSCALL_TABLE_SUPPORT */
-
-#include <libaudit.h>
-
-struct syscalltbl *syscalltbl__new(void)
-{
-	struct syscalltbl *tbl = zalloc(sizeof(*tbl));
-	if (tbl)
-		tbl->audit_machine = audit_detect_machine();
-	return tbl;
-}
-
-void syscalltbl__delete(struct syscalltbl *tbl)
-{
-	free(tbl);
-}
-
-const char *syscalltbl__name(const struct syscalltbl *tbl, int id)
-{
-	return audit_syscall_to_name(id, tbl->audit_machine);
-}
-
-int syscalltbl__id(struct syscalltbl *tbl, const char *name)
-{
-	return audit_name_to_syscall(name, tbl->audit_machine);
-}
-
-int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx)
-{
-	return idx;
-}
-
-int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
-				  const char *syscall_glob __maybe_unused, int *idx __maybe_unused)
-{
-	return -1;
-}
-
-int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
-{
-	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
-}
-#endif /* HAVE_SYSCALL_TABLE_SUPPORT */

-- 
2.34.1


