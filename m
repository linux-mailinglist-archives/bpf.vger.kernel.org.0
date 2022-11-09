Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137BB623303
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKISwL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiKISvj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:51:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B192C12F
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:51:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q62-20020a25d941000000b006cac1a4000cso17452827ybg.14
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRHZ0FW2HIw6QS+Bkui5kSfb7e3a9NpS1DLZODqxyrQ=;
        b=GPgb7yM3peSx5lbtrgAYiXyGaOh2dWb1x0APsgQSFdREbuoKUMUsu6vcx8Evw40fiY
         QAGjtLjIdv7+MYtobi6OJJlAIYqgn5nCyrkMWbGzI62qqkSAwtB7LA9ofYRpKx36RHKS
         eRIGKfs/HfJW6/ucPO/jwLYCyRgbdKepcMe3HU6W2PdzwhxhpD0KhzMoULrZw8ExJahG
         wHszHa+LZPcpl834kijyH641IEurVR85AF5yzOQuBCGOJNQLQyGotaFhmdfWCseui+Xz
         wJgRjoBihZ78jmltkEnNnE/cApoRkahbTh1TL+SAKqszC2ELjdcLziOI5MprJfzPa9fE
         K16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRHZ0FW2HIw6QS+Bkui5kSfb7e3a9NpS1DLZODqxyrQ=;
        b=eMpeNAXBZOjRUnlWz5TDE0QAxbukkxnoATlq4oJ3JrxVHoPPxqnt91UU0pwRDH3WY6
         XKJ1AvefPl+WKzUeDj0Z6pjN0Qxgxa8ECvWWKhOmR/8C+ou4E0FZltiII3wrGzGiEGPL
         oiSHAmgoNClN92Ms+vMYqJuKFoythAph6sok63b7gQEBSwdul0Vp/fVhSZ5Qi6uuEfdH
         g08OSrmhbh6gsKWC8l+YuCXU75pBgjC/oA4LwNXv3lNpro/L+Sbcaq7jyTxDSMVttFA/
         rRBiViElOQHrGuk/DJpXKZH2jCe2431kb/b/2Sv8YjhiZa9Sq55kpgF6R4u8yRW4s9eZ
         oRRw==
X-Gm-Message-State: ACrzQf26ju6cmZxobPtXmuuYJHtXC37U9DBVOgCWwKmRy+ABrVz7dKwD
        pB/uTlv6HcAM5y+kuQFWRgkFelLbgvqA
X-Google-Smtp-Source: AMsMyM4aG/qfIRrPsZc6e0jRKlvIWUDtNj+DGVN0VGLeGwCxia/YIhlvD0BRcIpmKA7adfm9rZBzCu9ZqgpG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a0d:dd90:0:b0:36d:2005:5417 with SMTP id
 g138-20020a0ddd90000000b0036d20055417mr1097889ywe.238.1668019873667; Wed, 09
 Nov 2022 10:51:13 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:13 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-14-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 13/14] perf cpumap: Tidy libperf includes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use public API when possible, don't include internal API in header
files in evsel.h. Fix any related breakages.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/cpumap.c  | 2 +-
 tools/perf/util/auxtrace.h | 2 +-
 tools/perf/util/cpumap.c   | 1 +
 tools/perf/util/cpumap.h   | 2 +-
 tools/perf/util/evsel.h    | 2 --
 5 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 7c873c6ae3eb..3150fc1fed6f 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -6,7 +6,7 @@
 #include "util/synthetic-events.h"
 #include <string.h>
 #include <linux/bitops.h>
-#include <perf/cpumap.h>
+#include <internal/cpumap.h>
 #include "debug.h"
 
 struct machine;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6a0f9b98f059..2cf63d377831 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -15,7 +15,7 @@
 #include <linux/list.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
-#include <internal/cpumap.h>
+#include <perf/cpumap.h>
 #include <asm/bitsperlong.h>
 #include <asm/barrier.h>
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 6e3fcf523de9..5e564974fba4 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -12,6 +12,7 @@
 
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
+#include <internal/cpumap.h>
 
 static struct perf_cpu max_cpu_num;
 static struct perf_cpu max_present_cpu_num;
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index da28b3146ef9..c2f5824a3a22 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -4,8 +4,8 @@
 
 #include <stdbool.h>
 #include <stdio.h>
-#include <internal/cpumap.h>
 #include <perf/cpumap.h>
+#include <linux/refcount.h>
 
 /** Identify where counts are aggregated, -1 implies not to aggregate. */
 struct aggr_cpu_id {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 989865e16aad..f5d9f6a351cd 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -10,8 +10,6 @@
 #include <internal/evsel.h>
 #include <perf/evsel.h>
 #include "symbol_conf.h"
-#include <internal/cpumap.h>
-#include <perf/cpumap.h>
 
 struct bpf_object;
 struct cgroup;
-- 
2.38.1.431.g37b22c650d-goog

