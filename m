Return-Path: <bpf+bounces-9012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C931E78E2FA
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822F7280D2E
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0178C15;
	Wed, 30 Aug 2023 23:01:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72548C02
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:01:53 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA89A10D1;
	Wed, 30 Aug 2023 16:01:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a440a8a20so148446b3a.3;
        Wed, 30 Aug 2023 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693436492; x=1694041292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCAB80Hl0oB8ahU5hZKKBa30iR3cuIAT81QaXCwq690=;
        b=sA0rDcQhzmmN8nyE8unxjEaGvYMWe3lVKDh0YZmkwruCIjVjOPhPmz0LcaO4jK4i7J
         wBszNA1m4myS2N5WUkTn2UnQp6YtN+pumyFqMrR1rTm948PRKFP/AE++00JneoeaQbKw
         Wwhj8+4JtAg9UQ+a710lxiqgVIJ2SbTyCsweENhK/EBwoYTHIao/j75JXczEHM5rR+r7
         s5bDSkQVNUOsRGKgn5x5d9AqrX9rn14iAmBgu7MbSP700432sNwGObejzfo+nVdg8VUU
         GVkRJK9oPI0oo++uB7cGPRI8aIBS1gN7kNT3V4+j6YeLYP0+Bf/qp7hAXidP/SKj8HYi
         H97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693436492; x=1694041292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hCAB80Hl0oB8ahU5hZKKBa30iR3cuIAT81QaXCwq690=;
        b=RFRq2u/hXmRjoNXl16x5G21mwPeb6WcEgycUOdAucCu5mwtQZ+7WvzNVhaNSB/IwgM
         sMa1FJ4b6rGlhYNTUaXYiAD7II8WEER1LtJNVKhBZUuE5Ud4HpGIcVuE2K/D5upTuS5v
         8qBsz79zMAvzJ9pclsIHYmYmC82lPs1jqZxe9iwdoThPek9SAwyeaqcmwO+ER0p8ZJyC
         2ESUk9WOGirvxIBo8caUy2yBhy4omqIzNDOJSxkKapwsXup8O+mNVTY2Ki/9seIOVvn3
         R6KrF6N06NerqHZTnGGge11bqUZJ5VCJWR0bPLB2Q7N2uDIXFtkOxISt5wRprhO384gu
         WeJA==
X-Gm-Message-State: AOJu0YxMkfkiEKL+G4ADf60HoSN3an7maKoTErGZpXG6CVmOrPYbStFD
	zowlJ4wdr4QRFrem3vrGgEM=
X-Google-Smtp-Source: AGHT+IF0EJhydYvJIhTWuO+pRVEVclJzrPq1oVUQYF3g5+45HWGNrcrSdC6P1zaZymT/WUN9Z2BEHA==
X-Received: by 2002:a05:6a00:189f:b0:68a:4dfa:ea62 with SMTP id x31-20020a056a00189f00b0068a4dfaea62mr4052100pfh.9.1693436492058;
        Wed, 30 Aug 2023 16:01:32 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:4366:cd91:1c34:2aa7])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7928d000000b00689f8dc26c2sm92531pfa.133.2023.08.30.16.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:01:31 -0700 (PDT)
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
Subject: [PATCH 2/5] perf lock contention: Prepare to handle cgroups
Date: Wed, 30 Aug 2023 16:01:23 -0700
Message-ID: <20230830230126.260508-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830230126.260508-1-namhyung@kernel.org>
References: <20230830230126.260508-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Save cgroup info and display cgroup names if requested.  This is a
preparation for the next patch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c             |  1 +
 tools/perf/util/bpf_lock_contention.c | 26 +++++++++++++++++++++++++-
 tools/perf/util/lock-contention.h     |  9 +++++++--
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b141f2134274..69086d94f588 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2040,6 +2040,7 @@ static int __cmd_contention(int argc, const char **argv)
 		.filters = &filters,
 		.save_callstack = needs_callstack(),
 		.owner = show_lock_owner,
+		.cgroups = RB_ROOT,
 	};
 
 	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index e7dddf0127bc..9d36b07eccf5 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "util/cgroup.h"
 #include "util/debug.h"
 #include "util/evlist.h"
 #include "util/machine.h"
@@ -151,6 +152,10 @@ int lock_contention_prepare(struct lock_contention *con)
 	skel->bss->needs_callstack = con->save_callstack;
 	skel->bss->lock_owner = con->owner;
 
+	if (con->use_cgroup) {
+		read_all_cgroups(&con->cgroups);
+	}
+
 	bpf_program__set_autoload(skel->progs.collect_lock_syms, false);
 
 	lock_contention_bpf__attach(skel);
@@ -222,6 +227,17 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 		return "";
 	}
 
+	if (con->use_cgroup) {
+		u64 cgrp_id = key->lock_addr_or_cgroup;
+		struct cgroup *cgrp = __cgroup__find(&con->cgroups, cgrp_id);
+
+		if (cgrp)
+			return cgrp->name;
+
+		snprintf(name_buf, sizeof(name_buf), "cgroup:%lu", cgrp_id);
+		return name_buf;
+	}
+
 	/* LOCK_AGGR_CALLER: skip lock internal functions */
 	while (machine__is_lock_function(machine, stack_trace[idx]) &&
 	       idx < con->max_stack - 1)
@@ -364,12 +380,20 @@ int lock_contention_read(struct lock_contention *con)
 	return err;
 }
 
-int lock_contention_finish(void)
+int lock_contention_finish(struct lock_contention *con)
 {
 	if (skel) {
 		skel->bss->enabled = 0;
 		lock_contention_bpf__destroy(skel);
 	}
 
+	while (!RB_EMPTY_ROOT(&con->cgroups)) {
+		struct rb_node *node = rb_first(&con->cgroups);
+		struct cgroup *cgrp = rb_entry(node, struct cgroup, node);
+
+		rb_erase(node, &con->cgroups);
+		cgroup__put(cgrp);
+	}
+
 	return 0;
 }
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index fa16532c971c..70423966d778 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -136,6 +136,7 @@ struct lock_contention {
 	struct hlist_head *result;
 	struct lock_filter *filters;
 	struct lock_contention_fails fails;
+	struct rb_root cgroups;
 	unsigned long map_nr_entries;
 	int max_stack;
 	int stack_skip;
@@ -143,6 +144,7 @@ struct lock_contention {
 	int owner;
 	int nr_filtered;
 	bool save_callstack;
+	bool use_cgroup;
 };
 
 #ifdef HAVE_BPF_SKEL
@@ -151,7 +153,7 @@ int lock_contention_prepare(struct lock_contention *con);
 int lock_contention_start(void);
 int lock_contention_stop(void);
 int lock_contention_read(struct lock_contention *con);
-int lock_contention_finish(void);
+int lock_contention_finish(struct lock_contention *con);
 
 #else  /* !HAVE_BPF_SKEL */
 
@@ -162,7 +164,10 @@ static inline int lock_contention_prepare(struct lock_contention *con __maybe_un
 
 static inline int lock_contention_start(void) { return 0; }
 static inline int lock_contention_stop(void) { return 0; }
-static inline int lock_contention_finish(void) { return 0; }
+static inline int lock_contention_finish(struct lock_contention *con __maybe_unused)
+{
+	return 0;
+}
 
 static inline int lock_contention_read(struct lock_contention *con __maybe_unused)
 {
-- 
2.42.0.283.g2d96d420d3-goog


