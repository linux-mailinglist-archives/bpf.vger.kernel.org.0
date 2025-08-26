Return-Path: <bpf+bounces-66596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6885B37452
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 23:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FF01BA1759
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000A92F83B7;
	Tue, 26 Aug 2025 21:22:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FBB30CD86;
	Tue, 26 Aug 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243377; cv=none; b=BZ4DjHHymH4zkdfoRHsDj8kvMU8F7jeS0qZo/fCAoG4pBIObPVCLfyXrPGNK2Ao0rJVWzeQMA5z+MHeC45g0aC61DGeSNvRqpqudONqRGPwJgsZmNfQ8blIS2ph24xni5EFspHkJkJLr3i3h2wN5nCXeoGozyg8SZrdGM7cwi7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243377; c=relaxed/simple;
	bh=xPYrDcC/f7UzlG/n2Hr/nmLWhWjNNbzGro/29S4N0Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ionLk8WhDXKbLEIT299+bpAEGn7Gb4HDM9uE7K9s+FSryY/VTxdUlFB2265PxjOVdmjwnZCki5SmXuhWfkWrJWRcNGvbGcVM48HkObNN3F/i61It3lXnQ2d+EN1JmLcNt5QBdWO3S9Wd+YWk47EgE00RSfQdhh71H/0i4h5SmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:df1d:d28e:21a2:5325])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 4DB7140AC9;
	Tue, 26 Aug 2025 21:22:46 +0000 (UTC)
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
Subject: [PATCH bpf-next v5 1/2] bpf: refactor max_depth computation in
 bpf_get_stack()
Date: Tue, 26 Aug 2025 22:22:29 +0100
Message-ID: <20250826212229.143230-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175624336718.30281.17351732042781701174@Plesk>
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

Link to v4: https://lore.kernel.org/all/20250819162652.8776-1-contact@arnaud-lcm.com/

Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/stackmap.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..796cc105eacb 100644
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
@@ -438,10 +460,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto clear;
 	}
 
-	num_elem = size / elem_size;
-	max_depth = num_elem + skip;
-	if (sysctl_perf_event_max_stack < max_depth)
-		max_depth = sysctl_perf_event_max_stack;
+	max_depth = stack_map_calculate_max_depth(size, elem_size, flags);
 
 	if (may_fault)
 		rcu_read_lock(); /* need RCU for perf's callchain below */
@@ -460,6 +479,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto err_fault;
 	}
 
+	num_elem = size / elem_size;
 	trace_nr = trace->nr - skip;
 	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
 	copy_len = trace_nr * elem_size;
-- 
2.43.0


