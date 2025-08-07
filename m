Return-Path: <bpf+bounces-65226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C049B1DCA4
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B5C3AF03C
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C881F8677;
	Thu,  7 Aug 2025 17:51:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE043146;
	Thu,  7 Aug 2025 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589060; cv=none; b=mPiF4kUdpYnBQQcdTQjfdkMevONXxbVmCvF3lXX96AHTsnSMZjv3h362VegaFltF5lWQVi42pvh8RvTleT4xiyKln/P9TWu5wRzY5O2tNfox71iG6XvB7bC6owdyuxC2uvW5/UkoQTp9K1m+mduWB8qozKJI8wkCKnt+wxthkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589060; c=relaxed/simple;
	bh=1o0vrAIQ1W715Aw5aPOYj6eRINnrgXR0qNF+4qLde/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwB8Wwwnt25sREAVGtxBOh/kxBai3M2msRmk+1DKgUSVAW+n31hDdO9Pk5K0fTfx4LuZkfNrYCVd2Xlw4kFWdOKtOy0t1ZWD71SpYHPE1hOGrf0egYzIqUyAelPcXlIiEBGJH9NGyoiWwRkCY0Qsd04PcAidYgH6gmylVv8gAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:ce11:d0e1:e548:b0a5])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 5B51A41E1A;
	Thu,  7 Aug 2025 17:50:49 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:ce11:d0e1:e548:b0a5) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: yonghong.song@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	contact@arnaud-lcm.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH 1/2] bpf: refactor max_depth computation in bpf_get_stack()
Date: Thu,  7 Aug 2025 18:50:32 +0100
Message-ID: <20250807175032.7381-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6cc26e1f-6ad6-44cd-a049-c4e7af9a229a@linux.dev>
References: <6cc26e1f-6ad6-44cd-a049-c4e7af9a229a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175458905029.16977.15328068061933544080@Plesk>
X-PPP-Vhost: arnaud-lcm.com

A new helper function stack_map_calculate_max_depth() that
computes the max depth for a stackmap.

Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 kernel/bpf/stackmap.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..14e034045310 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -42,6 +42,31 @@ static inline int stack_map_data_size(struct bpf_map *map)
 		sizeof(struct bpf_stack_build_id) : sizeof(u64);
 }
 
+/**
+ * stack_map_calculate_max_depth - Calculate maximum allowed stack trace depth
+ * @map_size:        Size of the buffer/map value in bytes
+ * @elem_size:       Size of each stack trace element
+ * @map_flags:       BPF stack trace flags (BPF_F_USER_STACK, BPF_F_USER_BUILD_ID, ...)
+ *
+ * Return: Maximum number of stack trace entries that can be safely stored,
+ * or -EINVAL if size is not a multiple of elem_size
+ */
+static u32 stack_map_calculate_max_depth(u32 map_size, u32 map_elem_size, u64 map_flags)
+{
+	u32 max_depth;
+	u32 skip = map_flags & BPF_F_SKIP_FIELD_MASK;
+
+	if (unlikely(map_size%map_elem_size))
+		return -EINVAL;
+
+	max_depth = map_size / map_elem_size;
+	max_depth += skip;
+	if (max_depth > sysctl_perf_event_max_stack)
+		return sysctl_perf_event_max_stack;
+
+	return max_depth;
+}
+
 static int prealloc_elems_and_freelist(struct bpf_stack_map *smap)
 {
 	u64 elem_size = sizeof(struct stack_map_bucket) +
@@ -406,7 +431,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
-	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
+	u32 trace_nr, copy_len, elem_size, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
 	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
@@ -423,8 +448,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto clear;
 
 	elem_size = user_build_id ? sizeof(struct bpf_stack_build_id) : sizeof(u64);
-	if (unlikely(size % elem_size))
-		goto clear;
 
 	/* cannot get valid user stack for task without user_mode regs */
 	if (task && user && !user_mode(regs))
@@ -438,10 +461,9 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto clear;
 	}
 
-	num_elem = size / elem_size;
-	max_depth = num_elem + skip;
-	if (sysctl_perf_event_max_stack < max_depth)
-		max_depth = sysctl_perf_event_max_stack;
+	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
+	if (max_depth < 0)
+		goto err_fault;
 
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
@@ -461,7 +483,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
-	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
+	trace_nr = min(trace_nr, max_depth - skip);
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.43.0


