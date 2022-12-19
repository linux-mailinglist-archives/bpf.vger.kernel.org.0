Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCC36513B6
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 21:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiLSURv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 15:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiLSURn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 15:17:43 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD32464FD;
        Mon, 19 Dec 2022 12:17:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 17so10201264pll.0;
        Mon, 19 Dec 2022 12:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjRD6WezQur7RnAVSzg16H/TNhNuOpZXrFzdEgyZjWY=;
        b=K/iKHmimDZqirm0C7DqsQepDan/duix8fBLJ8QxlpMoI9Q/F+HJT8NS6kSDLd5FvI8
         qHPfSE5jSlN0T/qSRbfhrt3vHNREdAWYIT8/6MRy/r4lKwV6ModsbZfTRjyVYv5egBnt
         rUUOw0Fm9+pt5kUgixtixgUCOUK7f1/Bk/Y4omdYwDKHAVaa1/ezTfDEYNutI+DEWJhm
         QcSAlVXIcUecVuO03SWTH2YonmxNyKIixBH0XCypanctfeQA0sNPLPwasaZcMfCF9Zyc
         OB/Mac6lGYTBl/WvGzy+O4F7FSkUxmDI1YSBn+o2XOBomWfUl8RVh2cS/2XOhBrtZt1g
         0xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RjRD6WezQur7RnAVSzg16H/TNhNuOpZXrFzdEgyZjWY=;
        b=zhk+/W+dC5XFG9wNKG+tSP8bl0viQRKBoacLZUaUNaxeoNXsMaqH8y6D7JZBPQWTKr
         HSx3mxG9DcJ9HAi8xJhRSj0d1n3uQ50UHcBVwBVZLKilgIE5Sy67y3AWB1tFFOleqGTG
         C5FFT51SB1dhPgOTjIGNhrgCiEBjvPmZjZnVU2KSD6UFabZMQydQKBfNpAHxx6Xu4rUs
         5rqFvJeNxZODH/oMTFAuFnL4jYYQMQKP4Gv1GcAv5fVEBkNNf0bWu9PKz5XhAda4oD20
         OV4B2zsOeIzNRRM0PcT10iRUqgrEXCSlD1Uh/0AKhsDgmWYFvpDhVWBY5tzElHMF1kWm
         PaoQ==
X-Gm-Message-State: ANoB5plcZS4kubLNPMo5lBLG30W0ivkjRl2mv9l1w1Cqo0AdYn2zl/Tp
        lRl3LsnxtRv/25dRsMXCGtQ=
X-Google-Smtp-Source: AA0mqf6od1Sl2FQ2RQ0VOzeajp7ymIBLRUWtAdXUHXhWOr03W5wAoNhJktICdLgTO3MR/2F5ecy3sA==
X-Received: by 2002:a17:90a:7525:b0:221:77b4:46e1 with SMTP id q34-20020a17090a752500b0022177b446e1mr27427217pjk.48.1671481062108;
        Mon, 19 Dec 2022 12:17:42 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:735a:2805:e706:5164])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b00219220edf0dsm6324260pju.48.2022.12.19.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:17:41 -0800 (PST)
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
Subject: [PATCH 4/6] perf lock contention: Add -L/--lock-filter option
Date:   Mon, 19 Dec 2022 12:17:30 -0800
Message-Id: <20221219201732.460111-5-namhyung@kernel.org>
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

The -L/--lock-filter option is to filter only given locks.  The locks
can be specified by address or name (if exists).

  $ sudo ./perf lock record -a  sleep 1

  $ sudo ./perf lock con -l
   contended   total wait     max wait     avg wait            address   symbol

          57      1.11 ms     42.83 us     19.54 us   ffff9f4140059000
          15    280.88 us     23.51 us     18.73 us   ffffffff9d007a40   jiffies_lock
           1     20.49 us     20.49 us     20.49 us   ffffffff9d0d50c0   rcu_state
           1      9.02 us      9.02 us      9.02 us   ffff9f41759e9ba0

  $ sudo ./perf lock con -L jiffies_lock,rcu_state
   contended   total wait     max wait     avg wait         type   caller

          15    280.88 us     23.51 us     18.73 us     spinlock   tick_sched_do_timer+0x93
           1     20.49 us     20.49 us     20.49 us     spinlock   __softirqentry_text_start+0xeb

  $ sudo ./perf lock con -L ffff9f4140059000
   contended   total wait     max wait     avg wait         type   caller

          38    779.40 us     42.83 us     20.51 us     spinlock   worker_thread+0x50
          11    216.30 us     39.87 us     19.66 us     spinlock   queue_work_on+0x39
           8    118.13 us     20.51 us     14.77 us     spinlock   kthread+0xe5

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |   4 +
 tools/perf/builtin-lock.c              | 140 +++++++++++++++++++++++--
 tools/perf/util/lock-contention.h      |   4 +
 3 files changed, 142 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index dea04ad5c28e..0f9f720e599d 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -183,6 +183,10 @@ CONTENTION OPTIONS
 	Note that RW-variant of locks have :R and :W suffix.  Names without the
 	suffix are shortcuts for the both variants.  Ex) rwsem = rwsem:R + rwsem:W.
 
+-L::
+--lock-filter=<value>::
+	Show lock contention only for given lock addresses or names (comma separated list).
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e4e785d3b4ec..6b8ea2f0b90a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -32,6 +32,7 @@
 #include <semaphore.h>
 #include <math.h>
 #include <limits.h>
+#include <ctype.h>
 
 #include <linux/list.h>
 #include <linux/hash.h>
