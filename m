Return-Path: <bpf+bounces-65227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE2B1DCAA
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 19:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AC93ACAEE
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775651F8677;
	Thu,  7 Aug 2025 17:53:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB2A43146;
	Thu,  7 Aug 2025 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589189; cv=none; b=HYfEIIGt8XArBWE0k61AhOTEJHuC26TckhYv+iwyMvCzlcsKMS26sw+6Y0e0f5pFLHCeoSbNhh5nieoOe084o6lNe2FeYjcrWqPF+9f9de5AKvvMTdQ+J1emepE24WdrW66ANjnrefqNJ+asi6tHt1umMXj8cvUIIJoQeaWoV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589189; c=relaxed/simple;
	bh=murgxXqK5MEygbTVNZ3W89Tu4fD2ohjtqaOMSeQzUaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMS/SR39BAtvtDCtHiB4pzfLnGDfm32JdqzkxKikpoP4eDHZr8MC5/W147eFpZsbdIYcPIN0rh9k14mW/JrotDJvZgqABv8srK2sNwn5bYtK/m7RwGj6KdQSImd/hVZTrvQxeqtIeZXB/XWjf+10m833hGyh4EeWQj1262BWEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:ce11:d0e1:e548:b0a5])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id C6AD7401FA;
	Thu,  7 Aug 2025 17:53:04 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:ce11:d0e1:e548:b0a5) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: yonghong.song@linux.dev
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
	song@kernel.org,
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCH 2/2] bpf: fix stackmap overflow check in __bpf_get_stackid()
Date: Thu,  7 Aug 2025 18:52:58 +0100
Message-ID: <20250807175258.7613-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807175032.7381-1-contact@arnaud-lcm.com>
References: <20250807175032.7381-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175458918573.18374.9325590239414294602@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
when copying stack trace data. The issue occurs when the perf trace
 contains more stack entries than the stack map bucket can hold,
 leading to an out-of-bounds write in the bucket's data array.

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 kernel/bpf/stackmap.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 14e034045310..d7ef840971f0 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -250,7 +250,7 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 }
 
 static long __bpf_get_stackid(struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+			      struct perf_callchain_entry *trace, u64 flags, u32 max_depth)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
@@ -266,6 +266,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
 
 	trace_nr = trace->nr - skip;
 	trace_len = trace_nr * sizeof(u64);
+	trace_nr = min(trace_nr, max_depth - skip);
+
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
 	id = hash & (smap->n_buckets - 1);
@@ -325,19 +327,19 @@ static long __bpf_get_stackid(struct bpf_map *map,
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
+	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+	if (max_depth < 0)
+		return -EFAULT;
 
 	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
 				   false, false);
@@ -346,7 +348,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(map, trace, flags);
+	return __bpf_get_stackid(map, trace, flags, max_depth);
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -378,6 +380,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
+	u32 elem_size, pe_max_depth;
 
 	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
 	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
@@ -396,24 +399,25 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
-
+	elem_size = stack_map_data_size(map);
 	if (kernel) {
 		__u64 nr = trace->nr;
 
 		trace->nr = nr_kernel;
-		ret = __bpf_get_stackid(map, trace, flags);
+		pe_max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		ret = __bpf_get_stackid(map, trace, flags, pe_max_depth);
 
 		/* restore nr */
 		trace->nr = nr;
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
-
 		skip += nr_kernel;
 		if (skip > BPF_F_SKIP_FIELD_MASK)
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		ret = __bpf_get_stackid(map, trace, flags);
+		pe_max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		ret = __bpf_get_stackid(map, trace, flags, pe_max_depth);
 	}
 	return ret;
 }
-- 
2.43.0


