Return-Path: <bpf+bounces-26371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 270DB89EB17
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80491B241F8
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30F51F602;
	Wed, 10 Apr 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sk3cbTk+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBCF2D05D
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731346; cv=none; b=n40dpa/a0SDE9U5LgnaTboPkbhO7B0jlXQobbWfpcgIAnXg6299OxqnzQ5Z7ummwL/fgLao0xY1Drx8MDCFauaYioZwaQWB4EtEg7xAmtSSzv1qxcVXJP+DbminKvaRkowFtQ46U3LbyxCKzFIv049B5AxU5ef6YgOCHrVd8Rtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731346; c=relaxed/simple;
	bh=SMCVUYowrGzJMdi4nTpQFEMpYjxcpgGfvbluM51+sCE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=irjyd77UoFxajXifUu1quXOYW44IcOhN+0XZQv3oNM2oJOP83OLnC5NPAct7zT25sE/FCuOLwBvkRkSxL7nybSyAyglVDSVGsAbCglWs5Cdpe3NsrOfLzyTN61YfrHNm99EyL63LU66L091s/ydmpUg1pumU7v7Q5mxNN1G28vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sk3cbTk+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd944567b6cso8414153276.2
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731343; x=1713336143; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mih80+QdQE43Tg7ZF+99UtFUTtA4OC5FDf/EzEE2jEk=;
        b=sk3cbTk+dGUMqwv6Bu/STFP3FDNvYZ0z1C9uSyKhOUEzbW7LKhV73kxT5RLsyseVxG
         s83+kidTtfXWHyWeDeweeCETmvyYvb7qYOr3A55S4e+MKg+f41/LWUVWVKszeMwVdZPW
         8fTpDBLN3WS+4u+rHIUSDov1lWS6DC/TSD4KSSw82FfAhKAAiHQO6+lrd5S9wsdMgx3J
         1gTL/AqVd4UbfEMOMtMCzS4HnzfYE9CwIvQNvqn66Tt43lXdr8809tYfO7ZWr86zo72i
         gzDGP7rePHcOUrd5R3cPwlNPD4FUPw+e2YeaoWcgPeSbQVOxZnceT1R+5B+ne0/S7as/
         xw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731343; x=1713336143;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mih80+QdQE43Tg7ZF+99UtFUTtA4OC5FDf/EzEE2jEk=;
        b=JTsYrdxzgBbnYw3i5NAXwZpdBHibe1R7NfUTIIXniq8kzuCp3PkzcJQcX/Q9rT97Ce
         8lyHAXHpVCB5fhOKvYBogpoBxafTe2e3RNbusFXI+2Pzb2i0+RQXmJQbLWs6iik+3qtt
         iHQWA5m6GAiLzDw1BuFj6CI6W6Bzbe1dvP0JTvn/r/WfpQA/1tqrlWbV09EkM6kiBNPS
         XjU1YwmzFy7RmBpIeI9lsPa/bfYkr9YNFEPX+MzOT9DZARrUxKcIRBUgSSCcYdPj/BmJ
         uIJx4v4n5oYx/U26T6R0nlFFrlK5nPUV3VcK3uJQZBLisCu0EDY6j9AU/tR7Gb1Uprq4
         rgcw==
X-Forwarded-Encrypted: i=1; AJvYcCVrGfPV8JvJoNp8vR89guN55h3fg1a4D/MfQL50r7vq1ZPH/DiWtMxqoXL2Ybve+V1I1ilT9gHPGk1unYwU7xmP7Vl9
X-Gm-Message-State: AOJu0YxwajH0tpMNf6ELe+SAMHlilDlmMOrCXS9SDq3MD/4j7jtEcRvN
	e1b3m0Lw5yA1crYHO3MBeww0Ht4wGGZNqDnupcAVG50kAkeILXLKY8+3C4zrYXTNYnOfBhAy6Rh
	TziYXWg==
