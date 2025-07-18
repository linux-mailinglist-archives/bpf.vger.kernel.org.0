Return-Path: <bpf+bounces-63728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24EB0A76C
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 17:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE391C83786
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709962E6D0D;
	Fri, 18 Jul 2025 15:26:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6432E6110;
	Fri, 18 Jul 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852367; cv=none; b=DIIxRE9Ohr/TSJLaNrVeN2D5g4b3jumQvmcYiQhq4AwRuwHt5IG/iQ+T02EkMezTwhWa5wZUooJBRD/viwtTHqGbWNBxoXpxEOSX02aYR0ZTgUJ0SQq6BJ4XCL5BoE+Npqn2eFSjR43wRRBrz8DqEdn+Xu7jz8PFiEcd4PvGnJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852367; c=relaxed/simple;
	bh=1onG4m0Dl1xWJc84rsDl+mHwjSDjdoN9Ilk+1lS2+Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tocYt5cNaup2JaucWnl6MZcYp9z1aUQlTxRlMsGyUjTDs6YMVIQYcTUMzn4bNQUXNnzxwUAdGuEVOhebe5wdd98gsIy9hkCUxi/kXvwj/WwQRwI84UQsfwmOMt6g1DkdwWj9HvX2t8jg41ub11u1Rgi5rNKPkvL26s90Gzh/rvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A216A176C;
	Fri, 18 Jul 2025 08:25:57 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F15073F6A8;
	Fri, 18 Jul 2025 08:26:00 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 18 Jul 2025 16:25:35 +0100
Subject: [PATCH PATCH v2 v2 1/6] perf/core: Make perf_event_aux_pause() as
 external function
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-perf_aux_pause_resume_bpf_rebase-v2-1-992557b8fb16@arm.com>
References: <20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com>
In-Reply-To: <20250718-perf_aux_pause_resume_bpf_rebase-v2-0-992557b8fb16@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 James Clark <james.clark@linaro.org>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752852356; l=1435;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=1onG4m0Dl1xWJc84rsDl+mHwjSDjdoN9Ilk+1lS2+Y8=;
 b=P73godvxPNRdgZiINt2MEVMtcY7vxfpDz3CizKSQd037e1XKwE2BoIYvr+DCcqBQGGtdcQq9/
 BwONfv90fJyDwXbYztPbEAOH9ZR+/hPi+LPuDzNFMRiNua3XUZsDciB
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Expose perf_event_aux_pause() as an external function, this will be used
by BPF kfunc in a sequential change.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d96025683958e909bb2463439dc69634f4ceb..9445c36e9f23e9090c7bf26c8085d2e4f308d38b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1252,6 +1252,7 @@ extern int perf_event_read_local(struct perf_event *event, u64 *value,
 				 u64 *enabled, u64 *running);
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
+extern void perf_event_aux_pause(struct perf_event *event, bool pause);
 
 extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f746469fda58dbc7651184adfd75962932026fb..f0a7e106910058832d0b52da8f1fb44107a57538 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8409,7 +8409,7 @@ static void __perf_event_aux_pause(struct perf_event *event, bool pause)
 	}
 }
 
-static void perf_event_aux_pause(struct perf_event *event, bool pause)
+void perf_event_aux_pause(struct perf_event *event, bool pause)
 {
 	struct perf_buffer *rb;
 

-- 
2.34.1


