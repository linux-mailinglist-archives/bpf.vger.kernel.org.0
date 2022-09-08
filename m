Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AA05B14C8
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 08:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiIHGiG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 02:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiIHGiD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 02:38:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D92C696E;
        Wed,  7 Sep 2022 23:38:02 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so1362042pjm.1;
        Wed, 07 Sep 2022 23:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=AtYzzReklNQuupYTXgf6CIVkK5TRUPCV7GIBcB2m37I=;
        b=DV796Ll6T89j3sjpAJ/2sM4bIKE+8QfCLmIkAZm9uITBJy8vKgSEhkcwuVqHproNks
         VbSkMAdJbrAy9gA+q9WWa/M9PyxFzrOJwazjIVbk/p0ipWXIUItQD8z4ND12QN9AIAEg
         94ZFpnGDH+DKXz5pM8mzv7vymvj0JNwHPETW9YigRo8JhHvFN/a37hbD/ssXexVgtSeF
         Jj8XphFTtl7wES5KwnXB3w0iMUQASN1i5hvPKXYFMCjanuPr8sreIvnxdCZXKHarAcMK
         oq2JIXpugcKd09tl0lQcGwXjtygIucubOCX3hmy0Rwmw1qdMqylE5DNjPqQPCA7sy6W3
         mT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=AtYzzReklNQuupYTXgf6CIVkK5TRUPCV7GIBcB2m37I=;
        b=fOKHx9s0GdA1C/kPJiEfhtYi43vmQOOE3JfEzzO5fW4td+e3U8TpcDPZTSdwir87Gq
         Im6xDjtHuiRm9HB0UJh9gM66LMxDlDzZTf47KupfvtwuGcmkdqUXe3xFnGVMR6mrzudv
         g6gBIJFNmQJ+V/UNgFB9RCnTfszPg5nOkt7FA1pIJD9E8RyAvVwlEQrFsAS57Tu4oYd5
         pbFNcn7vDNacLAQ/ZvJOtY+A/FX6I5TJROlTWx4GNy2AqOazZHh4PP3xdNFnoTgQ0snX
         sgCSwi+AmMoGLK21GPyRXo8rQ/o/ObHc7niyZWJjRncbFJOfLoVNDsEXu0K6OPCzpQgV
         kxqw==
X-Gm-Message-State: ACgBeo2vGvsAXuKChbhNQO3nnmq9SwfAepQJQOvHCOlYYLZR+2uE3oKm
        ZqU+yy6giTAljMqHS31ftWjZR8PSUrY=
X-Google-Smtp-Source: AA6agR7aKc93cU9fhSJjoIEDyivdEXSav31T+fdl+ov8F/8MAec91bRtv4PcW6l5BNZNSAsOnnTC3A==
X-Received: by 2002:a17:903:24e:b0:172:6c9d:14e0 with SMTP id j14-20020a170903024e00b001726c9d14e0mr7741072plh.84.1662619081689;
        Wed, 07 Sep 2022 23:38:01 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:7f21:d032:3f14:a4e6])
        by smtp.gmail.com with ESMTPSA id o33-20020a17090a0a2400b001fb0fc33d72sm890716pjo.47.2022.09.07.23.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 23:38:01 -0700 (PDT)
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
Subject: [PATCH 2/4] perf lock contention: Show full callstack with -v option
Date:   Wed,  7 Sep 2022 23:37:52 -0700
Message-Id: <20220908063754.1369709-3-namhyung@kernel.org>
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

Currently it shows a caller function for each entry, but users need to see
the full call stacks sometimes.  Use -v/--verbose option to do that.

  # perf lock con -a -b -v sleep 3
  Looking at the vmlinux_path (8 entries long)
  symsrc__init: cannot get elf header.
  Using /proc/kcore for kernel data
  Using /proc/kallsyms for symbols
   contended   total wait     max wait     avg wait         type   caller

           1     10.74 us     10.74 us     10.74 us     spinlock   __bpf_trace_contention_begin+0xb
                          0xffffffffc03b5c47  bpf_prog_bf07ae9e2cbd02c5_contention_begin+0x117
                          0xffffffffc03b5c47  bpf_prog_bf07ae9e2cbd02c5_contention_begin+0x117
                          0xffffffffbb8b8e75  bpf_trace_run2+0x35
                          0xffffffffbb7eab9b  __bpf_trace_contention_begin+0xb
                          0xffffffffbb7ebe75  queued_spin_lock_slowpath+0x1f5
                          0xffffffffbc1c26ff  _raw_spin_lock+0x1f
                          0xffffffffbb841015  tick_do_update_jiffies64+0x25
                          0xffffffffbb8409ee  tick_irq_enter+0x9e
           1      7.70 us      7.70 us      7.70 us     spinlock   __bpf_trace_contention_begin+0xb
                          0xffffffffc03b5c47  bpf_prog_bf07ae9e2cbd02c5_contention_begin+0x117
                          0xffffffffc03b5c47  bpf_prog_bf07ae9e2cbd02c5_contention_begin+0x117
                          0xffffffffbb8b8e75  bpf_trace_run2+0x35
                          0xffffffffbb7eab9b  __bpf_trace_contention_begin+0xb
                          0xffffffffbb7ebe75  queued_spin_lock_slowpath+0x1f5
                          0xffffffffbc1c26ff  _raw_spin_lock+0x1f
                          0xffffffffbb7bc27e  raw_spin_rq_lock_nested+0xe
                          0xffffffffbb7cef9c  load_balance+0x66c

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c             | 43 ++++++++++++++++++++++-----
 tools/perf/util/bpf_lock_contention.c |  9 ++++++
 tools/perf/util/lock-contention.h     |  1 +
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 2a5672f8d22e..e66fbb38d8df 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -972,13 +972,14 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
 	return -1;
 }
 
