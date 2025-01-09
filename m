Return-Path: <bpf+bounces-48344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41333A06B8A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 03:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44F93A4779
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 02:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E71204F66;
	Thu,  9 Jan 2025 02:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CEZVAAnD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4D204095
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390240; cv=none; b=NdGeZAbm5fMZDYumJBsf9ksiippTEg6NGKELbSKFafE+vMmzCNCvgOQgrBdmb8qKBejcdVNTZKmcaVOli5nXKZJRBjLhq4Bn58TReEujg1tMFsGo+s3sPojjxX0yiZV4veVgd6NiVZOO9XKm+KJxd/CktEDJYwDp/6pGGfi1QEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390240; c=relaxed/simple;
	bh=IIAUq83swkQS2L3CQ8q9+4EMHD3YoO1APmWKQvLl73Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JhO2cVuNAKE2FnTjcadizbUvDXzVHIIUA/c3Xr8frVISV3PfSdHpCJ+TBwl8PBFJxRpbG0n7ELqK5x0OhDlmyB67nB+ngceHsFUMKXJtAa1uJevKeE8fbQ2HHh6P06d0fbBopiykTUxKldjTNEIhUIzm2n6aMcHc+ubD/Brc/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CEZVAAnD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2167141dfa1so7261865ad.1
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 18:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736390237; x=1736995037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmoUDP2j7lySiEXnhAmYjytyq32XIAMnos02j/GTGtY=;
        b=CEZVAAnDI7QS+FnvKAPrFaOukxHWrkdqE8gAwsK2SupBDSqgj1Rc7SYSJt1UOBU/za
         DS+RYwO1Wuj29kK9+F2FAQPmBXU10tyGX67tXI2sVUUZVZ8CWFDG919jX0vq+LGcVn6X
         HCc84fzSdLne890TdKwqrLtCmG3QWrluGaTIsRILr5OeDM36bLrlXHBQN1rx3k4R/XUZ
         aH8VuNlZxJSGr6GAhtDy5vheF5m1n4CmlI40QwJYvL5QTiN9Aw+P2wuMgCS3rOa2Rx/S
         q6f8m4QIAS714zXTNEXskvwB7Y7JaRnZF+CO8tGd76vsIt+HueJu2HUFALid+u2eMWjS
         lGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736390237; x=1736995037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmoUDP2j7lySiEXnhAmYjytyq32XIAMnos02j/GTGtY=;
        b=G8tS7vpXm6dJCCGSLjhZCwxtCVuqrYhbFngXNBXpLMYfbrjASlkdbTqyxj8uVn3K7P
         OdDdY30WrVHjwMQHNsozQjL1iKRa8cUSoHMX34bU7OM9I/geZu4Nmc7LZwNk8L1IsODF
         OOM/TuY46uSVB/OnJ0CYtsh6Q6u071Sxd3l/KNx+mPzGzm+XfWB6AF5G+ZggNmRmB7Rr
         fx1xUjheIXBhoQ0HV4NzfVATqGsYymp0SAx5SYVNd8G78QG+p9tVifu3uOF+fFW32U2L
         jNQCZDyS6uD7NnEKSpVEMvD4oqr8TiWIdEi2we4Dv8PoCKKQaOuAmfIWku3bXzKTze87
         fQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh6POY2FNP4jh5YtyTMSCoZcmnYYSdwFAsj9LbV44ewJoUk1NQsR4ZCBAfMPfrSmXVSiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7avkPCjkG4tF4ifA6mB8X7CGbFaoE3jf7aZHTZTPurMOel0l
	wP955qItXD34HnD2+fRHA//FBQ2QmxAFXocLsXUgeY07tfOe+C+AkjD6L+tnkYw=
X-Gm-Gg: ASbGncsV1H03yD273ldKE34IIhPT9CalDW91cgKiSlMMsIZW3mOkPuuQODJhqgNoLBS
	ZbbHm6FJZlwpB55/CYmAO+NcbdHLrHyW74eA5e+XeRQ1WAlKKL4sq/atijmJ41nBqtzngqqv1RK
	6x/m4LglKbmoj83TiEy4EHX+0L/s7sR6S8DKChP36yotJ1tDkriDEs5xwiWKzas7bBfoOjxgb98
	NaaCZ+MupP9PVRZjwL1E+8vLV0ybOH9i7G1z0b7X8/bDJSVeblq5EZSEAeU+5w+R6bGUguC
