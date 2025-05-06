Return-Path: <bpf+bounces-57490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD02AABBE3
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 09:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D45C5A1A65
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB05230BF5;
	Tue,  6 May 2025 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jEcGWyZC"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F222FE19;
	Tue,  6 May 2025 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512165; cv=none; b=rAlY2fr5xgfJCccYfdhmFvFNEVNnKYjS9owt+2Xnu2fFJkTcRw9RRKO8pEe+3RfKcOwcmj0dnuC/mg7HBnINV39CMOyCYRBEQohn0IpG05tllzbujHJPprczeCuKbOfASJ4HOncCP/tF7l1W1Y4M9dWMr7ea00o2TAFz/ETtllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512165; c=relaxed/simple;
	bh=m/YuZWTrF+/VKXcdgsVWFgzOjKkSJoAFggYtbEIxQrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUYk8mktACBjXmCptSAJbuWUvRvZvmEVNkHnEtaSuVJV52Hm/gvQROfo57fYp0BDiiuduRVbk57iUhY2pBbRSsIXyDSbPz/RGbYALKNuFFb+4myu8/aJe2SDTxBujEegl7UIs5niNopsIwYwFDyRLlTzBSHGR2hz3Dg2TKBlCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jEcGWyZC; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=1oLdb
	NIqNor65xbuBeDYQarWcsYm8bDfHLUM/7iMxmg=; b=jEcGWyZCAAupQ692JM6Qp
	q3sC7Usms/eXIPaYwRiyPJDWcGo7uHn/Xli2N/MaOGv0cZokUWRP9j6N0c2Yg5TK
	x83wY1a9Oo1sNYyaqMfx106h3pRXuxUttt/Oj8brIGCuFUqXAmXmOFdpP3HGeC5S
	hKixw8qndlgv5+urVqrX7w=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnylfLqBlovwXpBw--.23593S3;
	Tue, 06 May 2025 14:14:37 +0800 (CST)
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
	davem@davemloft.net,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 bpf-next 1/2] bpf: Allow some trace helpers for all prog types
Date: Tue,  6 May 2025 14:14:33 +0800
Message-Id: <20250506061434.94277-2-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506061434.94277-1-yangfeng59949@163.com>
References: <20250506061434.94277-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBnylfLqBlovwXpBw--.23593S3
X-Coremail-Antispam: 1Uf129KBjvAXoW3trW7CFWfAw1DZFy8CrW7urg_yoW8Jw1kAo
	W2vF1YvF48Krn5Z34UAr1qkasxWF15Jr95GF4fXr4DCFW8Aa45Aw17Aa1xu3y7WFyYyr4D
	AF95Ja4Sqa1DC39xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxE_MUUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiwg9FeGgZovWwYgABsF

From: Feng Yang <yangfeng@kylinos.cn>

if it works under NMI and doesn't use any context-dependent things,
should be fine for any program type. The detailed discussion is in [1].

[1] https://lore.kernel.org/all/CAEf4Bza6gK3dsrTosk6k3oZgtHesNDSrDd8sdeQ-GiS6oJixQg@mail.gmail.com/

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 include/linux/bpf-cgroup.h |  8 --------
 kernel/bpf/cgroup.c        | 32 -----------------------------
 kernel/bpf/helpers.c       | 42 ++++++++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c   | 41 ++++---------------------------------
 net/core/filter.c          | 14 -------------
 5 files changed, 46 insertions(+), 91 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 9de7adb68294..4847dcade917 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -427,8 +427,6 @@ int cgroup_bpf_prog_query(const union bpf_attr *attr,
 
 const struct bpf_func_proto *
 cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
-const struct bpf_func_proto *
-cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 #else
 
 static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
@@ -465,12 +463,6 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	return NULL;
 }
 
-static inline const struct bpf_func_proto *
-cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-{
-	return NULL;
-}
-
 static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
 					    struct bpf_map *map) { return 0; }
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 84f58f3d028a..62a1d8deb3dc 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1653,10 +1653,6 @@ cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	if (func_proto)
 		return func_proto;
 
