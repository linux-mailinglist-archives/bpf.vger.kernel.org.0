Return-Path: <bpf+bounces-55437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA9A7F5BA
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 09:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26795189859D
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3862326139C;
	Tue,  8 Apr 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OClhXKoB"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2386E26138B;
	Tue,  8 Apr 2025 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744096391; cv=none; b=Gz17tScl7Ih+jN+P3reuMR/es4S9n3K9SMUApZ8S0hU+PZguP3FcVU72eQzSTMLcEmzXcrzTc4kfvk7+3ms8Kyb9n3btOj0DaWV6X7tb3v/EaCfiW8jcdFSbpqkfBuNKU6AK0AvKhFKCG/XA83+UVsTswrsP/LUXJJPR8Zq/gc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744096391; c=relaxed/simple;
	bh=boIkEt8dItdsmjNV3paAR24yWpziMldq7x6bxy4tfA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sZN9unL9KiZ3FQ94Ash148JeS5eK/UcY6+9faxFu9S8dqYR8GyQBj085A0B1rhrZ/pbxTPBTpYd7SgMeh0dlcHtCx9OsM9XwfDgruWEjipLiDuPtLaI2TX3iSctg+iUtDclG4wAYilZQGnIP3Qmn6VrOdlOePQNdfZhq4RhLEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OClhXKoB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=TjmkK
	cbdBteYcdY1oy1hg8QPf8yjTbl5uA4hIJiAC/4=; b=OClhXKoBVIv13mx9VO4ew
	bUgmbfurlhtCYplCbHY6gtyUeNYRTugY3eB7aG0BvrFQbk4nJ6ZIvrbmuoxFR+Y/
	V8GVXR0GCLrccuANfkq/XExz1huncWXPF29tu8d1iBWyxZpgjXkXdhfkr0C7FP2I
	4Qr1JO63kpsBFfVlyPfS8k=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCHEuM3zPRnLTyQTw--.34625S2;
	Tue, 08 Apr 2025 15:11:52 +0800 (CST)
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
Subject: [PATCH bpf-next v2] bpf: Remove duplicate judgments
Date: Tue,  8 Apr 2025 15:11:51 +0800
Message-Id: <20250408071151.229329-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCHEuM3zPRnLTyQTw--.34625S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww4rZF4DKF45XF43Zr1kXwb_yoW7Zw1kpF
	nxtrZxCrs2vw42qFy7Jr1fZa4Yy3srZ3yUWaykKw18ur4UZr4xtF12kF42gF1rAr98G347
	u3yvvFZ0kFyI93JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeksgUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwhApeGf0xeHvSgAAsR

From: Feng Yang <yangfeng@kylinos.cn>

Many judgments and bpf_base_func_proto functions are repetitive, remove them.

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Acked-by: Song Liu <song@kernel.org>
---
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


