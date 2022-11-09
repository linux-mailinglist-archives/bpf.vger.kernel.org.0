Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F49623302
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 19:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiKISvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 13:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKISvZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 13:51:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3663313FAF
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 10:51:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h4-20020a5b02c4000000b006bc192d672bso17636805ybp.22
        for <bpf@vger.kernel.org>; Wed, 09 Nov 2022 10:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sLyT/Gr9bkwApsNO104BHOJyfG2Scy1gd5V/ZkjXU8=;
        b=EXPYNDw8q5sMJw/9h7sXe54NaX+ABlrBG1Wkq3hZtn7Ly9uN7CJRP3sLwHDwmnARdX
         NUKekK7B9YJ6VUBNcmn/rOeUdBvy7RW/PLXTvopZRWHqpbh+5pXYy8iQyfOKfmp1srRh
         k5ZtFsZMK9cOdTujKz1D8zGojY+haXTOh8gGHObFlO4iLcTC7e5TII5AJ+YD2CWH29MG
         g+gqUe66dVtnGOsdBFEONBILr/BpnP7rMG5w2KIeg7i+csPdrqcW67ek2hD2JJ1YYCDq
         zj0gzDbNdDNIeL/CmiutymV23VmKicaFyhrv3F4ghu2BIX1essHFw2dCtlNs0RE25sqE
         7ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+sLyT/Gr9bkwApsNO104BHOJyfG2Scy1gd5V/ZkjXU8=;
        b=JXF6EIzROR6zHAZBLqB52tQWe62rGWwABXat54XYaPxyjS6uW8ev1AEjryo8TIhy1U
         QysjzyQFF0NQdzX3C1zURKNjoLEPnV4xt9vEKZQ2DM3PZi8XOOSqVCWWFKOMioqbB4d9
         zENLE19oOvnLaVrTtX7FzaLOgI28LmsDjs/gX0uwGJZ2gRr9O0cxa96RbPEBxvogQ0Vj
         4ub0W8UvzzTp4oiahRsiHLtz8Aw2kPB2ThgQKRUXbEX/05dG2iqctjyA0BODtUw1r5lO
         mBRt7KOmb7NQayxsQWiQEUBhuJTBlhWO3AQDoS+mu5gUomxwVDyK/vNSGBsbmBarc5/h
         R1FA==
X-Gm-Message-State: ANoB5pmqvEyjJdfh7w0YK8b4WQ3aQCs2XhiZqlz/8XAh5XuM/LNQhpYX
        grYKAdMSqMBVaFfxBeOacoh7dtuvVvvQ
X-Google-Smtp-Source: AA0mqf4HxDGA952FGpZO3fPfjGLbv9zXSjWQY5CePCx7XUHVmB1pNjrB3rDzlhFh2UsrbPTXX7k1tQCSGVMa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b06f:a254:5ce9:c442])
 (user=irogers job=sendgmr) by 2002:a81:19cb:0:b0:373:e88c:bc61 with SMTP id
 194-20020a8119cb000000b00373e88cbc61mr905833ywz.226.1668019865531; Wed, 09
 Nov 2022 10:51:05 -0800 (PST)
Date:   Wed,  9 Nov 2022 10:49:12 -0800
In-Reply-To: <20221109184914.1357295-1-irogers@google.com>
Message-Id: <20221109184914.1357295-13-irogers@google.com>
Mime-Version: 1.0
References: <20221109184914.1357295-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 12/14] perf thread_map: Reduce exposure of libperf internal API
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

Remove unnecessary include of internal threadmap.h and refcount.h in
thread_map.h. Switch to using public APIs when possible or including
the internal header file in the C file. Fix a transitive dependency in
openat-syscall.c broken by the clean up.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c                              | 1 +
 tools/perf/builtin-trace.c                             | 4 ++--
 tools/perf/tests/openat-syscall.c                      | 1 +
 tools/perf/tests/thread-map.c                          | 1 +
 tools/perf/util/bpf_counter.c                          | 2 +-
 tools/perf/util/evsel.c                                | 1 +
 tools/perf/util/python.c                               | 6 +++---
 tools/perf/util/scripting-engines/trace-event-python.c | 2 +-
 tools/perf/util/thread_map.c                           | 1 +
 tools/perf/util/thread_map.h                           | 2 --
 10 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d5e1670bca20..fb2d13650e42 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -93,6 +93,7 @@
 
 #include <linux/ctype.h>
 #include <perf/evlist.h>
