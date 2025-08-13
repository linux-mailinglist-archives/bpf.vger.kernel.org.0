Return-Path: <bpf+bounces-65542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF4EB254BD
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 392287A7832
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900012D3EE4;
	Wed, 13 Aug 2025 20:52:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14AA285C90;
	Wed, 13 Aug 2025 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755118369; cv=none; b=a3Kh6d3GQEQWjenCd0qGtU9ZoJG99b5UGTHEz5y9LX4P3wltd30ufnDs2l1Hkj78Kimuk46MBy+D6iOsqKbOCaYc6fIVdUIGkPa2t+dTmqvcwB8Bs1nKttLSHDIOgb8ryVW9uPjKPDCUm8hW+f218q5TjA1mVcZsu/fy8LmLlVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755118369; c=relaxed/simple;
	bh=f40U9cV9+MDtB+YZCj9VQeXm5Xn/ZSS3RxtQLbBNa80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrYhT/EW0equRULoiIrB8m7NHZ2KXwT1nB7+gNHzk5MqK2mGNtKHMaHXa2jX/wfWYBikQV0gkwo1sXg7wfjWJY8lbr6/A1pPDG4NRRGcPlT5nGhhgSX0XvG5pDzCCEexr9IuTTvsiDnIvJvoGidwPkcLHjFOxcfIefsDFA5sCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:c54d:a88a:ec30:aa38])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 4A4B542195;
	Wed, 13 Aug 2025 20:46:14 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:c54d:a88a:ec30:aa38) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
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
Subject: [PATCH bpf-next v4 1/2] bpf: refactor max_depth computation in
 bpf_get_stack()
Date: Wed, 13 Aug 2025 21:46:05 +0100
Message-ID: <20250813204606.167019-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <997d3b8a-4b3a-4720-8fa0-2f91447021bd@linux.dev>
References: <997d3b8a-4b3a-4720-8fa0-2f91447021bd@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175511797516.17216.2619667236383723338@Plesk>
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

Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 kernel/bpf/stackmap.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..b9cc6c72a2a5 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -42,6 +42,27 @@ static inline int stack_map_data_size(struct bpf_map *map)
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
+
+	max_depth = size / elem_size;
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
@@ -406,7 +427,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
-	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
+	u32 trace_nr, copy_len, elem_size, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
 	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
@@ -438,10 +459,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto clear;
 	}
 
-	num_elem = size / elem_size;
-	max_depth = num_elem + skip;
-	if (sysctl_perf_event_max_stack < max_depth)
-		max_depth = sysctl_perf_event_max_stack;
+	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
@@ -461,7 +479,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
-	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
+	trace_nr = min(trace_nr, max_depth - skip);
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.43.0


