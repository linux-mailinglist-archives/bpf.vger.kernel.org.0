Return-Path: <bpf+bounces-9013-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026C878E2FD
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 01:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC276280E65
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 23:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA5C8C1C;
	Wed, 30 Aug 2023 23:01:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAA8C02
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 23:01:57 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387F483;
	Wed, 30 Aug 2023 16:01:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68bee12e842so156586b3a.3;
        Wed, 30 Aug 2023 16:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693436493; x=1694041293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMcSxo2F836TQfM16lAyyXFuDeX3GK2PoeKLyRM3B1o=;
        b=GsvmzVFE26QbB4nbAKguiXOMfNAZEvhghfkiYoiNEaH1ef19I3NL2FhHAutra5pPxb
         S9+c4QHdfSoRbxsTQBm96vI3DNZd37CKJtO7adJAKWXWRzhEY/pC4EExWUgU2w3sd6z8
         thaTl9Lf+4wbQrQ6eWlbmXvHDHKOYwnPwMm2WOJcFnx877g+3PzWXvUwzUPHiTZfSFE+
         PK1MwPPBOY8e/W9FXrFOBIlGHiqBE8V2gAfLtDlsXpHRmB0J6j7Rg+ZrTb3IQEaElc3u
         vWFsDcmveNyfTMzeN4ZXSHePoVDT5X1FpFd581SDnHcP0lq3RQTul2uTEiYNfkyE8HMO
         lu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693436493; x=1694041293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wMcSxo2F836TQfM16lAyyXFuDeX3GK2PoeKLyRM3B1o=;
        b=NbBhhxkKsS6UVuthyLZyZFxhHiVrR7Toh0OGfNuDeVrIdM3dntl1QU7XB/qJ9bETkI
         20+nYDce4fAgJQ737EcyK7695GsdsGidkL7c8Zlh34uiv9FW1cl/VDvjnJf2CRuSnPfc
         02AypTn0Pr9N2raHi91e/L35ciZqKT6L55xRaFnGF9+wDRts+lICGA6Tbt6RTw0alrlu
         WEV55y5Uk4mYS8pwTpYxseWVAlrqrG0EKYY0mzkNKDXWzjrJg2RxMP1z/w3+DzecWnsO
         woPhu7ntI39xMDo/azhy89gmQfMsFjy6Xio4xsTBp68DSlN3Mrpwqdb4lgsqMEIXgCn9
         JFig==
X-Gm-Message-State: AOJu0YyPuyjrWJHN/j7YgtOaHSO+f/3tYtKW3JwDpTe7Kd2pQ9s/Ab95
	fJH5EpsoSRVInjG6ZqyWkNY=
X-Google-Smtp-Source: AGHT+IFZt+3Eyj4xvpcVGgNsvDDjEJltoeF+bhLDnlbqdFB0ouRwsHgetMwUG/UFzPnShBcZ5hKpew==
X-Received: by 2002:a05:6a00:2e83:b0:68a:52ec:3d36 with SMTP id fd3-20020a056a002e8300b0068a52ec3d36mr4163557pfb.31.1693436493373;
        Wed, 30 Aug 2023 16:01:33 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:4366:cd91:1c34:2aa7])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7928d000000b00689f8dc26c2sm92531pfa.133.2023.08.30.16.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 16:01:32 -0700 (PDT)
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
Subject: [PATCH 3/5] perf lock contention: Add -g/--lock-cgroup option
Date: Wed, 30 Aug 2023 16:01:24 -0700
Message-ID: <20230830230126.260508-4-namhyung@kernel.org>
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
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The -g option shows lock contention stats break down by cgroups.
Add LOCK_AGGR_CGROUP mode and use it instead of use_cgroup field.

  $ sudo ./perf lock con -abg sleep 1
   contended   total wait     max wait     avg wait   cgroup

           8     15.70 us      6.34 us      1.96 us   /
           2      1.48 us       747 ns       738 ns   /user.slice/.../app.slice/app-gnome-google\x2dchrome-6442.scope
           1       848 ns       848 ns       848 ns   /user.slice/.../session.slice/org.gnome.Shell@x11.service
           1       220 ns       220 ns       220 ns   /user.slice/.../session.slice/pipewire-pulse.service

For now, the cgroup mode only works with BPF (-b).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt        |  4 ++
 tools/perf/builtin-lock.c                     | 42 ++++++++++++++++++-
 tools/perf/util/bpf_lock_contention.c         | 14 ++++---
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 31 +++++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |  3 +-
 tools/perf/util/lock-contention.h             |  1 -
 6 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 30eea576721f..61c491df72b8 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -208,6 +208,10 @@ CONTENTION OPTIONS
 	Show results using a CSV-style output to make it easy to import directly
 	into spreadsheets. Columns are separated by the string specified in SEP.
 
+-g::
+--lock-cgroup::
+	Show lock contention stat by cgroup.  Requires --use-bpf.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 69086d94f588..b98948dd40ba 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -60,6 +60,7 @@ static bool combine_locks;
 static bool show_thread_stats;
 static bool show_lock_addrs;
 static bool show_lock_owner;
