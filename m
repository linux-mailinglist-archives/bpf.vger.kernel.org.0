Return-Path: <bpf+bounces-38245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A38961E34
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 07:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1132858A3
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 05:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCCB14D43D;
	Wed, 28 Aug 2024 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF36T2Jb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E414A4C7;
	Wed, 28 Aug 2024 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724822995; cv=none; b=REow6OxpyM3zPO5TYKfUyZw8k7TEk1ANpLsqcHYxUcJ1+66s68xZbS8MTED+8TBiiF9NAjTjQzxzuKCrcp2EhkBRtxosZkzH+ebkZC6TKRhwFRi6Zhp+Vdgl0SlGEMxbUPBsLV6J/F2R8HFXH55Bd+dXlQM02JGEO3Sn1HGlVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724822995; c=relaxed/simple;
	bh=FGISyqZO8CsSpcS8+QnbUGriIY/DF/FJMlaX57XnfLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A295W0qCJL3VKC4vUDlPVArPHk2f2031Lubgju0uwI0tLimz56jrMTvEHV1q2aR4iwXdov4vYj3jb1DLEIQbY+1Jgq5s66uJib8OZcU/mcsgXm4AtvGkMS8J3wze9/lF3CxzpQdGVOxzXnmYP3juCgNx8LaOkWtWH1hjp8g44C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF36T2Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8084C4AF19;
	Wed, 28 Aug 2024 05:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724822994;
	bh=FGISyqZO8CsSpcS8+QnbUGriIY/DF/FJMlaX57XnfLM=;
	h=From:To:Cc:Subject:Date:From;
	b=nF36T2JbCPgL6N4jf3rJ4iEsuAuNqm0VlAnLTpy3LyG/BAaaxJeDBvdLwz0jOdLTH
	 Q6Oj8q4N5cEYpqQCaG8MdlwH3YzsPmYCgDJlNsYlE0w9r91Ph2vhSPH1Q/nr5CMDbe
	 Crqr+rAkhh+A3H5hlRMrqcQFZhM6Rh7Nton4ZYf1LgEl+LbUUZMH36bjnKdyCyOL1q
	 +PB8kCZ8hrXj0dj1Ea1asmwHvUXRM6r/rsM1WNqPaRaa8+bO3nDbNRgrwjZas3g7/W
	 745RZ4YQLK7+9w7PnC4sZqT4XOUyLiP1a9U33jjJKnbzl/Gvp2QaYGF3w426+OFN79
	 bf6bp+7cM8ADw==
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
	bpf@vger.kernel.org,
	Xi Wang <xii@google.com>
Subject: [PATCH] perf lock contention: Fix spinlock and rwlock accounting
Date: Tue, 27 Aug 2024 22:29:53 -0700
Message-ID: <20240828052953.1445862-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The spinlock and rwlock use a single-element per-cpu array to track
current locks due to performance reason.  But this means the key is
always available and it cannot simply account lock stats in the array
because some of them are invalid.

In fact, the contention_end() program in the BPF invalidates the entry
by setting the 'lock' value to 0 instead of deleting the entry for the
hashmap.  So it should skip entries with the lock value of 0 in the
account_end_timestamp().

Otherwise, it'd have spurious high contention on an idle machine:

  $ sudo perf lock con -ab -Y spinlock sleep 3
   contended   total wait     max wait     avg wait         type   caller

           8      4.72 s       1.84 s     590.46 ms     spinlock   rcu_core+0xc7
           8      1.87 s       1.87 s     233.48 ms     spinlock   process_one_work+0x1b5
           2      1.87 s       1.87 s     933.92 ms     spinlock   worker_thread+0x1a2
           3      1.81 s       1.81 s     603.93 ms     spinlock   tmigr_update_events+0x13c
           2      1.72 s       1.72 s     861.98 ms     spinlock   tick_do_update_jiffies64+0x25
           6     42.48 us     13.02 us      7.08 us     spinlock   futex_q_lock+0x2a
           1     13.03 us     13.03 us     13.03 us     spinlock   futex_wake+0xce
           1     11.61 us     11.61 us     11.61 us     spinlock   rcu_core+0xc7

I don't believe it has contention on a spinlock longer than 1 second.
After this change, it only reports some small contentions.

  $ sudo perf lock con -ab -Y spinlock sleep 3
   contended   total wait     max wait     avg wait         type   caller

           4    133.51 us     43.29 us     33.38 us     spinlock   tick_do_update_jiffies64+0x25
           4     69.06 us     31.82 us     17.27 us     spinlock   process_one_work+0x1b5
           2     50.66 us     25.77 us     25.33 us     spinlock   rcu_core+0xc7
           1     28.45 us     28.45 us     28.45 us     spinlock   rcu_core+0xc7
           1     24.77 us     24.77 us     24.77 us     spinlock   tmigr_update_events+0x13c
           1     23.34 us     23.34 us     23.34 us     spinlock   raw_spin_rq_lock_nested+0x15

Fixes: b5711042a1c8 ("perf lock contention: Use per-cpu array map for spinlocks")
Reported-by: Xi Wang <xii@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_lock_contention.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 4ee54538aba2..a3d40940fb23 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -296,6 +296,9 @@ static void account_end_timestamp(struct lock_contention *con)
 			goto next;
 
 		for (int i = 0; i < total_cpus; i++) {
+			if (cpu_data[i].lock == 0)
+				continue;
+
 			update_lock_stat(stat_fd, -1, end_ts, aggr_mode,
 					 &cpu_data[i]);
 		}
-- 
2.46.0.295.g3b9ea8a38a-goog


