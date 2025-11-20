Return-Path: <bpf+bounces-75128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72115C71CB7
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 03:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F3004E4FBB
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD92C3749;
	Thu, 20 Nov 2025 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBSM4cEs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092F29293D;
	Thu, 20 Nov 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604654; cv=none; b=do/CwuCuDGKeEmy+s2ANXmN1ONzQpGQXkKlo+IARA/SGXAroGHzvNLtbvhFWq48IGiqAd2W9sgA8alPZ2ydTpzfZqf+1HEbYtWoE19CxE5OWTv1Ia5v6inlPYXsizSeuiByN2kxgoB5dKuKCBbPKh97lt7PHV7ehrF43zBWRLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604654; c=relaxed/simple;
	bh=E73NOe4LZ+33guscLt6L44CEIfeZ245gK9vbsf2ieQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/WSzzyTiSQi8EjuvxwCg2v5q2nwqExSDEJMWFJrAaRzJkmg3lzKDGf7YeOCSFydWUQN4ARM09hmifRfnP2WU020JjFUSfwke7/G8yCAUJUB6e91Ffep+C1BJ3ajHeGX7gKoYkHu38Lh809fynU2HryAHiwQqI64YXHiyR1/qhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBSM4cEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3157C19421;
	Thu, 20 Nov 2025 02:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604653;
	bh=E73NOe4LZ+33guscLt6L44CEIfeZ245gK9vbsf2ieQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBSM4cEs2wSRq9QLgPEG0IkFo9rQHbTfKtspzDnP16RnKBnfD3yPq1Nw4A8D1SFXo
	 8DjTNTBavDMxRzo+Ds0OyK02CRUZDEaX7ZNuXGIhst8fJkQhmxG8djta9YwGEQ4yv5
	 HVhVywhKRIvgIUWboKhRCan7MA9MLlYhjBX1lHvjT9Tg3xWJQLtC5uiVWy7toSPcEL
	 k47ciZAbxTmgkehw/81Q84mJRUIM4sqn1CLEahOzQCCEGTmcdXnhvHGnAJdf/IBxVa
	 mVgAJSuabo6TaJCVWZwwdp++X431F9qp2xLpksMNT/tjPo8VDttRnOcMK5Fs8wIUCE
	 UFP+sP8FvMhtQ==
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
Subject: [PATCH v5 2/6] perf tools: Minimal DEFERRED_CALLCHAIN support
Date: Wed, 19 Nov 2025 18:10:42 -0800
Message-ID: <20251120021046.94490-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251120021046.94490-1-namhyung@kernel.org>
References: <20251120021046.94490-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new event type for deferred callchains and a new callback for the
struct perf_tool.  For now it doesn't actually handle the deferred
callchains but it just marks the sample if it has the PERF_CONTEXT_
USER_DEFFERED in the callchain array.

At least, perf report can dump the raw data with this change.  Actually
this requires the next commit to enable attr.defer_callchain, but if you
already have a data file, it'll show the following result.

  $ perf report -D
  ...
  0x2158@perf.data [0x40]: event: 22
  .
  . ... raw event: size 64 bytes
  .  0000:  16 00 00 00 02 00 40 00 06 00 00 00 0b 00 00 00  ......@.........
  .  0010:  03 00 00 00 00 00 00 00 a7 7f 33 fe 18 7f 00 00  ..........3.....
  .  0020:  0f 0e 33 fe 18 7f 00 00 48 14 33 fe 18 7f 00 00  ..3.....H.3.....
  .  0030:  08 09 00 00 08 09 00 00 e6 7a e7 35 1c 00 00 00  .........z.5....

  121163447014 0x2158 [0x40]: PERF_RECORD_CALLCHAIN_DEFERRED(IP, 0x2): 2312/2312: 0xb00000006
  ... FP chain: nr:3
  .....  0: 00007f18fe337fa7
  .....  1: 00007f18fe330e0f
  .....  2: 00007f18fe331448
  : unhandled!

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/include/perf/event.h       | 13 ++++++++++
 tools/perf/util/event.c                   |  1 +
 tools/perf/util/evsel.c                   | 31 +++++++++++++++++++++--
 tools/perf/util/machine.c                 |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  2 ++
 tools/perf/util/sample.h                  |  2 ++
 tools/perf/util/session.c                 | 20 +++++++++++++++
 tools/perf/util/tool.c                    |  3 +++
 tools/perf/util/tool.h                    |  3 ++-
 9 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index aa1e91c97a226e1a..43a8cb04994fa033 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -151,6 +151,18 @@ struct perf_record_switch {
 	__u32			 next_prev_tid;
 };
 
