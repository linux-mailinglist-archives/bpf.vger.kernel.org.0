Return-Path: <bpf+bounces-60644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32915AD99BA
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 04:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20932189F219
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 02:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE4B72624;
	Sat, 14 Jun 2025 02:45:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AB2E11A3;
	Sat, 14 Jun 2025 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749869149; cv=none; b=FuMJy+N4aZrj69YbPrAJp8y4Si2ydgxw+Hq6lufbqzWh6cQJ14sZmXXa8LPdY7nIvP3jAVHhwexHo6TstlEqu5hzAU+63WqvHHuCkkmAXRH6TMglODtrk7zMU0tYq4eRqbTMPJN0suqlgWpe0q8+/ziA1XXcqDkkURQndrkBl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749869149; c=relaxed/simple;
	bh=uOx5DfUnBLxP9fI1uU9zO1GwRE8LdxHgs3BL/mHcvYk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BnrXOb0QUW8MQKyFLsszLmD4Qj+H+ldDB2w/ff6It+ASGz7sBWr7cZOxeGy56I4QsbZ8p2FICXj4i+G4XI3S6f+ZKcaclwurnnYx//i5sEH0BUriD5bCowePU1o6rYAGBQnEqBpZsnnJ08kZjxynnLjCJbm40JBw24mzRjGtIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 32B3F5FEA5;
	Sat, 14 Jun 2025 02:45:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 069AF20024;
	Sat, 14 Jun 2025 02:45:37 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uQGvN-00000002SqO-1E4p;
	Fri, 13 Jun 2025 22:47:17 -0400
Message-ID: <20250614024717.141958632@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 13 Jun 2025 22:46:14 -0400
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
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v10 09/11] perf record: Enable defer_callchain for user callchains
References: <20250614024605.597728558@goodmis.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 069AF20024
X-Stat-Signature: 3971e4wuhc3pt57kce1ihjqntxag934f
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18NbTsOPJyD9r2JVenCA8ZdIRSoDcqjV98=
X-HE-Tag: 1749869137-251098
X-HE-Meta: U2FsdGVkX198NzSiJDLMUL4phop9l16mAPMoWREz3aTuf3Fvge2AUfQuKVVILAE00qkf7UBWi2ACzmgDcl1WkoIiAb70OphgbV5pSAF3VJKPE1YUGlPkH9hhPTTe9DCKQ6F2brLD+19wPIFeQSXpapVOczWfvI5A2ur/+2jjuEIJxMYs4/7loqc585E6ewRCHj5NTMrKCOcvLn20qUAGX5C4yimeLXYjvqrHqiy7RlSPVgyzrS/uHQ+2Hv+2lHZ9VhBT3X46Z0MyJ+6emclQ4g9USPENKUSV2v5OIerIrzL4t3MkRc9vrMRWtrY9C+UaY4VzBke9kSf5UAb/2R+vzvx65vDaMKzwExq5CQTTGvnLl9JTMPJAL7SLrD5oLHGZcHwlzEt8OwIfz3R4aknWh6vW0ZIfb86whUhfW3WKnns=

From: Namhyung Kim <namhyung@kernel.org>

And add the missing feature detection logic to clear the flag on old
kernels.

  $ perf record -g -vv true
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    size                             136
    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CALLCHAIN|PERIOD
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    sample_id_all                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
    defer_callchain                  1
  ------------------------------------------------------------
  sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -22
  switching off deferred callchain support

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
 tools/perf/util/evsel.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6176c31b57ea..c942983b870e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1076,6 +1076,14 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		}
 	}
 
+	if (param->record_mode == CALLCHAIN_FP && !attr->exclude_callchain_user) {
+		/*
+		 * Enable deferred callchains optimistically.  It'll be switched
+		 * off later if the kernel doesn't support it.
+		 */
+		attr->defer_callchain = 1;
+	}
+
 	if (function) {
 		pr_info("Disabling user space callchains for function trace event.\n");
 		attr->exclude_callchain_user = 1;
@@ -2124,6 +2132,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.defer_callchain)
+		evsel->core.attr.defer_callchain = 0;
 	if (perf_missing_features.inherit_sample_read && evsel->core.attr.inherit &&
 	    (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
 		evsel->core.attr.inherit = 0;
@@ -2398,6 +2408,15 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
 
 	/* Please add new feature detection here. */
 
+	attr.defer_callchain = true;
+	attr.sample_type = PERF_SAMPLE_CALLCHAIN;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.defer_callchain = true;
+	pr_debug2("switching off deferred callchain support\n");
+	attr.defer_callchain = false;
+	attr.sample_type = 0;
+
 	attr.inherit = true;
 	attr.sample_type = PERF_SAMPLE_READ;
 	if (has_attr_feature(&attr, /*flags=*/0))
@@ -2509,6 +2528,11 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
 	errno = old_errno;
 
 check:
+	if (evsel->core.attr.defer_callchain &&
+	    evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN &&
+	    perf_missing_features.defer_callchain)
+		return true;
+
 	if (evsel->core.attr.inherit &&
 	    (evsel->core.attr.sample_type & PERF_SAMPLE_READ) &&
 	    perf_missing_features.inherit_sample_read)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 6dbc9690e0c9..a01c1de8f95f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -221,6 +221,7 @@ struct perf_missing_features {
 	bool branch_counters;
 	bool aux_action;
 	bool inherit_sample_read;
+	bool defer_callchain;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.47.2



