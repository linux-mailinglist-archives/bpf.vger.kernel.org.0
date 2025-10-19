Return-Path: <bpf+bounces-71312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C616BEEA6F
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27258349122
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 17:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA21FA178;
	Sun, 19 Oct 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SPQxIh1U"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9B1A704B
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760893365; cv=none; b=JHKJsmuSJcXOMgAWSU38c1uFpTvrzNOMrBMLvGvNBmI4imbyEI8K24NYzRndPdSZfX7aBp5DqQl5akDU/dO5EAYBGnKr3TUXo0jReHor4Xch+d1/UkHFSuX9U7TmTZ7OpW3XoWAz+fp7DvR2lDh3jQhPQ+1cqzgsMhKGw2LMVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760893365; c=relaxed/simple;
	bh=/BfyvLc3alET4VUbm8IcEp9DdnDvoMNBCmAfIzP2ToM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnJflQx9W9utzo2/Boxx0387KHxehbOrbFt2EBEmk2xgdO6aRXYZefopvvdX7sDbwLpTso+JjZ6VSIPKxkWJhPknoLE4hfpCRLQWXgLv4FW0IcOtZAJEXvD3UNSPS7KW5NeHO2XAfXy1cTxkvanHBmylb3qMln49HE/LIwfE3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SPQxIh1U; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760893350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx3Mu1f9RcQnyEwI6I+qDuteJEIdnrA8Zyt1Wu+roas=;
	b=SPQxIh1UvsRd6G8rZyl5KnLuw4kAh1Kq/NzKoeeQS6zN/2wICzK/c0e2IZuolami9QiBAJ
	GrmgskCgQs9Z/VvvQ7M0aDYMYW8yKE2XsU+EGHkfaz1NGfJAt7xYRIgxPM+jBVHdfxaR6e
	6Z9xfqL6paVp6ACBc6FjBFcxiI9YIis=
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
Subject: [PATCH bpf-next v3 1/2] perf: Use extern perf_callchain_entry for get_perf_callchain
Date: Mon, 20 Oct 2025 01:01:17 +0800
Message-ID: <20251019170118.2955346-2-chen.dylane@linux.dev>
In-Reply-To: <20251019170118.2955346-1-chen.dylane@linux.dev>
References: <20251019170118.2955346-1-chen.dylane@linux.dev>
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


