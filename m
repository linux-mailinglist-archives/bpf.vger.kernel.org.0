Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42586513B2
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 21:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiLSUR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 15:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiLSURp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 15:17:45 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593FB2BEB;
        Mon, 19 Dec 2022 12:17:44 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u7so1953502plq.11;
        Mon, 19 Dec 2022 12:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPDKYa8rD0VGPJQCF4t4qysKE20di3XOvK38s4BKO3o=;
        b=eu74UH9wGz7WdMFh5I8pM9WdmBiR0Gv/5jH4BeNEPO5Oh7kKrO5Zw9QorVrRLl3E7l
         oFgfj9hH2ZqKdQENWy9Bjknh7HEN4CvLiXJ+CQBl8JxTiah8rgaUafJJTsy6PWInyYmH
         QeMM6U7TxlcqfoJ0ZTbZ8fS2H1bHWyCNVkWt0J8myV2L/g5GzZyuidb8eKNmTaop6wN7
         IprPWJ9430EJgQoBc5Vk1Dhqv//azBjgF1hF/yd1krmYuVyHGhKIiyUcEJBT6DcXRAv9
         U1s/G1kalt1Xr0/8BUi8JBlYTXVJ+6rjpmFLnH1N25LvKC7MeD9rlswVqWYKVuW7eosn
         WKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rPDKYa8rD0VGPJQCF4t4qysKE20di3XOvK38s4BKO3o=;
        b=JLW8YZsPbHBYxKbI37XrGvpDDwsTOAuIFiKMPwP/n9UjFKNVuHKWF0zNymHlZcdIrW
         hBjF+KCtK0FL8GdDoJKwTRfLZ1tkUKNwed31/dK4tih+NIvFOiuhN659fp6JpzFZvSnv
         JFCdE0G8wI2mg5yXSKZ1n8geRbQYYa9DbdzF3s1P+TGMfQGyVbVuNJkLlweV7mme7YmM
         M+wcQoRrrg86Jg2JTAU8MWpfHHdC7YVIpgT/9NFc83U3NsBEPdtWq2MtzXej20bHR49F
         XC5/Ay3EwRwXmjsiYFQEa/n0JiwBaBcq1bqOaS03YiQLBmRJ1bBsJxPq6BuVGOBtDOiF
         BCBA==
X-Gm-Message-State: ANoB5pkocWtEtaA3/WnUY70PtuyUxykZIrPy8hHGsLnov/upoMYSDdpE
        li4+pZHlfVYTwAKmaqvGk2MOtJut6oA=
X-Google-Smtp-Source: AA0mqf5diJCT17BnJvoYPnuCPXbLNOWfhI+btTr1+tmXTumar6BFC9seq0Cix3EVbaz6BKBHk04sxA==
X-Received: by 2002:a17:90a:6be6:b0:219:34cb:476c with SMTP id w93-20020a17090a6be600b0021934cb476cmr46122823pjj.9.1671481063752;
        Mon, 19 Dec 2022 12:17:43 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:735a:2805:e706:5164])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b00219220edf0dsm6324260pju.48.2022.12.19.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:17:43 -0800 (PST)
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
Subject: [PATCH 5/6] perf lock contention: Support lock addr/name filtering for BPF
Date:   Mon, 19 Dec 2022 12:17:31 -0800
Message-Id: <20221219201732.460111-6-namhyung@kernel.org>
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

Likewise, add addr_filter BPF hash map and check it with the lock
address.

  $ sudo ./perf lock con -ab -L tasklist_lock -- ./perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.169 [sec]
   contended   total wait     max wait     avg wait         type   caller

          18    174.09 us     25.31 us      9.67 us     rwlock:W   do_exit+0x36d
           5     32.34 us     10.87 us      6.47 us     rwlock:R   do_wait+0x8b
           4     15.41 us      4.73 us      3.85 us     rwlock:W   release_task+0x6e

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c         | 42 ++++++++++++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 17 ++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index b8590b82ad3d..4a95c0ebcb3c 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -20,7 +20,7 @@ static struct lock_contention_bpf *skel;
 int lock_contention_prepare(struct lock_contention *con)
 {
 	int i, fd;
-	int ncpus = 1, ntasks = 1, ntypes = 1;
+	int ncpus = 1, ntasks = 1, ntypes = 1, naddrs = 1;
 	struct evlist *evlist = con->evlist;
 	struct target *target = con->target;
 
@@ -49,9 +49,39 @@ int lock_contention_prepare(struct lock_contention *con)
 	if (con->filters->nr_types)
 		ntypes = con->filters->nr_types;
 
+	/* resolve lock name filters to addr */
+	if (con->filters->nr_syms) {
+		struct symbol *sym;
+		struct map *kmap;
+		unsigned long *addrs;
+
+		for (i = 0; i < con->filters->nr_syms; i++) {
+			sym = machine__find_kernel_symbol_by_name(con->machine,
+								  con->filters->syms[i],
+								  &kmap);
+			if (sym == NULL) {
+				pr_warning("ignore unknown symbol: %s\n",
+					   con->filters->syms[i]);
+				continue;
+			}
+
+			addrs = realloc(con->filters->addrs,
+					(con->filters->nr_addrs + 1) * sizeof(*addrs));
+			if (addrs == NULL) {
+				pr_warning("memory allocation failure\n");
+				continue;
+			}
+
+			addrs[con->filters->nr_addrs++] = kmap->unmap_ip(kmap, sym->start);
+			con->filters->addrs = addrs;
+		}
+		naddrs = con->filters->nr_addrs;
+	}
+
 	bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
 	bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
 	bpf_map__set_max_entries(skel->maps.type_filter, ntypes);
+	bpf_map__set_max_entries(skel->maps.addr_filter, naddrs);
 
 	if (lock_contention_bpf__load(skel) < 0) {
 		pr_err("Failed to load lock-contention BPF skeleton\n");
@@ -103,6 +133,16 @@ int lock_contention_prepare(struct lock_contention *con)
 			bpf_map_update_elem(fd, &con->filters->types[i], &val, BPF_ANY);
 	}
 
+	if (con->filters->nr_addrs) {
+		u8 val = 1;
+
+		skel->bss->has_addr = 1;
+		fd = bpf_map__fd(skel->maps.addr_filter);
+
+		for (i = 0; i < con->filters->nr_addrs; i++)
+			bpf_map_update_elem(fd, &con->filters->addrs[i], &val, BPF_ANY);
+	}
+
 	/* these don't work well if in the rodata section */
 	skel->bss->stack_skip = con->stack_skip;
 	skel->bss->aggr_mode = con->aggr_mode;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index fb0128de7c00..ad0ca5d50557 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -69,11 +69,19 @@ struct {
 	__uint(max_entries, 1);
 } type_filter SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} addr_filter SEC(".maps");
+
 /* control flags */
 int enabled;
 int has_cpu;
 int has_task;
 int has_type;
+int has_addr;
 int stack_skip;
 
 /* determine the key of lock stat */
@@ -111,6 +119,15 @@ static inline int can_record(u64 *ctx)
 			return 0;
 	}
 
+	if (has_addr) {
+		__u8 *ok;
+		__u64 addr = ctx[0];
+
+		ok = bpf_map_lookup_elem(&addr_filter, &addr);
+		if (!ok)
+			return 0;
+	}
+
 	return 1;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

