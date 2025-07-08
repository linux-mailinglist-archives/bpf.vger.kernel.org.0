Return-Path: <bpf+bounces-62613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA7AAFC057
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 04:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2761BC0832
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F2B22837F;
	Tue,  8 Jul 2025 02:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ5FYcqS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738DA22156A;
	Tue,  8 Jul 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940051; cv=none; b=io72vqv5pc42RqPjIoCd8+NrCE3KecSYPIgK4yDAebCo1roFy7j4sVtaiyxGLS9k+8ciyfIew9xrb9ZmfVVN+Gp/N/L0Xt2/sxCJasKqqKUIs8Bb+bsPXsi49CZJOzGQLL5dm9LhlTDpNh1Q/GBIqnC29LtqBAN774eMsfhP+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940051; c=relaxed/simple;
	bh=uOx5DfUnBLxP9fI1uU9zO1GwRE8LdxHgs3BL/mHcvYk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EHRerh7BYaQrU375CcGyezWO9Cf+dJCu7UHqw2u3pfsS/IZr0qNGR2Yhk++0NdJV8IsbeE5/SLAn+ILL56avRWsb0YIxogqZBt292IXERSewc54zLrwda6/ATYP6AGXEMYiVrVXjAOQR+a6XBeZ+glbNLL0a80JksNEvfwUQ/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ5FYcqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4C0C116C6;
	Tue,  8 Jul 2025 02:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751940051;
	bh=uOx5DfUnBLxP9fI1uU9zO1GwRE8LdxHgs3BL/mHcvYk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=HQ5FYcqS7Ll/9x2LOOx412xxuL+W8sAv5GMDLCJD6LddvG/cChir7tnX2lO/ZAHSI
	 qN/TKdyE0G5vD32IggkAC83x8c4rOCGEYG0a+apDgktvhwOm6rTLpdV9NjlMmAhRZi
	 +poaZwePQv9+JcarxaXsJxeI7G1EDZkBieojAPrWKl4jjHvrjPb4kbePqs7LV1iOT+
	 Xjz3L194tDzVg0PrptFjnM9o2eOYpC3PbOBbxDvyyz2Y6y9S9n0PkE9if1nMmvtj4c
	 JIEsFVSyxCW0WrXh4rkdgxapN3/3/corRmU/N5wY/GRwTZ7JPMTTtqFOgeuawbehG4
	 5Xzlo3Xv5dN4w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uYxdb-00000000D87-2Sxl;
	Mon, 07 Jul 2025 22:00:51 -0400
Message-ID: <20250708020051.439871837@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 07 Jul 2025 22:00:12 -0400
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
Subject: [PATCH v13 09/11] perf record: Enable defer_callchain for user callchains
References: <20250708020003.565862284@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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



