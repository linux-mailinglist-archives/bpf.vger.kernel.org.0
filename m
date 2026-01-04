Return-Path: <bpf+bounces-77792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4ECF14BB
	for <lists+bpf@lfdr.de>; Sun, 04 Jan 2026 21:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7F83300443F
	for <lists+bpf@lfdr.de>; Sun,  4 Jan 2026 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C432EDD6B;
	Sun,  4 Jan 2026 20:52:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952F185E4A;
	Sun,  4 Jan 2026 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767559957; cv=none; b=j8fWK2wLOdQuEH7pYxfKsJlVuMUPAnGd5TCHfscFhMWUjvo93NWCl5Q5r7HnH6YSc1R4DV8eyzu7piMI3kJB+rt/FPCJD+alB6s1jTcPb7jHep5OEoGqv4Q07jalg6V/9HpmnYkzEZGs+DuzhZ0KKacJavaD9xYXS82WxnvhVLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767559957; c=relaxed/simple;
	bh=t106gGpXeRc4AiUFXMmFzCvrMdIePCMm3NCwCp4L6DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKy2Tfsigmno/+j/7o1tcqkvBkBYHgOglraQdgUkzJ1hIlTMWVYFPypNYr+mIm7XlIKGAWjFCMl4BkgHW7e0UQ/oRAwTCs/CCRXMeDft9xWpeMcZAlOu+TuJq+DgxczrXi5L8iuyWRzuFEKhQU4+wDcUx6ISkk1m6zMKxVsQGaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from localhost.localdomain (vps-f4c04b7b.vps.ovh.net [IPv6:2001:41d0:305:2100::d563])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 95E4140D08;
	Sun,  4 Jan 2026 20:52:32 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2001:41d0:305:2100::d563) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=localhost.localdomain
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	contact@arnaud-lcm.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	Brahmajit Das <listout@listout.xyz>
Subject: [PATCH] bpf-next: Prevent out of bound buffer write in
 __bpf_get_stack
Date: Sun,  4 Jan 2026 20:52:20 +0000
Message-ID: <20260104205220.980752-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <176755995311.29399.17282423088296445020@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stack()
during stack trace copying.

The issue occurs when: the callchain entry (stored as a per-cpu variable)
grow between collection and buffer copy, causing it to exceed the initially
calculated buffer size based on max_depth.

The callchain collection intentionally avoids locking for performance
reasons, but this creates a window where concurrent modifications can
occur during the copy operation.

To prevent this from happening, we clamp the trace len to the max
depth initially calculated with the buffer size and the size of
a trace.

Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/691231dc.a70a0220.22f260.0101.GAE@google.com/T/
Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: Brahmajit Das <listout@listout.xyz>
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
Thanks Brahmajit Das for the initial fix he proposed that I tweaked
with the correct justification and a better implementation in my
opinion.
---
 kernel/bpf/stackmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c15..e56752a9a891 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -465,7 +465,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 
 	if (trace_in) {
 		trace = trace_in;
-		trace->nr = min_t(u32, trace->nr, max_depth);
 	} else if (kernel && task) {
 		trace = get_callchain_entry_for_task(task, max_depth);
 	} else {
@@ -479,7 +478,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		goto err_fault;
 	}
 
-	trace_nr = trace->nr - skip;
+	trace_nr = min(trace->nr, max_depth);
+	trace_nr = trace_nr - skip;
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.43.0


