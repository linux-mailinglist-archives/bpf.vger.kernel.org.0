Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD5E623300
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKISvh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiKISvT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:51:19 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D3119C1B
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:50:58 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-37342ba89dbso169465787b3.1
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ig4l2ipqQRcuxZUCV8QGPuQA2SRfsl5B/KVZE9nXHU=;
        b=b7msoA8AoncFaspHrmwgH6klqKpT4URiSF4ZAdCaBph/QCJ4t4ghzAAqjIYIZYmbXo
         hhdFurpf02gKWsWyRVtIaJMW5X60TKr2h5MeJQIoylybrjkhfoLWSHZf9ymTUnXG6INr
         iigYpGgy1zdUhmN07pJP058WLgQExkAM3iH+WLErGpOLeHcN6EtlfpkIiJn2ftGMPBIH
         wZNZ1iLYrwNM8sIdsQhPxRFHVWdNPRIyUux26GHQ5ATPlp3BWFJy+60AYcf7np3+iapL
         2tnQffN4jerX+fIbyF4EWj7c5GIb4KSE0+qeXYxB/GXFMa3n86g/+I3Lem1zS7BxxvAJ
         66dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ig4l2ipqQRcuxZUCV8QGPuQA2SRfsl5B/KVZE9nXHU=;
        b=oeENFjvUqE7pRoh6LbvrxiOxCVwqITsbz/haKe2t0Mvk0hBDgz4FbNah65cYc5Vuok
         yV5/g+OvMtekHaJCW2tRlnaTwn6FRe1zI0ViTbAJhW0EOSvs6sQrFYDhEKztLTWRmxss
         foRcAAU/Nzd8F1jtuzfOHZZ2LxarRy9/vwIWCQBAJxMFwOmic3p2RqlPhtTyLcIONGuk
         IzXdEr/nhgOmTsfqCp+3wPZ9RbJgFWY9u+QUEe7nijDn6cz2LQRmECIs1vC32MiRyhJI
         VXnaUM0W4IM4yb0JZWWXH57zte9vwmtwQpWp2XyS8SXOiTZ3pbqRT4IdKQV89Yuawljt
         I1PQ==
X-Gm-Message-State: ACrzQf0PXRRHMjztGq6Jiu7kimu0BbxgzCXZDfZGSfnCnL+Iz+UjB6j9
        SSHNJ8KtIQLi0rBzY7V500gyLStkh6O9
X-Google-Smtp-Source: AMsMyM7EXK7A5OBuVY/9+gm4abCVR4vVdYR/D/GkIiYEaHDdLZVgcCVrdkaC7SatYykj8VrsVih4GZR7KZNU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a5b:792:0:b0:6bd:2b3:a4de with SMTP id
 b18-20020a5b0792000000b006bd02b3a4demr1142080ybq.123.1668019857697; Wed, 09
 Nov 2022 10:50:57 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:11 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-12-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 11/14] perf expr: Tidy hashmap dependency
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

