Return-Path: <bpf+bounces-32145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4B4907F77
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 01:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003F11F2105C
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36615253B;
	Thu, 13 Jun 2024 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fy9vvJJT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F2157E82
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321517; cv=none; b=YdEp2xK/5dGxzlqMk0ydd1X01bcXdJKevd8JIDXSz6rAhxUVLaIc6PILQpfRSSMf2EI7Ga6+HYSDv0F8eN5iSiQgPXpbtyQGJ1nBePd3dyWlwxRqil/ZK5+EzW3RD5QMejRj8+9OuRyPvbrB+ExypegQcnv0Gkq6ditTlDFHT40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321517; c=relaxed/simple;
	bh=urUO8Y3haQE+twhbUO02QJd7mDwhqYqqM+ick7Y5494=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uDPt9JZhGm0Zc4CCMimzvRb/tje3iVmTxXT572hAbhI4m4LQnvoZ82oAxKbDlfam4xZVTwm67Fgt3Is7M3kE4ty3h2/VHotSqMQ8ESe2xx1vNCPjVWXMJ4G9C6tPBCs+Vzn6agdrJd3Qvats4HBERzw2lq5OGJ18qFYkJvM1w9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fy9vvJJT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-630faac5e45so23717187b3.1
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321513; x=1718926313; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQjzrI9iAP+k1+LxMonKMA5zJbCh+x/ZjioYLNLQ4RU=;
        b=Fy9vvJJTdXw83SudEEsMEMz9P6UiP5Rtatn+Cq1KtJe+osaiBnCA4JksMTgY5uq/c8
         hEZVojVFNk7RsbGYbV4sb0zd7wuq+fFfr7lYOsN7ISWlU8kZRlNvdttc/2oHXDMKBmyx
         3nJyvjasjN89/Uac2K40t89dPN/MqG8PruBqawf1g8rCd4ObJOCiVG9Pjsv3Pz51/ix3
         0q9NwK/aTP3CX5eZqv8yTrAc62WGoMe3z8ylLL1/EK1jOd+OQBJfL+WzM5c0raxuw2Lm
         yCiKEAcNbYWiA4Lwx/ObhroFa2JjdCZR7qGpSEXiagCIQpy6SrswTtLwKueuMmcQFoa3
         W9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321513; x=1718926313;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQjzrI9iAP+k1+LxMonKMA5zJbCh+x/ZjioYLNLQ4RU=;
        b=JEFiG7uAYQbARfFeA9UYAoV/Nj735ZRVYaky3K7vycW1x3JbOF/9Eaex4OZaK0ck6a
         OPdWrGWDLkyyLu4d6hvzYNFUhoD54VKmT++2oGuKk3fNOCTIGL8/4kxi9h382CGWuPiP
         WV4wH/Gs0nYoGqn/PseTwdrAAnKTYv+kFuRqNy9CfFq7OEhaPQRL1B4ql5iZkyutL+hg
         51Ols7c7u5kM2cNHKKzB7XEY2znETcLnWzq6+V9L7dDCwFSCJePe7NgL0nP2lV6F5oq7
         XlnFmwXoZ823K66SvSgNjPa0FK3Qrkd4KygR0NMx4J7HoGrz5ImR5ien3PREfiWg6tKz
         cpWg==
X-Forwarded-Encrypted: i=1; AJvYcCUhzu/9sX3Y1i5jZ3F1e6Xggfy4LfYL75zauFGMF2EJ8eHxcg8ieXm8Teds2RwpNJAO1QCs1FPhcY7zP2tWrYD57eDG
X-Gm-Message-State: AOJu0YzZObekyR/gCHMjnFtulvMNihUNAd3/1Rx6vzJeQiz0el3o3QfD
	gCPf3IegGp22AjosOFCnWQFJc8f5BcVOrtr+erXQGsOT9fcEyLVn9S7o6pogpEDMvrlBTAvyD4n
	yqZPZwg==
X-Google-Smtp-Source: AGHT+IGznBlcOmvOfpA6EXVwqlnlxaxbXzthPZ1s2mObVJOdSCDpnUMUOvljQx0WhUMOq6cg4qYbQsbcWejs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:690c:6111:b0:62c:fa1a:21e7 with SMTP
 id 00721157ae682-63223f29c67mr2362377b3.6.1718321513360; Thu, 13 Jun 2024
 16:31:53 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:31:20 -0700
In-Reply-To: <20240613233122.3564730-1-irogers@google.com>
Message-Id: <20240613233122.3564730-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v3 6/8] perf util: Make util its own library
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make the util directory into its own library. This is done to avoid
compiling code twice, once for the perf tool and once for the perf
python module. For convenience:
  arch/common.c
  scripts/perl/Perf-Trace-Util/Context.c
  scripts/python/Perf-Trace-Util/Context.c
