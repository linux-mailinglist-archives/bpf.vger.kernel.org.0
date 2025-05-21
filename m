Return-Path: <bpf+bounces-58693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 634B8ABFF82
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 00:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F89318943C0
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146123D2A4;
	Wed, 21 May 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4fiOf15n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A8B23C501
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866460; cv=none; b=bYYVkxFG9o6v758LgrUuY1cH6YSoV7swPqTKZg9GjyLvgH0gIBW1fseQZV+aOu9DIdQ/43gbno/RhhfTecAGcBYGmF2pwMlzY4fd5Z9u21uL+i8J5+3PvTgZv2F2GgLY2baPGxRG4vmgkj5iGt2YtkkHFY+iyMHDpuH8PT9I9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866460; c=relaxed/simple;
	bh=5ndQlhz9FB0GfSKHERXhMy+k18dPFRMneg+C7rlhXrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cwZc3BG3gPzmQvlFByYdUiMMp11ja0rnjFwq2qnRcPgfRFf+vTM1pJhxkVgN/nWyGq5SqX6liD7F9hpqsW+ExDLmmryysLK27AAtMIZPuJA11tjDKxlBMae5brWvkMCp3Y/KcA5eRs4aaohXykvUMjhuWXbaEQo6ZJFrFVWvxKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4fiOf15n; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2371b50cabso7388918a12.0
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 15:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747866458; x=1748471258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDcyyMeU1YQ93lXrfp13UEs17WcGmsLfdj2k2DTJvn0=;
        b=4fiOf15nj2eUvQ3wGvBM+9Zg41ywyP2b/WcvRC5EByR3Lg3WN4iOkBFB5QCjqMIIln
         FFTTlELJWL0Yxky3ylHbPensmussOri6LKEd95t8SSlc/iJnyc9Pai1283hZVCrFLogl
         O+/3FWfyQAExVYeUaLnevU7WqKIdX0PXi8Nb2TtXNC58WxdricgYzqkf/ZsK/2N1ln1F
         Zt32Uq8x+0ZNTZ251AHu07vj87hSmSRheFyUfHsXzybIk4rJ7xTOhpDhKUrGWYaiUaBA
         SiRJJYy7V9AhDOeBo8yLMuxERwuRFFQ7/QuRh5KwT4Vg/5A5ujCQf/darlzbL46dtMt/
         r61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747866458; x=1748471258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDcyyMeU1YQ93lXrfp13UEs17WcGmsLfdj2k2DTJvn0=;
        b=OMUe5VBPVJKDX3/cPS6zoVK5VJ0+tht1brbBXZ0DBIbJU4z9Wfoh6eMU+1k281BaSj
         kU1LxDz7oBaJsezbq4kqJ15k7OTDq0KJywKFU4PtBlDwji77PI/cyWaGnlp2PQDxGhPo
         FbFaIRJZMcCVw5vmfimzZvW9GnawW3UEQxYRu+KnvXWflmN32BWsH5hauT61zcLtLqCR
         GHXZKimpH60eQHMRfnEfOWR74RgGEUE1fcg5eQl6j6G4VSwMPlTK9tOVh79l6uJbIE/3
         nRy7kSEPX9vABqL7QFxlSvRqPPAQEop0BpjhZD5JQHlEZfS4vkmO0+BdKxev5pjZyX3G
         0bKA==
X-Forwarded-Encrypted: i=1; AJvYcCX9jMljWgouQi8erurIqjNoXwBj5LDOIgYYGMvdKdUhM3uVxfXn9osqCs4G+K2rdoTv5ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeynQF635aFozfWQOn5vCpqZ+Z7XX1+B7GH6PR9V6e04Tf/4fS
	d1G7UR8DI/ndWhuJvfvQ0Qj3SiTfD1/LFfhERKeLir/qb7RazX/UY5AGLQE1Z0X2OdGYOE3LoAp
	CVAgzRLRqi01c1It7H6qAvQ==
X-Google-Smtp-Source: AGHT+IFGTXu7UDkEpHZnS+Hgm7cF9sD9eNKr/GvnOl9svURNm8Pz7ShENK06WLkLAzzYV8lkiM3fDq1O64bf0hvW
X-Received: from pgal137.prod.google.com ([2002:a63:3e8f:0:b0:af2:54b0:c8d5])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:cfa2:b0:204:4573:d856 with SMTP id adf61e73a8af0-216fba27c2cmr32432733637.4.1747866458060;
 Wed, 21 May 2025 15:27:38 -0700 (PDT)
