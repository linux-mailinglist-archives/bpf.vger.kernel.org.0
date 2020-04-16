Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758DD1AB827
	for <lists+bpf@lfdr.de>; Thu, 16 Apr 2020 08:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408093AbgDPGhN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 02:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408188AbgDPGgK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 02:36:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AB3C061BD3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 23:36:05 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d11so1995940pjh.4
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 23:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R8mSLoA4yKGeDKyGJ46zmAHwFa4kk4RkB3OQPR7SZNk=;
        b=Tbcz/5GTD0MhxbjxSz+zG5pSqKSdU1P5q8lEgAqpLkInNCr+YPX4aXcxjGsL7ummmO
         GN7GSZENxaeD3xf0Riocr4k4gZ92w9bkvgR2vMDepAHqQNLxebRMg5OjkWYX+OHSvm0L
         JzKcLJUCrjZEjlY5TM+NFLZH+aeLkHyQCEX/7B11Tik2AKdhaa6WKxGvgB7Al0Okd37f
         va1Cjb5bb8YzRxO9nZuEVcplEyMa2dl1tza1E6ca39I65H1XEkMVcvZ7pBjynJZi6ukn
         z1mER9KgwI0SG416uK2KmQOjz5yU/6LuyyRGly37Q1QVogfTwcRWqYE8KNiIX2bgkJLS
         itMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R8mSLoA4yKGeDKyGJ46zmAHwFa4kk4RkB3OQPR7SZNk=;
        b=BhxSaOFEWgPX9Zd9HuWI7h0n1m5+HpV1I//vHmuUc3SwNp1P98ZXaSOyagpbMCebxF
         t03HVCdN0EZzwFcW38mgDRH9zq7NwfuhZbnT1dWIFFXEUrE5GGXVgmLLGwSgSWjvmjkt
         t7k5rxUc2Uv+S+eAHDZoIWS4tRYw8Re2uoToB4GHIzFwRNfVxt2+gK1ZniVnwxmu7jbr
         jXEmDUIc7w2WotOVmqZLC27+dPi1Cp2CBAlsRYWeUtdWxr5d9p0voCKC1LiZJavapydS
         jY7sQeIBXKU+1AiaO9J4+KtRvT2luwamL6c1f+/qrLDVp0Cb8lwCMKpc1SvpLatrNH81
         RudA==
X-Gm-Message-State: AGi0PuYjPeHhQVAQqdPdFCE7ARrXX9OvKhfQnf3BEOAgZL7do4akl98w
        BTEAXpfv8oTYzz1h6K9RpQp0ExIi6deG
X-Google-Smtp-Source: APiQypK1f9V/XZSrdHGZIgfiemU4JkGrTWcw2vE8IRzSHkL3Sf6dG/w5H9cV54KYVepXp9T1LXUN49c7hTuD
X-Received: by 2002:a17:90a:2149:: with SMTP id a67mr3299588pje.43.1587018964507;
 Wed, 15 Apr 2020 23:36:04 -0700 (PDT)
Date:   Wed, 15 Apr 2020 23:35:49 -0700
In-Reply-To: <20200416063551.47637-1-irogers@google.com>
Message-Id: <20200416063551.47637-3-irogers@google.com>
Mime-Version: 1.0
References: <20200416063551.47637-1-irogers@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v9 2/4] tools feature: add support for detecting libpfm4
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