are made part of this library.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Build                              |   5 +-
 tools/perf/Makefile.perf                      |  12 +-
 tools/perf/arch/Build                         |   4 +-
 tools/perf/arch/arm/Build                     |   2 +-
 tools/perf/arch/arm/util/Build                |  10 +-
 tools/perf/arch/arm64/Build                   |   2 +-
 tools/perf/arch/arm64/util/Build              |  20 +-
 tools/perf/arch/csky/Build                    |   2 +-
 tools/perf/arch/csky/util/Build               |   6 +-
 tools/perf/arch/loongarch/Build               |   2 +-
 tools/perf/arch/loongarch/util/Build          |   8 +-
 tools/perf/arch/mips/Build                    |   2 +-
 tools/perf/arch/mips/util/Build               |   6 +-
 tools/perf/arch/powerpc/Build                 |   2 +-
 tools/perf/arch/powerpc/util/Build            |  24 +-
 tools/perf/arch/riscv/Build                   |   2 +-
 tools/perf/arch/riscv/util/Build              |   8 +-
 tools/perf/arch/s390/Build                    |   2 +-
 tools/perf/arch/s390/util/Build               |  16 +-
 tools/perf/arch/sh/Build                      |   2 +-
 tools/perf/arch/sh/util/Build                 |   2 +-
 tools/perf/arch/sparc/Build                   |   2 +-
 tools/perf/arch/sparc/util/Build              |   2 +-
 tools/perf/arch/x86/Build                     |   2 +-
 tools/perf/arch/x86/util/Build                |  42 +-
 tools/perf/arch/xtensa/Build                  |   2 +-
 tools/perf/scripts/Build                      |   4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
 .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
 tools/perf/util/Build                         | 394 +++++++++---------
 tools/perf/util/arm-spe-decoder/Build         |   2 +-
 tools/perf/util/cs-etm-decoder/Build          |   2 +-
 tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
 tools/perf/util/intel-pt-decoder/Build        |   2 +-
 tools/perf/util/perf-regs-arch/Build          |  18 +-
 tools/perf/util/scripting-engines/Build       |   4 +-
 36 files changed, 316 insertions(+), 305 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 2787f5630ff7..1d4957957d75 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -53,11 +53,12 @@ CFLAGS_builtin-trace.o	   += -DSTRACE_GROUPS_DIR="BUILD_STR($(STRACE_GROUPS_DIR_
 CFLAGS_builtin-report.o	   += -DTIPDIR="BUILD_STR($(tipdir_SQ))"
 CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
 
-perf-y += util/
+perf-util-y += util/
+perf-util-y += arch/
 perf-y += arch/
 perf-test-y += arch/
 perf-ui-y += ui/
-perf-y += scripts/
+perf-util-y += scripts/
 
 gtk-y += ui/gtk/
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 4a3c000b9845..ff03f0431013 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -434,6 +434,9 @@ LIBPERF_TEST := $(OUTPUT)libperf-test.a
 LIBPERF_UI_IN := $(OUTPUT)perf-ui-in.o
 LIBPERF_UI := $(OUTPUT)libperf-ui.a
 
+LIBPERF_UTIL_IN := $(OUTPUT)perf-util-in.o
+LIBPERF_UTIL := $(OUTPUT)libperf-util.a
+
 LIBPMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
 LIBPMU_EVENTS := $(OUTPUT)libpmu-events.a
 
@@ -441,7 +444,8 @@ PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifdef LIBBPF_STATIC
   PERFLIBS += $(LIBBPF)
 endif
