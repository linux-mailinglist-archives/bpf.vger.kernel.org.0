Return-Path: <bpf+bounces-9349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA3F79423D
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 19:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39AD91C2096D
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F187111A4;
	Wed,  6 Sep 2023 17:49:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023591119B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 17:49:12 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB8219A5;
	Wed,  6 Sep 2023 10:49:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-573f87480aeso103513a12.1;
        Wed, 06 Sep 2023 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694022551; x=1694627351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bv7DmFZONY3oD1dEZff0keudkrZ6REhufXZJ2Hw6rUw=;
        b=sJVyA7/e/HInvIPgDAIdbeCoDKKZrEL0buZtOQaf+cr2Ca1+zazP58PV3fTJiy3IG3
         GeVYeS4KEjgpc0L2Ny+DsGjHL249dsmhrnGde3JNc+vUeF5l7c6sMO6jaQIx2+LaRxrY
         PLljeN9MbYmiP+hZif9wUYT2091UPgeTdnyqBQhgpW4XHAgoSkwm4S9DGOshnKFV0qrq
         PNr8dMSZCqSjKgO4nG0GSHc1m957/PHdUYz/pj16dW/m+p9zK5tTOIQDf73GWysxaX0o
         qB/kn0BrEi0XrKdfCWKUnDygpP0yxenFV2ULqmaUewmd74l3SGiIBSv0XZ026bu9ssFR
         S0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694022551; x=1694627351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bv7DmFZONY3oD1dEZff0keudkrZ6REhufXZJ2Hw6rUw=;
        b=G6wHTryvPSbGl2OZXturrAfQKaucefhE8H7qzwy4l8UnXrlGQcvtqBqHl4vHO9uriu
         w0apEWAnE4SXpLuDtS5chm7N+7piEP/geqqJrMH3GL9jGxJeQAiOwBhBGtd1YKT5+V6B
         EHvt0cjwTxMiYg52P0UcifO1hnOMvwcsVorFVtb6au0mMMssj2KD+YqL/Gp2xLW8eV+i
         Vu8YilhCIHWhfz/M//o6kTvsWsf9DHN2iLAGZo3X7RfrM7hRjVsgeOB3npkXHK0D1uH7
         lG/9bu7iWOOhLvjRt+WLi/RZgkqanDOyLJZamFG3cmci1nYmnhOdQynon2uDDgCDmHPF
         AN/w==
X-Gm-Message-State: AOJu0Yyvkuim9EyK7KjR4Ll6TRybVB0drEutW8XnhPMQUm54vvBxsAP4
	QCBPvoM+/OOeOuslKVwbHfg=
X-Google-Smtp-Source: AGHT+IFVLXGXwVfXeBXhCZE/7zZp30yqYCIcX0o3C0RIPqTpKMatkpivhcXq+FvQFq10fAxS14GyJw==
X-Received: by 2002:a17:90a:d3c5:b0:262:ded7:63d with SMTP id d5-20020a17090ad3c500b00262ded7063dmr14124464pjw.17.1694022550607;
        Wed, 06 Sep 2023 10:49:10 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:5035:1b47:9a3f:312c])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090ad30b00b00262eccfa29fsm63564pju.33.2023.09.06.10.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:49:10 -0700 (PDT)
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
Subject: [PATCH 4/5] perf lock contention: Add -G/--cgroup-filter option
Date: Wed,  6 Sep 2023 10:49:02 -0700
Message-ID: <20230906174903.346486-5-namhyung@kernel.org>
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

The -G/--cgroup-filter is to limit lock contention collection on the
tasks in the specific cgroups only.

  $ sudo ./perf lock con -abt -G /user.slice/.../vte-spawn-52221fb8-b33f-4a52-b5c3-e35d1e6fc0e0.scope \
    ./perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.174 [sec]
   contended   total wait     max wait     avg wait          pid   comm

           4    114.45 us     60.06 us     28.61 us       214847   sched-messaging
           2    111.40 us     60.84 us     55.70 us       214848   sched-messaging
           2    106.09 us     59.42 us     53.04 us       214837   sched-messaging
           1     81.70 us     81.70 us     81.70 us       214709   sched-messaging
          68     78.44 us      6.83 us      1.15 us       214633   sched-messaging
          69     73.71 us      2.69 us      1.07 us       214632   sched-messaging
           4     72.62 us     60.83 us     18.15 us       214850   sched-messaging
           2     71.75 us     67.60 us     35.88 us       214840   sched-messaging
           2     69.29 us     67.53 us     34.65 us       214804   sched-messaging
           2     69.00 us     68.23 us     34.50 us       214826   sched-messaging
  ...

