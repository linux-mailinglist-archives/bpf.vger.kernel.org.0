Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060F56874E7
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 06:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjBBFFS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 00:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjBBFFG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 00:05:06 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300C670D7F;
        Wed,  1 Feb 2023 21:05:04 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mi9so828413pjb.4;
        Wed, 01 Feb 2023 21:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55jw19q8kUEYnAPhTjk+7NZAYN/Z3zsEUE3RkruDNgg=;
        b=iLt0fwhrTdeWab77xDTdgnBj4sgdotnGd9W+EmJKaKMW8IbTIi9guj00XPhpUOroz8
         7h6Q3GMS0WxrLyaKVBmgC6Hw5UAoSL9liDX/aU7YbQiG+OtescXa/datB6VXozMU7qZb
         sO6sMBGVLG2bnCw5vFLxU41D2yt1bwcbdyaD7V8nOJpmHJ38MxIJ+alHzE+7wiV4ooQH
         E0eVPdqXTK25a3/EvrgKrzE5VVJ5v8AZG/G7ZsmSoJfMvjuzicA78hTz6G8gyrBCJiuJ
         So7pdcQ12QDyHJ7OeTN+jTGDlyBYIv2lcUMoad3/UnP4jorP6oSpyxBHFerftZNVGE+S
         /foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55jw19q8kUEYnAPhTjk+7NZAYN/Z3zsEUE3RkruDNgg=;
        b=oODJgyg+PcAV5DcxEdP8lJt+KD7zaC4plC84k6GfeDYwa7+7e8v8/AnUpUN+MDeVxx
         yUFAv92rA0g0fcxX/7Tdv+Ai+txHOFvRJoGfSBeTKQvAlL5feCLS+83O/RRqCLU4EVfz
         ux9BHqDSeLS81VlDa2H0r5zZWPAN2wxrPXDyweuiDu2F5KtMP39jxImit/Nhi6RS/7E6
         GLAfPwFWjvdieM7HrhiA5mcqfSY7Q4XJUm+Uk2wbNcTYge9wOXPYRt4DlyNv3XlARH4a
         fqOSZcLeOLd7Xjkvk+VXnJXR+ePiJrn8r0/tQxy3tn1DiBV0IbYcxCrCOGDTlLw9iCJr
         y4mw==
X-Gm-Message-State: AO0yUKVmKg1NHzOjZb99qFvDGV3Fc3UJtDL/2FVXeRYm2RdHqoCF6imT
        slEW94IGzl106Ps7WeVEU/DHb/kI73s=
X-Google-Smtp-Source: AK7set/NMaJheSrOBHJJmxgMlRDpg2hkpjHq1M70cSgcntjqaQbxYe1xfrrEAf86aOmE9agyrzkRQg==
X-Received: by 2002:a17:90a:30d:b0:22c:932:2870 with SMTP id 13-20020a17090a030d00b0022c09322870mr5144511pje.33.1675314303647;
        Wed, 01 Feb 2023 21:05:03 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:8899:7288:e54d:8b87])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090aba8300b0022bb3ee9b68sm2238374pjr.13.2023.02.01.21.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 21:05:03 -0800 (PST)
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
Subject: [PATCH 3/4] perf lock contention: Support filters for different aggregation
Date:   Wed,  1 Feb 2023 21:04:54 -0800
Message-Id: <20230202050455.2187592-4-namhyung@kernel.org>
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

It'd be useful to filter other than the current aggregation mode.  For
example, users may want to see callstacks for specific locks only.  Or
they may want tasks from a certain callstack.

The tracepoints already collected the information but it needs to check
the condition again when processing the event.  And it needs to change
BPF to allow the key combinations.

