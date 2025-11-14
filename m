Return-Path: <bpf+bounces-74461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF57C5BA87
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 08:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830123A21E0
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769182F7ADF;
	Fri, 14 Nov 2025 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfkXNr2E"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D674C2F6598;
	Fri, 14 Nov 2025 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103625; cv=none; b=CZOaDNAoD0gD7hVJ7bYKGsOmxAG1dIXi1Eifp6gi6sH5Tplipci7KcejAQDlYk+lkxakiBi3gR3SRLnukFgR3PyKDhGKxF3ryBx8MUrPk3Py129XfdOXaIbj3IWIL1pZCova76aeHSWedYE3xxffgzB6bQLPZ9P4JNQ86XKSNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103625; c=relaxed/simple;
	bh=6Ocyy7HnJakMrtl0AhViXS4uUU1oNUj31kAZJUoFfo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdAV634D6i41K5Haw2Ssfo0og28SaDCdSZxRnGuWRd6QG7h4+W7pFjTw9TZ8G3y8n/98Zn/hWiXG123mfAedXcne9zUckVP58AdsfDsamVo4A4ota6c74xS7I9ui2j/NshOkdqPDzJeKwLTKsZvT1o+zVsvW+s9OmptD87VOljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfkXNr2E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A861DC2BC9E;
	Fri, 14 Nov 2025 07:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763103624;
	bh=6Ocyy7HnJakMrtl0AhViXS4uUU1oNUj31kAZJUoFfo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfkXNr2E1XUXu9gpdRBaRh20AqFYrdKc7C9mHW6qg0koE82zZC5k+dfPNKrOR6C8u
	 qxKcuswvXhRRNNPf/9k03oD49SQe5aKlMcDd9HattXwfGxl0+szjF84rC7HrFPEzP5
	 iDLCB5hjh9mxXgU2BFFT3lkkGqBiWvpUZK/1aWoySSklkdDQYUhuGZBl+Ulgosl494
	 sJUU8u6/cVLJlaGjZyytQALburMY3RmhbAbO6F5EtiIDh6+4IzQTvi0tRJ1OZucFjm
	 vWtsXmSG8ER51tUky1VvFRZavIojLkWCMI5B+2XuCOfW52hXEyWOuW1LXJuocWAtPJ
	 cHgXURFfmYJSw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 5/5] perf tools: Merge deferred user callchains
Date: Thu, 13 Nov 2025 23:00:18 -0800
Message-ID: <20251114070018.160330-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251114070018.160330-1-namhyung@kernel.org>
References: <20251114070018.160330-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save samples with deferred callchains in a separate list and deliver
them after merging the user callchains.  If users don't want to merge
they can set tool->merge_deferred_callchains to false to prevent the
behavior.

With previous result, now perf script will show the merged callchains.

  $ perf script
  ...
  pwd    2312   121.163435:     249113 cpu/cycles/P:
          ffffffff845b78d8 __build_id_parse.isra.0+0x218 ([kernel.kallsyms])
          ffffffff83bb5bf6 perf_event_mmap+0x2e6 ([kernel.kallsyms])
          ffffffff83c31959 mprotect_fixup+0x1e9 ([kernel.kallsyms])
          ffffffff83c31dc5 do_mprotect_pkey+0x2b5 ([kernel.kallsyms])
          ffffffff83c3206f __x64_sys_mprotect+0x1f ([kernel.kallsyms])
          ffffffff845e6692 do_syscall_64+0x62 ([kernel.kallsyms])
          ffffffff8360012f entry_SYSCALL_64_after_hwframe+0x76 ([kernel.kallsyms])
              7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
  ...

The old output can be get using --no-merge-callchain option.
Also perf report can get the user callchain entry at the end.

  $ perf report --no-children --stdio -q -S __build_id_parse.isra.0
  # symbol: __build_id_parse.isra.0
       8.40%  pwd      [kernel.kallsyms]
              |
              ---__build_id_parse.isra.0
                 perf_event_mmap
                 mprotect_fixup
                 do_mprotect_pkey
                 __x64_sys_mprotect
                 do_syscall_64
                 entry_SYSCALL_64_after_hwframe
                 mprotect
                 _dl_sysdep_start
                 _dl_start_user

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  5 ++
 tools/perf/builtin-inject.c              |  1 +
 tools/perf/builtin-report.c              |  1 +
 tools/perf/builtin-script.c              |  5 +-
 tools/perf/util/callchain.c              | 29 ++++++++++
 tools/perf/util/callchain.h              |  3 ++
 tools/perf/util/evlist.c                 |  1 +
 tools/perf/util/evlist.h                 |  2 +
 tools/perf/util/session.c                | 67 +++++++++++++++++++++++-
 tools/perf/util/tool.c                   |  1 +
 tools/perf/util/tool.h                   |  1 +
 11 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 28bec7e78bc858ba..03d1129606328d6d 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -527,6 +527,11 @@ include::itrace.txt[]
 	The known limitations include exception handing such as
 	setjmp/longjmp will have calls/returns not match.
 
