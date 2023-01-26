Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91E967C159
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 01:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjAZAJm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 19:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAZAJl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 19:09:41 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23448611D4;
        Wed, 25 Jan 2023 16:09:40 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso5054447pju.0;
        Wed, 25 Jan 2023 16:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=l5XuXmavpSaZYzYj4+k/+ajUmojV5SNgAjFshG+/OWQ=;
        b=JJADm9ZcnjTK0j/Sr1kLk1GqTvHwQGpWMGC7gvei5tGEnhaAAnFHBqxI6DqWCdoa7A
         mjoNooUzGz5GEmEO1x5QYv7TQspVC6pwjZr4duM0aUgz3V9mY7ct6Be4rbo/VWZ1Xkfe
         wY+4plFaObGBcG5K+tUM61g15IEISVBg6N9AcLMxUByzzweq/jzeofGn1Zw/rM2SMGW4
         VzW0qY/SmKGZAaBg5BWKlE1p73zx0gKfGe2fMjhF/t6swa0FXQYRvXjmhN1rKETljPlC
         iDPLKobdir4TYjVrbSnnMiW+VLWtFUy1erqEZdhb2D1jsp1RdGAPeth+4JD2x2mUHyS9
         0ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5XuXmavpSaZYzYj4+k/+ajUmojV5SNgAjFshG+/OWQ=;
        b=ocilVDfpmaJntchqI7wKCNBF2dM33In+vVZZqRfT84CGVlw9ZN2Ccndpu+i85NN6Xi
         XO+lluytXdgdFDIIMn5p0OtKENXchUJbUdus9pbyb0XWTAmxWC5lvB/y3xV2BnFMt1eM
         H0r+LCqBDfU/8pGTV7XsTVV4ql442LtL0mpk4o30uUwryw3dUDpxje/lKrYKx9TwtFZs
         Y37HzByeaJqAIQ8gLpq90DAPSCYDNh3DRnSpX4ZWFmvc+JmfF/QgdcTevSxRkD5ndVgk
         3GJzlSWlr2NTRBwjP6rIvvv+hcB/g2VxHWBbqyVdnXTkd2b+AT32r317nLCpRvjMNRzM
         F6Ew==
X-Gm-Message-State: AFqh2koExvBRNiUrzYhOw1SrmPynllbEEAYIM7RESJ0M76+mbE1gJvoK
        riy10UktPoX1gM/O3e+vbrw=
X-Google-Smtp-Source: AMrXdXvhZRnZ/1zz5oVxrQPA1vnOuc3g4M3uAzkecsih4IdzeoRh7kmCZWOTCu07b6YkpYL9KitACA==
X-Received: by 2002:a05:6a20:8e05:b0:af:ae14:9ecb with SMTP id y5-20020a056a208e0500b000afae149ecbmr52912491pzj.17.1674691779457;
        Wed, 25 Jan 2023 16:09:39 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:29ee:2efb:110e:b369])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b00177faf558b5sm4216160plj.250.2023.01.25.16.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 16:09:38 -0800 (PST)
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
        bpf@vger.kernel.org
Subject: [PATCH] perf lock contention: Add -S/--callstack-filter option
Date:   Wed, 25 Jan 2023 16:09:36 -0800
Message-Id: <20230126000936.3017683-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
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

The -S/--callstack-filter is to limit display entries having the given
string in the callstack (not only in the caller in the output).

The following example shows lock contention results if the callstack
has 'net' substring somewhere.  Note that the caller '__dev_queue_xmit'
does not match to it, but it has 'inet6_csk_xmit' in the callstack.

This applies even if you don't use -v option to show the full callstack.

  $ sudo ./perf lock con -abv -S net sleep 1
  ...
   contended   total wait     max wait     avg wait         type   caller

           5     70.20 us     16.13 us     14.04 us     spinlock   __dev_queue_xmit+0xb6d
                          0xffffffffa5dd1c60  _raw_spin_lock+0x30
                          0xffffffffa5b8f6ed  __dev_queue_xmit+0xb6d
                          0xffffffffa5cd8267  ip6_finish_output2+0x2c7
                          0xffffffffa5cdac14  ip6_finish_output+0x1d4
                          0xffffffffa5cdb477  ip6_xmit+0x457
                          0xffffffffa5d1fd17  inet6_csk_xmit+0xd7
                          0xffffffffa5c5f4aa  __tcp_transmit_skb+0x54a
                          0xffffffffa5c6467d  tcp_keepalive_timer+0x2fd

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt |  6 +++
 tools/perf/builtin-lock.c              | 68 +++++++++++++++++++++++++-
 tools/perf/util/bpf_lock_contention.c  |  2 +-
 tools/perf/util/lock-contention.h      |  1 +
 4 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 0f9f720e599d..11b8901d8d13 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -187,6 +187,12 @@ CONTENTION OPTIONS
 --lock-filter=<value>::
 	Show lock contention only for given lock addresses or names (comma separated list).
 
