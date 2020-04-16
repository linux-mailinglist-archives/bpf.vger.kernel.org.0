Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E21ACD8A
	for <lists+bpf@lfdr.de>; Thu, 16 Apr 2020 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437779AbgDPQVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388298AbgDPQVI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 12:21:08 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6DDC061A10
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 09:21:08 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 20so3462411pfw.10
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=i6zi1rxo51fT0gF/9bIKSou9eRtAcSwwYlA8EKV06Zo=;
        b=HN8WubAfA91Oq5unhGG2MkopzGLkdfvg9STdwJsiSIl7hxl76b/eAFL7jhXWb2Ox3m
         SaEaUPM39ntxqpGiuXqlA9gEIeJArcs1oELta1pGoAcCQ8Y7j8qiITnix2h4f6JoQEYo
         QGJQ8W+5urtqToRkZR16mEWxOdz8X99KKwur5GuVOBWessbgEv21JC8tFrrOd+XMsTgZ
         3gGLM7hP3pDlEuoL69b+4rbPzHzQTdT7C2AiKjHEWbjy6fqk6wwDguVwtJvgVeZiRMRD
         Qskf5j6/g0x46Y9hPI3Zx1XgQfznExjp8bc0l/9GDXZ+HHifmCBePWCImVSFvpI0yfuh
         lE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=i6zi1rxo51fT0gF/9bIKSou9eRtAcSwwYlA8EKV06Zo=;
        b=FbLcoVAqsVs/FAOgVGvAYyoeTjPeHANMY8p0tlIbEAZikQbAw/ioSZPSoJcJKexAw0
         Qiq466ZbSsSvqoTOqOeUlp8Z0pv32xhJUKzWBSA+/PGsc6ZWcCuxOjBaH/3Gq04xYC5A
         4KUzrXoPgSiGBagqFohUS0kwCjV0ulvNfcEB9kIQjH825tSV0I7gPbffW5ID3mmSGzvG
         ndt284yNITakgRK4VFF6RAmmatuW1mgWHE2OCDVbQoqhkrNWC45qS/7VbNOaJkWf4OlL
         NSW8cco5w/b/MQs7Po/+THn6atRRZEREkeOZ02tZM/JV7FKREA7gyQCFqYYYpzFk0idC
         osnA==
X-Gm-Message-State: AGi0PuZ1JZgdBKHmn1ZeQFU3ta3Fwb0mY6MDx7oS1x9JKXoJsI9io4Ci
        +k8qevRCTSKWTTxFitnFrIabljclatIF
X-Google-Smtp-Source: APiQypJCtiTrQy1RWVW3S33PVpA4SuG+D/ydw+ePNnNNFVlEgIZ3Zws8LDl2fX9FI8lD+yI2Kl+taVRN26F2
X-Received: by 2002:a63:6444:: with SMTP id y65mr27372866pgb.343.1587054067816;
 Thu, 16 Apr 2020 09:21:07 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:20:56 -0700
In-Reply-To: <20200416162058.201954-1-irogers@google.com>
Message-Id: <20200416162058.201954-3-irogers@google.com>
Mime-Version: 1.0
References: <20200416162058.201954-1-irogers@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v10 2/4] tools feature: add support for detecting libpfm4
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
2.26.1.301.g55bc3eb7cb9-goog