-PERFLIBS += $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPMU_EVENTS)
+PERFLIBS += $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPERF_UTIL)
+PERFLIBS += $(LIBPMU_EVENTS)
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -761,6 +765,12 @@ $(LIBPERF_UI_IN): FORCE prepare
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
+$(LIBPERF_UTIL_IN): FORCE prepare
+	$(Q)$(MAKE) $(build)=perf-util
+
+$(LIBPERF_UTIL): $(LIBPERF_UTIL_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
+
 $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
 		$(PERF_IN) $(LIBS) -o $@
diff --git a/tools/perf/arch/Build b/tools/perf/arch/Build
index 6dd68c17924c..f0d96a13445c 100644
--- a/tools/perf/arch/Build
+++ b/tools/perf/arch/Build
@@ -1,3 +1,3 @@
-perf-y += common.o
-perf-y += $(SRCARCH)/
+perf-util-y += common.o
 perf-test-y += $(SRCARCH)/
+perf-util-y += $(SRCARCH)/
diff --git a/tools/perf/arch/arm/Build b/tools/perf/arch/arm/Build
index 6b4fdec52122..317425aa3712 100644
--- a/tools/perf/arch/arm/Build
+++ b/tools/perf/arch/arm/Build
@@ -1,2 +1,2 @@
-perf-y += util/
+perf-util-y += util/
 perf-test-$(CONFIG_DWARF_UNWIND) += tests/
diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index 37fc63708966..e6dd7cd79ebd 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -1,8 +1,8 @@
-perf-y += perf_regs.o
+perf-util-y += perf_regs.o
 
-perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
 
-perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
-perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
+perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-perf-$(CONFIG_AUXTRACE) += pmu.o auxtrace.o cs-etm.o
+perf-util-$(CONFIG_AUXTRACE) += pmu.o auxtrace.o cs-etm.o
diff --git a/tools/perf/arch/arm64/Build b/tools/perf/arch/arm64/Build
index 58b2d965ed86..12ebc65ea7a3 100644
--- a/tools/perf/arch/arm64/Build
+++ b/tools/perf/arch/arm64/Build
@@ -1,2 +1,2 @@
-perf-y += util/
+perf-util-y += util/
 perf-test-y += tests/
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 78ef7115be3d..343ef7589a77 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,14 +1,14 @@
-perf-y += header.o
-perf-y += machine.o
-perf-y += perf_regs.o
-perf-y += tsc.o
-perf-y += pmu.o
-perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-$(CONFIG_DWARF)     += dwarf-regs.o
-perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
-perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-y += header.o
+perf-util-y += machine.o
+perf-util-y += perf_regs.o
+perf-util-y += tsc.o
+perf-util-y += pmu.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
+perf-util-$(CONFIG_DWARF)     += dwarf-regs.o
+perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
+perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-perf-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
+perf-util-$(CONFIG_AUXTRACE) += ../../arm/util/pmu.o \
 			      ../../arm/util/auxtrace.o \
 			      ../../arm/util/cs-etm.o \
 			      arm-spe.o mem-events.o hisi-ptt.o
diff --git a/tools/perf/arch/csky/Build b/tools/perf/arch/csky/Build
index e4e5f33c84d8..e63eabc2c8f4 100644
--- a/tools/perf/arch/csky/Build
+++ b/tools/perf/arch/csky/Build
@@ -1 +1 @@
-perf-y += util/
+perf-util-y += util/
diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
index 7d3050134ae0..99d83f41bf43 100644
--- a/tools/perf/arch/csky/util/Build
+++ b/tools/perf/arch/csky/util/Build
@@ -1,4 +1,4 @@
-perf-y += perf_regs.o
+perf-util-y += perf_regs.o
 
-perf-$(CONFIG_DWARF) += dwarf-regs.o
-perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/loongarch/Build b/tools/perf/arch/loongarch/Build
index e4e5f33c84d8..e63eabc2c8f4 100644
--- a/tools/perf/arch/loongarch/Build
+++ b/tools/perf/arch/loongarch/Build
@@ -1 +1 @@
-perf-y += util/
+perf-util-y += util/
diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index d776125a2d06..2386ebbf6dd4 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,5 +1,5 @@
-perf-y += perf_regs.o
+perf-util-y += perf_regs.o
 
-perf-$(CONFIG_DWARF)     += dwarf-regs.o
-perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
-perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-$(CONFIG_DWARF)     += dwarf-regs.o
+perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
+perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/mips/Build b/tools/perf/arch/mips/Build
index e4e5f33c84d8..e63eabc2c8f4 100644
--- a/tools/perf/arch/mips/Build
+++ b/tools/perf/arch/mips/Build
@@ -1 +1 @@
-perf-y += util/
+perf-util-y += util/
diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
index 51c8900a9a10..e4644f1e68a0 100644
--- a/tools/perf/arch/mips/util/Build
+++ b/tools/perf/arch/mips/util/Build
@@ -1,3 +1,3 @@
-perf-y += perf_regs.o
-perf-$(CONFIG_DWARF) += dwarf-regs.o
-perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
+perf-util-y += perf_regs.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/powerpc/Build b/tools/perf/arch/powerpc/Build
index 58b2d965ed86..12ebc65ea7a3 100644
--- a/tools/perf/arch/powerpc/Build
+++ b/tools/perf/arch/powerpc/Build
@@ -1,2 +1,2 @@
-perf-y += util/
+perf-util-y += util/
 perf-test-y += tests/
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 1d323f3a3322..6c588ecdf3bd 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,14 +1,14 @@
-perf-y += header.o
-perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-y += perf_regs.o
-perf-y += mem-events.o
-perf-y += pmu.o
-perf-y += sym-handling.o
-perf-y += evsel.o
-perf-y += event.o
+perf-util-y += header.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
+perf-util-y += perf_regs.o
+perf-util-y += mem-events.o
+perf-util-y += pmu.o
+perf-util-y += sym-handling.o
+perf-util-y += evsel.o
+perf-util-y += event.o
 
-perf-$(CONFIG_DWARF) += dwarf-regs.o
-perf-$(CONFIG_DWARF) += skip-callchain-idx.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_DWARF) += skip-callchain-idx.o
 
-perf-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
-perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
+perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/riscv/Build b/tools/perf/arch/riscv/Build
index e4e5f33c84d8..e63eabc2c8f4 100644
--- a/tools/perf/arch/riscv/Build
+++ b/tools/perf/arch/riscv/Build
@@ -1 +1 @@
-perf-y += util/
+perf-util-y += util/
diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 603dbb5ae4dc..65ec3c66a375 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -1,5 +1,5 @@
-perf-y += perf_regs.o
-perf-y += header.o
+perf-util-y += perf_regs.o
+perf-util-y += header.o
 
