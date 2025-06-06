Return-Path: <bpf+bounces-59959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40343AD09C2
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B8597A1B04
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 21:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6AF23F42A;
	Fri,  6 Jun 2025 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qPF8LeJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F153223E34C
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749246778; cv=none; b=erpt1fX2VJzMQcWwIZHsDM1FB4uGdQuBYkGVS0p4qRLpjYm2QAvpfkG9BRHBnDBkCyhF6RdPSE7HGUvlGnH8dIVgmxrz/O5iN5XPdgUiZiDNBazLckPWI9K9mD81rjq5af46mcr/EB3m5Zkl2j4r4etCKjcBz1GBxNhHebnDWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749246778; c=relaxed/simple;
	bh=OhUv3r9YK7S2vWeklKY7wXIyczrwBkYk68z5KVxE38M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZCfnAMpvmuW3bTGV85uTwcpsrmqYuAhc8+BM/xwuLVOVY7CYIAUWm49rSv6u7Xe+8mh5BwS4S0cWdVFWovWHsPl3nGLT1TUMqogUiOXuWVSRJn9MsU0qConIsHnueVZeoTk16BZKcKTakOQ38WGbNzL5izYz4ltClSjStzsOjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qPF8LeJ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22aa75e6653so20923325ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Jun 2025 14:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749246776; x=1749851576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JS/Db2SUjK5/g3LbclVsWOHT1Smx8t5HOzo/CvKXbp4=;
        b=4qPF8LeJGIuGPOEENYNF/0NRGd0KoYHWcEFG7U3ywnkDjaD1Hd4OyKdRSlBgwzCEh7
         OiSvEHG2lAjh/Ak2x4mPQ0Ylqe3m7EkiZQ5Dq8TAXJB39jjb3hgplQy+6iGtB18MB5zy
         m8KXh8MZxEc5g+466Qx5aUngHFKsPLM5QleIQ+PRh+ktmI0MrUZ0lZFfOpmI/uuO2Ha6
         iNq25gFrPFg+IY6hUl9Y8IzTawYzE0fZuHbJ1kdacV0pyza8hBbSgnWcwrZ22F9ikcci
         bA1BIdo3ktOzLTtrO3ACI+cBaVoazqUx1I6BdFNI2XqCHYh8oHNGLoc1jYAjC1TpT/OZ
         FUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749246776; x=1749851576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JS/Db2SUjK5/g3LbclVsWOHT1Smx8t5HOzo/CvKXbp4=;
        b=aDTbrnnaRH8aNY39UnEYLoby69FNuoefEAaZClG/eUG37V2y6n/w/rAOVW/gow0vp2
         4LYCUhUhoXW5iZOPIozMvexaDSrHioBTEl7Wx5O/irvkiwcIBQpIDPrCr3oOijTj1amb
         PMf+BTsGhLtyvM8Bhg47+UAT4WpdiKKx4XY0FTYwpP/GkEnK+W99OFlLvgykI74vb+HL
         AzmBDIHbL7KmF5BHu/XqcFlsusmHIM1kToTVAI9mfbdy/OO/gQSpMSEyB3Q9g3JO1/Q3
         32WXULXwWZ9C5Uz/roZebAaXz2xPQuc08baUdPJGWolxLTQelhtSWjxssr/9wzXbHp6a
         I1sg==
X-Forwarded-Encrypted: i=1; AJvYcCU2bL6+qbSV9GcLa6iHEckf/17JQQ9osve41ftLclZL3OkOKtYevVtZdbjGRXqZYnZgGTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgMGjewXHKr78CfpGTjMOMmwGIPWzUT7T7nALvPUlcL0Uf9Mo
	xVd5b32c8GoXxsqsp6gtolVjZjhZ663G7/qZ1rnq0ycUtpbZVBVB9jXF1rHe0gXcmY8dtbR1i0O
	NqSI/6iTKDTezcGJy69hEFQ==
