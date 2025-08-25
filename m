Return-Path: <bpf+bounces-66426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B43AB349C7
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558561B25111
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CE430F7EB;
	Mon, 25 Aug 2025 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS8JzDIz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE6B30DECF;
	Mon, 25 Aug 2025 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145268; cv=none; b=dSmcAI/q/qpqRJSl1QuVI1JmWGjE8U0KCIE+tcPooOeeIThz+pEh4eBGdmgoCoNs7GWo+QEU2BPgIpOg4nbtid0/i3N3u03eEvDUftr6tMbKH7CAnDoq2lB2lTiwfFp3dEY2MfQ3Vk22pzRoe8Xpr4xBJBTmzmcE4cExSPNZiyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145268; c=relaxed/simple;
	bh=9Rnqq37ziyd9TsWuAFkC6MYJHfruZ8hlQguidrQFd3k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=WTXcYCSwCb7k7zzfQj7PEYS2VLkBN561cakKW0DFi+1520+JOR18C5JtjsPUHsY5V5RYhRUoRMbP5GiSVc37sZzlIUijSqQN5WPNu5cMedblZAvRBnyu2CvXV1YOek9QmtEluX3MLViyWoV2Vjm8QvQeX+VizEnQuk1ZclR5Y6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS8JzDIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A52EC16AAE;
	Mon, 25 Aug 2025 18:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145268;
	bh=9Rnqq37ziyd9TsWuAFkC6MYJHfruZ8hlQguidrQFd3k=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gS8JzDIzEdSj2aexctiE9Mq9Vy9eZ0/3isWBhmDLvan2TuHZlH/x4DnjG4pAiW6eF
	 CcNDscCeC/d9mr8WIj4glE7IRsYJFxn+Jnq00vNxaS/ZE07ncX1+w7C//GBOtKDAzg
	 ogg1cc1oyzG3l11EfQymUZ8NazRUAiyxKQ7qBLd7HY5Pgar1DK2VHIYWjCmybc9Qe0
	 yXEHWAWqg7gq7+qoaWpe4TT3DOrG7QGGMYOKklwqsxDDzg71WYzhIBBdfPkiVnUkug
	 jfsiOIGGQ+xbSjlj2kyQULzlebfhOJw+KJJEXodoY68ZgzvRU05GAXJhbrBCXTQJVt
	 CXay/8kuxwpMQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uqbbu-00000002n56-1Ybz;
	Mon, 25 Aug 2025 14:08:02 -0400
Message-ID: <20250825180802.223812079@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 25 Aug 2025 14:06:43 -0400
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
 Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: [PATCH v15 5/8] perf tools: Minimal CALLCHAIN_DEFERRED support
References: <20250825180638.877627656@kernel.org>
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

  0 24344920643 0x5fe0 [0x40]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 801/801: 0 [300000001]
  ... FP chain: nr:2
  .....  0: fffffffffffffe00
  .....  1: 00007f45253fd34b
  : unhandled!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v14: https://lore.kernel.org/20250718164324.423885737@kernel.org

- Updated to use PERF_DEFERRED_ITEMS to find PERF_CONTEXT_USER_DEFERRED

 tools/lib/perf/include/perf/event.h       |  8 ++++++++
 tools/perf/util/event.c                   |  1 +
 tools/perf/util/evsel.c                   | 18 ++++++++++++++++++
 tools/perf/util/machine.c                 |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/sample.h                  |  4 +++-
 tools/perf/util/session.c                 | 18 ++++++++++++++++++
 tools/perf/util/tool.c                    |  1 +
 tools/perf/util/tool.h                    |  3 ++-
 9 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 6608f1e3701b..4af8cb238e27 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -151,6 +151,13 @@ struct perf_record_switch {
 	__u32			 next_prev_tid;
 };
 