-perf-$(CONFIG_DWARF) += dwarf-regs.o
-perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/s390/Build b/tools/perf/arch/s390/Build
index e4e5f33c84d8..e63eabc2c8f4 100644
--- a/tools/perf/arch/s390/Build
+++ b/tools/perf/arch/s390/Build
@@ -1 +1 @@
-perf-y += util/
+perf-util-y += util/
diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index fa66f15a14ec..1ac830030ff3 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -1,11 +1,11 @@
-perf-y += header.o
-perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-y += perf_regs.o
+perf-util-y += header.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
+perf-util-y += perf_regs.o
 
-perf-$(CONFIG_DWARF) += dwarf-regs.o
-perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-perf-y += machine.o
-perf-y += pmu.o
+perf-util-y += machine.o
+perf-util-y += pmu.o
 
-perf-$(CONFIG_AUXTRACE) += auxtrace.o
+perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
diff --git a/tools/perf/arch/sh/Build b/tools/perf/arch/sh/Build
index e4e5f33c84d8..e63eabc2c8f4 100644
--- a/tools/perf/arch/sh/Build
+++ b/tools/perf/arch/sh/Build
@@ -1 +1 @@
-perf-y += util/
+perf-util-y += util/
diff --git a/tools/perf/arch/sh/util/Build b/tools/perf/arch/sh/util/Build
index e813e618954b..32f44fc4ab98 100644
--- a/tools/perf/arch/sh/util/Build
+++ b/tools/perf/arch/sh/util/Build
@@ -1 +1 @@
-perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
diff --git a/tools/perf/arch/sparc/Build b/tools/perf/arch/sparc/Build
index e4e5f33c84d8..e63eabc2c8f4 100644
--- a/tools/perf/arch/sparc/Build
+++ b/tools/perf/arch/sparc/Build
@@ -1 +1 @@
-perf-y += util/
+perf-util-y += util/
diff --git a/tools/perf/arch/sparc/util/Build b/tools/perf/arch/sparc/util/Build
index e813e618954b..32f44fc4ab98 100644
--- a/tools/perf/arch/sparc/util/Build
+++ b/tools/perf/arch/sparc/util/Build
@@ -1 +1 @@
-perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index 132cf8beaca2..87d057491343 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -1,4 +1,4 @@
-perf-y += util/
+perf-util-y += util/
 perf-test-y += tests/
 
 ifdef SHELLCHECK
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 005907cb97d8..2607ed5c4296 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -1,24 +1,24 @@
-perf-y += header.o
-perf-y += tsc.o
-perf-y += pmu.o
-perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-y += perf_regs.o
-perf-y += topdown.o
-perf-y += machine.o
-perf-y += event.o
-perf-y += evlist.o
-perf-y += mem-events.o
-perf-y += evsel.o
-perf-y += iostat.o
-perf-y += env.o
+perf-util-y += header.o
+perf-util-y += tsc.o
+perf-util-y += pmu.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
+perf-util-y += perf_regs.o
+perf-util-y += topdown.o
+perf-util-y += machine.o
+perf-util-y += event.o
+perf-util-y += evlist.o
+perf-util-y += mem-events.o
+perf-util-y += evsel.o
+perf-util-y += iostat.o
+perf-util-y += env.o
 
-perf-$(CONFIG_DWARF) += dwarf-regs.o
-perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
 
-perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
-perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
+perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
-perf-$(CONFIG_AUXTRACE) += auxtrace.o
-perf-$(CONFIG_AUXTRACE) += archinsn.o
-perf-$(CONFIG_AUXTRACE) += intel-pt.o
-perf-$(CONFIG_AUXTRACE) += intel-bts.o
+perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
+perf-util-$(CONFIG_AUXTRACE) += archinsn.o
+perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
+perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
diff --git a/tools/perf/arch/xtensa/Build b/tools/perf/arch/xtensa/Build
index e4e5f33c84d8..e63eabc2c8f4 100644
--- a/tools/perf/arch/xtensa/Build
+++ b/tools/perf/arch/xtensa/Build
@@ -1 +1 @@
-perf-y += util/
+perf-util-y += util/
diff --git a/tools/perf/scripts/Build b/tools/perf/scripts/Build
index 7d8e2e57faac..46f0c6f76dbf 100644
--- a/tools/perf/scripts/Build
+++ b/tools/perf/scripts/Build
@@ -1,4 +1,4 @@
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
+  perf-util-$(CONFIG_LIBPERL)   += perl/Perf-Trace-Util/
 endif
-perf-$(CONFIG_LIBPYTHON) += python/Perf-Trace-Util/
+perf-util-$(CONFIG_LIBPYTHON) += python/Perf-Trace-Util/
diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Build b/tools/perf/scripts/perl/Perf-Trace-Util/Build
index cc76be005d5e..9b0e5a8b5070 100644
--- a/tools/perf/scripts/perl/Perf-Trace-Util/Build
+++ b/tools/perf/scripts/perl/Perf-Trace-Util/Build
@@ -1,4 +1,4 @@
-perf-y += Context.o
+perf-util-y += Context.o
 
 CFLAGS_Context.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum
 CFLAGS_Context.o += -Wno-unused-parameter -Wno-nested-externs -Wno-undef
diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Build b/tools/perf/scripts/python/Perf-Trace-Util/Build
index 5b0b5ff7e14a..be3710c61320 100644
--- a/tools/perf/scripts/python/Perf-Trace-Util/Build
+++ b/tools/perf/scripts/python/Perf-Trace-Util/Build
@@ -1,4 +1,4 @@
-perf-y += Context.o
+perf-util-y += Context.o
 
 # -Wno-declaration-after-statement: The python headers have mixed code with declarations (decls after asserts, for instance)
 CFLAGS_Context.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-nested-externs -Wno-declaration-after-statement
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index da64efd8718f..0f18fe81ef0b 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -1,181 +1,181 @@
 include $(srctree)/tools/scripts/Makefile.include
 include $(srctree)/tools/scripts/utilities.mak
 
-perf-y += arm64-frame-pointer-unwind-support.o
-perf-y += addr_location.o
-perf-y += annotate.o
-perf-y += block-info.o
-perf-y += block-range.o
-perf-y += build-id.o
-perf-y += cacheline.o
-perf-y += config.o
-perf-y += copyfile.o
-perf-y += ctype.o
-perf-y += db-export.o
-perf-y += disasm.o
-perf-y += env.o
-perf-y += event.o
-perf-y += evlist.o
-perf-y += sideband_evlist.o
-perf-y += evsel.o
-perf-y += evsel_fprintf.o
-perf-y += perf_event_attr_fprintf.o
-perf-y += evswitch.o
-perf-y += find_bit.o
-perf-y += get_current_dir_name.o
-perf-y += levenshtein.o
-perf-y += mmap.o
-perf-y += memswap.o
-perf-y += parse-events.o
-perf-y += print-events.o
-perf-y += tracepoint.o
-perf-y += perf_regs.o
-perf-y += perf-regs-arch/
-perf-y += path.o
-perf-y += print_binary.o
-perf-y += print_insn.o
-perf-y += rlimit.o
-perf-y += argv_split.o
-perf-y += rbtree.o
-perf-y += libstring.o
-perf-y += bitmap.o
-perf-y += hweight.o
-perf-y += smt.o
-perf-y += strbuf.o
-perf-y += string.o
-perf-y += strlist.o
-perf-y += strfilter.o
-perf-y += top.o
-perf-y += usage.o
-perf-y += dso.o
-perf-y += dsos.o
-perf-y += symbol.o
-perf-y += symbol_fprintf.o
-perf-y += map_symbol.o
-perf-y += color.o
-perf-y += color_config.o
-perf-y += metricgroup.o
-perf-y += header.o
-perf-y += callchain.o
-perf-y += values.o
-perf-y += debug.o
-perf-y += fncache.o
-perf-y += machine.o
-perf-y += map.o
-perf-y += maps.o
-perf-y += pstack.o
-perf-y += session.o
-perf-y += sample-raw.o
-perf-y += s390-sample-raw.o
-perf-y += amd-sample-raw.o
-perf-$(CONFIG_TRACE) += syscalltbl.o
-perf-y += ordered-events.o
-perf-y += namespaces.o
-perf-y += comm.o
-perf-y += thread.o
-perf-y += threads.o
-perf-y += thread_map.o
-perf-y += parse-events-flex.o
-perf-y += parse-events-bison.o
-perf-y += pmu.o
-perf-y += pmus.o
-perf-y += pmu-flex.o
-perf-y += pmu-bison.o
-perf-y += svghelper.o
-perf-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
-perf-y += trace-event-scripting.o
-perf-$(CONFIG_LIBTRACEEVENT) += trace-event.o
-perf-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
-perf-$(CONFIG_LIBTRACEEVENT) += trace-event-read.o
-perf-y += sort.o
-perf-y += hist.o
-perf-y += util.o
-perf-y += cpumap.o
-perf-y += affinity.o
-perf-y += cputopo.o
-perf-y += cgroup.o
-perf-y += target.o
-perf-y += rblist.o
-perf-y += intlist.o
-perf-y += vdso.o
-perf-y += counts.o
-perf-y += stat.o
-perf-y += stat-shadow.o
-perf-y += stat-display.o
-perf-y += perf_api_probe.o
-perf-y += record.o
-perf-y += srcline.o
-perf-y += srccode.o
-perf-y += synthetic-events.o
-perf-y += data.o
-perf-y += tsc.o
-perf-y += cloexec.o
-perf-y += call-path.o
-perf-y += rwsem.o
-perf-y += thread-stack.o
-perf-y += spark.o
-perf-y += topdown.o
-perf-y += iostat.o
-perf-y += stream.o
-perf-$(CONFIG_AUXTRACE) += auxtrace.o
-perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
-perf-$(CONFIG_AUXTRACE) += intel-pt.o
-perf-$(CONFIG_AUXTRACE) += intel-bts.o
-perf-$(CONFIG_AUXTRACE) += arm-spe.o
-perf-$(CONFIG_AUXTRACE) += arm-spe-decoder/
-perf-$(CONFIG_AUXTRACE) += hisi-ptt.o
-perf-$(CONFIG_AUXTRACE) += hisi-ptt-decoder/
-perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
+perf-util-y += arm64-frame-pointer-unwind-support.o
+perf-util-y += addr_location.o
+perf-util-y += annotate.o
+perf-util-y += block-info.o
+perf-util-y += block-range.o
+perf-util-y += build-id.o
+perf-util-y += cacheline.o
+perf-util-y += config.o
+perf-util-y += copyfile.o
+perf-util-y += ctype.o
+perf-util-y += db-export.o
+perf-util-y += disasm.o
+perf-util-y += env.o
+perf-util-y += event.o
+perf-util-y += evlist.o
+perf-util-y += sideband_evlist.o
+perf-util-y += evsel.o
+perf-util-y += evsel_fprintf.o
+perf-util-y += perf_event_attr_fprintf.o
+perf-util-y += evswitch.o
+perf-util-y += find_bit.o
+perf-util-y += get_current_dir_name.o
+perf-util-y += levenshtein.o
+perf-util-y += mmap.o
+perf-util-y += memswap.o
+perf-util-y += parse-events.o
+perf-util-y += print-events.o
+perf-util-y += tracepoint.o
+perf-util-y += perf_regs.o
+perf-util-y += perf-regs-arch/
+perf-util-y += path.o
+perf-util-y += print_binary.o
+perf-util-y += print_insn.o
+perf-util-y += rlimit.o
+perf-util-y += argv_split.o
+perf-util-y += rbtree.o
+perf-util-y += libstring.o
+perf-util-y += bitmap.o
+perf-util-y += hweight.o
+perf-util-y += smt.o
+perf-util-y += strbuf.o
+perf-util-y += string.o
+perf-util-y += strlist.o
+perf-util-y += strfilter.o
+perf-util-y += top.o
+perf-util-y += usage.o
+perf-util-y += dso.o
+perf-util-y += dsos.o
+perf-util-y += symbol.o
+perf-util-y += symbol_fprintf.o
+perf-util-y += map_symbol.o
+perf-util-y += color.o
+perf-util-y += color_config.o
+perf-util-y += metricgroup.o
+perf-util-y += header.o
+perf-util-y += callchain.o
+perf-util-y += values.o
+perf-util-y += debug.o
+perf-util-y += fncache.o
+perf-util-y += machine.o
+perf-util-y += map.o
+perf-util-y += maps.o
+perf-util-y += pstack.o
+perf-util-y += session.o
+perf-util-y += sample-raw.o
+perf-util-y += s390-sample-raw.o
+perf-util-y += amd-sample-raw.o
+perf-util-$(CONFIG_TRACE) += syscalltbl.o
+perf-util-y += ordered-events.o
+perf-util-y += namespaces.o
+perf-util-y += comm.o
+perf-util-y += thread.o
+perf-util-y += threads.o
+perf-util-y += thread_map.o
+perf-util-y += parse-events-flex.o
+perf-util-y += parse-events-bison.o
+perf-util-y += pmu.o
+perf-util-y += pmus.o
+perf-util-y += pmu-flex.o
+perf-util-y += pmu-bison.o
+perf-util-y += svghelper.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
+perf-util-y += trace-event-scripting.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
+perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-read.o
+perf-util-y += sort.o
+perf-util-y += hist.o
+perf-util-y += util.o
+perf-util-y += cpumap.o
+perf-util-y += affinity.o
+perf-util-y += cputopo.o
+perf-util-y += cgroup.o
+perf-util-y += target.o
+perf-util-y += rblist.o
+perf-util-y += intlist.o
+perf-util-y += vdso.o
+perf-util-y += counts.o
+perf-util-y += stat.o
+perf-util-y += stat-shadow.o
+perf-util-y += stat-display.o
+perf-util-y += perf_api_probe.o
+perf-util-y += record.o
+perf-util-y += srcline.o
+perf-util-y += srccode.o
+perf-util-y += synthetic-events.o
+perf-util-y += data.o
+perf-util-y += tsc.o
+perf-util-y += cloexec.o
+perf-util-y += call-path.o
+perf-util-y += rwsem.o
+perf-util-y += thread-stack.o
+perf-util-y += spark.o
+perf-util-y += topdown.o
+perf-util-y += iostat.o
+perf-util-y += stream.o
+perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
+perf-util-$(CONFIG_AUXTRACE) += intel-pt-decoder/
+perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
+perf-util-$(CONFIG_AUXTRACE) += intel-bts.o
+perf-util-$(CONFIG_AUXTRACE) += arm-spe.o
+perf-util-$(CONFIG_AUXTRACE) += arm-spe-decoder/
+perf-util-$(CONFIG_AUXTRACE) += hisi-ptt.o
+perf-util-$(CONFIG_AUXTRACE) += hisi-ptt-decoder/
+perf-util-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
-perf-$(CONFIG_AUXTRACE) += cs-etm.o
-perf-$(CONFIG_AUXTRACE) += cs-etm-decoder/
+perf-util-$(CONFIG_AUXTRACE) += cs-etm.o
+perf-util-$(CONFIG_AUXTRACE) += cs-etm-decoder/
 endif
