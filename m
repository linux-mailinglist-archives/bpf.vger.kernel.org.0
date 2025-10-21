Return-Path: <bpf+bounces-71587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEF6BF794F
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628BB405EC4
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAE3431F5;
	Tue, 21 Oct 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wpw5QU7a"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFAA341AC1
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062830; cv=none; b=V3A4jth1cFh/Wr0Tg77OSQ7VfFNKgUkuLpjpoJNFA1Ed2iCQZLR3ot0zx/tnZOumKRyrxZuSaCSjk0IMxF2yC6u17vfpOEm6i2D/GmSoN3XiYCpr9Rs5dwpISNA9sslKVLIV69NS4S6x/DrHD8eH/wnPKcfNgIWjkiffub2sssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062830; c=relaxed/simple;
	bh=/BfyvLc3alET4VUbm8IcEp9DdnDvoMNBCmAfIzP2ToM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtHsXxXcsI0N6pgcV4i1N7jkqCZsnZnUp6OF0YoXO7zlcIeWyaLyJSymH014BPQvT4xrrtyAGzsm6d396QsRlSW3gPFRAp/RQffPsw88BQMN7j2ti6MDQaE/bagQGzYDlEv+RmEM+Ml0yVmrVdfEzgZAM8Wo+gfEdOVJvrMvxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wpw5QU7a; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761062825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx3Mu1f9RcQnyEwI6I+qDuteJEIdnrA8Zyt1Wu+roas=;
	b=wpw5QU7auhont3DE94eD3Lc/11dQx6XQgINlzNT2fQuKRzmQkAY1bUpygOG4ZtrQBYc9xu
	YVl4vuej6mk500AhDWlE0ZWlSa7ta8Hfc6u3sqQLjV0eRzcLpkspva2uby0Sig9fyIv79c
	B+genqXj8jZcr4WG5/WssaeBTSBhdvU=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v4 1/2] perf: Use extern perf_callchain_entry for get_perf_callchain
Date: Wed, 22 Oct 2025 00:06:32 +0800
Message-ID: <20251021160633.3046301-2-chen.dylane@linux.dev>
In-Reply-To: <20251021160633.3046301-1-chen.dylane@linux.dev>
References: <20251021160633.3046301-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From bpf stack map, we want to use our own buffers to avoid unnecessary
copy, so let us pass it directly. BPF will use this in the next patch.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/perf_event.h |  4 ++--
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 13 +++++++++----
 kernel/events/core.c       |  2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b9..b144da7d803 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1719,8 +1719,8 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry *external_entry,
+		   bool kernel, bool user, u32 max_stack, bool crosstask, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 4d53cdd1374..94e46b7f340 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,7 +314,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
+	trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
 				   false, false);
 
 	if (unlikely(!trace))
@@ -451,7 +451,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, kernel, user, max_depth,
+		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
 					   crosstask, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 808c0d7a31f..851e8f9d026 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,8 +217,8 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry *external_entry,
+		   bool kernel, bool user, u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -228,7 +228,11 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	if (crosstask && user && !kernel)
 		return NULL;
 
-	entry = get_callchain_entry(&rctx);
+	if (external_entry)
+		entry = external_entry;
+	else
+		entry = get_callchain_entry(&rctx);
+
 	if (!entry)
 		return NULL;
 
@@ -260,7 +264,8 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 	}
 
 exit_put:
-	put_callchain_entry(rctx);
+	if (!external_entry)
+		put_callchain_entry(rctx);
 
 	return entry;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7541f6f85fc..5d8e146003a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8217,7 +8217,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user,
+	callchain = get_perf_callchain(regs, NULL, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }
-- 
2.48.1


