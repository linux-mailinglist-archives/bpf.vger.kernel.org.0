Return-Path: <bpf+bounces-74191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5056C4C5A6
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 09:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A3564F6A1E
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21666330300;
	Tue, 11 Nov 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="x1GkMJjg"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7AA3195EB;
	Tue, 11 Nov 2025 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848800; cv=none; b=ZPCYDVxsvvq+ryTf6dtLdFt02I9GCnNkSjI7De5Wxf2t/8RQr5WKm/m6PIUhn+dN55mJSFIILCwrO8nRZPVa1JnQg4jEgy+elAqxZx2gDKds2aGlGeHtS/un1cnJqdA/rdsqfzaUnpwfHgWUI3hsctUmeoYvNpRvvzVnkxrFdh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848800; c=relaxed/simple;
	bh=R/ssoBsXWb6sflro9YrhGdrY25IqwtWiz1h6+wsE/T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mr1dB/GSTyx2dW6722pmbfd464LCcUNKC0qK+NyAApHFi9zTBmENXOsL/J1w1JqL0AGkUumsobkS4V0DMuoMAKYTytJIrAFiZpEhlgfyZUv/mqsiqv4zi66WFDR/PNE4+hpF4oAWmy2g4Eh7C8WCHGSmlA9lc7cB+t2d0qsij2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=x1GkMJjg; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d5K6H5JKcz9tKq;
	Tue, 11 Nov 2025 09:13:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1762848791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imzhVMup//2ffpyDtioFEjTxYvW8FouyExcfdyRpW2E=;
	b=x1GkMJjgkJYoYbiV8LMtZu5UcfOYdsFUA3NkHmy4qTI81xd9zZaeB8K94fmi6057tKCKOJ
	8QcP0INhKYOURMyNOyIKAswwaUQ2RXERTDFey2tIRzjVxtalpawNYy4z6fMDrMBhx7gnSP
	9BpNCeHNkx9StWMBR9hEzqpBvz6Jle+9uRShx+rBTgjmBmvk4xnrEj8aOLracSCOOIt8+f
	0mooEuhFSkDR9+SBBtg06urTZHATDY9YI4eB4ymcPP5V6r8A8y+LzpwbhK+AGfPGtZXxrQ
	kJ85WFG6/WzMxXy5bOZmojJissiySNZG1FlyzXMnK29YvB6OTMLqrDxD+D2J/Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
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
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack to fix OOB write
Date: Tue, 11 Nov 2025 13:42:54 +0530
Message-ID: <20251111081254.25532-1-listout@listout.xyz>
In-Reply-To: <691231dc.a70a0220.22f260.0101.GAE@google.com>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4d5K6H5JKcz9tKq

syzbot reported a stack-out-of-bounds write in __bpf_get_stack()
triggered via bpf_get_stack() when capturing a kernel stack trace.

After the recent refactor that introduced stack_map_calculate_max_depth(),
the code in stack_map_get_build_id_offset() (and related helpers) stopped
clamping the number of trace entries (`trace_nr`) to the number of elements
that fit into the stack map value (`num_elem`).

As a result, if the captured stack contained more frames than the map value
can hold, the subsequent memcpy() would write past the end of the buffer,
triggering a KASAN report like:

    BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x...
    Write of size N at addr ... by task syz-executor...

Restore the missing clamp by limiting `trace_nr` to `num_elem` before
computing the copy length. This mirrors the pre-refactor logic and ensures
we never copy more bytes than the destination buffer can hold.

No functional change intended beyond reintroducing the missing bound check.

Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
Changes in v3:
Revert back to num_elem based logic for setting trace_nr. This was
suggested by bpf-ci bot, mainly pointing out the chances of underflow
when  max_depth < skip.

Quoting the bot's reply:
The stack_map_calculate_max_depth() function can return a value less than
skip when sysctl_perf_event_max_stack is lowered below the skip value:

    max_depth = size / elem_size;
    max_depth += skip;
    if (max_depth > curr_sysctl_max_stack)
        return curr_sysctl_max_stack;

If sysctl_perf_event_max_stack = 10 and skip = 20, this returns 10.

Then max_depth - skip = 10 - 20 underflows to 4294967286 (u32 wraps),
causing min_t() to not limit trace_nr at all. This means the original OOB
write is not fixed in cases where skip > max_depth.

With the default sysctl_perf_event_max_stack = 127 and skip up to 255, this
scenario is reachable even without admin changing sysctls.

Changes in v2:
- Use max_depth instead of num_elem logic, this logic is similar to what
we are already using __bpf_get_stackid
Link: https://lore.kernel.org/all/20251111003721.7629-1-listout@listout.xyz/

Changes in v1:
- RFC patch that restores the number of trace entries by setting
trace_nr to trace_nr or num_elem based on whichever is the smallest.
Link: https://lore.kernel.org/all/20251110211640.963-1-listout@listout.xyz/
---
 kernel/bpf/stackmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2365541c81dd..cef79d9517ab 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -426,7 +426,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 			    struct perf_callchain_entry *trace_in,
 			    void *buf, u32 size, u64 flags, bool may_fault)
 {
-	u32 trace_nr, copy_len, elem_size, max_depth;
+	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
 	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
 	bool crosstask = task && task != current;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
@@ -480,6 +480,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	}
 
 	trace_nr = trace->nr - skip;
+	num_elem = size / elem_size;
+	trace_nr = min_t(u32, trace_nr, num_elem);
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-- 
2.51.2


