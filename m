Return-Path: <bpf+bounces-56481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13CBA9811E
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 09:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF1B16FC76
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83795268FF6;
	Wed, 23 Apr 2025 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TtIE0T5T"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8CB215771;
	Wed, 23 Apr 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393614; cv=none; b=CiHxXXAi3kbHcLs8aJU729tB0GBovso5k7pI+UjdWsFmjMRVvT4NSuLgLyg2IBxcA0/OS+KXt7O6uvHpAg6PgjIwWk92HDcIymcOYKbDIP8xT9VaxvHFxB22cWHiK4K2kkTy/hB1Ha4hffG2572ucOXUKi46LnUIifsoSCaru3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393614; c=relaxed/simple;
	bh=Dvyz6DITaxkdGp0a835ONmkSb8MvYzExGjAgvoMRHRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lj6AA9utY7TkSaDe4TIK8tIitdcXQYdd+53LZSSFLxvctnH/4I6abPfsgV2kyyjOBLNwRm9uZRvgME1oOxHMpD9eBxZbWnbun20dyaO9m1lrCcvHzMhvcrKdaAY0CO0gXljSjkiRqWJBvlFtTUhTACd/5owyjyzG0g5jpmXyxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TtIE0T5T; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MSxQX
	vQax8p9c+hmvlHTDibnsDBQVDBYA+HPPCGtZ74=; b=TtIE0T5TyFciWIB6aKQRs
	8VMYjsvHplMURfiVMt12Kyvo24xUzp313aQVI6VQIOF/zj13jx+S2MmtNpMfm5aD
	w6EbQdY4rXFRvL5IN9+ODR5TAuagWUcadQGcTZ/UAQLPVd5OxnVoCWOAHaIjppz1
	rA6m0OVvdAOfv4ENuMixUQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHqhNulwhohX4qAg--.21421S2;
	Wed, 23 Apr 2025 15:32:00 +0800 (CST)
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
Subject: [PATCH bpf-next v4] bpf: streamline allowed helpers between tracing and base sets
Date: Wed, 23 Apr 2025 15:31:51 +0800
Message-Id: <20250423073151.297103-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHqhNulwhohX4qAg--.21421S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF4fJry3WFyUtFyrAF17Awb_yoW3Xw1rpF
	sxtrW3Crs7tw4aqFy7Jr1fZa4Fk3srX3yUWa95Gw18ur4jvr47tF129F42gF1rAr98W347
	u3yvvFZ0kFy293JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ja4E_UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiThQ4eGgIPm4qYQABsg

From: Feng Yang <yangfeng@kylinos.cn>

Many conditional checks in switch-case are redundant
with bpf_base_func_proto and should be removed.

Regarding the permission checks bpf_base_func_proto:
The permission checks in bpf_prog_load (as outlined below)
ensure that the trace has both CAP_BPF and CAP_PERFMON capabilities,
thus enabling the use of corresponding prototypes
in bpf_base_func_proto without adverse effects.
bpf_prog_load
	......
	bpf_cap = bpf_token_capable(token, CAP_BPF);
	......
	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
	    type != BPF_PROG_TYPE_CGROUP_SKB &&
	    !bpf_cap)
		goto put_token;
	......
	if (is_perfmon_prog_type(type) && !bpf_token_capable(token, CAP_PERFMON))
		goto put_token;
	......

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Acked-by: Song Liu <song@kernel.org>
---
Changes in v4:
- Only modify patch description information.
- At present, bpf_tracing_func_proto still has the following ID:
- BPF_FUNC_get_current_uid_gid
- BPF_FUNC_get_current_comm
- BPF_FUNC_get_smp_processor_id
- BPF_FUNC_perf_event_read
- BPF_FUNC_probe_read
- BPF_FUNC_probe_read_str
- BPF_FUNC_current_task_under_cgroup
- BPF_FUNC_send_signal
- BPF_FUNC_send_signal_thread
- BPF_FUNC_get_task_stack
- BPF_FUNC_copy_from_user
- BPF_FUNC_copy_from_user_task
- BPF_FUNC_task_storage_get
- BPF_FUNC_task_storage_delete
- BPF_FUNC_get_func_ip
- BPF_FUNC_get_branch_snapshot
- BPF_FUNC_find_vma
- BPF_FUNC_probe_write_user
- I'm not sure which ones can be used by all programs, as Zvi Effron said(https://lore.kernel.org/all/CAC1LvL2SOKojrXPx92J46fFEi3T9TAWb3mC1XKtYzwU=pzTEbQ@mail.gmail.com/)
- get_smp_processor_id also be retained(https://lore.kernel.org/all/CAADnVQ+WYLfoR1W6AsCJF6fNKEUgfxANXP01EQCJh1=99ZpoNw@mail.gmail.com/)

- Link to v3: https://lore.kernel.org/all/20250410070258.276759-1-yangfeng59949@163.com/

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
index 0f5906f43d7c..52c432a44aeb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1430,56 +1430,14 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -1489,10 +1447,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -1500,20 +1454,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -1521,12 +1461,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -1535,18 +1469,12 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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


