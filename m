Return-Path: <bpf+bounces-65872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FC3B29EEF
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 12:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C18B2A0884
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 10:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260031578D;
	Mon, 18 Aug 2025 10:20:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550882701C3;
	Mon, 18 Aug 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512436; cv=none; b=Go0DY2+uQTglUCIjA2L9GI+Ih0YlmKpFpO0kYL2vax7jDevAnCGWZF4em0dtYPeU7jHgcYA2C7tYUrd+qIDvcJbifaMzAva8GW3pZ2j3JutdHLZWkuTfxsTPmsN3jfZtPhOl4dUfXLCdAelcWZmlSGL5+/XoUzKfZMD2zjn1E1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512436; c=relaxed/simple;
	bh=+XhdQ/6Cv07xh5XJuWky6AAJAqEv9jeFuZbvrkyhrmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmrConCPHoZ0QvDOSw+17TN7p+GxnCEzaHGp2F2o2azGaVrHbE2NrzxpAjW3CkpY67ui1gw+Mj0LnNxDc8M5mVY8O+s+5BzfjtlIquSmal7c83RQSQTc1oShHK63uT6LwYvQIMg26M7NpIAqlR5C6lTeYx8BYubaEA0s57HUr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c57Rd3yS1z9sSd;
	Mon, 18 Aug 2025 11:57:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h80lqdebdhir; Mon, 18 Aug 2025 11:57:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c57Rd3CJwz9sRs;
	Mon, 18 Aug 2025 11:57:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5050A8B764;
	Mon, 18 Aug 2025 11:57:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id tlZNreI0Ep2e; Mon, 18 Aug 2025 11:57:17 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2436D8B763;
	Mon, 18 Aug 2025 11:57:17 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH RESEND] perf: Completely remove possibility to override MAX_NR_CPUS
Date: Mon, 18 Aug 2025 11:57:15 +0200
Message-ID: <b205802edbb6fcc78822f558dff7104e64b29864.1755510867.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755511036; l=1837; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=+XhdQ/6Cv07xh5XJuWky6AAJAqEv9jeFuZbvrkyhrmk=; b=zdPN0IV1SNTGhsT/B/ZD7T275sgUgqXxPLny2G78OqJ6BvMFbf5LABG+tvEdnb5BCwv3d3520 PCs+mIsM2s9DbHVPxqJ5mL+Z3bGQ2YafBB+1s8Vay76lq2zTo774wof
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 21b8732eb447 ("perf tools: Allow overriding MAX_NR_CPUS at
compile time") added the capability to override MAX_NR_CPUS. At
that time it was necessary to reduce the huge amount of RAM used
by static stats variables.

But this has been unnecessary since commit 6a1e2c5c2673 ("perf stat:
Remove a set of shadow stats static variables"), and
commit e8399d34d568 ("libperf cpumap: Hide/reduce scope of
MAX_NR_CPUS") broke the build in that case because it failed to
add the guard around the new definition of MAX_NR_CPUS.

So cleanup things and remove guards completely to officialise it
is not necessary anymore to override MAX_NR_CPUS.

Link: https://lore.kernel.org/all/8c8553387ebf904a9e5a93eaf643cb01164d9fb3.1736188471.git.christophe.leroy@csgroup.eu/
Fixes: e8399d34d568 ("libperf cpumap: Hide/reduce scope of MAX_NR_CPUS")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/perf/perf.h                        | 2 --
 tools/perf/util/bpf_skel/kwork_top.bpf.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 3cb40965549f..e004178472d9 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -2,9 +2,7 @@
 #ifndef _PERF_PERF_H
 #define _PERF_PERF_H
 
-#ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS			4096
-#endif
 
 enum perf_affinity {
 	PERF_AFFINITY_SYS = 0,
diff --git a/tools/perf/util/bpf_skel/kwork_top.bpf.c b/tools/perf/util/bpf_skel/kwork_top.bpf.c
index 73e32e063030..6673386302e2 100644
--- a/tools/perf/util/bpf_skel/kwork_top.bpf.c
+++ b/tools/perf/util/bpf_skel/kwork_top.bpf.c
@@ -18,9 +18,7 @@ enum kwork_class_type {
 };
 
 #define MAX_ENTRIES     102400
-#ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS     4096
-#endif
 #define PF_KTHREAD      0x00200000
 #define MAX_COMMAND_LEN 16
 
-- 
2.49.0


