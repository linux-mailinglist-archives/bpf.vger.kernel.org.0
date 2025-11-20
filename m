Return-Path: <bpf+bounces-75129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F35C71CBA
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 03:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF1BE4E39D1
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 02:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDA22D2382;
	Thu, 20 Nov 2025 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXfCHXL2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B1727B358;
	Thu, 20 Nov 2025 02:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763604656; cv=none; b=e+zXD+ryZBJOEhwICqDto6x/XMFrCUbiJ2XDdFVrDDcocvJx0gk8nigSivUeHyIzL59+4JT5AMtpyFTpjKp+1BBbQHM9WyTV2IxKk1uod9tvCyM9bbH6CvIk5hv9+72NDw5zssdpIRdPQz3mNabbINLWJN8xUDJybmxsSVA2wA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763604656; c=relaxed/simple;
	bh=G3JXFFGpO2SarJKns3afuT++lqbghmeEwxTGITFL/Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVC472OJaH2X1fmlEUTPSDo58ikSB7zkVzdiJUuYMDAqRBCLLnYZdHsPdgL8sBlhhsqWTVbni5HjI8mSXLyaOb+tmo2CcErzQHj4gaXDePbircXndGoWz0+kXtdrztgQrpj9m3Ijb7PnMqCowk/89BQC4LiTygzxqIdUXb44edM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXfCHXL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAE4C16AAE;
	Thu, 20 Nov 2025 02:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763604656;
	bh=G3JXFFGpO2SarJKns3afuT++lqbghmeEwxTGITFL/Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXfCHXL2Z54boWlRhI6+B4zQd7pnJGabl2CUDIwo5TcOQlcywJKTLaP2iWTu1Cnn9
	 yMcWO1C7en+iIYhe2H5Sh1xjMk8eomEoJRet4k1zIRwd3NOq5+wK1IgvDIDMSNH+/9
	 /qNGc/N8S9o6mRgM3v79AK4yVTKoA9M1dM4T+PsmL6k+tiH8u3dddcr83XpD/juCnl
	 AdzFBE2Pqjrex6hOK+DDDDksJ9N76VC2WAeJ8n9pqRAphxdlwCPI/BHGiJazTV7lpi
	 kb4lAiLVJwXdgprIYsfJQsiXSzUfLy+DWy3i6Zton2cvjbbSsJpMuw/uLzE6PueiFK
	 3TPIi11zPqgbg==
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
Subject: [PATCH v5 3/6] perf record: Add --call-graph fp,defer option for deferred callchains
Date: Wed, 19 Nov 2025 18:10:43 -0800
Message-ID: <20251120021046.94490-4-namhyung@kernel.org>
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

Add a new callchain record mode option for deferred callchains.  For now
it only works with FP (frame-pointer) mode.

And add the missing feature detection logic to clear the flag on old
kernels.

  $ perf record --call-graph fp,defer -vv true
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
    defer_output                     1
  ------------------------------------------------------------
  sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -22
  switching off deferred callchain support

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-config.txt |  3 +++
 tools/perf/Documentation/perf-record.txt |  4 ++++
 tools/perf/util/callchain.c              | 16 +++++++++++++---
 tools/perf/util/callchain.h              |  1 +
 tools/perf/util/evsel.c                  | 19 +++++++++++++++++++
 tools/perf/util/evsel.h                  |  1 +
 6 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c6f33565966735fe..642d1c490d9e3bcd 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -452,6 +452,9 @@ Variables
 		kernel space is controlled not by this option but by the
 		kernel config (CONFIG_UNWINDER_*).
 
+		The 'defer' mode can be used with 'fp' mode to enable deferred
+		user callchains (like 'fp,defer').
+
 	call-graph.dump-size::
 		The size of stack to dump in order to do post-unwinding. Default is 8192 (byte).
 		When using dwarf into record-mode, the default size will be used if omitted.
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 067891bd7da6edc8..e8b9aadbbfa50574 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -325,6 +325,10 @@ OPTIONS
 	by default.  User can change the number by passing it after comma
 	like "--call-graph fp,32".
 
