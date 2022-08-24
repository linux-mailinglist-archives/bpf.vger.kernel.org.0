Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E52159FE91
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 17:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239521AbiHXPkh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 11:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiHXPkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 11:40:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E4B286C0
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-32a115757b6so299929627b3.13
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 08:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=/ILfvpN1NHzKgXNdja/+/asgEHNUSqwihtbTOOtNWMg=;
        b=KC5jR4bhZlhGHXpbXx8Sy/971RKTEG3JOdyrKJ8+8yhEnh9kwjw4boPtyrtzme1pKC
         EdbfK/pKP9JGu980DYvKwuzcynaPL6heGl63+cLhc3Q3VviTxUOpSz4HMaF9s+17kyHG
         RkKZD8xzq7N+X3dxUpRU/sgIkW9RY41fO+rekM8XyBqkxH9d5O5SxdN8ccpp600KsZJ2
         xWtjvujc5F5XwLwzaOc/vL5TdSgYqW9gw4LRpC7BDvrT+yVUo6tsRZ4fCWu295snGelo
         rmVNJqKogy7hdciYz1XiT1YFYWmnTAqgveFEFbcQfNukDXfP6hWR32f82QE4/QUZNspx
         FoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=/ILfvpN1NHzKgXNdja/+/asgEHNUSqwihtbTOOtNWMg=;
        b=1ywblBp493foafIcjTI3TQ2f5Ov8N1FgUAIaPj6Lt3cy6+RQ3JWDHvJlMYesnr66Ll
         aysrMIgEwueiK5kNdoroQohRyXhhT+vq5ymx5sOiJM7w4wDMd7jZHzV9n6uL958wOZFX
         PLZro/OmfoBzktHShENzMHB8o7ROUYG+RdQlW2lm0SizvJPFHcMK5W9/QbVl1g61o0H2
         1ol+QY/uFmGqQ519LSmijsh8IsMOaW0XTxQpoD0wib1/J1YUnUd92khRRHDoUylvhk6O
         ccFt7iHLM5LJE2uuKSVH0cGtIObSv3oo2rpEUtqejqaDISalXKFyUS1lKA3SQh6ofbMU
         5LlQ==
X-Gm-Message-State: ACgBeo16SvRrbi1iFa3UbMFmUHIeJJyGRj1COpbdKMgTrqsYNPuwMnVI
        qzDNiZY7//g1u/KRXPwuvVhScSdLvytV
X-Google-Smtp-Source: AA6agR6dE2KJjBOgrSaom7szU/BKSYqNbZFXxUCdzu7MVACZT4sXapSTucfNldaAPXUDWy7pxp3b+pUWUowZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:ab82:a348:500d:1fc4])
 (user=irogers job=sendgmr) by 2002:a25:b901:0:b0:682:66a2:f714 with SMTP id
 x1-20020a25b901000000b0068266a2f714mr27193407ybj.577.1661355615114; Wed, 24
 Aug 2022 08:40:15 -0700 (PDT)
Date:   Wed, 24 Aug 2022 08:38:51 -0700
In-Reply-To: <20220824153901.488576-1-irogers@google.com>
Message-Id: <20220824153901.488576-9-irogers@google.com>
Mime-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v3 08/18] perf sched: Update use of pthread mutex
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
2.37.2.609.g9ff673ca1a-goog

