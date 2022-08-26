Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1C5A2C8D
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244764AbiHZQnG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343881AbiHZQnC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:43:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AE0DF66B
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:43:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33da75a471cso33282257b3.20
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=OGW6u/w8E7rtFoVCHl2hMelnGzxIW2OVOqfv9qQJktE=;
        b=TGQQ4SVdRMyECrYYp4Kt7qld0dy+4tSgWYiOultZ0CvS2F5gFmg7ZwGQ8BLh0CN0ex
         pigqjV1vrOGU9Azq5msrQVMojOOjt9xqvns4hJvY2F/1XE37B3DqEr7O7gh0/uk6wIP8
         3k6eelLXytmhZRCxAK9b7oItOUPfTACr/qnbjVmOjm9Ix0hO/09PeD4kIh0IdX37hoXq
         F34Eh8pvym1cheVDLK91TWf8OEvR9F8jFUnhrlP18BSon4SMw9hESQASxh07iBJKVI73
         y9+FGoGR3wL5k2FGcIjY8lY/mOM0w7WKmMcFv3bHJq0mzKb/ip1uUyFQoNN7XDFRJDMJ
         ccQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=OGW6u/w8E7rtFoVCHl2hMelnGzxIW2OVOqfv9qQJktE=;
        b=rBMfQbQ20SL+x7L9kfTuqfjlOj8FNFkhHg3fPYwsj4nUECq08MTx7svx05EO1nhcdL
         Zr+Wot0biN/EVfkFs2fhGjJXH4BVhPrOqc6oQQMEqJn2jlxm/moFO/nVkDk+pGM05vHL
         TqlLMR3jleFGrId71NnB7+GmIilpUQn5Lb783g7tInWYzHaTaNm/UE9IiKV4yADLj26f
         WDlTrkUPxhEkcpqSjy/ZxaSvZBAoLYzF3NKe4Nwdozw4u6gNy2x/DSLQ0xbozeUw5WD8
         afkUFr2gWx7T4JXgbyVleGKuHFLDLkhtKe/PRdrxGFHSeXua1BIF6ReTomnlEOItYLyK
         6b4Q==
X-Gm-Message-State: ACgBeo10rle6zOl0K0FC74IvFSaIYDDv61f0Qksk0mau7W/RSYzsxLhS
        b9vEDPu8NwYmNtHoFY0Hs5ZxWhwMsH12
X-Google-Smtp-Source: AA6agR5jwQs39a20cy3Z29YfirEvLxtmk7QoN98uryiBq7PDypA4w0OxnATHL6bXOYVYAVfVqOmmPIFKHMg4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a5b:6c1:0:b0:669:a7c3:4c33 with SMTP id
 r1-20020a5b06c1000000b00669a7c34c33mr460617ybq.543.1661532179892; Fri, 26 Aug
 2022 09:42:59 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:25 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-2-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 01/18] perf mutex: Wrapped usage of mutex and cond
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pavithra Gurushankar <gpavithrasha@gmail.com>

Added a new header file mutex.h that wraps the usage of
pthread_mutex_t and pthread_cond_t. By abstracting these it is
possible to introduce error checking.

Signed-off-by: Pavithra Gurushankar <gpavithrasha@gmail.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build   |   1 +
 tools/perf/util/mutex.c | 117 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mutex.h |  48 +++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 tools/perf/util/mutex.c
 create mode 100644 tools/perf/util/mutex.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 9dfae1bda9cc..8fd6dc8de521 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -143,6 +143,7 @@ perf-y += branch.o
 perf-y += mem2node.o
 perf-y += clockid.o
 perf-y += list_sort.o
+perf-y += mutex.o
 
 perf-$(CONFIG_LIBBPF) += bpf-loader.o
 perf-$(CONFIG_LIBBPF) += bpf_map.o
diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
new file mode 100644
index 000000000000..5029237164e5
--- /dev/null
+++ b/tools/perf/util/mutex.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "mutex.h"
+
+#include "debug.h"
+#include <linux/string.h>
+#include <errno.h>
+
+static void check_err(const char *fn, int err)
+{
+	char sbuf[STRERR_BUFSIZE];
+
+	if (err == 0)
+		return;
+
+	pr_err("%s error: '%s'\n", fn, str_error_r(err, sbuf, sizeof(sbuf)));
+}
+
+#define CHECK_ERR(err) check_err(__func__, err)
+
+static void __mutex_init(struct mutex *mtx, bool pshared)
+{
+	pthread_mutexattr_t attr;
+
+	CHECK_ERR(pthread_mutexattr_init(&attr));
+
+#ifndef NDEBUG
+	/* In normal builds enable error checking, such as recursive usage. */
+	CHECK_ERR(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK));
+#endif
+	if (pshared)
+		CHECK_ERR(pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
+
+	CHECK_ERR(pthread_mutex_init(&mtx->lock, &attr));
+	CHECK_ERR(pthread_mutexattr_destroy(&attr));
+}
+
+void mutex_init(struct mutex *mtx)
+{
+	__mutex_init(mtx, /*pshared=*/false);
+}
+
+void mutex_init_pshared(struct mutex *mtx)
+{
+	__mutex_init(mtx, /*pshared=*/true);
+}
+
+void mutex_destroy(struct mutex *mtx)
+{
+	CHECK_ERR(pthread_mutex_destroy(&mtx->lock));
+}
+
+void mutex_lock(struct mutex *mtx)
+{
+	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
+}
+
+void mutex_unlock(struct mutex *mtx)
+{
+	CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
+}
+
+bool mutex_trylock(struct mutex *mtx)
+{
+	int ret = pthread_mutex_trylock(&mtx->lock);
+
+	if (ret == 0)
+		return true; /* Lock acquired. */
+
+	if (ret == EBUSY)
+		return false; /* Lock busy. */
+
+	/* Print error. */
+	CHECK_ERR(ret);
+	return false;
+}
+
+static void __cond_init(struct cond *cnd, bool pshared)
+{
+	pthread_condattr_t attr;
+
+	CHECK_ERR(pthread_condattr_init(&attr));
+	if (pshared)
+		CHECK_ERR(pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED));
+
+	CHECK_ERR(pthread_cond_init(&cnd->cond, &attr));
+	CHECK_ERR(pthread_condattr_destroy(&attr));
+}
+
+void cond_init(struct cond *cnd)
+{
+	__cond_init(cnd, /*pshared=*/false);
+}
+
+void cond_init_pshared(struct cond *cnd)
+{
+	__cond_init(cnd, /*pshared=*/true);
+}
+
+void cond_destroy(struct cond *cnd)
+{
+	CHECK_ERR(pthread_cond_destroy(&cnd->cond));
+}
+
+void cond_wait(struct cond *cnd, struct mutex *mtx)
+{
+	CHECK_ERR(pthread_cond_wait(&cnd->cond, &mtx->lock));
+}
+
+void cond_signal(struct cond *cnd)
+{
+	CHECK_ERR(pthread_cond_signal(&cnd->cond));
+}
+
+void cond_broadcast(struct cond *cnd)
+{
+	CHECK_ERR(pthread_cond_broadcast(&cnd->cond));
+}
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
new file mode 100644
index 000000000000..cfff32a902d9
--- /dev/null
+++ b/tools/perf/util/mutex.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_MUTEX_H
+#define __PERF_MUTEX_H
+
+#include <pthread.h>
+#include <stdbool.h>
+
+/*
+ * A wrapper around the mutex implementation that allows perf to error check
+ * usage, etc.
+ */
+struct mutex {
+	pthread_mutex_t lock;
+};
+
+/* A wrapper around the condition variable implementation. */
+struct cond {
+	pthread_cond_t cond;
+};
+
+/* Default initialize the mtx struct. */
+void mutex_init(struct mutex *mtx);
+/*
+ * Initialize the mtx struct and set the process-shared rather than default
+ * process-private attribute.
+ */
+void mutex_init_pshared(struct mutex *mtx);
+void mutex_destroy(struct mutex *mtx);
+
+void mutex_lock(struct mutex *mtx);
+void mutex_unlock(struct mutex *mtx);
+/* Tries to acquire the lock and returns true on success. */
+bool mutex_trylock(struct mutex *mtx);
+
+/* Default initialize the cond struct. */
+void cond_init(struct cond *cnd);
+/*
+ * Initialize the cond struct and specify the process-shared rather than default
+ * process-private attribute.
+ */
+void cond_init_pshared(struct cond *cnd);
+void cond_destroy(struct cond *cnd);
+
+void cond_wait(struct cond *cnd, struct mutex *mtx);
+void cond_signal(struct cond *cnd);
+void cond_broadcast(struct cond *cnd);
+
+#endif /* __PERF_MUTEX_H */
-- 
2.37.2.672.g94769d06f0-goog

