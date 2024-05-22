Return-Path: <bpf+bounces-30340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CAA8CC85D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 23:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73EED1C20DF5
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 21:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA3D148839;
	Wed, 22 May 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZrQl0R/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50611487E3;
	Wed, 22 May 2024 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716414982; cv=none; b=X9Gp46fy1UQiPyZ3w/OZVP6p1gevtSlHb5Qa/Wueq395DchIdrD3Nptb9mYlyGhksjzUp8wP4fZ8Ue8PJuPqLiumRCopAh2/yhYvfBt0rpmUcelrFG978suxckF8v3mgC9hcAU6p8Y2phOxaZDhVtB98XANqiPDG/vaUkABZLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716414982; c=relaxed/simple;
	bh=Z4r4Kvmu8bvtpq0F56IFeFFxcPQskBGSqOlqhqZnnvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnI2HvEELIiXNj9gIZlvRYvR8Z6X6UXSDwVysGVLZQ/8Zf0QyAxTMr5GvL3F8cJbOVc1x1XtJqQoHtWhcWNsMdSxgElbx5B7djmqUhcmIJHHpShGcxXjIruHg9DvmMhzV6t9n45AwSCHfW+lGEm+O6/RL2Ab7Hf7wWCV7ps52Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZrQl0R/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190ABC4AF0A;
	Wed, 22 May 2024 21:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716414981;
	bh=Z4r4Kvmu8bvtpq0F56IFeFFxcPQskBGSqOlqhqZnnvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZrQl0R/lbG8f4A7szWgDJYqmLYn7KOIeQeMfrtQxitWHeoO/sYd4zuepi/Rp+fCI
	 e4zAfV5f47LS1zMIKgwVOVtSlhSN6mc796VSgUuWO1V/VqEKwiZzHxfklGrRUk2U6r
	 4PrqUUFqGuC/ZiWBBGnt5Ge70Ff7NVneaTImxXAsmLC4VLZjxAjocOupoa0Zrdqp45
	 XlYv0cFvjCOL93fJCOTtu/WaCQYDa3c9ihmfNHFjhhYVtfX3tYDoRCDjBHU/DMAxUk
	 /OC/cN+YzUX2/D3D9PWPSUKFvXGy4aZhlLzz6J8lMXJ2QniKoGTumkiGYQ0W5QPJsw
	 9BIz6HXdxxjew==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 6/6] perf record: Add --setup-filter option
Date: Wed, 22 May 2024 14:56:16 -0700
Message-ID: <20240522215616.762195-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240522215616.762195-1-namhyung@kernel.org>
References: <20240522215616.762195-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow BPF filters for unprivileged users it needs to pin the BPF
objects to BPF-fs first.  Let's add a new option to pin and unpin the
objects easily.

  $ sudo perf record --setup-filter pin

The above command would pin BPF program and maps for the filter when the
system has BPF-fs (usually at /sys/fs/bpf/).  To unpin the objects,
users can run the following command (as root).

  $ sudo perf record --setup-filter unpin

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  5 +++++
 tools/perf/builtin-record.c              | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb6..e51a492dc8e0 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -828,6 +828,11 @@ filtered through the mask provided by -C option.
 	only, as of now.  So the applications built without the frame
 	pointer might see bogus addresses.
 
+--setup-filter=<action>::
+	Prepare BPF filter to be used by regular users.  The action should be
+	either "pin" or "unpin".  The filter can be used after it's pinned.
+
+
 include::intel-hybrid.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3a5a24dec356..4dababd0d338 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -171,6 +171,7 @@ struct record {
 	bool			timestamp_filename;
 	bool			timestamp_boundary;
 	bool			off_cpu;
+	const char		*filter_action;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	unsigned long		output_max_size;	/* = 0: unlimited */
@@ -3573,6 +3574,8 @@ static struct option __record_options[] = {
 			    "write collected trace data into several data files using parallel threads",
 			    record__parse_threads),
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
+	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
+		   "BPF filter action"),
 	OPT_END()
 };
 
@@ -4102,6 +4105,18 @@ int cmd_record(int argc, const char **argv)
 		pr_warning("WARNING: --timestamp-filename option is not available in parallel streaming mode.\n");
 	}
 
+	if (rec->filter_action) {
+		if (!strcmp(rec->filter_action, "pin"))
+			err = perf_bpf_filter__pin();
+		else if (!strcmp(rec->filter_action, "unpin"))
+			err = perf_bpf_filter__unpin();
+		else {
+			pr_warning("Unknown BPF filter action: %s\n", rec->filter_action);
+			err = -EINVAL;
+		}
+		goto out_opts;
+	}
+
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
-- 
2.45.1.288.g0e0cd299f1-goog