Date: Wed, 21 May 2025 15:27:25 -0700
In-Reply-To: <20250521222725.3895192-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250521222725.3895192-1-blakejones@google.com>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Message-ID: <20250521222725.3895192-4-blakejones@google.com>
Subject: [PATCH 3/3] perf: collect BPF metadata from new programs, and display
 the new event
From: Blake Jones <blakejones@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	James Clark <james.clark@linaro.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

This collects metadata for any BPF programs that were loaded during a
"perf record" run, and emits it at the end of the run. It also adds support
for displaying the new PERF_RECORD_BPF_METADATA type.

Here's some example "perf script -D" output for the new event type. The
": unhandled!" message is from tool.c, analogous to other behavior there.
I've elided some rows with all NUL characters for brevity, and I wrapped
one of the >75-column lines to fit in the commit guidelines.

0x50fc8@perf.data [0x260]: event: 84
.
. ... raw event: size 608 bytes
.  0000:  54 00 00 00 00 00 60 02 62 70 66 5f 70 72 6f 67  T.....`.bpf_prog
.  0010:  5f 31 65 30 61 32 65 33 36 36 65 35 36 66 31 61  _1e0a2e366e56f1a
.  0020:  32 5f 70 65 72 66 5f 73 61 6d 70 6c 65 5f 66 69  2_perf_sample_fi
.  0030:  6c 74 65 72 00 00 00 00 00 00 00 00 00 00 00 00  lter............
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[...]
.  0110:  74 65 73 74 5f 76 61 6c 75 65 00 00 00 00 00 00  test_value......
.  0120:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[...]
.  0150:  34 32 00 00 00 00 00 00 00 00 00 00 00 00 00 00  42..............
.  0160:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[...]

0 0x50fc8 [0x260]: PERF_RECORD_BPF_METADATA \
      prog bpf_prog_1e0a2e366e56f1a2_perf_sample_filter
  entry 0:           test_value = 42
: unhandled!

Signed-off-by: Blake Jones <blakejones@google.com>
---
 tools/perf/builtin-inject.c                  |  1 +
 tools/perf/builtin-record.c                  |  8 +++
 tools/perf/builtin-script.c                  | 15 ++++-
 tools/perf/tests/shell/test_bpf_metadata.sh  | 67 ++++++++++++++++++++
 tools/perf/util/bpf-event.c                  | 46 ++++++++++++++
 tools/perf/util/bpf-event.h                  |  1 +
 tools/perf/util/bpf_skel/sample_filter.bpf.c |  4 ++
 tools/perf/util/env.c                        | 19 +++++-
 tools/perf/util/env.h                        |  4 ++
 tools/perf/util/event.c                      | 21 ++++++
 tools/perf/util/event.h                      |  1 +
 tools/perf/util/header.c                     |  1 +
 tools/perf/util/session.c                    |  4 ++
 tools/perf/util/synthetic-events.h           |  2 +
 tools/perf/util/tool.c                       | 14 ++++
 tools/perf/util/tool.h                       |  3 +-
 16 files changed, 207 insertions(+), 4 deletions(-)
 create mode 100644 tools/perf/tests/shell/test_bpf_metadata.sh

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 11e49cafa3af..b15eac0716f7 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2530,6 +2530,7 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.finished_init	= perf_event__repipe_op2_synth;
 	inject.tool.compressed		= perf_event__repipe_op4_synth;
 	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
+	inject.tool.bpf_metadata	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
 	inject.session = __perf_session__new(&data, &inject.tool,
 					     /*trace_event_repipe=*/inject.output.is_pipe);
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 136c0172799a..067e203f57c2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2161,6 +2161,12 @@ static int record__synthesize(struct record *rec, bool tail)
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
@@ -2806,6 +2812,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
+	record__synthesize_final_bpf_metadata(rec);
+
 	if (opts->auxtrace_snapshot_on_exit)
 		record__auxtrace_snapshot_exit(rec);
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6c3bf74dd78c..4001e621b6cb 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -38,6 +38,7 @@
 #include "print_insn.h"
 #include "archinsn.h"
 #include <linux/bitmap.h>
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
@@ -50,6 +51,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <signal.h>
+#include <stdio.h>
 #include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -2755,6 +2757,14 @@ process_bpf_events(const struct perf_tool *tool __maybe_unused,
 			   sample->tid);
 }
 
+static int
+process_bpf_metadata_event(struct perf_session *session __maybe_unused,
+			   union perf_event *event)
+{
+	perf_event__fprintf(event, NULL, stdout);
+	return 0;
+}
+
 static int process_text_poke_events(const struct perf_tool *tool,
 				    union perf_event *event,
 				    struct perf_sample *sample,
@@ -2877,8 +2887,9 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.finished_round = process_finished_round_event;
 	}
 	if (script->show_bpf_events) {
-		script->tool.ksymbol = process_bpf_events;
-		script->tool.bpf     = process_bpf_events;
+		script->tool.ksymbol	  = process_bpf_events;
+		script->tool.bpf	  = process_bpf_events;
+		script->tool.bpf_metadata = process_bpf_metadata_event;
 	}
 	if (script->show_text_poke_events) {
 		script->tool.ksymbol   = process_bpf_events;
diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tests/shell/test_bpf_metadata.sh
new file mode 100644
index 000000000000..ede31d5a3c36
--- /dev/null
+++ b/tools/perf/tests/shell/test_bpf_metadata.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# BPF metadata collection test.
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+	rm -f "${perfdata}"
+	rm -f "${perfdata}".old
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_bpf_metadata() {
+	echo "Checking BPF metadata collection"
+
+	# This is a basic invocation of perf record
+	# that invokes the perf_sample_filter BPF program.
+	if ! perf record -e task-clock --filter 'ip > 0' \
+			 -o "${perfdata}" sleep 1 2> /dev/null
+	then
+		echo "Basic BPF metadata test [Failed record]"
+		err=1
+		return
+	fi
+
+	# The perf_sample_filter BPF program has the following variable in it:
+	#
+	#   volatile const int bpf_metadata_test_value SEC(".rodata") = 42;
+	#
+	# This invocation looks for a PERF_RECORD_BPF_METADATA event,
+	# and checks that its content includes something for the above variable.
+	if ! perf script --show-bpf-events -i "${perfdata}" | awk '
+		/PERF_RECORD_BPF_METADATA.*perf_sample_filter/ {
+			header = 1;
+		}
+		/^ *entry/ {
+			if (header) { header = 0; entry = 1; }
+		}
+		$0 !~ /^ *entry/ {
+			entry = 0;
+		}
+		/test_value/ {
+			if (entry) print $NF;
+		}
+	' | grep 42 > /dev/null
+	then
+		echo "Basic BPF metadata test [Failed invalid output]"
+		err=1
+		return
+	fi
+	echo "Basic BPF metadata test [Success]"
+}
+
+test_bpf_metadata
+
+cleanup
+exit $err
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 36d5676f025e..019832ec4802 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -450,6 +450,49 @@ static int synthesize_perf_record_bpf_metadata(const struct bpf_metadata *metada
 	return err;
 }
 
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
@@ -590,6 +633,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 		}
 
 		info_node->info_linear = info_linear;
+		info_node->metadata = NULL;
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
 			free(info_linear);
 			free(info_node);
@@ -781,6 +825,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	arrays |= 1UL << PERF_BPIL_JITED_INSNS;
 	arrays |= 1UL << PERF_BPIL_LINE_INFO;
 	arrays |= 1UL << PERF_BPIL_JITED_LINE_INFO;
+	arrays |= 1UL << PERF_BPIL_MAP_IDS;
 
 	info_linear = get_bpf_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
@@ -793,6 +838,7 @@ static void perf_env__add_bpf_info(struct perf_env *env, u32 id)
 	info_node = malloc(sizeof(struct bpf_prog_info_node));
 	if (info_node) {
 		info_node->info_linear = info_linear;
+		info_node->metadata = bpf_metadata_create(&info_linear->info);
 		if (!perf_env__insert_bpf_prog_info(env, info_node)) {
 			free(info_linear);
 			free(info_node);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 007f0b4d21cb..49a42c15bcc6 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -26,6 +26,7 @@ struct bpf_metadata {
 
 struct bpf_prog_info_node {
 	struct perf_bpil		*info_linear;
+	struct bpf_metadata		*metadata;
 	struct rb_node			rb_node;
 };
 
diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
index b195e6efeb8b..b0265f000325 100644
--- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
+++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
@@ -43,6 +43,10 @@ struct lost_count {
 	__uint(max_entries, 1);
 } dropped SEC(".maps");
 
+// This is used by tests/shell/record_bpf_metadata.sh
+// to verify that BPF metadata generation works.
+const int bpf_metadata_test_value SEC(".rodata") = 42;
+
 volatile const int use_idx_hash;
 
 void *bpf_cast_to_kern_ctx(void *) __ksym;
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
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 80c9ea682413..e81c2d87d76a 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1,9 +1,12 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <inttypes.h>
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <perf/cpumap.h>
+#include <perf/event.h>
+#include <stdio.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
@@ -78,6 +81,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
 	[PERF_RECORD_COMPRESSED2]		= "COMPRESSED2",
+	[PERF_RECORD_BPF_METADATA]		= "BPF_METADATA",
 };
 
 const char *perf_event__name(unsigned int id)
@@ -504,6 +508,20 @@ size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp)
 		       event->bpf.type, event->bpf.flags, event->bpf.id);
 }
 
+size_t perf_event__fprintf_bpf_metadata(union perf_event *event, FILE *fp)
+{
+	struct perf_record_bpf_metadata *metadata = &event->bpf_metadata;
+	size_t ret;
+
+	ret = fprintf(fp, " prog %s\n", metadata->prog_name);
+	for (__u32 i = 0; i < metadata->nr_entries; i++) {
+		ret += fprintf(fp, "  entry %d: %20s = %s\n", i,
+			       metadata->entries[i].key,
+			       metadata->entries[i].value);
+	}
+	return ret;
+}
+
 static int text_poke_printer(enum binary_printer_ops op, unsigned int val,
 			     void *extra, FILE *fp)
 {
@@ -601,6 +619,9 @@ size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FIL
 	case PERF_RECORD_AUX_OUTPUT_HW_ID:
 		ret += perf_event__fprintf_aux_output_hw_id(event, fp);
 		break;
+	case PERF_RECORD_BPF_METADATA:
+		ret += perf_event__fprintf_bpf_metadata(event, fp);
+		break;
 	default:
 		ret += fprintf(fp, "\n");
 	}
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 664bf39567ce..67ad4a2014bc 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -370,6 +370,7 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_bpf_metadata(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_text_poke(union perf_event *event, struct machine *machine,FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, struct machine *machine, FILE *fp);
 
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
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a320672c264e..38075059086c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -12,6 +12,7 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <perf/cpumap.h>
+#include <perf/event.h>
 
 #include "map_symbol.h"
 #include "branch.h"
@@ -1491,6 +1492,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_FINISHED_INIT:
 		err = tool->finished_init(session, event);
 		break;
+	case PERF_RECORD_BPF_METADATA:
+		err = tool->bpf_metadata(session, event);
+		break;
 	default:
 		err = -EINVAL;
 		break;
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
 
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 37bd8ac63b01..204ec03071bc 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -1,12 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "data.h"
 #include "debug.h"
+#include "event.h"
 #include "header.h"
 #include "session.h"
 #include "stat.h"
 #include "tool.h"
 #include "tsc.h"
+#include <linux/compiler.h>
 #include <sys/mman.h>
+#include <stddef.h>
 #include <unistd.h>
 
 #ifdef HAVE_ZSTD_SUPPORT
@@ -237,6 +240,16 @@ static int perf_session__process_compressed_event_stub(struct perf_session *sess
 	return 0;
 }
 
+static int perf_event__process_bpf_metadata_stub(struct perf_session *perf_session __maybe_unused,
+						 union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_bpf_metadata(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
 void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 {
 	tool->ordered_events = ordered_events;
@@ -293,6 +306,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->compressed = perf_session__process_compressed_event_stub;
 #endif
 	tool->finished_init = process_event_op2_stub;
+	tool->bpf_metadata = perf_event__process_bpf_metadata_stub;
 }
 
 bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index db1c7642b0d1..18b76ff0f26a 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -77,7 +77,8 @@ struct perf_tool {
 			stat,
 			stat_round,
 			feature,
-			finished_init;
+			finished_init,
+			bpf_metadata;
 	event_op4	compressed;
 	event_op3	auxtrace;
 	bool		ordered_events;
-- 
2.49.0.1143.g0be31eac6b-goog