The lock contentions on 'rcu_state' spinlock can be monitored:

  $ sudo perf lock con -abv -L rcu_state sleep 1
  ...
   contended   total wait     max wait     avg wait         type   caller

           4    151.39 us     62.57 us     37.85 us     spinlock   rcu_core+0xcb
                          0xffffffff81fd1666  _raw_spin_lock_irqsave+0x46
                          0xffffffff8172d76b  rcu_core+0xcb
                          0xffffffff822000eb  __softirqentry_text_start+0xeb
                          0xffffffff816a0ba9  __irq_exit_rcu+0xc9
                          0xffffffff81fc0112  sysvec_apic_timer_interrupt+0xa2
                          0xffffffff82000e46  asm_sysvec_apic_timer_interrupt+0x16
                          0xffffffff81d49f78  cpuidle_enter_state+0xd8
                          0xffffffff81d4a259  cpuidle_enter+0x29
           1     30.21 us     30.21 us     30.21 us     spinlock   rcu_core+0xcb
                          0xffffffff81fd1666  _raw_spin_lock_irqsave+0x46
                          0xffffffff8172d76b  rcu_core+0xcb
                          0xffffffff822000eb  __softirqentry_text_start+0xeb
                          0xffffffff816a0ba9  __irq_exit_rcu+0xc9
                          0xffffffff81fc00c4  sysvec_apic_timer_interrupt+0x54
                          0xffffffff82000e46  asm_sysvec_apic_timer_interrupt+0x16
           1     28.84 us     28.84 us     28.84 us     spinlock   rcu_accelerate_cbs_unlocked+0x40
                          0xffffffff81fd1c60  _raw_spin_lock+0x30
                          0xffffffff81728cf0  rcu_accelerate_cbs_unlocked+0x40
                          0xffffffff8172da82  rcu_core+0x3e2
                          0xffffffff822000eb  __softirqentry_text_start+0xeb
                          0xffffffff816a0ba9  __irq_exit_rcu+0xc9
                          0xffffffff81fc0112  sysvec_apic_timer_interrupt+0xa2
                          0xffffffff82000e46  asm_sysvec_apic_timer_interrupt+0x16
                          0xffffffff81d49f78  cpuidle_enter_state+0xd8
  ...

To see tasks calling 'rcu_core' function:

  $ sudo perf lock con -abt -S rcu_core sleep 1
   contended   total wait     max wait     avg wait          pid   comm

          19     23.46 us      2.21 us      1.23 us            0   swapper
           2     18.37 us     17.01 us      9.19 us      2061859   ThreadPoolForeg
           3      5.76 us      1.97 us      1.92 us         3909   pipewire-pulse
           1      2.26 us      2.26 us      2.26 us      1809271   MediaSu~isor #2
           1      1.97 us      1.97 us      1.97 us      1514882   Chrome_ChildIOT
           1       987 ns       987 ns       987 ns         3740   pipewire-pulse

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c                     | 75 +++++++++++--------
 tools/perf/util/bpf_lock_contention.c         | 44 +++++++----
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 15 ++--
 tools/perf/util/bpf_skel/lock_data.h          |  4 +-
 tools/perf/util/lock-contention.h             |  2 +
 5 files changed, 89 insertions(+), 51 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 0593c6e636c6..0d11f301fd72 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -509,6 +509,34 @@ struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
 	return NULL;
 }
 