Export cgroup__new() function as it's needed from outside.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt        |  4 ++
 tools/perf/builtin-lock.c                     | 56 +++++++++++++++++++
 tools/perf/util/bpf_lock_contention.c         | 15 ++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 17 ++++++
 tools/perf/util/cgroup.c                      |  2 +-
 tools/perf/util/cgroup.h                      |  1 +
 tools/perf/util/lock-contention.h             |  2 +
 7 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 61c491df72b8..0897443948b7 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -212,6 +212,10 @@ CONTENTION OPTIONS
 --lock-cgroup::
 	Show lock contention stat by cgroup.  Requires --use-bpf.
 
+-G::
+--cgroup-filter=<value>::
+	Show lock contention only in the given cgroups (comma separated list).
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b98948dd40ba..3902780d5229 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -10,6 +10,7 @@
 #include "util/thread.h"
 #include "util/header.h"
 #include "util/target.h"
+#include "util/cgroup.h"
 #include "util/callchain.h"
 #include "util/lock-contention.h"
 #include "util/bpf_skel/lock_data.h"
@@ -1631,6 +1632,9 @@ static void lock_filter_finish(void)
 
 	zfree(&filters.syms);
 	filters.nr_syms = 0;
+
+	zfree(&filters.cgrps);
+	filters.nr_cgrps = 0;
 }
 
 static void sort_contention_result(void)
@@ -2488,6 +2492,56 @@ static int parse_output(const struct option *opt __maybe_unused, const char *str
 	return 0;
 }
 
