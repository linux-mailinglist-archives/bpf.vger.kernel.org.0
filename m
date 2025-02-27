Return-Path: <bpf+bounces-52794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61454A488D4
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 20:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E697A8A5A
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 19:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9573826FA55;
	Thu, 27 Feb 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhM+4HWN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ABC26E652;
	Thu, 27 Feb 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683545; cv=none; b=NmKWkDxFG5zlMnpiEcE2XLWL407KSiSFvO3H5fSiK1K7SXgyEfNx+Mg8Eu9o0nPpVt4faxbSmP/CyWh143b33fwJZHBo8Gucj67gjb2/BZ8BIIJIT/kQAts/0GoTNNwj1LYCcGUG6JsCF6C8ZVOe3WIJyH+DglClEfseDQfa6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683545; c=relaxed/simple;
	bh=XAI9N0CyboDBU2+RbgAT/8/54tDkScI6/mXCsBkG6Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Au9LTXjDR9UHPVXlzIzi/00J5+oYpHE+bhuROF2zIdoaR5LsupElhTAaEG4BadqJ1mz4xOLH2hmZFdUvL2TdZZuM/lVp+LBNzQ0jf2nwbPjLL1KZCej7hJxpP/k3VDJOM3W5S80QKBgi4Kyrp1jk3+Cd3CqMSX0aE8KubgbeL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhM+4HWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6F7C4CEDD;
	Thu, 27 Feb 2025 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740683544;
	bh=XAI9N0CyboDBU2+RbgAT/8/54tDkScI6/mXCsBkG6Tk=;
	h=From:To:Cc:Subject:Date:From;
	b=hhM+4HWN2MzmpOJNwe7Kll28cNsUpwiUJDtCc5wWw532oucul/rZbiqmtnnLPtMeU
	 /hAl4dYZzjG2bY2FrssUxHU4GxZDxe3n6989lVRiWcyM4usRPzlYqizj2ceVyTqlMl
	 PGL1ZfShI0QDCU9ihUqqj6YhmoZF90Pmf66MzgheD6EzkaVx4xFzct73sHcNkfVbc1
	 EzLDNvaAhfnmcPQfLMkI1+0hFRQ/7OLetr0x5ehqbsZ6JX+H6DJTEt7XndgHHZJbSc
	 QReeObCm3usBqA0A7pl6mw4zMa0/nvXtnqDKp2elxbHJt95+MDPWS0+Pb8P0QdzbNk
	 P3PCBLM0iuqZQ==
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
	bpf@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 1/3] perf ftrace: Fix latency stats with BPF
Date: Thu, 27 Feb 2025 11:12:21 -0800
Message-ID: <20250227191223.1288473-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BPF collects the stats for the latency in usec, it first divides
the time by 1000.  But that means it would have 0 if the delta is small
and won't update the total time properly.

Let's keep the stats in nsec always and adjust to usec before printing.

Before:

  $ sudo ./perf ftrace latency -ab -T mutex_lock --hide-empty -- sleep 0.1
  #   DURATION     |      COUNT | GRAPH                                          |
       0 -    1 us |        765 | #############################################  |
       1 -    2 us |         10 |                                                |
       2 -    4 us |          2 |                                                |
       4 -    8 us |          5 |                                                |

  # statistics  (in usec)
    total time:                    0    <<<--- (here)
      avg time:                    0
      max time:                    6
      min time:                    0
         count:                  782

After:

  $ sudo ./perf ftrace latency -ab -T mutex_lock --hide-empty -- sleep 0.1
  #   DURATION     |      COUNT | GRAPH                                          |
       0 -    1 us |        880 | ############################################   |
       1 -    2 us |         13 |                                                |
       2 -    4 us |          8 |                                                |
       4 -    8 us |          3 |                                                |

  # statistics  (in usec)
    total time:                  268    <<<--- (here)
      avg time:                    0
      max time:                    6
      min time:                    0
         count:                  904

Cc: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_ftrace.c                |  8 +++++++-
 tools/perf/util/bpf_skel/func_latency.bpf.c | 20 ++++++++------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index 51f407a782d6c58a..7324668cc83e747e 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -128,7 +128,7 @@ int perf_ftrace__latency_stop_bpf(struct perf_ftrace *ftrace __maybe_unused)
 	return 0;
 }
 
-int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
+int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace,
 				  int buckets[], struct stats *stats)
 {
 	int i, fd, err;
@@ -158,6 +158,12 @@ int perf_ftrace__latency_read_bpf(struct perf_ftrace *ftrace __maybe_unused,
 		stats->n = skel->bss->count;
 		stats->max = skel->bss->max;
 		stats->min = skel->bss->min;
+
+		if (!ftrace->use_nsec) {
+			stats->mean /= 1000;
+			stats->max /= 1000;
+			stats->min /= 1000;
+		}
 	}
 
 	free(hist);
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index 09e70d40a0f4d855..3d3d9f427c20876e 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -102,6 +102,7 @@ int BPF_PROG(func_end)
 	start = bpf_map_lookup_elem(&functime, &tid);
 	if (start) {
 		__s64 delta = bpf_ktime_get_ns() - *start;
+		__u64 val = delta;
 		__u32 key = 0;
 		__u64 *hist;
 
@@ -111,26 +112,24 @@ int BPF_PROG(func_end)
 			return 0;
 
 		if (bucket_range != 0) {
-			delta /= cmp_base;
+			val = delta / cmp_base;
 
 			if (min_latency > 0) {
-				if (delta > min_latency)
-					delta -= min_latency;
+				if (val > min_latency)
+					val -= min_latency;
 				else
 					goto do_lookup;
 			}
 
 			// Less than 1 unit (ms or ns), or, in the future,
 			// than the min latency desired.
-			if (delta > 0) { // 1st entry: [ 1 unit .. bucket_range units )
-				// clang 12 doesn't like s64 / u32 division
-				key = (__u64)delta / bucket_range + 1;
+			if (val > 0) { // 1st entry: [ 1 unit .. bucket_range units )
+				key = val / bucket_range + 1;
 				if (key >= bucket_num ||
-					delta >= max_latency - min_latency)
+					val >= max_latency - min_latency)
 					key = bucket_num - 1;
 			}
 
-			delta += min_latency;
 			goto do_lookup;
 		}
 		// calculate index using delta
@@ -146,10 +145,7 @@ int BPF_PROG(func_end)
 
 		*hist += 1;
 
-		if (bucket_range == 0)
-			delta /= cmp_base;
-
-		__sync_fetch_and_add(&total, delta);
+		__sync_fetch_and_add(&total, delta); // always in nsec
 		__sync_fetch_and_add(&count, 1);
 
 		if (delta > max)
-- 
2.48.1.711.g2feabab25a-goog


