Return-Path: <bpf+bounces-58344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBECAAB8E93
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EEF51BC6EE1
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C3325B68A;
	Thu, 15 May 2025 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1x5q2g9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372831361;
	Thu, 15 May 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332645; cv=none; b=r9TVur2Zt+s/J58wGHJeE2J+d8comb38DVax8g64w/irXINnbHHVLuU4BZYFJXkXHutfKF1T54aUy89NVOTsM7yXe3fPkHLCRXVsenu9dyEb5AlyN7gnVpeLxcb4ZhyqVyBumKX8Zn6mVLVHIPAXYy8M8qYA4kvk2Oa+30klzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332645; c=relaxed/simple;
	bh=zJQj8G/+NXrzMSLETEU+MnzqI5BBDPNb1qPfB81NR+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TwLqvrbPVXkxFaThu6abcKzHy94RjnaGw7adMa9AHAnH1zf+7UdtBJf6HFxpnF7/xvMLsJaeJXrufaoBW5CLKKGOcGOjve17la37QZeYYijzW2OxYcrOc9UtK+oq7fWG8mz57rRIljvZs4LDz3EBUr1S8nboPE2BhGgbgBs2Wm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1x5q2g9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F2BC4CEE7;
	Thu, 15 May 2025 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747332643;
	bh=zJQj8G/+NXrzMSLETEU+MnzqI5BBDPNb1qPfB81NR+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=K1x5q2g9reAR0SV/6O0cv5yTC9oJQ4XogjCSfRoOHkB5/+Lbos4BOCv0mDcaRWjEs
	 Ozspfq8YNArveEsD/tWaZ0hgpP6MxOSpKt5zn/ea3e8LMaB49/Pg3jqkIEQKxHBQ9I
	 FaBY0T64y3PKdphIavtlKqLPDrDul5YWtwe0choz3oM1bpi5dlJHePFFWrmncLt4EP
	 k7/xgVDZFX29Qzj9Kl32wDo5YdjqBzir5Ozoc87a9ZLA421/Uk66STLpafhISPUy+e
	 R/Q3Kc4yb9SM1v6E1TgJrJMwd2a18S7EMFUUXJO7FW4Rdv4B8oZbTbFnpCoNWlY9rr
	 Sg9J+0EPn7HuQ==
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
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH] perf lock contention: Reject more than 10ms delays for safety
Date: Thu, 15 May 2025 11:10:42 -0700
Message-ID: <20250515181042.555189-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delaying kernel operations can be dangerous and the kernel may kill
(non-sleepable) BPF programs running for long in the future.

Limit the max delay to 10ms and update the document about it.

  $ sudo ./perf lock con -abl -J 100000us@cgroup_mutex true
  lock delay is too long: 100000us (> 10ms)

   Usage: perf lock contention [<options>]

      -J, --inject-delay <TIME@FUNC>
                            Inject delays to specific locks

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-lock.txt | 8 ++++++--
 tools/perf/builtin-lock.c              | 5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-lock.txt b/tools/perf/Documentation/perf-lock.txt
index 2d9aecf630422aa6..c17b3e318169f9dc 100644
--- a/tools/perf/Documentation/perf-lock.txt
+++ b/tools/perf/Documentation/perf-lock.txt
@@ -224,8 +224,12 @@ CONTENTION OPTIONS
 	only with -b/--use-bpf.
 
 	The 'time' is specified in nsec but it can have a unit suffix.  Available
-	units are "ms" and "us".  Note that it will busy-wait after it gets the
-	lock.  Please use it at your own risk.
+	units are "ms", "us" and "ns".  Currently it accepts up to 10ms of delays
+	for safety reasons.
+
+	Note that it will busy-wait after it gets the lock. Delaying locks can
+	have significant consequences including potential kernel crashes.  Please
+	use it at your own risk.
 
 
 SEE ALSO
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 41f6f3d2b779b986..3b3ade7a39cad01f 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2537,6 +2537,11 @@ static bool add_lock_delay(char *spec)
 		return false;
 	}
 
+	if (duration > 10 * 1000 * 1000) {
+		pr_err("lock delay is too long: %s (> 10ms)\n", spec);
+		return false;
+	}
+
 	tmp = realloc(delays, (nr_delays + 1) * sizeof(*delays));
 	if (tmp == NULL) {
 		pr_err("Memory allocation failure\n");
-- 
2.49.0.1101.gccaa498523-goog


