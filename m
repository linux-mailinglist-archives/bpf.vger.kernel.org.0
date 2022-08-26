Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C555A2CBA
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344706AbiHZQrC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344427AbiHZQqU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:46:20 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7E27CFA
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:45:22 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3363b1dffa0so33061597b3.23
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=O8Qr4u2Ex+vGQYNxrAO3WvQT1T8a47855lT6UekNsbk=;
        b=akb+9dSb467cjd2G9Apq4JRbepx097HVchmRbRbAH+zwl1beW1vL1eBXVIRJ+8ulQl
         z61OTSCYkQBJJuGHOX/DqMTSBgtjdvdFPWd6NxEV8vQMKPDmE1zLMCBiMFgYpbUKyH++
         rQCbXuxVP2vPL8CBkwM+4+bvtsGbU61t7t5I0uXChM8FaAOyeGk8mwYEO5hwOsksI2MP
         ywmrudXhK4qZAXgs92mlQq8hxj5ZR2rwyfLIvFtCWWBLNMFWoL2K05OQaIuuJ1zgWjPH
         HL2TNXtvTFmZIL4XVHJRMFdVwQfwY4yDaj/dtqUl89/DWhIUq9ln4SjNwBmXPBB1aoZB
         G1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=O8Qr4u2Ex+vGQYNxrAO3WvQT1T8a47855lT6UekNsbk=;
        b=jdukbQ8MmXV23THtOskoSKx7ZItwAGRTpIItQII+CjW+XtvCjnslNnkRZ/LNve3ANT
         azIXiTJZK7jLLMlVa/y0CeZlORuzhLqj6o5qW4JOGesc/B51dUWEs3xOUuxdemS0+26F
         gwxxZ0ainQFEC/dwErQ2bKlwzs4aZBe/HoVyRfgeAQLSDc9UnU1PaQK2yZZ9/RzqGnd7
         7JKvXqiLWbtmkm8V8D5Id0+9pEeav7GbezmRAP5DeLtYu2t8k9cuGUmCazFGu510sbrb
         nFo7d96i3Qkw2Fot1YaEf3orEaeJI7sobsqrLxIaaBgcsLO6OdVD3ROIoWgSuFpWisBk
         OkLg==
X-Gm-Message-State: ACgBeo3wwji0RncFPmuXrHu0Z/I4CPVXpuouBbby4PxIwRuZX2iQlhrL
        OodcOtELIwSxC1pa7O8IzhVF2LBKbGW/
X-Google-Smtp-Source: AA6agR5R064ML6FigNicUfVaFAIqgVvCzSA3QYsjZDwwqZufirr829wsg6kAlryDwTanAFH/voDz0TZVwXeo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a81:4507:0:b0:33d:d0a5:aaf4 with SMTP id
 s7-20020a814507000000b0033dd0a5aaf4mr621623ywa.150.1661532321892; Fri, 26 Aug
 2022 09:45:21 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:39 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-16-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 15/18] perf mutex: Add thread safety annotations
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

Add thread safety annotations to struct mutex so that when compiled with
clang's -Wthread-safety warnings are generated for erroneous lock
patterns. NO_THREAD_SAFETY_ANALYSIS is needed for
mutex_lock/mutex_unlock as the analysis doesn't under pthread calls.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mutex.c |  2 ++
 tools/perf/util/mutex.h | 70 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
index 5029237164e5..bca7f0717f35 100644
--- a/tools/perf/util/mutex.c
+++ b/tools/perf/util/mutex.c
@@ -50,11 +50,13 @@ void mutex_destroy(struct mutex *mtx)
 }
 
 void mutex_lock(struct mutex *mtx)
+	NO_THREAD_SAFETY_ANALYSIS
 {
 	CHECK_ERR(pthread_mutex_lock(&mtx->lock));
 }
 
 void mutex_unlock(struct mutex *mtx)
+	NO_THREAD_SAFETY_ANALYSIS
 {
 	CHECK_ERR(pthread_mutex_unlock(&mtx->lock));
 }
diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index cfff32a902d9..5677f92ca6ed 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -5,11 +5,71 @@
 #include <pthread.h>
 #include <stdbool.h>
 
