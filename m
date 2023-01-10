Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E66E664EAB
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 23:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjAJWUs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 17:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjAJWUi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 17:20:38 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D944A631BA
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:20:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4597b0ff5e9so143312907b3.10
        for <bpf@vger.kernel.org>; Tue, 10 Jan 2023 14:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wXlKtQGeWTp7vou3jM8pEXClHMn0X8ibzVPnBb6ixuM=;
        b=hjTIUiM3nzSYOud7leDVomzWDX3omcRH7XxTp1cWtIJhcikMVufN+ADzaTNdzeYkj3
         HC8m5Q1q0N4tWXzZdz62Ir1LPgLAO+IhU/NZoaVR4GFeUM6+9gdxTBxUG6xXuEsppqxe
         4vnw6QbBUijTFsZg9n4sHratLsuRyEm4BjeV3UDRMt9++3Yh3Cq54hMnLSk3/4AROLWi
         fsELZGJJQe97BgTCi3vctbH4g6noIJFn734K3HKJyuYmN0ckIZ3X1C+cnuvxMG2MVHUU
         +jYZGmTxMrdoDqn9BRXhS5pXUVJNJf1poMGdTSp9IsSQGq4MmAoB+vrv5a5KcpnoI+PE
         Ogzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXlKtQGeWTp7vou3jM8pEXClHMn0X8ibzVPnBb6ixuM=;
        b=R42xOgimp4hrpIu/f4y/hxyR9LwN4zvhjI5illmi6TnwLg2Oyo5SV1jz9gJJa69ANs
         KLSvJzuIpLj8Fbf7bzcs+25P8fG02LrivHqe8w3tovxvxhuTsS8NhZPrPZcYDkaRkXeL
         fFbUy2RT2vvshBwDJhKZjLiWeBg95lg34GCyK2oznQgdttAJxLFXVAD9D+ul97mBmkbJ
         73VNZv2iSBBtq+KAzCsOzPzTu+MVrAzR1dRyb4KCXkH7ygWFEPl4QKACkEDDD21z75KW
         dyDMENuh2XV5Cxy9WzB6HkP3VoyEeDsyaSPQOiMxrwlVPCP9eAxHArWLmxzon3FsLbK0
         +brQ==
X-Gm-Message-State: AFqh2kpYdil9XJJR+xrC/XmCyxG195DJaxD0HFLNF+aNHuYWhBJJzAft
        gsVTV8TKNv/qr1rvX+Sq8IvFDlhT7ASO
X-Google-Smtp-Source: AMrXdXtsOl1f0Fb5fgvGa0gNKl1sLtoEETV+mVGmD2eGj8R7T4gSvIGR7mJ2SG2Ofoi48bTKkMaSZ7HQKeQj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a0d:e60b:0:b0:3ec:2e89:409c with SMTP id
 p11-20020a0de60b000000b003ec2e89409cmr1362309ywe.20.1673389236102; Tue, 10
 Jan 2023 14:20:36 -0800 (PST)
Date:   Tue, 10 Jan 2023 14:19:58 -0800
In-Reply-To: <20230110222003.1591436-1-irogers@google.com>
Message-Id: <20230110222003.1591436-3-irogers@google.com>
Mime-Version: 1.0
References: <20230110222003.1591436-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v1 2/7] tools lib: Move strbuf to libapi
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Qi Liu <liuqi115@huawei.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Xin Gao <gaoxin@cdjrlc.com>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stephane Eranian <eranian@google.com>,
        German Gomez <german.gomez@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
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