@@ -995,24 +996,52 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 	unsigned int flags = evsel__intval(evsel, sample, "flags");
 	u64 key;
 	int i, ret;
+	static bool kmap_loaded;
+	struct machine *machine = &session->machines.host;
+	struct map *kmap;
+	struct symbol *sym;
 
 	ret = get_key_by_aggr_mode(&key, addr, evsel, sample);
 	if (ret < 0)
 		return ret;
 
+	if (!kmap_loaded) {
+		unsigned long *addrs;
+
+		/* make sure it loads the kernel map to find lock symbols */
+		map__load(machine__kernel_map(machine));
+		kmap_loaded = true;
+
+		/* convert (kernel) symbols to addresses */
+		for (i = 0; i < filters.nr_syms; i++) {
+			sym = machine__find_kernel_symbol_by_name(machine,
+								  filters.syms[i],
+								  &kmap);
+			if (sym == NULL) {
+				pr_warning("ignore unknown symbol: %s\n",
+					   filters.syms[i]);
+				continue;
+			}
+
+			addrs = realloc(filters.addrs,
+					(filters.nr_addrs + 1) * sizeof(*addrs));
+			if (addrs == NULL) {
+				pr_warning("memory allocation failure\n");
+				return -ENOMEM;
+			}
+
+			addrs[filters.nr_addrs++] = kmap->unmap_ip(kmap, sym->start);
+			filters.addrs = addrs;
+		}
+	}
+
 	ls = lock_stat_find(key);
 	if (!ls) {
 		char buf[128];
 		const char *name = "";
-		struct machine *machine = &session->machines.host;
-		struct map *kmap;
-		struct symbol *sym;
 
 		switch (aggr_mode) {
 		case LOCK_AGGR_ADDR:
-			/* make sure it loads the kernel map to find lock symbols */
-			map__load(machine__kernel_map(machine));
-
 			sym = machine__find_kernel_symbol(machine, key, &kmap);
 			if (sym)
 				name = sym->name;
@@ -1052,6 +1081,20 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 			return 0;
 	}
 
+	if (filters.nr_addrs) {
+		bool found = false;
+
+		for (i = 0; i < filters.nr_addrs; i++) {
+			if (addr == filters.addrs[i]) {
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
@@ -1496,6 +1539,15 @@ static void lock_filter_finish(void)
 {
 	zfree(&filters.types);
 	filters.nr_types = 0;
+
+	zfree(&filters.addrs);
+	filters.nr_addrs = 0;
+
+	for (int i = 0; i < filters.nr_syms; i++)
+		free(filters.syms[i]);
+
+	zfree(&filters.syms);
+	filters.nr_syms = 0;
 }
 
 static void sort_contention_result(void)
@@ -1995,6 +2047,80 @@ static int parse_lock_type(const struct option *opt __maybe_unused, const char *
 	return ret;
 }
 
+static bool add_lock_addr(unsigned long addr)
+{
+	unsigned long *tmp;
+
+	tmp = realloc(filters.addrs, (filters.nr_addrs + 1) * sizeof(*filters.addrs));
+	if (tmp == NULL) {
+		pr_err("Memory allocation failure\n");
+		return false;
+	}
+
+	tmp[filters.nr_addrs++] = addr;
+	filters.addrs = tmp;
+	return true;
+}
+
+static bool add_lock_sym(char *name)
+{
+	char **tmp;
+	char *sym = strdup(name);
+
+	if (sym == NULL) {
+		pr_err("Memory allocation failure\n");
+		return false;
+	}
+
+	tmp = realloc(filters.syms, (filters.nr_syms + 1) * sizeof(*filters.syms));
+	if (tmp == NULL) {
+		pr_err("Memory allocation failure\n");
+		free(sym);
+		return false;
+	}
+
+	tmp[filters.nr_syms++] = sym;
+	filters.syms = tmp;
+	return true;
+}
+
+static int parse_lock_addr(const struct option *opt __maybe_unused, const char *str,
+			   int unset __maybe_unused)
+{
+	char *s, *tmp, *tok;
+	int ret = 0;
+	u64 addr;
+
+	s = strdup(str);
+	if (s == NULL)
+		return -1;
+
+	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
+		char *end;
+
+		addr = strtoul(tok, &end, 16);
+		if (*end == '\0') {
+			if (!add_lock_addr(addr)) {
+				ret = -1;
+				break;
+			}
+			continue;
+		}
+
+		/*
+		 * At this moment, we don't have kernel symbols.  Save the symbols
+		 * in a separate list and resolve them to addresses later.
+		 */
+		if (!add_lock_sym(tok)) {
+			ret = -1;
+			break;
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
@@ -2060,6 +2186,8 @@ int cmd_lock(int argc, const char **argv)
 	OPT_BOOLEAN('l', "lock-addr", &show_lock_addrs, "show lock stats by address"),
 	OPT_CALLBACK('Y', "type-filter", NULL, "FLAGS",
 		     "Filter specific type of locks", parse_lock_type),
+	OPT_CALLBACK('L', "lock-filter", NULL, "ADDRS/NAMES",
+		     "Filter specific address/symbol of locks", parse_lock_addr),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index dc621386a16b..b99e83fccf5c 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -7,7 +7,11 @@
 
 struct lock_filter {
 	int			nr_types;
+	int			nr_addrs;
+	int			nr_syms;
 	unsigned int		*types;
+	unsigned long		*addrs;
+	char			**syms;
 };
 
 struct lock_stat {
-- 
2.39.0.314.g84b9a713c41-goog

