Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA365B14C7
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 08:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiIHGiH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 02:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiIHGiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 02:38:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93BFC59D3;
        Wed,  7 Sep 2022 23:38:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fv3so10684353pjb.0;
        Wed, 07 Sep 2022 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=DkRY6cqz3FlVC+lgkVgVD+Fncc7hcTBy/c6wwEkWsko=;
        b=XG0KJtYiLaeVeduW4SOmWJ3DtmrKj7To4hEvZKbKFxkhlnQOxktHJG3XOQtVFbQBRw
         dUMpM+5ia5vbtD8pqXL9F1fmsw3E8zlWW63IWHXeMIzmdbrmbCl1hnWYOuRpSrx4amAH
         6zQ4vtmOp1i+8yhKc4sSYpHoYfE0RtvNz7d+jolY6vZNbmY7XfdlXxc0h628rPgxu1n6
         djZzJuq2n50YmthzW/CEs0n6SrvK9jsEI2W6AlL9NYWjZmk3wpyXxHt0xVY8rUr5+1nj
         +3ec0Ivxyh3OQmO6/51UeWGaHmDodlD2ohfB7HdWRmbf+jCgdNdty1uIXmwgwpYEx/1E
         WFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=DkRY6cqz3FlVC+lgkVgVD+Fncc7hcTBy/c6wwEkWsko=;
        b=7c4C9hp6s/+XmuNUN0X8Y7BR3OU1xn9FdUinvufouEOqnCVDsNjVMBxRH9I6qDutaL
         +QGSjwlomBcWHB3xTbwuZVdTH5mC790QBficp7Tje+D546zLU6YqW7ca2pYJIjTM2s40
         kELXIskST8twuBJw8NInJTaSHUjOVa0+zLecc0dgF7c64ZajwReYuLnFSGtzkGy5/msI
         vqo/OybLUF04xqV6GdHllG8ruCfZk7qf/+u+hQ5L9FZ0FpiOj8SccfWt9D1vzq6rguid
         mRZguyxtkhh8EPTOd3HfSf9M/QyMOowL3MybscrSqZYDgDF3yikq79dEhVekoZj7BwbX
         zpuA==
X-Gm-Message-State: ACgBeo1NelYepNOC8Afcl4vQo6FvQ6lhHGC4IAEJ0sj9E4+WXlcX3eDH
        0Dt2f0hWFybqh3HQsbfJ6Z8=
X-Google-Smtp-Source: AA6agR4VCqnyQmP686jiPAgUunom+WROf7zeas1U0hL7tdnDx1hKEFZx+cGMv376SR9h92kUDWtKyA==
X-Received: by 2002:a17:90a:4a0e:b0:1fe:1c89:a6b7 with SMTP id e14-20020a17090a4a0e00b001fe1c89a6b7mr2549600pjh.239.1662619083292;
        Wed, 07 Sep 2022 23:38:03 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:7f21:d032:3f14:a4e6])
        by smtp.gmail.com with ESMTPSA id o33-20020a17090a0a2400b001fb0fc33d72sm890716pjo.47.2022.09.07.23.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:38:02 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 3/4] perf lock contention: Allow to change stack depth and skip
Date:   Wed,  7 Sep 2022 23:37:53 -0700
Message-Id: <20220908063754.1369709-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220908063754.1369709-1-namhyung@kernel.org>
References: <20220908063754.1369709-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It needs stack traces to find callers of locks.  To minimize the
performance overhead it only collects up to 8 entries for each stack
trace.  And it skips first 3 entries as they came from BPF, tracepoint
and lock functions which are not interested for most users.

But it turned out that those numbers are different in some
configuration.  Using fixed number can result in non meaningful caller
names.  Let's make them adjustable with --stack-depth and --skip-stack
options.

On my setup, the default output is like below:

  # perf lock con -ab -F contended,wait_total sleep 3
   contended   total wait         type   caller

          28      4.55 ms     rwlock:W   __bpf_trace_contention_begin+0xb
          33      1.67 ms     rwlock:W   __bpf_trace_contention_begin+0xb
          12    580.28 us     spinlock   __bpf_trace_contention_begin+0xb
          60    240.54 us      rwsem:R   __bpf_trace_contention_begin+0xb
          27     64.45 us     spinlock   __bpf_trace_contention_begin+0xb

If I change the stack skip to 5, the result will be like:

  # perf lock con -ab -F contended,wait_total --stack-skip 5 sleep 3
   contended   total wait         type   caller

          32    715.45 us     spinlock   folio_lruvec_lock_irqsave+0x61
          26    550.22 us     spinlock   folio_lruvec_lock_irqsave+0x61
          15    486.93 us      rwsem:R   mmap_read_lock+0x13
          12    139.66 us      rwsem:W   vm_mmap_pgoff+0x93
           1      7.04 us     spinlock   tick_do_update_jiffies64+0x25

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |  6 ++++++
 tools/perf/builtin-lock.c              | 20 +++++++++++++++-----
 tools/perf/util/bpf_lock_contention.c  |  7 ++++---
 tools/perf/util/lock-contention.h      |  2 ++
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 193c5d8b8db9..5f2dc634258e 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -148,6 +148,12 @@ CONTENTION OPTIONS
 --map-nr-entries::
 	Maximum number of BPF map entries (default: 10240).
 