+static bool show_lock_cgroups;
 static bool use_bpf;
 static unsigned long bpf_map_entries = MAX_ENTRIES;
 static int max_stack_depth = CONTENTION_STACK_DEPTH;
@@ -619,6 +620,7 @@ static int get_key_by_aggr_mode_simple(u64 *key, u64 addr, u32 tid)
 		*key = tid;
 		break;
 	case LOCK_AGGR_CALLER:
+	case LOCK_AGGR_CGROUP:
 	default:
 		pr_err("Invalid aggregation mode: %d\n", aggr_mode);
 		return -EINVAL;
@@ -1103,6 +1105,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 			if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
 				name = "Unknown";
 			break;
+		case LOCK_AGGR_CGROUP:
 		case LOCK_AGGR_TASK:
 		default:
 			break;
@@ -1653,6 +1656,9 @@ static void print_header_stdio(void)
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "  %16s   %s\n\n", "address", "symbol");
 		break;
+	case LOCK_AGGR_CGROUP:
+		fprintf(lock_output, "  %s\n\n", "cgroup");
+		break;
 	default:
 		break;
 	}
@@ -1680,6 +1686,9 @@ static void print_header_csv(const char *sep)
 	case LOCK_AGGR_ADDR:
 		fprintf(lock_output, "%s%s %s%s %s\n", "address", sep, "symbol", sep, "type");
 		break;
+	case LOCK_AGGR_CGROUP:
+		fprintf(lock_output, "%s\n", "cgroup");
+		break;
 	default:
 		break;
 	}
@@ -1720,6 +1729,9 @@ static void print_lock_stat_stdio(struct lock_contention *con, struct lock_stat
 		fprintf(lock_output, "  %016llx   %s (%s)\n", (unsigned long long)st->addr,
 			st->name, get_type_name(st->flags));
 		break;
+	case LOCK_AGGR_CGROUP:
+		fprintf(lock_output, "  %s\n", st->name);
+		break;
 	default:
 		break;
 	}
@@ -1770,6 +1782,9 @@ static void print_lock_stat_csv(struct lock_contention *con, struct lock_stat *s
 		fprintf(lock_output, "%llx%s %s%s %s\n", (unsigned long long)st->addr, sep,
 			st->name, sep, get_type_name(st->flags));
 		break;
+	case LOCK_AGGR_CGROUP:
+		fprintf(lock_output, "%s\n",st->name);
+		break;
 	default:
 		break;
 	}
@@ -1999,6 +2014,27 @@ static int check_lock_contention_options(const struct option *options,
 		return -1;
 	}
 
