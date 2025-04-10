Return-Path: <bpf+bounces-55634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548B8A83A32
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 09:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EE11B82324
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 07:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD648204C0A;
	Thu, 10 Apr 2025 07:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V1clprFc"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E51DFDE;
	Thu, 10 Apr 2025 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268628; cv=none; b=Rf3n5j25zTZWVar0KZ7Dzctw86ls8OHq8bSSIr58VLOJhgFC53ocYcj2OWHzlY5SJ/OTTL2jDnB5pKiGU4gIl2eiAktfrexHSzDVcN4GCBYtRQcmSQgEhxz/vkxLotQJjm/ZJ39HadbpyPo/59RY+oydSwEEW2fJ+hLmUd5Vhh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268628; c=relaxed/simple;
	bh=bZLY15UrVGK7p97LG2OmtwjcZajPk3Fv1tuBhvNIjMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QkuSt4iwjVmdbLnWVpHywQkFks8Am0XmioKGvVbebAJebf1+4NindtuLH3iB5IBgEh3MhaBVxt1/U4mI1YS6f29vP1Tuk4/udUR6vRUq53gz9m7pww0Yl0OrE68wSqOPx7CxvC2+3VegD01C0yB3I6TtM/z0bhg4Mxa34VXJQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V1clprFc; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CnPiI
	i+40Nq8IcPg6K0qCX4b4qsQqX8RZrW3I0ARU+w=; b=V1clprFcSYL5hj6EdrKA/
	ZvKFdBpjr6yT9+dg7+1YdX+thh8ahiBMaJT4MVUdw/U7dpVGGafHBkkfCB3VWhvf
	iTo3Ic8iK1g6yaC1qQOTeF+l84ndxcoEIZ2HkP/wu6O1RH2sJdkjRqj/O4IrCCS/
	xio5MB4R5GF2TMerhFUzJE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3f7EibfdnHOEjFg--.20679S2;
	Thu, 10 Apr 2025 15:02:59 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
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
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3] bpf: Remove redundant checks
Date: Thu, 10 Apr 2025 15:02:58 +0800
Message-Id: <20250410070258.276759-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f7EibfdnHOEjFg--.20679S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr4kJFy8XF15Zr1rWw13twb_yoW7tF1rpF
	sxtrZxCrs2vw42qFy7Jr1fZa4Yy3srX3y5WaykKw18ur4UZr47tF12kF42gF1rAr98G347
	u3yvvFZ0kFyI93JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jerWrUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwgMreGf3aJu3wAAAsG

From: Feng Yang <yangfeng@kylinos.cn>

Many conditional checks in switch-case are redundant
with bpf_base_func_proto and should be removed.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Acked-by: Song Liu <song@kernel.org>
---
Changes in v3:
- Only modify patch description information.
- Link to v2: https://lore.kernel.org/all/20250408071151.229329-1-yangfeng59949@163.com/

