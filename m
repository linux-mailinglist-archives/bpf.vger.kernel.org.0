Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22F659FE85
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiHXPjb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbiHXPja (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:39:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04C17FF83
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:39:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33da75a471cso29979347b3.20
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=++XG8O/XaqKk+21dlmEttl6X7NLCCkpk9VicaKU4kRo=;
        b=RNWZjC4x7qCmj+eMHBx8E9gRymYa/abrWXR0TPI4R+3Hdgtf6X/Rvre5qgXYwrEDsQ
         eUko0AYuxQ56ZM71nCU0yvQLlvg/hVJsj0JqgMWLKi8y6GPwtf1v/cQUg5f9c4PlTgWR
         Jz7YspEWpQulj+Ov7Z9P2q8ICRJYK5MAkwREhD4EPMtc/1QIwuU+wK0QhD7P0dvfSvj/
         XpABvv5RrxJk8eVg1iE4b0+M01scplVcK1VGV8wtY+PmeRnmgYXYxeCxVU6CcNaPMwZH
         v8/1IYxancXDMFMWpUQf0hzDgdTcBlOBk9inFF30osL8cvYvacEEOBl/UYb0NP4g6jm8
         wLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=++XG8O/XaqKk+21dlmEttl6X7NLCCkpk9VicaKU4kRo=;
        b=3Yg1jD3sH6WAv1MwhV2IiIRQ15diQXtn46HjOl3crScQpsC9abpy2IJa53P53LtMIW
         ujkBZ1P3Mz+cklaGql1zDRQz/O24zOazGcSJQIerNpSfOgAYeTAER2vkYhG0p54lzkxu
         dSe7GvgQVtfjfCJyUeJKJ8A1KlRPKuxzSfx6qdEWNnMEwouNHCbg+ou27GHei9BmXtIJ
         FQ1IE+MQpEOktt6KP5EvBVEdsq+ZnI+iAIY7Ele+SPSnxzZpxq8075FeN+dwQ1sEZRCI
         kRYY1H4p4t8PI9CZmx31/JWUp9ghXDB708a2Sn38boNW8O7mb1vAI1ge6pGU7/1TVTCq
         gVqg==
X-Gm-Message-State: ACgBeo2KnENnRRoESKuI+BbVnI9av8xaZ6f9a0uq07PKP8T+fqD6pGi2
        ispbHbQKbZF8fZM94CPX3p5Zupa2AYEZ
X-Google-Smtp-Source: AA6agR5FJRn8KG2WmSzsO9s1GlvF5t7+sXLv2G2zM9OWGN5Z3pYSc8avuTfsMReEF339vulPgYGOuJTyL37A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:7d81:0:b0:677:b27:40a4 with SMTP id
 y123-20020a257d81000000b006770b2740a4mr26319459ybc.589.1661355568028; Wed, 24
 Aug 2022 08:39:28 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:44 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-2-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 01/18] perf mutex: Wrapped usage of mutex and cond
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
 tools/perf/util/mutex.h |  47 ++++++++++++++++
 3 files changed, 165 insertions(+)
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
index 000000000000..892294ac1769
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
+	pr_err("%s error: '%s'", fn, str_error_r(err, sbuf, sizeof(sbuf)));
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
index 000000000000..c9e110a2b55e
--- /dev/null
+++ b/tools/perf/util/mutex.h
@@ -0,0 +1,47 @@
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
2.37.2.609.g9ff673ca1a-goog