X-Google-Smtp-Source: AGHT+IFUJt2PiR8gchoXXib+3Y+oJMwuTpeOWa5SSx640YDNZ1hj8sbyJedkdqh5Bt7h12K/8yZm4/d5aIf9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dc6:e647:3fae with SMTP
 id w10-20020a056902100a00b00dc6e6473faemr217954ybt.2.1712731343268; Tue, 09
 Apr 2024 23:42:23 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:03 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 01/12] perf dsos: Attempt to better abstract dsos internals
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move functions from machine and build-id to dsos. Pass dsos struct
rather than internal state. Rename some functions to better represent
which data structure they operate on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c |  2 +-
 tools/perf/builtin-record.c |  2 +-
 tools/perf/util/build-id.c  | 38 +---------------------------
 tools/perf/util/build-id.h  |  2 --
 tools/perf/util/dso.h       |  6 -----
 tools/perf/util/dsos.c      | 49 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/dsos.h      | 19 +++++++++++---
 tools/perf/util/machine.c   | 40 ++++++------------------------
 tools/perf/util/machine.h   |  2 ++
 tools/perf/util/session.c   | 21 ++++++++++++++++
 tools/perf/util/session.h   |  2 ++
 11 files changed, 97 insertions(+), 86 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index eb3ef5c24b66..ef73317e6ae7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2122,7 +2122,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		 */
 		if (perf_header__has_feat(&session->header, HEADER_BUILD_ID) &&
 		    inject->have_auxtrace && !inject->itrace_synth_opts.set)
