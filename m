Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3CF5A2CA2
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbiHZQpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344679AbiHZQoz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 12:44:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E45AE1905
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:44:15 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-336c3b72da5so33405557b3.6
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=GgD+6zwqra9gOnSqGkAieKztoRTvvP9XXeeW7MuBWMo=;
        b=VIOXaOsl5Ybq3F+Ya1f+q2xUAralWPCk+yRASBaGpkAZo2gq+PuQ8qUI43ZsErEeOH
         /CIpkUnC/fPPIvNZc8OZ+ruKlZtSG2o2A/oWHwmTw0JDQ5dVFhR5r9jph9vsjHAu5rjy
         b8FfJMPNyzWfnufYso4NpxZsAhdfdtxadODqdMFXDGWw8FOI2L5YX5empRcw86z5P6zr
         0UU4aDlCYr/D+stU/r5ELtfgESrfXDTUnf+eJWFEOL5qHCkiVa78QX7cfdkTfhetqfu6
         p5xsZkN1LJt/vVStBCS9F/BhaShHR1jB5IWv91GNdQ5GaiyJdJSO/QotIlOBIsaQ/abH
         uu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=GgD+6zwqra9gOnSqGkAieKztoRTvvP9XXeeW7MuBWMo=;
        b=p14JoEwXqhQCL27ckdcj7M56epZhmsLR25FVb0mlF62P6Wp7sUGeAnM5pqPgipRxNH
         afU+tQneVWDniU3EPXI2VyfsZNJ1k/LvffcOgiPdmwsQ8F95m9/qf++bXViUKdaLI7Kx
         cEs+MZSfFqiBRZSZwNE71NLkJTBDO0ea0qJC1HejUVMTkA5e3Yihs9VJrjaOKNYqpiHl
         IRyUTqPvXtoqvzHP8xzhtF9O3QKSfeKj8o7NyjStB+wPda7nK37O01A2Odbt9iNkQrSc
         vxrQUyhMeZOCsf7r6rzX6R45TrRqi4b9x9cNB0AUxbgh+2JM7g7DxdA/pc7aWStE0kLK
         4wnQ==
X-Gm-Message-State: ACgBeo3awSF2VpGeTAfS5u9lfTEW+j5LMb0WPkZyi6EMEqmb3a4s0gYA
        as7rEDYYUzYxzmI+e9KaIUapAlNlRjhg
X-Google-Smtp-Source: AA6agR6lqr3Mf/yq4gHfai7EoCGqdkPDaQRC0WWlRD459eEHKC2xzEVghJ668HwLSNkBvHYMTAZPI224F5d7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ccb1:c46b:7044:2508])
 (user=irogers job=sendgmr) by 2002:a25:b983:0:b0:695:d8b4:a5a3 with SMTP id
 r3-20020a25b983000000b00695d8b4a5a3mr488819ybg.553.1661532254499; Fri, 26 Aug
 2022 09:44:14 -0700 (PDT)
Date:   Fri, 26 Aug 2022 09:42:32 -0700
In-Reply-To: <20220826164242.43412-1-irogers@google.com>
Message-Id: <20220826164242.43412-9-irogers@google.com>
Mime-Version: 1.0
References: <20220826164242.43412-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 08/18] perf sched: Update use of pthread mutex
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

Switch to the use of mutex wrappers that provide better error
checking. Update cmd_sched so that we always explicitly destroy the
mutexes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 67 ++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 2f6cd1b8b662..7e4006d6b8bc 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -7,6 +7,7 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/evsel_fprintf.h"
+#include "util/mutex.h"
 #include "util/symbol.h"
 #include "util/thread.h"
 #include "util/header.h"