X-Google-Smtp-Source: AGHT+IGlHDIsXQ6iCILcEd7JatNtcpZ/R5Fn6/EzRFCZispX4sWEu4cmFjgXt5Xg05e2D5V/72S4Vg3WxP0+mCk4
X-Received: from plnz4.prod.google.com ([2002:a17:902:8344:b0:234:d2de:e601])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:244c:b0:235:f3df:bc1f with SMTP id d9443c01a7336-23601dc4688mr76887345ad.36.1749246776340;
 Fri, 06 Jun 2025 14:52:56 -0700 (PDT)
Date: Fri,  6 Jun 2025 14:52:44 -0700
In-Reply-To: <20250606215246.2419387-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250606215246.2419387-1-blakejones@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250606215246.2419387-4-blakejones@google.com>
Subject: [PATCH v3 3/5] perf: collect BPF metadata from new programs
From: Blake Jones <blakejones@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	Graham Woodward <graham.woodward@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

This collects metadata for any BPF programs that were loaded during a
"perf record" run, and emits it at the end of the run.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/perf/builtin-record.c        |  8 ++++++
 tools/perf/util/bpf-event.c        | 46 ++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h        |  1 +
 tools/perf/util/env.c              | 19 +++++++++++-
 tools/perf/util/env.h              |  4 +++
 tools/perf/util/header.c           |  1 +
 tools/perf/util/synthetic-events.h |  2 ++
 7 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0b566f300569..47adee0c2a1c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2162,6 +2162,12 @@ static int record__synthesize(struct record *rec, bool tail)
 	return err;
 }
 