-perf-$(CONFIG_AUXTRACE) += cs-etm-base.o
-
-perf-y += parse-branch-options.o
-perf-y += dump-insn.o
-perf-y += parse-regs-options.o
-perf-y += parse-sublevel-options.o
-perf-y += term.o
-perf-y += help-unknown-cmd.o
-perf-y += dlfilter.o
-perf-y += mem-events.o
-perf-y += mem-info.o
-perf-y += vsprintf.o
-perf-y += units.o
-perf-y += time-utils.o
-perf-y += expr-flex.o
-perf-y += expr-bison.o
-perf-y += expr.o
-perf-y += branch.o
-perf-y += mem2node.o
-perf-y += clockid.o
-perf-y += list_sort.o
-perf-y += mutex.o
-perf-y += sharded_mutex.o
-
-perf-$(CONFIG_LIBBPF) += bpf_map.o
-perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
-perf-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
-perf-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
-perf-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
-perf-$(CONFIG_PERF_BPF_SKEL) += bpf-filter.o
-perf-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-flex.o
-perf-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-bison.o
+perf-util-$(CONFIG_AUXTRACE) += cs-etm-base.o
+
+perf-util-y += parse-branch-options.o
+perf-util-y += dump-insn.o
+perf-util-y += parse-regs-options.o
+perf-util-y += parse-sublevel-options.o
+perf-util-y += term.o
+perf-util-y += help-unknown-cmd.o
+perf-util-y += dlfilter.o
+perf-util-y += mem-events.o
+perf-util-y += mem-info.o
+perf-util-y += vsprintf.o
+perf-util-y += units.o
+perf-util-y += time-utils.o
+perf-util-y += expr-flex.o
+perf-util-y += expr-bison.o
+perf-util-y += expr.o
+perf-util-y += branch.o
+perf-util-y += mem2node.o
+perf-util-y += clockid.o
+perf-util-y += list_sort.o
+perf-util-y += mutex.o
+perf-util-y += sharded_mutex.o
+
+perf-util-$(CONFIG_LIBBPF) += bpf_map.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_ftrace.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_off_cpu.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-flex.o
+perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf-filter-bison.o
 
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o
+  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_lock_contention.o
 endif
 
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork.o
-  perf-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork_top.o
+  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork.o
+  perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_kwork_top.o
 endif
 