+--max-stack::
+	Maximum stack depth when collecting lock contention (default: 8).
+
+--stack-skip
+	Number of stack depth to skip when finding a lock caller (default: 3).
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e66fbb38d8df..13900ac1d186 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -56,6 +56,8 @@ static bool combine_locks;
 static bool show_thread_stats;
 static bool use_bpf;
 static unsigned long bpf_map_entries = 10240;
+static int max_stack_depth = CONTENTION_STACK_DEPTH;
+static int stack_skip = CONTENTION_STACK_SKIP;
 
 static enum {
 	LOCK_AGGR_ADDR,
@@ -939,7 +941,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 
 	/* use caller function name from the callchain */
 	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
-					NULL, NULL, CONTENTION_STACK_DEPTH);
+					NULL, NULL, max_stack_depth);
 	if (ret != 0) {
 		thread__put(thread);
 		return -1;
@@ -956,7 +958,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 			break;
 
 		/* skip first few entries - for lock functions */
-		if (++skip <= CONTENTION_STACK_SKIP)
+		if (++skip <= stack_skip)
 			goto next;
 
 		sym = node->ms.sym;
@@ -988,7 +990,7 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample, u64 *ca
 
 	/* use caller function name from the callchain */
 	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
-					NULL, NULL, CONTENTION_STACK_DEPTH);
+					NULL, NULL, max_stack_depth);
 	thread__put(thread);
 
 	if (ret != 0)
@@ -1007,7 +1009,7 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample, u64 *ca
 			callchains[i++] = node->ip;
 
 		/* skip first few entries - for lock functions */
-		if (++skip <= CONTENTION_STACK_SKIP)
+		if (++skip <= stack_skip)
 			goto next;
 
 		if (node->ms.sym && is_lock_function(machine, node->ip))
@@ -1524,7 +1526,7 @@ static void print_contention_result(struct lock_contention *con)
 			char buf[128];
 			u64 ip;
 
-			for (int i = 0; i < CONTENTION_STACK_DEPTH; i++) {
+			for (int i = 0; i < max_stack_depth; i++) {
 				if (!st->callstack || !st->callstack[i])
 					break;
 
@@ -1641,6 +1643,8 @@ static int __cmd_contention(int argc, const char **argv)
 		.target = &target,
 		.result = &lockhash_table[0],
 		.map_nr_entries = bpf_map_entries,
+		.max_stack = max_stack_depth,
+		.stack_skip = stack_skip,
 	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
@@ -1904,6 +1908,12 @@ int cmd_lock(int argc, const char **argv)
 		   "Trace on existing thread id (exclusive to --pid)"),
 	OPT_CALLBACK(0, "map-nr-entries", &bpf_map_entries, "num",
 		     "Max number of BPF map entries", parse_map_entry),
+	OPT_INTEGER(0, "max-stack", &max_stack_depth,
+		    "Set the maximum stack depth when collecting lock contention, "
+		    "Default: " __stringify(CONTENTION_STACK_DEPTH)),
+	OPT_INTEGER(0, "stack-skip", &stack_skip,
+		    "Set the number of stack depth to skip when finding a lock caller, "
+		    "Default: " __stringify(CONTENTION_STACK_SKIP)),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 6545bee65347..ef5323c78ffc 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -41,6 +41,7 @@ int lock_contention_prepare(struct lock_contention *con)
 		return -1;
 	}
 
+	bpf_map__set_value_size(skel->maps.stacks, con->max_stack * sizeof(u64));
 	bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
 	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_nr_entries);
 
@@ -115,7 +116,7 @@ int lock_contention_read(struct lock_contention *con)
 	struct lock_contention_data data;
 	struct lock_stat *st;
 	struct machine *machine = con->machine;
-	u64 stack_trace[CONTENTION_STACK_DEPTH];
+	u64 stack_trace[con->max_stack];
 
 	fd = bpf_map__fd(skel->maps.lock_stat);
 	stack = bpf_map__fd(skel->maps.stacks);
@@ -146,9 +147,9 @@ int lock_contention_read(struct lock_contention *con)
 		bpf_map_lookup_elem(stack, &key, stack_trace);
 
 		/* skip BPF + lock internal functions */
-		idx = CONTENTION_STACK_SKIP;
+		idx = con->stack_skip;
 		while (is_lock_function(machine, stack_trace[idx]) &&
-		       idx < CONTENTION_STACK_DEPTH - 1)
+		       idx < con->max_stack - 1)
 			idx++;
 
 		st->addr = stack_trace[idx];
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index bdb6e2a61e5b..67db311fc9df 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -115,6 +115,8 @@ struct lock_contention {
 	struct hlist_head *result;
 	unsigned long map_nr_entries;
 	unsigned long lost;
+	int max_stack;
+	int stack_skip;
 };
 
 #ifdef HAVE_BPF_SKEL
-- 
2.37.2.789.g6183377224-goog

