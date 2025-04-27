Return-Path: <bpf+bounces-56797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B535A9DFF8
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 08:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D392460991
	for <lists+bpf@lfdr.de>; Sun, 27 Apr 2025 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B652405FD;
	Sun, 27 Apr 2025 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WYyjQOhZ"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5773719F43A;
	Sun, 27 Apr 2025 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745735973; cv=none; b=tLGXSfdMAMzbszQETOJfARs+gwI/T2N8uRA1hj2a3GDgiBM7VZIwZNoRi1R5p7MZI/EM1L+JndESBVjfuYrMzR2MKZGbetY9nCN9uWFxtGuYB2vN8hUDuwgI+5nUdobJ9lfFsZtbcHOMmlVBVkXcgaRomZr6KgxAYg+nSIVdy/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745735973; c=relaxed/simple;
	bh=1KUTe4VJP1xNF2VNHwy4i7kAovjH09ZQfopHkdFD8bI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9AM7YOI9pIU1DLuvcT3jU5FxuSfTG/p8dD6o+KAaHwk/GiZmkgSvdvthwYGFgNb4HRUqGTPAvD7Gb1qRuDw9TYA9fz0AoSV3/Ggp4zYVzdQ0FxTf0fqj5C/piSxk+0WIBBnYozPffqCQJ8M5bmPZvBn1zqaqP+2Bi+bD63WpKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WYyjQOhZ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LnP2a
	VLj/uA1xUaM2LTPsV7mUmvBriC6e38+xa5mYGA=; b=WYyjQOhZ+M41ksbyED8XK
	zBHsJ6UFKT52oHrUtCCDjmAJIhL1qa54to/PPVkMMRYrIRniq9FM1Ni+Jjke0hi3
	AP86h0IvDl4kt0B194RttAiikeBnLCDf7ScLdSkwjx5/99kZi7UsJsO3Zd3RCUTt
	SNy+XZ77wyPfnDhypUNI1g=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAnH_Ld0A1oUVz9Cw--.8800S2;
	Sun, 27 Apr 2025 14:38:23 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
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
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 bpf-next] bpf: Allow some trace helpers for all prog types
Date: Sun, 27 Apr 2025 14:38:21 +0800
Message-Id: <20250427063821.207263-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnH_Ld0A1oUVz9Cw--.8800S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3trW7tF1UtFy5tF1rGF43Awb_yoWDWry5pF
	nrAr9xCr4kt3yaqr17Jwn7Z34Fy34DX3yUGayDGw1xur42vry7tF1UKF42gF1rAr9rW347
	Z3yqvFZ0kw1Iga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ja4E_UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTgA6eGgLtSPFxQABs4

From: Feng Yang <yangfeng@kylinos.cn>

if it works under NMI and doesn't use any context-dependent things,
should be fine for any program type. The detailed discussion is in [1].

[1] https://lore.kernel.org/all/CAEf4Bza6gK3dsrTosk6k3oZgtHesNDSrDd8sdeQ-GiS6oJixQg@mail.gmail.com/

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v2:
- not expose compat probe read APIs to more program types.
- Remove the prog->sleepable check added for copy_from_user,
- or the summarization_freplace/might_sleep_with_might_sleep test will fail with the error "program of this type cannot use helper bpf_copy_from_user"
- Link to v1: https://lore.kernel.org/all/20250425080032.327477-1-yangfeng59949@163.com/
---
 kernel/bpf/cgroup.c      |  6 ------
 kernel/bpf/helpers.c     | 38 +++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c | 41 ++++------------------------------------
 net/core/filter.c        |  2 --
 4 files changed, 42 insertions(+), 45 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a..dbdad5f42761 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2607,16 +2607,10 @@ const struct bpf_func_proto *
 cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
-	case BPF_FUNC_get_current_uid_gid:
-		return &bpf_get_current_uid_gid_proto;
-	case BPF_FUNC_get_current_comm:
-		return &bpf_get_current_comm_proto;
 #ifdef CONFIG_CGROUP_NET_CLASSID
 	case BPF_FUNC_get_cgroup_classid:
 		return &bpf_get_cgroup_classid_curr_proto;
 #endif
