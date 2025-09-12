Return-Path: <bpf+bounces-68279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382FB55A61
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 01:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37F504E0713
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A4D296BA5;
	Fri, 12 Sep 2025 23:36:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209128489D;
	Fri, 12 Sep 2025 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720170; cv=none; b=h/H47QwYl0jsejsXu+pEW6EAXnw72476d47+rLbCf/6n3F95MA89vMNsQNF2iV866xmF8CooBu4KREyv+P1JPnpXHhIm2cnA/gdFBK/2m7+7tixPFoOH1TviMH3iWSUGtcTFBFjDgCite8Ff9lTVeFaI6ST7KZga/nSSQAtSm14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720170; c=relaxed/simple;
	bh=6uGhFrL17N+32Nuc6ZMq/+AyTyb52dRPz7G0SdniNKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6Xmv8QgH70DY5lfy8mw/OfMF3SfWw/YeCdCn/oIz1jIroCRZnosc6cAlsfygTYt7VVvLNMK+U47/8ao+T5RrKP+ICPOyqK9JfFvsQ7XT+BrZyddJGdsu4Hn8Hsxb5HnXBra7InAgNNvFn5gJ94z5zNfhpbBK+mp41QVg/qgjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:186b:e316:24ee:afec])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id ADF9741666;
	Fri, 12 Sep 2025 23:36:05 +0000 (UTC)
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
Subject: [PATCH bpf-next v9 3/3] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Date: Sat, 13 Sep 2025 00:35:58 +0100
Message-ID: <20250912233558.75076-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912233509.74996-1-contact@arnaud-lcm.com>
References: <20250912233509.74996-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175772016664.3971.581423742891501353@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
when copying stack trace data. The issue occurs when the perf trace
 contains more stack entries than the stack map bucket can hold,
 leading to an out-of-bounds write in the bucket's data array.

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
Changes in v2:
 - Fixed max_depth names across get stack id

Changes in v4:
 - Removed unnecessary empty line in __bpf_get_stackid

Changes in v6:
 - Added back trace_len computation in __bpf_get_stackid

Changes in v7:
 - Removed usefull trace->nr assignation in bpf_get_stackid_pe
 - Added restoration of trace->nr for both kernel and user traces
   in bpf_get_stackid_pe

Changes in v9:
 - Fixed variable declarations in bpf_get_stackid_pe
 - Added the missing truncate of trace_nr in __bpf_getstackid

Link to v8: https://lore.kernel.org/all/20250905134833.26791-1-contact@arnaud-lcm.com/
---
---
 kernel/bpf/stackmap.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 9a86b5acac10..ac5ec3253ce6 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -251,8 +251,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
+	u32 hash, id, trace_nr, trace_len, i, max_storable;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len, i;
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -261,7 +261,9 @@ static long __bpf_get_stackid(struct bpf_map *map,
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
+	max_storable = map->value_size / stack_map_data_size(map);
 	trace_nr = trace->nr - skip;
+	trace_nr = min_t(u32, trace_nr, max_storable);
 	trace_len = trace_nr * sizeof(u64);
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
@@ -369,6 +371,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 {
 	struct perf_event *event = ctx->event;
 	struct perf_callchain_entry *trace;
+	u32 elem_size, max_depth;
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
@@ -390,15 +393,16 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
+	elem_size = stack_map_data_size(map);
+	__u64 nr = trace->nr; /* save original */
 
 	if (kernel) {
-		__u64 nr = trace->nr;
-
 		trace->nr = nr_kernel;
+		max_depth =
+			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		trace->nr = min_t(u32, nr_kernel, max_depth);
 		ret = __bpf_get_stackid(map, trace, flags);
 
-		/* restore nr */
-		trace->nr = nr;
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -407,8 +411,15 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
+		max_depth =
+			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		trace->nr = min_t(u32, trace->nr, max_depth);
 		ret = __bpf_get_stackid(map, trace, flags);
 	}
+
+	/* restore nr */
+	trace->nr = nr;
+
 	return ret;
 }
 
-- 
2.43.0


