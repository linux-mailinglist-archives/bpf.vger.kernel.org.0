Return-Path: <bpf+bounces-58095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AF8AB4A7E
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 06:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46C43B2844
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 04:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B001E04BD;
	Tue, 13 May 2025 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X7YZ9Tm5"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAD1C862B
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747110490; cv=none; b=J79fKVZgY1A0d0ZlFZTen6j392G5jhJPuCQWWL9lwtAXiJAfsiLcgLFHl0UExoKcUaPYLLIvBENGlrYNPqeMLRr7LdRpU60Q0DFVNz9NMDS15ZK1TWVK0OuNRrOEH+8kohuQLObYQWMdpOvwOD99Yha8aS1PJCS4OZwigleDfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747110490; c=relaxed/simple;
	bh=P/tVh1SGmOv4IS5LacLBq2PIeXYPZBySnKyqY6IxmmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ze7cEqO1Yxmg5hkQRPYBHSXrGJ9QbjKFD/cynqnTUIwrIAIITig+MALtkXmk7vrC+kDb/6YUIx0Hd5iro7w8gm+ipiL0uLKpA6vZ1Fh9psDmuZez55LgEL8baVhwVrVTTi4zfR8lVEuaTNEKfb8lAT1iGnolFnZujaQpY6hRDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X7YZ9Tm5; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747110476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BPTA9vVxkQoC46WbGZ0A0ac/vwtYT1FSdvh6sBn5uV4=;
	b=X7YZ9Tm52OJw1Zo1gDM4ed9e+Dl8r4JQbud7yvSjT3UubAbFW3ZtmxmYoO9lwPkiILR81g
	4tmjTk0+nWTdfZzs50vWuGFxSm/IB7hwHCSxxW6rw9SaSecyDlRvkf+uE9XvHMSnDNHp5v
	J/REZf27qAH1Yi8peo1+ZI2rRJ1rMcI=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mmullins@fb.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>,
	syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
Subject: [PATCH bpf-next] bpf: Fix WARN() in get_bpf_raw_tp_regs
Date: Tue, 13 May 2025 12:27:47 +0800
Message-Id: <20250513042747.757042-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

syzkaller reported an issue:

WARNING: CPU: 3 PID: 5971 at kernel/trace/bpf_trace.c:1861 get_bpf_raw_tp_regs+0xa4/0x100 kernel/trace/bpf_trace.c:1861
Modules linked in:
CPU: 3 UID: 0 PID: 5971 Comm: syz-executor205 Not tainted 6.15.0-rc5-syzkaller-00038-g707df3375124 #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:get_bpf_raw_tp_regs+0xa4/0x100 kernel/trace/bpf_trace.c:1861
RSP: 0018:ffffc90003636fa8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff81c6bc4c
RDX: ffff888032efc880 RSI: ffffffff81c6bc83 RDI: 0000000000000005
RBP: ffff88806a730860 R08: 0000000000000005 R09: 0000000000000003
R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000004
R13: 0000000000000001 R14: ffffc90003637008 R15: 0000000000000900
FS:  0000000000000000(0000) GS:ffff8880d6cdf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7baee09130 CR3: 0000000029f5a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1934 [inline]
 bpf_get_stack_raw_tp+0x24/0x160 kernel/trace/bpf_trace.c:1931
 bpf_prog_ec3b2eefa702d8d3+0x43/0x47
 bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
 __bpf_prog_run include/linux/filter.h:718 [inline]
 bpf_prog_run include/linux/filter.h:725 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2363 [inline]
 bpf_trace_run3+0x23f/0x5a0 kernel/trace/bpf_trace.c:2405
 __bpf_trace_mmap_lock_acquire_returned+0xfc/0x140 include/trace/events/mmap_lock.h:47
 __traceiter_mmap_lock_acquire_returned+0x79/0xc0 include/trace/events/mmap_lock.h:47
 __do_trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
 trace_mmap_lock_acquire_returned include/trace/events/mmap_lock.h:47 [inline]
 __mmap_lock_do_trace_acquire_returned+0x138/0x1f0 mm/mmap_lock.c:35
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:204 [inline]
 stack_map_get_build_id_offset+0x535/0x6f0 kernel/bpf/stackmap.c:157
 __bpf_get_stack+0x307/0xa10 kernel/bpf/stackmap.c:483
 ____bpf_get_stack kernel/bpf/stackmap.c:499 [inline]
 bpf_get_stack+0x32/0x40 kernel/bpf/stackmap.c:496
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1941 [inline]
 bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1931
 bpf_prog_ec3b2eefa702d8d3+0x43/0x47

Tracepoint like trace_mmap_lock_acquire_returned may cause nested call
as the corner case show above, which will be resolved with more general
method in the future. As a result, WARN_ON_ONCE will be triggered. As
Alexei suggested, remove the WARN_ON_ONCE first.

Reported-by: syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/8bc2554d-1052-4922-8832-e0078a033e1d@gmail.com
Fixes: 9594dc3c7e71 ("bpf: fix nested bpf tracepoints with per-cpu data")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Change list:
- v1 -> v2:
  - remove WARN() as Alexei suggested
  - rename the patch
- v1:
    https://lore.kernel.org/bpf/a3fa6129-933a-4747-8165-884e38c58e3b@linux.dev

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 187dc37d61..d14f0fdd7a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1858,7 +1858,7 @@ static struct pt_regs *get_bpf_raw_tp_regs(void)
 	struct bpf_raw_tp_regs *tp_regs = this_cpu_ptr(&bpf_raw_tp_regs);
 	int nest_level = this_cpu_inc_return(bpf_raw_tp_nest_level);
 
-	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(tp_regs->regs))) {
+	if (nest_level > ARRAY_SIZE(tp_regs->regs)) {
 		this_cpu_dec(bpf_raw_tp_nest_level);
 		return ERR_PTR(-EBUSY);
 	}
-- 
2.43.0


