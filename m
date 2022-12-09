Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0B66488D4
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 20:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiLITHo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 14:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiLITHi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 14:07:38 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7582AEE;
        Fri,  9 Dec 2022 11:07:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u5so5718057pjy.5;
        Fri, 09 Dec 2022 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjY8H+PAiusizFOCgESEpT8nPlA0MeCSIYNjtpBPi54=;
        b=BB9OCfif8nj6AThEtwutm8zAPoYPL/0mvBRijpK3N89uiL2xCiSZ7kLhaduq5YzDNs
         i80l3bPChiY56yI5oueQXVwD/Lur+XgAyv1SO1dVcUmr9JZAyTZy9U3oCfFyltmU2lLL
         7M44IAK48x5Efqjys61aSwyrq9ab2eBMFh5xf/7TSo+zfwX6jSD+U2sDO6c2z10OjLJc
         9fOR+//+9VnEbaEzKBsTYCstYYcMCoU8YTs6lwe/c+0N9R5AFDkgzYE69FyNO26VzBrg
         MduazddKc4xXWpe6QNpHBX/k5/OzIE+HkdnSzrxdCRvyqQFEi8Q7FmSgayPI5L/LhfhH
         UVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PjY8H+PAiusizFOCgESEpT8nPlA0MeCSIYNjtpBPi54=;
        b=szaqpY461cPlPX0cA3jX48lUjxKCJMhCPlPCEGPlDCdNkuvolpxKe4/ROIxl4Zh0r3
         VhqN1kQ8TBGQPvZPEOqK1Xj4oTHKUAs83q8+AhIGCw9DZLrVS0+l27pAVgCEUKzyPOwr
         MUI6/eg1RV7K5joO+JdQADaJZbDMJBFLH2rQuSNlPazOK1A6K9lfR99kq6UaD9DnZiHH
         nEcSI71VZQevhJKMq3g7ZU4li5VQA2W8OfiX9F9nqjVlku298p+3BQgM8liXHNGcny0A
         sgClfYUQFWFksLbBn6Bg+6XNnKLxWCHUD8aGSNHNbu80AjF9BFgjwSEtIYjwpG/89e2s
         ZipA==
X-Gm-Message-State: ANoB5plSxeIjxJMwFfvwauTpXlD3vkXWyYpgRp3ujT0h+0qasdx1utR3
        AbxbPWGsCwCTZ8W0fkJ2wfw=
X-Google-Smtp-Source: AA0mqf6YRJAEXx+NGCn2wLRqoeyRNYlgFsYtH8rRjhN9KhbZQGLv28M35T6rxk+e1Bk488OaUIKGCg==
X-Received: by 2002:a05:6a20:2a8c:b0:a6:6d23:a007 with SMTP id v12-20020a056a202a8c00b000a66d23a007mr12557006pzh.42.1670612854906;
        Fri, 09 Dec 2022 11:07:34 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:c952:d848:9e00:3cce])
        by smtp.gmail.com with ESMTPSA id nd17-20020a17090b4cd100b002135de3013fsm1431432pjb.32.2022.12.09.11.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:07:34 -0800 (PST)
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
Subject: [PATCH 3/4] perf lock contention: Add -l/--lock-addr option
Date:   Fri,  9 Dec 2022 11:07:26 -0800
Message-Id: <20221209190727.759804-4-namhyung@kernel.org>
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

The -l/--lock-addr option is to implement per-lock-instance contention
stat using LOCK_AGGR_ADDR.  It displays lock address and optionally
symbol name if exists.

  $ sudo ./perf lock con -abl sleep 1
   contended   total wait     max wait     avg wait            address   symbol

           1     36.28 us     36.28 us     36.28 us   ffff92615d6448b8
           9     10.91 us      1.84 us      1.21 us   ffffffffbaed50c0   rcu_state
           1     10.49 us     10.49 us     10.49 us   ffff9262ac4f0c80
           8      4.68 us      1.67 us       585 ns   ffffffffbae07a40   jiffies_lock
           3      3.03 us      1.45 us      1.01 us   ffff9262277861e0
           1       924 ns       924 ns       924 ns   ffff926095ba9d20
           1       436 ns       436 ns       436 ns   ffff9260bfda4f60

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt        |  4 +
 tools/perf/builtin-lock.c                     | 84 +++++++++++++++----
 tools/perf/util/bpf_lock_contention.c         | 23 +++--
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 17 +++-
 tools/perf/util/bpf_skel/lock_data.h          |  2 +-
 5 files changed, 102 insertions(+), 28 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 4958a1ffa1cc..38e79d45e426 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -168,6 +168,10 @@ CONTENTION OPTIONS
 --entries=<value>::
 	Display this many entries.
 
