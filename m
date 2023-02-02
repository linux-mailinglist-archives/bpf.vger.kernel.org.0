Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3066874E3
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 06:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBBFFD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 00:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBBFFC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 00:05:02 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE22413D6F;
        Wed,  1 Feb 2023 21:05:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mi9so828312pjb.4;
        Wed, 01 Feb 2023 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOU/DIS3FJule2LiTwVBX9EbwBghUDusHfGnb+FT/ZA=;
        b=lCF2pcP/QHMEJGiIPMBZVeaiXjF3+zNSoFftzLQdl+mbYFwFkeNee9PfGMQ6ouvTJw
         G4Mnlg9vSoQ6ljihWWKl2x0ghROZz+9fqYZkBKkpz8UFnspiVr2fFygI5XQwUM0zrwgV
         0GKb+b4Y4Y4vJ32xqROGYeiDUwpI5ygQcWBb0lpYgIZv5nM7yNqA1/1YSG03NSPdGLgs
         CWlcKajH8NQi74hLdtJhl2zZYhPjCse2ZRChebemZRFvfRxSQoUKxIVFJfTdBbh3E+7A
         Qq7i9hx1j7e5lfNA9A9vtrGcVTVtQkem/7L8IFWaYSC9jgnh1A3/7ZHPuNAXzrWmofxM
         +JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fOU/DIS3FJule2LiTwVBX9EbwBghUDusHfGnb+FT/ZA=;
        b=YCGBORA5tUwe1uMl7DC1Ijq+vW7nB1MBbPNf3q9BQHZ6F7PQ8SWYjEmGfYTheuVyxh
         SxFcQ6Wre6j4yADJMcVTEH8FfqF7Djdm9iEEl61AjScmlTg98ublJUgbKMj70nWiab28
         IeN0aApzC814Rh+YURhxwPriBZFSh48NdJHDFRtH2HXMQ7rvyQ2lmPJqDmHOT95eDbFg
         T7KFuCWm4AUuJlXv6OuGKV+E6YVYqq0MNe011jC3c4wkeazKxciBX3BHiyxgj+zLHokQ
         7dj7Sf5Z/MZ1HAO9l/0DLEJCVoyktwG2RorWd1AnT++5F9KxImXZOCX+lOKCHaUffMxI
         sSDA==
X-Gm-Message-State: AO0yUKWYke8qE2vfWbYpe0jQJ8JFTkNxkpIWkQES5m89n/SYZd4kgjIk
        2dD0eKyYvnOmkwXLGUFxt1k=
X-Google-Smtp-Source: AK7set+rqv8FEdCNstXyCgW9LESMkUr3P2/DjhcrPxP/JkZfTormucnKpiCc4y+WzTzaLnBJnGnY/A==
X-Received: by 2002:a17:90a:db8e:b0:22c:147d:137f with SMTP id h14-20020a17090adb8e00b0022c147d137fmr5356825pjv.17.1675314300163;
        Wed, 01 Feb 2023 21:05:00 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:8899:7288:e54d:8b87])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090aba8300b0022bb3ee9b68sm2238374pjr.13.2023.02.01.21.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 21:04:59 -0800 (PST)
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
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: [PATCH 1/4] perf lock contention: Factor out lock_contention_get_name()
Date:   Wed,  1 Feb 2023 21:04:52 -0800
Message-Id: <20230202050455.2187592-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230202050455.2187592-1-namhyung@kernel.org>
References: <20230202050455.2187592-1-namhyung@kernel.org>
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

The lock_contention_get_name() returns a name for the lock stat entry
based on the current aggregation mode.  As it's called sequentially in a
single thread, it can return the address of a static buffer for symbol
and offset of the caller.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c | 113 ++++++++++++++------------
 1 file changed, 63 insertions(+), 50 deletions(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 4902ac331f41..967ce168f163 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -163,9 +163,68 @@ int lock_contention_stop(void)
 	return 0;
 }
 
