Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D86488D2
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 20:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiLITHj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 14:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiLITHf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 14:07:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406D1012;
        Fri,  9 Dec 2022 11:07:33 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 4so5887488pli.0;
        Fri, 09 Dec 2022 11:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwTfL0kKYTF0adsT64MgLXJKXYchBqVGT1PKMwmP0aw=;
        b=kezPGi3vgNhkaDI9UImYJllOrlZs9FuJL+9LAQwe30hkWzHpxkSgsaPLkkQyk+oFhf
         QuU8TYVwGwh4mfVU2v+jNLqjDtt+LejKzGCNwfPrg9xd6pw10u8AjazFc9DHx7TDpG4F
         sN13nhHzksVBEFhfc+6DxZJ9gC9+8+Gsa7nYTbDLz7DjcJFKoL/w/F0RpaOBYzq/l6YU
         k1xFdqiJQgs/ee1xTGtsSk6eo+sTPF8gspY+cPhnGeJuGgFHyCLYOk3XVLnFj5r6ESAA
         hIaS2RdSs9la2OueaYtEpaZk5EeC/uIDndl7VZX4pPIaTPSlbC1ZovUheoQF2/oRjxlF
         Kz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwTfL0kKYTF0adsT64MgLXJKXYchBqVGT1PKMwmP0aw=;
        b=w7/Og49frtliqU/1sjAb7v3DgajNYsP0//1INMBy6wGeAHkGFhwrC/HUBiGLl5RZtD
         ph6unoEWMc17uFB3+DMTANWxQWrbV3XWKODXoZsddfg6zUnO9+qKPWg7virxCzrlARuY
         R9TAV3ZDpyXc4Mj8tZJtdB4vVOoreQzAeMaO4w0iOLgTbl7z21YD2GEWyOh+H3rcdF9Z
         WfWPuX9rjjcTqQVnENGE3og4dklmT1zvAxOWPnLSQhSWVkGqrtRS4e0UkpQAKBh+RHTX
         Ox8FF58kXOQWS9jLnZs4esW+P3J7sxjxVz7qbbYKU1YPCnbbHISgcce5Bc8OE4RaGmeD
         Kn2w==
X-Gm-Message-State: ANoB5pmSQ2I9nlilmtphK6No7dQjdEXt5dzsRtwVM1U6HsiOoCypiHY1
        icNt+JE6dsPBKmBE9FleRHU=
X-Google-Smtp-Source: AA0mqf4ROZfFScaahkNAlZSBVfn4hJIDZE+t4RCv6Nt4d9lSbPKnhrir9X9eK3+xOwMJyAsXmPLUbg==
X-Received: by 2002:a17:90a:ac07:b0:219:aa58:77ba with SMTP id o7-20020a17090aac0700b00219aa5877bamr6769116pjq.25.1670612853422;
        Fri, 09 Dec 2022 11:07:33 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:c952:d848:9e00:3cce])
        by smtp.gmail.com with ESMTPSA id nd17-20020a17090b4cd100b002135de3013fsm1431432pjb.32.2022.12.09.11.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:07:33 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: [PATCH 2/4] perf lock contention: Implement -t/--threads option for BPF
Date:   Fri,  9 Dec 2022 11:07:25 -0800
Message-Id: <20221209190727.759804-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209190727.759804-1-namhyung@kernel.org>
References: <20221209190727.759804-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF didn't show the per-thread stat properly.  Use task's thread id (PID)
as a key instead of stack_id and add a task_data map to save task comm names.

  $ sudo ./perf lock con -abt -E 5 sleep 1
   contended   total wait     max wait     avg wait          pid   comm

           1    740.66 ms    740.66 ms    740.66 ms         1950   nv_queue
           3    305.50 ms    298.19 ms    101.83 ms         1884   nvidia-modeset/
           1     25.14 us     25.14 us     25.14 us      2725038   EventManager_De
          12     23.09 us      9.30 us      1.92 us            0   swapper
           1     20.18 us     20.18 us     20.18 us      2725033   EventManager_De

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                     | 13 ++----
 tools/perf/util/bpf_lock_contention.c         | 40 ++++++++++++++++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 41 +++++++++++++++++--
 tools/perf/util/lock-contention.h             |  1 +
 4 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 15ce6358f127..6fa3cdfec5cb 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -12,6 +12,7 @@
 #include "util/target.h"
 #include "util/callchain.h"
 #include "util/lock-contention.h"
