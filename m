Return-Path: <bpf+bounces-53431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 188FDA53E79
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 00:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502C6169FC6
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 23:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36822066F0;
	Wed,  5 Mar 2025 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMOILR0s"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634DD1FECA7;
	Wed,  5 Mar 2025 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217320; cv=none; b=CU49l2QQc3tf+wyiAzF+wz8aQPQzHzLOU/vwoRSAovg4WqS0VnFuE7YyIj6deZELiGbYbX9xAZV1Alh8grthimxiUieIf2AXOmRHoBNm+364ebKfEoYgJJcvI2zx8bis1eRRz/+X1Oakb2vf13qISkD3doRvZAdhW764wi13dKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217320; c=relaxed/simple;
	bh=1DSYQ1qZXldUi2D2+oqIa5YOVp9kOpDYGcyXzcj4LTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=de1G8J3xJFmaKwSOcaIQjnsI5xuSCxH7RpkjyDQ9RrdoPTf1k1scoQSopyMu1PVUysLW4+/mNI9/ZO+87CJCZArf5qK7NMN2NaDNamrcYnsvJwfJpbM+ZUURBW2euZoucViwNsxmKHjGQjezUte5bQGzoXEii2WAQ9r9QsABY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMOILR0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7BFC4CED1;
	Wed,  5 Mar 2025 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741217319;
	bh=1DSYQ1qZXldUi2D2+oqIa5YOVp9kOpDYGcyXzcj4LTE=;
	h=From:To:Cc:Subject:Date:From;
	b=sMOILR0soOcsJJbs+/W1K9vRnlqUvbY18rWHkUykwolAjn7D2hbma519YgkqRGgRM
	 Zv6JGTImP+p170EyoGmkpmtr2Bhc/c3srilEDq/V5p4wmzR6d9cncHosZ2EIzHu/vI
	 YVwj9OZQIBXagjtlzhzNgrMEG6PHzKJjI23QCWJsec62A4iPsz823MYMg33Km0QRIB
	 AGRhB9gs5NL/vrt5DR76EOzv/Uu9PViLEVxGnLmcAUqOF5bpb8bVgzlE+vcB/+FrU4
	 rp5ZALBkRpHtbfcBaJ64JaUk3rU6LRGPSDoYIxO3U2NDL3C83p2b2Xqp6RFVWf401y
	 BoT6qiZyqgTyA==
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
	Kevin Nomura <nomurak@google.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH] perf report: Do not process non-JIT BPF ksymbol events
Date: Wed,  5 Mar 2025 15:28:38 -0800
Message-ID: <20250305232838.128692-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length of PERF_RECORD_KSYMBOL for BPF is a size of JITed code so
it'd be 0 when it's not JITed.  The ksymbol is needed to symbolize the
code when it gets samples in the region but non-JITed code cannot get
samples.  Thus it'd be ok to ignore them.

Actually it caused a performance issue in the perf tools on old ARM
kernels where it can refuse to JIT some BPF codes.  It ended up
splitting the existing kernel map (kallsyms).  And later lookup for a
kernel symbol would create a new kernel map from kallsyms and then
split it again and again. :(

Probably there's a bug in the kernel map/symbol handling in perf tools.
But I think we need to fix this anyway.

Reported-by: Kevin Nomura <nomurak@google.com>
Cc: Song Liu <song@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3f1faf94198dbe56..c7d27384f0736408 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -779,6 +779,10 @@ int machine__process_ksymbol(struct machine *machine __maybe_unused,
 	if (dump_trace)
 		perf_event__fprintf_ksymbol(event, stdout);
 
+	/* no need to process non-JIT BPF as it cannot get samples */
+	if (event->ksymbol.len == 0)
+		return 0;
+
 	if (event->ksymbol.flags & PERF_RECORD_KSYMBOL_FLAGS_UNREGISTER)
 		return machine__process_ksymbol_unregister(machine, event,
 							   sample);
-- 
2.48.1.711.g2feabab25a-goog