Move strbuf, appendable C strings, to libapi so that other libraries
may use it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Build                   | 1 +
 tools/lib/api/Makefile                | 2 +-
 tools/{perf/util => lib/api}/strbuf.c | 5 +++--
 tools/{perf/util => lib/api}/strbuf.h | 0
 tools/perf/bench/evlist-open-close.c  | 2 +-
 tools/perf/builtin-help.c             | 2 +-
 tools/perf/builtin-list.c             | 2 +-
 tools/perf/util/Build                 | 1 -
 tools/perf/util/cache.h               | 2 +-
 tools/perf/util/dwarf-aux.c           | 2 +-
 tools/perf/util/env.c                 | 2 +-
 tools/perf/util/header.c              | 2 +-
 tools/perf/util/metricgroup.c         | 2 +-
 tools/perf/util/pfm.c                 | 2 +-
 tools/perf/util/pmu.c                 | 2 +-
 tools/perf/util/probe-event.c         | 2 +-
 tools/perf/util/probe-file.c          | 2 +-
 tools/perf/util/probe-finder.c        | 2 +-
 tools/perf/util/sort.c                | 2 +-
 19 files changed, 19 insertions(+), 18 deletions(-)
 rename tools/{perf/util => lib/api}/strbuf.c (97%)
 rename tools/{perf/util => lib/api}/strbuf.h (100%)

diff --git a/tools/lib/api/Build b/tools/lib/api/Build
index 6e2373db5598..2eab5abbad50 100644
--- a/tools/lib/api/Build
+++ b/tools/lib/api/Build
@@ -3,6 +3,7 @@ libapi-y += fs/
 libapi-y += cpu.o
 libapi-y += debug.o
 libapi-y += str_error_r.o
+libapi-y += strbuf.o
 
 $(OUTPUT)str_error_r.o: ../str_error_r.c FORCE
 	$(call rule_mkdir)
diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 044860ac1ed1..dc2d810dfbad 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-HDRS := cpu.h debug.h io.h
+HDRS := cpu.h debug.h io.h strbuf.h
 FD_HDRS := fd/array.h
 FS_HDRS := fs/fs.h fs/tracing_path.h
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
diff --git a/tools/perf/util/strbuf.c b/tools/lib/api/strbuf.c
similarity index 97%
rename from tools/perf/util/strbuf.c
rename to tools/lib/api/strbuf.c
index a64a37628f12..4639b2d02e62 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/lib/api/strbuf.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "cache.h"
-#include "debug.h"
+#include "debug-internal.h"
 #include "strbuf.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -43,6 +42,7 @@ char *strbuf_detach(struct strbuf *sb, size_t *sz)
 	return res;
 }
 
+#define alloc_nr(x) (((x)+16)*3/2)
 int strbuf_grow(struct strbuf *sb, size_t extra)
 {
 	char *buf;
@@ -69,6 +69,7 @@ int strbuf_grow(struct strbuf *sb, size_t extra)
 	sb->alloc = nr;
 	return 0;
 }
