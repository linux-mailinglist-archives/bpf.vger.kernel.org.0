Return-Path: <bpf+bounces-2097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4A27276C7
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 07:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8142C1C20E97
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 05:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5704C95;
	Thu,  8 Jun 2023 05:38:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB3C46B6
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 05:38:49 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE5268E;
	Wed,  7 Jun 2023 22:38:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b24eba185cso601785ad.2;
        Wed, 07 Jun 2023 22:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686202727; x=1688794727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KbuJyzse4Bi2WrII0Cx/yNSeDiTgYsBnY8PUYJS2XiI=;
        b=mmVuqZEpjAiOSV9R4PtxGwg8NnOnX9g571CiKvdZenHFtpUgjUrMbvJZer+L2R6hXe
         5EXJQVwpd+G4EMeRL5g3D6I46ZSLQ3C70ci9u4Hyv5bVWMA6stcxYgtgGR3FTpbkIa4+
         0qvP0C5M92Bd8XztcxsxGLhp7O7wbx5oyg3vTqqW9XJFibQp+Z5NmlxhbHvhOaMAvjud
         /kQPxJsSuiyqj3SXrXNmNtGyyDpTgAGJ+TznkWs4/PUk4XOkonMfDowmqQdqOHn++o1y
         FwkXMgZh5TErguVqq4auxTKBMm/Z6R6pxFIGY1Ze0dLq34n3tJ9UdylBlhIJ+qs1pDeq
         KIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686202727; x=1688794727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbuJyzse4Bi2WrII0Cx/yNSeDiTgYsBnY8PUYJS2XiI=;
        b=Z6OFK9B4s64BhCbXIpdYLawurZClWbza++ScVXLqIOYza6LggzNRSmbEoNACPwDKOz
         may7ZMRRYuy4q6QpXD4U3TUnohiKIsDCHuV4jop3bE5fAmvymloDI5/iFGtkkzedW8ue
         rbA5+9TZTqupa8jZohauTRGljRdqMBNrMygoWCwwitLX+/WgapwNCV889Y9ennXQmUbi
         vZ/8RItML+4YwwPYga4oJX9joPr6Lr9dvltotolG7nijKlhLs1X3ZvPXct6ive3vpYwG
         HgUfCKqSQGJXYaIIpekWlBKH9Zd5F0Oz5wSz5QAd9QCSnCh4C5BmAU2wp9xvWTNw3VWd
         5piQ==
X-Gm-Message-State: AC+VfDwDmF/jx2riwiyu/h4aNsfEvgRnMtjL8wQwhlcDfRtcHL8akE3P
	6opLq27WrlIAsG4OyvSaCmBYsPzyjVs=
X-Google-Smtp-Source: ACHHUZ6ta9eb2GbSSNeGbPk7i0Ocx/UGi+9/WW3uSqQ783xtbx7bm6hfB3y9PqVeoc9svkNVyVr7Ug==
X-Received: by 2002:a17:903:1110:b0:1a6:74f6:fa92 with SMTP id n16-20020a170903111000b001a674f6fa92mr4746911plh.19.1686202726626;
        Wed, 07 Jun 2023 22:38:46 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:151d:c55c:d8a1:495a])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709027fc700b001a63ba28052sm485626plb.69.2023.06.07.22.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 22:38:46 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH] perf lock contention: Add -x option for CSV style output
Date: Wed,  7 Jun 2023 22:38:44 -0700
Message-ID: <20230608053844.2872345-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Sometimes we want to process the output by external programs.  Let's add
the -x option to specify the field separator like perf stat.

  $ sudo ./perf lock con -ab -x, sleep 1
  # output: contended, total wait, max wait, avg wait, type, caller
  19, 194232, 21415, 10222, spinlock, process_one_work+0x1f0
  15, 162748, 23843, 10849, rwsem:R, do_user_addr_fault+0x40e
  4, 86740, 23415, 21685, rwlock:R, ep_poll_callback+0x2d
  1, 84281, 84281, 84281, mutex, iwl_mvm_async_handlers_wk+0x135
  8, 67608, 27404, 8451, spinlock, __queue_work+0x174
  3, 58616, 31125, 19538, rwsem:W, do_mprotect_pkey+0xff
  3, 52953, 21172, 17651, rwlock:W, do_epoll_wait+0x248
  2, 30324, 19704, 15162, rwsem:R, do_madvise+0x3ad
  1, 24619, 24619, 24619, spinlock, rcu_core+0xd4

