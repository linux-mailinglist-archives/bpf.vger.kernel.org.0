Return-Path: <bpf+bounces-64590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B4BB14906
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F18F17F2B1
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB793262FD7;
	Tue, 29 Jul 2025 07:22:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACD1EEBD;
	Tue, 29 Jul 2025 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753773767; cv=none; b=RNt6A/ixNLmsEMLHeFqlPhfGaraYY4xdS7/TYWGKQ0gphA35eNMtjj61M+cqjpaTQY36Is16ohdHW2yL+fRHrVjzYOVdPiYM/25uJoYnZBKMk1Kyo5GoyAnsKiEnwH6EOQsOsIVTQ0+z0aGSG0S3hFFQW6PYv/wdcPvKbJ2PyPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753773767; c=relaxed/simple;
	bh=GwFSsAnn5e/gFzfmxnEwurhex/jDUSBm0oFAOSEuKvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUkXasv04pv7C1aZbdvJHWVUTr177fP0MunZOmNNQCJKG1c9HfEWjDB8TwecKWUM4O87PKLfzNqvl13ltMezNhP7iA+sUnQGlKsTEosvW+n6hFFJQOgRaIKDWwp6w933WK4Cri8G1o4zrgwpbqJM0+ecFwiuBut/vI+/i2C3Xno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:b0f6:f50b:6492:2c39])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id B81F940B15;
	Tue, 29 Jul 2025 07:22:40 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:b0f6:f50b:6492:2c39) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: syztest
Date: Tue, 29 Jul 2025 08:22:34 +0100
Message-ID: <20250729072234.90576-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <688809c1.a00a0220.b12ec.00b7.GAE@google.com>
References: <688809c1.a00a0220.b12ec.00b7.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175377376123.12091.12839028667260881757@Plesk>
X-PPP-Vhost: arnaud-lcm.com

#syz test

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
@@ -241,6 +241,19 @@ static long __bpf_get_stackid(struct bpf_map *map,
 
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
+ 	ips = trace->ip + skip;
+
+
 	ips = trace->ip + skip;
 	hash = jhash2((u32 *)ips, trace_len / sizeof(u32), 0);
 	id = hash & (smap->n_buckets - 1);
-- 


