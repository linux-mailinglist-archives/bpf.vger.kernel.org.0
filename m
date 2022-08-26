Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5357B5A2C79
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbiHZQlr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiHZQlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:41:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023822F3B6
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:41:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3328a211611so33418527b3.5
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=ZGIJ7tERl/X5G2g/yFJuinw4oJjB76MF5S9q0o4IoVM=;
        b=Zpj6veHFDp4QaT6Cb9eFD/piPdme6q8M2U4alEDncSnImp3U6qpuko9PMtcxoefZkA
         42bReKC0Oq7zFPw73FLhBmDyzaJ/uyHD9VN0fvOPFeyhF5jjM2S1AwuBq/7441sJ1kUw
         z8OLVdXjO3nvDjQ7zvUJ/+GeJjq62XEkjKDp0VJcjwK/tp/iLmNi6yFusrox4rO+ZFdt
         JtO5duJPNWtFoB6k7VRjE3QoV7dCUUMMNcENe6KrWEgHeCxPXGk3APbaXqkZtS/DTZGe
         bB4XzQTi6lzgdtFfwIMjz+6fEc0DsXgV6lrZC/YRdLx7Fu3wZktFvgvi2otC/WJc9+xV
         ctwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ZGIJ7tERl/X5G2g/yFJuinw4oJjB76MF5S9q0o4IoVM=;
        b=7QcFzUTLf5kE8s1eOYLAPmPaSQslaU4YsfMLdlqMLO8gFjVeeJw7iHtcgLff1TZlja
         DyOz05Tvnrum7VmG6pXxTaho7G7IwRbpTyaKfGJlQp3CDm23crWmoc3FpAIOPjSEcp/a
         IilTAvooTy8hdCVXz4b1fVQSLYi0kSxkynKYxf1on4hLHG1O8YZ0mPjKHQQ/ZabU/Lrc
         BgAR0oucOtw93iVhMQUNrdbqlscYLak0YjOO2A1tB8HSlOnrJPQSzYpI/u26n/MGJSdv
         1uCqYG8HicdMnximh6yvDRTqixaVSkiJd2f1VT/NtfDsN47aZqNlFYc0uEEPlXQt58zQ
         69oQ==
X-Gm-Message-State: ACgBeo1WbnUrsN4U1TZ0zZwP71ZFtjDAdAny0aHbwQNENosIF2y3jb6s
        1PT60xVcwSIaguprdtQZdxgM1GKLBTEq
X-Google-Smtp-Source: AA6agR6ZYgSGJifVBqwUVhMoqIahzzC2+wtgishtSvy8Lq4rTsq04nY1jYDjImPeDiS7kuoqVlFxp5SdzOGx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a25:f50b:0:b0:695:a128:1f8a with SMTP id
 a11-20020a25f50b000000b00695a1281f8amr482576ybe.576.1661532102254; Fri, 26
 Aug 2022 09:41:42 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:40:11 -0700
In-Reply-To: <20220826164027.42929-1-irogers@google.com>
Message-Id: <20220826164027.42929-3-irogers@google.com>
Mime-Version: 1.0
References: <20220826164027.42929-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 02/18] perf bench: Update use of pthread mutex/cond
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

Switch to the use of mutex wrappers that provide better error checking.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/epoll-ctl.c           | 33 ++++-----
 tools/perf/bench/epoll-wait.c          | 33 ++++-----
 tools/perf/bench/futex-hash.c          | 33 ++++-----
 tools/perf/bench/futex-lock-pi.c       | 33 ++++-----
 tools/perf/bench/futex-requeue.c       | 33 ++++-----
 tools/perf/bench/futex-wake-parallel.c | 33 ++++-----
 tools/perf/bench/futex-wake.c          | 33 ++++-----
 tools/perf/bench/numa.c                | 93 ++++++++++----------------
 8 files changed, 153 insertions(+), 171 deletions(-)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 4256dc5d6236..521d1ff97b06 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -23,6 +23,7 @@
 #include <sys/eventfd.h>
 #include <perf/cpumap.h>
 
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
@@ -58,10 +59,10 @@ static unsigned int nested = 0;
 /* amount of fds to monitor, per thread */
 static unsigned int nfds = 64;
 
