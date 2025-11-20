Return-Path: <bpf+bounces-75209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 669ACC76A97
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 00:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC4DC347D8B
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474AC31ED70;
	Thu, 20 Nov 2025 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqHoGseE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E831BC82;
	Thu, 20 Nov 2025 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682498; cv=none; b=EB1t+L+vsTMpl+Ir8+RxBp9qD1CDo5u6rddlsUi7mQEynxzep1rL/tUgVcEoRPxRxDS1JOjk3+cWUwpDgt+wJCqpGyImFHPU665nWzEH9AJnO4Em9JdmqLWjB4dfsE0Ma+BsVyz/DE/lCdnFYHI9MjRBi7sNH56FRfPe5oRtrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682498; c=relaxed/simple;
	bh=QMamA0NlFUaDlTU9/ZeJqqbfrtRkRhvOhwEeWlYNw3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjMw+UoUZNdc+/XI2VMhDc7D3uj/O3Kmxg7H7vkM/DZA+Y/UfmtreHG3qRZGGLnOigE8Vig1x4QLLTjtCkAnIFlVxa2OVlhlaXullCN3znufNVpiQa7guteznS+UBmF98kuCzcGq1zQ9k1Eq5+nH88rbOKSAip38oMjFRXIls4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqHoGseE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1395C116C6;
	Thu, 20 Nov 2025 23:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763682498;
	bh=QMamA0NlFUaDlTU9/ZeJqqbfrtRkRhvOhwEeWlYNw3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqHoGseEH4Ro4SA8zEx/DczzViuX0e5Hkz4T5htEqWEq/gSO/6p3YFNaH/tsU4IWm
	 KgyNjChven9u7W0Z/Su5AJPVy1PTQF9zX5NpSFQDuUxNEYfJZq5vmTiNUiNjag0eDQ
	 BUO8KP01GDTOPyQzLd7Xi/IN76vw9GZtNbDQUJ97fusqPx4/Dp/BPc4DWp19hXVsIO
	 0WhiCmTraIhZjaiWhpILtCi4pUk03w/yGuiLxkp28JsYV9lzk4DA+sfGk7AKB4AXaq
	 Ufjkmh4aOXR4YzD5KJ99USQ+17Ok1L/rOTYT/DGOwvxkMKE8cgob2y70e+o7Tzc9+0
	 ey4Y/kl5r4QbQ==
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
Subject: [PATCH v6 6/6] perf tools: Flush remaining samples w/o deferred callchains
Date: Thu, 20 Nov 2025 15:48:04 -0800
Message-ID: <20251120234804.156340-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251120234804.156340-1-namhyung@kernel.org>
References: <20251120234804.156340-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's possible that some kernel samples don't have matching deferred
callchain records when the profiling session was ended before the
threads came back to userspace.  Let's flush the samples before
finish the session.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dc570ad47ccc2c63..4236503c8f6c1350 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1295,6 +1295,10 @@ struct deferred_event {
 	union perf_event *event;
 };
 
+/*
+ * This is called when a deferred callchain record comes up.  Find all matching
+ * samples, merge the callchains and process them.
+ */
 static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 					      const struct perf_tool *tool,
 					      union  perf_event *event,
@@ -1345,6 +1349,42 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
 	return ret;
 }
 
+/*
+ * This is called at the end of the data processing for the session.  Flush the
+ * remaining samples as there's no hope for matching deferred callchains.
+ */
+static int session__flush_deferred_samples(struct perf_session *session,
+					   const struct perf_tool *tool)
+{
+	struct evlist *evlist = session->evlist;
+	struct machine *machine = &session->machines.host;
+	struct deferred_event *de, *tmp;
+	struct evsel *evsel;
+	int ret = 0;
+
+	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
+		struct perf_sample sample;
+
+		ret = evlist__parse_sample(evlist, de->event, &sample);
+		if (ret < 0) {
+			pr_err("failed to parse original sample\n");
+			break;
+		}
+
+		evsel = evlist__id2evsel(evlist, sample.id);
+		ret = evlist__deliver_sample(evlist, tool, de->event,
+					     &sample, evsel, machine);
+
+		list_del(&de->list);
+		free(de->event);
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
@@ -2038,6 +2078,9 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 done:
 	/* do the final flush for ordered samples */
 	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
+	if (err)
+		goto out_err;
+	err = session__flush_deferred_samples(session, tool);
 	if (err)
 		goto out_err;
 	err = auxtrace__flush_events(session, tool);
@@ -2384,6 +2427,9 @@ static int __perf_session__process_events(struct perf_session *session)
 	if (err)
 		goto out_err;
 	err = auxtrace__flush_events(session, tool);
+	if (err)
+		goto out_err;
+	err = session__flush_deferred_samples(session, tool);
 	if (err)
 		goto out_err;
 	err = perf_session__flush_thread_stacks(session);
@@ -2506,6 +2552,10 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 	if (ret)
 		goto out_err;
 
+	ret = session__flush_deferred_samples(session, tool);
+	if (ret)
+		goto out_err;
+
 	ret = perf_session__flush_thread_stacks(session);
 out_err:
 	ui_progress__finish();
-- 
2.52.0.rc2.455.g230fcf2819-goog


