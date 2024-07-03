Return-Path: <bpf+bounces-33833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF9F926B9A
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA19D282D39
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613F198A02;
	Wed,  3 Jul 2024 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP6/nJpx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30660195FEA;
	Wed,  3 Jul 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045841; cv=none; b=sSzSwNr+juW9jPn3GnVmOv7et15LEyk3R5Y0YOGMSwyS6nR6S3J/poyRcPRGXk+NxSA5m2tKz5UlKz+LdE7ofTtMJr05jZu0djnHT1Rn017uVGI8jx+lBzSNoHn0BGwuIK1N5DHEV3lvud38WCN+rd2UdJGDB54IL9K9e3kmcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045841; c=relaxed/simple;
	bh=Oe38Zy3sD1EBtAZsJmD68r+VYxDVmXNUn21vOw1Hj8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnrJ8BZ0MGYPwKid7cfpEHaQmF0Oi6OQYH8xZVEIfjNlw+kM5cN+e+bHC/GiqtfQDyhH8i+Kfk5LTD5K8+ZORCO8q4SwckJLEPsVIIuPGDoZMAQPhMi67K5+MX6o0Ni/Mr2YTGVxpmBhD7W5V/U8243rhCUFrMMv7QKNzxholGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP6/nJpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536E0C4AF0A;
	Wed,  3 Jul 2024 22:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045840;
	bh=Oe38Zy3sD1EBtAZsJmD68r+VYxDVmXNUn21vOw1Hj8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sP6/nJpxO0u8DHPOvnaaBixGb6AsMH1UHhLJe2Ae1xSQDzlE/lAfe1dSyM4LHFbnW
	 vpN2m2vI/2TtVzhVeUczv/tP45Jp45kjQmdemBpjJ86pKAF8386AOPDHS9cP5xEo8u
	 +DY9XOg6YkirHEus4JYb/cwf8eHhqyCD4yMXFFMv42L85wDOLoMdcp50BU3upvpl0Z
	 UvjM1n7CF5VIVScoXQSsnSic70HDOnN7hcXOW+OxQUWQVcVi4ultQuuJD+0gc9ommi
	 3ZwfPoWxg/tSNH4+22dq6UhO2D2iWw9Ke1kxIajAOzDXDDQOnEVTpzey5SDDeRnxVO
	 Lzr5exwC0qZyw==
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
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH v3 7/8] perf record: Add --setup-filter option
Date: Wed,  3 Jul 2024 15:30:34 -0700
Message-ID: <20240703223035.2024586-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240703223035.2024586-1-namhyung@kernel.org>
References: <20240703223035.2024586-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow BPF filters for unprivileged users it needs to pin the BPF
objects to BPF-fs first.  Let's add a new option to pin and unpin the
objects easily.  I'm not sure 'perf record' is a right place to do this
but I don't have a better idea right now.

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
index d6532ed97c02..41e36b4dc765 100644
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
index a473000f3599..e88dedc0391b 100644
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
@@ -3557,6 +3558,8 @@ static struct option __record_options[] = {
 			    "write collected trace data into several data files using parallel threads",
 			    record__parse_threads),
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
+	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
+		   "BPF filter action"),
 	OPT_END()
 };
 
@@ -4086,6 +4089,18 @@ int cmd_record(int argc, const char **argv)
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
2.45.2.803.g4e1b14247a-goog


