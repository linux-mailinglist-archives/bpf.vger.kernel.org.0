Return-Path: <bpf+bounces-61713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2A7AEAC3F
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 03:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF611883812
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 01:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2213C3CD;
	Fri, 27 Jun 2025 01:08:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5533FF1;
	Fri, 27 Jun 2025 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986537; cv=none; b=CaapbF4GIoOq4Uzp9BaSAlIwZcroUwZdFn2MyqQjsX8uw9SLgHOuqzq9jjxz+wzPyPevpDaX05D0E2bVrf7dXLbT6dYSBH7DRKhilhZH412ZgJ6dxO3KVZVvo0gFjqodGGeWb1nP0HGoTLGUe+9oeonZkeAMonC9EkQb4JhAY6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986537; c=relaxed/simple;
	bh=oHPYUeSh9kzOTuyf9BuaYRfYud04q8z+PPKjT187KuE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ovh+RUW8dnUGzDisZ9EH49d89KZ7UjXyAa85Z5f1Q2SCCXUs0Bif58gCyQ7QgfS+OA0chtZnGNimPEHrWUA1vHBX/YuPJh65RRl6U76Bmu/WWwtCF8OUyoH6+j66kDwYgvJptk+zBOJno+B+Gwg07ib++VgeieeCK+1j2vFe1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 923D9804BE;
	Fri, 27 Jun 2025 01:08:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 493692002A;
	Fri, 27 Jun 2025 01:08:43 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uUZLr-000000044kh-2kME;
	Wed, 25 Jun 2025 19:16:23 -0400
Message-ID: <20250625231623.509253709@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 25 Jun 2025 19:15:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org,
 x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v11 11/11] perf tools: Merge deferred user callchains
References: <20250625231541.584226205@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 493692002A
X-Stat-Signature: mwcxteq6sdksrnssuqc918u4do69cwfi
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NOJQuEfYXel9KQNSCWK3M+Ys6PD0p3KI=
X-HE-Tag: 1750986523-488827
X-HE-Meta: U2FsdGVkX1+De09pSHEswSx1Pq+z6rwdBbi0D60ghxC6AZZqRlCY/sxuV2AZpLK9FyfGsSac3RUSxvmwpwwRpCvZIf8uzmdE2w/36TRmTOUZYnVas7vbp5fY15kcvZlBaOWd+dGdzJOBmjvP4GwIlBjzEpUjPPMknzlQQNaXtty62XPPYClHtYregnYa5JrkQdn9jJaayGPy3TBBDyVnTBrCoLi9nIyTnwie7Mfpr9L/ys7RPlbNEKh0Xoi2OdFf6PWlTQBxU4xqHxHYhMSytwxJ33cPqnBaIQtF+EHm4osgULUCC4+gzw/tGYA7pMagxFYVhXUFBK+cDDIJuo6uzztYGlSE/hmbxPgP2CQA+XDY6EQtspgoVR6oRw8huSJZgvDFScgHeYqtl1VKc1fOdtnD/K3MVLKoNcATTGqZFDk=

From: Namhyung Kim <namhyung@kernel.org>

Save samples with deferred callchains in a separate list and deliver
them after merging the user callchains.  If users don't want to merge
they can set tool->merge_deferred_callchains to false to prevent the
behavior.

With previous result, now perf script will show the merged callchains.

  $ perf script
  perf     801 [000]    18.031793:          1 cycles:P:
          ffffffff91a14c36 __intel_pmu_enable_all.isra.0+0x56 ([kernel.kallsyms])
          ffffffff91d373e9 perf_ctx_enable+0x39 ([kernel.kallsyms])
          ffffffff91d36af7 event_function+0xd7 ([kernel.kallsyms])
          ffffffff91d34222 remote_function+0x42 ([kernel.kallsyms])
          ffffffff91c1ebe1 generic_exec_single+0x61 ([kernel.kallsyms])
          ffffffff91c1edac smp_call_function_single+0xec ([kernel.kallsyms])
          ffffffff91d37a9d event_function_call+0x10d ([kernel.kallsyms])
          ffffffff91d33557 perf_event_for_each_child+0x37 ([kernel.kallsyms])
          ffffffff91d47324 _perf_ioctl+0x204 ([kernel.kallsyms])
          ffffffff91d47c43 perf_ioctl+0x33 ([kernel.kallsyms])
          ffffffff91e2f216 __x64_sys_ioctl+0x96 ([kernel.kallsyms])
          ffffffff9265f1ae do_syscall_64+0x9e ([kernel.kallsyms])
          ffffffff92800130 entry_SYSCALL_64+0xb0 ([kernel.kallsyms])
              7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)
  ...

