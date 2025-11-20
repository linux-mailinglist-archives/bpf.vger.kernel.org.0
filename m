Return-Path: <bpf+bounces-75132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75904C71CB1
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 03:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32AEF351744
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1B72DCF72;
	Thu, 20 Nov 2025 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eud32Usg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0892D6E6F;
	Thu, 20 Nov 2025 02:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604662; cv=none; b=NOvWMJuiRh1+OXgP71TP/pL/0P7xpTz3XLZLnVov3kN6BoUYX44SOCe/JYJ3Ftsg8vUKY+g+1U1jegHox5DDBJnZk3LOZS/3r9FNyVdv/XTG1jbqYrsaUUEX+jXVJR1610q9lGEMB0griNauXs8BruE84z92/P2LxIi24xjv0Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604662; c=relaxed/simple;
	bh=siw+mcZ83tjXm1ovxal++nt/JLHPrue73w1F1ndPwRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQvjaxBRX2FPMYk4SzN1ZAYsrR5pOUUUwBaJ+CfjVCQKSADz+3SvNwWkH9jCBmhOt8yiAMxD7XE4WCVRetz8tmYQ8jTxJ+JLoFboFnBIa6jD00xumPLZ9EXC2wxIWVUEZCSjg3zVlzolA28MzMQGav67n3wtdRQVZEVFIWmOinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eud32Usg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E88CC16AAE;
	Thu, 20 Nov 2025 02:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604662;
	bh=siw+mcZ83tjXm1ovxal++nt/JLHPrue73w1F1ndPwRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eud32Usgc3f/G2icCK37SiCaUf90+lfBfUw++mCSiv4YBzcQAI2m0Tp0eKPxU/+B0
	 Qi7uOEyO8fQT4OAzOXa8gqG74jJjkWG2Qu4N2St0oI+Mfoj7aqwwqEaFREgr0b3RAD
	 oQHKpA43Mj5cVJCLn20JZDC4fsAA1l+uF4xabDkgqiALIdek06BVmr0dcJoPqhNGkF
	 J1Y6e1vzO73CFXOwG1HTJHmemhGdqTtNiKBUkp348Rc5gv0h6Jbw6SCl/I9U9JMjwG
	 a5KyipsPMQxA1VP3S7vGyeQqb7E+gXoP5pU793H4uxMs2Z/K0eMoREgFK7Wi+z8Uny
	 l2GL2YjAMkPqg==
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
Subject: [PATCH v5 6/6] perf tools: Flush remaining samples w/o deferred callchains
Date: Wed, 19 Nov 2025 18:10:46 -0800
Message-ID: <20251120021046.94490-7-namhyung@kernel.org>
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

It's possible that some kernel samples don't have matching deferred
callchain records when the profiling session was ended before the
threads came back to userspace.  Let's flush the samples before
finish the session.

Also 32-bit systems can see partial mmap for the data.  In that case,
deferred samples won't point to the correct data once the mapping moves
to the next portion of the file.  Copy the original sample before it
unmaps the current data.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 98 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2e777fd1bcf6707b..b781e01ddcb4876b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1288,8 +1288,13 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
 struct deferred_event {
 	struct list_head list;
 	union perf_event *event;
+	bool allocated;
 };
 
+/*
+ * This is called when a deferred callchain record comes up.  Find all matching
+ * samples, merge the callchains and process them.
+ */
 static int evlist__deliver_deferred_samples(struct evlist *evlist,
 					    const struct perf_tool *tool,
 					    union  perf_event *event,
@@ -1331,6 +1336,86 @@ static int evlist__deliver_deferred_samples(struct evlist *evlist,
 			free(orig_sample.callchain);
 
 		list_del(&de->list);
+		if (de->allocated)
+			free(de->event);
+		free(de);
+
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+/*
+ * This is called when the backing mmap is about to go away.  It needs to save
+ * the original sample data until it finds the matching deferred callchains.
+ */
+static void evlist__copy_deferred_samples(struct evlist *evlist,
+					  const struct perf_tool *tool,
+					  struct machine *machine)
+{
+	struct deferred_event *de, *tmp;
+	struct evsel *evsel;
+	int ret = 0;
+
+	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
+		struct perf_sample sample;
+		size_t sz = de->event->header.size;
+		void *buf;
+
+		if (de->allocated)
+			continue;
+
+		buf = malloc(sz);
+		if (buf) {
+			memcpy(buf, de->event, sz);
+			de->event = buf;
+			de->allocated = true;
+			continue;
+		}
+
+		/* The allocation failed, flush the sample now */
+		ret = evlist__parse_sample(evlist, de->event, &sample);
+		if (ret == 0) {
+			evsel = evlist__id2evsel(evlist, sample.id);
+			evlist__deliver_sample(evlist, tool, de->event,
+					       &sample, evsel, machine);
+		}
+
+		list_del(&de->list);
+		BUG_ON(de->allocated);
+		free(de);
+	}
+}
+
+/*
+ * This is called at the end of the data processing for the session.  Flush the
+ * remaining samples as there's no hope for matching deferred callchains.
+ */
+static int evlist__flush_deferred_samples(struct evlist *evlist,
+					  const struct perf_tool *tool,
+					  struct machine *machine)
+{
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
+		if (de->allocated)
+			free(de->event);
 		free(de);
 
 		if (ret)
@@ -1374,6 +1459,7 @@ static int machines__deliver_event(struct machines *machines,
 				return -ENOMEM;
 
 			de->event = event;
+			de->allocated = false;
 			list_add_tail(&de->list, &evlist->deferred_samples);
 			return 0;
 		}
@@ -2218,6 +2304,8 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 	}
 
 	if (mmaps[rd->mmap_idx]) {
+		evlist__copy_deferred_samples(session->evlist, session->tool,
+					      &session->machines.host);
 		munmap(mmaps[rd->mmap_idx], rd->mmap_size);
 		mmaps[rd->mmap_idx] = NULL;
 	}
@@ -2372,6 +2460,11 @@ static int __perf_session__process_events(struct perf_session *session)
 	if (err)
 		goto out_err;
 	err = auxtrace__flush_events(session, tool);
+	if (err)
+		goto out_err;
+	err = evlist__flush_deferred_samples(session->evlist,
+					     session->tool,
+					     &session->machines.host);
 	if (err)
 		goto out_err;
 	err = perf_session__flush_thread_stacks(session);
@@ -2494,6 +2587,11 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 	if (ret)
 		goto out_err;
 
+	ret = evlist__flush_deferred_samples(session->evlist, tool,
+					     &session->machines.host);
+	if (ret)
+		goto out_err;
+
 	ret = perf_session__flush_thread_stacks(session);
 out_err:
 	ui_progress__finish();
-- 
2.52.0.rc1.455.g30608eb744-goog