+struct perf_record_callchain_deferred {
+	struct perf_event_header header;
+	/*
+	 * This is to match kernel and (deferred) user stacks together.
+	 * The kernel part will be in the sample callchain array after
+	 * the PERF_CONTEXT_USER_DEFERRED entry.
+	 */
+	__u64			 cookie;
+	__u64			 nr;
+	__u64			 ips[];
+};
+
 struct perf_record_header_attr {
 	struct perf_event_header header;
 	struct perf_event_attr	 attr;
@@ -523,6 +535,7 @@ union perf_event {
 	struct perf_record_read			read;
 	struct perf_record_throttle		throttle;
 	struct perf_record_sample		sample;
+	struct perf_record_callchain_deferred	callchain_deferred;
 	struct perf_record_bpf_event		bpf;
 	struct perf_record_ksymbol		ksymbol;
 	struct perf_record_text_poke_event	text_poke;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fcf44149feb20c35..4c92cc1a952c1d9f 100644
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
index 989c56d4a23f74f4..5ee3e7dee93fbbcb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3089,6 +3089,20 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	data->data_src = PERF_MEM_DATA_SRC_NONE;
 	data->vcpu = -1;
 
+	if (event->header.type == PERF_RECORD_CALLCHAIN_DEFERRED) {
+		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
+
+		data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
+		if (data->callchain->nr > max_callchain_nr)
+			return -EFAULT;
+
+		data->deferred_cookie = event->callchain_deferred.cookie;
+
+		if (evsel->core.attr.sample_id_all)
+			perf_evsel__parse_id_sample(evsel, event, data);
+		return 0;
+	}
+
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		if (!evsel->core.attr.sample_id_all)
 			return 0;
@@ -3213,12 +3227,25 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 	if (type & PERF_SAMPLE_CALLCHAIN) {
 		const u64 max_callchain_nr = UINT64_MAX / sizeof(u64);
+		u64 callchain_nr;
 
 		OVERFLOW_CHECK_u64(array);
 		data->callchain = (struct ip_callchain *)array++;
-		if (data->callchain->nr > max_callchain_nr)
+		callchain_nr = data->callchain->nr;
+		if (callchain_nr > max_callchain_nr)
 			return -EFAULT;
-		sz = data->callchain->nr * sizeof(u64);
+		sz = callchain_nr * sizeof(u64);
+		/*
+		 * Save the cookie for the deferred user callchain.  The last 2
+		 * entries in the callchain should be the context marker and the
+		 * cookie.  The cookie will be used to match PERF_RECORD_
+		 * CALLCHAIN_DEFERRED later.
+		 */
+		if (evsel->core.attr.defer_callchain && callchain_nr >= 2 &&
+		    data->callchain->ips[callchain_nr - 2] == PERF_CONTEXT_USER_DEFERRED) {
+			data->deferred_cookie = data->callchain->ips[callchain_nr - 1];
+			data->deferred_callchain = true;
+		}
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
 	}
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b5dd42588c916d91..841b711d970e9457 100644
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
index 66b666d9ce649dd7..741c3d657a8b6ae7 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -343,6 +343,8 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(inherit_thread, p_unsigned);
 	PRINT_ATTRf(remove_on_exec, p_unsigned);
 	PRINT_ATTRf(sigtrap, p_unsigned);
+	PRINT_ATTRf(defer_callchain, p_unsigned);
+	PRINT_ATTRf(defer_output, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned, false);
 	PRINT_ATTRf(bp_type, p_unsigned);
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index fae834144ef42105..a8307b20a9ea8066 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -107,6 +107,8 @@ struct perf_sample {
 	/** @weight3: On x86 holds retire_lat, on powerpc holds p_stage_cyc. */
 	u16 weight3;
 	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
+	bool deferred_callchain;	/* Has deferred user callchains */
+	u64 deferred_cookie;
 	char insn[MAX_INSN];
 	void *raw_data;
 	struct ip_callchain *callchain;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4b0236b2df2913e1..361e15c1f26a96d0 100644
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
@@ -854,6 +855,9 @@ static void callchain__printf(struct evsel *evsel,
 	for (i = 0; i < callchain->nr; i++)
 		printf("..... %2d: %016" PRIx64 "\n",
 		       i, callchain->ips[i]);
+
+	if (sample->deferred_callchain)
+		printf("...... (deferred)\n");
 }
 
 static void branch_stack__printf(struct perf_sample *sample,
@@ -1123,6 +1127,19 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		sample_read__printf(sample, evsel->core.attr.read_format);
 }
 
+static void dump_deferred_callchain(struct evsel *evsel, union perf_event *event,
+				    struct perf_sample *sample)
+{
+	if (!dump_trace)
+		return;
+
+	printf("(IP, 0x%x): %d/%d: %#" PRIx64 "\n",
+	       event->header.misc, sample->pid, sample->tid, sample->deferred_cookie);
+
+	if (evsel__has_callchain(evsel))
+		callchain__printf(evsel, sample);
+}
+
 static void dump_read(struct evsel *evsel, union perf_event *event)
 {
 	struct perf_record_read *read_event = &event->read;
@@ -1353,6 +1370,9 @@ static int machines__deliver_event(struct machines *machines,
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
index 22a8a4ffe05f778e..e77f0e2ecc1f79db 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -287,6 +287,7 @@ void perf_tool__init(struct perf_tool *tool, bool ordered_events)
 	tool->read = process_event_sample_stub;
 	tool->throttle = process_event_stub;
 	tool->unthrottle = process_event_stub;
+	tool->callchain_deferred = process_event_sample_stub;
 	tool->attr = process_event_synth_attr_stub;
 	tool->event_update = process_event_synth_event_update_stub;
 	tool->tracing_data = process_event_synth_tracing_data_stub;
@@ -335,6 +336,7 @@ bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
 	}
 CREATE_DELEGATE_SAMPLE(read);
 CREATE_DELEGATE_SAMPLE(sample);
+CREATE_DELEGATE_SAMPLE(callchain_deferred);
 
 #define CREATE_DELEGATE_ATTR(name)					\
 	static int delegate_ ## name(const struct perf_tool *tool,	\
@@ -468,6 +470,7 @@ void delegate_tool__init(struct delegate_tool *tool, struct perf_tool *delegate)
 	tool->tool.ksymbol = delegate_ksymbol;
 	tool->tool.bpf = delegate_bpf;
 	tool->tool.text_poke = delegate_text_poke;
+	tool->tool.callchain_deferred = delegate_callchain_deferred;
 
 	tool->tool.attr = delegate_attr;
 	tool->tool.event_update = delegate_event_update;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 88337cee1e3e2be3..9b9f0a8cbf3de4b5 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -44,7 +44,8 @@ enum show_feature_header {
 
 struct perf_tool {
 	event_sample	sample,
-			read;
+			read,
+			callchain_deferred;
 	event_op	mmap,
 			mmap2,
 			comm,
-- 
2.52.0.rc1.455.g30608eb744-goog