+#include <internal/threadmap.h>
 
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"devices/cpu/freeze_on_smi"
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5690c33c523b..c554dd9bcfee 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4093,8 +4093,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	}
 
 	trace->multiple_threads = perf_thread_map__pid(evlist->core.threads, 0) == -1 ||
-				  evlist->core.threads->nr > 1 ||
-				  evlist__first(evlist)->core.attr.inherit;
+		perf_thread_map__nr(evlist->core.threads) > 1 ||
+		evlist__first(evlist)->core.attr.inherit;
 
 	/*
 	 * Now that we already used evsel->core.attr to ask the kernel to setup the
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 7e05b8b5cc95..131b62271bfa 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -7,6 +7,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
+#include <unistd.h>
 #include "thread_map.h"
 #include "evsel.h"
 #include "debug.h"
diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index e413c1387fcb..74308c1368fe 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -11,6 +11,7 @@
 #include "util/synthetic-events.h"
 #include <linux/zalloc.h>
 #include <perf/event.h>
+#include <internal/threadmap.h>
 
 struct perf_sample;
 struct perf_tool;
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ef1c15e4aeba..eeee899fcf34 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -561,7 +561,7 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 
 		if (filter_type == BPERF_FILTER_PID ||
 		    filter_type == BPERF_FILTER_TGID)
-			key = evsel->core.threads->map[i].pid;
+			key = perf_thread_map__pid(evsel->core.threads, i);
 		else if (filter_type == BPERF_FILTER_CPU)
 			key = evsel->core.cpus->map[i].cpu;
 		else
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2139e8b0e401..2e212ae73b9f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -53,6 +53,7 @@
 #include "util/parse-branch-options.h"
 #include <internal/xyarray.h>
 #include <internal/lib.h>
+#include <internal/threadmap.h>
 
 #include <linux/ctype.h>
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5be5fa2391de..b5941c74a0d6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -718,17 +718,17 @@ static Py_ssize_t pyrf_thread_map__length(PyObject *obj)
 {
 	struct pyrf_thread_map *pthreads = (void *)obj;
 
-	return pthreads->threads->nr;
+	return perf_thread_map__nr(pthreads->threads);
 }
 
 static PyObject *pyrf_thread_map__item(PyObject *obj, Py_ssize_t i)
 {
 	struct pyrf_thread_map *pthreads = (void *)obj;
 
-	if (i >= pthreads->threads->nr)
+	if (i >= perf_thread_map__nr(pthreads->threads))
 		return NULL;
 
-	return Py_BuildValue("i", pthreads->threads->map[i]);
+	return Py_BuildValue("i", perf_thread_map__pid(pthreads->threads, i));
 }
 
 static PySequenceMethods pyrf_thread_map__sequence_methods = {
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 1985d1a42a22..1cf65db8f861 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1654,7 +1654,7 @@ static void python_process_stat(struct perf_stat_config *config,
 	struct perf_cpu_map *cpus = counter->core.cpus;
 	int cpu, thread;
 
-	for (thread = 0; thread < threads->nr; thread++) {
+	for (thread = 0; thread < perf_thread_map__nr(threads); thread++) {
 		for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
 			process_stat(counter, perf_cpu_map__cpu(cpus, cpu),
 				     perf_thread_map__pid(threads, thread), tstamp,
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index c9bfe4696943..e848579e61a8 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -18,6 +18,7 @@
 #include "thread_map.h"
 #include "debug.h"
 #include "event.h"
+#include <internal/threadmap.h>
 
 /* Skip "." and ".." directories */
 static int filter(const struct dirent *dir)
diff --git a/tools/perf/util/thread_map.h b/tools/perf/util/thread_map.h
index 3bb860a32b8e..00ec05fc1656 100644
--- a/tools/perf/util/thread_map.h
+++ b/tools/perf/util/thread_map.h
@@ -4,8 +4,6 @@
 
 #include <sys/types.h>
 #include <stdio.h>
-#include <linux/refcount.h>
-#include <internal/threadmap.h>
 #include <perf/threadmap.h>
 
 struct perf_record_thread_map;
-- 
2.38.1.431.g37b22c650d-goog