X-Google-Smtp-Source: AGHT+IFsob0kLx0wGZL8egoOjIAsW9D2jwccSrPTQMz9F7TxBEjtWo1Hnt5ie8lWnR+ymimO40tQkw==
X-Received: by 2002:a17:903:2442:b0:215:ae61:27ca with SMTP id d9443c01a7336-21a8d6c9facmr26744885ad.26.1736390236979;
        Wed, 08 Jan 2025 18:37:16 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9176bed6sm1434365ad.12.2025.01.08.18.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:37:16 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 08 Jan 2025 18:36:31 -0800
Subject: [PATCH v6 16/16] perf tools: Remove dependency on libaudit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-perf_syscalltbl-v6-16-7543b5293098@rivosinc.com>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
In-Reply-To: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=19168; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=IIAUq83swkQS2L3CQ8q9+4EMHD3YoO1APmWKQvLl73Q=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3q9mf6Z/s+dgZ5O7781lSXnKqyYEufGfMDzkZ2h7ZygE
 yr5BSwdpSwMYhwMsmKKLDzXGphb7+iXHRUtmwAzh5UJZAgDF6cA3OQXDP+dZd1ZL7lwT/xiWrKC
 oX7yGnOvZa/tvKxM18hMP3PrhFkSwx/+bDbPX0+f7JlRMZFhknTn1lXzOi9L2LyMYJ3rq7V5dio
 LAA==
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
 tools/perf/Documentation/perf-check.txt        |  2 -
 tools/perf/Makefile.config                     | 31 +--------------
 tools/perf/Makefile.perf                       | 15 --------
 tools/perf/builtin-check.c                     |  2 -
 tools/perf/builtin-help.c                      |  2 -
 tools/perf/builtin-trace.c                     | 30 ---------------
 tools/perf/perf.c                              |  6 +--
 tools/perf/tests/make                          |  7 +---
 tools/perf/util/env.c                          |  6 +--
 tools/perf/util/generate-cmdlist.sh            |  4 +-
 tools/perf/util/syscalltbl.c                   | 52 --------------------------
 tools/perf/util/syscalltbl.h                   |  1 -
 15 files changed, 11 insertions(+), 164 deletions(-)

diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
index b2e254ec8ee846afe78eede74a825b51c6ab119b..6be38c1b9c5bb4be899fd261c6d2911abcf959dc 100644
--- a/Documentation/admin-guide/workload-tracing.rst
+++ b/Documentation/admin-guide/workload-tracing.rst
@@ -83,7 +83,7 @@ scripts/ver_linux is a good way to check if your system already has
 the necessary tools::
 
   sudo apt-get build-essentials flex bison yacc
-  sudo apt install libelf-dev systemtap-sdt-dev libaudit-dev libslang2-dev libperl-dev libdw-dev
+  sudo apt install libelf-dev systemtap-sdt-dev libslang2-dev libperl-dev libdw-dev
 
 cscope is a good tool to browse kernel sources. Let's install it now::
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 680f9b07150f906c0bae1ab990cc01bb0d6b0de6..cb1e3e2feedf39d7b95442bafc87d43dc84a740d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -13,7 +13,6 @@ FILES=                                          \
          test-gtk2.bin                          \
          test-gtk2-infobar.bin                  \
          test-hello.bin                         \
-         test-libaudit.bin                      \
          test-libbfd.bin                        \
          test-libbfd-buildid.bin		\
          test-disassembler-four-args.bin        \