-	case BPF_FUNC_current_task_under_cgroup:
-		return &bpf_current_task_under_cgroup_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..a01a2e55e17d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#include <linux/bpf_verifier.h>
 
 #include "../../lib/kstrtox.h"
 
@@ -1912,6 +1913,12 @@ const struct bpf_func_proto bpf_probe_read_user_str_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_proto __weak;
 const struct bpf_func_proto bpf_probe_read_kernel_str_proto __weak;
 const struct bpf_func_proto bpf_task_pt_regs_proto __weak;
+const struct bpf_func_proto bpf_perf_event_read_proto __weak;
+const struct bpf_func_proto bpf_send_signal_proto __weak;
+const struct bpf_func_proto bpf_send_signal_thread_proto __weak;
+const struct bpf_func_proto bpf_get_task_stack_sleepable_proto __weak;
+const struct bpf_func_proto bpf_get_task_stack_proto __weak;
+const struct bpf_func_proto bpf_get_branch_snapshot_proto __weak;
 
 const struct bpf_func_proto *
 bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
@@ -1965,6 +1972,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_pid_tgid_proto;
 	case BPF_FUNC_get_ns_current_pid_tgid:
 		return &bpf_get_ns_current_pid_tgid_proto;
+	case BPF_FUNC_get_current_uid_gid:
+		return &bpf_get_current_uid_gid_proto;
 	default:
 		break;
 	}
@@ -2022,6 +2031,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_cgroup_id_proto;
 	case BPF_FUNC_get_current_ancestor_cgroup_id:
 		return &bpf_get_current_ancestor_cgroup_id_proto;
+	case BPF_FUNC_current_task_under_cgroup:
+		return &bpf_current_task_under_cgroup_proto;
 #endif
 	default:
 		break;
@@ -2037,6 +2048,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_task_proto;
 	case BPF_FUNC_get_current_task_btf:
 		return &bpf_get_current_task_btf_proto;
+	case BPF_FUNC_get_current_comm:
+		return &bpf_get_current_comm_proto;
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
@@ -2047,6 +2060,10 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_probe_read_kernel_str:
 		return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
 		       NULL : &bpf_probe_read_kernel_str_proto;
+	case BPF_FUNC_copy_from_user:
+		return &bpf_copy_from_user_proto;
+	case BPF_FUNC_copy_from_user_task:
+		return &bpf_copy_from_user_task_proto;
 	case BPF_FUNC_snprintf_btf:
 		return &bpf_snprintf_btf_proto;
 	case BPF_FUNC_snprintf:
@@ -2057,6 +2074,27 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return bpf_get_trace_vprintk_proto();
 	case BPF_FUNC_perf_event_read_value:
 		return bpf_get_perf_event_read_value_proto();
+	case BPF_FUNC_perf_event_read:
+		return &bpf_perf_event_read_proto;
+	case BPF_FUNC_send_signal:
+		return &bpf_send_signal_proto;
+	case BPF_FUNC_send_signal_thread:
+		return &bpf_send_signal_thread_proto;
+	case BPF_FUNC_get_task_stack:
+		return prog->sleepable ? &bpf_get_task_stack_sleepable_proto
+				       : &bpf_get_task_stack_proto;
+	case BPF_FUNC_task_storage_get:
+		if (bpf_prog_check_recur(prog))
+			return &bpf_task_storage_get_recur_proto;
+		return &bpf_task_storage_get_proto;
+	case BPF_FUNC_task_storage_delete:
+		if (bpf_prog_check_recur(prog))
+			return &bpf_task_storage_delete_recur_proto;
+		return &bpf_task_storage_delete_proto;
+	case BPF_FUNC_get_branch_snapshot:
+		return &bpf_get_branch_snapshot_proto;
+	case BPF_FUNC_find_vma:
+		return &bpf_find_vma_proto;
 	default:
 		return NULL;
 	}
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 52c432a44aeb..868920994517 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -572,7 +572,7 @@ BPF_CALL_2(bpf_perf_event_read, struct bpf_map *, map, u64, flags)
 	return value;
 }
 
