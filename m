Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673641A8883
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 20:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503319AbgDNSFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407798AbgDNSEg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 14:04:36 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E4AC03C1A9
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 11:04:31 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id nh16so1922175pjb.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 11:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R8mSLoA4yKGeDKyGJ46zmAHwFa4kk4RkB3OQPR7SZNk=;
        b=DgacTHFrhUTmRCS1G/R3HDZNLNcCg6Re4d6abGUYneugCwTHhTBWu1tZzjSEItrPCm
         3LDsMfjwNW6fFeTTzKLKugqGaVdt1lIfWTBDJQnjww7xvxiCiJnVR7I3Xfon+ri8l1Op
         yt6pmmodkCIuMHMGFN892/pvE34SkT2eG2Z/DJkOjd+9HF88UfwP45Q30n4W/F9Xz3f7
         2U2A8DE2Hlt6RjeMsSmq5YlrgsZrg5l+iCRT1GbGYZPak2qr1eQ/YUP9zHZGsqwTtb/s
         ar+uWxLPQYSQJAGuaCOl1L8eXbnYvdpli1Fsqz7b80DT+BxAJQ33eSTJyONyjJ6IRle4
         VbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R8mSLoA4yKGeDKyGJ46zmAHwFa4kk4RkB3OQPR7SZNk=;
        b=tEWYs19qkZI80EScNTHrL188B5tjCB5A28hqr1uTuZ5QT1JF45A5LWQ8IIO10WOtn4
         vDuVnEoqkaY42GnP4tGUtoHGXuxYwhpyq7LvIeFGzTgKwEK+2wunTw1c5OKbJo1hpbPA
         27rd+59ctwCa/kGkC4kPSQLFDM/z11ES1weK/GjmD0Q3w3le2D7+17qhKcf3Uo9UU7bv
         CIaASzGT4zAZrKfcc97Nug5Ly8D2eB+6Ce56fQYkuZjRoOECRimj+2yvcbl8QWZN977m
         D9kdNKVAd2DVClxBiTBdqJKfdLMrYG3gaP2tIk0gX9qncVCb578YL656rQJbBsEeWsNw
         cfnQ==
X-Gm-Message-State: AGi0PubRA/SqT/sSrK2UBa5GjerqSrtPcYBwdUVANitcrP/zktKfp4r/
        36/RCdMSpbRVj+n+Feo075l0mrkfKODk
X-Google-Smtp-Source: APiQypJCA7H1GxMspnIkqi7P7Iyd1SpZ3mgnXSOlXDy11YUXuRBlquJhX0wMDMg9qn+SxUXDgZ+TEBgwvW2z
X-Received: by 2002:a17:90a:9504:: with SMTP id t4mr1524428pjo.21.1586887470647;
 Tue, 14 Apr 2020 11:04:30 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:04:17 -0700
In-Reply-To: <20200414180419.14398-1-irogers@google.com>
Message-Id: <20200414180419.14398-3-irogers@google.com>
Mime-Version: 1.0
References: <20200414180419.14398-1-irogers@google.com>
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