@@ -232,9 +231,6 @@ $(OUTPUT)test-libunwind-debug-frame-arm.bin:
 $(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
 	$(BUILD) -lelf -llzma -lunwind-aarch64
 
-$(OUTPUT)test-libaudit.bin:
-	$(BUILD) -laudit
-
 $(OUTPUT)test-libslang.bin:
 	$(BUILD) -lslang
 
diff --git a/tools/build/feature/test-libaudit.c b/tools/build/feature/test-libaudit.c
deleted file mode 100644
index f5b0863fa1ec240795339428d8deed98a946d405..0000000000000000000000000000000000000000
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
index 31741499e7867c9b712227f31a2958fd641d474a..a764a46292206632c9bc890342ceadbf8889c4de 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -51,7 +51,6 @@ feature::
                 dwarf_getlocations      /  HAVE_LIBDW_SUPPORT
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
-                libaudit                /  HAVE_LIBAUDIT_SUPPORT
                 libbfd                  /  HAVE_LIBBFD_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
@@ -67,7 +66,6 @@ feature::
                 libunwind               /  HAVE_LIBUNWIND_SUPPORT
                 lzma                    /  HAVE_LZMA_SUPPORT
                 numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
-                syscall_table           /  HAVE_SYSCALL_TABLE_SUPPORT
                 zlib                    /  HAVE_ZLIB_SUPPORT
                 zstd                    /  HAVE_ZSTD_SUPPORT
 
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index feb61be7c4f93d7ebe0530839aebcd03ab8ec425..a148ca9efca912c588d470335a5a13afeb758206 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -28,20 +28,7 @@ include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,SRCARCH)
 
-ifneq ($(NO_SYSCALL_TABLE),1)
-  NO_SYSCALL_TABLE := 1
-
-  # architectures that use the generic syscall table scripts
-  ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
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
@@ -776,21 +763,7 @@ ifndef NO_LIBUNWIND
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
index 8081adf0e02354b9662a4e3c8493d6b1cec9fe25..a449d0015536442273a9268b37be34e4757f577a 100644
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
@@ -310,11 +304,7 @@ ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
 FEATURE_TESTS := all
 endif
 endif
-# architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc s390
-ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
-endif
 include Makefile.config
 endif
 
@@ -1102,11 +1092,6 @@ endif
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
index 2346536a5ee14f91ecd10bd130a64676e871e1b2..61a11a9b4e7594bfc019e9e496b6cc919d584300 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -31,7 +31,6 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
-	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
 	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
@@ -47,7 +46,6 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
 	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
 	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
-	FEATURE_STATUS("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
 	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
 	FEATURE_STATUS("zstd", HAVE_ZSTD_SUPPORT),
 
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 0854d3cd9f6a304cd9cb50ad430d5706d91df0e9..7be6fb6df595923c15ae51747d5bf17d867ae785 100644
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
index fc257d5e8144746ae5a0aa0538d531c8f86dec05..6f5ae3ac0638ba8c462050b1766770d8a4cd5e18 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2073,30 +2073,11 @@ static int trace__read_syscall_info(struct trace *trace, int id)
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
@@ -2447,18 +2428,7 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 
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
index a2987f2cfe1a3958f53239ed1a4eec3f87d7466a..f0617cc41f5fe638986e5d8316a6b3056c2c4bc5 100644
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
index a7fcbd589752a90459815bd21075528c6dfa4d94..0ee94caf9ec19820a94a87dd46a7ccf1cefb844a 100644
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
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
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
index 610c57da5b37ac1a42b81d80e33787b09c25fb28..cae4f6d63318f365609c9f6d2b5b9b15d13d234e 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -480,19 +480,19 @@ const char *perf_env__arch(struct perf_env *env)
 	return normalize_arch(arch_name);
 }
 
-#if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#if defined(HAVE_LIBTRACEEVENT)
 #include "trace/beauty/arch_errno_names.c"
 #endif
 
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
index 1b5140e5ce9975fac87b2674dc694f9d4e439a5f..6a73c903d69050df69267a8aeaeeac1ed170efe1 100755
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
index 210f61b0a7a264a427ebb602185d3a9da2f426f4..928aca4cd6e9f2f26c5c4fd825b4538c064a4cc3 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -10,20 +10,12 @@
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
@@ -131,47 +123,3 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
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
diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
index 2b53b7ed25a6affefd3d85012198eab2f2af550c..362411a6d849b1f67ec54b34345364c04ad90f89 100644
--- a/tools/perf/util/syscalltbl.h
+++ b/tools/perf/util/syscalltbl.h
@@ -3,7 +3,6 @@
 #define __PERF_SYSCALLTBL_H
 
 struct syscalltbl {
-	int audit_machine;
 	struct {
 		int max_id;
 		int nr_entries;

-- 
2.34.1


