Return-Path: <bpf+bounces-64640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F32B151BC
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AD518A40AE
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACA32951DD;
	Tue, 29 Jul 2025 16:56:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E736265CC8;
	Tue, 29 Jul 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808201; cv=none; b=DyeyNoHWnETuj50xeP4p6LsA5zevpCrMC5dcPeMT63+VM74FXqW1eHqJeu9s6gGuwRL6awZ/EzCnmf2hGkB1vG5C0pitDTAknqH3cGTENyp/CF3VxxZbVyUAfwO+V2bKnDN9Ydm8wfhCI0wSXAXADb0PZq4vFN6gK9mwFfAmi54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808201; c=relaxed/simple;
	bh=gkHE6WyHWyPUujbv/s/TY/7ZFHN9NyQ8MiG7C3d14zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K753pTRi/Vu1HKe97H8YPuSYopsPN5x+HVAXJBm4qB5fbqTdjzKdguDKwhIPnsoMvzH3W2FXgqgd05INUHCdRlBGHCGj2bSSaJoUaYfd+nDTBmP9hdU54hHqOXQ2mv7JC8j2IG12t2U+nXXPgiTjD4LL/WZLHbc546tGEJSTaAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:d071:2bab:ab9:4510])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id A76F540420;
	Tue, 29 Jul 2025 16:56:37 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:d071:2bab:ab9:4510) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCH v2] bpf: fix stackmap overflow check in __bpf_get_stackid()
Date: Tue, 29 Jul 2025 17:56:22 +0100
Message-ID: <20250729165622.13794-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175380819860.18739.12641251852562863575@Plesk>
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
Changes in v2:
 - Use utilty stack_map_data_size to compute map stack map size
---
 kernel/bpf/stackmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..6f225d477f07 100644
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
@@ -241,6 +241,12 @@ static long __bpf_get_stackid(struct bpf_map *map,
 
 	trace_nr = trace->nr - skip;
 	trace_len = trace_nr * sizeof(u64);
+
+	/* Clamp the trace to max allowed depth */
+	max_depth = smap->map.value_size / stack_map_data_size(map);
+	if (trace_nr > max_depth)
+		trace_nr = max_depth;
+
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
 	id = hash & (smap->n_buckets - 1);
-- 
2.43.0