-static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
+static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample, u64 *callchains)
 {
 	struct callchain_cursor *cursor = &callchain_cursor;
 	struct machine *machine = &session->machines.host;
 	struct thread *thread;
 	u64 hash = 0;
 	int skip = 0;
+	int i = 0;
 	int ret;
 
 	thread = machine__findnew_thread(machine, -1, sample->pid);
@@ -1002,6 +1003,9 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 		if (node == NULL)
 			break;
 
+		if (callchains)
+			callchains[i++] = node->ip;
+
 		/* skip first few entries - for lock functions */
 		if (++skip <= CONTENTION_STACK_SKIP)
 			goto next;
@@ -1025,6 +1029,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	struct lock_seq_stat *seq;
 	u64 addr = evsel__intval(evsel, sample, "lock_addr");
 	u64 key;
+	u64 callchains[CONTENTION_STACK_DEPTH];
 
 	switch (aggr_mode) {
 	case LOCK_AGGR_ADDR:
@@ -1034,7 +1039,9 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		key = sample->tid;
 		break;
 	case LOCK_AGGR_CALLER:
-		key = callchain_id(evsel, sample);
+		if (verbose)
+			memset(callchains, 0, sizeof(callchains));
+		key = callchain_id(evsel, sample, verbose ? callchains : NULL);
 		break;
 	default:
 		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
@@ -1053,6 +1060,12 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		ls = lock_stat_findnew(key, caller, flags);
 		if (!ls)
 			return -ENOMEM;
+
+		if (aggr_mode == LOCK_AGGR_CALLER && verbose) {
+			ls->callstack = memdup(callchains, sizeof(callchains));
+			if (ls->callstack == NULL)
+				return -ENOMEM;
+		}
 	}
 
 	ts = thread_stat_findnew(sample->tid);
@@ -1117,7 +1130,7 @@ static int report_lock_contention_end_event(struct evsel *evsel,
 		key = sample->tid;
 		break;
 	case LOCK_AGGR_CALLER:
-		key = callchain_id(evsel, sample);
+		key = callchain_id(evsel, sample, NULL);
 		break;
 	default:
 		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
@@ -1466,7 +1479,7 @@ static void sort_contention_result(void)
 	sort_result();
 }
 
-static void print_contention_result(void)
+static void print_contention_result(struct lock_contention *con)
 {
 	struct lock_stat *st;
 	struct lock_key *key;
@@ -1505,6 +1518,22 @@ static void print_contention_result(void)
 		}
 
 		pr_info("  %10s   %s\n", get_type_str(st), st->name);
+		if (verbose) {
+			struct map *kmap;
+			struct symbol *sym;
+			char buf[128];
+			u64 ip;
+
+			for (int i = 0; i < CONTENTION_STACK_DEPTH; i++) {
+				if (!st->callstack || !st->callstack[i])
+					break;
+
+				ip = st->callstack[i];
+				sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
+				get_symbol_name_offset(kmap, sym, ip, buf, sizeof(buf));
+				pr_info("\t\t\t%#lx  %s\n", (unsigned long)ip, buf);
+			}
+		}
 	}
 
 	print_bad_events(bad, total);
@@ -1620,6 +1649,8 @@ static int __cmd_contention(int argc, const char **argv)
 		return PTR_ERR(session);
 	}
 
+	con.machine = &session->machines.host;
+
 	/* for lock function check */
 	symbol_conf.sort_by_name = true;
 	symbol__init(&session->header.env);
@@ -1638,8 +1669,6 @@ static int __cmd_contention(int argc, const char **argv)
 		signal(SIGCHLD, sighandler);
 		signal(SIGTERM, sighandler);
 
-		con.machine = &session->machines.host;
-
 		con.evlist = evlist__new();
 		if (con.evlist == NULL) {
 			err = -ENOMEM;
@@ -1711,7 +1740,7 @@ static int __cmd_contention(int argc, const char **argv)
 	setup_pager();
 
 	sort_contention_result();
-	print_contention_result();
+	print_contention_result(&con);
 
 out_delete:
 	evlist__delete(con.evlist);
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index c591a66733ef..6545bee65347 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -8,6 +8,7 @@
 #include "util/thread_map.h"
 #include "util/lock-contention.h"
 #include <linux/zalloc.h>
+#include <linux/string.h>
 #include <bpf/bpf.h>
 
 #include "bpf_skel/lock_contention.skel.h"
@@ -171,6 +172,14 @@ int lock_contention_read(struct lock_contention *con)
 			return -1;
 		}
 
+		if (verbose) {
+			st->callstack = memdup(stack_trace, sizeof(stack_trace));
+			if (st->callstack == NULL) {
+				free(st);
+				return -1;
+			}
+		}
+
 		hlist_add_head(&st->hash_entry, con->result);
 		prev_key = key;
 	}
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 2146efc33396..bdb6e2a61e5b 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -11,6 +11,7 @@ struct lock_stat {
 
 	u64			addr;		/* address of lockdep_map, used as ID */
 	char			*name;		/* for strcpy(), we cannot use const */
+	u64			*callstack;
 
 	unsigned int		nr_acquire;
 	unsigned int		nr_acquired;
-- 
2.37.2.789.g6183377224-goog

