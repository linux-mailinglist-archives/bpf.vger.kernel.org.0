Return-Path: <bpf+bounces-59957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8EAAD09BB
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E9C3B30FC
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BEA238C0F;
	Fri,  6 Jun 2025 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uK/aKTd/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE59623C516
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246775; cv=none; b=GMxUOUT2X1k/0wA2jzgN4ntoZGqi+tG32HCH2bny1r/8pu1/wlrupce3JPS4t934peUOpLWEjMPnBQS1poCD5PyrwYQ2rFBPAzlAYO1HqDXDdDeSkxFU8PShdNxuGkHsMDogKbn4/xOHjBnCvTQUUfXbwlvqlXBzeHGeKe0AUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246775; c=relaxed/simple;
	bh=fdk50WYueaBLzSwBgidVg7pckEa/1AfhDiTbjBNVjvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QXVckRjwWkRQi+Wbwgxaq7BKDwpq30SGiN8IV2PoUbwHKbEMCk6cl2EVSHCn3JPlyeEIIXegje0qQD5dq/OeEyTLZP93W5Rg0GHpm40tl37eD+hAotm2aFipZ/nJDR64u/ZDzw7+0IVabccsW2bUES6rJu0bm+qeZ0GQ/dXu6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uK/aKTd/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so3212448a91.2
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749246773; x=1749851573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+kZBatEUrJrZZ6PE0Z1l/q9xeZJJ3Utgr+97hvf5fQ=;
        b=uK/aKTd/Adr+/dFRFxIfcWYYJ00FUhuc0ocrZJKSq5kXY/09xgScHNf4OK6ylS48hf
         ihlOqcmixyysf7LSwErV7gm/xMaMClXYpnhbnF6MGBL5GKYtSfzuWEG+l9TGICe/QGOz
         Z5TjyIYXzIMo+3GpAUz8ynJGjA/keqSMtYyMCj7Bp+zkgqrOP5xVeXGkBSgXhYtxRJpA
         OnSgbG2p76EIpJfog9lOqw4Z1OgdMAra9aSWJEbFOjKpPeCb4DCZNhfMz2c1tzfh5k5o
         7bN+E2LfUapjXbUPlwLTYNiyTu/8rfD8Ek7gLm0Bzkm2eIAS1eCi2ftqTLAruZY5bPzb
         As8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246773; x=1749851573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+kZBatEUrJrZZ6PE0Z1l/q9xeZJJ3Utgr+97hvf5fQ=;
        b=AwN1YKXGdLYTYNJIMqvo/r/Pq+UqYQAiUHbuTb53/lNHk3wSPcuQDunsTcVCgDS1RM
         U+KDxds6OiJEp5gGG7fSic4Yait14ufloq339KacBiGM9AcdSJ3usecuREETH0b2w0rS
         MNF/XogJncvmx/AoddO2iaCZzDjt+gegBEyarT6LQBJWmowpjXEcNOXLWPCMlNqVwcE8
         QwdbVyW4t5ej76F7lpsg7uLfRHjlKkdJc/pCPoQ6KqZkiqgiHIAx9xXWSgdn76W9gnFI
         /oKO3suXhENgcZiThnhWO8c2Kp+Lqw2cEP5bOl1nq3pj3oE5xSZj+glkuQ9/nIpYPaam
         MhXA==
X-Forwarded-Encrypted: i=1; AJvYcCVdqb/HaFWca8++27tnzzP+QUHR7hlnhtJzWm9FsWquHouRl+vohXQVev4mjkudjuw7ALw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIECUFl66m2AkpppnoNsSCHNM7f3rWKkO1hdmoHLWjh+sSkXre
	lIIi1xwqL2z8JRpMJpYMWMdIQZkdarezloIa/2KcF2ROU8+iQx4MQ8zXzUv3SZABzvt1i/3BX7P
	Fiq5eVQCBveUDqqDyP+M4ew==
X-Google-Smtp-Source: AGHT+IGUB45yrNx9LuqRMIDTKKRwgWQUuD4w9NE1Ld77LnJv215C9tYBR+DSbX0KgD3MHda8qh5AmDJxb4IqBytr
X-Received: from pjm5.prod.google.com ([2002:a17:90b:2fc5:b0:313:245:8921])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1dcb:b0:312:639:a064 with SMTP id 98e67ed59e1d1-3134768d9cbmr7402437a91.28.1749246773007;
 Fri, 06 Jun 2025 14:52:53 -0700 (PDT)
Date: Fri,  6 Jun 2025 14:52:42 -0700
In-Reply-To: <20250606215246.2419387-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250606215246.2419387-2-blakejones@google.com>
Subject: [PATCH v3 1/5] perf: detect support for libbpf's emit_strings option
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