+-l::
+--lock-addr::
+	Show lock contention stat by address
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6fa3cdfec5cb..25c0a5e5051f 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -56,6 +56,7 @@ static struct rb_root		thread_stats;
 
 static bool combine_locks;
 static bool show_thread_stats;
+static bool show_lock_addrs;
 static bool use_bpf;
 static unsigned long bpf_map_entries = 10240;
 static int max_stack_depth = CONTENTION_STACK_DEPTH;
@@ -999,13 +1000,32 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	ls = lock_stat_find(key);
 	if (!ls) {
 		char buf[128];
-		const char *caller = buf;
+		const char *name = "";
 		unsigned int flags = evsel__intval(evsel, sample, "flags");
+		struct machine *machine = &session->machines.host;
+		struct map *kmap;
+		struct symbol *sym;
+
+		switch (aggr_mode) {
+		case LOCK_AGGR_ADDR:
+			/* make sure it loads the kernel map to find lock symbols */
+			map__load(machine__kernel_map(machine));
+
+			sym = machine__find_kernel_symbol(machine, key, &kmap);
+			if (sym)
+				name = sym->name;
+			break;
+		case LOCK_AGGR_CALLER:
+			name = buf;
+			if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
+				name = "Unknown";
+			break;
+		case LOCK_AGGR_TASK:
+		default:
+			break;
+		}
 
-		if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
-			caller = "Unknown";
-
-		ls = lock_stat_findnew(key, caller, flags);
+		ls = lock_stat_findnew(key, name, flags);
 		if (!ls)
 			return -ENOMEM;
 
@@ -1460,10 +1480,19 @@ static void print_contention_result(struct lock_contention *con)
 		list_for_each_entry(key, &lock_keys, list)
 			pr_info("%*s ", key->len, key->header);
 
-		if (show_thread_stats)
+		switch (aggr_mode) {
+		case LOCK_AGGR_TASK:
 			pr_info("  %10s   %s\n\n", "pid", "comm");
-		else
+			break;
+		case LOCK_AGGR_CALLER:
 			pr_info("  %10s   %s\n\n", "type", "caller");
+			break;
+		case LOCK_AGGR_ADDR:
+			pr_info("  %16s   %s\n\n", "address", "symbol");
+			break;
+		default:
+			break;
+		}
 	}
 
 	bad = total = printed = 0;
@@ -1471,6 +1500,9 @@ static void print_contention_result(struct lock_contention *con)
 		bad = bad_hist[BROKEN_CONTENDED];
 
 	while ((st = pop_from_result())) {
+		struct thread *t;
+		int pid;
+
 		total += use_bpf ? st->nr_contended : 1;
 		if (st->broken)
 			bad++;
@@ -1480,18 +1512,24 @@ static void print_contention_result(struct lock_contention *con)
 			pr_info(" ");
 		}
 
-		if (show_thread_stats) {
-			struct thread *t;
-			int pid = st->addr;
-
-			/* st->addr contains tid of thread */
+		switch (aggr_mode) {
+		case LOCK_AGGR_CALLER:
+			pr_info("  %10s   %s\n", get_type_str(st), st->name);
+			break;
+		case LOCK_AGGR_TASK:
+			pid = st->addr;
 			t = perf_session__findnew(session, pid);
 			pr_info("  %10d   %s\n", pid, thread__comm_str(t));
-			goto next;
+			break;
+		case LOCK_AGGR_ADDR:
+			pr_info("  %016llx   %s\n", (unsigned long long)st->addr,
+				st->name ? : "");
+			break;
+		default:
+			break;
 		}
 
-		pr_info("  %10s   %s\n", get_type_str(st), st->name);
-		if (verbose) {
+		if (aggr_mode == LOCK_AGGR_CALLER && verbose) {
 			struct map *kmap;
 			struct symbol *sym;
 			char buf[128];
@@ -1508,7 +1546,6 @@ static void print_contention_result(struct lock_contention *con)
 			}
 		}
 
-next:
 		if (++printed >= print_nr_entries)
 			break;
 	}
@@ -1616,7 +1653,6 @@ static int __cmd_contention(int argc, const char **argv)
 		.map_nr_entries = bpf_map_entries,
 		.max_stack = max_stack_depth,
 		.stack_skip = stack_skip,
-		.aggr_mode = show_thread_stats ? LOCK_AGGR_TASK : LOCK_AGGR_CALLER,
 	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
@@ -1627,6 +1663,9 @@ static int __cmd_contention(int argc, const char **argv)
 
 	con.machine = &session->machines.host;
 