+struct perf_record_callchain_deferred {
+	struct perf_event_header header;
+	__u64			 cookie;
+	__u64			 nr;
+	__u64			 ips[];
+};
+
 struct perf_record_header_attr {
 	struct perf_event_header header;
 	struct perf_event_attr	 attr;
@@ -522,6 +529,7 @@ union perf_event {
 	struct perf_record_read			read;
 	struct perf_record_throttle		throttle;
 	struct perf_record_sample		sample;
+	struct perf_record_callchain_deferred	callchain_deferred;
 	struct perf_record_bpf_event		bpf;
 	struct perf_record_ksymbol		ksymbol;
 	struct perf_record_text_poke_event	text_poke;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fcf44149feb2..4c92cc1a952c 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -61,6 +61,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_CGROUP]			= "CGROUP",
 	[PERF_RECORD_TEXT_POKE]			= "TEXT_POKE",
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]		= "AUX_OUTPUT_HW_ID",
+	[PERF_RECORD_CALLCHAIN_DEFERRED]	= "CALLCHAIN_DEFERRED",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d264c143b592..7512b9fb877d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3002,6 +3002,18 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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
@@ -3132,6 +3144,12 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		if (data->callchain->nr > max_callchain_nr)
 			return -EFAULT;
 		sz = data->callchain->nr * sizeof(u64);
+		if (evsel->core.attr.defer_callchain &&
+		    data->callchain->nr >= PERF_DEFERRED_ITEMS &&
+		    data->callchain->ips[data->callchain->nr - PERF_DEFERRED_ITEMS] == PERF_CONTEXT_USER_DEFERRED) {
+			data->deferred_callchain = true;
+			data->deferred_cookie = data->callchain->ips[data->callchain->nr - 1];
+		}
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b5dd42588c91..841b711d970e 100644
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
index fae834144ef4..68392e6298b7 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -106,7 +106,9 @@ struct perf_sample {
 	u16 ins_lat;
 	/** @weight3: On x86 holds retire_lat, on powerpc holds p_stage_cyc. */
 	u16 weight3;
-	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
+	bool no_hw_idx;			/* No hw_idx collected in branch_stack */
+	bool deferred_callchain;	/* Has deferred user callchains */
+	u64 deferred_cookie;
 	char insn[MAX_INSN];
 	void *raw_data;
 	struct ip_callchain *callchain;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 26ae078278cd..a071006350f5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -720,6 +720,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_CGROUP]		  = perf_event__cgroup_swap,
 	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  = perf_event__all64_swap,
+	[PERF_RECORD_CALLCHAIN_DEFERRED]  = perf_event__all64_swap,
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
@@ -1123,6 +1124,20 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		sample_read__printf(sample, evsel->core.attr.read_format);
 }
 
+static void dump_deferred_callchain(struct evsel *evsel, union perf_event *event,
+				    struct perf_sample *sample)
+{
+	if (!dump_trace)
+		return;
+
+	printf("(IP, 0x%x): %d/%d: %#" PRIx64 " [%llx]\n",
+	       event->header.misc, sample->pid, sample->tid, sample->ip,
+		event->callchain_deferred.cookie);
+
+	if (evsel__has_callchain(evsel))
+		callchain__printf(evsel, sample);
+}
+
 static void dump_read(struct evsel *evsel, union perf_event *event)
 {
 	struct perf_record_read *read_event = &event->read;
@@ -1353,6 +1368,9 @@ static int machines__deliver_event(struct machines *machines,
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
index e83c7ababc2a..8bf86af1ca90 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -279,6 +279,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->read = process_event_sample_stub;
 	tool->throttle = process_event_stub;
 	tool->unthrottle = process_event_stub;
+	tool->callchain_deferred = process_event_sample_stub;
 	tool->attr = process_event_synth_attr_stub;
 	tool->event_update = process_event_synth_event_update_stub;
 	tool->tracing_data = process_event_synth_tracing_data_stub;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 18b76ff0f26a..2676d84da80c 100644
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
2.50.1