The first line is a comment that shows the output format.  Each line is
separated by the given string ("," in this case).  The time is printed
in nsec without the unit so that it can be parsed easily.

The characters can be used in the output like (":", "+" and ".") are not
allowed for the -x option.

  $ ./perf lock con -x:
  Cannot use the separator that is already used

   Usage: perf lock contention [<options>]

      -x, --field-separator <separator>
                            print result in CSV format with custom separator

The stacktraces are printed in the same line separated by ":".  The
header is updated to show the stacktrace.  Also the debug output is
added at the end as a comment.

  $ sudo ./perf lock con -abv -x, -F wait_total sleep 1
  Looking at the vmlinux_path (8 entries long)
  symsrc__init: cannot get elf header.
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
  # output: total wait, type, caller, stacktrace
  37134, spinlock, rcu_core+0xd4, 0xffffffff9d0401e4 _raw_spin_lock_irqsave+0x44: 0xffffffff9c738114 rcu_core+0xd4: ...
  21213, spinlock, raw_spin_rq_lock_nested+0x1b, 0xffffffff9d0407c0 _raw_spin_lock+0x30: 0xffffffff9c6d9cfb raw_spin_rq_lock_nested+0x1b: ...
  20506, rwlock:W, ep_done_scan+0x2d, 0xffffffff9c9bc4dd ep_done_scan+0x2d: 0xffffffff9c9bd5f1 do_epoll_wait+0x6d1: ...
  18044, rwlock:R, ep_poll_callback+0x2d, 0xffffffff9d040555 _raw_read_lock_irqsave+0x45: 0xffffffff9c9bc81d ep_poll_callback+0x2d: ...
  17890, rwlock:W, do_epoll_wait+0x47b, 0xffffffff9c9bd39b do_epoll_wait+0x47b: 0xffffffff9c9be9ef __x64_sys_epoll_wait+0x6d1: ...
  12114, spinlock, futex_wait_queue+0x60, 0xffffffff9d0407c0 _raw_spin_lock+0x30: 0xffffffff9d037cae __schedule+0xbe: ...
  # debug: total=7, bad=0, bad_task=0, bad_stack=0, bad_time=0, bad_data=0

Also note that some field (like lock symbols) can be empty.

  $ sudo ./perf lock con -abl -x, -E 10 sleep 1
  # output: contended, total wait, max wait, avg wait, address, symbol, type
  6, 275025, 61764, 45837, ffff9dcc9f7d60d0, , spinlock
  18, 87716, 11196, 4873, ffff9dc540059000, , spinlock
  2, 6472, 5499, 3236, ffff9dcc7f730e00, rq_lock, spinlock
  3, 4429, 2341, 1476, ffff9dcc7f7b0e00, rq_lock, spinlock
  3, 3974, 1635, 1324, ffff9dcc7f7f0e00, rq_lock, spinlock
  4, 3290, 1326, 822, ffff9dc5f4e2cde0, , rwlock
  3, 2894, 1023, 964, ffffffff9e0d7700, rcu_state, spinlock
  1, 2567, 2567, 2567, ffff9dcc7f6b0e00, rq_lock, spinlock
  4, 1259, 596, 314, ffff9dc69c2adde0, , rwlock
  1, 934, 934, 934, ffff9dcc7f670e00, rq_lock, spinlock

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |   5 +
 tools/perf/builtin-lock.c              | 303 +++++++++++++++++++------
 2 files changed, 241 insertions(+), 67 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 6e5ba3cd2b72..d1efcbe7a470 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -200,6 +200,11 @@ CONTENTION OPTIONS
 	Note that it matches the substring so 'rq' would match both 'raw_spin_rq_lock'
 	and 'irq_enter_rcu'.
 
