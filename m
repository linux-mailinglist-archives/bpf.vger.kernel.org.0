Return-Path: <bpf+bounces-62612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25FDAFC059
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8323A6534
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43C226CF6;
	Tue,  8 Jul 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trcFkIiv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56A21FF51;
	Tue,  8 Jul 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940051; cv=none; b=CnAKZBLDJJZDou5tY4lECpF08ZwVoEP2CNdckbKX0E4sXoPPQG63WE+jLH4hVjin5BrtG3q9V6miuVQkb/uTLY9I/0ycrZhm+9EQ7eqR2WUhhA0q5qmA5BpO8E1/vJ70//5OVr/jV+OBeNycRWr6y8Nqk4n54xXcpPIEHok42rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940051; c=relaxed/simple;
	bh=Ut+iVTIHMBQnU1pbZZ59ZgZri4xhPXiNg+APs2M5CUE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ETVcOPe2S0lGkXwphePaolQLSNeRNYE4j2R9XmYJhxfvfj3E2A5lQil7FiWNJ841H0wxDYSFtK3EGq+HZMEUxr5oa68T0K5kOhzp0+T8IyQMq6OXoxem3YEmLaxnGBBjNKgTzF0DEAZMfKVniFkQnFqKwhkpUu5FmqH9UqmLjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trcFkIiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E390C4CEF5;
	Tue,  8 Jul 2025 02:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940051;
	bh=Ut+iVTIHMBQnU1pbZZ59ZgZri4xhPXiNg+APs2M5CUE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=trcFkIivYkEOYCrMPZnjtjhFKgSFULauApQ+kzZTuIBCehw65RSYX00+AhyiG2g6C
	 gZnacEd3BpxfLpv+OL3zgklDEVqc9R2lt6SSGxu/3ndi3ySNJhDvW0T+l/fj2rZirK
	 DCGIODNE207qrm9r6FxwmPgufGCcLPNmQq8aOmDbLV4RMQg8WqKEEsFEEQ8pYuVcWn
	 kD9vF5MLN6xBzpyiqxHIpvtVci/eTru4+UlnGlQFEm3kRIyTEOPNgzRiAzdBijaP0e
	 7JEqxDzAA+qzP9AtkWHJUN/qFSsYDWQp36I919vBVnGki0sioLRoxJxOHAAhGn3xSA
	 o6yzf/sVnokwg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxdb-00000000D7c-1kwX;
	Mon, 07 Jul 2025 22:00:51 -0400
Message-ID: <20250708020051.268700027@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:00:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
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
 Jens Axboe <axboe@kernel.dk>,
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>
Subject: [PATCH v13 08/11] perf tools: Minimal CALLCHAIN_DEFERRED support
References: <20250708020003.565862284@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Namhyung Kim <namhyung@kernel.org>

Add a new event type for deferred callchains and a new callback for the
struct perf_tool.  For now it doesn't actually handle the deferred
callchains but it just marks the sample if it has the PERF_CONTEXT_
USER_DEFFERED in the callchain array.

At least, perf report can dump the raw data with this change.  Actually
this requires the next commit to enable attr.defer_callchain, but if you
already have a data file, it'll show the following result.

  $ perf report -D
  ...
  0x5fe0@perf.data [0x40]: event: 22
  .
  . ... raw event: size 64 bytes
  .  0000:  16 00 00 00 02 00 40 00 02 00 00 00 00 00 00 00  ......@.........
  .  0010:  00 fe ff ff ff ff ff ff 4b d3 3f 25 45 7f 00 00  ........K.?%E...
  .  0020:  21 03 00 00 21 03 00 00 43 02 12 ab 05 00 00 00  !...!...C.......
  .  0030:  00 00 00 00 00 00 00 00 09 00 00 00 00 00 00 00  ................

  0 24344920643 0x5fe0 [0x40]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 801/801: 0
  ... FP chain: nr:2
  .....  0: fffffffffffffe00
  .....  1: 00007f45253fd34b
  : unhandled!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/lib/perf/include/perf/event.h       |  7 +++++++
 tools/perf/util/event.c                   |  1 +
 tools/perf/util/evsel.c                   | 15 +++++++++++++++
 tools/perf/util/machine.c                 |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/sample.h                  |  3 ++-
 tools/perf/util/session.c                 | 17 +++++++++++++++++
 tools/perf/util/tool.c                    |  1 +
 tools/perf/util/tool.h                    |  3 ++-
 9 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 09b7c643ddac..4590d62ca913 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -151,6 +151,12 @@ struct perf_record_switch {
 	__u32			 next_prev_tid;
 };
 