+-S::
+--callstack-filter=<value>::
+	Show lock contention only if the callstack contains the given string.
+	Note that it matches the substring so 'rq' would match both 'raw_spin_rq_lock'
+	and 'irq_enter_rcu'.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 506c2fe42d52..216a9a252bf4 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -63,11 +63,22 @@ static unsigned long bpf_map_entries = 10240;
 static int max_stack_depth = CONTENTION_STACK_DEPTH;
 static int stack_skip = CONTENTION_STACK_SKIP;
 static int print_nr_entries = INT_MAX / 2;
+static LIST_HEAD(callstack_filters);
+
+struct callstack_filter {
+	struct list_head list;
+	char name[];
+};
 
 static struct lock_filter filters;
 
 static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
 
+static bool needs_callstack(void)
+{
+	return verbose > 0 || !list_empty(&callstack_filters);
+}
+
 static struct thread_stat *thread_stat_find(u32 tid)
 {
 	struct rb_node *node;
@@ -1060,7 +1071,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		if (!ls)
 			return -ENOMEM;
 
-		if (aggr_mode == LOCK_AGGR_CALLER && verbose > 0) {
+		if (aggr_mode == LOCK_AGGR_CALLER && needs_callstack()) {
 			ls->callstack = get_callstack(sample, max_stack_depth);
 			if (ls->callstack == NULL)
 				return -ENOMEM;
@@ -1595,6 +1606,31 @@ static void print_contention_result(struct lock_contention *con)
 		if (!st->wait_time_total)
 			continue;
 
+		if (aggr_mode == LOCK_AGGR_CALLER && !list_empty(&callstack_filters)) {
+			struct map *kmap;
+			struct symbol *sym;
+			u64 ip;
+
+			for (int i = 0; i < max_stack_depth; i++) {
+				struct callstack_filter *filter;
+
+				if (!st->callstack || !st->callstack[i])
+					break;
+
+				ip = st->callstack[i];
+				sym = machine__find_kernel_symbol(con->machine, ip, &kmap);
+				if (sym == NULL)
+					continue;
+
+				list_for_each_entry(filter, &callstack_filters, list) {
+					if (strstr(sym->name, filter->name))
+						goto found;
+				}
+			}
+			continue;
+		}
+
+found:
 		list_for_each_entry(key, &lock_keys, list) {
 			key->print(key, st);
 			pr_info(" ");
@@ -1743,6 +1779,7 @@ static int __cmd_contention(int argc, const char **argv)
 		.max_stack = max_stack_depth,
 		.stack_skip = stack_skip,
 		.filters = &filters,
+		.save_callstack = needs_callstack(),
 	};
 
 	session = perf_session__new(use_bpf ? NULL : &data, &eops);
@@ -2123,6 +2160,33 @@ static int parse_lock_addr(const struct option *opt __maybe_unused, const char *
 	return ret;
 }
 
+static int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
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
+		struct callstack_filter *entry;
+
+		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
+		if (entry == NULL) {
+			pr_err("Memory allocation failure\n");
+			return -1;
+		}
+
+		strcpy(entry->name, tok);
+		list_add_tail(&entry->list, &callstack_filters);
+	}
+
+	free(s);
+	return ret;
+}
+
 int cmd_lock(int argc, const char **argv)
 {
 	const struct option lock_options[] = {
@@ -2190,6 +2254,8 @@ int cmd_lock(int argc, const char **argv)
 		     "Filter specific type of locks", parse_lock_type),
 	OPT_CALLBACK('L', "lock-filter", NULL, "ADDRS/NAMES",
 		     "Filter specific address/symbol of locks", parse_lock_addr),
+	OPT_CALLBACK('S', "callstack-filter", NULL, "NAMES",
+		     "Filter specific function in the callstack", parse_call_stack),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 0236334fd69b..4902ac331f41 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -268,7 +268,7 @@ int lock_contention_read(struct lock_contention *con)
 			break;
 		}
 
-		if (verbose > 0) {
+		if (con->save_callstack) {
 			st->callstack = memdup(stack_trace, stack_size);
 			if (st->callstack == NULL)
 				break;
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index b99e83fccf5c..17e594d57a61 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -128,6 +128,7 @@ struct lock_contention {
 	int max_stack;
 	int stack_skip;
 	int aggr_mode;
+	bool save_callstack;
 };
 
 #ifdef HAVE_BPF_SKEL
-- 
2.39.1.456.gfc5497dd1b-goog

