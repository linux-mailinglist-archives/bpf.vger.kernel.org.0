Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7896513AF
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 21:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiLSURp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 15:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiLSURk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 15:17:40 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528FB20;
        Mon, 19 Dec 2022 12:17:39 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so14300484pjj.2;
        Mon, 19 Dec 2022 12:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZkB4QuSwHTQCLJv4c82Z6FZXzye3hmuSZyyGw5CfKo=;
        b=ffiQULjKKRzXhpUY0AzbdmAOwIDrA+JSyz+7u/IQszYHdVb+znQ4lQ5LQmyT9vz1vB
         Y9sYFLbWMtzGR7pZBnPcc4W9+XRpJjCAU8uzN2N+u1LpmAgNd9S6rmHdkL2da/xRoF29
         i8qeCJhC6s4WGDR0jRTnsn4fQd9mY6dcjuMZEzlS7B+SFSZrIOiBbNRv9gPRKbTwHFK6
         VH4y+cD6UW1UIdUhmswcNWkt/GVvzxeiJyBM6wx7MWxcIB/tcSLIBEK3kN+BF3D3rRTB
         rNkonqIE+x/oO0qO7XtQAOP/tOOdPTbkHRj7zzmW956ht/AoaUU98gmBni4/1+009SLs
         dQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EZkB4QuSwHTQCLJv4c82Z6FZXzye3hmuSZyyGw5CfKo=;
        b=j0wQXCjzLgE7nBz6cyJ2tvAF+y2KTnv0UCVOKfwFyCt7MrXKdTYAP7WdzNv3/oimM+
         UE/qGgZ+8+0bH6JFlfgTkIdTggGJJfmo25HhjBZV6dCvwOhxmbMKwYP3lrR8Q4fvVBRW
         uBbHg3HCOozcpyKslBQlfxF1iPGEhSCekdMSKlbu947bW/EZRwaoonADzjUNxM3KiofW
         CsdHomA2VZPAJR/TO/9au7UACHxewQSEuspa7YvmkkEO8Jtmx+gZR8UUMLeTaFZOEaEn
         LN0nCYsfyE1P/xAnhV5jwRpImGMcaluCJCnKmgomrjH5ulMkswIvr+9sgXzkRZNmwpD1
         hRqg==
X-Gm-Message-State: ANoB5pkp2l0WGNPJozEmfCyMS8ZE5FuvWR1CygocjOu6PKabEMyYxPWf
        I/q3tqktlEdu7GxnuCPxRZM=
X-Google-Smtp-Source: AA0mqf7UmdNe91hR1c61hwA1v4sjJlxe+G174ZISXTbzc90YhmHSBZ21f+TiztAu0CpzHI7th64j8g==
X-Received: by 2002:a17:90b:1bcc:b0:223:2654:9dd0 with SMTP id oa12-20020a17090b1bcc00b0022326549dd0mr26243137pjb.28.1671481058913;
        Mon, 19 Dec 2022 12:17:38 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:735a:2805:e706:5164])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b00219220edf0dsm6324260pju.48.2022.12.19.12.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:17:38 -0800 (PST)
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
Subject: [PATCH 2/6] perf lock contention: Add -Y/--type-filter option
Date:   Mon, 19 Dec 2022 12:17:28 -0800
Message-Id: <20221219201732.460111-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221219201732.460111-1-namhyung@kernel.org>
References: <20221219201732.460111-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The -Y/--type-filter option is to filter the result for specific lock
types only.  It can accept comma-separated values.  Note that it would
accept type names like one in the output.  spinlock, mutex, rwsem:R and
so on.

