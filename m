Return-Path: <bpf+bounces-67292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB101B42283
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2243A2078E4
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87530DEB9;
	Wed,  3 Sep 2025 13:53:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479C2E8E0F;
	Wed,  3 Sep 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907634; cv=none; b=q3nmsWO7hBZmZLK+ahEOcQwWk/tSz2vPU1NbFqcmpEsNZqC0hxkctIHRM1BJz/K0EcOBean2mCdIMpEh1t2KItjIk3LBWXPYqN5kyQS8ulziJgDJvD/QFuuA7sQGc5Vyp+C61uWp1lxLnaa+/y3ark/r1Rt27jHWX6fsezz6QVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907634; c=relaxed/simple;
	bh=j+kPGOFhynhpG0gp3DoKa1yVPSbzCmQcI8JJg2ZKe/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TjvDk+ecjW1LRDEPSyY4+byXTHVgVsAG9P2wT9BRvsjA24xrNZMs2FPz83j26uLEsjpWASVndR9z0IdhMyfyvdrYwJCAj5wKQeao9sZeY9UZhKrem/7WIMcrB4iBfFalP7Yk9MNnSvL6nRRkfwAw4iKQkCPpcNxhq1AKeYJ/y+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34ddaca59.ant.amazon.com (unknown [IPv6:2a01:e0a:3e8:c0d0:f888:35a:53a4:66b4])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id CDF154213E;
	Wed,  3 Sep 2025 13:53:49 +0000 (UTC)
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
Subject: [PATCH bpf-next v6 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Date: Wed,  3 Sep 2025 15:53:48 +0200
Message-Id: <20250903135348.97884-1-contact@arnaud-lcm.com>
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
X-PPP-Message-ID: <175690763045.28809.1530218238142963216@Plesk>
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

Link to v5: https://lore.kernel.org/all/20250826212229.143230-1-contact@arnaud-lcm.com/

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/stackmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 1ebc525b7c2f..8b2dcb8a6dc3 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -251,8 +251,9 @@ static long __bpf_get_stackid(struct bpf_map *map,
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
+	u32 hash, id, trace_nr, trace_len, i, max_depth;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len, i;
+	u32 elem_size = stack_map_data_size(map);
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -261,8 +262,12 @@ static long __bpf_get_stackid(struct bpf_map *map,
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
+	max_depth =
+		stack_map_calculate_max_depth(map->value_size, elem_size, flags);
 	trace_nr = trace->nr - skip;
+	trace_nr = min_t(u32, trace_nr, max_depth - skip);
 	trace_len = trace_nr * sizeof(u64);
+
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
 	id = hash & (smap->n_buckets - 1);
-- 
2.47.3

