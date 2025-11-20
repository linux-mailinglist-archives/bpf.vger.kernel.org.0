Return-Path: <bpf+bounces-75207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0AC76A8B
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 00:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 7B03030DCA
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16E1318135;
	Thu, 20 Nov 2025 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8iwSSFY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F063164B6;
	Thu, 20 Nov 2025 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682495; cv=none; b=jp/fVF+GnAcZP/zhM1Aea7fvq78FjCXQA3L9LeuIaxnKwTrsdY9bT9Qff2/oOcyn0DT+Sb/R/Bek2qTb/5IdQdL7vC6DjOqFDTzYhUKitg7aZ92aY1hJES/dNjnN1oyX+a+sivxYjcfUnSH4WTROEBJDGbpfa5FgDmJLFMYoEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682495; c=relaxed/simple;
	bh=upTAgARAQAq18z+WH9kjn/9KKukOA/BvWpQEDF9vHOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mqd8NEflIy3awQ+ePDCsb0kDOcL9Tf5FWNlD3Z70Fqi+jtrswcOwY7wXOPlZlu1ht0Z2jpBFfsQ80xqHzaew2yThiQiTF1nqawQkqdLDaBOoXjxBfMzbO8S2Mu4ZKebvrkrgs3ErvlckGKdnkMDTJLLym8G96UEo5wfHNwHXcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8iwSSFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4F1C116B1;
	Thu, 20 Nov 2025 23:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763682494;
	bh=upTAgARAQAq18z+WH9kjn/9KKukOA/BvWpQEDF9vHOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8iwSSFY8uj+09NJSUmTbGyYmh+2LI4TP5WNJ7wLMH1ErEVt3MhCc0WJIazEmRT7k
	 jeH8xoBTWzaMg16GgcZcvh+AH9LS/OgpsMXGcvUcKQ9GXgcXV3v03+sR0cG26xepsM
	 4ucfs1jl/6jZ+R14b0cVTVJtLrlCOo5+cZVY3eBqUyIx7kRrHrRbyXzTdglVZWE1UG
	 CyfYH1I6sTyaiQwapuPiIX3iQx4ImbJqsed+SqJCbFeb8vx1Su274bOp/0Zap8u7Qv
	 u7NoTViEvkstNXam+LVYy3LNWbze5sWM4WgQPSRP4Zz+UFmQhYfu9p+RB+ttZO5s4r
	 f2D+5dSb2bhWA==
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
Subject: [PATCH v6 4/6] perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
Date: Thu, 20 Nov 2025 15:48:02 -0800
Message-ID: <20251120234804.156340-5-namhyung@kernel.org>
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

Handle the deferred callchains in the script output.

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
                 b00000006 (cookie) ([unknown])

  pwd    2312   121.163447: DEFERRED CALLCHAIN [cookie: b00000006]
              7f18fe337fa7 mprotect+0x7 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe330e0f _dl_sysdep_start+0x7f (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)
              7f18fe331448 _dl_start_user+0x0 (/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2)

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-script.c     | 89 +++++++++++++++++++++++++++++++++
 tools/perf/util/evsel_fprintf.c |  5 +-
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 011962e1ee0f6898..85b42205a71b3993 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2706,6 +2706,94 @@ static int process_sample_event(const struct perf_tool *tool,
 	return ret;
 }
 
+static int process_deferred_sample_event(const struct perf_tool *tool,
+					 union perf_event *event,
+					 struct perf_sample *sample,
+					 struct evsel *evsel,
+					 struct machine *machine)
+{
+	struct perf_script *scr = container_of(tool, struct perf_script, tool);
+	struct perf_event_attr *attr = &evsel->core.attr;
+	struct evsel_script *es = evsel->priv;
+	unsigned int type = output_type(attr->type);
+	struct addr_location al;
+	FILE *fp = es->fp;
+	int ret = 0;
+
+	if (output[type].fields == 0)
+		return 0;
+
+	/* Set thread to NULL to indicate addr_al and al are not initialized */
+	addr_location__init(&al);
+
+	if (perf_time__ranges_skip_sample(scr->ptime_range, scr->range_num,
+					  sample->time)) {
+		goto out_put;
+	}
+
+	if (debug_mode) {
+		if (sample->time < last_timestamp) {
+			pr_err("Samples misordered, previous: %" PRIu64
+				" this: %" PRIu64 "\n", last_timestamp,
+				sample->time);
+			nr_unordered++;
+		}
+		last_timestamp = sample->time;
+		goto out_put;
+	}
+
+	if (filter_cpu(sample))
+		goto out_put;
+
+	if (machine__resolve(machine, &al, sample) < 0) {
+		pr_err("problem processing %d event, skipping it.\n",
+		       event->header.type);
+		ret = -1;
+		goto out_put;
+	}
+
+	if (al.filtered)
+		goto out_put;
+
+	if (!show_event(sample, evsel, al.thread, &al, NULL))
+		goto out_put;
+
+	if (evswitch__discard(&scr->evswitch, evsel))
+		goto out_put;
+
+	perf_sample__fprintf_start(scr, sample, al.thread, evsel,
+				   PERF_RECORD_CALLCHAIN_DEFERRED, fp);
+	fprintf(fp, "DEFERRED CALLCHAIN [cookie: %llx]",
+		(unsigned long long)event->callchain_deferred.cookie);
+
+	if (PRINT_FIELD(IP)) {
+		struct callchain_cursor *cursor = NULL;
+
+		if (symbol_conf.use_callchain && sample->callchain) {
+			cursor = get_tls_callchain_cursor();
+			if (thread__resolve_callchain(al.thread, cursor, evsel,
+						      sample, NULL, NULL,
+						      scripting_max_stack)) {
+				pr_info("cannot resolve deferred callchains\n");
+				cursor = NULL;
+			}
+		}
+
+		fputc(cursor ? '\n' : ' ', fp);
+		sample__fprintf_sym(sample, &al, 0, output[type].print_ip_opts,
+				    cursor, symbol_conf.bt_stop_list, fp);
+	}
+
+	fprintf(fp, "\n");
+
+	if (verbose > 0)
+		fflush(fp);
+
+out_put:
+	addr_location__exit(&al);
+	return ret;
+}
+
 // Used when scr->per_event_dump is not set
 static struct evsel_script es_stdout;
 
@@ -4303,6 +4391,7 @@ int cmd_script(int argc, const char **argv)
 
 	perf_tool__init(&script.tool, !unsorted_dump);
 	script.tool.sample		 = process_sample_event;
+	script.tool.callchain_deferred	 = process_deferred_sample_event;
 	script.tool.mmap		 = perf_event__process_mmap;
 	script.tool.mmap2		 = perf_event__process_mmap2;
 	script.tool.comm		 = perf_event__process_comm;
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 103984b29b1e10ae..10f1a03c28601e36 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -168,7 +168,10 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				node_al.addr = addr;
 				node_al.map  = map__get(map);
 
-				if (print_symoffset) {
+				if (sample->deferred_callchain &&
+				    sample->deferred_cookie == node->ip) {
+					printed += fprintf(fp, "(cookie)");
+				} else if (print_symoffset) {
 					printed += __symbol__fprintf_symname_offs(sym, &node_al,
 										  print_unknown_as_addr,
 										  true, fp);
-- 
2.52.0.rc2.455.g230fcf2819-goog