+--merge-callchains::
+	Enable merging deferred user callchains if available.  This is the
+	default behavior.  If you want to see separate CALLCHAIN_DEFERRED
+	records for some reason, use --no-merge-callchains explicitly.
+
 :GMEXAMPLECMD: script
 :GMEXAMPLESUBCMD:
 include::guest-files.txt[]
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 044074080aa53abd..30ae38212f57580a 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2542,6 +2542,7 @@ int cmd_inject(int argc, const char **argv)
 	inject.tool.auxtrace		= perf_event__repipe_auxtrace;
 	inject.tool.bpf_metadata	= perf_event__repipe_op2_synth;
 	inject.tool.dont_split_sample_group = true;
+	inject.tool.merge_deferred_callchains = false;
 	inject.session = __perf_session__new(&data, &inject.tool,
 					     /*trace_event_repipe=*/inject.output.is_pipe,
 					     /*host_env=*/NULL);
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2bc269f5fcef8023..add6b1c2aaf04270 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1614,6 +1614,7 @@ int cmd_report(int argc, const char **argv)
 	report.tool.event_update	 = perf_event__process_event_update;
 	report.tool.feature		 = process_feature_event;
 	report.tool.ordering_requires_timestamps = true;
+	report.tool.merge_deferred_callchains = !dump_trace;
 
 	session = perf_session__new(&data, &report.tool);
 	if (IS_ERR(session)) {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3b2896350bad2924..2374c7a1684028cc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4025,6 +4025,7 @@ int cmd_script(int argc, const char **argv)
 	bool header_only = false;
 	bool script_started = false;
 	bool unsorted_dump = false;
+	bool merge_deferred_callchains = true;
 	char *rec_script_path = NULL;
 	char *rep_script_path = NULL;
 	struct perf_session *session;
@@ -4178,6 +4179,8 @@ int cmd_script(int argc, const char **argv)
 		    "Guest code can be found in hypervisor process"),
 	OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
 		    "Enable LBR callgraph stitching approach"),
+	OPT_BOOLEAN('\0', "merge-callchains", &merge_deferred_callchains,
+		    "Enable merge deferred user callchains"),
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
@@ -4434,7 +4437,7 @@ int cmd_script(int argc, const char **argv)
 	script.tool.throttle		 = process_throttle_event;
 	script.tool.unthrottle		 = process_throttle_event;
 	script.tool.ordering_requires_timestamps = true;
-	script.tool.merge_deferred_callchains = false;
+	script.tool.merge_deferred_callchains = merge_deferred_callchains;
 	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d7b7eef740b9d6ed..a0a0e6784420d478 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1828,3 +1828,32 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
 	}
 	return 0;
 }
+
+int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
+				     struct perf_sample *sample_callchain)
+{
+	u64 nr_orig = sample_orig->callchain->nr - 1;
+	u64 nr_deferred = sample_callchain->callchain->nr;
+	struct ip_callchain *callchain;
+
+	if (sample_orig->callchain->nr < 2) {
+		sample_orig->deferred_callchain = false;
+		return -EINVAL;
+	}
+
+	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
+	if (callchain == NULL) {
+		sample_orig->deferred_callchain = false;
+		return -ENOMEM;
+	}
+
+	callchain->nr = nr_orig + nr_deferred;
+	/* copy original including PERF_CONTEXT_USER_DEFERRED (but the cookie) */
+	memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * sizeof(u64));
+	/* copy deferred user callchains */
+	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
+	       nr_deferred * sizeof(u64));
+
+	sample_orig->callchain = callchain;
+	return 0;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 86ed9e4d04f9ee7b..89785125ed25783d 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -317,4 +317,7 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
 				    struct perf_sample *sample, int max_stack,
 				    bool symbols, callchain_iter_fn cb, void *data);
 