For RW-variant lock types, it converts the name to the both variants.
In other words, "rwsem" is same as "rwsem:R,rwsem:W".  Also note that
"mutex" has two different encoding - one for sleeping wait, another for
optimistic spinning.  Add "mutex-spin" entry for the lock_type_table so
that we can add it for "mutex" under the table.

  $ sudo ./perf lock record -a -- ./perf bench sched messaging

  $ sudo ./perf lock con -E 5 -Y spinlock
   contended   total wait     max wait     avg wait         type   caller

         802      1.26 ms     11.73 us      1.58 us     spinlock   __wake_up_common_lock+0x62
          13    787.16 us    105.44 us     60.55 us     spinlock   remove_wait_queue+0x14
          12    612.96 us     78.70 us     51.08 us     spinlock   prepare_to_wait+0x27
         114    340.68 us     12.61 us      2.99 us     spinlock   try_to_wake_up+0x1f5
          83    226.38 us      9.15 us      2.73 us     spinlock   folio_lruvec_lock_irqsave+0x5e

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |  23 +++--
 tools/perf/builtin-lock.c              | 116 ++++++++++++++++++++++++-
 tools/perf/util/lock-contention.h      |   5 ++
 3 files changed, 136 insertions(+), 8 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 38e79d45e426..dea04ad5c28e 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -143,25 +143,25 @@ CONTENTION OPTIONS
         System-wide collection from all CPUs.
 
 -C::
---cpu::
+--cpu=<value>::
 	Collect samples only on the list of CPUs provided. Multiple CPUs can be
 	provided as a comma-separated list with no space: 0,1. Ranges of CPUs
 	are specified with -: 0-2.  Default is to monitor all CPUs.
 
 -p::
---pid=::
+--pid=<value>::
 	Record events on existing process ID (comma separated list).
 
---tid=::
+--tid=<value>::
         Record events on existing thread ID (comma separated list).
 
---map-nr-entries::
+--map-nr-entries=<value>::
 	Maximum number of BPF map entries (default: 10240).
 
---max-stack::
+--max-stack=<value>::
 	Maximum stack depth when collecting lock contention (default: 8).
 
---stack-skip
+--stack-skip=<value>::
 	Number of stack depth to skip when finding a lock caller (default: 3).
 
 -E::
@@ -172,6 +172,17 @@ CONTENTION OPTIONS
 --lock-addr::
 	Show lock contention stat by address
 
+-Y::
+--type-filter=<value>::
+	Show lock contention only for given lock types (comma separated list).
+	Available values are:
+	  semaphore, spinlock, rwlock, rwlock:R, rwlock:W, rwsem, rwsem:R, rwsem:W,
+	  rtmutex, rwlock-rt, rwlock-rt:R, rwlock-rt:W, pcpu-sem, pcpu-sem:R, pcpu-sem:W,
+	  mutex
+
+	Note that RW-variant of locks have :R and :W suffix.  Names without the
+	suffix are shortcuts for the both variants.  Ex) rwsem = rwsem:R + rwsem:W.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 548d81eb0b18..49b4add53204 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -63,6 +63,8 @@ static int max_stack_depth = CONTENTION_STACK_DEPTH;
 static int stack_skip = CONTENTION_STACK_SKIP;
 static int print_nr_entries = INT_MAX / 2;
 
+static struct lock_filter filters;
+
 static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
 
 static struct thread_stat *thread_stat_find(u32 tid)
@@ -990,8 +992,9 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	struct thread_stat *ts;
 	struct lock_seq_stat *seq;
 	u64 addr = evsel__intval(evsel, sample, "lock_addr");
+	unsigned int flags = evsel__intval(evsel, sample, "flags");
 	u64 key;
-	int ret;
+	int i, ret;
 
 	ret = get_key_by_aggr_mode(&key, addr, evsel, sample);
 	if (ret < 0)
@@ -1001,7 +1004,6 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	if (!ls) {
 		char buf[128];
 		const char *name = "";
-		unsigned int flags = evsel__intval(evsel, sample, "flags");
 		struct machine *machine = &session->machines.host;
 		struct map *kmap;
 		struct symbol *sym;
@@ -1036,6 +1038,20 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		}
 	}
 
+	if (filters.nr_types) {
+		bool found = false;
+
+		for (i = 0; i < filters.nr_types; i++) {
+			if (flags == filters.types[i]) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found)
+			return 0;
+	}
+
 	ts = thread_stat_findnew(sample->tid);
 	if (!ts)
 		return -ENOMEM;
@@ -1454,6 +1470,8 @@ static const struct {
 	{ LCB_F_PERCPU | LCB_F_WRITE,	"pcpu-sem:W" },
 	{ LCB_F_MUTEX,			"mutex" },
 	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex" },
+	/* alias for get_type_flag() */
+	{ LCB_F_MUTEX | LCB_F_SPIN,	"mutex-spin" },
 };
 
 static const char *get_type_str(unsigned int flags)