-static const struct bpf_func_proto bpf_perf_event_read_proto = {
+const struct bpf_func_proto bpf_perf_event_read_proto = {
 	.func		= bpf_perf_event_read,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
@@ -882,7 +882,7 @@ BPF_CALL_1(bpf_send_signal, u32, sig)
 	return bpf_send_signal_common(sig, PIDTYPE_TGID, NULL, 0);
 }
 
-static const struct bpf_func_proto bpf_send_signal_proto = {
+const struct bpf_func_proto bpf_send_signal_proto = {
 	.func		= bpf_send_signal,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
@@ -894,7 +894,7 @@ BPF_CALL_1(bpf_send_signal_thread, u32, sig)
 	return bpf_send_signal_common(sig, PIDTYPE_PID, NULL, 0);
 }
 
-static const struct bpf_func_proto bpf_send_signal_thread_proto = {
+const struct bpf_func_proto bpf_send_signal_thread_proto = {
 	.func		= bpf_send_signal_thread,
 	.gpl_only	= false,
 	.ret_type	= RET_INTEGER,
@@ -1185,7 +1185,7 @@ BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
 	return entry_cnt * br_entry_size;
 }
 
-static const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
+const struct bpf_func_proto bpf_get_branch_snapshot_proto = {
 	.func		= bpf_get_branch_snapshot,
 	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
@@ -1430,14 +1430,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	const struct bpf_func_proto *func_proto;
 
 	switch (func_id) {
-	case BPF_FUNC_get_current_uid_gid:
-		return &bpf_get_current_uid_gid_proto;
-	case BPF_FUNC_get_current_comm:
-		return &bpf_get_current_comm_proto;
 	case BPF_FUNC_get_smp_processor_id:
 		return &bpf_get_smp_processor_id_proto;
-	case BPF_FUNC_perf_event_read:
-		return &bpf_perf_event_read_proto;
 #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	case BPF_FUNC_probe_read:
 		return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
@@ -1446,35 +1440,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return security_locked_down(LOCKDOWN_BPF_READ_KERNEL) < 0 ?
 		       NULL : &bpf_probe_read_compat_str_proto;
 #endif
-#ifdef CONFIG_CGROUPS
-	case BPF_FUNC_current_task_under_cgroup:
-		return &bpf_current_task_under_cgroup_proto;
-#endif
-	case BPF_FUNC_send_signal:
-		return &bpf_send_signal_proto;
-	case BPF_FUNC_send_signal_thread:
-		return &bpf_send_signal_thread_proto;
-	case BPF_FUNC_get_task_stack:
-		return prog->sleepable ? &bpf_get_task_stack_sleepable_proto
-				       : &bpf_get_task_stack_proto;
-	case BPF_FUNC_copy_from_user:
-		return &bpf_copy_from_user_proto;
-	case BPF_FUNC_copy_from_user_task:
-		return &bpf_copy_from_user_task_proto;
-	case BPF_FUNC_task_storage_get:
-		if (bpf_prog_check_recur(prog))
-			return &bpf_task_storage_get_recur_proto;
-		return &bpf_task_storage_get_proto;
-	case BPF_FUNC_task_storage_delete:
-		if (bpf_prog_check_recur(prog))
-			return &bpf_task_storage_delete_recur_proto;
-		return &bpf_task_storage_delete_proto;
 	case BPF_FUNC_get_func_ip:
 		return &bpf_get_func_ip_proto_tracing;
-	case BPF_FUNC_get_branch_snapshot:
-		return &bpf_get_branch_snapshot_proto;
-	case BPF_FUNC_find_vma:
-		return &bpf_find_vma_proto;
 	default:
 		break;
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 79cab4d78dc3..53bf560354f7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8488,8 +8488,6 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_msg_pop_data_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-	case BPF_FUNC_get_current_uid_gid:
-		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
-- 
2.43.0


