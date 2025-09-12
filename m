Return-Path: <bpf+bounces-68280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6C4B55A70
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 01:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226A7177D19
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB228469E;
	Fri, 12 Sep 2025 23:40:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32426D4EF;
	Fri, 12 Sep 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720411; cv=none; b=ZJapoUq67s0LH56HuarRimlrQ4xMqaOQQmpSYoiQ9mckwsSv240Sv5SmAZykSAkoAQe7ZSo9uf1kcTwuRnO2+dxtNRqJ5iBNk+8Tky3W6u0A4Q9p/dHgqT2HxgmhPVq9+G7Co2ptE6gb1kRXOeg6X3CZmftw+eppQDO2Eqc1plI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720411; c=relaxed/simple;
	bh=ALrO9M8gBNByn8rkQ0DpqNVGoyHxIJFif9e88v21F7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTEXKgoiETZmPB+J1Jnuvo8ceociJ0QTd8VgYTPJuwtVgRdOM/bVxu1GRdj2asxVXkqR61jPIdz3VdA2MjuzKI3pYDfG1yjyJ7qI+eQMWkdIOyaKg9uLIKfQQM8y6MxqDd0FVs3XTUhoWWTq7n7YHtLu34Rjekp1++F54he3ZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:186b:e316:24ee:afec])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 656424022C;
	Fri, 12 Sep 2025 23:34:16 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:186b:e316:24ee:afec) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
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
	contact@arnaud-lcm.com
Subject: [PATCH bpf-next v9 1/3] bpf: refactor max_depth computation in
 bpf_get_stack()
Date: Sat, 13 Sep 2025 00:34:09 +0100
Message-ID: <20250912233409.74900-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175772005728.2166.1193317056877954951@Plesk>
X-PPP-Vhost: arnaud-lcm.com

A new helper function stack_map_calculate_max_depth() that
computes the max depth for a stackmap.

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
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

Changes in v7:
 - Removed additional cleanup from v6

Changes in v9:
 - Fixed incorrect removal of num_elem in get stack

Link to v8: https://lore.kernel.org/all/20250905134625.26531-1-contact@arnaud-lcm.com/
---
---
 kernel/bpf/stackmap.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..a794e04f5ae9 100644
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
 
@@ -406,7 +425,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
-	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
+	u32 trace_nr, copy_len, elem_size, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
 	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
@@ -438,10 +457,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto clear;
 	}
 
-	num_elem = size / elem_size;
-	max_depth = num_elem + skip;
-	if (sysctl_perf_event_max_stack < max_depth)
-		max_depth = sysctl_perf_event_max_stack;
+	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
@@ -461,7 +477,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
-	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.43.0


