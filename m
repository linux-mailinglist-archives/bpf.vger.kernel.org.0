Return-Path: <bpf+bounces-67563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C76B45989
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B61A81C87429
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 13:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A742353368;
	Fri,  5 Sep 2025 13:48:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC76352FFF;
	Fri,  5 Sep 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080122; cv=none; b=DOdGaiMhixhLr2Uw/QTKFxP2AUsIYgok0xOXCVYESxVmPMoiWyZBZPOzmJH8WIvJBkF+Bm9XRXsNM8w4rRDl07BuRnBgj+X725mV7rJqrPQyFvyxNqDhUYnQfF4ZfAOoNxmUCRqWpFffeyprsL8F2jruVTCDeAuBB2UHeKBj/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080122; c=relaxed/simple;
	bh=znhd37DdN6KALLrsCH/O6IMvCVPXC7uRg/8pj3Fasqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VtVRuYqE519gZFN70rUi9KxaO0XKxX+oMgZ+U+asQNTVxgQDC8Gd2sttEMQPBAP/i6+FmaPsHXIz48V9In5v5DGAusVDHT40p5A4SAVN3Lqfkm35knp3bELXOvj5vF7pUUlE+DIc79vhlCPMllNJwOTaSQCVzFCbIxsfEtOneS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from 7cf34ddaca59.ant.amazon.com (unknown [IPv6:2a01:e0a:3e8:c0d0:24ce:2523:e0d0:1c47])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id AFAC74207B;
	Fri,  5 Sep 2025 13:48:37 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a01:e0a:3e8:c0d0:24ce:2523:e0d0:1c47) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=7cf34ddaca59.ant.amazon.com
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud lecomte <contact@arnaud-lcm.com>
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
Subject: [PATCH bpf-next v8 3/3] bpf: fix stackmap overflow check in
 __bpf_get_stackid()
Date: Fri,  5 Sep 2025 15:48:33 +0200
Message-Id: <20250905134833.26791-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250905134625.26531-1-contact@arnaud-lcm.com>
References: <20250905134625.26531-1-contact@arnaud-lcm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175708011830.28313.17001961462282681133@Plesk>
X-PPP-Vhost: arnaud-lcm.com

From: Arnaud Lecomte <contact@arnaud-lcm.com>

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stackid()
when copying stack trace data. The issue occurs when the perf trace
 contains more stack entries than the stack map bucket can hold,
 leading to an out-of-bounds write in the bucket's data array.

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
Fixes: ee2a098851bf ("bpf: Adjust BPF stack helper functions to accommodate skip > 0")
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
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

Link to v7: https://lore.kernel.org/all/20250903234325.30212-1-contact@arnaud-lcm.com/
---
 kernel/bpf/stackmap.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 9f3ae426ddc3..9b57b8307565 100644
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
@@ -390,15 +391,16 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
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
 
@@ -407,8 +409,15 @@ BPF_CALL_3(bpf_get_stackid_pe, struct bpf_perf_event_data_kern *, ctx,
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
2.47.3


