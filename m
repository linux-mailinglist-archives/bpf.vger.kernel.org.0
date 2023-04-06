Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9756DA462
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbjDFVGa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbjDFVGU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:06:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E649012;
        Thu,  6 Apr 2023 14:06:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ja10so38616005plb.5;
        Thu, 06 Apr 2023 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815179; x=1683407179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyYImB6w0gbLwOhqAGS6GeXGg4AcAsKtDrgZnurJMx8=;
        b=o6bX848aRmyvy3jboloj4EINCdFM9X5H44+UT55eIy4lYVFD88bhmTKFsn24uW084j
         YP49XfOAgZEmV73Lm0KBL/EhxndEe8naLFw6gRNhLyzqqjqr2yqSx6I7naOfHik/YIu5
         JelIwU24eYT73Rg7L/AGXxdeqFKBYLAzxZRxFPMqkqtpEYvrSmmd6MF+lOrDPhMosMPL
         2DurjLQytI3KC40hYTLXtyEZ0otFFP3T65jXPwdZL/1cNKTripGwXI65PH9NgIxQS/pV
         mseQYMTXyuTWqgrIEPsvew1VQBb5s1PWLlcrprRv14na3FiknV0Vk0mMI6YQTHuy94W/
         Jwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815179; x=1683407179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyYImB6w0gbLwOhqAGS6GeXGg4AcAsKtDrgZnurJMx8=;
        b=8LHFx0+pUmA5g3NGp2Lo3gtHRlRl75OVdFjmUrSSHwg/p7mixON2yeWD8mvaIisoAz
         CPBkPoHA7hh6+Ss4312nvYIk5y5c455fJHD2VxsFAMRGWmDnclN2MZIRbNGTcP3OrYfM
         vl0F3T9dNxIL1JPcVo1ZICJP/Eyz9d9WM5aVKgnAe9uEr+8LEhMarlfAXiC/UWf2Z9eM
         z0pM5+9yDjEvn8mV0kObPWIlBgIM+qM8kCIK40rhMSnjdzPToDObk0hKCTu9R+axhsu7
         8L2j1zvtB5popmV8ODyDf7V1iPVDXPrQ0p6BhOjD20Y8CsozRKYN0hz1rrJW5zwgyV/a
         B5tg==
X-Gm-Message-State: AAQBX9ced3jC3ekgrzo0U5xow7E3MQhD0ZN+D96eit4Ao8HprC0KVP47
        AaJ9b2vwO+gceVT0yw/ncxA=
X-Google-Smtp-Source: AKy350bhzJ+y82FJXwFNvJ56CllVZBUkuGPJvHxLb8UujQn2wqPWcuTPV2Tq+HRvAUhf4zVt7tAcRw==
X-Received: by 2002:a17:903:11d0:b0:1a1:bff4:4a06 with SMTP id q16-20020a17090311d000b001a1bff44a06mr531968plh.24.1680815178970;
        Thu, 06 Apr 2023 14:06:18 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3301:38fe:e39e:3d51])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001a0667822c8sm1777837plo.94.2023.04.06.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:06:18 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 4/7] perf lock contention: Add data failure stat
Date:   Thu,  6 Apr 2023 14:06:08 -0700
Message-Id: <20230406210611.1622492-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230406210611.1622492-1-namhyung@kernel.org>
References: <20230406210611.1622492-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's possible to fail to update the data when the lock_stat map is full.
We should check that case and show the number at the end.

  $ sudo ./perf lock con -ablv -E3 -- ./perf bench sched messaging
  ...
   contended   total wait     max wait     avg wait            address   symbol

        6157    208.48 ms     69.29 us     33.86 us   ffff934c001c1f00    (spinlock)
        4030     72.04 ms     61.84 us     17.88 us   ffff934c000415c0    (spinlock)
        3201     50.30 ms     47.73 us     15.71 us   ffff934c2eead850    (spinlock)

  === output for debug ===

  bad: 0, total: 13388
  bad rate: 0.00 %
  histogram of failure reasons
         task: 0
        stack: 0
         time: 0
         data: 0      <----- added

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                      | 4 +++-
 tools/perf/util/bpf_lock_contention.c          | 1 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 4 +++-
 tools/perf/util/lock-contention.h              | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 9b92c7a5aefb..01b318d6c80a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1626,7 +1626,7 @@ static void sort_contention_result(void)
 static void print_bpf_events(int total, struct lock_contention_fails *fails)
 {
 	/* Output for debug, this have to be removed */
-	int broken = fails->task + fails->stack + fails->time;
+	int broken = fails->task + fails->stack + fails->time + fails->data;
 
 	if (quiet || total == 0 || (broken == 0 && verbose <= 0))
 		return;
@@ -1640,7 +1640,9 @@ static void print_bpf_events(int total, struct lock_contention_fails *fails)
 	pr_info(" %10s: %d\n", "task", fails->task);
 	pr_info(" %10s: %d\n", "stack", fails->stack);
 	pr_info(" %10s: %d\n", "time", fails->time);
+	pr_info(" %10s: %d\n", "data", fails->data);
 }
+
 static void print_contention_result(struct lock_contention *con)
 {
 	struct lock_stat *st;
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 8a5d0eb44189..0071058ac3d2 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -262,6 +262,7 @@ int lock_contention_read(struct lock_contention *con)
 	con->fails.task = skel->bss->task_fail;
 	con->fails.stack = skel->bss->stack_fail;
 	con->fails.time = skel->bss->time_fail;
+	con->fails.data = skel->bss->data_fail;
 
 	stack_trace = zalloc(stack_size);
 	if (stack_trace == NULL)
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index f9d2d792ccc8..cb87c98e5340 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -124,6 +124,7 @@ int aggr_mode;
 int task_fail;
 int stack_fail;
 int time_fail;
+int data_fail;
 
 static inline int can_record(u64 *ctx)
 {
@@ -380,7 +381,8 @@ int contention_end(u64 *ctx)
 		if (aggr_mode == LOCK_AGGR_ADDR)
 			first.flags |= check_lock_type(pelem->lock, pelem->flags);
 
-		bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
+		if (bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST) < 0)
+			__sync_fetch_and_add(&data_fail, 1);
 		bpf_map_delete_elem(&tstamp, &pid);
 		return 0;
 	}
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 10c28302420c..3ed1cad370fc 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -126,6 +126,7 @@ struct lock_contention_fails {
 	int task;
 	int stack;
 	int time;
+	int data;
 };
 
 struct lock_contention {
-- 
2.40.0.577.gac1e443424-goog