+	con.aggr_mode = aggr_mode = show_thread_stats ? LOCK_AGGR_TASK :
+		show_lock_addrs ? LOCK_AGGR_ADDR : LOCK_AGGR_CALLER;
+
 	/* for lock function check */
 	symbol_conf.sort_by_name = true;
 	symbol__init(&session->header.env);
@@ -1907,6 +1946,7 @@ int cmd_lock(int argc, const char **argv)
 		    "Set the number of stack depth to skip when finding a lock caller, "
 		    "Default: " __stringify(CONTENTION_STACK_SKIP)),
 	OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
+	OPT_BOOLEAN('l', "lock-addr", &show_lock_addrs, "show lock stats by address"),
 	OPT_PARENT(lock_options)
 	};
 
@@ -1976,6 +2016,16 @@ int cmd_lock(int argc, const char **argv)
 			argc = parse_options(argc, argv, contention_options,
 					     contention_usage, 0);
 		}
+
+		if (show_thread_stats && show_lock_addrs) {
+			pr_err("Cannot use thread and addr mode together\n");
+			parse_options_usage(contention_usage, contention_options,
+					    "threads", 0);
+			parse_options_usage(NULL, contention_options,
+					    "lock-addr", 0);
+			return -1;
+		}
+
 		rc = __cmd_contention(argc, argv);
 	} else {
 		usage_with_options(lock_usage, lock_options);
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 1590a9f05145..8e1b791dc58f 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -137,11 +137,15 @@ int lock_contention_read(struct lock_contention *con)
 		thread__set_comm(idle, "swapper", /*timestamp=*/0);
 	}
 
+	/* make sure it loads the kernel map */
+	map__load(maps__first(machine->kmaps));
+
 	prev_key = NULL;
 	while (!bpf_map_get_next_key(fd, prev_key, &key)) {
 		struct map *kmap;
 		struct symbol *sym;
 		int idx = 0;
+		s32 stack_id;
 
 		/* to handle errors in the loop body */
 		err = -1;
@@ -160,24 +164,31 @@ int lock_contention_read(struct lock_contention *con)
 			st->avg_wait_time = data.total_time / data.count;
 
 		st->flags = data.flags;
+		st->addr = key.aggr_key;
 
 		if (con->aggr_mode == LOCK_AGGR_TASK) {
 			struct contention_task_data task;
 			struct thread *t;
-
-			st->addr = key.stack_or_task_id;
+			int pid = key.aggr_key;
 
 			/* do not update idle comm which contains CPU number */
 			if (st->addr) {
-				bpf_map_lookup_elem(task_fd, &key, &task);
-				t = __machine__findnew_thread(machine, /*pid=*/-1,
-							      key.stack_or_task_id);
+				bpf_map_lookup_elem(task_fd, &pid, &task);
+				t = __machine__findnew_thread(machine, /*pid=*/-1, pid);
 				thread__set_comm(t, task.comm, /*timestamp=*/0);
 			}
 			goto next;
 		}
 
-		bpf_map_lookup_elem(stack, &key, stack_trace);
+		if (con->aggr_mode == LOCK_AGGR_ADDR) {
+			sym = machine__find_kernel_symbol(machine, st->addr, &kmap);
+			if (sym)
+				st->name = strdup(sym->name);
+			goto next;
+		}
+
+		stack_id = key.aggr_key;
+		bpf_map_lookup_elem(stack, &stack_id, stack_trace);
 
 		/* skip lock internal functions */
 		while (machine__is_lock_function(machine, stack_trace[idx]) &&
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index cd405adcd252..11b0fc7ee53b 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -168,11 +168,20 @@ int contention_end(u64 *ctx)
 
 	duration = bpf_ktime_get_ns() - pelem->timestamp;
 
-	if (aggr_mode == LOCK_AGGR_CALLER) {
-		key.stack_or_task_id = pelem->stack_id;
-	} else {
-		key.stack_or_task_id = pid;
+	switch (aggr_mode) {
+	case LOCK_AGGR_CALLER:
+		key.aggr_key = pelem->stack_id;
+		break;
+	case LOCK_AGGR_TASK:
+		key.aggr_key = pid;
 		update_task_data(pid);
+		break;
+	case LOCK_AGGR_ADDR:
+		key.aggr_key = pelem->lock;
+		break;
+	default:
+		/* should not happen */
+		return 0;
 	}
 
 	data = bpf_map_lookup_elem(&lock_stat, &key);
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index dbdf4caedc4a..ce71cf1a7e1e 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -4,7 +4,7 @@
 #define UTIL_BPF_SKEL_LOCK_DATA_H
 
 struct contention_key {
-	s32 stack_or_task_id;
+	u64 aggr_key;  /* can be stack_id, pid or lock addr */
 };
 
 #define TASK_COMM_LEN  16
-- 
2.39.0.rc1.256.g54fd8350bd-goog