+#undef alloc_nr
 
 int strbuf_addch(struct strbuf *sb, int c)
 {
diff --git a/tools/perf/util/strbuf.h b/tools/lib/api/strbuf.h
similarity index 100%
rename from tools/perf/util/strbuf.h
rename to tools/lib/api/strbuf.h
diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index 5a27691469ed..d8a8fcadb9ca 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -8,7 +8,7 @@
 #include "../util/stat.h"
 #include "../util/evlist.h"
 #include "../util/evsel.h"
-#include "../util/strbuf.h"
+#include <api/strbuf.h>
 #include "../util/record.h"
 #include "../util/parse-events.h"
 #include "internal/threadmap.h"
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 3976aebe3677..8874e1e0335b 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -6,7 +6,7 @@
  */
 #include "util/cache.h"
 #include "util/config.h"
-#include "util/strbuf.h"
+#include <api/strbuf.h>
 #include "builtin.h"
 #include <subcmd/exec-cmd.h>
 #include "common-cmds.h"
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 137d73edb541..ca52227f311c 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -17,7 +17,7 @@
 #include "util/metricgroup.h"
 #include "util/string2.h"
 #include "util/strlist.h"
-#include "util/strbuf.h"
+#include <api/strbuf.h>
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 79b9498886a2..5c68ab8c69f8 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -37,7 +37,6 @@ perf-y += libstring.o
 perf-y += bitmap.o
 perf-y += hweight.o
 perf-y += smt.o
-perf-y += strbuf.o
 perf-y += string.o
 perf-y += strlist.o
 perf-y += strfilter.o
diff --git a/tools/perf/util/cache.h b/tools/perf/util/cache.h
index 9f2e36ef5072..19e60decb24c 100644
--- a/tools/perf/util/cache.h
+++ b/tools/perf/util/cache.h
@@ -2,7 +2,7 @@
 #ifndef __PERF_CACHE_H
 #define __PERF_CACHE_H
 
-#include "strbuf.h"
+#include <api/strbuf.h>
 #include <subcmd/pager.h>
 #include "../ui/ui.h"
 
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index b07414409771..673ddfeb938d 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -9,7 +9,7 @@
 #include <stdlib.h>
 #include "debug.h"
 #include "dwarf-aux.h"
-#include "strbuf.h"
+#include <api/strbuf.h>
 #include "string2.h"
 
 /**
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 5b8cf6a421a4..3dc1c51a8335 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -10,7 +10,7 @@
 #include <sys/utsname.h>
 #include <stdlib.h>
 #include <string.h>
-#include "strbuf.h"
+#include <api/strbuf.h>
 
 struct perf_env perf_env;
 
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 404d816ca124..35067c22a47f 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -38,7 +38,7 @@
 #include "cpumap.h"
 #include "pmu.h"
 #include "vdso.h"
-#include "strbuf.h"
+#include <api/strbuf.h>
 #include "build-id.h"
 #include "data.h"
 #include <api/fs/fs.h>
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b9c273ed080a..d1d21605715a 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -9,7 +9,7 @@
 #include "debug.h"
 #include "evlist.h"
 #include "evsel.h"
-#include "strbuf.h"
+#include <api/strbuf.h>
 #include "pmu.h"
 #include "pmu-hybrid.h"
 #include "print-events.h"
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index ac3227ba769c..c82e7bc7c5ea 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -12,7 +12,7 @@
 #include "util/parse-events.h"
 #include "util/pmu.h"
 #include "util/pfm.h"
-#include "util/strbuf.h"
+#include <api/strbuf.h>
 
 #include <string.h>
 #include <linux/kernel.h>
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2bdeb89352e7..4648ccf0b50a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -27,7 +27,7 @@
 #include "print-events.h"
 #include "header.h"
 #include "string2.h"
-#include "strbuf.h"
+#include <api/strbuf.h>
 #include "fncache.h"
 #include "pmu-hybrid.h"
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 0c24bc7afbca..e609970e2113 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -38,7 +38,7 @@
 #include "probe-file.h"
 #include "session.h"
 #include "string2.h"
-#include "strbuf.h"
+#include <api/strbuf.h>
 
 #include <subcmd/pager.h>
 #include <linux/ctype.h>
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 3d50de3217d5..c1f1ef3f48d4 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -20,7 +20,7 @@
 #include "dso.h"
 #include "color.h"
 #include "symbol.h"
-#include "strbuf.h"
+#include <api/strbuf.h>
 #include <api/fs/tracing_path.h>
 #include <api/fs/fs.h>
 #include "probe-event.h"
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 54b49ce85c9f..4368a9dffc35 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -24,7 +24,7 @@
 #include "dso.h"
 #include "debug.h"
 #include "intlist.h"
-#include "strbuf.h"
+#include <api/strbuf.h>
 #include "strlist.h"
 #include "symbol.h"
 #include "probe-finder.h"
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e188f74698dd..32f00a340c0d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -21,7 +21,7 @@
 #include "evlist.h"
 #include "srcline.h"
 #include "strlist.h"
-#include "strbuf.h"
+#include <api/strbuf.h>
 #include "mem-events.h"
 #include "annotate.h"
 #include "event.h"
-- 
2.39.0.314.g84b9a713c41-goog