+#include "util/bpf_skel/lock_data.h"
 
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
@@ -61,11 +62,7 @@ static int max_stack_depth = CONTENTION_STACK_DEPTH;
 static int stack_skip = CONTENTION_STACK_SKIP;
 static int print_nr_entries = INT_MAX / 2;
 
-static enum {
-	LOCK_AGGR_ADDR,
-	LOCK_AGGR_TASK,
-	LOCK_AGGR_CALLER,
-} aggr_mode = LOCK_AGGR_ADDR;
+static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
 
 static struct thread_stat *thread_stat_find(u32 tid)
 {
@@ -1619,6 +1616,7 @@ static int __cmd_contention(int argc, const char **argv)
 		.map_nr_entries = bpf_map_entries,
 		.max_stack = max_stack_depth,
 		.stack_skip = stack_skip,
+		.aggr_mode = show_thread_stats ? LOCK_AGGR_TASK : LOCK_AGGR_CALLER,
 	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
@@ -1691,11 +1689,6 @@ static int __cmd_contention(int argc, const char **argv)
 	if (select_key(true))
 		goto out_delete;
 
-	if (show_thread_stats)
-		aggr_mode = LOCK_AGGR_TASK;
-	else
-		aggr_mode = LOCK_AGGR_CALLER;
-
 	if (use_bpf) {
 		lock_contention_start();
 		if (argc)
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index b6a8eb7164b3..1590a9f05145 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -5,6 +5,7 @@
 #include "util/map.h"
 #include "util/symbol.h"
 #include "util/target.h"
+#include "util/thread.h"
 #include "util/thread_map.h"
 #include "util/lock-contention.h"
 #include <linux/zalloc.h>
@@ -30,10 +31,17 @@ int lock_contention_prepare(struct lock_contention *con)
 	}
 
 	bpf_map__set_value_size(skel->maps.stacks, con->max_stack * sizeof(u64));
-	bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
 	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_nr_entries);
 	bpf_map__set_max_entries(skel->maps.tstamp, con->map_nr_entries);
 
+	if (con->aggr_mode == LOCK_AGGR_TASK) {
+		bpf_map__set_max_entries(skel->maps.task_data, con->map_nr_entries);
+		bpf_map__set_max_entries(skel->maps.stacks, 1);
+	} else {
+		bpf_map__set_max_entries(skel->maps.task_data, 1);
+		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
+	}
+
 	if (target__has_cpu(target))
 		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
 	if (target__has_task(target))
@@ -82,7 +90,9 @@ int lock_contention_prepare(struct lock_contention *con)
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
 	}
 
+	/* these don't work well if in the rodata section */
 	skel->bss->stack_skip = con->stack_skip;
+	skel->bss->aggr_mode = con->aggr_mode;
 
 	lock_contention_bpf__attach(skel);
 	return 0;
