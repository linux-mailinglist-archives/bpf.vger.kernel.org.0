Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1F41BEC85
	for <lists+bpf@lfdr.de>; Thu, 30 Apr 2020 01:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgD2XOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Apr 2020 19:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgD2XOw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Apr 2020 19:14:52 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A9EC08E934
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 16:14:52 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id d13so4454340qke.19
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2020 16:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eiWqfc49ogrYbZ/4/xuGkLOd4BeleFiuwlczI7sArlo=;
        b=Un4WQVe5D1bdYyPUVc6UQDO3j0T9MYR3rGyZ2ceOJtfX6QNrYpRMgVjMcxYeEps1k6
         ZMWjpH0eDukhgY7ojYA6f3eFq0CHjY/IOyeDzaHrv4Y/2YLXEoxQ/KPcJsmECkud8/+P
         sl/yU64IiBRk1Bit02eWZd5mGAH+MEiCK7tWX1R7HsMsPRDFljOz2Ux3BjDce695yBMJ
         69WpStLxpilYpM4uLeKxhJtqUzMymXy4kH77soTQRCaKfLFbhrNBqPZhhhydncySyGAp
         CpkuWlKPgRwgj5H0TesyuQwJ10CCQeidlGmYMcetG0KWehLkbleIzKKzxac82MvYBRlq
         2ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eiWqfc49ogrYbZ/4/xuGkLOd4BeleFiuwlczI7sArlo=;
        b=o65MKdfr6Y4TrlIsxGs0w85NFRfiRPne1oBe6gHKN5yozEabcZh8R5HMRW9zMNS2y6
         r1yjC+0aOHzWbcIw9jjf5iO0jfRjwkxU4pBOVfGuiZe6iW16QPcduaylzlAgG9bT7y2O
         xvGa04rRj61YCOe7piAmzDjYnTAaQCk7mJlgJpHbgb2XPs50H3F7XovdsucOKUL/VGfD
         246ZyDe2sOsW/oMRqm+UlDAeSI+uJkKGov0F+wcuS6pSKZE4h92Ms9mMvfl29YKPb3FU
         Chv5hOJo7r4KooIR2FnX7vBOw5muC5Acck1wDNR9ypIruvHBlhFxcc6KB1iP93tLZTQr
         kecQ==
X-Gm-Message-State: AGi0PuYwI1JCFDkNFqLmcB9Se1VbDodCv7FL9Y7uunmWUzqk2nkermO/
        lNicpD6EMDmnqw/2fn706F4gzSoQqFe7
X-Google-Smtp-Source: APiQypJF+pNX0f25uRs8CxEj2RzxyRoLpHIC31I9C2TGE4E2d47A5QkzmO9GJcdYTfo+svN1asUse81hbhTv
X-Received: by 2002:a0c:d652:: with SMTP id e18mr292809qvj.58.1588202091087;
 Wed, 29 Apr 2020 16:14:51 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:14:41 -0700
In-Reply-To: <20200429231443.207201-1-irogers@google.com>
Message-Id: <20200429231443.207201-3-irogers@google.com>
Mime-Version: 1.0
References: <20200429231443.207201-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v12 2/4] tools feature: add support for detecting libpfm4
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
 tools/build/Makefile.feature       | 3 ++-
 tools/build/feature/Makefile       | 6 +++++-
 tools/build/feature/test-libpfm4.c | 9 +++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 tools/build/feature/test-libpfm4.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 3e0c019ef297..3abd4316cd4f 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -98,7 +98,8 @@ FEATURE_TESTS_EXTRA :=                  \
          llvm                           \
          llvm-version                   \
          clang                          \
-         libbpf
+         libbpf                         \
+         libpfm4
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 92012381393a..84f845b9627d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -69,7 +69,8 @@ FILES=                                          \
          test-libaio.bin			\
          test-libzstd.bin			\
          test-clang-bpf-global-var.bin		\
-         test-file-handle.bin
+         test-file-handle.bin			\
+         test-libpfm4.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -331,6 +332,9 @@ $(OUTPUT)test-clang-bpf-global-var.bin:
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
2.26.2.303.gf8c07b1a785-goog

