Return-Path: <bpf+bounces-67443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA4B43E3F
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAC5A41028
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B17308F17;
	Thu,  4 Sep 2025 14:11:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC56307AF9;
	Thu,  4 Sep 2025 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995088; cv=none; b=U5xXYMBbUNXv05UhwGvhsttz9ljOwJH0dZyLIgACrp9KDDM1sim3Hi6+yNgHFqAddGpBPS/wu+B3s4gL9mnqJcbkyFZPzRk0hST2AlKoaj1c0RL7SRQMJ1H6fT6s5pfeNDa6gKIm5gNetO8ITyVwtoc9FRtAspQFAu1ii0rpY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995088; c=relaxed/simple;
	bh=fzCPTNn8nu0FtclJsY7lvQPxusay7GTZ07NEl3wxy08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KU+6Pzfsp8Xx++cS7ucySwlAKYDOYSYZ0AF/Iz+j+IJ5lmL329N0sNrmc8BjkiU00e09jmg8nAen/l7oFvIvTqb78ZDR0aPWl7KSGMtr+Rb6otjsysRcvGM886rNv3Kvq2e4X7O4QIUmVOJW6NigbHjqjcONzOtuuBEkYb5apNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34ddaca59.ant.amazon.com (unknown [IPv6:2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id A16AF41E6B;
	Thu,  4 Sep 2025 14:11:17 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a01:e0a:3e8:c0d0:74c4:9b58:271e:cbdf) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=7cf34ddaca59.ant.amazon.com
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: syztest
Date: Thu,  4 Sep 2025 16:11:13 +0200
Message-Id: <20250904141113.40660-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <6887e3c8.a00a0220.b12ec.00ad.GAE@google.com>
References: <6887e3c8.a00a0220.b12ec.00ad.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175699507802.11890.12523896466965428946@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..1389712bc1df 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -42,6 +42,28 @@ static inline int stack_map_data_size(struct bpf_map *map)
 		sizeof(struct bpf_stack_build_id) : sizeof(u64);
 }
 
+/**
+ * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
+ * @size:  Size of the buffer/map value in bytes
+ * @elem_size:  Size of each stack trace element
+ * @flags:  BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)
+ *
+ * Return: Maximum number of stack trace entries that can be safely stored
+ */
+static u32 stack_map_calculate_max_depth(u32 size, u32 elem_size, u64 flags)
+{
+	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
+	u32 max_depth;
+	u32 curr_sysctl_max_stack = READ_ONCE(sysctl_perf_event_max_stack);
+
+	max_depth = size / elem_size;
+	max_depth += skip;
+	if (max_depth > curr_sysctl_max_stack)
+		return curr_sysctl_max_stack;
+
+	return max_depth;
+}
+
 static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
 {
 	u64 elem_size = sizeof(struct stack_map_bucket) +
@@ -300,22 +322,20 @@ static long __bpf_get_stackid(struct bpf_map *map,
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags)
 {
-	u32 max_depth = map->value_size / stack_map_data_size(map);
-	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
+	u32 elem_size = stack_map_data_size(map);
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
+	u32 max_depth;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
 		return -EINVAL;
 
-	max_depth += skip;
-	if (max_depth > sysctl_perf_event_max_stack)
-		max_depth = sysctl_perf_event_max_stack;
-
+	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
 	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
 				   false, false);
+	trace->nr = min_t(u32, trace->nr, max_depth);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -350,6 +370,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 {
 	struct perf_event *event = ctx->event;
 	struct perf_callchain_entry *trace;
+	u32 elem_size, max_depth;
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
@@ -371,11 +392,15 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
+	elem_size = stack_map_data_size(map);
 
 	if (kernel) {
 		__u64 nr = trace->nr;
 
 		trace->nr = nr_kernel;
+		max_depth =
+			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		trace->nr = min_t(u32, nr_kernel, max_depth);
 		ret = __bpf_get_stackid(map, trace, flags);
 
 		/* restore nr */
@@ -388,6 +413,9 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
+		max_depth =
+			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		trace->nr = min_t(u32, trace->nr, max_depth);
 		ret = __bpf_get_stackid(map, trace, flags);
 	}
 	return ret;
@@ -406,8 +434,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
-	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
+	u32 trace_nr, copy_len, elem_size, max_depth;
 	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
@@ -438,21 +466,20 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto clear;
 	}
 
-	num_elem = size / elem_size;
-	max_depth = num_elem + skip;
-	if (sysctl_perf_event_max_stack < max_depth)
-		max_depth = sysctl_perf_event_max_stack;
+	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
 
-	if (trace_in)
+	if (trace_in) {
 		trace = trace_in;
-	else if (kernel && task)
+		trace->nr = min_t(u32, trace->nr, max_depth);
+	} else if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
-	else
+	} else {
 		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
 					   crosstask, false);
+	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
@@ -461,7 +488,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
-	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.47.3


