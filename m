Return-Path: <bpf+bounces-38518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC449657D4
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 08:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27D128597D
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 06:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DF91547F6;
	Fri, 30 Aug 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEISNJ5h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8521531FE;
	Fri, 30 Aug 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000713; cv=none; b=cD4iXub3LDYQaOKeudvf08TJrZp91ZQItss0QWnVxLJsA86mP8bzzcNV9AT618QApDkrJv4+4thEcs37fkwBQaRdRDNYLWhRAOpvmIn0a93i/hD4lDy7Q1qtLUc/IE136/Nixr1BIujiXKzEWckAhU8kZUkbkVZ5itm46g+C2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000713; c=relaxed/simple;
	bh=wCR9miOWHuvC38OVs2dILCHpxCTCD26WoFfBRNFtywY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSAfcVYptVp/s5YDNRPFBwrZbvO7e1MwBZuQRCX8h1UfMfe+dtiDcgHY2+aZHbHWuuGmbbhzJqyrl7UmSXnsFgEcNPH7xmxa3cinsxHzo8b8u16qEnT3SEFu8gsRwqgmI+/Shr4I7NGzFhp1Q6hZABHKzOegbKKicZP57G3PNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEISNJ5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1DAC4CEC2;
	Fri, 30 Aug 2024 06:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725000712;
	bh=wCR9miOWHuvC38OVs2dILCHpxCTCD26WoFfBRNFtywY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEISNJ5hNoowtpXMTYmu6CxZzOrlXDCrbXZfokfHyCZ/hgLiFChgj8N1jGvcrewIQ
	 xyd70x7tpZxElAKM7Nm7Sd2Y5T1T8YNGz0pPUsJ7Hk3RqzcZuOsgFCoRZqCB8ytoBu
	 KjDQIa8aJ+WUik9qqRaRAT9K/b2GV3psU+nNqU1bi4/pW0oOIwb0d/ptATMbXT2mMI
	 y1jefhatg5Ah1ePHS9XVz+GQw6mQ688SV+887Wh5LV6uoSRiMIoxWBjcnLvgRatY+3
	 L0inblkGn6jJZGRav1lgI1fzt8Y3rCF+iv3h1ckgC5JgbXkG/l8+J/r7lGgnbgV2z6
	 YSVJBu2mzQHRQ==
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
Subject: [PATCH 3/3] perf lock contention: Do not fail EEXIST for update
Date: Thu, 29 Aug 2024 23:51:50 -0700
Message-ID: <20240830065150.1758962-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240830065150.1758962-1-namhyung@kernel.org>
References: <20240830065150.1758962-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it updates the lock stat for the first time, it needs to create an
element in the BPF hash map.  But if there's a concurrent thread waiting
for the same lock (like for rwsem or rwlock), it might race with the
thread and possibly failed to update with -EEXIST.  In that case, it can
lookup the map again and put the data there instead of failing.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 4b7237e178bd..52a876b42699 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -491,6 +491,12 @@ int contention_end(u64 *ctx)
 
 		err = bpf_map_update_elem(&lock_stat, &key, &first, BPF_NOEXIST);
 		if (err < 0) {
+			if (err == -EEXIST) {
+				/* it lost the race, try to get it again */
+				data = bpf_map_lookup_elem(&lock_stat, &key);
+				if (data != NULL)
+					goto found;
+			}
 			if (err == -E2BIG)
 				data_map_full = 1;
 			__sync_fetch_and_add(&data_fail, 1);
@@ -498,6 +504,7 @@ int contention_end(u64 *ctx)
 		goto out;
 	}
 
+found:
 	__sync_fetch_and_add(&data->total_time, duration);
 	__sync_fetch_and_add(&data->count, 1);
 
-- 
2.46.0.469.g59c65b2a67-goog


