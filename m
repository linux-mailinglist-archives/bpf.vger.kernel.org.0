Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54747620A58
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 08:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiKHHhk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 02:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbiKHHhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 02:37:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A6431F82
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 23:37:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368994f4bc0so129239977b3.14
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 23:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcIKP47y+JSPnlG86ZitTgFKXbNZnIlDlaeWOyIniEY=;
        b=BMEqfqsjTeaurfuCtzDjeW0q1DlJjsXAbVlSiJWF6mS4cGaDikyIVmW7hXbUkRIkPW
         UvWAdu2eu24JqRTfL0s+jvV5dTXwHqNOq9TIUN9qMWufZJfLai2rq51rnM92BzwNufQ9
         Aw3eqRg7nFANy08wGWjKnI3o/1l48dQ36o+G7IpZ9i0EWrwoB84wfu05aAFalfhT8Yma
         HMUnB9GWxsHH9jUcZKCKj5gGbAwrrNiudjy72wClI37rzGIw6Zjd27IA4VUF9cVbRUOe
         NunT5LBVtrED8jJM8ywv+7FzBrvbug7O2c8iZDwIfmozF2NCetrmb1eR0bcZOk/4Q0G4
         ilSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcIKP47y+JSPnlG86ZitTgFKXbNZnIlDlaeWOyIniEY=;
        b=TTmI28hzq+xyYc6zUXqXwdnqcMxEaQ/3cQVgR2tgyb06zlqjmtS3Kr27p3qCt4Rqnx
         yJuHGWXYvlFyneQ5yhQEd2DjOm/AWEGxJ/lPXo4iB/zQ8cjptEb5N9R09gywKZAJUSqM
         eD5NDQAgNK+b+M/v50yEyoJhIySXXBs87gVA5VwkU5rCJfPkjO3gSSnsr8lIXD8q/JSs
         1hYKLp/ra1GQjzsDmRI6PscpjT1hJ6B6uTzhPO2tgu8t54JiYwDjYJjyZIY4/Gxpolvz
         VRu+krkKXo+edAwqG1XojYxEMHmPgCCdjDlgip3DbnnZ2QW0ZUOBM6SE/inGQPuPsEid
         SxGQ==
X-Gm-Message-State: ACrzQf1WX64eZHWCm2/6OO172lRZQtwblG1cKr5W+6HAQ5yHwtXjMFFR
        C9490VMcf/sGPuw+61Jo3GxbcqqmAl6N
X-Google-Smtp-Source: AMsMyM6xWmGhmC5MCqpSz2YJlSOjNiIyqOdAAuhd9e4WmFKqwSZGGU1jUpNIbBlfN8J7bqFiaAWwVwmQvBQs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a697:9013:186f:ed07])
 (user=irogers job=sendgmr) by 2002:a0d:c481:0:b0:370:7a9a:564 with SMTP id
 g123-20020a0dc481000000b003707a9a0564mr863517ywd.278.1667893028204; Mon, 07
 Nov 2022 23:37:08 -0800 (PST)
Date:   Mon,  7 Nov 2022 23:35:16 -0800
In-Reply-To: <20221108073518.1154450-1-irogers@google.com>
Message-Id: <20221108073518.1154450-13-irogers@google.com>
Mime-Version: 1.0
References: <20221108073518.1154450-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 12/14] perf thread_map: Reduce exposure of libperf internal API
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
index 72991528687e..b403f3fab2a4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4092,8 +4092,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
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