+bool match_callstack_filter(struct machine *machine, u64 *callstack)
+{
+	struct map *kmap;
+	struct symbol *sym;
+	u64 ip;
+
+	if (list_empty(&callstack_filters))
+		return true;
+
+	for (int i = 0; i < max_stack_depth; i++) {
+		struct callstack_filter *filter;
+
+		if (!callstack || !callstack[i])
+			break;
+
+		ip = callstack[i];
+		sym = machine__find_kernel_symbol(machine, ip, &kmap);
+		if (sym == NULL)
+			continue;
+
+		list_for_each_entry(filter, &callstack_filters, list) {
+			if (strstr(sym->name, filter->name))
+				return true;
+		}
+	}
+	return false;
+}
+
 struct trace_lock_handler {
 	/* it's used on CONFIG_LOCKDEP */
 	int (*acquire_event)(struct evsel *evsel,
@@ -1070,12 +1098,6 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		ls = lock_stat_findnew(key, name, flags);
 		if (!ls)
 			return -ENOMEM;
-
-		if (aggr_mode == LOCK_AGGR_CALLER && needs_callstack()) {
-			ls->callstack = get_callstack(sample, max_stack_depth);
-			if (ls->callstack == NULL)
-				return -ENOMEM;
-		}
 	}
 
 	if (filters.nr_types) {
@@ -1106,6 +1128,22 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 			return 0;
 	}
 
+	if (needs_callstack()) {
+		u64 *callstack = get_callstack(sample, max_stack_depth);
+		if (callstack == NULL)
+			return -ENOMEM;
+
+		if (!match_callstack_filter(machine, callstack)) {
+			free(callstack);
+			return 0;
+		}
+
+		if (ls->callstack == NULL)
+			ls->callstack = callstack;
+		else
+			free(callstack);
+	}
+
 	ts = thread_stat_findnew(sample->tid);
 	if (!ts)
 		return -ENOMEM;
@@ -1606,31 +1644,6 @@ static void print_contention_result(struct lock_contention *con)
 		if (!st->wait_time_total)
 			continue;
 
-		if (aggr_mode == LOCK_AGGR_CALLER && !list_empty(&callstack_filters)) {
-			struct map *kmap;
-			struct symbol *sym;
-			u64 ip;
-
-			for (int i = 0; i < max_stack_depth; i++) {
-				struct callstack_filter *filter;
-
-				if (!st->callstack || !st->callstack[i])
-					break;
-
-				ip = st->callstack[i];
-				sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
-				if (sym == NULL)
-					continue;
-
-				list_for_each_entry(filter, &callstack_filters, list) {
-					if (strstr(sym->name, filter->name))
-						goto found;
-				}
-			}
-			continue;
-		}
-
-found:
 		list_for_each_entry(key, &lock_keys, list) {
 			key->print(key, st);
 			pr_info(" ");
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index c6f2db603d5a..3b4308b7b6bf 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -34,13 +34,15 @@ int lock_contention_prepare(struct lock_contention *con)
 	bpf_map__set_max_entries(skel->maps.lock_stat, con->map_nr_entries);
 	bpf_map__set_max_entries(skel->maps.tstamp, con->map_nr_entries);
 
-	if (con->aggr_mode == LOCK_AGGR_TASK) {
+	if (con->aggr_mode == LOCK_AGGR_TASK)
 		bpf_map__set_max_entries(skel->maps.task_data, con->map_nr_entries);
-		bpf_map__set_max_entries(skel->maps.stacks, 1);
-	} else {
+	else
 		bpf_map__set_max_entries(skel->maps.task_data, 1);
+
+	if (con->save_callstack)
 		bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_entries);
-	}
+	else
+		bpf_map__set_max_entries(skel->maps.stacks, 1);
 
 	if (target__has_cpu(target))
 		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
@@ -146,6 +148,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	/* these don't work well if in the rodata section */
 	skel->bss->stack_skip = con->stack_skip;
 	skel->bss->aggr_mode = con->aggr_mode;
+	skel->bss->needs_callstack = con->save_callstack;
 
 	lock_contention_bpf__attach(skel);
 	return 0;
@@ -178,7 +181,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	if (con->aggr_mode == LOCK_AGGR_TASK) {
 		struct contention_task_data task;
 		struct thread *t;
-		int pid = key->aggr_key;
+		int pid = key->pid;
 		int task_fd = bpf_map__fd(skel->maps.task_data);
 
 		/* do not update idle comm which contains CPU number */
@@ -192,7 +195,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 	}
 
 	if (con->aggr_mode == LOCK_AGGR_ADDR) {
-		sym = machine__find_kernel_symbol(machine, key->aggr_key, &kmap);
+		sym = machine__find_kernel_symbol(machine, key->lock_addr, &kmap);
 		if (sym)
 			name = sym->name;
 		return name;
@@ -253,20 +256,35 @@ int lock_contention_read(struct lock_contention *con)
 
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
-		s32 stack_id;
+		s64 ls_key;
 		const char *name;
 
 		/* to handle errors in the loop body */
 		err = -1;
 
 		bpf_map_lookup_elem(fd, &key, &data);
-
 		if (con->save_callstack) {
-			stack_id = key.aggr_key;
-			bpf_map_lookup_elem(stack, &stack_id, stack_trace);
+			bpf_map_lookup_elem(stack, &key.stack_id, stack_trace);
+
+			if (!match_callstack_filter(machine, stack_trace))
+				goto next;
 		}
 
-		st = lock_stat_find(key.aggr_key);
+		switch (con->aggr_mode) {
+		case LOCK_AGGR_CALLER:
+			ls_key = key.stack_id;
+			break;
+		case LOCK_AGGR_TASK:
+			ls_key = key.pid;
+			break;
+		case LOCK_AGGR_ADDR:
+			ls_key = key.lock_addr;
+			break;
+		default:
+			goto next;
+		}
+
+		st = lock_stat_find(ls_key);
 		if (st != NULL) {
 			st->wait_time_total += data.total_time;
 			if (st->wait_time_max < data.max_time)
@@ -281,7 +299,7 @@ int lock_contention_read(struct lock_contention *con)
 		}
 
 		name = lock_contention_get_name(con, &key, stack_trace);
-		st = lock_stat_findnew(key.aggr_key, name, data.flags);
+		st = lock_stat_findnew(ls_key, name, data.flags);
 		if (st == NULL)
 			break;
 
@@ -293,8 +311,6 @@ int lock_contention_read(struct lock_contention *con)
 		if (data.count)
 			st->avg_wait_time = data.total_time / data.count;
 
-		st->flags = data.flags;
-
 		if (con->save_callstack) {
 			st->callstack = memdup(stack_trace, stack_size);
 			if (st->callstack == NULL)
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index ad0ca5d50557..7ce276ed987e 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -82,6 +82,7 @@ int has_cpu;
 int has_task;
 int has_type;
 int has_addr;
+int needs_callstack;
 int stack_skip;
 
 /* determine the key of lock stat */
@@ -173,7 +174,7 @@ int contention_begin(u64 *ctx)
 	pelem->lock = (__u64)ctx[0];
 	pelem->flags = (__u32)ctx[1];
 
-	if (aggr_mode == LOCK_AGGR_CALLER) {
+	if (needs_callstack) {
 		pelem->stack_id = bpf_get_stackid(ctx, &stacks,
 						  BPF_F_FAST_STACK_CMP | stack_skip);
 		if (pelem->stack_id < 0)
@@ -188,7 +189,7 @@ int contention_end(u64 *ctx)
 {
 	__u32 pid;
 	struct tstamp_data *pelem;
-	struct contention_key key;
+	struct contention_key key = {};
 	struct contention_data *data;
 	__u64 duration;
 
@@ -204,14 +205,18 @@ int contention_end(u64 *ctx)
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_CALLER:
-		key.aggr_key = pelem->stack_id;
+		key.stack_id = pelem->stack_id;
 		break;
 	case LOCK_AGGR_TASK:
-		key.aggr_key = pid;
+		key.pid = pid;
 		update_task_data(pid);
+		if (needs_callstack)
+			key.stack_id = pelem->stack_id;
 		break;
 	case LOCK_AGGR_ADDR:
-		key.aggr_key = pelem->lock;
+		key.lock_addr = pelem->lock;
+		if (needs_callstack)
+			key.stack_id = pelem->stack_id;
 		break;
 	default:
 		/* should not happen */
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index ce71cf1a7e1e..3d35fd4407ac 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -4,7 +4,9 @@
 #define UTIL_BPF_SKEL_LOCK_DATA_H
 
 struct contention_key {
-	u64 aggr_key;  /* can be stack_id, pid or lock addr */
+	u32 stack_id;
+	u32 pid;
+	u64 lock_addr;
 };
 
 #define TASK_COMM_LEN  16
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 39d5bfc77f4e..e5fc036108ec 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -68,6 +68,8 @@ struct lock_stat {
 struct lock_stat *lock_stat_find(u64 addr);
 struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
 
+bool match_callstack_filter(struct machine *machine, u64 *callstack);
+
 /*
  * struct lock_seq_stat:
  * Place to put on state of one lock sequence
-- 
2.39.1.456.gfc5497dd1b-goog