@@ -1465,6 +1483,21 @@ static const char *get_type_str(unsigned int flags)
 	return "unknown";
 }
 
+static unsigned int get_type_flag(const char *str)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(lock_type_table); i++) {
+		if (!strcmp(lock_type_table[i].name, str))
+			return lock_type_table[i].flags;
+	}
+	return -1U;
+}
+
+static void lock_filter_finish(void)
+{
+	zfree(&filters.types);
+	filters.nr_types = 0;
+}
+
 static void sort_contention_result(void)
 {
 	sort_result();
@@ -1507,6 +1540,9 @@ static void print_contention_result(struct lock_contention *con)
 		if (st->broken)
 			bad++;
 
+		if (!st->wait_time_total)
+			continue;
+
 		list_for_each_entry(key, &lock_keys, list) {
 			key->print(key, st);
 			pr_info(" ");
@@ -1753,6 +1789,7 @@ static int __cmd_contention(int argc, const char **argv)
 	print_contention_result(&con);
 
 out_delete:
+	lock_filter_finish();
 	evlist__delete(con.evlist);
 	lock_contention_finish();
 	perf_session__delete(session);
@@ -1884,6 +1921,79 @@ static int parse_max_stack(const struct option *opt, const char *str,
 	return 0;
 }
 
+static bool add_lock_type(unsigned int flags)
+{
+	unsigned int *tmp;
+
+	tmp = realloc(filters.types, (filters.nr_types + 1) * sizeof(*filters.types));
+	if (tmp == NULL)
+		return false;
+
+	tmp[filters.nr_types++] = flags;
+	filters.types = tmp;
+	return true;
+}
+
+static int parse_lock_type(const struct option *opt __maybe_unused, const char *str,
+			   int unset __maybe_unused)
+{
+	char *s, *tmp, *tok;
+	int ret = 0;
+
+	s = strdup(str);
+	if (s == NULL)
+		return -1;
+
+	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
+		unsigned int flags = get_type_flag(tok);
+
+		if (flags == -1U) {
+			char buf[32];
+
+			if (strchr(tok, ':'))
+			    continue;
+
+			/* try :R and :W suffixes for rwlock, rwsem, ... */
+			scnprintf(buf, sizeof(buf), "%s:R", tok);
+			flags = get_type_flag(buf);
+			if (flags != -1UL) {
+				if (!add_lock_type(flags)) {
+					ret = -1;
+					break;
+				}
+			}
+
+			scnprintf(buf, sizeof(buf), "%s:W", tok);
+			flags = get_type_flag(buf);
+			if (flags != -1UL) {
+				if (!add_lock_type(flags)) {
+					ret = -1;
+					break;
+				}
+			}
+			continue;
+		}
+
+		if (!add_lock_type(flags)) {
+			ret = -1;
+			break;
+		}
+
+		if (!strcmp(tok, "mutex")) {
+			flags = get_type_flag("mutex-spin");
+			if (flags != -1UL) {
+				if (!add_lock_type(flags)) {
+					ret = -1;
+					break;
+				}
+			}
+		}
+	}
+
+	free(s);
+	return ret;
+}
+
 int cmd_lock(int argc, const char **argv)
 {
 	const struct option lock_options[] = {
@@ -1947,6 +2057,8 @@ int cmd_lock(int argc, const char **argv)
 		    "Default: " __stringify(CONTENTION_STACK_SKIP)),
 	OPT_INTEGER('E', "entries", &print_nr_entries, "display this many functions"),
 	OPT_BOOLEAN('l', "lock-addr", &show_lock_addrs, "show lock stats by address"),
+	OPT_CALLBACK('Y', "type-filter", NULL, "FLAGS",
+		     "Filter specific type of locks", parse_lock_type),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 47fd47fb56c1..d5b75b222d8e 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -5,6 +5,11 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 
+struct lock_filter {
+	int			nr_types;
+	unsigned int		*types;
+};
+
 struct lock_stat {
 	struct hlist_node	hash_entry;
 	struct rb_node		rb;		/* used for sorting */
-- 
2.39.0.314.g84b9a713c41-goog