+static bool add_lock_cgroup(char *name)
+{
+	u64 *tmp;
+	struct cgroup *cgrp;
+
+	cgrp = cgroup__new(name, /*do_open=*/false);
+	if (cgrp == NULL) {
+		pr_err("Failed to create cgroup: %s\n", name);
+		return false;
+	}
+
+	if (read_cgroup_id(cgrp) < 0) {
+		pr_err("Failed to read cgroup id for %s\n", name);
+		cgroup__put(cgrp);
+		return false;
+	}
+
+	tmp = realloc(filters.cgrps, (filters.nr_cgrps + 1) * sizeof(*filters.cgrps));
+	if (tmp == NULL) {
+		pr_err("Memory allocation failure\n");
+		return false;
+	}
+
+	tmp[filters.nr_cgrps++] = cgrp->id;
+	filters.cgrps = tmp;
+	cgroup__put(cgrp);
+	return true;
+}
+
+static int parse_cgroup_filter(const struct option *opt __maybe_unused, const char *str,
+			       int unset __maybe_unused)
+{
+	char *s, *tmp, *tok;
+	int ret = 0;
+
+	s = strdup(str);
+	if (s == NULL)
+		return -1;
+
+	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
+		if (!add_lock_cgroup(tok)) {
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
@@ -2562,6 +2616,8 @@ int cmd_lock(int argc, const char **argv)
 	OPT_STRING_NOEMPTY('x', "field-separator", &symbol_conf.field_sep, "separator",
 		   "print result in CSV format with custom separator"),
 	OPT_BOOLEAN('g', "lock-cgroup", &show_lock_cgroups, "show lock stats by cgroup"),
+	OPT_CALLBACK('G', "cgroup-filter", NULL, "CGROUPS",
+		     "Filter specific cgroups", parse_cgroup_filter),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 42753a0dfdc5..e105245eb905 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -21,7 +21,7 @@ static struct lock_contention_bpf *skel;
 int lock_contention_prepare(struct lock_contention *con)
 {
 	int i, fd;
-	int ncpus = 1, ntasks = 1, ntypes = 1, naddrs = 1;
+	int ncpus = 1, ntasks = 1, ntypes = 1, naddrs = 1, ncgrps = 1;
 	struct evlist *evlist = con->evlist;
 	struct target *target = con->target;
 
@@ -51,6 +51,8 @@ int lock_contention_prepare(struct lock_contention *con)
 		ntasks = perf_thread_map__nr(evlist->core.threads);
 	if (con->filters->nr_types)
 		ntypes = con->filters->nr_types;
+	if (con->filters->nr_cgrps)
+		ncgrps = con->filters->nr_cgrps;
 
 	/* resolve lock name filters to addr */
 	if (con->filters->nr_syms) {
@@ -85,6 +87,7 @@ int lock_contention_prepare(struct lock_contention *con)
 	bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
 	bpf_map__set_max_entries(skel->maps.type_filter, ntypes);
 	bpf_map__set_max_entries(skel->maps.addr_filter, naddrs);
+	bpf_map__set_max_entries(skel->maps.cgroup_filter, ncgrps);
 
 	if (lock_contention_bpf__load(skel) < 0) {
 		pr_err("Failed to load lock-contention BPF skeleton\n");
@@ -146,6 +149,16 @@ int lock_contention_prepare(struct lock_contention *con)
 			bpf_map_update_elem(fd, &con->filters->addrs[i], &val, BPF_ANY);
 	}
 
+	if (con->filters->nr_cgrps) {
+		u8 val = 1;
+
+		skel->bss->has_cgroup = 1;
+		fd = bpf_map__fd(skel->maps.cgroup_filter);
+
+		for (i = 0; i < con->filters->nr_cgrps; i++)
+			bpf_map_update_elem(fd, &con->filters->cgrps[i], &val, BPF_ANY);
+	}
+
 	/* these don't work well if in the rodata section */
 	skel->bss->stack_skip = con->stack_skip;
 	skel->bss->aggr_mode = con->aggr_mode;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 823354999022..4900a5dfb4a4 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -92,6 +92,13 @@ struct {
 	__uint(max_entries, 1);
 } addr_filter SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} cgroup_filter SEC(".maps");
+
 struct rw_semaphore___old {
 	struct task_struct *owner;
 } __attribute__((preserve_access_index));
@@ -114,6 +121,7 @@ int has_cpu;
 int has_task;
 int has_type;
 int has_addr;
+int has_cgroup;
 int needs_callstack;
 int stack_skip;
 int lock_owner;
@@ -194,6 +202,15 @@ static inline int can_record(u64 *ctx)
 			return 0;
 	}
 
+	if (has_cgroup) {
+		__u8 *ok;
+		__u64 cgrp = get_current_cgroup_id();
+
+		ok = bpf_map_lookup_elem(&cgroup_filter, &cgrp);
+		if (!ok)
+			return 0;
+	}
+
 	return 1;
 }
 
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 2e969d1464f4..b8499da2ef48 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -114,7 +114,7 @@ static struct cgroup *evlist__find_cgroup(struct evlist *evlist, const char *str
 	return NULL;
 }
 
-static struct cgroup *cgroup__new(const char *name, bool do_open)
+struct cgroup *cgroup__new(const char *name, bool do_open)
 {
 	struct cgroup *cgroup = zalloc(sizeof(*cgroup));
 
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index beb6fe1012ed..de8882d6e8d3 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -26,6 +26,7 @@ void cgroup__put(struct cgroup *cgroup);
 struct evlist;
 struct rblist;
 
+struct cgroup *cgroup__new(const char *name, bool do_open);
 struct cgroup *evlist__findnew_cgroup(struct evlist *evlist, const char *name);
 int evlist__expand_cgroup(struct evlist *evlist, const char *cgroups,
 			  struct rblist *metric_events, bool open_cgroup);
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index a073cc6a82d2..1a7248ff3889 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -9,9 +9,11 @@ struct lock_filter {
 	int			nr_types;
 	int			nr_addrs;
 	int			nr_syms;
+	int			nr_cgrps;
 	unsigned int		*types;
 	unsigned long		*addrs;
 	char			**syms;
+	u64			*cgrps;
 };
 
 struct lock_stat {
-- 
2.42.0.283.g2d96d420d3-goog


