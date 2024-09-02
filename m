Return-Path: <bpf+bounces-38734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08E968EAD
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 22:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4118D1C21E10
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB821019F;
	Mon,  2 Sep 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc24pqBx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542CC1D6792;
	Mon,  2 Sep 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307517; cv=none; b=AroO1w7ahw5SYuk67yud3sCedOlEqAPkPy3LimYz+5TxU/d9iGiQupG6VtycfHvHYT0AFvdR5HO6b4/sUhZ5G1AakGz3FGQ+mSyESpqMstgx1PLhw/JR0bziXkrm4+CpTl1rO+Eny+Zjd1740ALpA7yY3X8vl7Zh3QBo5RFya9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307517; c=relaxed/simple;
	bh=uh4VtjUUr5NjwAo/DUboGTevNunfbEJudmUWdFmEXu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHzgbQb9GF+idIfoiYpm4Gm96S4QdGZeDlZlJDj6+fDIN+0fjcUSG/5ANbAYzOeiXsyXNPFS+AXzQ/ItFUpJZ9eqo5QSHEI622SVK/1sLlIem/SLrVR76lNNEnrRKS2W1B7pMXu59hSGq5F7mW76NBfk94seJIzlblp+fHSjMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc24pqBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFDFC4CEC8;
	Mon,  2 Sep 2024 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725307516;
	bh=uh4VtjUUr5NjwAo/DUboGTevNunfbEJudmUWdFmEXu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hc24pqBxda9cs7V7huGhzYzUgIL+hpKrNG2OvPgCnuOg1CdWJbxQVSIaYUFqZh1y+
	 cQ1IIQDF9ya2liIrham/nuxdIeAJHhDOWpt4FAWQQ13vxTd4IodlqQVoYqEa+CiKYJ
	 GBZGGRib4yVM/BQ7rucK3tT4jwOo1PErhIpSQcs0rWi6Pjzdc8hX7zwzCPd6amSYX2
	 R4N4jURNlduwhUUue6EcLxp7Epy//G5zURTjbPCjro7bVMgy1NVB90a4arlz6Q8FiL
	 lZlFiezLSfMvqrOw6DLBOTqDuRj2TX+iLul+mJirUAUvOPF0vg5U/Q2yQt8pHtnsEs
	 SrIn5A3UTJHcA==
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
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH 1/5] perf stat: Constify control data for BPF
Date: Mon,  2 Sep 2024 13:05:11 -0700
Message-ID: <20240902200515.2103769-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240902200515.2103769-1-namhyung@kernel.org>
References: <20240902200515.2103769-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The control knobs set before loading BPF programs should be declared as
'const volatile' so that it can be optimized by the BPF core.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_counter_cgroup.c        | 6 +++---
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index ea29c372f339705d..6ff42619de12bddf 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -61,6 +61,9 @@ static int bperf_load_program(struct evlist *evlist)
 	skel->rodata->num_cpus = total_cpus;
 	skel->rodata->num_events = evlist->core.nr_entries / nr_cgroups;
 
+	if (cgroup_is_v2("perf_event") > 0)
+		skel->rodata->use_cgroup_v2 = 1;
+
 	BUG_ON(evlist->core.nr_entries % nr_cgroups != 0);
 
 	/* we need one copy of events per cpu for reading */
@@ -82,9 +85,6 @@ static int bperf_load_program(struct evlist *evlist)
 		goto out;
 	}
 
-	if (cgroup_is_v2("perf_event") > 0)
-		skel->bss->use_cgroup_v2 = 1;
-
 	err = -1;
 
 	cgrp_switch = evsel__new(&cgrp_switch_attr);
diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 6a438e0102c5a2cb..57cab7647a9ad766 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -57,9 +57,9 @@ struct cgroup___old {
 
 const volatile __u32 num_events = 1;
 const volatile __u32 num_cpus = 1;
+const volatile int use_cgroup_v2 = 0;
 
 int enabled = 0;
-int use_cgroup_v2 = 0;
 int perf_subsys_id = -1;
 
 static inline __u64 get_cgroup_v1_ancestor_id(struct cgroup *cgrp, int level)
-- 
2.46.0.469.g59c65b2a67-goog


