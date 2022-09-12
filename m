Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5FE5B53AB
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 07:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiILFxe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 01:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiILFxb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 01:53:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A45255BA;
        Sun, 11 Sep 2022 22:53:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c2so7583379plo.3;
        Sun, 11 Sep 2022 22:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=VZ4ZKi2LPoTeZRL8wpsaNHCGDJSV43IWeEv/p4e0aFg=;
        b=iJcO9ACPZ2R0/MfNRVibiDu7NSMfQT0wG3hi7T1XRmBs+HtuTQ+LOlasFaWomn12AD
         Z1HRkoHjIj+dM/FeXbGGyeg5pLt5o7CmVLHjxJMRvFw/uQuZKrgvVE7qo9PxTTvUL0BS
         vQLOivNLJdS4agKnxsTvk1ujA5pMgP35KqKe65NsD/tk2kTkH34caS9eP8gdJS/40q94
         lY6FWC02wDxklEAVqnMislNrH/gQ4K2gxIPh6RrtxZcyiPFeBOE3gX3JFUs2k3n7Heze
         1ZCaRpB5n2taaRACwVHZfR9CcAWhxx7bwpPsXcBQaaUzo+c4LfXz8v94e9oSfZQNCCo1
         RsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=VZ4ZKi2LPoTeZRL8wpsaNHCGDJSV43IWeEv/p4e0aFg=;
        b=xJ0gUs9k4IC6nu1HmlBL1LRGCWfmbwIisYYa7ba9GTKIl553dsS6N8446ErmB0EbtT
         ji5i2CWg21bZqFEDWTqyt8p4haTEa4soKmGUgHn2TOycnyTOwgnS91DxZb56NZabcWYp
         +C4Y+MZAplXs2T6ZCyO3WyaDW1wOD+9Y7HDNNVMr6c3wEX7NAU3+gaXpYmtIkplGfhbR
         MBzuZEhsnQmFsK+tkTCei3LLa4QdJ1wutc190W7ctBwSw4U4YiwJ74O7F5kclTC7uWKi
         K/GrTLDCI1GkjktzbhxXVhq6LKuC/C+7mI1OYnnYTTDU6cou+F7M10l4dVnBAI1zuke/
         OTbQ==
X-Gm-Message-State: ACgBeo0X5SwjSwCJpBnav7idotsjOE4HxHAtoUo9dke5AfZHWrdMw4mU
        k1MFBgWXRcR/oMjkemw0iTM=
X-Google-Smtp-Source: AA6agR5hHNuALS4EZ8avXAv4TGpC5QINdVvwHAn3VI/N0Lr9bKUHAl2AkoSAwdVS0a5ClzDVskXo3A==
X-Received: by 2002:a17:902:8503:b0:173:368b:dce3 with SMTP id bj3-20020a170902850300b00173368bdce3mr25396809plb.104.1662962003174;
        Sun, 11 Sep 2022 22:53:23 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cfe7:8794:a807:6746])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b00176b87a697fsm4882736pls.269.2022.09.11.22.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:53:22 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 3/4] perf lock contention: Allow to change stack depth and skip
Date:   Sun, 11 Sep 2022 22:53:13 -0700
Message-Id: <20220912055314.744552-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220912055314.744552-1-namhyung@kernel.org>
References: <20220912055314.744552-1-namhyung@kernel.org>
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

  # /perf lock con -ab -F contended,wait_total sleep 3
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
 tools/perf/builtin-lock.c              | 22 ++++++++++++++++------
 tools/perf/util/bpf_lock_contention.c  |  7 ++++---
 tools/perf/util/lock-contention.h      |  2 ++
 4 files changed, 28 insertions(+), 9 deletions(-)

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
index 371539049358..25d75fa09b90 100644
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
@@ -936,7 +938,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 
 	/* use caller function name from the callchain */
 	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
-					NULL, NULL, CONTENTION_STACK_DEPTH);
+					NULL, NULL, max_stack_depth);
 	if (ret != 0) {
 		thread__put(thread);
 		return -1;
@@ -953,7 +955,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 			break;
 
 		/* skip first few entries - for lock functions */
-		if (++skip <= CONTENTION_STACK_SKIP)
+		if (++skip <= stack_skip)
 			goto next;
 
 		sym = node->ms.sym;
@@ -984,7 +986,7 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 
 	/* use caller function name from the callchain */
 	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
-					NULL, NULL, CONTENTION_STACK_DEPTH);
+					NULL, NULL, max_stack_depth);
 	thread__put(thread);
 
 	if (ret != 0)
@@ -1000,7 +1002,7 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 			break;
 
 		/* skip first few entries - for lock functions */
-		if (++skip <= CONTENTION_STACK_SKIP)
+		if (++skip <= stack_skip)
 			goto next;
 
 		if (node->ms.sym && is_lock_function(machine, node->ip))
@@ -1063,7 +1065,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 			return -ENOMEM;
 
 		if (aggr_mode == LOCK_AGGR_CALLER && verbose) {
-			ls->callstack = get_callstack(sample, CONTENTION_STACK_DEPTH);
+			ls->callstack = get_callstack(sample, max_stack_depth);
 			if (ls->callstack == NULL)
 				return -ENOMEM;
 		}
@@ -1515,7 +1517,7 @@ static void print_contention_result(struct lock_contention *con)
 			char buf[128];
 			u64 ip;
 
-			for (int i = 0; i < CONTENTION_STACK_DEPTH; i++) {
+			for (int i = 0; i < max_stack_depth; i++) {
 				if (!st->callstack || !st->callstack[i])
 					break;
 
@@ -1632,6 +1634,8 @@ static int __cmd_contention(int argc, const char **argv)
 		.target = &target,
 		.result = &lockhash_table[0],
 		.map_nr_entries = bpf_map_entries,
+		.max_stack = max_stack_depth,
+		.stack_skip = stack_skip,
 	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
@@ -1895,6 +1899,12 @@ int cmd_lock(int argc, const char **argv)
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

