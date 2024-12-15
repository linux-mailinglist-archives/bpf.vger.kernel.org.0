Return-Path: <bpf+bounces-47001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F79F25D9
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADAD1885D29
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC81C1F19;
	Sun, 15 Dec 2024 19:35:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509261BE251;
	Sun, 15 Dec 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734291315; cv=none; b=M33f5kkVsD+2qR4qlO05GhioCt7beS4+Z1lDhOyAnlrWm6fOUts/t6ZVtBIAq6rlTwgFgEEXBpUoU5+Bb6gQDjYMS0NzwkvyIlt8CWP0dqpVnb2UEUsSTNh94wC19TAzEoVTGhCOiuHuNShc8HNMkQD8IuwLmbeHhGo8fdZckGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734291315; c=relaxed/simple;
	bh=OEI2Fz2yXqTgdBh5vpHorwKmhmsxHR/gg703j4lqtIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7g0lo7VWJ3zSlE2GUpRWsRWgjaL8wESoLUQHPR9lxNNCpDOx2W+1zvm+2z5/GxsTXOauc23VzS4BfqIU8gx8/HQp8e3QyMwLjcezQEF6/UXL8RtaErlws56MzDzwPNI2Wsf/eJJPRYagNVGKLg7ItdzluP3PhqlQTG22moWxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0FCC168F;
	Sun, 15 Dec 2024 11:35:40 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E4883F528;
	Sun, 15 Dec 2024 11:35:08 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 1/7] perf/core: Make perf_event_aux_pause() as external function
Date: Sun, 15 Dec 2024 19:34:30 +0000
Message-Id: <20241215193436.275278-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215193436.275278-1-leo.yan@arm.com>
References: <20241215193436.275278-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose perf_event_aux_pause() as an external function, this will be used
by eBPF APIs in sequential changes.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 include/linux/perf_event.h | 1 +
 kernel/events/core.c       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index cb99ec8c9e96..890b7ba4a729 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1162,6 +1162,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 			  u64 *enabled, u64 *running);
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
+extern void perf_event_aux_pause(struct perf_event *event, bool pause);
 
 extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 065f9188b44a..8deb356a915e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8032,7 +8032,7 @@ static void __perf_event_aux_pause(struct perf_event *event, bool pause)
 	}
 }
 
-static void perf_event_aux_pause(struct perf_event *event, bool pause)
+void perf_event_aux_pause(struct perf_event *event, bool pause)
 {
 	struct perf_buffer *rb;
 
-- 
2.34.1