+-x::
+--field-separator=<SEP>::
+	Show results using a CSV-style output to make it easy to import directly
+	into spreadsheets. Columns are separated by the string specified in SEP.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index fc8356bd6e3a..52c87cc3d224 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -225,6 +225,12 @@ static void lock_stat_key_print_time(unsigned long long nsec, int len)
 		{ 0, NULL },
 	};
 
+	/* for CSV output */
+	if (len == 0) {
+		pr_info("%llu", nsec);
+		return;
+	}
+
 	for (int i = 0; table[i].unit; i++) {
 		if (nsec < table[i].base)
 			continue;
@@ -1623,11 +1629,179 @@ static void sort_contention_result(void)
 	sort_result();
 }
 
-static void print_bpf_events(int total, struct lock_contention_fails *fails)
+static void print_header_stdio(void)
+{
+	struct lock_key *key;
+
+	list_for_each_entry(key, &lock_keys, list)
+		pr_info("%*s ", key->len, key->header);
+
+	switch (aggr_mode) {
+	case LOCK_AGGR_TASK:
+		pr_info("  %10s   %s\n\n", "pid",
+			show_lock_owner ? "owner" : "comm");
+		break;
+	case LOCK_AGGR_CALLER:
+		pr_info("  %10s   %s\n\n", "type", "caller");
+		break;
+	case LOCK_AGGR_ADDR:
+		pr_info("  %16s   %s\n\n", "address", "symbol");
+		break;
+	default:
+		break;
+	}
+}
+
+static void print_header_csv(const char *sep)
+{
+	struct lock_key *key;
+
+	pr_info("# output: ");
+	list_for_each_entry(key, &lock_keys, list)
+		pr_info("%s%s ", key->header, sep);
+
+	switch (aggr_mode) {
+	case LOCK_AGGR_TASK:
+		pr_info("%s%s %s\n", "pid", sep,
+			show_lock_owner ? "owner" : "comm");
+		break;
+	case LOCK_AGGR_CALLER:
+		pr_info("%s%s %s", "type", sep, "caller");
+		if (verbose > 0)
+			pr_info("%s %s", sep, "stacktrace");
+		pr_info("\n");
+		break;
+	case LOCK_AGGR_ADDR:
+		pr_info("%s%s %s%s %s\n", "address", sep, "symbol", sep, "type");
+		break;
+	default:
+		break;
+	}
+}
+
+static void print_header(void)
+{
+	if (!quiet) {
+		if (symbol_conf.field_sep)
+			print_header_csv(symbol_conf.field_sep);
+		else
+			print_header_stdio();
+	}
+}
+
+static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat *st)
+{
+	struct lock_key *key;
+	struct thread *t;
+	int pid;
+
+	list_for_each_entry(key, &lock_keys, list) {
+		key->print(key, st);
+		pr_info(" ");
+	}
+
+	switch (aggr_mode) {
+	case LOCK_AGGR_CALLER:
+		pr_info("  %10s   %s\n", get_type_str(st->flags), st->name);
+		break;
+	case LOCK_AGGR_TASK:
+		pid = st->addr;
+		t = perf_session__findnew(session, pid);
+		pr_info("  %10d   %s\n",
+			pid, pid == -1 ? "Unknown" : thread__comm_str(t));
+		break;
+	case LOCK_AGGR_ADDR:
+		pr_info("  %016llx   %s (%s)\n", (unsigned long long)st->addr,
+			st->name, get_type_name(st->flags));
+		break;
+	default:
+		break;
+	}
+
+	if (aggr_mode == LOCK_AGGR_CALLER && verbose > 0) {
+		struct map *kmap;
+		struct symbol *sym;
+		char buf[128];
+		u64 ip;
+
+		for (int i = 0; i < max_stack_depth; i++) {
+			if (!st->callstack || !st->callstack[i])
+				break;
+
+			ip = st->callstack[i];
+			sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
+			get_symbol_name_offset(kmap, sym, ip, buf, sizeof(buf));
+			pr_info("\t\t\t%#lx  %s\n", (unsigned long)ip, buf);
+		}
+	}
+}
+
+static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *st,
+				const char *sep)
+{
+	struct lock_key *key;
+	struct thread *t;
+	int pid;
+
+	list_for_each_entry(key, &lock_keys, list) {
+		key->print(key, st);
+		pr_info("%s ", sep);
+	}
+
+	switch (aggr_mode) {
+	case LOCK_AGGR_CALLER:
+		pr_info("%s%s %s", get_type_str(st->flags), sep, st->name);
+		if (verbose <= 0)
+			pr_info("\n");
+		break;
+	case LOCK_AGGR_TASK:
+		pid = st->addr;
+		t = perf_session__findnew(session, pid);
+		pr_info("%d%s %s\n", pid, sep, pid == -1 ? "Unknown" : thread__comm_str(t));
+		break;
+	case LOCK_AGGR_ADDR:
+		pr_info("%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
+			st->name, sep, get_type_name(st->flags));
+		break;
+	default:
+		break;
+	}
+
+	if (aggr_mode == LOCK_AGGR_CALLER && verbose > 0) {
+		struct map *kmap;
+		struct symbol *sym;
+		char buf[128];
+		u64 ip;
+
+		for (int i = 0; i < max_stack_depth; i++) {
+			if (!st->callstack || !st->callstack[i])
+				break;
+
+			ip = st->callstack[i];
+			sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
+			get_symbol_name_offset(kmap, sym, ip, buf, sizeof(buf));
+			pr_info("%s %#lx %s", i ? ":" : sep, (unsigned long) ip, buf);
+		}
+		pr_info("\n");
+	}
+}
+
+static void print_lock_stat(struct lock_contention *con, struct lock_stat *st)
+{
+	if (symbol_conf.field_sep)
+		print_lock_stat_csv(con, st, symbol_conf.field_sep);
+	else
+		print_lock_stat_stdio(con, st);
+}
+
+static void print_footer_stdio(int total, int bad, struct lock_contention_fails *fails)
 {
 	/* Output for debug, this have to be removed */
 	int broken = fails->task + fails->stack + fails->time + fails->data;
 
+	if (!use_bpf)
+		print_bad_events(bad, total);
+
 	if (quiet || total == 0 || (broken == 0 && verbose <= 0))
 		return;
 
@@ -1643,38 +1817,53 @@ static void print_bpf_events(int total, struct lock_contention_fails *fails)
 	pr_info(" %10s: %d\n", "data", fails->data);
 }
 
