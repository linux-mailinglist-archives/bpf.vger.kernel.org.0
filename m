Return-Path: <bpf+bounces-67767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994D4B49798
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 19:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412FA171696
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 17:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6D314B6E;
	Mon,  8 Sep 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT9jQse+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC1313E2E;
	Mon,  8 Sep 2025 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354025; cv=none; b=aHv//x3xqJXGTcbTIQWjL7XlFBZcn9ZfDilXIY23wcaoh1BPYp6urw+B/ucBRKR52WIvyIK17g/08QD2+wxpxLivb/f5mxOYTQveguf10nwFPgycGS5DwXbdNLpC69bxtuFkyplviOfB4dMG9U1pe9L/tDBdDkRFK+MxI9pshHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354025; c=relaxed/simple;
	bh=BhpB4Hf4gnrWTl4zJnVEoytLOMXxEDW7wZ+75iSbkjg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Nt/D+fa2IlC3DeYQKSgvEpXL8stoQXTp6OZq+BP6VaO0It8MvXJGJfkjOsCSQJjlIA7dUGH4dmsH3bg2jH+DKTfiyCZ6rK2s73TOjS1zqOmpDJO4nejP1LzKIDkPlKUKoZURciUJd92SOAxV21pmFwIjd/sTOqshU2+XZIAndEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT9jQse+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEF3C4CEFA;
	Mon,  8 Sep 2025 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757354024;
	bh=BhpB4Hf4gnrWTl4zJnVEoytLOMXxEDW7wZ+75iSbkjg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=NT9jQse+G5KXmTuLtYrDkzxSKOTd1QsmwpQRO2dgyiBZq2oS34eYKTuq6fyK29Ft9
	 ZgzBDDI3dgOEtephTU2pYK4Nmm8tfHUTuDFoUoAvU3ITzdE3SpvkpxFSFKPaJm0zfN
	 BC/HpM5wxv55I4FA09hLSLkPeOqqcC2XO619WFyMEbyXX+NR440wEgZ6SCTq8XnXl2
	 2btn0smZ1iqQSqxSYfEa6eAfJ7q5vR+NUwQ284dvjTXm9BBD+rVifFjFcJYtHBrJYx
	 VKqbkcnQ/M2HQubA2aadDfgaWqqkX5SnwIe4MBmJYkXo6qEiZomo9giVi/3Sdtat5L
	 /2xoAMBtNY3FQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uvg4U-000000076B7-2axS;
	Mon, 08 Sep 2025 13:54:30 -0400
Message-ID: <20250908175430.469531803@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 08 Sep 2025 13:53:22 -0400
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
 Florian Weimer <fweimer@redhat.com>,
 Sam James <sam@gentoo.org>,
 Kees Cook <kees@kernel.org>,
 "Carlos O'Donell" <codonell@redhat.com>
Subject: [PATCH v16 3/4] perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
References: <20250908175319.841517121@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Namhyung Kim <namhyung@kernel.org>

Handle the deferred callchains in the script output.

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

  perf     801 [000]    18.031814: DEFERRED CALLCHAIN
              7fb5fc22034b __GI___ioctl+0x3b (/usr/lib/x86_64-linux-gnu/libc.so.6)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v15: https://lore.kernel.org/20250825180802.557798597@kernel.org

- Removed initialization of script.tool.merge_deferred_callchains as it is
  introduced in the next patch.

 tools/perf/builtin-script.c | 88 +++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d9fbdcf72f25..03ea7b7e5bc1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2484,6 +2484,93 @@ static int process_sample_event(const struct perf_tool *tool,
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
+	fprintf(fp, "DEFERRED CALLCHAIN");
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
 
@@ -4080,6 +4167,7 @@ int cmd_script(int argc, const char **argv)
 
 	perf_tool__init(&script.tool, !unsorted_dump);
 	script.tool.sample		 = process_sample_event;
+	script.tool.callchain_deferred	 = process_deferred_sample_event;
 	script.tool.mmap		 = perf_event__process_mmap;
 	script.tool.mmap2		 = perf_event__process_mmap2;
 	script.tool.comm		 = perf_event__process_comm;
-- 
2.50.1