-perf-$(CONFIG_LIBELF) += symbol-elf.o
-perf-$(CONFIG_LIBELF) += probe-file.o
-perf-$(CONFIG_LIBELF) += probe-event.o
+perf-util-$(CONFIG_LIBELF) += symbol-elf.o
+perf-util-$(CONFIG_LIBELF) += probe-file.o
+perf-util-$(CONFIG_LIBELF) += probe-event.o
 
 ifdef CONFIG_LIBBPF_DYNAMIC
   hashmap := 1
@@ -185,60 +185,60 @@ ifndef CONFIG_LIBBPF
 endif
 
 ifdef hashmap
-perf-y += hashmap.o
+perf-util-y += hashmap.o
 endif
 
 ifndef CONFIG_LIBELF
-perf-y += symbol-minimal.o
+perf-util-y += symbol-minimal.o
 endif
 
 ifndef CONFIG_SETNS
-perf-y += setns.o
+perf-util-y += setns.o
 endif
 
-perf-$(CONFIG_DWARF) += probe-finder.o
-perf-$(CONFIG_DWARF) += dwarf-aux.o
-perf-$(CONFIG_DWARF) += dwarf-regs.o
-perf-$(CONFIG_DWARF) += debuginfo.o
-perf-$(CONFIG_DWARF) += annotate-data.o
+perf-util-$(CONFIG_DWARF) += probe-finder.o
+perf-util-$(CONFIG_DWARF) += dwarf-aux.o
+perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_DWARF) += debuginfo.o
+perf-util-$(CONFIG_DWARF) += annotate-data.o
 
-perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
-perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
-perf-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
-perf-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
-perf-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
+perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
+perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
+perf-util-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
+perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
+perf-util-$(CONFIG_LIBUNWIND_AARCH64)  += libunwind/arm64.o
 
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
+  perf-util-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
 endif
 
-perf-y += data-convert-json.o
+perf-util-y += data-convert-json.o
 
-perf-y += scripting-engines/
+perf-util-y += scripting-engines/
 
-perf-$(CONFIG_ZLIB) += zlib.o
-perf-$(CONFIG_LZMA) += lzma.o
-perf-$(CONFIG_ZSTD) += zstd.o
+perf-util-$(CONFIG_ZLIB) += zlib.o
+perf-util-$(CONFIG_LZMA) += lzma.o
+perf-util-$(CONFIG_ZSTD) += zstd.o
 
-perf-$(CONFIG_LIBCAP) += cap.o
+perf-util-$(CONFIG_LIBCAP) += cap.o
 
-perf-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
-perf-y += demangle-ocaml.o
-perf-y += demangle-java.o
-perf-y += demangle-rust.o
+perf-util-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
+perf-util-y += demangle-ocaml.o
+perf-util-y += demangle-java.o
+perf-util-y += demangle-rust.o
 
 ifdef CONFIG_JITDUMP