+static void print_footer_csv(int total, int bad, struct lock_contention_fails *fails,
+			     const char *sep)
+{
+	/* Output for debug, this have to be removed */
+	if (use_bpf)
+		bad = fails->task + fails->stack + fails->time + fails->data;
+
+	if (quiet || total == 0 || (bad == 0 && verbose <= 0))
+		return;
+
+	total += bad;
+	pr_info("# debug: total=%d%s bad=%d", total, sep, bad);
+
+	if (use_bpf) {
+		pr_info("%s bad_%s=%d", sep, "task", fails->task);
+		pr_info("%s bad_%s=%d", sep, "stack", fails->stack);
+		pr_info("%s bad_%s=%d", sep, "time", fails->time);
+		pr_info("%s bad_%s=%d", sep, "data", fails->data);
+	} else {
+		int i;
+		const char *name[4] = { "acquire", "acquired", "contended", "release" };
+
+		for (i = 0; i < BROKEN_MAX; i++)
+			pr_info("%s bad_%s=%d", sep, name[i], bad_hist[i]);
+	}
+	pr_info("\n");
+}
+
+static void print_footer(int total, int bad, struct lock_contention_fails *fails)
+{
+	if (symbol_conf.field_sep)
+		print_footer_csv(total, bad, fails, symbol_conf.field_sep);
+	else
+		print_footer_stdio(total, bad, fails);
+}
+
 static void print_contention_result(struct lock_contention *con)
 {
 	struct lock_stat *st;
-	struct lock_key *key;
 	int bad, total, printed;
 
-	if (!quiet) {
-		list_for_each_entry(key, &lock_keys, list)
-			pr_info("%*s ", key->len, key->header);
-
-		switch (aggr_mode) {
-		case LOCK_AGGR_TASK:
-			pr_info("  %10s   %s\n\n", "pid",
-				show_lock_owner ? "owner" : "comm");
-			break;
-		case LOCK_AGGR_CALLER:
-			pr_info("  %10s   %s\n\n", "type", "caller");
-			break;
-		case LOCK_AGGR_ADDR:
-			pr_info("  %16s   %s\n\n", "address", "symbol");
-			break;
-		default:
-			break;
-		}
-	}
+	if (!quiet)
+		print_header();
 
 	bad = total = printed = 0;
 
 	while ((st = pop_from_result())) {
-		struct thread *t;
-		int pid;
-
 		total += use_bpf ? st->nr_contended : 1;
 		if (st->broken)
 			bad++;
@@ -1682,45 +1871,7 @@ static void print_contention_result(struct lock_contention *con)
 		if (!st->wait_time_total)
 			continue;
 
-		list_for_each_entry(key, &lock_keys, list) {
-			key->print(key, st);
-			pr_info(" ");
-		}
-
-		switch (aggr_mode) {
-		case LOCK_AGGR_CALLER:
-			pr_info("  %10s   %s\n", get_type_str(st->flags), st->name);
-			break;
-		case LOCK_AGGR_TASK:
-			pid = st->addr;
-			t = perf_session__findnew(session, pid);
-			pr_info("  %10d   %s\n",
-				pid, pid == -1 ? "Unknown" : thread__comm_str(t));
-			break;
-		case LOCK_AGGR_ADDR:
-			pr_info("  %016llx   %s (%s)\n", (unsigned long long)st->addr,
-				st->name, get_type_name(st->flags));
-			break;
-		default:
-			break;
-		}
-
-		if (aggr_mode == LOCK_AGGR_CALLER && verbose > 0) {
-			struct map *kmap;
-			struct symbol *sym;
-			char buf[128];
-			u64 ip;
-
-			for (int i = 0; i < max_stack_depth; i++) {
-				if (!st->callstack || !st->callstack[i])
-					break;
-
-				ip = st->callstack[i];
-				sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
-				get_symbol_name_offset(kmap, sym, ip, buf, sizeof(buf));
-				pr_info("\t\t\t%#lx  %s\n", (unsigned long)ip, buf);
-			}
-		}
+		print_lock_stat(con, st);
 
 		if (++printed >= print_nr_entries)
 			break;
@@ -1737,10 +1888,7 @@ static void print_contention_result(struct lock_contention *con)
 	/* some entries are collected but hidden by the callstack filter */
 	total += con->nr_filtered;
 
-	if (use_bpf)
-		print_bpf_events(total, &con->fails);
-	else
-		print_bad_events(bad, total);
+	print_footer(total, bad, &con->fails);
 }
 
 static bool force;
@@ -1846,6 +1994,16 @@ static int check_lock_contention_options(const struct option *options,
 		return -1;
 	}
 
+	if (symbol_conf.field_sep) {
+		if (strstr(symbol_conf.field_sep, ":") || /* part of type flags */
+		    strstr(symbol_conf.field_sep, "+") || /* part of caller offset */
+		    strstr(symbol_conf.field_sep, ".")) { /* can be in a symbol name */
+			pr_err("Cannot use the separator that is already used\n");
+			parse_options_usage(usage, options, "x", 1);
+			return -1;
+		}
+	}
+
 	if (show_lock_owner)
 		show_thread_stats = true;
 
@@ -1963,6 +2121,15 @@ static int __cmd_contention(int argc, const char **argv)
 	if (select_key(true))
 		goto out_delete;
 
+	if (symbol_conf.field_sep) {
+		int i;
+		struct lock_key *keys = contention_keys;
+
+		/* do not align output in CSV format */
+		for (i = 0; keys[i].name; i++)
+			keys[i].len = 0;
+	}
+
 	if (use_bpf) {
 		lock_contention_start();
 		if (argc)
@@ -2331,6 +2498,8 @@ int cmd_lock(int argc, const char **argv)
 	OPT_CALLBACK('S', "callstack-filter", NULL, "NAMES",
 		     "Filter specific function in the callstack", parse_call_stack),
 	OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters"),
+	OPT_STRING_NOEMPTY('x', "field-separator", &symbol_conf.field_sep, "separator",
+		   "print result in CSV format with custom separator"),
 	OPT_PARENT(lock_options)
 	};
 
-- 
2.41.0.rc0.172.g3f132b7071-goog