Changes in v2:
- Only modify patch description information.
- Link to v1: https://lore.kernel.org/all/20250320032258.116156-1-yangfeng59949@163.com/
---
 kernel/trace/bpf_trace.c | 72 ----------------------------------------
 1 file changed, 72 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6b07fa7081d9..c89b25344422 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1443,56 +1443,14 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	const struct bpf_func_proto *func_proto;
 
 	switch (func_id) {
-	case BPF_FUNC_map_lookup_elem:
-		return &bpf_map_lookup_elem_proto;
-	case BPF_FUNC_map_update_elem:
-		return &bpf_map_update_elem_proto;
-	case BPF_FUNC_map_delete_elem:
-		return &bpf_map_delete_elem_proto;
-	case BPF_FUNC_map_push_elem:
-		return &bpf_map_push_elem_proto;
-	case BPF_FUNC_map_pop_elem:
-		return &bpf_map_pop_elem_proto;
-	case BPF_FUNC_map_peek_elem:
-		return &bpf_map_peek_elem_proto;
-	case BPF_FUNC_map_lookup_percpu_elem:
-		return &bpf_map_lookup_percpu_elem_proto;
-	case BPF_FUNC_ktime_get_ns:
-		return &bpf_ktime_get_ns_proto;
-	case BPF_FUNC_ktime_get_boot_ns:
-		return &bpf_ktime_get_boot_ns_proto;
-	case BPF_FUNC_tail_call:
-		return &bpf_tail_call_proto;
-	case BPF_FUNC_get_current_task:
-		return &bpf_get_current_task_proto;
-	case BPF_FUNC_get_current_task_btf:
-		return &bpf_get_current_task_btf_proto;
-	case BPF_FUNC_task_pt_regs:
-		return &bpf_task_pt_regs_proto;
 	case BPF_FUNC_get_current_uid_gid:
 		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_get_current_comm:
 		return &bpf_get_current_comm_proto;
-	case BPF_FUNC_trace_printk:
-		return bpf_get_trace_printk_proto();
 	case BPF_FUNC_get_smp_processor_id:
 		return &bpf_get_smp_processor_id_proto;
-	case BPF_FUNC_get_numa_node_id:
-		return &bpf_get_numa_node_id_proto;
 	case BPF_FUNC_perf_event_read:
 		return &bpf_perf_event_read_proto;
-	case BPF_FUNC_get_prandom_u32:
-		return &bpf_get_prandom_u32_proto;
-	case BPF_FUNC_probe_read_user:
-		return &bpf_probe_read_user_proto;
-	case BPF_FUNC_probe_read_kernel:
-		return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
-		       NULL : &bpf_probe_read_kernel_proto;
-	case BPF_FUNC_probe_read_user_str:
-		return &bpf_probe_read_user_str_proto;
-	case BPF_FUNC_probe_read_kernel_str:
-		return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
-		       NULL : &bpf_probe_read_kernel_str_proto;
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	case BPF_FUNC_probe_read:
 		return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
@@ -1502,10 +1460,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		       NULL : &bpf_probe_read_compat_str_proto;
 #endif
 #ifdef CONFIG_CGROUPS
-	case BPF_FUNC_cgrp_storage_get:
-		return &bpf_cgrp_storage_get_proto;
-	case BPF_FUNC_cgrp_storage_delete:
-		return &bpf_cgrp_storage_delete_proto;
 	case BPF_FUNC_current_task_under_cgroup:
 		return &bpf_current_task_under_cgroup_proto;
 #endif
@@ -1513,20 +1467,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_send_signal_proto;
 	case BPF_FUNC_send_signal_thread:
 		return &bpf_send_signal_thread_proto;
-	case BPF_FUNC_perf_event_read_value:
-		return &bpf_perf_event_read_value_proto;
-	case BPF_FUNC_ringbuf_output:
-		return &bpf_ringbuf_output_proto;
-	case BPF_FUNC_ringbuf_reserve:
-		return &bpf_ringbuf_reserve_proto;
-	case BPF_FUNC_ringbuf_submit:
-		return &bpf_ringbuf_submit_proto;
-	case BPF_FUNC_ringbuf_discard:
-		return &bpf_ringbuf_discard_proto;
-	case BPF_FUNC_ringbuf_query:
-		return &bpf_ringbuf_query_proto;
-	case BPF_FUNC_jiffies64:
-		return &bpf_jiffies64_proto;
 	case BPF_FUNC_get_task_stack:
 		return prog->sleepable ? &bpf_get_task_stack_sleepable_proto
 				       : &bpf_get_task_stack_proto;
@@ -1534,12 +1474,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_copy_from_user_proto;
 	case BPF_FUNC_copy_from_user_task:
 		return &bpf_copy_from_user_task_proto;
-	case BPF_FUNC_snprintf_btf:
-		return &bpf_snprintf_btf_proto;
-	case BPF_FUNC_per_cpu_ptr:
-		return &bpf_per_cpu_ptr_proto;
-	case BPF_FUNC_this_cpu_ptr:
-		return &bpf_this_cpu_ptr_proto;
 	case BPF_FUNC_task_storage_get:
 		if (bpf_prog_check_recur(prog))
 			return &bpf_task_storage_get_recur_proto;
@@ -1548,18 +1482,12 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		if (bpf_prog_check_recur(prog))
 			return &bpf_task_storage_delete_recur_proto;
 		return &bpf_task_storage_delete_proto;
-	case BPF_FUNC_for_each_map_elem:
-		return &bpf_for_each_map_elem_proto;
-	case BPF_FUNC_snprintf:
-		return &bpf_snprintf_proto;
 	case BPF_FUNC_get_func_ip:
 		return &bpf_get_func_ip_proto_tracing;
 	case BPF_FUNC_get_branch_snapshot:
 		return &bpf_get_branch_snapshot_proto;
 	case BPF_FUNC_find_vma:
 		return &bpf_find_vma_proto;
-	case BPF_FUNC_trace_vprintk:
-		return bpf_get_trace_vprintk_proto();
 	default:
 		break;
 	}
-- 
2.43.0