-static pthread_mutex_t thread_lock;
+static struct mutex thread_lock;
 static unsigned int threads_starting;
 static struct stats all_stats[EPOLL_NR_OPS];
-static pthread_cond_t thread_parent, thread_worker;
+static struct cond thread_parent, thread_worker;
 
 struct worker {
 	int tid;
@@ -174,12 +175,12 @@ static void *workerfn(void *arg)
 	struct timespec ts = { .tv_sec = 0,
 			       .tv_nsec = 250 };
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	/* Let 'em loose */
 	do {
@@ -367,9 +368,9 @@ int bench_epoll_ctl(int argc, const char **argv)
 	for (i = 0; i < EPOLL_NR_OPS; i++)
 		init_stats(&all_stats[i]);
 
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock);
+	cond_init(&thread_parent);
+	cond_init(&thread_worker);
 
 	threads_starting = nthreads;
 
@@ -377,11 +378,11 @@ int bench_epoll_ctl(int argc, const char **argv)
 
 	do_threads(worker, cpu);
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	while (threads_starting)
-		pthread_cond_wait(&thread_parent, &thread_lock);
-	pthread_cond_broadcast(&thread_worker);
-	pthread_mutex_unlock(&thread_lock);
+		cond_wait(&thread_parent, &thread_lock);
+	cond_broadcast(&thread_worker);
+	mutex_unlock(&thread_lock);
 
 	sleep(nsecs);
 	toggle_done(0, NULL, NULL);
@@ -394,9 +395,9 @@ int bench_epoll_ctl(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 
 	for (i = 0; i < nthreads; i++) {
 		unsigned long t[EPOLL_NR_OPS];
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 2728b0140853..c1cdf03c075d 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -79,6 +79,7 @@
 #include <perf/cpumap.h>
 
 #include "../util/stat.h"
+#include "../util/mutex.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
 
@@ -109,10 +110,10 @@ static bool multiq; /* use an epoll instance per thread */
 /* amount of fds to monitor, per thread */
 static unsigned int nfds = 64;
 
-static pthread_mutex_t thread_lock;
+static struct mutex thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
-static pthread_cond_t thread_parent, thread_worker;
+static struct cond thread_parent, thread_worker;
 
 struct worker {
 	int tid;
@@ -189,12 +190,12 @@ static void *workerfn(void *arg)
 	int to = nonblocking? 0 : -1;
 	int efd = multiq ? w->epollfd : epollfd;
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	do {
 		/*
@@ -485,9 +486,9 @@ int bench_epoll_wait(int argc, const char **argv)
 	       getpid(), nthreads, oneshot ? " (EPOLLONESHOT semantics)": "", nfds, nsecs);
 
 	init_stats(&throughput_stats);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock);
+	cond_init(&thread_parent);
+	cond_init(&thread_worker);
 
 	threads_starting = nthreads;
 
@@ -495,11 +496,11 @@ int bench_epoll_wait(int argc, const char **argv)
 
 	do_threads(worker, cpu);
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	while (threads_starting)
-		pthread_cond_wait(&thread_parent, &thread_lock);
-	pthread_cond_broadcast(&thread_worker);
-	pthread_mutex_unlock(&thread_lock);
+		cond_wait(&thread_parent, &thread_lock);
+	cond_broadcast(&thread_worker);
+	mutex_unlock(&thread_lock);
 
 	/*
 	 * At this point the workers should be blocked waiting for read events
@@ -522,9 +523,9 @@ int bench_epoll_wait(int argc, const char **argv)
 		err(EXIT_FAILURE, "pthread_join");
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 
 	/* sort the array back before reporting */
 	if (randomize)
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index f05db4cf983d..2005a3fa3026 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -23,6 +23,7 @@
 #include <sys/mman.h>
 #include <perf/cpumap.h>
 
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include "bench.h"
@@ -34,10 +35,10 @@ static bool done = false;
 static int futex_flag = 0;
 
 struct timeval bench__start, bench__end, bench__runtime;
-static pthread_mutex_t thread_lock;
+static struct mutex thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
-static pthread_cond_t thread_parent, thread_worker;
+static struct cond thread_parent, thread_worker;
 
 struct worker {
 	int tid;
@@ -73,12 +74,12 @@ static void *workerfn(void *arg)
 	unsigned int i;
 	unsigned long ops = w->ops; /* avoid cacheline bouncing */
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	do {
 		for (i = 0; i < params.nfutexes; i++, ops++) {
@@ -165,9 +166,9 @@ int bench_futex_hash(int argc, const char **argv)
 	       getpid(), params.nthreads, params.nfutexes, params.fshared ? "shared":"private", params.runtime);
 
 	init_stats(&throughput_stats);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock);
+	cond_init(&thread_parent);
+	cond_init(&thread_worker);
 
 	threads_starting = params.nthreads;
 	pthread_attr_init(&thread_attr);
@@ -203,11 +204,11 @@ int bench_futex_hash(int argc, const char **argv)
 	CPU_FREE(cpuset);
 	pthread_attr_destroy(&thread_attr);
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	while (threads_starting)
-		pthread_cond_wait(&thread_parent, &thread_lock);
-	pthread_cond_broadcast(&thread_worker);
-	pthread_mutex_unlock(&thread_lock);
+		cond_wait(&thread_parent, &thread_lock);
+	cond_broadcast(&thread_worker);
+	mutex_unlock(&thread_lock);
 
 	sleep(params.runtime);
 	toggle_done(0, NULL, NULL);
@@ -219,9 +220,9 @@ int bench_futex_hash(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 
 	for (i = 0; i < params.nthreads; i++) {
 		unsigned long t = bench__runtime.tv_sec > 0 ?
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 0abb3f7ee24f..2d0417949727 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -8,6 +8,7 @@
 #include <pthread.h>
 
 #include <signal.h>
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include <linux/compiler.h>
@@ -34,10 +35,10 @@ static u_int32_t global_futex = 0;
 static struct worker *worker;
 static bool done = false;
 static int futex_flag = 0;
-static pthread_mutex_t thread_lock;
+static struct mutex thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
-static pthread_cond_t thread_parent, thread_worker;
+static struct cond thread_parent, thread_worker;
 
 static struct bench_futex_parameters params = {
 	.runtime  = 10,
@@ -83,12 +84,12 @@ static void *workerfn(void *arg)
 	struct worker *w = (struct worker *) arg;
 	unsigned long ops = w->ops;
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	do {
 		int ret;
@@ -197,9 +198,9 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	       getpid(), params.nthreads, params.runtime);
 
 	init_stats(&throughput_stats);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock);
+	cond_init(&thread_parent);
+	cond_init(&thread_worker);
 
 	threads_starting = params.nthreads;
 	pthread_attr_init(&thread_attr);
@@ -208,11 +209,11 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	create_threads(worker, thread_attr, cpu);
 	pthread_attr_destroy(&thread_attr);
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	while (threads_starting)
-		pthread_cond_wait(&thread_parent, &thread_lock);
-	pthread_cond_broadcast(&thread_worker);
-	pthread_mutex_unlock(&thread_lock);
+		cond_wait(&thread_parent, &thread_lock);
+	cond_broadcast(&thread_worker);
+	mutex_unlock(&thread_lock);
 
 	sleep(params.runtime);
 	toggle_done(0, NULL, NULL);
@@ -224,9 +225,9 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 
 	for (i = 0; i < params.nthreads; i++) {
 		unsigned long t = bench__runtime.tv_sec > 0 ?
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index b6faabfafb8e..69ad896f556c 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -15,6 +15,7 @@
 #include <pthread.h>
 
 #include <signal.h>
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include <linux/compiler.h>
@@ -34,8 +35,8 @@ static u_int32_t futex1 = 0, futex2 = 0;
 
 static pthread_t *worker;
 static bool done = false;
-static pthread_mutex_t thread_lock;
-static pthread_cond_t thread_parent, thread_worker;
+static struct mutex thread_lock;
+static struct cond thread_parent, thread_worker;
 static struct stats requeuetime_stats, requeued_stats;
 static unsigned int threads_starting;
 static int futex_flag = 0;
@@ -82,12 +83,12 @@ static void *workerfn(void *arg __maybe_unused)
 {
 	int ret;
 
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	while (1) {
 		if (!params.pi) {
@@ -209,9 +210,9 @@ int bench_futex_requeue(int argc, const char **argv)
 	init_stats(&requeued_stats);
 	init_stats(&requeuetime_stats);
 	pthread_attr_init(&thread_attr);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock);
+	cond_init(&thread_parent);
+	cond_init(&thread_worker);
 
 	for (j = 0; j < bench_repeat && !done; j++) {
 		unsigned int nrequeued = 0, wakeups = 0;
@@ -221,11 +222,11 @@ int bench_futex_requeue(int argc, const char **argv)
 		block_threads(worker, thread_attr, cpu);
 
 		/* make sure all threads are already blocked */
-		pthread_mutex_lock(&thread_lock);
+		mutex_lock(&thread_lock);
 		while (threads_starting)
-			pthread_cond_wait(&thread_parent, &thread_lock);
-		pthread_cond_broadcast(&thread_worker);
-		pthread_mutex_unlock(&thread_lock);
+			cond_wait(&thread_parent, &thread_lock);
+		cond_broadcast(&thread_worker);
+		mutex_unlock(&thread_lock);
 
 		usleep(100000);
 
@@ -297,9 +298,9 @@ int bench_futex_requeue(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 	pthread_attr_destroy(&thread_attr);
 
 	print_summary();
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index e47f46a3a47e..6682e49d0ee0 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -10,6 +10,7 @@
 #include "bench.h"
 #include <linux/compiler.h>
 #include "../util/debug.h"
+#include "../util/mutex.h"
 
 #ifndef HAVE_PTHREAD_BARRIER
 int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe_unused)
@@ -49,8 +50,8 @@ static u_int32_t futex = 0;
 
 static pthread_t *blocked_worker;
 static bool done = false;
-static pthread_mutex_t thread_lock;
-static pthread_cond_t thread_parent, thread_worker;
+static struct mutex thread_lock;
+static struct cond thread_parent, thread_worker;
 static pthread_barrier_t barrier;
 static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
@@ -125,12 +126,12 @@ static void wakeup_threads(struct thread_data *td, pthread_attr_t thread_attr)
 
 static void *blocked_workerfn(void *arg __maybe_unused)
 {
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	while (1) { /* handle spurious wakeups */
 		if (futex_wait(&futex, 0, NULL, futex_flag) != EINTR)
@@ -294,9 +295,9 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	init_stats(&waketime_stats);
 
 	pthread_attr_init(&thread_attr);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock);
+	cond_init(&thread_parent);
+	cond_init(&thread_worker);
 
 	for (j = 0; j < bench_repeat && !done; j++) {
 		waking_worker = calloc(params.nwakes, sizeof(*waking_worker));
@@ -307,11 +308,11 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		block_threads(blocked_worker, thread_attr, cpu);
 
 		/* make sure all threads are already blocked */
-		pthread_mutex_lock(&thread_lock);
+		mutex_lock(&thread_lock);
 		while (threads_starting)
-			pthread_cond_wait(&thread_parent, &thread_lock);
-		pthread_cond_broadcast(&thread_worker);
-		pthread_mutex_unlock(&thread_lock);
+			cond_wait(&thread_parent, &thread_lock);
+		cond_broadcast(&thread_worker);
+		mutex_unlock(&thread_lock);
 
 		usleep(100000);
 
@@ -332,9 +333,9 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 	pthread_attr_destroy(&thread_attr);
 
 	print_summary();
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 201a3555f09a..9ecab6620a87 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -14,6 +14,7 @@
 #include <pthread.h>
 
 #include <signal.h>
+#include "../util/mutex.h"
 #include "../util/stat.h"
 #include <subcmd/parse-options.h>
 #include <linux/compiler.h>
@@ -34,8 +35,8 @@ static u_int32_t futex1 = 0;
 
 static pthread_t *worker;
 static bool done = false;
-static pthread_mutex_t thread_lock;
-static pthread_cond_t thread_parent, thread_worker;
+static struct mutex thread_lock;
+static struct cond thread_parent, thread_worker;
 static struct stats waketime_stats, wakeup_stats;
 static unsigned int threads_starting;
 static int futex_flag = 0;
@@ -65,12 +66,12 @@ static const char * const bench_futex_wake_usage[] = {
 
 static void *workerfn(void *arg __maybe_unused)
 {
-	pthread_mutex_lock(&thread_lock);
+	mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
-		pthread_cond_signal(&thread_parent);
-	pthread_cond_wait(&thread_worker, &thread_lock);
-	pthread_mutex_unlock(&thread_lock);
+		cond_signal(&thread_parent);
+	cond_wait(&thread_worker, &thread_lock);
+	mutex_unlock(&thread_lock);
 
 	while (1) {
 		if (futex_wait(&futex1, 0, NULL, futex_flag) != EINTR)
@@ -178,9 +179,9 @@ int bench_futex_wake(int argc, const char **argv)
 	init_stats(&wakeup_stats);
 	init_stats(&waketime_stats);
 	pthread_attr_init(&thread_attr);
-	pthread_mutex_init(&thread_lock, NULL);
-	pthread_cond_init(&thread_parent, NULL);
-	pthread_cond_init(&thread_worker, NULL);
+	mutex_init(&thread_lock);
+	cond_init(&thread_parent);
+	cond_init(&thread_worker);
 
 	for (j = 0; j < bench_repeat && !done; j++) {
 		unsigned int nwoken = 0;
@@ -190,11 +191,11 @@ int bench_futex_wake(int argc, const char **argv)
 		block_threads(worker, thread_attr, cpu);
 
 		/* make sure all threads are already blocked */
-		pthread_mutex_lock(&thread_lock);
+		mutex_lock(&thread_lock);
 		while (threads_starting)
-			pthread_cond_wait(&thread_parent, &thread_lock);
-		pthread_cond_broadcast(&thread_worker);
-		pthread_mutex_unlock(&thread_lock);
+			cond_wait(&thread_parent, &thread_lock);
+		cond_broadcast(&thread_worker);
+		mutex_unlock(&thread_lock);
 
 		usleep(100000);
 
@@ -224,9 +225,9 @@ int bench_futex_wake(int argc, const char **argv)
 	}
 
 	/* cleanup & report results */
-	pthread_cond_destroy(&thread_parent);
-	pthread_cond_destroy(&thread_worker);
-	pthread_mutex_destroy(&thread_lock);
+	cond_destroy(&thread_parent);
+	cond_destroy(&thread_worker);
+	mutex_destroy(&thread_lock);
 	pthread_attr_destroy(&thread_attr);
 
 	print_summary();
diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 20eed1e53f80..e78dedf9e682 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -6,8 +6,6 @@
  */
 
 #include <inttypes.h>
-/* For the CLR_() macros */
-#include <pthread.h>
 
 #include <subcmd/parse-options.h>
 #include "../util/cloexec.h"
@@ -35,6 +33,7 @@
 #include <linux/zalloc.h>
 
 #include "../util/header.h"
+#include "../util/mutex.h"
 #include <numa.h>
 #include <numaif.h>
 
@@ -67,7 +66,7 @@ struct thread_data {
 	u64			system_time_ns;
 	u64			user_time_ns;
 	double			speed_gbs;
-	pthread_mutex_t		*process_lock;
+	struct mutex		*process_lock;
 };
 
 /* Parameters set by options: */
@@ -137,16 +136,16 @@ struct params {
 struct global_info {
 	u8			*data;
 
-	pthread_mutex_t		startup_mutex;
-	pthread_cond_t		startup_cond;
+	struct mutex		startup_mutex;
+	struct cond		startup_cond;
 	int			nr_tasks_started;
 
-	pthread_mutex_t		start_work_mutex;
-	pthread_cond_t		start_work_cond;
+	struct mutex		start_work_mutex;
+	struct cond		start_work_cond;
 	int			nr_tasks_working;
 	bool			start_work;
 
-	pthread_mutex_t		stop_work_mutex;
+	struct mutex		stop_work_mutex;
 	u64			bytes_done;
 
 	struct thread_data	*threads;
@@ -524,30 +523,6 @@ static void * setup_private_data(ssize_t bytes)
 	return alloc_data(bytes, MAP_PRIVATE, 0, g->p.init_cpu0,  g->p.thp, g->p.init_random);
 }
 
-/*
- * Return a process-shared (global) mutex:
- */
-static void init_global_mutex(pthread_mutex_t *mutex)
-{
-	pthread_mutexattr_t attr;
-
-	pthread_mutexattr_init(&attr);
-	pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
-	pthread_mutex_init(mutex, &attr);
-}
-
-/*
- * Return a process-shared (global) condition variable:
- */
-static void init_global_cond(pthread_cond_t *cond)
-{
-	pthread_condattr_t attr;
-
-	pthread_condattr_init(&attr);
-	pthread_condattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
-	pthread_cond_init(cond, &attr);
-}
-
 static int parse_cpu_list(const char *arg)
 {
 	p0.cpu_list_str = strdup(arg);
@@ -1220,22 +1195,22 @@ static void *worker_thread(void *__tdata)
 	}
 
 	if (g->p.serialize_startup) {
-		pthread_mutex_lock(&g->startup_mutex);
+		mutex_lock(&g->startup_mutex);
 		g->nr_tasks_started++;
 		/* The last thread wakes the main process. */
 		if (g->nr_tasks_started == g->p.nr_tasks)
-			pthread_cond_signal(&g->startup_cond);
+			cond_signal(&g->startup_cond);
 
-		pthread_mutex_unlock(&g->startup_mutex);
+		mutex_unlock(&g->startup_mutex);
 
 		/* Here we will wait for the main process to start us all at once: */
-		pthread_mutex_lock(&g->start_work_mutex);
+		mutex_lock(&g->start_work_mutex);
 		g->start_work = false;
 		g->nr_tasks_working++;
 		while (!g->start_work)
-			pthread_cond_wait(&g->start_work_cond, &g->start_work_mutex);
+			cond_wait(&g->start_work_cond, &g->start_work_mutex);
 
-		pthread_mutex_unlock(&g->start_work_mutex);
+		mutex_unlock(&g->start_work_mutex);
 	}
 
 	gettimeofday(&start0, NULL);
@@ -1254,17 +1229,17 @@ static void *worker_thread(void *__tdata)
 		val += do_work(thread_data,  g->p.bytes_thread,  0,          1,		l, val);
 
 		if (g->p.sleep_usecs) {
-			pthread_mutex_lock(td->process_lock);
+			mutex_lock(td->process_lock);
 			usleep(g->p.sleep_usecs);
-			pthread_mutex_unlock(td->process_lock);
+			mutex_unlock(td->process_lock);
 		}
 		/*
 		 * Amount of work to be done under a process-global lock:
 		 */
 		if (g->p.bytes_process_locked) {
-			pthread_mutex_lock(td->process_lock);
+			mutex_lock(td->process_lock);
 			val += do_work(process_data, g->p.bytes_process_locked, thread_nr,  g->p.nr_threads,	l, val);
-			pthread_mutex_unlock(td->process_lock);
+			mutex_unlock(td->process_lock);
 		}
 
 		work_done = g->p.bytes_global + g->p.bytes_process +
@@ -1361,9 +1336,9 @@ static void *worker_thread(void *__tdata)
 
 	free_data(thread_data, g->p.bytes_thread);
 
-	pthread_mutex_lock(&g->stop_work_mutex);
+	mutex_lock(&g->stop_work_mutex);
 	g->bytes_done += bytes_done;
-	pthread_mutex_unlock(&g->stop_work_mutex);
+	mutex_unlock(&g->stop_work_mutex);
 
 	return NULL;
 }
@@ -1373,7 +1348,7 @@ static void *worker_thread(void *__tdata)
  */
 static void worker_process(int process_nr)
 {
-	pthread_mutex_t process_lock;
+	struct mutex process_lock;
 	struct thread_data *td;
 	pthread_t *pthreads;
 	u8 *process_data;
@@ -1381,7 +1356,7 @@ static void worker_process(int process_nr)
 	int ret;
 	int t;
 
-	pthread_mutex_init(&process_lock, NULL);
+	mutex_init(&process_lock);
 	set_taskname("process %d", process_nr);
 
 	/*
@@ -1540,11 +1515,11 @@ static int init(void)
 	g->data = setup_shared_data(g->p.bytes_global);
 
 	/* Startup serialization: */
-	init_global_mutex(&g->start_work_mutex);
-	init_global_cond(&g->start_work_cond);
-	init_global_mutex(&g->startup_mutex);
-	init_global_cond(&g->startup_cond);
-	init_global_mutex(&g->stop_work_mutex);
+	mutex_init_pshared(&g->start_work_mutex);
+	cond_init_pshared(&g->start_work_cond);
+	mutex_init_pshared(&g->startup_mutex);
+	cond_init_pshared(&g->startup_cond);
+	mutex_init_pshared(&g->stop_work_mutex);
 
 	init_thread_data();
 
@@ -1633,17 +1608,17 @@ static int __bench_numa(const char *name)
 		 * Wait for all the threads to start up. The last thread will
 		 * signal this process.
 		 */
-		pthread_mutex_lock(&g->startup_mutex);
+		mutex_lock(&g->startup_mutex);
 		while (g->nr_tasks_started != g->p.nr_tasks)
-			pthread_cond_wait(&g->startup_cond, &g->startup_mutex);
+			cond_wait(&g->startup_cond, &g->startup_mutex);
 
-		pthread_mutex_unlock(&g->startup_mutex);
+		mutex_unlock(&g->startup_mutex);
 
 		/* Wait for all threads to be at the start_work_cond. */
 		while (!threads_ready) {
-			pthread_mutex_lock(&g->start_work_mutex);
+			mutex_lock(&g->start_work_mutex);
 			threads_ready = (g->nr_tasks_working == g->p.nr_tasks);
-			pthread_mutex_unlock(&g->start_work_mutex);
+			mutex_unlock(&g->start_work_mutex);
 			if (!threads_ready)
 				usleep(1);
 		}
@@ -1661,10 +1636,10 @@ static int __bench_numa(const char *name)
 
 		start = stop;
 		/* Start all threads running. */
-		pthread_mutex_lock(&g->start_work_mutex);
+		mutex_lock(&g->start_work_mutex);
 		g->start_work = true;
-		pthread_mutex_unlock(&g->start_work_mutex);
-		pthread_cond_broadcast(&g->start_work_cond);
+		mutex_unlock(&g->start_work_mutex);
+		cond_broadcast(&g->start_work_cond);
 	} else {
 		gettimeofday(&start, NULL);
 	}
-- 
2.37.2.672.g94769d06f0-goog