+int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
+				     struct perf_sample *sample_callchain);
+
 #endif	/* __PERF_CALLCHAIN_H */
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e8217efdda5323c6..03674d2cbd015e4f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -85,6 +85,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	evlist->ctl_fd.pos = -1;
 	evlist->nr_br_cntr = -1;
 	metricgroup__rblist_init(&evlist->metric_events);
+	INIT_LIST_HEAD(&evlist->deferred_samples);
 }
 
 struct evlist *evlist__new(void)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 5e71e3dc60423079..911834ae7c2a6f76 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -92,6 +92,8 @@ struct evlist {
 	 * of struct metric_expr.
 	 */
 	struct rblist	metric_events;
+	/* samples with deferred_callchain would wait here. */
+	struct list_head deferred_samples;
 };
 
 struct evsel_str_handler {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 361e15c1f26a96d0..2e777fd1bcf6707b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1285,6 +1285,60 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
 					    per_thread);
 }
 
+struct deferred_event {
+	struct list_head list;
+	union perf_event *event;
+};
+
+static int evlist__deliver_deferred_samples(struct evlist *evlist,
+					    const struct perf_tool *tool,
+					    union  perf_event *event,
+					    struct perf_sample *sample,
+					    struct machine *machine)
+{
+	struct deferred_event *de, *tmp;
+	struct evsel *evsel;
+	int ret = 0;
+
+	if (!tool->merge_deferred_callchains) {
+		evsel = evlist__id2evsel(evlist, sample->id);
+		return tool->callchain_deferred(tool, event, sample,
+						evsel, machine);
+	}
+
+	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
+		struct perf_sample orig_sample;
+
+		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
+		if (ret < 0) {
+			pr_err("failed to parse original sample\n");
+			break;
+		}
+
+		if (sample->tid != orig_sample.tid)
+			continue;
+
+		if (event->callchain_deferred.cookie == orig_sample.deferred_cookie)
+			sample__merge_deferred_callchain(&orig_sample, sample);
+		else
+			orig_sample.deferred_callchain = false;
+
+		evsel = evlist__id2evsel(evlist, orig_sample.id);
+		ret = evlist__deliver_sample(evlist, tool, de->event,
+					     &orig_sample, evsel, machine);
+
+		if (orig_sample.deferred_callchain)
+			free(orig_sample.callchain);
+
+		list_del(&de->list);
+		free(de);
+
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 static int machines__deliver_event(struct machines *machines,
 				   struct evlist *evlist,
 				   union perf_event *event,
@@ -1313,6 +1367,16 @@ static int machines__deliver_event(struct machines *machines,
 			return 0;
 		}
 		dump_sample(evsel, event, sample, perf_env__arch(machine->env));
+		if (sample->deferred_callchain && tool->merge_deferred_callchains) {
+			struct deferred_event *de = malloc(sizeof(*de));
+
+			if (de == NULL)
+				return -ENOMEM;
+
+			de->event = event;
+			list_add_tail(&de->list, &evlist->deferred_samples);
+			return 0;
+		}
 		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
 	case PERF_RECORD_MMAP:
 		return tool->mmap(tool, event, sample, machine);
@@ -1372,7 +1436,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->aux_output_hw_id(tool, event, sample, machine);
 	case PERF_RECORD_CALLCHAIN_DEFERRED:
 		dump_deferred_callchain(evsel, event, sample);
-		return tool->callchain_deferred(tool, event, sample, evsel, machine);
+		return evlist__deliver_deferred_samples(evlist, tool, event,
+							sample, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index f732d33e7f895ed4..c5d3b464b2a433b3 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -266,6 +266,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->cgroup_events = false;
 	tool->no_warn = false;
 	tool->show_feat_hdr = SHOW_FEAT_NO_HEADER;
+	tool->merge_deferred_callchains = true;
 
 	tool->sample = process_event_sample_stub;
 	tool->mmap = process_event_stub;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 9b9f0a8cbf3de4b5..e96b69d25a5b737d 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -90,6 +90,7 @@ struct perf_tool {
 	bool		cgroup_events;
 	bool		no_warn;
 	bool		dont_split_sample_group;
+	bool		merge_deferred_callchains;
 	enum show_feature_header show_feat_hdr;
 };
 
-- 
2.52.0.rc1.455.g30608eb744-goog


