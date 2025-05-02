Return-Path: <bpf+bounces-57223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F9BAA7355
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B631218826A0
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B90255252;
	Fri,  2 May 2025 13:20:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC21DDAB;
	Fri,  2 May 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192037; cv=none; b=TCIKa0A5L/J5smoDpGhmxJLIGuDMopDvjdh7Rs8Oihc7bJ1RwQ4LgL79ESjhBC6mgImeHReM3ufUiqVwhMZvcBaNP9R8Dm8Ia0kMIl6IqDS14c9wEC++OOfA3/c1NIMNAKugtgKH29zcx54VcpCoQ5QdUP369IQP+1qeJvB1ojc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192037; c=relaxed/simple;
	bh=U6urzpE91xdUZF2TxiVY8gAIcNB1QAGPhG01RWYs0Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OqxvLa1DW/mJoio8qJg/PtyGTcUj7eBSUREF9bPBnp+5vyXGMADYlUFN2RbUFFh5p7QhFOlqSih7sbZasf96OxSGVchuhFMDrT2MWKM8TE7SJ1vBT/uE3IN97BXQNNi3f138emHP5F6RZqMIQxAhxpX/EgeKTU6U19PZXR5b0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Zprfq673lz9s36;
	Fri,  2 May 2025 15:02:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bu1Itk0akfuE; Fri,  2 May 2025 15:02:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Zprfq5Q81z9s2l;
	Fri,  2 May 2025 15:02:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B27598B765;
	Fri,  2 May 2025 15:02:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ifS9dlAYK1bu; Fri,  2 May 2025 15:02:11 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C68E8B763;
	Fri,  2 May 2025 15:02:11 +0200 (CEST)
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
Subject: [PATCH] perf: Completely remove possibility to override MAX_NR_CPUS
Date: Fri,  2 May 2025 15:02:02 +0200
Message-ID: <bfa19c0a3a40d10a053a2c7d3219eee2098e3b38.1746190831.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746190923; l=1837; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=U6urzpE91xdUZF2TxiVY8gAIcNB1QAGPhG01RWYs0Mg=; b=AbOUqnFYBy/JIKaV6NPiEHKBx4D/iZtblMJLv+s4PQBQBiCEaWHpczStEz79pf2M6XeENOMBg H7RI8hx/LgpAV7EYtjQqjWWCiORDG/TzKjvtEYyDAqv87WdkNM5buYN
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
2.47.0


