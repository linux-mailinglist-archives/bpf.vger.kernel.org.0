Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F835B53AA
	for <lists+bpf@lfdr.de>; Mon, 12 Sep 2022 07:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiILFxe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Sep 2022 01:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiILFxX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Sep 2022 01:53:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A542559A;
        Sun, 11 Sep 2022 22:53:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id b75so2339964pfb.7;
        Sun, 11 Sep 2022 22:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=MgnVYvvI9fTf9f50zjOp5guIgv7ykcrcTCcvrW7IcH8=;
        b=iR0aeSJ8ymUsURCTt57njklvlnaaFLFOdJkSkigwYkQnQDycQk6XpkSilQbCTjDjik
         +LNNSIShIw5bml1qNUXlMNNuBBUnurh4XXjc87jL/UvTrbCFRlhxPAZ4eeY7vYik48Gq
         JnBEiPT1fqJzlDX+QkbQ4ApcdSUu1w8PgcHzYje0vosCrilUsXI7SVQGlwc3W3saph/f
         hw7y9e7zNLZOB8HsaQ9bJg/XPbCPUASCUPKxSBnk9G+jORcKqfhB/yeA0iU2BqYgH4Iz
         O/0BJQz1EE9O9BA7tF2biEe0ytb3UM/+svGKD4BcjzSkPCSaUzLvVi5xavoCkvkwYZXK
         3Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=MgnVYvvI9fTf9f50zjOp5guIgv7ykcrcTCcvrW7IcH8=;
        b=W898GVWQ/X1ZECFBNfRJudh1t8YBTq4+0HoUjUMjYTItWfaTMIs0zIuMntECz1yA2G
         PPhYDArcM73H33iD884xE1MTgUDgzflknJxd2eJALMDTmryUQhZGxYJAe4lz8ng1i2w1
         sRhPYf8rZzhJep/TchM1fQLZyuVarOE4HJ74ZxLDI6iBnRO7I59RPxvvKpyH+wLVWeit
         YLy22jt5OtdORzlaLPc/mHu+AHKMyatVYJtF5MDqR7EdDNiM5ILmBI7wyfF5nJ+A9SwV
         X6iaFoVNLI91Sse/7zFpGJuBPT+u2SI8ii+f8jKVwtNN8PrgbhC39nPbhY9TSsp4cEKX
         ztCg==
X-Gm-Message-State: ACgBeo1F0WVPzs0yJcevxy8geBfu9HksRN/IXvN9QmkdpFrTYoZiMTPq
        D0y8KSB8DqXnsI06+2odLeU=
X-Google-Smtp-Source: AA6agR4S9EYqYRzkLxlvN52ukNk+dkfS3W8oA/m3tRt7QLz1ytpGIDxpF00SPyQpkdA0JJiN9qoQPQ==
X-Received: by 2002:a05:6a00:1aca:b0:52f:55f8:c3ec with SMTP id f10-20020a056a001aca00b0052f55f8c3ecmr25758897pfv.25.1662962001488;
        Sun, 11 Sep 2022 22:53:21 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cfe7:8794:a807:6746])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b00176b87a697fsm4882736pls.269.2022.09.11.22.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 22:53:20 -0700 (PDT)
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
Subject: [PATCH 2/4] perf lock contention: Show full callstack with -v option
Date:   Sun, 11 Sep 2022 22:53:12 -0700
Message-Id: <20220912055314.744552-3-namhyung@kernel.org>
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
 tools/perf/builtin-lock.c             | 51 ++++++++++++++++++++++++---
 tools/perf/util/bpf_lock_contention.c |  9 +++++
 tools/perf/util/lock-contention.h     |  1 +
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index eaba6018da69..371539049358 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1014,6 +1014,27 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
 	return hash;
 }
 
+static u64 *get_callstack(struct perf_sample *sample, int max_stack)
+{
+	u64 *callstack;
+	u64 i;
+	int c;
+
+	callstack = calloc(max_stack, sizeof(*callstack));
+	if (callstack == NULL)
+		return NULL;
+
+	for (i = 0, c = 0; i < sample->callchain->nr && c < max_stack; i++) {
+		u64 ip = sample->callchain->ips[i];
+
+		if (ip >= PERF_CONTEXT_MAX)
+			continue;
+
+		callstack[c++] = ip;
+	}
+	return callstack;
+}
+
 static int report_lock_contention_begin_event(struct evsel *evsel,
 					      struct perf_sample *sample)
 {
@@ -1040,6 +1061,12 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		ls = lock_stat_findnew(key, caller, flags);
 		if (!ls)
 			return -ENOMEM;
+
+		if (aggr_mode == LOCK_AGGR_CALLER && verbose) {
+			ls->callstack = get_callstack(sample, CONTENTION_STACK_DEPTH);
+			if (ls->callstack == NULL)
+				return -ENOMEM;
+		}
 	}
 
 	ts = thread_stat_findnew(sample->tid);
@@ -1443,7 +1470,7 @@ static void sort_contention_result(void)
 	sort_result();
 }
 
-static void print_contention_result(void)
+static void print_contention_result(struct lock_contention *con)
 {
 	struct lock_stat *st;
 	struct lock_key *key;
@@ -1482,6 +1509,22 @@ static void print_contention_result(void)
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
@@ -1597,6 +1640,8 @@ static int __cmd_contention(int argc, const char **argv)
 		return PTR_ERR(session);
 	}
 
+	con.machine = &session->machines.host;
+
 	/* for lock function check */
 	symbol_conf.sort_by_name = true;
 	symbol__init(&session->header.env);
@@ -1615,8 +1660,6 @@ static int __cmd_contention(int argc, const char **argv)
 		signal(SIGCHLD, sighandler);
 		signal(SIGTERM, sighandler);
 
-		con.machine = &session->machines.host;
-
 		con.evlist = evlist__new();
 		if (con.evlist == NULL) {
 			err = -ENOMEM;
@@ -1688,7 +1731,7 @@ static int __cmd_contention(int argc, const char **argv)
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

