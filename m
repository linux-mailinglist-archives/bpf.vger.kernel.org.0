Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC9A5A2C74
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiHZQk5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbiHZQkz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:40:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C89D1C930
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:40:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-340862314d9so18301687b3.3
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=OGW6u/w8E7rtFoVCHl2hMelnGzxIW2OVOqfv9qQJktE=;
        b=Us5VjbWSTTYWTUWhMO9QVkqK75L6jBcCi16bdVeorKHLmtT0O5D6vIzNnOxkBi+sKT
         Kxg24QY04c6r7tNyxiAD+DNwLXbZp5huo5+VXagaSrKd6VlWmoye8ZI3flUpKTV86EUD
         OBpnraCaGGzi8cG2JouBOrg63br6SrePVnRpzPCmTBpF8j+L5qKGGFeE02HudTcsSH9h
         ETs/6+fUeIygYPrXqQkb0WXTbZkSz/r5d1FmtF+ylURcXRaFnf+U6RN5ZF4PK0nlPz8l
         lQWUTI+b6i3gknhkGf8oSMlxfjW50S/Jph1MHQyud46ephTT7OL4vv3se4oNYSIeDF8m
         3yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=OGW6u/w8E7rtFoVCHl2hMelnGzxIW2OVOqfv9qQJktE=;
        b=szIlvGbHUh00PsohQD+YbUdS3ZfhaynG4A0/mm3ZQaDsne8AH1Bh9JutG7UY3rfJY9
         L9uw0zVWjRkplYT7kPDyJ2k7DjR+ylxT3sBiAoaDmkaiwEQtnOrgeFjx3CBUE2Qtw42v
         EbyyJisVISkRo6jQKia0VVFNb/U9dhUzHWgXxq+4AibfxSWT1FLD2iBRpHQ0kdtyyWLJ
         SnuhUkklObuLXFuxyW5SxXlBDqlNDVKwVzAQ+I7gaaqpyROeD7+Am4zl/GxCRIIXSpwe
         RdNbvn8WeufJ9u9JTiGfJcJd1gs4bqdRns8loDweDU72hez5B46+zmqMJ/bOtN36Y3HP
         ENTA==
X-Gm-Message-State: ACgBeo39aLMOETK0X83YzW/Zdj5Dkchq4aOd0g47RBoQGx9NsJ+CYAN+
        twATsE3hPb8kWOK5VvmIb72wbnxkkXgW
X-Google-Smtp-Source: AA6agR7ACSGk8a4B4SYUIPDiyv+IvwuRMOpPIzYnR5Pdpg5EGNHHAIX7sG/1uSiMSFQJXGxypQPIE3kyzxwM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a5b:401:0:b0:696:48ef:d1ab with SMTP id
 m1-20020a5b0401000000b0069648efd1abmr506277ybp.338.1661532051744; Fri, 26 Aug
 2022 09:40:51 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:40:10 -0700
In-Reply-To: <20220826164027.42929-1-irogers@google.com>
Message-Id: <20220826164027.42929-2-irogers@google.com>
Mime-Version: 1.0
References: <20220826164027.42929-1-irogers@google.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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