+	Also "defer" can be used with "fp" (like "--call-graph fp,defer") to
+	enable deferred user callchain which will collect user-space callchains
+	when the thread returns to the user space.
+
 -q::
 --quiet::
 	Don't print any warnings or messages, useful for scripting.
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index d7b7eef740b9d6ed..2884187ccbbecfdc 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -275,9 +275,13 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 			if (tok) {
 				unsigned long size;
 
-				size = strtoul(tok, &name, 0);
-				if (size < (unsigned) sysctl__max_stack())
-					param->max_stack = size;
+				if (!strncmp(tok, "defer", sizeof("defer"))) {
+					param->defer = true;
+				} else {
+					size = strtoul(tok, &name, 0);
+					if (size < (unsigned) sysctl__max_stack())
+						param->max_stack = size;
+				}
 			}
 			break;
 
@@ -314,6 +318,12 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 	} while (0);
 
 	free(buf);
+
+	if (param->defer && param->record_mode != CALLCHAIN_FP) {
+		pr_err("callchain: deferred callchain only works with FP\n");
+		return -EINVAL;
+	}
+
 	return ret;
 }
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 86ed9e4d04f9ee7b..d5ae4fbb7ce5fa44 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -98,6 +98,7 @@ extern bool dwarf_callchain_users;
 
 struct callchain_param {
 	bool			enabled;
+	bool			defer;
 	enum perf_call_graph_mode record_mode;
 	u32			dump_size;
 	enum chain_mode 	mode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5ee3e7dee93fbbcb..7772ee9cfe3ac1c7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1065,6 +1065,9 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		pr_info("Disabling user space callchains for function trace event.\n");
 		attr->exclude_callchain_user = 1;
 	}
+
+	if (param->defer && !attr->exclude_callchain_user)
+		attr->defer_callchain = 1;
 }
 
 void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
@@ -1511,6 +1514,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->mmap2    = track && !perf_missing_features.mmap2;
 	attr->comm     = track;
 	attr->build_id = track && opts->build_id;
+	attr->defer_output = track && callchain->defer;
 
 	/*
 	 * ksymbol is tracked separately with text poke because it needs to be
@@ -2199,6 +2203,10 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.defer_callchain && evsel->core.attr.defer_callchain)
+		evsel->core.attr.defer_callchain = 0;
+	if (perf_missing_features.defer_callchain && evsel->core.attr.defer_output)
+		evsel->core.attr.defer_output = 0;
 	if (perf_missing_features.inherit_sample_read && evsel->core.attr.inherit &&
 	    (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
 		evsel->core.attr.inherit = 0;
@@ -2473,6 +2481,13 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
 
 	/* Please add new feature detection here. */
 
+	attr.defer_callchain = true;
+	if (has_attr_feature(&attr, /*flags=*/0))
+		goto found;
+	perf_missing_features.defer_callchain = true;
+	pr_debug2("switching off deferred callchain support\n");
+	attr.defer_callchain = false;
+
 	attr.inherit = true;
 	attr.sample_type = PERF_SAMPLE_READ | PERF_SAMPLE_TID;
 	if (has_attr_feature(&attr, /*flags=*/0))
@@ -2584,6 +2599,10 @@ static bool evsel__detect_missing_features(struct evsel *evsel, struct perf_cpu
 	errno = old_errno;
 
 check:
+	if ((evsel->core.attr.defer_callchain || evsel->core.attr.defer_output) &&
+	    perf_missing_features.defer_callchain)
+		return true;
+
 	if (evsel->core.attr.inherit &&
 	    (evsel->core.attr.sample_type & PERF_SAMPLE_READ) &&
 	    perf_missing_features.inherit_sample_read)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3ae4ac8f9a37e009..a08130ff2e47a887 100644
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
2.52.0.rc1.455.g30608eb744-goog


