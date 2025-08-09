Return-Path: <bpf+bounces-65297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E0B1F489
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 14:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B76F1892C7D
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022AE27FD43;
	Sat,  9 Aug 2025 12:14:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A127F01B;
	Sat,  9 Aug 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754741661; cv=none; b=GOhSF1yH8a35x5aKTBJg+uD6kitoChxX3M8dx5qI9cMQBNzyaAe3zjTWBpJxPliNJCcJxLl2mxFlklOP5CQoxb3mA3UkvvvWxl8gomd1Q0ctL3+bA51j4bhGvonvb1rThNxWJE29zfwzcc+Eimptc/ytKxmxnchvc4yea0FdECo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754741661; c=relaxed/simple;
	bh=I4MQzY8BWmsC+1VtxtyLfB+9yn9888xtLB3/amsVWJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SryYIa96tgtZGOo9TDrZqaugF/RnGj4xBBr0bb4E2L220mtOTtCUVeKckGJtmd2IWHpiSShTnRFHAxl/YjJ8oxocEjZrKuONcT/K8lgCYGk/Q9IQOXXr6VuLI0hLY0/J+emvgCui9WygZW/lsjLBASA/LkiOJnM8T+j2a1yaR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:f24d:f84c:98a:7e26])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 49FE941C3C;
	Sat,  9 Aug 2025 12:14:16 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:f24d:f84c:98a:7e26) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
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
Subject: [PATCH RESEND v2 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Date: Sat,  9 Aug 2025 13:14:06 +0100
Message-ID: <20250809121406.89333-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250809120911.88670-1-contact@arnaud-lcm.com>
References: <20250809120911.88670-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175474165717.5974.2272911099559087113@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
when copying stack trace data. The issue occurs when the perf trace
 contains more stack entries than the stack map bucket can hold,
 leading to an out-of-bounds write in the bucket's data array.

Changes in v2:
 - Fixed max_depth names across get stack id

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 kernel/bpf/stackmap.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 532447606532..b3995724776c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -246,7 +246,7 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 }
 
 static long __bpf_get_stackid(struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+			      struct perf_callchain_entry *trace, u64 flags, u32 max_depth)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
@@ -262,6 +262,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
 
 	trace_nr = trace->nr - skip;
 	trace_len = trace_nr * sizeof(u64);
+	trace_nr = min(trace_nr, max_depth - skip);
+
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
 	id = hash & (smap->n_buckets - 1);
@@ -321,19 +323,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
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
 
 	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
 				   false, false);
@@ -342,7 +342,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(map, trace, flags);
+	return __bpf_get_stackid(map, trace, flags, max_depth);
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -374,6 +374,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
+	u32 elem_size, max_depth;
 
 	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
 	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
@@ -392,16 +393,18 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
-
+	elem_size = stack_map_data_size(map);
 	if (kernel) {
 		__u64 nr = trace->nr;
 
 		trace->nr = nr_kernel;
-		ret = __bpf_get_stackid(map, trace, flags);
+		max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		ret = __bpf_get_stackid(map, trace, flags, max_depth);
 
 		/* restore nr */
 		trace->nr = nr;
 	} else { /* user */
+
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
 		skip += nr_kernel;
@@ -409,7 +412,8 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
-		ret = __bpf_get_stackid(map, trace, flags);
+		max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		ret = __bpf_get_stackid(map, trace, flags, max_depth);
 	}
 	return ret;
 }
-- 
2.43.0


