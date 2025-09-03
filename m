Return-Path: <bpf+bounces-67291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC47B42280
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE69B3B01F5
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B730DD30;
	Wed,  3 Sep 2025 13:53:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2A2EC570;
	Wed,  3 Sep 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907610; cv=none; b=JcDYMURjY+fFAC2eXhOadyJ9ZZYZZhkEAY1L/IpZ/MqvTYD2eiFj6Hq5HLLzbFxlWnawQ6Prp1ve9rDu+LnsicCMrGe8yRrbprg0TEU5V0U8zZMjUoiEjzVqedNQbOBfI1lqgpMcZS6M1vwaM7YyCeMgVongkCC+O5Lq93skNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907610; c=relaxed/simple;
	bh=lsfdW4D9gXb/VXmAPKoFZQs/ypqu6RtwOHYa6Kd2x/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o5lVLHRDgaG+EDDaDzOMukkB3jXWQNP9RP7BEht1w0Se0hOeVuxWkZxE94b5tHVuDpbxsOsylw4rRGZQJizY1889C8tt7Nb0RDSdLDzsoBDjbO5LHLyN/Ui8ekuDKtnntPEW52Ysavl+aHfBcdFpy5ImCtlbl4blJ+n66dyBc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34ddaca59.ant.amazon.com (unknown [IPv6:2a01:e0a:3e8:c0d0:f888:35a:53a4:66b4])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id D6B88405A2;
	Wed,  3 Sep 2025 13:53:25 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a01:e0a:3e8:c0d0:f888:35a:53a4:66b4) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=7cf34ddaca59.ant.amazon.com
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: alexei.starovoitov@gmail.com,
	yonghong.song@linux.dev,
	song@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCH bpf-next v6 1/2] bpf: refactor max_depth computation in
 bpf_get_stack()
Date: Wed,  3 Sep 2025 15:53:23 +0200
Message-Id: <20250903135323.97847-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250903135222.97604-1-contact@arnaud-lcm.com>
References: <20250903135222.97604-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175690760649.28174.2302454827272099020@Plesk>
X-PPP-Vhost: arnaud-lcm.com

A new helper function stack_map_calculate_max_depth() that
computes the max depth for a stackmap.

Changes in v2:
 - Removed the checking 'map_size % map_elem_size' from
   stack_map_calculate_max_depth
 - Changed stack_map_calculate_max_depth params name to be more generic

Changes in v3:
 - Changed map size param to size in max depth helper

Changes in v4:
 - Fixed indentation in max depth helper for args

Changes in v5:
 - Bound back trace_nr to num_elem in __bpf_get_stack
 - Make a copy of sysctl_perf_event_max_stack
   in stack_map_calculate_max_depth

Changes in v6:
 - Restrained max_depth computation only when required
 - Additional cleanup from Song in __bpf_get_stack

Link to v5: https://lore.kernel.org/all/20250826212229.143230-1-contact@arnaud-lcm.com/

Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Cc: Song Lui <song@kernel.org>
---
 kernel/bpf/stackmap.c | 58 ++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..1ebc525b7c2f 100644
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
@@ -300,20 +322,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
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
 
@@ -350,6 +369,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 {
 	struct perf_event *event = ctx->event;
 	struct perf_callchain_entry *trace;
+	u32 elem_size, max_depth;
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
@@ -371,11 +391,14 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
+	elem_size = stack_map_data_size(map);
 
 	if (kernel) {
 		__u64 nr = trace->nr;
 
-		trace->nr = nr_kernel;
+		max_depth =
+			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		trace->nr = min_t(u32, nr_kernel, max_depth);
 		ret = __bpf_get_stackid(map, trace, flags);
 
 		/* restore nr */
@@ -388,6 +411,9 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
+		max_depth =
+			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		trace->nr = min_t(u32, trace->nr, max_depth);
 		ret = __bpf_get_stackid(map, trace, flags);
 	}
 	return ret;
@@ -406,8 +432,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
-	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
+	u32 trace_nr, copy_len, elem_size, max_depth;
 	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
 	bool user = flags & BPF_F_USER_STACK;
@@ -438,21 +464,20 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
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
-					   crosstask, false);
+			crosstask, false);
+	}
 
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
@@ -461,7 +486,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
-	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.47.3