+static const char *lock_contention_get_name(struct lock_contention *con,
+					    struct contention_key *key,
+					    u64 *stack_trace)
+{
+	int idx = 0;
+	u64 addr;
+	const char *name = "";
+	static char name_buf[KSYM_NAME_LEN];
+	struct symbol *sym;
+	struct map *kmap;
+	struct machine *machine = con->machine;
+
+	if (con->aggr_mode == LOCK_AGGR_TASK) {
+		struct contention_task_data task;
+		struct thread *t;
+		int pid = key->aggr_key;
+		int task_fd = bpf_map__fd(skel->maps.task_data);
+
+		/* do not update idle comm which contains CPU number */
+		if (pid) {
+			bpf_map_lookup_elem(task_fd, &pid, &task);
+			t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
+			thread__set_comm(t, task.comm, /*timestamp=*/0);
+			name = task.comm;
+		}
+		return name;
+	}
+
+	if (con->aggr_mode == LOCK_AGGR_ADDR) {
+		sym = machine__find_kernel_symbol(machine, key->aggr_key, &kmap);
+		if (sym)
+			name = sym->name;
+		return name;
+	}
+
+	/* LOCK_AGGR_CALLER: skip lock internal functions */
+	while (machine__is_lock_function(machine, stack_trace[idx]) &&
+	       idx < con->max_stack - 1)
+		idx++;
+
+	addr = stack_trace[idx];
+	sym = machine__find_kernel_symbol(machine, addr, &kmap);
+
+	if (sym) {
+		unsigned long offset;
+
+		offset = kmap->map_ip(kmap, addr) - sym->start;
+
+		if (offset == 0)
+			return sym->name;
+
+		snprintf(name_buf, sizeof(name_buf), "%s+%#lx", sym->name, offset);
+	} else {
+		snprintf(name_buf, sizeof(name_buf), "%#lx", (unsigned long)addr);
+	}
+
+	return name_buf;
+}
+
 int lock_contention_read(struct lock_contention *con)
 {
-	int fd, stack, task_fd, err = 0;
+	int fd, stack, err = 0;
 	struct contention_key *prev_key, key;
 	struct contention_data data = {};
 	struct lock_stat *st = NULL;
@@ -175,7 +234,6 @@ int lock_contention_read(struct lock_contention *con)
 
 	fd = bpf_map__fd(skel->maps.lock_stat);
 	stack = bpf_map__fd(skel->maps.stacks);
-	task_fd = bpf_map__fd(skel->maps.task_data);
 
 	con->lost = skel->bss->lost;
 
@@ -195,9 +253,6 @@ int lock_contention_read(struct lock_contention *con)
 
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
-		struct map *kmap;
-		struct symbol *sym;
-		int idx = 0;
 		s32 stack_id;
 
 		/* to handle errors in the loop body */
@@ -219,61 +274,19 @@ int lock_contention_read(struct lock_contention *con)
 		st->flags = data.flags;
 		st->addr = key.aggr_key;
 
-		if (con->aggr_mode == LOCK_AGGR_TASK) {
-			struct contention_task_data task;
-			struct thread *t;
-			int pid = key.aggr_key;
-
-			/* do not update idle comm which contains CPU number */
-			if (st->addr) {
-				bpf_map_lookup_elem(task_fd, &pid, &task);
-				t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
-				thread__set_comm(t, task.comm, /*timestamp=*/0);
-			}
-			goto next;
-		}
-
-		if (con->aggr_mode == LOCK_AGGR_ADDR) {
-			sym = machine__find_kernel_symbol(machine, st->addr, &kmap);
-			if (sym)
-				st->name = strdup(sym->name);
-			goto next;
-		}
-
 		stack_id = key.aggr_key;
 		bpf_map_lookup_elem(stack, &stack_id, stack_trace);
 
-		/* skip lock internal functions */
-		while (machine__is_lock_function(machine, stack_trace[idx]) &&
-		       idx < con->max_stack - 1)
-			idx++;
-
-		st->addr = stack_trace[idx];
-		sym = machine__find_kernel_symbol(machine, st->addr, &kmap);
-
-		if (sym) {
-			unsigned long offset;
-			int ret = 0;
-
-			offset = kmap->map_ip(kmap, st->addr) - sym->start;
-
-			if (offset)
-				ret = asprintf(&st->name, "%s+%#lx", sym->name, offset);
-			else
-				st->name = strdup(sym->name);
-
-			if (ret < 0 || st->name == NULL)
-				break;
-		} else if (asprintf(&st->name, "%#lx", (unsigned long)st->addr) < 0) {
+		st->name = strdup(lock_contention_get_name(con, &key, stack_trace));
+		if (st->name == NULL)
 			break;
-		}
 
 		if (con->save_callstack) {
 			st->callstack = memdup(stack_trace, stack_size);
 			if (st->callstack == NULL)
 				break;
 		}
-next:
+
 		hlist_add_head(&st->hash_entry, con->result);
 		prev_key = &key;
 
-- 
2.39.1.456.gfc5497dd1b-goog

