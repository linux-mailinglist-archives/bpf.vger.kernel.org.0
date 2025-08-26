Return-Path: <bpf+bounces-66597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418FCB37458
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 23:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0342042C9
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A932F99A5;
	Tue, 26 Aug 2025 21:24:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E228151E;
	Tue, 26 Aug 2025 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243446; cv=none; b=kIkniDH1jkuoAy8Jg2297J/qel3lgqMW2H1lvAXtnHDTDsw1EPudpU8qBhMy21xEcLrVvya0mgMrpGCTGVuiaP3hzYy4LFHPn5GPjh54vx6b0h0U1X8Hh3zfTytbQNs3KYs7WMmRQNOwy5Ty9KBNamvRi+dqAOMTCeBNI0uXzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243446; c=relaxed/simple;
	bh=tcKlRdf0OBEu2+100IjXjkXwwlpLL819tePWH4aHQLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yq0Ts1tZMdKiERLTaoyOyTen7/cTraVy0GZPvkBMwEvewyoNvjBoQvZ8bjw9Qgf4RAECg7aLoNrueytyJkQ1lVrQ14rf/8jqSt+pcvuCwTxLBD6QImFZvXYS+2xjsjc68uUeWsUzxLarKsqbrhx9jIjzKA6H+QgBL8uPNEsYbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:df1d:d28e:21a2:5325])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 1943940091;
	Tue, 26 Aug 2025 21:24:01 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:df1d:d28e:21a2:5325) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev
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
	sdf@fomichev.me,
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCH bpf-next v5 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Date: Tue, 26 Aug 2025 22:23:52 +0100
Message-ID: <20250826212352.143299-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826212229.143230-1-contact@arnaud-lcm.com>
References: <20250826212229.143230-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175624344201.31674.16241940723371382857@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
when copying stack trace data. The issue occurs when the perf trace
 contains more stack entries than the stack map bucket can hold,
 leading to an out-of-bounds write in the bucket's data array.

Changes in v2:
 - Fixed max_depth names across get stack id

Changes in v4:
 - Removed unnecessary empty line in __bpf_get_stackid

Link to v4: https://lore.kernel.org/all/20250813205506.168069-1-contact@arnaud-lcm.com/

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/stackmap.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 796cc105eacb..ef8269ab8d6f 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -247,7 +247,7 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 }
 
 static long __bpf_get_stackid(struct bpf_map *map,
-			      struct perf_callchain_entry *trace, u64 flags)
+			      struct perf_callchain_entry *trace, u64 flags, u32 max_depth)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
@@ -263,6 +263,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
 
 	trace_nr = trace->nr - skip;
 	trace_len = trace_nr * sizeof(u64);
+	trace_nr = min(trace_nr, max_depth - skip);
+
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
 	id = hash & (smap->n_buckets - 1);
@@ -322,19 +324,17 @@ static long __bpf_get_stackid(struct bpf_map *map,
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
@@ -343,7 +343,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(map, trace, flags);
+	return __bpf_get_stackid(map, trace, flags, max_depth);
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -375,6 +375,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
+	u32 elem_size, max_depth;
 
 	/* perf_sample_data doesn't have callchain, use bpf_get_stackid */
 	if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
@@ -393,12 +394,13 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
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
@@ -410,7 +412,8 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
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


