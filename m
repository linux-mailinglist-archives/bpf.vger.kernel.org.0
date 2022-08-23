Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BB459EECC
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiHWWMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiHWWMW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:12:22 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618897C192
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:11:12 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q7-20020a63e947000000b004297f1e1f86so6665868pgj.12
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=XPuMrEmpVaX0CO7dyFJBelQFPDb3Vcz70HxeyCf+Aoo=;
        b=SJ+8921Gu9b3/VmEZj1EADQgc2FMFPsv+iqRwwG5/DLfP5x1WL5CBnZHQEUET2dwDf
         XCIywGXcF2XdS/+7+k9pj4eDl7frNGPb65KPPdKE101o4g6KTeZpDK6CGNKG00b0ITNl
         zyDdmGb4gNTgLzAqH4Tjy2oJzOgCcHLXJBlNtbKjB6XEVu49IDYwo+amTX33qly9RRwv
         rwDvxWdmjvQRM8UsDDWP5uyogTrGHTO2VgNeNSTn06gT7UylBKz+LA4jtwbG1NOPNYJo
         dzhQ6/kVIZUwVds8WBpBKWKtDjgoVl+bezYgHud5Lxcb045ct0ESDcPS4o48YA9GuyiX
         cz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=XPuMrEmpVaX0CO7dyFJBelQFPDb3Vcz70HxeyCf+Aoo=;
        b=V/uPrBj3uz+wC205v8gYYm1j9wgoJkiHk4D9KOcw8nuXpOqrtRAjNWDeMGvqokT6e1
         QM/F5hjb34IZ7BU4hy8TBHYxpTQpbtyLl/uFn/715Ih9Fc7cfNkTB0FKLNDjeYQ1PQjk
         s12xq4K9DRjC33V8bW/Mwa+yVu7tH2KBl7g0QFoEU3Do7ZBBKZ/lIi7r2aqnlDoyKqY1
         g1FZbq1/B4EIHyznBxYzXZ9JMgNZ4zBPHFUmsxoO2BqY+b5tpIO5e0FC4JONAXDDAzKI
         AxoBel8sXu6c8O66dq1mUQ99+q0GVjtgXXuuq4QtZtDm6pGKRhFp6XB6LlwDozQpenEz
         c6pg==
X-Gm-Message-State: ACgBeo0ZaVZuRVKmOThMCEo8fSRimHcg04bFzDJ8Hsirs6HwhXdc8GrT
        6OFHQ/8qS12Fl2SwinD0yUZbD3inEuyt
X-Google-Smtp-Source: AA6agR6/lrrbVHDvzAtqYEgzKbOP+OGUUywQemY8hrKQaj9m/YTAfzeBeCgzyMm2qKvm/cIwWjLpEYwnDh/O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7dbd:c08f:de81:c2a3])
 (user=irogers job=sendgmr) by 2002:a17:902:d505:b0:173:111a:3023 with SMTP id
 b5-20020a170902d50500b00173111a3023mr1535558plg.32.1661292670931; Tue, 23 Aug
 2022 15:11:10 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:09:20 -0700
In-Reply-To: <20220823220922.256001-1-irogers@google.com>
Message-Id: <20220823220922.256001-17-irogers@google.com>
Mime-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v2 16/18] perf sched: Fixes for thread safety analysis
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

Add annotations to describe lock behavior. Add unlocks so that mutexes
aren't conditionally held on exit from perf_sched__replay. Add an exit
variable so that thread_func can terminate, rather than leaving the
threads blocked on mutexes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 46 ++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0f52f73be896..ce8497d39f9c 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -246,6 +246,7 @@ struct perf_sched {
 	const char	*time_str;
 	struct perf_time_interval ptime;
 	struct perf_time_interval hist_time;
+	volatile bool   thread_funcs_exit;
 };
 
 /* per thread run time data */
@@ -633,31 +634,34 @@ static void *thread_func(void *ctx)
 	prctl(PR_SET_NAME, comm2);
 	if (fd < 0)
 		return NULL;
-again:
-	ret = sem_post(&this_task->ready_for_work);
-	BUG_ON(ret);
-	mutex_lock(&sched->start_work_mutex);
-	mutex_unlock(&sched->start_work_mutex);
 
-	cpu_usage_0 = get_cpu_usage_nsec_self(fd);
+	while (!sched->thread_funcs_exit) {
+		ret = sem_post(&this_task->ready_for_work);
+		BUG_ON(ret);
+		mutex_lock(&sched->start_work_mutex);
+		mutex_unlock(&sched->start_work_mutex);
 
-	for (i = 0; i < this_task->nr_events; i++) {
-		this_task->curr_event = i;
-		perf_sched__process_event(sched, this_task->atoms[i]);
-	}
+		cpu_usage_0 = get_cpu_usage_nsec_self(fd);
 
-	cpu_usage_1 = get_cpu_usage_nsec_self(fd);
-	this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
-	ret = sem_post(&this_task->work_done_sem);
-	BUG_ON(ret);
+		for (i = 0; i < this_task->nr_events; i++) {
+			this_task->curr_event = i;
+			perf_sched__process_event(sched, this_task->atoms[i]);
+		}
 
-	mutex_lock(&sched->work_done_wait_mutex);
-	mutex_unlock(&sched->work_done_wait_mutex);
+		cpu_usage_1 = get_cpu_usage_nsec_self(fd);
+		this_task->cpu_usage = cpu_usage_1 - cpu_usage_0;
+		ret = sem_post(&this_task->work_done_sem);
+		BUG_ON(ret);
 
-	goto again;
+		mutex_lock(&sched->work_done_wait_mutex);
+		mutex_unlock(&sched->work_done_wait_mutex);
+	}
+	return NULL;
 }
 
 static void create_tasks(struct perf_sched *sched)
+	EXCLUSIVE_LOCK_FUNCTION(sched->start_work_mutex)
+	EXCLUSIVE_LOCK_FUNCTION(sched->work_done_wait_mutex)
 {
 	struct task_desc *task;
 	pthread_attr_t attr;
@@ -687,6 +691,8 @@ static void create_tasks(struct perf_sched *sched)
 }
 
 static void wait_for_tasks(struct perf_sched *sched)
+	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
+	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
 {
 	u64 cpu_usage_0, cpu_usage_1;
 	struct task_desc *task;
@@ -738,6 +744,8 @@ static void wait_for_tasks(struct perf_sched *sched)
 }
 
 static void run_one_test(struct perf_sched *sched)
+	EXCLUSIVE_LOCKS_REQUIRED(sched->work_done_wait_mutex)
+	EXCLUSIVE_LOCKS_REQUIRED(sched->start_work_mutex)
 {
 	u64 T0, T1, delta, avg_delta, fluct;
 
@@ -3309,11 +3317,15 @@ static int perf_sched__replay(struct perf_sched *sched)
 	print_task_traces(sched);
 	add_cross_task_wakeups(sched);
 
+	sched->thread_funcs_exit = false;
 	create_tasks(sched);
 	printf("------------------------------------------------------------\n");
 	for (i = 0; i < sched->replay_repeat; i++)
 		run_one_test(sched);
 
+	sched->thread_funcs_exit = true;
+	mutex_unlock(&sched->start_work_mutex);
+	mutex_unlock(&sched->work_done_wait_mutex);
 	return 0;
 }
 
-- 
2.37.2.609.g9ff673ca1a-goog