@@ -102,7 +112,7 @@ int lock_contention_stop(void)
 
 int lock_contention_read(struct lock_contention *con)
 {
-	int fd, stack, err = 0;
+	int fd, stack, task_fd, err = 0;
 	struct contention_key *prev_key, key;
 	struct contention_data data = {};
 	struct lock_stat *st = NULL;
@@ -112,6 +122,7 @@ int lock_contention_read(struct lock_contention *con)
 
 	fd = bpf_map__fd(skel->maps.lock_stat);
 	stack = bpf_map__fd(skel->maps.stacks);
+	task_fd = bpf_map__fd(skel->maps.task_data);
 
 	con->lost = skel->bss->lost;
 
@@ -119,6 +130,13 @@ int lock_contention_read(struct lock_contention *con)
 	if (stack_trace == NULL)
 		return -1;
 
+	if (con->aggr_mode == LOCK_AGGR_TASK) {
+		struct thread *idle = __machine__findnew_thread(machine,
+								/*pid=*/0,
+								/*tid=*/0);
+		thread__set_comm(idle, "swapper", /*timestamp=*/0);
+	}
+
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
 		struct map *kmap;
@@ -143,6 +161,22 @@ int lock_contention_read(struct lock_contention *con)
 
 		st->flags = data.flags;
 
+		if (con->aggr_mode == LOCK_AGGR_TASK) {
+			struct contention_task_data task;
+			struct thread *t;
+
+			st->addr = key.stack_or_task_id;
+
+			/* do not update idle comm which contains CPU number */
+			if (st->addr) {
+				bpf_map_lookup_elem(task_fd, &key, &task);
+				t = __machine__findnew_thread(machine, /*pid=*/-1,
+							      key.stack_or_task_id);
+				thread__set_comm(t, task.comm, /*timestamp=*/0);
+			}
+			goto next;
+		}
+
 		bpf_map_lookup_elem(stack, &key, stack_trace);
 
 		/* skip lock internal functions */
@@ -175,7 +209,7 @@ int lock_contention_read(struct lock_contention *con)
 			if (st->callstack == NULL)
 				break;
 		}
-
+next:
 		hlist_add_head(&st->hash_entry, con->result);
 		prev_key = &key;
 
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 0f63cc28ccba..cd405adcd252 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -41,6 +41,13 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } lock_stat SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct contention_task_data));
+	__uint(max_entries, MAX_ENTRIES);
+} task_data SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(key_size, sizeof(__u32));
@@ -61,6 +68,9 @@ int has_cpu;
 int has_task;
 int stack_skip;
 
+/* determine the key of lock stat */
+int aggr_mode;
+
 /* error stat */
 int lost;
 
@@ -87,6 +97,19 @@ static inline int can_record(void)
 	return 1;
 }
 
+static inline void update_task_data(__u32 pid)
+{
+	struct contention_task_data *p;
+
+	p = bpf_map_lookup_elem(&task_data, &pid);
+	if (p == NULL) {
+		struct contention_task_data data;
+
+		bpf_get_current_comm(data.comm, sizeof(data.comm));
+		bpf_map_update_elem(&task_data, &pid, &data, BPF_NOEXIST);
+	}
+}
+
 SEC("tp_btf/contention_begin")
 int contention_begin(u64 *ctx)
 {
@@ -115,10 +138,14 @@ int contention_begin(u64 *ctx)
 	pelem->timestamp = bpf_ktime_get_ns();
 	pelem->lock = (__u64)ctx[0];
 	pelem->flags = (__u32)ctx[1];
-	pelem->stack_id = bpf_get_stackid(ctx, &stacks, BPF_F_FAST_STACK_CMP | stack_skip);
 
-	if (pelem->stack_id < 0)
-		lost++;
+	if (aggr_mode == LOCK_AGGR_CALLER) {
+		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
+						  BPF_F_FAST_STACK_CMP | stack_skip);
+		if (pelem->stack_id < 0)
+			lost++;
+	}
+
 	return 0;
 }
 
@@ -141,7 +168,13 @@ int contention_end(u64 *ctx)
 
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
 
-	key.stack_id = pelem->stack_id;
+	if (aggr_mode == LOCK_AGGR_CALLER) {
+		key.stack_or_task_id = pelem->stack_id;
+	} else {
+		key.stack_or_task_id = pid;
+		update_task_data(pid);
+	}
+
 	data = bpf_map_lookup_elem(&lock_stat, &key);
 	if (!data) {
 		struct contention_data first = {
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index a2346875098d..47fd47fb56c1 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -117,6 +117,7 @@ struct lock_contention {
 	int lost;
 	int max_stack;
 	int stack_skip;
+	int aggr_mode;
 };
 
 #ifdef HAVE_BPF_SKEL
-- 
2.39.0.rc1.256.g54fd8350bd-goog

