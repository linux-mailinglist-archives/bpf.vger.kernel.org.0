Return-Path: <bpf+bounces-71588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC05BF795B
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA23421613
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058FE345CDC;
	Tue, 21 Oct 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w5uYFMHO"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B233033B;
	Tue, 21 Oct 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062845; cv=none; b=agcXU1Kts1p+GoqnZUSeNLkycprOTlmfe15z8ZfnLaAwVLptfgJfqVqquttQ6ikCZXVfexOibqUMDn1dY9UeakQMwKKgo8R9aCL0iSVTJncIBhDWKCjV92df5i5h9TnGd4Fn435N2kiuka1jzmwk0F0pNqIPRhzylUYaBxde6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062845; c=relaxed/simple;
	bh=iY9Yb0Gn2Gx4LmXHIlKFgLujqTljqZiHXTOJwPqFXek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAx5H0usOuh+IwNGmOiPbHEqF4pCeWZDJLSTND9IX9lHjTbuMxQ2Zs8oIF4m4JTDP3NIub9+mFXZIR1i8Ylr4c3vIu3p2hkJLMsDhLKStL9fjAs9Y5bqNp69cN2vbDKcSYGxYUd3nIlKgULlLkuyGU3FC+9CBX6Tn8rEyEP+hFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w5uYFMHO; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761062840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f/ceOYFMHO8rupmeTuNBdZk0i8ibDpq4hA/Mx8osgH0=;
	b=w5uYFMHOTKmlHbxaOYhCWyqkI8cAKAvY99nTXx8aZW5iJ/KTAY7VpzsqKirs4UX3yWYWkp
	K0sWgibi7IsLsDTyKluOg0gORACCMrBNTFlgnSsG9dYOH/TpfW4h7awVXUQTSqBHE4FVtM
	oksRDUvsZfQBNN0QrhyDiDi47xSoDp8=
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
Subject: [PATCH bpf-next v4 2/2] bpf: Use per-cpu BPF callchain entry to save callchain
Date: Wed, 22 Oct 2025 00:06:33 +0800
Message-ID: <20251021160633.3046301-3-chen.dylane@linux.dev>
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

As Alexei noted, get_perf_callchain() return values may be reused
if a task is preempted after the BPF program enters migrate disable
mode. Drawing on the per-cpu design of bpf_bprintf_buffers,
per-cpu BPF callchain entry is used here.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 98 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 94e46b7f340..97028d39df1 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -31,6 +31,52 @@ struct bpf_stack_map {
 	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
 };
 
+struct bpf_perf_callchain_entry {
+	u64 nr;
+	u64 ip[PERF_MAX_STACK_DEPTH];
+};
+
+#define MAX_PERF_CALLCHAIN_PREEMPT 3
+static DEFINE_PER_CPU(struct bpf_perf_callchain_entry[MAX_PERF_CALLCHAIN_PREEMPT],
+		      bpf_perf_callchain_entries);
+static DEFINE_PER_CPU(int, bpf_perf_callchain_preempt_cnt);
+
+static int bpf_get_perf_callchain_or_entry(struct perf_callchain_entry **entry,
+					   struct pt_regs *regs, bool kernel,
+					   bool user, u32 max_stack, bool crosstack,
+					   bool add_mark, bool get_callchain)
+{
+	struct bpf_perf_callchain_entry *bpf_entry;
+	struct perf_callchain_entry *perf_entry;
+	int preempt_cnt;
+
+	preempt_cnt = this_cpu_inc_return(bpf_perf_callchain_preempt_cnt);
+	if (WARN_ON_ONCE(preempt_cnt > MAX_PERF_CALLCHAIN_PREEMPT)) {
+		this_cpu_dec(bpf_perf_callchain_preempt_cnt);
+		return -EBUSY;
+	}
+
+	bpf_entry = this_cpu_ptr(&bpf_perf_callchain_entries[preempt_cnt - 1]);
+	if (!get_callchain) {
+		*entry = (struct perf_callchain_entry *)bpf_entry;
+		return 0;
+	}
+
+	perf_entry = get_perf_callchain(regs, (struct perf_callchain_entry *)bpf_entry,
+					kernel, user, max_stack,
+					crosstack, add_mark);
+	*entry = perf_entry;
+
+	return 0;
+}
+
+static void bpf_put_perf_callchain(void)
+{
+	if (WARN_ON_ONCE(this_cpu_read(bpf_perf_callchain_preempt_cnt) == 0))
+		return;
+	this_cpu_dec(bpf_perf_callchain_preempt_cnt);
+}
+
 static inline bool stack_map_use_build_id(struct bpf_map *map)
 {
 	return (map->map_flags & BPF_F_STACK_BUILD_ID);
@@ -192,11 +238,11 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 {
 #ifdef CONFIG_STACKTRACE
 	struct perf_callchain_entry *entry;
-	int rctx;
-
-	entry = get_callchain_entry(&rctx);
+	int ret;
 
-	if (!entry)
+	ret = bpf_get_perf_callchain_or_entry(&entry, NULL, false, false, 0, false, false,
+					      false);
+	if (ret)
 		return NULL;
 
 	entry->nr = stack_trace_save_tsk(task, (unsigned long *)entry->ip,
@@ -216,8 +262,6 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 			to[i] = (u64)(from[i]);
 	}
 
-	put_callchain_entry(rctx);
-
 	return entry;
 #else /* CONFIG_STACKTRACE */
 	return NULL;
@@ -305,6 +349,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
+	int err;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -314,14 +359,15 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
-				   false, false);
+	err = bpf_get_perf_callchain_or_entry(&trace, regs, kernel, user, max_depth,
+					      false, false, true);
+	if (err)
+		return err;
 
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
+	err = __bpf_get_stackid(map, trace, flags);
+	bpf_put_perf_callchain();
 
-	return __bpf_get_stackid(map, trace, flags);
+	return err;
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -443,20 +489,23 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (sysctl_perf_event_max_stack < max_depth)
 		max_depth = sysctl_perf_event_max_stack;
 
-	if (may_fault)
-		rcu_read_lock(); /* need RCU for perf's callchain below */
-
 	if (trace_in)
 		trace = trace_in;
-	else if (kernel && task)
+	else if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
-	else
-		trace = get_perf_callchain(regs, NULL, kernel, user, max_depth,
-					   crosstask, false);
+	} else {
+		err = bpf_get_perf_callchain_or_entry(&trace, regs, kernel, user, max_depth,
+						      false, false, true);
+		if (err)
+			return err;
+	}
+
+	if (unlikely(!trace))
+		goto err_fault;
 
-	if (unlikely(!trace) || trace->nr < skip) {
-		if (may_fault)
-			rcu_read_unlock();
+	if (trace->nr < skip) {
+		if (!trace_in)
+			bpf_put_perf_callchain();
 		goto err_fault;
 	}
 
@@ -475,9 +524,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		memcpy(buf, ips, copy_len);
 	}
 
-	/* trace/ips should not be dereferenced after this point */
-	if (may_fault)
-		rcu_read_unlock();
+	if (!trace_in)
+		bpf_put_perf_callchain();
 
 	if (user_build_id)
 		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
-- 
2.48.1


