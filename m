Return-Path: <bpf+bounces-67360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC0B42D94
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4063AF589
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 23:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255A631CA5B;
	Wed,  3 Sep 2025 23:43:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135432F775;
	Wed,  3 Sep 2025 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756943011; cv=none; b=Lmdk66WVCZYgmN4C5xaLkzwLD/3i5ZM/1vl5DAdCNVd8OZcHb+aFhs5Oi3XI7nEymCMgNJrY4jSexB/uM9wKf1eVnlUz8pf39cBokJQUkwbO863fqwFXuiWahx1R7RUE5UvxYzxsBLAYBUfZY3QQMXbBJJa8HH3DUmFtOuy50ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756943011; c=relaxed/simple;
	bh=q7QB1SR7jn2lapgT2UnUNNqjqRd5fXtqzmJyV2sSSSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EJ5cbDgbbfyiA6a1G6jRjs/aW/it++gS+zYnGytrx03wDhQl1CIfuM8SJWxEZnaXnoF5Ju3/eq5xGyJwOFv59SZCkcJLKfdTk06p0JQLK2jGxO6IS+vG86nVebLAZh2ZlqlV7dNkrtHHfKx8gvRCXqPGW97kxTmKIDYKVA7lMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34ddaca59.ant.amazon.com (unknown [IPv6:2a01:e0a:3e8:c0d0:d63:c24f:a3ef:4dc9])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id D311141C2B;
	Wed,  3 Sep 2025 23:43:27 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a01:e0a:3e8:c0d0:d63:c24f:a3ef:4dc9) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=7cf34ddaca59.ant.amazon.com
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
Subject: [PATCH bpf-next v7 3/3] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Date: Thu,  4 Sep 2025 01:43:25 +0200
Message-Id: <20250903234325.30212-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250903234052.29678-1-contact@arnaud-lcm.com>
References: <20250903234052.29678-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175694300847.10311.7704524635727624988@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
when copying stack trace data. The issue occurs when the perf trace
 contains more stack entries than the stack map bucket can hold,
 leading to an out-of-bounds write in the bucket's data array.

Changes in v2:
 - Fixed max_depth names across get stack id

Changes in v4:
 - Removed unnecessary empty line in __bpf_get_stackid

Changs in v6:
 - Added back trace_len computation in __bpf_get_stackid

Link to v6: https://lore.kernel.org/all/20250903135348.97884-1-contact@arnaud-lcm.com/

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/stackmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 9f3ae426ddc3..29e05c9ff1bd 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -369,6 +369,7 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 {
 	struct perf_event *event = ctx->event;
 	struct perf_callchain_entry *trace;
+	u32 elem_size, max_depth;
 	bool kernel, user;
 	__u64 nr_kernel;
 	int ret;
@@ -390,11 +391,15 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
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
@@ -407,6 +412,9 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 			return -EFAULT;
 
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
+		max_depth =
+			stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+		trace->nr = min_t(u32, trace->nr, max_depth);
 		ret = __bpf_get_stackid(map, trace, flags);
 	}
 	return ret;
-- 
2.47.3

