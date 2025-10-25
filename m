Return-Path: <bpf+bounces-72200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7983C09F46
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 21:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921371C2085E
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB80309F0F;
	Sat, 25 Oct 2025 19:30:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668030ACE3;
	Sat, 25 Oct 2025 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761420599; cv=none; b=TLNHGK7vMbRn/ek7WX6feNuorOYGK8vcCLvpFfziq5BbqwqIZ8gPva9BtHuljOKDKMZC+eX1rV7c+IWR/VQTHoUWcCZiiOFq+NAJjv06Ck0FlvozofI/Tw+b9uK49AYluS8NZZd0O0jqoSpTvgF9tPeabcbj/808GwBA4V/7q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761420599; c=relaxed/simple;
	bh=BKwSS5n1j+TmCA2j8wQg/7+SCSaYJZVFdLwqBi+78Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSqL47Dkx3DAo4qk/cDTyjcSocDvco8itKRczVv4zqHAm0LgerFP22+4IsyO6FadVcktisHrTdQ5jpdVfr2zTWSbSydWFSoHkymVclmXpXV+QHgUma0gRgjkrRsDcacYex8YO3MURYWzlqE5EbXTOslAgCHO2q6ai3r1kijebEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from dev-dsk-arnaudlc-1a-b66eeb5f.eu-west-1.amazon.com (54-240-197-230.amazon.com [54.240.197.230])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 1798640B8D;
	Sat, 25 Oct 2025 19:29:54 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 54.240.197.230) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=dev-dsk-arnaudlc-1a-b66eeb5f.eu-west-1.amazon.com
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: contact@arnaud-lcm.com,
	alexei.starovoitov@gmail.com,
	andrii.nakryiko@gmail.com,
	andrii@kernel.org
Cc: ast@kernel.org,
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
	yonghong.song@linux.dev
Subject: [PATCH V10 RESEND 2/2] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Date: Sat, 25 Oct 2025 19:29:41 +0000
Message-ID: <20251025192941.1500-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251025192858.31424-1-contact@arnaud-lcm.com>
References: <20251025192858.31424-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <176142059485.24744.14432141279233149393@Plesk>
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

Changes in v10:
 - Remove not required trace->nr = nr_kernel; in bpf_get_stackid_pe

Link to v9:
https://lore.kernel.org/all/20250912233558.75076-1-contact@arnaud-lcm.com/
---
---
 kernel/bpf/stackmap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 5e9ad050333c..2365541c81dd 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -251,8 +251,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
+	u32 hash, id, trace_nr, trace_len, i, max_depth;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len, i;
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -261,7 +261,8 @@ static long __bpf_get_stackid(struct bpf_map *map,
 		/* skipping more than usable stack trace */
 		return -EFAULT;
 
-	trace_nr = trace->nr - skip;
+	max_depth = stack_map_calculate_max_depth(map->value_size, stack_map_data_size(map), flags);
+	trace_nr = min_t(u32, trace->nr - skip, max_depth - skip);
 	trace_len = trace_nr * sizeof(u64);
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
@@ -390,15 +391,11 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		return -EFAULT;
 
 	nr_kernel = count_kernel_ip(trace);
+	__u64 nr = trace->nr; /* save original */
 
 	if (kernel) {
-		__u64 nr = trace->nr;
-
 		trace->nr = nr_kernel;
 		ret = __bpf_get_stackid(map, trace, flags);
-
-		/* restore nr */
-		trace->nr = nr;
 	} else { /* user */
 		u64 skip = flags & BPF_F_SKIP_FIELD_MASK;
 
@@ -409,6 +406,10 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
 		flags = (flags & ~BPF_F_SKIP_FIELD_MASK) | skip;
 		ret = __bpf_get_stackid(map, trace, flags);
 	}
+
+	/* restore nr */
+	trace->nr = nr;
+
 	return ret;
 }
 
-- 
2.47.3