This creates a config option that detects libbpf's ability to display
character arrays as strings, which was just added to the BPF tree
(https://git.kernel.org/bpf/bpf-next/c/87c9c79a02b4).

To test this change, I built perf (from later in this patch set) with:

- static libbpf (default, using source from kernel tree)
- dynamic libbpf (LIBBPF_DYNAMIC=1 LIBBPF_INCLUDE=/usr/local/include)

For both the static and dynamic versions, I used headers with and without
the ".emit_strings" option.

I verified that of the four resulting binaries, the two with
".emit_strings" would successfully record BPF_METADATA events, and the two
without wouldn't.  All four binaries would successfully display
BPF_METADATA events, because the relevant bit of libbpf code is only used
during "perf record".

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/build/Makefile.feature              |  1 +
 tools/build/feature/Makefile              |  4 ++++
 tools/build/feature/test-libbpf-strings.c | 10 ++++++++++
 tools/perf/Documentation/perf-check.txt   |  1 +
 tools/perf/Makefile.config                | 12 ++++++++++++
 tools/perf/builtin-check.c                |  1 +
 6 files changed, 29 insertions(+)
 create mode 100644 tools/build/feature/test-libbpf-strings.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 3a1fddd38db0..2e5f4c8b6547 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -126,6 +126,7 @@ FEATURE_TESTS_EXTRA :=                  \
          llvm                           \
          clang                          \
          libbpf                         \
+         libbpf-strings                 \
          libpfm4                        \
          libdebuginfod			\
          clang-bpf-co-re		\
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 4aa166d3eab6..0c4e541ed56e 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -59,6 +59,7 @@ FILES=                                          \
          test-lzma.bin                          \
          test-bpf.bin                           \
          test-libbpf.bin                        \
+         test-libbpf-strings.bin                \
          test-get_cpuid.bin                     \
          test-sdt.bin                           \
          test-cxx.bin                           \
@@ -339,6 +340,9 @@ $(OUTPUT)test-bpf.bin:
 $(OUTPUT)test-libbpf.bin:
 	$(BUILD) -lbpf
 
+$(OUTPUT)test-libbpf-strings.bin:
+	$(BUILD)
+
 $(OUTPUT)test-sdt.bin:
 	$(BUILD)
 
diff --git a/tools/build/feature/test-libbpf-strings.c b/tools/build/feature/test-libbpf-strings.c
new file mode 100644
index 000000000000..83e6c45f5c85
--- /dev/null
+++ b/tools/build/feature/test-libbpf-strings.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bpf/btf.h>
+
+int main(void)
+{
+	struct btf_dump_type_data_opts opts;
+
+	opts.emit_strings = 0;
+	return opts.emit_strings;
+}
diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index a764a4629220..799982d8d868 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -52,6 +52,7 @@ feature::
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
                 libbfd                  /  HAVE_LIBBFD_SUPPORT
+                libbpf-strings          /  HAVE_LIBBPF_STRINGS_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
                 libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
                 libdw-dwarf-unwind      /  HAVE_LIBDW_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d1ea7bf44964..647ade45e4e5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -595,8 +595,20 @@ ifndef NO_LIBELF
           LIBBPF_STATIC := 1
           $(call detected,CONFIG_LIBBPF)
           CFLAGS += -DHAVE_LIBBPF_SUPPORT
+          ifneq ($(OUTPUT),)
+            LIBBPF_INCLUDE = $(abspath $(OUTPUT))/libbpf/include
+          else
+            LIBBPF_INCLUDE = $(CURDIR)/libbpf/include
+          endif
         endif
       endif
+
+      FEATURE_CHECK_CFLAGS-libbpf-strings="-I$(LIBBPF_INCLUDE)"
+      $(call feature_check,libbpf-strings)
+      ifeq ($(feature-libbpf-strings), 1)
+        $(call detected,CONFIG_LIBBPF_STRINGS)
+        CFLAGS += -DHAVE_LIBBPF_STRINGS_SUPPORT
+      endif
     endif
   endif # NO_LIBBPF
 endif # NO_LIBELF
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 9a509cb3bb9a..f4827f0ddb47 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -43,6 +43,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
 	FEATURE_STATUS_TIP("libbfd", HAVE_LIBBFD_SUPPORT, "Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el]"),
+	FEATURE_STATUS("libbpf-strings", HAVE_LIBBPF_STRINGS_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
 	FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
 	FEATURE_STATUS("libdw-dwarf-unwind", HAVE_LIBDW_SUPPORT),
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


