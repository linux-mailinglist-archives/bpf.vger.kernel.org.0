Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE53D1A4EB2
	for <lists+bpf@lfdr.de>; Sat, 11 Apr 2020 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgDKHqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Apr 2020 03:46:42 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41614 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgDKHqm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Apr 2020 03:46:42 -0400
Received: by mail-pg1-f202.google.com with SMTP id m25so3447782pgl.8
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2020 00:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AkAQBjWzUU3cZ8rKRxOD3TM368KdO9ukCYNqfogwqG0=;
        b=oL4DFCReRM9ZjntXtsZLZQoVfPwo4U0OJ4TLLh+ap1Vu/k4k0wZ7YLKBS8in6hSwly
         cTTceY+QSAzHBCsU36Le+3N6Pb1brdk3q7D1RBReu4JTn4G9zwRB2YgNBMG2mtoYdgDG
         B/joXuAzouf8OWHe3HxlgVYCmLr69AxThFM4e4TDazs03im0KyMW4N8fVFGsKx52fcmv
         ib10D/Ex/QXt/LTCAtgxFp1wgqPSXtQGFpkWg50Yk7yOFa7MyHr7SIPor5h2uwgvS5uh
         OaJ60cxcPDAKfmyIAlIZKlfdMt3rD8trgdn4sZh4rKPN+211+vEnmAHY3G6QwZ4zEzMd
         nt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AkAQBjWzUU3cZ8rKRxOD3TM368KdO9ukCYNqfogwqG0=;
        b=DOEPKCc9kkUADQzqDKKEKtJzDF1odzoshrmZfvjJkzlpHy1K+lidQWk9ruAogGiN6O
         OLVZWPfzaWaKGWuMzOxrMbXh5IDzYLr0Vlwmxp73YHc5z+Dm1DPv46QFXakkc7lzFZ4h
         w+OnmLeQZcNXj7PcanWWeZHBsLzBASeDNdGR81/v3U1aGM9nFZ/5ovd6EwiHTM/AlGSU
         fx6y7yamRlRksum5TKKdDP1mdIZofVYyE2UP6FxOrVe2wb0m4YDKaRXUwiT6s5ueSr6n
         QX/WPd8hiN8kWpzHHhKqk/W1CT2c+60FKI9+7ctYCtypEq7MTwCsDHcCoTSfeCXcTqfv
         eDtw==
X-Gm-Message-State: AGi0PubntAAlndtX9jrkCOBILH5QFRXQJX8L7SB8NYCDcYTtGnFBhkIx
        Rjb8rmmHIAyk6WwlV7ah3d1EqGh2ZD9/
X-Google-Smtp-Source: APiQypJxsq2ZlA8bzhAUN0rO0Lqq/+xxCnedGFpdVIW2pp4IRi+ji1qhJCV8kX5A421vR5UzDRrFe8+vUG7O
X-Received: by 2002:a63:7e58:: with SMTP id o24mr7894193pgn.3.1586591201104;
 Sat, 11 Apr 2020 00:46:41 -0700 (PDT)
Date:   Sat, 11 Apr 2020 00:46:29 -0700
In-Reply-To: <20200411074631.9486-1-irogers@google.com>
Message-Id: <20200411074631.9486-3-irogers@google.com>
Mime-Version: 1.0
References: <20200411074631.9486-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v8 2/4] tools feature: add support for detecting libpfm4
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

libpfm4 provides an alternate command line encoding of perf events.

Signed-off-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature       | 6 ++++--
 tools/build/feature/Makefile       | 6 +++++-
 tools/build/feature/test-libpfm4.c | 9 +++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 tools/build/feature/test-libpfm4.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 3e0c019ef297..0b651171476f 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -73,7 +73,8 @@ FEATURE_TESTS_BASIC :=                  \
         libaio				\
         libzstd				\
         disassembler-four-args		\
-        file-handle
+        file-handle			\
+        libpfm4
 
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
@@ -128,7 +129,8 @@ FEATURE_DISPLAY ?=              \
          bpf			\
          libaio			\
          libzstd		\
-         disassembler-four-args
+         disassembler-four-args	\
+         libpfm4
 
 # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
 # If in the future we need per-feature checks/flags for features not
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 621f528f7822..a6eded94a36b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -68,7 +68,8 @@ FILES=                                          \
          test-llvm-version.bin			\
          test-libaio.bin			\
          test-libzstd.bin			\
-         test-file-handle.bin
+         test-file-handle.bin			\
+         test-libpfm4.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -325,6 +326,9 @@ $(OUTPUT)test-libzstd.bin:
 $(OUTPUT)test-file-handle.bin:
 	$(BUILD)
 
+$(OUTPUT)test-libpfm4.bin:
+	$(BUILD) -lpfm
+
 ###############################
 
 clean:
diff --git a/tools/build/feature/test-libpfm4.c b/tools/build/feature/test-libpfm4.c
new file mode 100644
index 000000000000..af49b259459e
--- /dev/null
+++ b/tools/build/feature/test-libpfm4.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/types.h>
+#include <perfmon/pfmlib.h>
+
+int main(void)
+{
+	pfm_initialize();
+	return 0;
+}
-- 
2.26.0.110.g2183baf09c-goog