-	func_proto = cgroup_current_func_proto(func_id, prog);
-	if (func_proto)
-		return func_proto;
-
 	switch (func_id) {
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
@@ -2204,10 +2200,6 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	if (func_proto)
 		return func_proto;
 
-	func_proto = cgroup_current_func_proto(func_id, prog);
-	if (func_proto)
-		return func_proto;
-
 	switch (func_id) {
 	case BPF_FUNC_sysctl_get_name:
 		return &bpf_sysctl_get_name_proto;
@@ -2351,10 +2343,6 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	if (func_proto)
 		return func_proto;
 
-	func_proto = cgroup_current_func_proto(func_id, prog);
-	if (func_proto)
-		return func_proto;
-
 	switch (func_id) {
 #ifdef CONFIG_NET
 	case BPF_FUNC_get_netns_cookie:
@@ -2601,23 +2589,3 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return NULL;
 	}
 }
-
-/* Common helpers for cgroup hooks with valid process context. */
-const struct bpf_func_proto *
-cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-{
-	switch (func_id) {
-	case BPF_FUNC_get_current_uid_gid:
-		return &bpf_get_current_uid_gid_proto;
-	case BPF_FUNC_get_current_comm:
-		return &bpf_get_current_comm_proto;
-#ifdef CONFIG_CGROUP_NET_CLASSID
-	case BPF_FUNC_get_cgroup_classid:
-		return &bpf_get_cgroup_classid_curr_proto;
-#endif
-	case BPF_FUNC_current_task_under_cgroup:
-		return &bpf_current_task_under_cgroup_proto;
-	default:
-		return NULL;
-	}
-}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..c42b6c331461 100644
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
@@ -2022,7 +2031,21 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_cgroup_id_proto;
 	case BPF_FUNC_get_current_ancestor_cgroup_id:
 		return &bpf_get_current_ancestor_cgroup_id_proto;
+	case BPF_FUNC_current_task_under_cgroup:
+		return &bpf_current_task_under_cgroup_proto;
 #endif
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	case BPF_FUNC_get_cgroup_classid:
+		return &bpf_get_cgroup_classid_curr_proto;
+#endif
+	case BPF_FUNC_task_storage_get:
+		if (bpf_prog_check_recur(prog))
+			return &bpf_task_storage_get_recur_proto;
+		return &bpf_task_storage_get_proto;
+	case BPF_FUNC_task_storage_delete:
+		if (bpf_prog_check_recur(prog))
+			return &bpf_task_storage_delete_recur_proto;
+		return &bpf_task_storage_delete_proto;
 	default:
 		break;
 	}
@@ -2037,6 +2060,8 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_task_proto;
 	case BPF_FUNC_get_current_task_btf:
 		return &bpf_get_current_task_btf_proto;
+	case BPF_FUNC_get_current_comm:
+		return &bpf_get_current_comm_proto;
 	case BPF_FUNC_probe_read_user:
 		return &bpf_probe_read_user_proto;
 	case BPF_FUNC_probe_read_kernel:
@@ -2047,6 +2072,10 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
@@ -2057,6 +2086,19 @@ bpf_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
index 79cab4d78dc3..30e7d3679088 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8022,10 +8022,6 @@ sock_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	if (func_proto)
 		return func_proto;
 
-	func_proto = cgroup_current_func_proto(func_id, prog);
-	if (func_proto)
-		return func_proto;
-
 	switch (func_id) {
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_sock_proto;
@@ -8051,10 +8047,6 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	if (func_proto)
 		return func_proto;
 
-	func_proto = cgroup_current_func_proto(func_id, prog);
-	if (func_proto)
-		return func_proto;
-
 	switch (func_id) {
 	case BPF_FUNC_bind:
 		switch (prog->expected_attach_type) {
@@ -8488,18 +8480,12 @@ sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_msg_pop_data_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-	case BPF_FUNC_get_current_uid_gid:
-		return &bpf_get_current_uid_gid_proto;
 	case BPF_FUNC_sk_storage_get:
 		return &bpf_sk_storage_get_proto;
 	case BPF_FUNC_sk_storage_delete:
 		return &bpf_sk_storage_delete_proto;
 	case BPF_FUNC_get_netns_cookie:
 		return &bpf_get_netns_cookie_sk_msg_proto;
-#ifdef CONFIG_CGROUP_NET_CLASSID
-	case BPF_FUNC_get_cgroup_classid:
-		return &bpf_get_cgroup_classid_curr_proto;
-#endif
 	default:
 		return bpf_sk_base_func_proto(func_id, prog);
 	}
-- 
2.43.0


