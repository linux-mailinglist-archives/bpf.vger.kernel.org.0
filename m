Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59876CB208
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 00:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC0W5S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 18:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjC0W5R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 18:57:17 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4D01FF3;
        Mon, 27 Mar 2023 15:57:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so10619900pjl.4;
        Mon, 27 Mar 2023 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679957835; x=1682549835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMiun7k5j2gOKDHoLzVDIm/hIRI73xZoJstuabRRi/o=;
        b=GADKS9E1D0PUHHw6EWPHMgAIjXTv1edfejBt74ayP5a1/llkz8yecJrScYdZTpSGei
         5qybFLJDXJBLdpZcnoHKFyrFpDutcts1JcXU/t/+1lb9PLNtXO84IvahwSAPHNC2nRbR
         uLfjDaa7mngGtRiT/dItP0HGRrxNlweZ4YYkpbmGEiWcITGwFVW4nguyNggA7vHl2ZlH
         w5rIPdOwiTcpt5p1Ypz2DrXVj+/a1DZ4dkNGlpJVPpAzg7CLbUoGvJpNgen+j13tHjlx
         qsrqom1eDigKI4iYGcze3JE1k7LTO+vPvtNz1V+aWEk2Yu+5F8OwSvva4bWjAmcuLcut
         x5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679957835; x=1682549835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VMiun7k5j2gOKDHoLzVDIm/hIRI73xZoJstuabRRi/o=;
        b=Owq2FeP3aVcuaBlxwTdc0swTKad2VJMwVElEW2ee21mZpnmHahqjboWhazsv/+Fcdj
         Aa7rW0AswNOSn4R4l9jB8jQJutBnhib39rkMNOsHhB8S6ODU1+d2xNJGB+sr4JlmIFk4
         Nv9G/CUxxEAKVWa9xBnQii+cIn6GzjraM51hjedcyoFcK/clWaLK+DNchzAUlP0EA2xN
         5f5Mt3n+K9UX6F/mXLuWNaMkQ6E84qaYzshbadZ7GfCmJ0JnyCP19A+dI7KHeOxMGAW4
         zjMsx26idHYF2ElGG1EC4ZGxXhUAabDwYMzxu+B5o6nyUMRS6LP8L3tVyNBFvE+mWkxi
         rZ4A==
X-Gm-Message-State: AO0yUKWrwbTOQXMS+TqtPC1Vn/i/2na9tAtjN+ax0QkcDZ8E5JPovcet
        RpWcrI97ecHetmvbZoj87vA=
X-Google-Smtp-Source: AK7set82h99bMSgEhT5XQQyL9LbXEIwuAIpQ/+etNKNzQj1/3YVpdYx2CGb3mFSvoSpNLuqJ9u6kpw==
X-Received: by 2002:a05:6a20:8c14:b0:db:da69:3deb with SMTP id j20-20020a056a208c1400b000dbda693debmr10858647pzh.21.1679957835434;
        Mon, 27 Mar 2023 15:57:15 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:4cdc:1028:ab64:920d])
        by smtp.gmail.com with ESMTPSA id c11-20020aa781cb000000b0062d84986823sm2383579pfn.169.2023.03.27.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 15:57:15 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org
Subject: [PATCH 2/2] perf lock contention: Show detail failure reason for BPF
Date:   Mon, 27 Mar 2023 15:57:11 -0700
Message-Id: <20230327225711.245738-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230327225711.245738-1-namhyung@kernel.org>
References: <20230327225711.245738-1-namhyung@kernel.org>
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

It can fail to collect lock stat from BPF for various reasons.  For
example, I've got a report that sometimes time calculation seems wrong
in case of contended spinlocks.  I suspect the time delta went negative
for some reason.

Count them separately and show in the output like below:

$ sudo perf lock contention -abE5 sleep 10
 contended   total wait     max wait     avg wait         type   caller

        13    785.61 us     79.36 us     60.43 us     spinlock   remove_wait_queue+0x14
        10    469.02 us     87.51 us     46.90 us     spinlock   prepare_to_wait+0x27
         9    289.09 us     69.08 us     32.12 us     spinlock   finish_wait+0x36
       114    251.05 us      8.56 us      2.20 us     spinlock   try_to_wake_up+0x1f5
       132    188.63 us      5.01 us      1.43 us     spinlock   __wake_up_common_lock+0x62

=== output for debug ===

bad: 1, total: 279
bad rate: 0.36 %
histogram of failure reasons
       task: 1
      stack: 0
       time: 0

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                     | 28 +++++++++++++++----
 tools/perf/util/bpf_lock_contention.c         |  4 ++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 13 +++++++--
 tools/perf/util/lock-contention.h             |  8 +++++-
 4 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 82dd2dfe5692..32ec58fb80e4 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1619,6 +1619,24 @@ static void sort_contention_result(void)
 	sort_result();
 }
 
