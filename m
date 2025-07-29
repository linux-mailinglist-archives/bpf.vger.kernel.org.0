Return-Path: <bpf+bounces-64602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B6B14B0B
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24993AF3A7
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F56A26B762;
	Tue, 29 Jul 2025 09:19:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDD22B8A5;
	Tue, 29 Jul 2025 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780754; cv=none; b=YscFz3kqhhQ1xgrn2uhIiN8FTTWIrEG2KtAfrvHXrji4m+ljoh/3X90hbUcDm5IvdQnn5dbnMX7VBJzdeJa3yR6+hVrEvEY/0OTvK4mSsgzIRCYCgUFOPrGDl7nLA6oQTreA/oQAxCzk41OlgKLtJYv3x01Kls3/AFFrI3AcA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780754; c=relaxed/simple;
	bh=MWN/4Wglm/rTn9ibOPTMJxkL74bcwbr8wWIlo15GG7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkr7Y4AhXTadyzYlfFyLXP3hLN2BB1OxK1Za9f0rMrBNpIB38VjOqcWNPFeXMlzv2PxC9YvjM+Gh81+Dsu44QvAgPq3xeBKLDirwYpS83AGNEetZDUqQR64+xrb87xJHjoTE/LtkFMh1W1g0b30YjFyOZJR24PLM2jrEv001+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34dd3dd11.ant.amazon.com (unknown [15.248.2.230])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id D2AE640420;
	Tue, 29 Jul 2025 09:19:08 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 15.248.2.230) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=7cf34dd3dd11.ant.amazon.com
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: song@kernel.org
Cc: jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCH] bpf: fix stackmap overflow check in __bpf_get_stackid()
Date: Tue, 29 Jul 2025 10:19:01 +0100
Message-ID: <20250729091901.26436-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175378074970.13305.6575133741608671950@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
when copying stack trace data. The issue occurs when the perf trace
 contains more stack entries than the stack map bucket can hold,
 leading to an out-of-bounds write in the bucket's data array.
For build_id mode, we use sizeof(struct bpf_stack_build_id)
 to determine capacity, and for normal mode we use sizeof(u64).

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 kernel/bpf/stackmap.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..0f9f6e4b6fe9 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -230,7 +230,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len, i;
+	u32 hash, id, trace_nr, trace_len, i, max_depth;
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -241,6 +241,16 @@ static long __bpf_get_stackid(struct bpf_map *map,
 
 	trace_nr = trace->nr - skip;
 	trace_len = trace_nr * sizeof(u64);
+
+	/* Clamp the trace to max allowed depth */
+	if (stack_map_use_build_id(map))
+		max_depth = smap->map.value_size / sizeof(struct bpf_stack_build_id);
+	else
+		max_depth = smap->map.value_size / sizeof(u64);
+
+	if (trace_nr > max_depth)
+		trace_nr = max_depth;
+
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
 	id = hash & (smap->n_buckets - 1);
-- 
2.43.0