+	if (show_lock_cgroups && !use_bpf) {
+		pr_err("Cgroups are available only with BPF\n");
+		parse_options_usage(usage, options, "lock-cgroup", 0);
+		parse_options_usage(NULL, options, "use-bpf", 0);
+		return -1;
+	}
+
+	if (show_lock_cgroups && show_lock_addrs) {
+		pr_err("Cannot use cgroup and addr mode together\n");
+		parse_options_usage(usage, options, "lock-cgroup", 0);
+		parse_options_usage(NULL, options, "lock-addr", 0);
+		return -1;
+	}
+
+	if (show_lock_cgroups && show_thread_stats) {
+		pr_err("Cannot use cgroup and thread mode together\n");
+		parse_options_usage(usage, options, "lock-cgroup", 0);
+		parse_options_usage(NULL, options, "threads", 0);
+		return -1;
+	}
+
 	if (symbol_conf.field_sep) {
 		if (strstr(symbol_conf.field_sep, ":") || /* part of type flags */
 		    strstr(symbol_conf.field_sep, "+") || /* part of caller offset */
@@ -2060,7 +2096,8 @@ static int __cmd_contention(int argc, const char **argv)
 	con.machine = &session->machines.host;
 
 	con.aggr_mode = aggr_mode = show_thread_stats ? LOCK_AGGR_TASK :
-		show_lock_addrs ? LOCK_AGGR_ADDR : LOCK_AGGR_CALLER;
+		show_lock_addrs ? LOCK_AGGR_ADDR :
+		show_lock_cgroups ? LOCK_AGGR_CGROUP : LOCK_AGGR_CALLER;
 
 	if (con.aggr_mode == LOCK_AGGR_CALLER)
 		con.save_callstack = true;
@@ -2159,7 +2196,7 @@ static int __cmd_contention(int argc, const char **argv)
 out_delete:
 	lock_filter_finish();
 	evlist__delete(con.evlist);
-	lock_contention_finish();
+	lock_contention_finish(&con);
 	perf_session__delete(session);
 	zfree(&lockhash_table);
 	return err;
@@ -2524,6 +2561,7 @@ int cmd_lock(int argc, const char **argv)
 	OPT_BOOLEAN('o', "lock-owner", &show_lock_owner, "show lock owners instead of waiters"),
 	OPT_STRING_NOEMPTY('x', "field-separator", &symbol_conf.field_sep, "separator",
 		   "print result in CSV format with custom separator"),
+	OPT_BOOLEAN('g', "lock-cgroup", &show_lock_cgroups, "show lock stats by cgroup"),
 	OPT_PARENT(lock_options)
 	};
 
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 9d36b07eccf5..42753a0dfdc5 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -152,7 +152,10 @@ int lock_contention_prepare(struct lock_contention *con)
 	skel->bss->needs_callstack = con->save_callstack;
 	skel->bss->lock_owner = con->owner;
 
-	if (con->use_cgroup) {
+	if (con->aggr_mode == LOCK_AGGR_CGROUP) {
+		if (cgroup_is_v2("perf_event"))
+			skel->bss->use_cgroup_v2 = 1;
+
 		read_all_cgroups(&con->cgroups);
 	}
 
@@ -214,12 +217,12 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 			return "siglock";
 
 		/* global locks with symbols */
-		sym = machine__find_kernel_symbol(machine, key->lock_addr, &kmap);
+		sym = machine__find_kernel_symbol(machine, key->lock_addr_or_cgroup, &kmap);
 		if (sym)
 			return sym->name;
 
 		/* try semi-global locks collected separately */
-		if (!bpf_map_lookup_elem(lock_fd, &key->lock_addr, &flags)) {
+		if (!bpf_map_lookup_elem(lock_fd, &key->lock_addr_or_cgroup, &flags)) {
 			if (flags == LOCK_CLASS_RQLOCK)
 				return "rq_lock";
 		}
@@ -227,7 +230,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 		return "";
 	}
 
-	if (con->use_cgroup) {
+	if (con->aggr_mode == LOCK_AGGR_CGROUP) {
 		u64 cgrp_id = key->lock_addr_or_cgroup;
 		struct cgroup *cgrp = __cgroup__find(&con->cgroups, cgrp_id);
 
@@ -329,7 +332,8 @@ int lock_contention_read(struct lock_contention *con)
 			ls_key = key.pid;
 			break;
 		case LOCK_AGGR_ADDR:
-			ls_key = key.lock_addr;
+		case LOCK_AGGR_CGROUP:
+			ls_key = key.lock_addr_or_cgroup;
 			break;
 		default:
 			goto next;
diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 8d3cfbb3cc65..823354999022 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -118,6 +118,9 @@ int needs_callstack;
 int stack_skip;
 int lock_owner;
 
+int use_cgroup_v2;
+int perf_subsys_id = -1;
+
 /* determine the key of lock stat */
 int aggr_mode;
 
@@ -130,6 +133,29 @@ int data_fail;
 int task_map_full;
 int data_map_full;
 
+static inline __u64 get_current_cgroup_id(void)
+{
+	struct task_struct *task;
+	struct cgroup *cgrp;
+
+	if (use_cgroup_v2)
+		return bpf_get_current_cgroup_id();
+
+	task = bpf_get_current_task_btf();
+
+	if (perf_subsys_id == -1) {
+#if __has_builtin(__builtin_preserve_enum_value)
+		perf_subsys_id = bpf_core_enum_value(enum cgroup_subsys_id,
+						     perf_event_cgrp_id);
+#else
+		perf_subsys_id = perf_event_cgrp_id;
+#endif
+	}
+
+	cgrp = BPF_CORE_READ(task, cgroups, subsys[perf_subsys_id], cgroup);
+	return BPF_CORE_READ(cgrp, kn, id);
+}
+
 static inline int can_record(u64 *ctx)
 {
 	if (has_cpu) {
@@ -364,10 +390,13 @@ int contention_end(u64 *ctx)
 			key.stack_id = pelem->stack_id;
 		break;
 	case LOCK_AGGR_ADDR:
-		key.lock_addr = pelem->lock;
+		key.lock_addr_or_cgroup = pelem->lock;
 		if (needs_callstack)
 			key.stack_id = pelem->stack_id;
 		break;
+	case LOCK_AGGR_CGROUP:
+		key.lock_addr_or_cgroup = get_current_cgroup_id();
+		break;
 	default:
 		/* should not happen */
 		return 0;
diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf_skel/lock_data.h
index 260062a9f2ab..08482daf61be 100644
--- a/tools/perf/util/bpf_skel/lock_data.h
+++ b/tools/perf/util/bpf_skel/lock_data.h
@@ -6,7 +6,7 @@
 struct contention_key {
 	u32 stack_id;
 	u32 pid;
-	u64 lock_addr;
+	u64 lock_addr_or_cgroup;
 };
 
 #define TASK_COMM_LEN  16
@@ -39,6 +39,7 @@ enum lock_aggr_mode {
 	LOCK_AGGR_ADDR = 0,
 	LOCK_AGGR_TASK,
 	LOCK_AGGR_CALLER,
+	LOCK_AGGR_CGROUP,
 };
 
 enum lock_class_sym {
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 70423966d778..a073cc6a82d2 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -144,7 +144,6 @@ struct lock_contention {
 	int owner;
 	int nr_filtered;
 	bool save_callstack;
-	bool use_cgroup;
 };
 
 #ifdef HAVE_BPF_SKEL
-- 
2.42.0.283.g2d96d420d3-goog