+struct perf_record_callchain_deferred {
+	struct perf_event_header header;
+	__u64			 nr;
+	__u64			 ips[];
+};
+
 struct perf_record_header_attr {
 	struct perf_event_header header;
 	struct perf_event_attr	 attr;
@@ -505,6 +511,7 @@ union perf_event {
 	struct perf_record_read			read;
 	struct perf_record_throttle		throttle;
 	struct perf_record_sample		sample;
+	struct perf_record_callchain_deferred	callchain_deferred;
 	struct perf_record_bpf_event		bpf;
 	struct perf_record_ksymbol		ksymbol;
 	struct perf_record_text_poke_event	text_poke;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 7544a3104e21..720682fea9be 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -58,6 +58,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_CGROUP]			= "CGROUP",
 	[PERF_RECORD_TEXT_POKE]			= "TEXT_POKE",
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]		= "AUX_OUTPUT_HW_ID",
+	[PERF_RECORD_CALLCHAIN_DEFERRED]	= "CALLCHAIN_DEFERRED",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d55482f094bf..6176c31b57ea 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2978,6 +2978,18 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 	data->vcpu = -1;
 
+	if (event->header.type == PERF_RECORD_CALLCHAIN_DEFERRED) {
+		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
+
+		data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
+		if (data->callchain->nr > max_callchain_nr)
+			return -EFAULT;
+
+		if (evsel->core.attr.sample_id_all)
+			perf_evsel__parse_id_sample(evsel, event, data);
+		return 0;
+	}
+
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		if (!evsel->core.attr.sample_id_all)
 			return 0;
@@ -3108,6 +3120,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		if (data->callchain->nr > max_callchain_nr)
 			return -EFAULT;
 		sz = data->callchain->nr * sizeof(u64);
+		if (evsel->core.attr.defer_callchain && data->callchain->nr >= 1 &&
+		    data->callchain->ips[data->callchain->nr - 1] == PERF_CONTEXT_USER_DEFERRED)
+			data->deferred_callchain = true;
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7ec12c207970..de6100366eee 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2124,6 +2124,7 @@ static int add_callchain_ip(struct thread *thread,
 				*cpumode = PERF_RECORD_MISC_KERNEL;
 				break;
 			case PERF_CONTEXT_USER:
+			case PERF_CONTEXT_USER_DEFERRED:
 				*cpumode = PERF_RECORD_MISC_USER;
 				break;
 			default:
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 66b666d9ce64..abfd9b9a718c 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -343,6 +343,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(inherit_thread, p_unsigned);
 	PRINT_ATTRf(remove_on_exec, p_unsigned);
 	PRINT_ATTRf(sigtrap, p_unsigned);
+	PRINT_ATTRf(defer_callchain, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned, false);
 	PRINT_ATTRf(bp_type, p_unsigned);
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 0e96240052e9..9d6e2f14551c 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -108,7 +108,8 @@ struct perf_sample {
 		u16 p_stage_cyc;
 		u16 retire_lat;
 	};
-	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
+	bool no_hw_idx;			/* No hw_idx collected in branch_stack */
+	bool deferred_callchain;	/* Has deferred user callchains */
 	char insn[MAX_INSN];
 	void *raw_data;
 	struct ip_callchain *callchain;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a320672c264e..e6be01459352 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -715,6 +715,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_CGROUP]		  = perf_event__cgroup_swap,
 	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  = perf_event__all64_swap,
+	[PERF_RECORD_CALLCHAIN_DEFERRED]  = perf_event__all64_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
@@ -1118,6 +1119,19 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		sample_read__printf(sample, evsel->core.attr.read_format);
 }
 
+static void dump_deferred_callchain(struct evsel *evsel, union perf_event *event,
+				    struct perf_sample *sample)
+{
+	if (!dump_trace)
+		return;
+
+	printf("(IP, 0x%x): %d/%d: %#" PRIx64 "\n",
+	       event->header.misc, sample->pid, sample->tid, sample->ip);
+
+	if (evsel__has_callchain(evsel))
+		callchain__printf(evsel, sample);
+}
+
 static void dump_read(struct evsel *evsel, union perf_event *event)
 {
 	struct perf_record_read *read_event = &event->read;
@@ -1348,6 +1362,9 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->text_poke(tool, event, sample, machine);
 	case PERF_RECORD_AUX_OUTPUT_HW_ID:
 		return tool->aux_output_hw_id(tool, event, sample, machine);
+	case PERF_RECORD_CALLCHAIN_DEFERRED:
+		dump_deferred_callchain(evsel, event, sample);
+		return tool->callchain_deferred(tool, event, sample, evsel, machine);
 	default:
 		++evlist->stats.nr_unknown_events;
 		return -1;
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 37bd8ac63b01..e1d60abb4e41 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -266,6 +266,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->read = process_event_sample_stub;
 	tool->throttle = process_event_stub;
 	tool->unthrottle = process_event_stub;
+	tool->callchain_deferred = process_event_sample_stub;
 	tool->attr = process_event_synth_attr_stub;
 	tool->event_update = process_event_synth_event_update_stub;
 	tool->tracing_data = process_event_synth_tracing_data_stub;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index db1c7642b0d1..9987bbde6d5e 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -42,7 +42,8 @@ enum show_feature_header {
 
 struct perf_tool {
 	event_sample	sample,
-			read;
+			read,
+			callchain_deferred;
 	event_op	mmap,
 			mmap2,
 			comm,
-- 
2.47.2



