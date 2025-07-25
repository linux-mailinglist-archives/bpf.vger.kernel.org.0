Return-Path: <bpf+bounces-64341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D12B11B5F
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED0A7B9E1E
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8402A2D542B;
	Fri, 25 Jul 2025 09:59:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A82D46D3;
	Fri, 25 Jul 2025 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437574; cv=none; b=lseyRK6Cdj/wF5EiZ0KIZCyknh8MUtw5NL+LLLbWj5IhyUp+0TBngsNdpBZFuuIgeFq8ewEDpQzsP5I6WlEq9/Etvrytk0zjLbdR9QEUw/d8oxvMN+qi6s0dM47rC6dV9VNqk0aGCSaBkd83JM10mwcquwE4yc7+x5Mx8EnYqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437574; c=relaxed/simple;
	bh=5VhjTk5cRVzoBPnaiyr/CQD1RNUacBsxaN4yCOc1nkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PsjyRgF/VlJ7SIefR/V7/Xgz995xdxzAFwG1lPBqy2eMgiqDk04m2EB8aAHOdje+Noq8oWXrtqN02szXc/ImLG4zM6U7KDNpf+PDWbs2sXSk23OK71xJcAJqRF0WNJt6wqnVuSv3Lbx2RU14xGQIdgoKguj3oToZlKGyXw5cRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8212F1A00;
	Fri, 25 Jul 2025 02:59:25 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 470893F5A1;
	Fri, 25 Jul 2025 02:59:28 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 25 Jul 2025 10:59:10 +0100
Subject: [PATCH PATCH v2 v3 1/6] perf/core: Make perf_event_aux_pause() as
 external function
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-perf_aux_pause_resume_bpf_rebase-v3-1-9fc84c0f4b3a@arm.com>
References: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
In-Reply-To: <20250725-perf_aux_pause_resume_bpf_rebase-v3-0-9fc84c0f4b3a@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753437563; l=1435;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=5VhjTk5cRVzoBPnaiyr/CQD1RNUacBsxaN4yCOc1nkQ=;
 b=kiSNU+vHB6WnZWaJiag6LSxlH9NMwCoNT5UcP6qc4w3S3mLtZKYI5uCvrqY47N6X2Grw2h4VV
 zDWbahm5T4qALFz6lGjGec5rtpp+kEZ6uGkaSNBrbvhyoYH6QryZ+dN
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
index 22fdf0c187cd970f59ad8d6de9c1b231f68ec2cb..75c194007ace911e6f91a27738c04dd0840bb3fb 100644
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


