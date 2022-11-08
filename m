Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D423620A53
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiKHHhZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbiKHHhB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:37:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D1C326C2
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:37:00 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36f8318e4d0so130878867b3.20
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ig4l2ipqQRcuxZUCV8QGPuQA2SRfsl5B/KVZE9nXHU=;
        b=f5+cgbH+7Iy/kQMhz2Ss4kNkLwzOc61RPvlR7cP3Vuczg9OwBZ7Ho9ipmpcesN9ydb
         xXABppTLCLTp7pgW1nav/llJ7UtXv8+C4FdOhRB7MR0heNmwcDcjdYLVL3iMKZMN97zI
         0xs/fJRZauIpxcwYX3K4sxfLG+wF5nr4GzUfphybcMCsCnUtgORnAuvgkKJzyuC+qUA0
         gFGEb+Vc+ZekhsAMvkM08VN7s8A2YFdDM+QivmxqPcTjqImPA4GHRfYdvJzbk+wOn7/K
         9uHiioNCea7AEqob1KJ6Gup91SFhEEnRtutyEJvVfsdnuwEtVIIzaaiJaNln1aMHTDyq
         cBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ig4l2ipqQRcuxZUCV8QGPuQA2SRfsl5B/KVZE9nXHU=;
        b=E0qySQglSfYzJbifOAF1dsiGhlA+ank8AeA1DUXZ5VoKtGQlH5b8b1FqRavC/KoNWM
         ju4QRyF2mP6Q6CD0QYlI7aExq6L0q0T4nDA9urGM+4PoPeYHz/Y643kPUpMMQSktgqvb
         Cml1I3PxoRZDkmXDvl0WWBljBpXpO5lImHNJIdCdaMFyOpNOX3CWnt/3yM3N/eYqtPMl
         Go6AqXADkNLDKWRXLcLPKRYffsW/MDiEEsiznwMnaeip/lacmQcVIU7Hdy+SfZ5lVZ62
         zs3ikj9f5yfzPeRUpYng0QSB0Rg5P6L3d3lp8y1uhzPiX5WXL8BHKnfJiyP8llZqH2Ta
         5BWg==
X-Gm-Message-State: ACrzQf0QviTCtcu9zePhq+BOn2Awaj0yTswJ7bC1rdw2aZPI8zpvRnns
        J4RvTAtgstkm8rrgx6vNuO7ZuXwQQQ1n
X-Google-Smtp-Source: AMsMyM44DCoS6coOCjK4/HJdg32GkzZTM3Bfy1XTy80sl7Ua9Tl/cUqvJhW06FCu65mFpumAMewaZnYH6L72
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a05:6902:128d:b0:695:818e:3996 with SMTP
 id i13-20020a056902128d00b00695818e3996mr52680112ybu.499.1667893019871; Mon,
 07 Nov 2022 23:36:59 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:15 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-12-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 11/14] perf expr: Tidy hashmap dependency
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hashmap.h comes from libbpf but isn't installed with its
headers. Always use the header file of the code in util. Change the
hashmap.h dependency in expr.h to a forward declaration, add the
necessary header file includes in the C files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c       | 1 +
 tools/perf/tests/pmu-events.c | 1 +
 tools/perf/util/bpf-loader.c  | 4 ----
 tools/perf/util/evsel.c       | 4 ----
 tools/perf/util/expr.c        | 1 +
 tools/perf/util/expr.h        | 7 +------
 tools/perf/util/metricgroup.c | 1 +
 tools/perf/util/stat-shadow.c | 1 +
 tools/perf/util/stat.c        | 4 ----
 9 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 6512f5e22045..b6667501ebb4 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -2,6 +2,7 @@
 #include "util/cputopo.h"
 #include "util/debug.h"
 #include "util/expr.h"
+#include "util/hashmap.h"
 #include "util/header.h"
 #include "util/smt.h"
 #include "tests.h"
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 5d0d3b239a68..f7b9dbbad97f 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -12,6 +12,7 @@
 #include <perf/evlist.h>
 #include "util/evlist.h"
 #include "util/expr.h"
+#include "util/hashmap.h"
 #include "util/parse-events.h"
 #include "metricgroup.h"
 #include "stat.h"
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index f4adeccdbbcb..b3c8174360bf 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -27,11 +27,7 @@
 #include "util.h"
 #include "llvm-utils.h"
 #include "c++/clang-c.h"
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/hashmap.h>
-#else
 #include "util/hashmap.h"
-#endif
 #include "asm/bug.h"
 
 #include <internal/xyarray.h>
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cdde5b5f8ad2..2139e8b0e401 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -46,11 +46,7 @@
 #include "string2.h"
 #include "memswap.h"
 #include "util.h"
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/hashmap.h>
-#else
 #include "util/hashmap.h"
-#endif
 #include "pmu-hybrid.h"
 #include "off_cpu.h"
 #include "../perf-sys.h"
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index aaacf514dc09..140f2acdb325 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -11,6 +11,7 @@
 #include "expr.h"
 #include "expr-bison.h"
 #include "expr-flex.h"
+#include "util/hashmap.h"
 #include "smt.h"
 #include "tsc.h"
 #include <linux/err.h>
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index d6c1668dc1a0..029271540fb0 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,12 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/hashmap.h>
-#else
-#include "util/hashmap.h"
-#endif
-
+struct hashmap;
 struct metric_ref;
 
 struct expr_scanner_ctx {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4c98ac29ee13..15441e9bfb73 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -28,6 +28,7 @@
 #include "util.h"
 #include <asm/bug.h>
 #include "cgroup.h"
+#include "util/hashmap.h"
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 07b29fe272c7..9bde9224a97c 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -14,6 +14,7 @@
 #include "units.h"
 #include <linux/zalloc.h>
 #include "iostat.h"
+#include "util/hashmap.h"
 
 /*
  * AGGR_GLOBAL: Use CPU 0
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 3a432a949d46..273a5b32e815 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -14,11 +14,7 @@
 #include "evlist.h"
 #include "evsel.h"
 #include "thread_map.h"
-#ifdef HAVE_LIBBPF_SUPPORT
-#include <bpf/hashmap.h>
-#else
 #include "util/hashmap.h"
-#endif
 #include <linux/zalloc.h>
 
 void update_stats(struct stats *stats, u64 val)
-- 
2.38.1.431.g37b22c650d-goog

