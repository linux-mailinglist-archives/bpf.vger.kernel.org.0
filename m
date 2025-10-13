Return-Path: <bpf+bounces-70832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1774EBD597B
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 19:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 062C04E944C
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23202D3733;
	Mon, 13 Oct 2025 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dqog44Hl"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E93C213E9C
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377700; cv=none; b=pOdeGYWQqtWbS1KBuv1bqANdZcZX/4jgjyglTnN5rFFVEYsS70W8Yuo1FsK49alODO3iX+JauOZ3QzwmB4Z1B2+vKeiUfDn6Fq1UAl4gyRADamc6UslG055vYkDIUCNBFjfBwHDWhofzt6gTcyxbgJ0RoG6Ltfv/XDh6Dlw+0RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377700; c=relaxed/simple;
	bh=U0voQM2oYnf6STeO6/rk9aLxKnrO1RiaTGJ/8zUau1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7G4cxLDl+I96aEHqzzN5RjLmwUt9xaQhRtYBXXf6JycGnRHhQrdVzdv3e0A1V0ipBFG9yi971g7Pyi1T6RenjP0OE7aS4wd5SeVQ9LZcDtoM0UnaOiGU3waKKUGx+ZOgGbGv1+kd6RiP6w9WJm+0db1bjlDo7A8Sl/Sa391lAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dqog44Hl; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760377696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFSgpLJ9oy5bTPXjycAjjR+uiZnaDlBjDtnbne3KHWA=;
	b=dqog44HlD/xi4SmzgPayoGAyNglOXEbXHUVvDjSrKnNlF3zG9OY+/PnBjRu+tI5R08bv9L
	9qo8QWSiIBxn8QVr5br7rI2wp/EfK/WDxBe87TvPgk/V9vehAAux3m0Izgp2PxAQJgot8B
	Aw2WZP8/zaM7h7tp6DhqHswK/xTC768=
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
Subject: [PATCH bpf-next RFC 1/2] perf: Use extern perf_callchain_entry for get_perf_callchain
Date: Tue, 14 Oct 2025 01:47:20 +0800
Message-ID: <20251013174721.2681091-2-chen.dylane@linux.dev>
In-Reply-To: <20251013174721.2681091-1-chen.dylane@linux.dev>
References: <20251013174721.2681091-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From bpf stack map, we want to use our own buffers to avoid unnecessary copy,
so let us pass it directly.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/perf_event.h |  5 +++--
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 18 ++++++++++++------
 kernel/events/core.c       |  2 +-
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d9602568..ca69ad2723c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1719,8 +1719,9 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry *external_entry,
+		   u32 init_nr, bool kernel, bool user, u32 max_stack, bool crosstask,
+		   bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2e182a3ac4c..e6e40f22826 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -314,7 +314,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+	trace = get_perf_callchain(regs, NULL, 0, kernel, user, max_depth,
 				   false, false);
 
 	if (unlikely(!trace))
@@ -451,7 +451,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+		trace = get_perf_callchain(regs, NULL, 0, kernel, user, max_depth,
 					   crosstask, false);
 
 	if (unlikely(!trace) || trace->nr < skip) {
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 6c83ad674d0..fe5d2d58deb 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -217,16 +217,21 @@ static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entr
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry *external_entry,
+		   u32 init_nr, bool kernel, bool user, u32 max_stack, bool crosstask,
+		   bool add_mark)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
 	int rctx, start_entry_idx;
 
-	entry = get_callchain_entry(&rctx);
-	if (!entry)
-		return NULL;
+	if (external_entry) {
+		entry = external_entry;
+	} else {
+		entry = get_callchain_entry(&rctx);
+		if (!entry)
+			return NULL;
+	}
 
 	ctx.entry     = entry;
 	ctx.max_stack = max_stack;
@@ -262,7 +267,8 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	}
 
 exit_put:
-	put_callchain_entry(rctx);
+	if (!external_entry)
+		put_callchain_entry(rctx);
 
 	return entry;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1d354778dcd..08ce44db18f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8204,7 +8204,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, 0, kernel, user,
+	callchain = get_perf_callchain(regs, NULL, 0, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }
-- 
2.48.1