-			dsos__hit_all(session);
+			perf_session__dsos_hit_all(session);
 		/*
 		 * The AUX areas have been removed and replaced with
 		 * synthesized hardware events, so clear the feature flag.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 40d2c1c48666..32df34dda9cd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1790,7 +1790,7 @@ record__finish_output(struct record *rec)
 		process_buildids(rec);
 
 		if (rec->buildid_all)
-			dsos__hit_all(rec->session);
+			perf_session__dsos_hit_all(rec->session);
 	}
 	perf_session__write_header(rec->session, rec->evlist, fd, true);
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 03c64b85383b..a617b1917e6b 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -390,42 +390,6 @@ int perf_session__write_buildid_table(struct perf_session *session,
 	return err;
 }
 
-static int __dsos__hit_all(struct list_head *head)
-{
-	struct dso *pos;
-
-	list_for_each_entry(pos, head, node)
-		pos->hit = true;
-
-	return 0;
-}
-
-static int machine__hit_all_dsos(struct machine *machine)
-{
-	return __dsos__hit_all(&machine->dsos.head);
-}
-
-int dsos__hit_all(struct perf_session *session)
-{
-	struct rb_node *nd;
-	int err;
-
-	err = machine__hit_all_dsos(&session->machines.host);
-	if (err)
-		return err;
-
-	for (nd = rb_first_cached(&session->machines.guests); nd;
-	     nd = rb_next(nd)) {
-		struct machine *pos = rb_entry(nd, struct machine, rb_node);
-
-		err = machine__hit_all_dsos(pos);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 void disable_buildid_cache(void)
 {
 	no_buildid_cache = true;
@@ -992,7 +956,7 @@ int perf_session__cache_build_ids(struct perf_session *session)
 
 static bool machine__read_build_ids(struct machine *machine, bool with_hits)
 {
-	return __dsos__read_build_ids(&machine->dsos.head, with_hits);
+	return __dsos__read_build_ids(&machine->dsos, with_hits);
 }
 
 bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 4e3a1169379b..3fa8bffb07ca 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -39,8 +39,6 @@ int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
 			   struct perf_sample *sample, struct evsel *evsel,
 			   struct machine *machine);
 
-int dsos__hit_all(struct perf_session *session);
-
 int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
 			       struct perf_sample *sample, struct evsel *evsel,
 			       struct machine *machine);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 17dab230a2ca..3d4faad8d5dc 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -233,12 +233,6 @@ struct dso {
 #define dso__for_each_symbol(dso, pos, n)	\
 	symbols__for_each_entry(&(dso)->symbols, pos, n)
 
-#define dsos__for_each_with_build_id(pos, head)	\
-	list_for_each_entry(pos, head, node)	\
-		if (!pos->has_build_id)		\
-			continue;		\
-		else
-
 static inline void dso__set_loaded(struct dso *dso)
 {
 	dso->loaded = true;
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cf80aa42dd07..e65ef6762bed 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -12,6 +12,35 @@
 #include <symbol.h> // filename__read_build_id
 #include <unistd.h>
 
+void dsos__init(struct dsos *dsos)
+{
+	INIT_LIST_HEAD(&dsos->head);
+	dsos->root = RB_ROOT;
+	init_rwsem(&dsos->lock);
+}
+
+static void dsos__purge(struct dsos *dsos)
+{
+	struct dso *pos, *n;
+
+	down_write(&dsos->lock);
+
+	list_for_each_entry_safe(pos, n, &dsos->head, node) {
+		RB_CLEAR_NODE(&pos->rb_node);
+		pos->root = NULL;
+		list_del_init(&pos->node);
+		dso__put(pos);
+	}
+
+	up_write(&dsos->lock);
+}
+
+void dsos__exit(struct dsos *dsos)
+{
+	dsos__purge(dsos);
+	exit_rwsem(&dsos->lock);
+}
+
 static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 {
 	if (a->maj > b->maj) return -1;
@@ -73,8 +102,9 @@ int dso__cmp_id(struct dso *a, struct dso *b)
 	return __dso_id__cmp(&a->id, &b->id);
 }
 
-bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
+bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits)
 {
+	struct list_head *head = &dsos->head;
 	bool have_build_id = false;
 	struct dso *pos;
 	struct nscookie nsc;
@@ -303,9 +333,10 @@ struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id
 	return dso;
 }
 
-size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
+size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm)
 {
+	struct list_head *head = &dsos->head;
 	struct dso *pos;
 	size_t ret = 0;
 
@@ -320,8 +351,9 @@ size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
 	return ret;
 }
 
-size_t __dsos__fprintf(struct list_head *head, FILE *fp)
+size_t __dsos__fprintf(struct dsos *dsos, FILE *fp)
 {
+	struct list_head *head = &dsos->head;
 	struct dso *pos;
 	size_t ret = 0;
 
@@ -331,3 +363,14 @@ size_t __dsos__fprintf(struct list_head *head, FILE *fp)
 
 	return ret;
 }
+
+int __dsos__hit_all(struct dsos *dsos)
+{
+	struct list_head *head = &dsos->head;
+	struct dso *pos;
+
+	list_for_each_entry(pos, head, node)
+		pos->hit = true;
+
+	return 0;
+}
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index 5dbec2bc6966..1c81ddf07f8f 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -21,6 +21,15 @@ struct dsos {
 	struct rw_semaphore lock;
 };
 
+#define dsos__for_each_with_build_id(pos, head)	\
+	list_for_each_entry(pos, head, node)	\
+		if (!pos->has_build_id)		\
+			continue;		\
+		else
+
+void dsos__init(struct dsos *dsos);
+void dsos__exit(struct dsos *dsos);
+
 void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
@@ -28,13 +37,15 @@ struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
  
+bool __dsos__read_build_ids(struct dsos *dsos, bool with_hits);
+
 struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso *dso,
 						const char *name, struct dso_id *id);
 
-bool __dsos__read_build_ids(struct list_head *head, bool with_hits);
-
-size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
+size_t __dsos__fprintf_buildid(struct dsos *dsos, FILE *fp,
 			       bool (skip)(struct dso *dso, int parm), int parm);
-size_t __dsos__fprintf(struct list_head *head, FILE *fp);
+size_t __dsos__fprintf(struct dsos *dsos, FILE *fp);
+
+int __dsos__hit_all(struct dsos *dsos);
 
 #endif /* __PERF_DSOS */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5eb9044bc223..dc8d5e410535 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -48,13 +48,6 @@ static struct dso *machine__kernel_dso(struct machine *machine)
 	return map__dso(machine->vmlinux_map);
 }
 