The old output can be get using --no-merge-callchain option.
Also perf report can get the user callchain entry at the end.

  $ perf report --no-children --percent-limit=0 --stdio -q -S __intel_pmu_enable_all.isra.0
  # symbol: __intel_pmu_enable_all.isra.0
       0.00%  perf     [kernel.kallsyms]
              |
              ---__intel_pmu_enable_all.isra.0
                 perf_ctx_enable
                 event_function
                 remote_function
                 generic_exec_single
                 smp_call_function_single
                 event_function_call
                 perf_event_for_each_child
                 _perf_ioctl
                 perf_ioctl
                 __x64_sys_ioctl
                 do_syscall_64
                 entry_SYSCALL_64
                 __GI___ioctl

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/perf/Documentation/perf-script.txt |  5 ++
 tools/perf/builtin-script.c              |  5 +-
 tools/perf/util/callchain.c              | 24 +++++++++
 tools/perf/util/callchain.h              |  3 ++
 tools/perf/util/evlist.c                 |  1 +
 tools/perf/util/evlist.h                 |  1 +
 tools/perf/util/session.c                | 63 +++++++++++++++++++++++-
 tools/perf/util/tool.c                   |  1 +
 tools/perf/util/tool.h                   |  1 +
 9 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 28bec7e78bc8..03d112960632 100644
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
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a6f8209256fe..b50442cca540 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3775,6 +3775,7 @@ int cmd_script(int argc, const char **argv)
 	bool header_only = false;
 	bool script_started = false;
 	bool unsorted_dump = false;
+	bool merge_deferred_callchains = true;
 	char *rec_script_path = NULL;
 	char *rep_script_path = NULL;
 	struct perf_session *session;
@@ -3928,6 +3929,8 @@ int cmd_script(int argc, const char **argv)
 		    "Guest code can be found in hypervisor process"),
 	OPT_BOOLEAN('\0', "stitch-lbr", &script.stitch_lbr,
 		    "Enable LBR callgraph stitching approach"),
+	OPT_BOOLEAN('\0', "merge-callchains", &merge_deferred_callchains,
+		    "Enable merge deferred user callchains"),
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
@@ -4183,7 +4186,7 @@ int cmd_script(int argc, const char **argv)
 	script.tool.throttle		 = process_throttle_event;
 	script.tool.unthrottle		 = process_throttle_event;
 	script.tool.ordering_requires_timestamps = true;
-	script.tool.merge_deferred_callchains = false;
+	script.tool.merge_deferred_callchains = merge_deferred_callchains;
 	session = perf_session__new(&data, &script.tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d7b7eef740b9..6d423d92861b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1828,3 +1828,27 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
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
+	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
+	if (callchain == NULL) {
+		sample_orig->deferred_callchain = false;
+		return -ENOMEM;
+	}
+
+	callchain->nr = nr_orig + nr_deferred;
+	/* copy except for the last PERF_CONTEXT_USER_DEFERRED */
+	memcpy(callchain->ips, sample_orig->callchain->ips, nr_orig * sizeof(u64));
+	/* copy deferred use callchains */
+	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
+	       nr_deferred * sizeof(u64));
+
+	sample_orig->callchain = callchain;
+	return 0;
+}
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 86ed9e4d04f9..89785125ed25 100644
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
index dcd1130502df..1d5f50f83b31 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -83,6 +83,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	evlist->ctl_fd.ack = -1;
 	evlist->ctl_fd.pos = -1;
 	evlist->nr_br_cntr = -1;
+	INIT_LIST_HEAD(&evlist->deferred_samples);
 }
 
 struct evlist *evlist__new(void)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 85859708393e..d2895c8be167 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -86,6 +86,7 @@ struct evlist {
 		int	pos;	/* index at evlist core object to check signals */
 	} ctl_fd;
 	struct event_enable_timer *eet;
+	struct list_head deferred_samples;
 };
 
 struct evsel_str_handler {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e6be01459352..21b0958e8229 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1277,6 +1277,56 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
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
+		evsel = evlist__id2evsel(evlist, orig_sample.id);
+		sample__merge_deferred_callchain(&orig_sample, sample);
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
@@ -1305,6 +1355,16 @@ static int machines__deliver_event(struct machines *machines,
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
@@ -1364,7 +1424,8 @@ static int machines__deliver_event(struct machines *machines,
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
index e1d60abb4e41..61fdba70b0a4 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -245,6 +245,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->cgroup_events = false;
 	tool->no_warn = false;
 	tool->show_feat_hdr = SHOW_FEAT_NO_HEADER;
+	tool->merge_deferred_callchains = true;
 
 	tool->sample = process_event_sample_stub;
 	tool->mmap = process_event_stub;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 9987bbde6d5e..d06580478ab1 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -87,6 +87,7 @@ struct perf_tool {
 	bool		cgroup_events;
 	bool		no_warn;
 	bool		dont_split_sample_group;
+	bool		merge_deferred_callchains;
 	enum show_feature_header show_feat_hdr;
 };
 
-- 
2.47.2



