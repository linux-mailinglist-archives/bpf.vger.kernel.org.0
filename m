Return-Path: <bpf+bounces-60518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E3AD7B67
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D26B3B50F1
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEAA2D6616;
	Thu, 12 Jun 2025 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F20QgdiE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511212D5416
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749757786; cv=none; b=M7JsgZJF8omqzW1hl/CX6UUDn1zlJLLi4srnSSH91bLfiocb9dxIMYGTwkURvL6fZcGYkmFfFs6ZaTClbsy4cQSXnRpJ1Jm3UD+aFQSOMfyuhSD9DxBteaO8WV7u8qh2X5BC2uoxqVGovoPCzSoyWsswmRu1z+ozw3IOQrOWZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749757786; c=relaxed/simple;
	bh=jY3MGFXxhQhmObC8B0QQNU5r9zUDqG3Bm/y01WftukM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fxSrKoMkTAGXHeunu/gq+ZV/uPrMJT+9KS1hC6fnjLYCJcTObWH91d2cL4g8eyQK9GjePQbwdEZ5yHNspRnTSRdCcFghWxlfONZlH567uzW1Dpa2ywxAkYUO5aOCr8D7jmTcd7eBj5mDNnSOYMEma6aEdwkrKYd82+RVM4muJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F20QgdiE; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311d670ad35so1282693a91.3
        for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749757784; x=1750362584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYXjS/TK8jfGSnydeZ1dK5T+dpqe3MEJcXcTnDyoht0=;
        b=F20QgdiElgHCP7ZXBXR16EXGexXeku68NO0Y+jO22wNmvFAIzzuq1jGFH5UEbZZmvG
         D+rMmYCR39hzxU4Prb5auOce1l+vgsPAE552ns4ialv6lqzky9c9ex9y4ddB6HM15/+T
         aZptf/wWZW5Jpp1IqsZ33mYAxsk07NsOOUG1F9VldMqUW63tITswQbInTAE78sArlfI1
         VuQrEF6iIjaw7LAuZ4maPN43W4ppSCBA9TugzFsQioK91CGEydke/PoIy8EWzOXaXJGi
         t7DgGWHSH9Dil6dMqvzXVEaVYUzmIhpJtebTsVcYTaTovcUJkSBQb0V5wixSq4a5c5sa
         MIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749757784; x=1750362584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYXjS/TK8jfGSnydeZ1dK5T+dpqe3MEJcXcTnDyoht0=;
        b=xVZ9kC35tjwlZmz0cAIafszS6u2C0Pmq1JRbAtVCJhhY4uKK8Pvh1YjKjn4doLY9ME
         lERUco1I9AMIx5XKKOTCnhWNFrtIhlqu8yGU2VtD1Ohkn/tgDmMG3YCsx4bOBFkXZHPS
         TWhGHaDxWC0zwsdKhb1s53kDfvaFfvS1u2BVwqnCCBPSTiNtC7zHdUpvdIYr5pcA602+
         tLzj5854n30fR504to6sMlFAokmdStW07Hv/V8dRWQXOxjjqJvu/DIzxR1wTvRLx82um
         ovv/bA5/DZ2PMhY9oNR7jLVKq6zUiQIgFx/fHospskcs7zqSHUJzSGmRzoDDbWwvW4s7
         mITw==
X-Forwarded-Encrypted: i=1; AJvYcCWqvYfUkD/mCidcu/4dPWgoyUjtX3jOdazLDXB5ylNALrnZ5vPLB981aqeB1K8JQoE2io0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxavHFz1w27O4Aj0mg3StJf7Qx5VGZW51YIkaLAOz3mdx9dX/2s
	p0JmiYCwe/TeX9aNCEk4Glv57GwxOnM+psc0+8IuIGthkG9jjWdgdZc8ugwami4Sgm1gvm/k250
	BrR6gfEFRzeN8Wjh0t0sgsA==
X-Google-Smtp-Source: AGHT+IEIyY1JuTOelnsD6QIJH09dPoFDqlUdg6uKiJwl+kRH0n4MU6s3D73fdkkzPSwsOxlG8YH8nMFbcjmO/aUx
X-Received: from pjbdb8.prod.google.com ([2002:a17:90a:d648:b0:30c:4b1f:78ca])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c6:b0:311:e358:c4af with SMTP id 98e67ed59e1d1-313d9eac799mr726583a91.16.1749757784484;
 Thu, 12 Jun 2025 12:49:44 -0700 (PDT)
Date: Thu, 12 Jun 2025 12:49:35 -0700
In-Reply-To: <20250612194939.162730-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612194939.162730-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612194939.162730-2-blakejones@google.com>
Subject: [PATCH v4 1/5] perf: detect support for libbpf's emit_strings option
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
 tools/perf/Makefile.config                |  8 ++++++++
 tools/perf/builtin-check.c                |  1 +
 6 files changed, 25 insertions(+)
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
index d1ea7bf44964..affe5e173920 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -595,8 +595,16 @@ ifndef NO_LIBELF
           LIBBPF_STATIC := 1
           $(call detected,CONFIG_LIBBPF)
           CFLAGS += -DHAVE_LIBBPF_SUPPORT
+	  LIBBPF_INCLUDE = $(LIBBPF_DIR)/..
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
2.50.0.rc1.591.g9c95f17f64-goog