-static void dsos__init(struct dsos *dsos)
-{
-	INIT_LIST_HEAD(&dsos->head);
-	dsos->root = RB_ROOT;
-	init_rwsem(&dsos->lock);
-}
-
 static int machine__set_mmap_name(struct machine *machine)
 {
 	if (machine__is_host(machine))
@@ -165,28 +158,6 @@ struct machine *machine__new_kallsyms(void)
 	return machine;
 }
 
-static void dsos__purge(struct dsos *dsos)
-{
-	struct dso *pos, *n;
-
-	down_write(&dsos->lock);
-
-	list_for_each_entry_safe(pos, n, &dsos->head, node) {
-		RB_CLEAR_NODE(&pos->rb_node);
-		pos->root = NULL;
-		list_del_init(&pos->node);
-		dso__put(pos);
-	}
-
-	up_write(&dsos->lock);
-}
-
-static void dsos__exit(struct dsos *dsos)
-{
-	dsos__purge(dsos);
-	exit_rwsem(&dsos->lock);
-}
-
 void machine__delete_threads(struct machine *machine)
 {
 	threads__remove_all_threads(&machine->threads);
@@ -907,11 +878,11 @@ static struct map *machine__addnew_module_map(struct machine *machine, u64 start
 size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 {
 	struct rb_node *nd;
-	size_t ret = __dsos__fprintf(&machines->host.dsos.head, fp);
+	size_t ret = __dsos__fprintf(&machines->host.dsos, fp);
 
 	for (nd = rb_first_cached(&machines->guests); nd; nd = rb_next(nd)) {
 		struct machine *pos = rb_entry(nd, struct machine, rb_node);
-		ret += __dsos__fprintf(&pos->dsos.head, fp);
+		ret += __dsos__fprintf(&pos->dsos, fp);
 	}
 
 	return ret;
@@ -920,7 +891,7 @@ size_t machines__fprintf_dsos(struct machines *machines, FILE *fp)
 size_t machine__fprintf_dsos_buildid(struct machine *m, FILE *fp,
 				     bool (skip)(struct dso *dso, int parm), int parm)
 {
-	return __dsos__fprintf_buildid(&m->dsos.head, fp, skip, parm);
+	return __dsos__fprintf_buildid(&m->dsos, fp, skip, parm);
 }
 
 size_t machines__fprintf_dsos_buildid(struct machines *machines, FILE *fp,
@@ -3306,3 +3277,8 @@ bool machine__is_lock_function(struct machine *machine, u64 addr)
 
 	return false;
 }
+
+int machine__hit_all_dsos(struct machine *machine)
+{
+	return __dsos__hit_all(&machine->dsos);
+}
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 4312f6db6de0..82a47bac8023 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -306,4 +306,6 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 int machine__resolve(struct machine *machine, struct addr_location *al,
 		     struct perf_sample *sample);
 
+int machine__hit_all_dsos(struct machine *machine);
+
 #endif /* __PERF_MACHINE_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 02a932a83c51..a10343b9dcd4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2916,3 +2916,24 @@ int perf_event__process_id_index(struct perf_session *session,
 	}
 	return 0;
 }
+
+int perf_session__dsos_hit_all(struct perf_session *session)
+{
+	struct rb_node *nd;
+	int err;
+
+	err = machine__hit_all_dsos(&session->machines.host);
+	if (err)
+		return err;
+
+	for (nd = rb_first_cached(&session->machines.guests); nd;
+	     nd = rb_next(nd)) {
+		struct machine *pos = rb_entry(nd, struct machine, rb_node);
+
+		err = machine__hit_all_dsos(pos);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 5064c6ec11e7..3b0256e977a6 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -156,6 +156,8 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_sample *sample);
 
+int perf_session__dsos_hit_all(struct perf_session *session);
+
 int perf_event__process_id_index(struct perf_session *session,
 				 union perf_event *event);
 
-- 
2.44.0.478.gd926399ef9-goog


