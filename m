Return-Path: <bpf+bounces-63751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A99B0A8BD
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 18:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649645A7F2B
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D6E2E7F0A;
	Fri, 18 Jul 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb+iGYCm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E92E7659;
	Fri, 18 Jul 2025 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856981; cv=none; b=fGACl22i8KksMo3/fQE7yb84JoO6+kB6Gp40PqCzTnGcSr5mGhKD9yH6JW7rs0aZ2pv1WS27WM4z2jWdZ2TxixmDvVn3sKq/uihGyHzkq/ocdxUu7BhO0fDqf4vKcr88dwT8YLl9yIlRqxVwQbDu90jy2ppZLEc+LM9hv4tCQNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856981; c=relaxed/simple;
	bh=uOx5DfUnBLxP9fI1uU9zO1GwRE8LdxHgs3BL/mHcvYk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=m27mrzN/MpcHm42w9Bd/LUAKUyamaf1uTPP2T5y7C4HgrrPDie2ODcvei24KEZfWojGVv2ZmW34km5oADpBTDV5Y2AGNVT+JLImlbEU3pwgdDCLaSaZIpiJDAT/2hXg0j0bR9DcTJoTNS1YMNLhuLSl70OqzJINQW6nSPytTmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb+iGYCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6BBC4CEEB;
	Fri, 18 Jul 2025 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856980;
	bh=uOx5DfUnBLxP9fI1uU9zO1GwRE8LdxHgs3BL/mHcvYk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=sb+iGYCmxdkg6Kdyj3n3YPiKjrGfRKV3fKFSsWxXGZh01mZlf2yEGb3J6Vdsv0bIH
	 gAxbS1oc1ijx5yXz3nfcDA+axtTtgkkQWyvellwMJ/1GelusEJK2csxyephpPuek6g
	 xlQZrQClKzIrEhmCnn3U91aV9wTFIRYD5+Xp4B+gFcbQ8PZ+FZb1EQkFDhQrRS2vCI
	 YCfkYGkA+RBkD779OMgZ2R7fQqeU3sWoLussc9/BGvflCYOuJlzhYBk1NCt2FOPcrC
	 CIYm1ebqv2Hcx0dVjgKxHnPSGAUeOr3uy/30sDaYsRpigpUJj57ajIOGOqMYuknkmP
	 OtPLX3sRxwUJg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucoBA-00000007JaG-36Cz;
	Fri, 18 Jul 2025 12:43:24 -0400
Message-ID: <20250718164324.593888790@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 12:41:28 -0400
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
Subject: [PATCH v14 09/11] perf record: Enable defer_callchain for user callchains
References: <20250718164119.089692174@kernel.org>
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