-perf-$(CONFIG_LIBELF) += jitdump.o
-perf-$(CONFIG_LIBELF) += genelf.o
-perf-$(CONFIG_DWARF) += genelf_debug.o
+perf-util-$(CONFIG_LIBELF) += jitdump.o
+perf-util-$(CONFIG_LIBELF) += genelf.o
+perf-util-$(CONFIG_DWARF) += genelf_debug.o
 endif
 
-perf-y += perf-hooks.o
+perf-util-y += perf-hooks.o
 
-perf-$(CONFIG_LIBBPF) += bpf-event.o
-perf-$(CONFIG_LIBBPF) += bpf-utils.o
+perf-util-$(CONFIG_LIBBPF) += bpf-event.o
+perf-util-$(CONFIG_LIBBPF) += bpf-utils.o
 
-perf-$(CONFIG_LIBPFM4) += pfm.o
+perf-util-$(CONFIG_LIBPFM4) += pfm.o
 
 CFLAGS_config.o   += -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
 
@@ -403,4 +403,4 @@ $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-y += $(TEST_LOGS)
+perf-util-y += $(TEST_LOGS)
diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
index f8dae13fc876..960062b3cb9e 100644
--- a/tools/perf/util/arm-spe-decoder/Build
+++ b/tools/perf/util/arm-spe-decoder/Build
@@ -1 +1 @@
-perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o arm-spe-decoder.o
+perf-util-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o arm-spe-decoder.o
diff --git a/tools/perf/util/cs-etm-decoder/Build b/tools/perf/util/cs-etm-decoder/Build
index 216cb17a3322..056d665f7f88 100644
--- a/tools/perf/util/cs-etm-decoder/Build
+++ b/tools/perf/util/cs-etm-decoder/Build
@@ -1 +1 @@
-perf-$(CONFIG_AUXTRACE) += cs-etm-decoder.o
+perf-util-$(CONFIG_AUXTRACE) += cs-etm-decoder.o
diff --git a/tools/perf/util/hisi-ptt-decoder/Build b/tools/perf/util/hisi-ptt-decoder/Build
index db3db8b75033..3298f7b7e308 100644
--- a/tools/perf/util/hisi-ptt-decoder/Build
+++ b/tools/perf/util/hisi-ptt-decoder/Build
@@ -1 +1 @@
-perf-$(CONFIG_AUXTRACE) += hisi-ptt-pkt-decoder.o
+perf-util-$(CONFIG_AUXTRACE) += hisi-ptt-pkt-decoder.o
diff --git a/tools/perf/util/intel-pt-decoder/Build b/tools/perf/util/intel-pt-decoder/Build
index b41c2e9c6f88..30793d08c6d4 100644
--- a/tools/perf/util/intel-pt-decoder/Build
+++ b/tools/perf/util/intel-pt-decoder/Build
@@ -1,4 +1,4 @@
-perf-$(CONFIG_AUXTRACE) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
+perf-util-$(CONFIG_AUXTRACE) += intel-pt-pkt-decoder.o intel-pt-insn-decoder.o intel-pt-log.o intel-pt-decoder.o
 
 inat_tables_script = $(srctree)/tools/arch/x86/tools/gen-insn-attr-x86.awk
 inat_tables_maps = $(srctree)/tools/arch/x86/lib/x86-opcode-map.txt
diff --git a/tools/perf/util/perf-regs-arch/Build b/tools/perf/util/perf-regs-arch/Build
index d9d596d330a7..be95402aa540 100644
--- a/tools/perf/util/perf-regs-arch/Build
+++ b/tools/perf/util/perf-regs-arch/Build
@@ -1,9 +1,9 @@
-perf-y += perf_regs_aarch64.o
-perf-y += perf_regs_arm.o
-perf-y += perf_regs_csky.o
-perf-y += perf_regs_loongarch.o
-perf-y += perf_regs_mips.o
-perf-y += perf_regs_powerpc.o
-perf-y += perf_regs_riscv.o
-perf-y += perf_regs_s390.o
-perf-y += perf_regs_x86.o
+perf-util-y += perf_regs_aarch64.o
+perf-util-y += perf_regs_arm.o
+perf-util-y += perf_regs_csky.o
+perf-util-y += perf_regs_loongarch.o
+perf-util-y += perf_regs_mips.o
+perf-util-y += perf_regs_powerpc.o
+perf-util-y += perf_regs_riscv.o
+perf-util-y += perf_regs_s390.o
+perf-util-y += perf_regs_x86.o
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scripting-engines/Build
index 586b94e90f4e..2282fe3772f3 100644
--- a/tools/perf/util/scripting-engines/Build
+++ b/tools/perf/util/scripting-engines/Build
@@ -1,7 +1,7 @@
 ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  perf-$(CONFIG_LIBPERL)   += trace-event-perl.o
+  perf-util-$(CONFIG_LIBPERL)   += trace-event-perl.o
 endif
-perf-$(CONFIG_LIBPYTHON) += trace-event-python.o
+perf-util-$(CONFIG_LIBPYTHON) += trace-event-python.o
 
 CFLAGS_trace-event-perl.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum
 
-- 
2.45.2.627.g7a2c4fd464-goog