+static void print_bpf_events(int total, struct lock_contention_fails *fails)
+{
+	/* Output for debug, this have to be removed */
+	int broken = fails->task + fails->stack + fails->time;
+
+	if (quiet || total == 0 || (broken == 0 && verbose <= 0))
+		return;
+
+	total += broken;
+	pr_info("\n=== output for debug ===\n\n");
+	pr_info("bad: %d, total: %d\n", broken, total);
+	pr_info("bad rate: %.2f %%\n", (double)broken / (double)total * 100);
+
+	pr_info("histogram of failure reasons\n");
+	pr_info(" %10s: %d\n", "task", fails->task);
+	pr_info(" %10s: %d\n", "stack", fails->stack);
+	pr_info(" %10s: %d\n", "time", fails->time);
+}
 static void print_contention_result(struct lock_contention *con)
 {
 	struct lock_stat *st;
@@ -1646,8 +1664,6 @@ static void print_contention_result(struct lock_contention *con)
 	}
 
 	bad = total = printed = 0;
-	if (use_bpf)
-		bad = bad_hist[BROKEN_CONTENDED];
 
 	while ((st = pop_from_result())) {
 		struct thread *t;
@@ -1704,7 +1720,10 @@ static void print_contention_result(struct lock_contention *con)
 			break;
 	}
 
-	print_bad_events(bad, total);
+	if (use_bpf)
+		print_bpf_events(total, &con->fails);
+	else
+		print_bad_events(bad, total);
 }
 
 static bool force;
@@ -1931,9 +1950,6 @@ static int __cmd_contention(int argc, const char **argv)
 
 		lock_contention_stop();
 		lock_contention_read(&con);
-
-		/* abuse bad hist stats for lost entries */
-		bad_hist[BROKEN_CONTENDED] = con.lost;
 	} else {
 		err = perf_session__process_events(session);
 		if (err)
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 5927bf0bd92b..b3e8aa9cd011 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -259,7 +259,9 @@ int lock_contention_read(struct lock_contention *con)
 	fd = bpf_map__fd(skel->maps.lock_stat);
 	stack = bpf_map__fd(skel->maps.stacks);
 
-	con->lost = skel->bss->lost;
+	con->fails.task = skel->bss->task_fail;
+	con->fails.stack = skel->bss->stack_fail;
+	con->fails.time = skel->bss->time_fail;
 
 	stack_trace = zalloc(stack_size);
 	if (stack_trace == NULL)
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index ed9160999c32..3f4ee3992e81 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -124,7 +124,9 @@ int lock_owner;
 int aggr_mode;
 
 /* error stat */
-int lost;
+int task_fail;
+int stack_fail;
+int time_fail;
 
 static inline int can_record(u64 *ctx)
 {
@@ -283,7 +285,7 @@ int contention_begin(u64 *ctx)
 		bpf_map_update_elem(&tstamp, &pid, &zero, BPF_ANY);
 		pelem = bpf_map_lookup_elem(&tstamp, &pid);
 		if (pelem == NULL) {
-			lost++;
+			__sync_fetch_and_add(&task_fail, 1);
 			return 0;
 		}
 	}
@@ -296,7 +298,7 @@ int contention_begin(u64 *ctx)
 		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
 						  BPF_F_FAST_STACK_CMP | stack_skip);
 		if (pelem->stack_id < 0)
-			lost++;
+			__sync_fetch_and_add(&stack_fail, 1);
 	} else if (aggr_mode == LOCK_AGGR_TASK) {
 		struct task_struct *task;
 
@@ -340,6 +342,11 @@ int contention_end(u64 *ctx)
 		return 0;
 
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
+	if ((__s64)duration < 0) {
+		bpf_map_delete_elem(&tstamp, &pid);
+		__sync_fetch_and_add(&time_fail, 1);
+		return 0;
+	}
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 040b618b2215..10c28302420c 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -122,14 +122,20 @@ struct evlist;
 struct machine;
 struct target;
 
+struct lock_contention_fails {
+	int task;
+	int stack;
+	int time;
+};
+
 struct lock_contention {
 	struct evlist *evlist;
 	struct target *target;
 	struct machine *machine;
 	struct hlist_head *result;
 	struct lock_filter *filters;
+	struct lock_contention_fails fails;
 	unsigned long map_nr_entries;
-	int lost;
 	int max_stack;
 	int stack_skip;
 	int aggr_mode;
-- 
2.40.0.348.gf938b09366-goog