+static void record__synthesize_final_bpf_metadata(struct record *rec)
+{
+	perf_event__synthesize_final_bpf_metadata(rec->session,
+						  process_synthesized_event);
+}
+
 static int record__process_signal_event(union perf_event *event __maybe_unused, void *data)
 {
 	struct record *rec = data;
@@ -2807,6 +2813,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
+	record__synthesize_final_bpf_metadata(rec);
+
 	if (opts->auxtrace_snapshot_on_exit)
 		record__auxtrace_snapshot_exit(rec);
 
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 1f6e76ee6024..dc09a4730c50 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -472,6 +472,49 @@ void bpf_metadata_free(struct bpf_metadata *metadata __maybe_unused)
 
 #endif /* HAVE_LIBBPF_STRINGS_SUPPORT */
 
+struct bpf_metadata_final_ctx {
+	const struct perf_tool *tool;
+	perf_event__handler_t process;
+	struct machine *machine;
+};
+
+static void synthesize_final_bpf_metadata_cb(struct bpf_prog_info_node *node,
+					     void *data)
+{
+	struct bpf_metadata_final_ctx *ctx = (struct bpf_metadata_final_ctx *)data;
+	struct bpf_metadata *metadata = node->metadata;
+	int err;
+
+	if (metadata == NULL)
+		return;
+	err = synthesize_perf_record_bpf_metadata(metadata, ctx->tool,
+						  ctx->process, ctx->machine);
+	if (err != 0) {
+		const char *prog_name = metadata->prog_names[0];
+
+		if (prog_name != NULL)
+			pr_warning("Couldn't synthesize final BPF metadata for %s.\n", prog_name);
+		else
+			pr_warning("Couldn't synthesize final BPF metadata.\n");
+	}
+	bpf_metadata_free(metadata);
+	node->metadata = NULL;
+}
+
+void perf_event__synthesize_final_bpf_metadata(struct perf_session *session,
+					       perf_event__handler_t process)
+{
+	struct perf_env *env = &session->header.env;
+	struct bpf_metadata_final_ctx ctx = {
+		.tool = session->tool,
+		.process = process,
+		.machine = &session->machines.host,
+	};
+
+	perf_env__iterate_bpf_prog_info(env, synthesize_final_bpf_metadata_cb,
+					&ctx);
+}
+
 /*
  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
@@ -612,6 +655,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 		}
 
 		info_node->info_linear = info_linear;
+		info_node->metadata = NULL;
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
 			free(info_linear);
 			free(info_node);
@@ -803,6 +847,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	arrays |= 1UL << PERF_BPIL_JITED_INSNS;
 	arrays |= 1UL << PERF_BPIL_LINE_INFO;
 	arrays |= 1UL << PERF_BPIL_JITED_LINE_INFO;
+	arrays |= 1UL << PERF_BPIL_MAP_IDS;
 
 	info_linear = get_bpf_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
@@ -815,6 +860,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	info_node = malloc(sizeof(struct bpf_prog_info_node));
 	if (info_node) {
 		info_node->info_linear = info_linear;
+		info_node->metadata = bpf_metadata_create(&info_linear->info);
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
 			free(info_linear);
 			free(info_node);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 16644b3aaba1..1ed0b36dc3b8 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -25,6 +25,7 @@ struct bpf_metadata {
 
 struct bpf_prog_info_node {
 	struct perf_bpil		*info_linear;
+	struct bpf_metadata		*metadata;
 	struct rb_node			rb_node;
 };
 
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 36411749e007..05a4f2657d72 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -3,8 +3,10 @@
 #include "debug.h"
 #include "env.h"
 #include "util/header.h"
-#include "linux/compiler.h"
+#include "util/rwsem.h"
+#include <linux/compiler.h>
 #include <linux/ctype.h>
+#include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include "cgroup.h"
@@ -89,6 +91,20 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 	return node;
 }
 
+void perf_env__iterate_bpf_prog_info(struct perf_env *env,
+				     void (*cb)(struct bpf_prog_info_node *node,
+						void *data),
+				     void *data)
+{
+	struct rb_node *first;
+
+	down_read(&env->bpf_progs.lock);
+	first = rb_first(&env->bpf_progs.infos);
+	for (struct rb_node *node = first; node != NULL; node = rb_next(node))
+		(*cb)(rb_entry(node, struct bpf_prog_info_node, rb_node), data);
+	up_read(&env->bpf_progs.lock);
+}
+
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
 {
 	bool ret;
@@ -174,6 +190,7 @@ static void perf_env__purge_bpf(struct perf_env *env)
 		next = rb_next(&node->rb_node);
 		rb_erase(&node->rb_node, root);
 		zfree(&node->info_linear);
+		bpf_metadata_free(node->metadata);
 		free(node);
 	}
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d90e343cf1fa..6819cb9b99ff 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -180,6 +180,10 @@ bool perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
+void perf_env__iterate_bpf_prog_info(struct perf_env *env,
+				     void (*cb)(struct bpf_prog_info_node *node,
+						void *data),
+				     void *data);
 bool perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 bool __perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e3cdc3b7b4ab..7c477e2a93b3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3161,6 +3161,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
 		/* after reading from file, translate offset to address */
 		bpil_offs_to_addr(info_linear);
 		info_node->info_linear = info_linear;
+		info_node->metadata = NULL;
 		if (!__perf_env__insert_bpf_prog_info(env, info_node)) {
 			free(info_linear);
 			free(info_node);
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index b9c936b5cfeb..ee29615d68e5 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -92,6 +92,8 @@ int perf_event__synthesize_threads(const struct perf_tool *tool, perf_event__han
 int perf_event__synthesize_tracing_data(const struct perf_tool *tool, int fd, struct evlist *evlist, perf_event__handler_t process);
 int perf_event__synth_time_conv(const struct perf_event_mmap_page *pc, const struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 pid_t perf_event__synthesize_comm(const struct perf_tool *tool, union perf_event *event, pid_t pid, perf_event__handler_t process, struct machine *machine);
+void perf_event__synthesize_final_bpf_metadata(struct perf_session *session,
+					       perf_event__handler_t process);
 
 int perf_tool__process_synth_event(const struct perf_tool *tool, union perf_event *event, struct machine *machine, perf_event__handler_t process);
 
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


