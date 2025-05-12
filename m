Return-Path: <bpf+bounces-58020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81C1AB3B84
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC3A3B8C0E
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E264D2309B0;
	Mon, 12 May 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="utUCRfVN"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6021ABAB
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061993; cv=none; b=spEBWV4R0O8WtzKKfCZSdVm59XEE9ClQJd1IEnPIfcyLbQqqH03R6p/Or+spTgd5WYD9DQoJW+5LxStmXILcU0Q2EvQ9SfQpIwomULqRwU3gMl4KpM+t6H2ROY9D8IsITVrecSaNY+ca0c+hSRTOQy9KdyHfjHtGJNK+DUnHaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061993; c=relaxed/simple;
	bh=BCBD1wYqokyqr2aiQMrpy1uVk1gZBlvuJ2ouwPMITC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ew+vu2iS+VBvDga7joll6Hm62iXcoXQIJ8iBRp9CNLk8hUUhzgR4z2yod2SvwISMOuaX/UXS0nnDzdaDCySkfeI1rwoKfDrzNtl/KX5+oxWwow976B27kejjklIkVJwc0xd7AQfOxMW8JDv7BTEws5jRQ0IuFLa4lNzz116C7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=utUCRfVN; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747061989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pN5YUwiMpNiv+3vgH4ZuR+WEDhGNjxfxrY55N9N2w9U=;
	b=utUCRfVN+IN7BPDWwcN7ke1nZKX9pJR587ZE26+1rVMhO2di8ySVR6yInPh6oQKwGhhjMA
	x1OkPUp6EQa1EB3KQ0o/IZT6tufcbpz14pX8e/TWjKWEvFEgdvydQcUy3z31kymT4K3wHt
	ap5u6HuksgFShHav4LBxRcjmAT3+sbk=
From: Tao Chen <chen.dylane@linux.dev>
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
	haoluo@google.com,
	Liam.Howlett@oracle.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>,
	syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
Subject: [PATCH] bpf: Fix bpf_prog nested call in trace_mmap_lock_acquire_returned
Date: Mon, 12 May 2025 22:59:01 +0800
Message-Id: <20250512145901.691685-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

syzkaller reported an issue:

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
 mmap_read_lock include/linux/mmap_lock.h:185 [inline]
 exit_mm kernel/exit.c:565 [inline]
 do_exit+0xf72/0x2c30 kernel/exit.c:940
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 __do_sys_exit_group kernel/exit.c:1113 [inline]
 __se_sys_exit_group kernel/exit.c:1111 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1111
 x64_sys_call+0x1530/0x1730 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

mmap_read_trylock is used in stack_map_get_build_id_offset, if user
wants to trace trace_mmap_lock_acquire_returned tracepoint and get user
stack in the bpf_prog, it will call trace_mmap_lock_acquire_returned
again in the bpf_get_stack, which will lead to a nested call relationship.

Reported-by: syzbot+45b0c89a0fc7ae8dbadc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/8bc2554d-1052-4922-8832-e0078a033e1d@gmail.com
Fixes: 2f1aaf3ea666 ("bpf, mm: Fix lockdep warning triggered by stack_map_get_build_id_offset()")
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7dfa..eec51f069028 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -130,6 +130,10 @@ static int fetch_build_id(struct vm_area_struct *vma, unsigned char *build_id, b
 			 : build_id_parse_nofault(vma, build_id, NULL);
 }
 
+static inline bool mmap_read_trylock_no_trace(struct mm_struct *mm)
+{
+	return down_read_trylock(&mm->mmap_lock) != 0;
+}
 /*
  * Expects all id_offs[i].ip values to be set to correct initial IPs.
  * They will be subsequently:
@@ -154,7 +158,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	 * build_id.
 	 */
 	if (!user || !current || !current->mm || irq_work_busy ||
-	    !mmap_read_trylock(current->mm)) {
+	    !mmap_read_trylock_no_trace(current->mm)) {
 		/* cannot access current->mm, fall back to ips */
 		for (i = 0; i < trace_nr; i++) {
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-- 
2.43.0


