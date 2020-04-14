Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D872B1A88C0
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 20:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503538AbgDNSMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 14:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503476AbgDNSLE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 14:11:04 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2A2C061A10
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 11:11:04 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id r198so488677pfc.8
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R8mSLoA4yKGeDKyGJ46zmAHwFa4kk4RkB3OQPR7SZNk=;
        b=soPE3YbSyYsetKYuTK1j8cBgfL1ufL/chbR0V1Nlr/KGFsEhqXTx37PrP+FQqZ0VYS
         NctD2fvmwY0Mz0T3Tcm3+G7nBpf9rZrXjJUeST7ysZvyAr/mrERTRZWTCT2/0UIRi5/Z
         q3KMJmhn4tEpliFy/lSZC8i7J7aWbJfQN21+4ZFDhmKviV5dV+ltPNrogtJFbmI87/hL
         dh42b3mlezccKwMiD+jM5ivV64HZ+tLkq/7I3cFlXr6jqHlMyidiBdgzeBrS9/3wb9yA
         VoQgrEmq7kcUFtWJiiCr5r+X2ChTmphrOZS/2BOjmBmPijYVLcQ4/ngHh9BbhtWWjdSe
         cODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R8mSLoA4yKGeDKyGJ46zmAHwFa4kk4RkB3OQPR7SZNk=;
        b=umB/1YWUrdt8czRjHuT03z7dPYMSD23XcorCM2kMb60GqJU5wl6DNNuGWosdnycNyD
         0OdTnPOPbA33G+PqO9jAvWTtNN6yaiilqKHmbsltYH/aj48+J41b0RCY15vGFDZNpWVI
         LhKQylrxdWZRTnLSxORJ07fC5HTHiLbVKktO78iYRUv5BMixQA/ppxrOzjOCBeA6fIKS
         c6Knzsv/Fbe37v9vttjPG+FvIMvITk4gd79OCK386aANtFavpec9F+6MGqQrD7TKlnQc
         WfsPJ/Chk3dVevCUBteZIZspOX/3fZQ0PHOCXGMbQQYPSIQLCRzJvFUPoTv/9aIZxDIF
         FviQ==
X-Gm-Message-State: AGi0PuavTWFvafYm2xGhqWQncSxFq8M60SaIqhVnqksrbc/ebSTM1kQE
        kphFh9YOEWzDVwpqxylDTAItL5hvmDdQ
X-Google-Smtp-Source: APiQypKS42oeOJ/EEIPZ1vIkACtXeNF9CLv/+ToiDrm8HpPrn9vyCpP3q9r8jnr+W/V+4FlFShEz/09JUiYJ
X-Received: by 2002:a17:90a:14c6:: with SMTP id k64mr1503515pja.39.1586887863831;
 Tue, 14 Apr 2020 11:11:03 -0700 (PDT)
Date:   Tue, 14 Apr 2020 11:10:52 -0700
In-Reply-To: <20200414181054.22435-1-irogers@google.com>
Message-Id: <20200414181054.22435-3-irogers@google.com>
Mime-Version: 1.0
References: <20200414181054.22435-1-irogers@google.com>
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