+/*
+ * A function-like feature checking macro that is a wrapper around
+ * `__has_attribute`, which is defined by GCC 5+ and Clang and evaluates to a
+ * nonzero constant integer if the attribute is supported or 0 if not.
+ */
+#ifdef __has_attribute
+#define HAVE_ATTRIBUTE(x) __has_attribute(x)
+#else
+#define HAVE_ATTRIBUTE(x) 0
+#endif
+
+#if HAVE_ATTRIBUTE(guarded_by) && HAVE_ATTRIBUTE(pt_guarded_by) && \
+	HAVE_ATTRIBUTE(lockable) && HAVE_ATTRIBUTE(exclusive_lock_function) && \
+	HAVE_ATTRIBUTE(exclusive_trylock_function) && HAVE_ATTRIBUTE(exclusive_locks_required) && \
+	HAVE_ATTRIBUTE(no_thread_safety_analysis)
+
+/* Documents if a shared field or global variable needs to be protected by a mutex. */
+#define GUARDED_BY(x) __attribute__((guarded_by(x)))
+
+/*
+ * Documents if the memory location pointed to by a pointer should be guarded by
+ * a mutex when dereferencing the pointer.
+ */
+#define PT_GUARDED_BY(x) __attribute__((pt_guarded_by(x)))
+
+/* Documents if a type is a lockable type. */
+#define LOCKABLE __attribute__((capability("lockable")))
+
+/* Documents functions that acquire a lock in the body of a function, and do not release it. */
+#define EXCLUSIVE_LOCK_FUNCTION(...)  __attribute__((exclusive_lock_function(__VA_ARGS__)))
+
+/*
+ * Documents functions that expect a lock to be held on entry to the function,
+ * and release it in the body of the function.
+ */
+#define UNLOCK_FUNCTION(...) __attribute__((unlock_function(__VA_ARGS__)))
+
+/* Documents functions that try to acquire a lock, and return success or failure. */
+#define EXCLUSIVE_TRYLOCK_FUNCTION(...) \
+	__attribute__((exclusive_trylock_function(__VA_ARGS__)))
+
+/* Documents a function that expects a mutex to be held prior to entry. */
+#define EXCLUSIVE_LOCKS_REQUIRED(...) __attribute__((exclusive_locks_required(__VA_ARGS__)))
+
+/* Turns off thread safety checking within the body of a particular function. */
+#define NO_THREAD_SAFETY_ANALYSIS __attribute__((no_thread_safety_analysis))
+
+#else
+
+#define GUARDED_BY(x)
+#define PT_GUARDED_BY(x)
+#define LOCKABLE
+#define EXCLUSIVE_LOCK_FUNCTION(...)
+#define UNLOCK_FUNCTION(...)
+#define EXCLUSIVE_TRYLOCK_FUNCTION(...)
+#define EXCLUSIVE_LOCKS_REQUIRED(...)
+#define NO_THREAD_SAFETY_ANALYSIS
+
+#endif
+
 /*
  * A wrapper around the mutex implementation that allows perf to error check
  * usage, etc.
  */
-struct mutex {
+struct LOCKABLE mutex {
 	pthread_mutex_t lock;
 };
 
@@ -27,10 +87,10 @@ void mutex_init(struct mutex *mtx);
 void mutex_init_pshared(struct mutex *mtx);
 void mutex_destroy(struct mutex *mtx);
 
-void mutex_lock(struct mutex *mtx);
-void mutex_unlock(struct mutex *mtx);
+void mutex_lock(struct mutex *mtx) EXCLUSIVE_LOCK_FUNCTION(*mtx);
+void mutex_unlock(struct mutex *mtx) UNLOCK_FUNCTION(*mtx);
 /* Tries to acquire the lock and returns true on success. */
-bool mutex_trylock(struct mutex *mtx);
+bool mutex_trylock(struct mutex *mtx) EXCLUSIVE_TRYLOCK_FUNCTION(true, *mtx);
 
 /* Default initialize the cond struct. */
 void cond_init(struct cond *cnd);
@@ -41,7 +101,7 @@ void cond_init(struct cond *cnd);
 void cond_init_pshared(struct cond *cnd);
 void cond_destroy(struct cond *cnd);
 
-void cond_wait(struct cond *cnd, struct mutex *mtx);
+void cond_wait(struct cond *cnd, struct mutex *mtx) EXCLUSIVE_LOCKS_REQUIRED(mtx);
 void cond_signal(struct cond *cnd);
 void cond_broadcast(struct cond *cnd);
 
-- 
2.37.2.672.g94769d06f0-goog

