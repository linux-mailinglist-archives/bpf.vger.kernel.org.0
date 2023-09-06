Return-Path: <bpf+bounces-9348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E071979423A
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 19:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA062811DC
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 17:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3844511197;
	Wed,  6 Sep 2023 17:49:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22411192
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 17:49:10 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEBA19A2;
	Wed,  6 Sep 2023 10:49:08 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3aa1c04668bso75709b6e.0;
        Wed, 06 Sep 2023 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694022548; x=1694627348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuYzt7xPG0E87DLY3ah52THY+sk0KT9cUifgWh31Iso=;
        b=aavKP7yubnssInvx5jwrrn/KAHNUR1SRl+Mjzs/cFCaSpZisZ5FlZRIg4sKVfL2weH
         Wlr1tFNS1zY4wgIvAkU3OaXrQRPmHSCSiDn41WCIbx6kIXqCGs/A1uivogKrrP7GExmK
         5bVfSiWL4dw1Nj8yhUymn7RaOcmW6HGIz1R/sB+0xqiqdqpxSiPVShMs1WOMf2bsyNHu
         DSJTuP1RML/+MsxmIawd1MCObGG+4bImU4PQ64SMgjSFuAQ9NuZZECekE2HtxKN2mKsh
         WpAeQXHNoo3XGC56+/8AkWANGfwUPjRNHO4bW/WR0se05cpFnHCtNq3UsdbRyv6WwU9q
         DgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694022548; x=1694627348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QuYzt7xPG0E87DLY3ah52THY+sk0KT9cUifgWh31Iso=;
        b=gombU1DvGZrN6Mfnb9Chl0FTybAPPlbln5EIbh3QKKOQYGnPTd/Mx21QSUuWVd8cmq
         kU7m5RJVKv21G3NSvFasboq+skfFvrO80eXCdhwhkUCgzluOKwirsHeEek6AOzxzgDtv
         a3ffw+Avs5NktP1S3mR4z2nO7WwxEKOv4CvBDjb6NNnZczu4PADete/pFW7y51JRYkwz
         PB8IkP0LXyHIR/TAEOR1GfKNq/TPpiSciguRdz3X+z3BbTsTI2jd5N6626W6lzvpnC+F
         Eab2X2UJWC1Oa5HJg6jVg5gk9aA6gNy6kwanAATn1gt7RSuWW8HYZAgWmf5npnXuDnQ9
         JvXQ==
X-Gm-Message-State: AOJu0YyrDKnsg24TOOqFcSBOgAiXQjQYLjGn+/CS/pkPkhfyGwGWLODj
	9qdwlJC1fNDoW0ZFQD5K0Jw=
X-Google-Smtp-Source: AGHT+IFY2Tb5xL1bNPvdrxTNqpVVBf/kIm5+SACfJQs8hNOKEbD/qvTA1tmmk5PNw99wWdNZX36A/g==
X-Received: by 2002:a05:6808:b2e:b0:3a6:febf:fb with SMTP id t14-20020a0568080b2e00b003a6febf00fbmr15011434oij.22.1694022548067;
        Wed, 06 Sep 2023 10:49:08 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:5035:1b47:9a3f:312c])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090ad30b00b00262eccfa29fsm63564pju.33.2023.09.06.10.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:49:07 -0700 (PDT)
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
Date: Wed,  6 Sep 2023 10:49:00 -0700
Message-ID: <20230906174903.346486-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230906174903.346486-1-namhyung@kernel.org>
References: <20230906174903.346486-1-namhyung@kernel.org>
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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c             |  3 ++-
 tools/perf/util/bpf_lock_contention.c | 26 +++++++++++++++++++++++++-
 tools/perf/util/lock-contention.h     |  9 +++++++--
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b141f2134274..06430980dfd7 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2040,6 +2040,7 @@ static int __cmd_contention(int argc, const char **argv)
 		.filters = &filters,
 		.save_callstack = needs_callstack(),
 		.owner = show_lock_owner,
+		.cgroups = RB_ROOT,
 	};
 
 	lockhash_table = calloc(LOCKHASH_SIZE, sizeof(*lockhash_table));
@@ -2158,7 +2159,7 @@ static int __cmd_contention(int argc, const char **argv)
 out_delete:
 	lock_filter_finish();
 	evlist__delete(con.evlist);
-	lock_contention_finish();
+	lock_contention_finish(&con);
 	perf_session__delete(session);
 	zfree(&lockhash_table);
 	return err;
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index e7dddf0127bc..c6bd7c9b2d57 100644
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
+		u64 cgrp_id = key->lock_addr;
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