@@ -184,8 +185,8 @@ struct perf_sched {
 	struct task_desc **pid_to_task;
 	struct task_desc **tasks;
 	const struct trace_sched_handler *tp_handler;
-	pthread_mutex_t	 start_work_mutex;
-	pthread_mutex_t	 work_done_wait_mutex;
+	struct mutex	 start_work_mutex;
+	struct mutex	 work_done_wait_mutex;
 	int		 profile_cpu;
 /*
  * Track the current task - that way we can know whether there's any
@@ -635,10 +636,8 @@ static void *thread_func(void *ctx)
 again:
 	ret = sem_post(&this_task->ready_for_work);
 	BUG_ON(ret);
-	ret = pthread_mutex_lock(&sched->start_work_mutex);
-	BUG_ON(ret);
-	ret = pthread_mutex_unlock(&sched->start_work_mutex);
-	BUG_ON(ret);
+	mutex_lock(&sched->start_work_mutex);
+	mutex_unlock(&sched->start_work_mutex);
 
 	cpu_usage_0 = get_cpu_usage_nsec_self(fd);
 
@@ -652,10 +651,8 @@ static void *thread_func(void *ctx)
 	ret = sem_post(&this_task->work_done_sem);
 	BUG_ON(ret);
 
-	ret = pthread_mutex_lock(&sched->work_done_wait_mutex);
-	BUG_ON(ret);
-	ret = pthread_mutex_unlock(&sched->work_done_wait_mutex);
-	BUG_ON(ret);
+	mutex_lock(&sched->work_done_wait_mutex);
+	mutex_unlock(&sched->work_done_wait_mutex);
 
 	goto again;
 }
@@ -672,10 +669,8 @@ static void create_tasks(struct perf_sched *sched)
 	err = pthread_attr_setstacksize(&attr,
 			(size_t) max(16 * 1024, (int)PTHREAD_STACK_MIN));
 	BUG_ON(err);
-	err = pthread_mutex_lock(&sched->start_work_mutex);
-	BUG_ON(err);
-	err = pthread_mutex_lock(&sched->work_done_wait_mutex);
-	BUG_ON(err);
+	mutex_lock(&sched->start_work_mutex);
+	mutex_lock(&sched->work_done_wait_mutex);
 	for (i = 0; i < sched->nr_tasks; i++) {
 		struct sched_thread_parms *parms = malloc(sizeof(*parms));
 		BUG_ON(parms == NULL);
@@ -699,7 +694,7 @@ static void wait_for_tasks(struct perf_sched *sched)
 
 	sched->start_time = get_nsecs();
 	sched->cpu_usage = 0;
-	pthread_mutex_unlock(&sched->work_done_wait_mutex);
+	mutex_unlock(&sched->work_done_wait_mutex);
 
 	for (i = 0; i < sched->nr_tasks; i++) {
 		task = sched->tasks[i];
@@ -707,12 +702,11 @@ static void wait_for_tasks(struct perf_sched *sched)
 		BUG_ON(ret);
 		sem_init(&task->ready_for_work, 0, 0);
 	}
-	ret = pthread_mutex_lock(&sched->work_done_wait_mutex);
-	BUG_ON(ret);
+	mutex_lock(&sched->work_done_wait_mutex);
 
 	cpu_usage_0 = get_cpu_usage_nsec_parent();
 
-	pthread_mutex_unlock(&sched->start_work_mutex);
+	mutex_unlock(&sched->start_work_mutex);
 
 	for (i = 0; i < sched->nr_tasks; i++) {
 		task = sched->tasks[i];
@@ -734,8 +728,7 @@ static void wait_for_tasks(struct perf_sched *sched)
 	sched->runavg_parent_cpu_usage = (sched->runavg_parent_cpu_usage * (sched->replay_repeat - 1) +
 					 sched->parent_cpu_usage)/sched->replay_repeat;
 
-	ret = pthread_mutex_lock(&sched->start_work_mutex);
-	BUG_ON(ret);
+	mutex_lock(&sched->start_work_mutex);
 
 	for (i = 0; i < sched->nr_tasks; i++) {
 		task = sched->tasks[i];
@@ -3430,8 +3423,6 @@ int cmd_sched(int argc, const char **argv)
 		},
 		.cmp_pid	      = LIST_HEAD_INIT(sched.cmp_pid),
 		.sort_list	      = LIST_HEAD_INIT(sched.sort_list),
-		.start_work_mutex     = PTHREAD_MUTEX_INITIALIZER,
-		.work_done_wait_mutex = PTHREAD_MUTEX_INITIALIZER,
 		.sort_order	      = default_sort_order,
 		.replay_repeat	      = 10,
 		.profile_cpu	      = -1,
@@ -3545,8 +3536,10 @@ int cmd_sched(int argc, const char **argv)
 		.fork_event	    = replay_fork_event,
 	};
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
+	mutex_init(&sched.start_work_mutex);
+	mutex_init(&sched.work_done_wait_mutex);
 	for (i = 0; i < ARRAY_SIZE(sched.curr_pid); i++)
 		sched.curr_pid[i] = -1;
 
@@ -3558,11 +3551,10 @@ int cmd_sched(int argc, const char **argv)
 	/*
 	 * Aliased to 'perf script' for now:
 	 */
-	if (!strcmp(argv[0], "script"))
-		return cmd_script(argc, argv);
-
-	if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
-		return __cmd_record(argc, argv);
+	if (!strcmp(argv[0], "script")) {
+		ret = cmd_script(argc, argv);
+	} else if (strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
+		ret = __cmd_record(argc, argv);
 	} else if (strlen(argv[0]) > 2 && strstarts("latency", argv[0])) {
 		sched.tp_handler = &lat_ops;
 		if (argc > 1) {
@@ -3571,7 +3563,7 @@ int cmd_sched(int argc, const char **argv)
 				usage_with_options(latency_usage, latency_options);
 		}
 		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__lat(&sched);
+		ret = perf_sched__lat(&sched);
 	} else if (!strcmp(argv[0], "map")) {
 		if (argc) {
 			argc = parse_options(argc, argv, map_options, map_usage, 0);
@@ -3580,7 +3572,7 @@ int cmd_sched(int argc, const char **argv)
 		}
 		sched.tp_handler = &map_ops;
 		setup_sorting(&sched, latency_options, latency_usage);
-		return perf_sched__map(&sched);
+		ret = perf_sched__map(&sched);
 	} else if (strlen(argv[0]) > 2 && strstarts("replay", argv[0])) {
 		sched.tp_handler = &replay_ops;
 		if (argc) {
@@ -3588,7 +3580,7 @@ int cmd_sched(int argc, const char **argv)
 			if (argc)
 				usage_with_options(replay_usage, replay_options);
 		}
-		return perf_sched__replay(&sched);
+		ret = perf_sched__replay(&sched);
 	} else if (!strcmp(argv[0], "timehist")) {
 		if (argc) {
 			argc = parse_options(argc, argv, timehist_options,
@@ -3604,16 +3596,21 @@ int cmd_sched(int argc, const char **argv)
 				parse_options_usage(NULL, timehist_options, "w", true);
 			if (sched.show_next)
 				parse_options_usage(NULL, timehist_options, "n", true);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		ret = symbol__validate_sym_arguments();
 		if (ret)
-			return ret;
+			goto out;
 
-		return perf_sched__timehist(&sched);
+		ret = perf_sched__timehist(&sched);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
 
-	return 0;
+out:
+	mutex_destroy(&sched.start_work_mutex);
+	mutex_destroy(&sched.work_done_wait_mutex);
+
+	return ret;
 }
-- 
2.37.2.672.g94769d06f0-goog

