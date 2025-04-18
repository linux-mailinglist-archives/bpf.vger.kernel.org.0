Return-Path: <bpf+bounces-56221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB677A930F5
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 05:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080FC8E294D
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 03:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9098267B9A;
	Fri, 18 Apr 2025 03:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P5cKFKig"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B34770E2;
	Fri, 18 Apr 2025 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947701; cv=none; b=uR7a6nN10Y/jjhreDwhd/nk8h5qIQKCnp93G32wQZO5JGL6w9qGXD0L53YFjOIUTscJqfKfXURKe5P2i7drIU8zoFbOAHASTSZMkmO/D06j8ckry20QHAn8x5ccPmvuOQ2DsjLzuwnAM1maGcCvMoMlEK1jEBkjxWN9Vb+Pc87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947701; c=relaxed/simple;
	bh=lBgE/VTwfPL/98uIqYAL2OGCRqK6PQxVZcPsVcJjVlo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ouTrZrEwTTyovL9LJGtS31bqAXXvbPnJfBZfKHHuv/af0jqoOpSLJXVFuHJ4qp1Dgmjic0ZtKTrJwW9oVLGTKuzWrq2gxBTGi5acAxXNzMb+hfzmwTeg1oubiW5Rv3FbYmaE7LJ7zx2DQawmOva4YHYxvsmd3zeL1qkUbNgxL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P5cKFKig; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Q1buKkeBBzshig53X4
	Su1cjMDcBScgw+OeLMBh2Msks=; b=P5cKFKigmEICtLzPFpjFmLX7oCVSe5PpwZ
	LhViNNa8ObsMph7IET805fCHhSxCcr2fnq+UM27qFfwGMK1/ynvP8P492C1moLz+
	vdXoGuRkHOuEXmC4abIlXslW72BVJEV1xCo5nv0uQtFCXl7sPN5jEZ6Zet8MOHwM
	iOEalOxUE=
Received: from yang-Virtual-Machine.mshome.net (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAHp3fKyQFo8gRoAg--.90S2;
	Fri, 18 Apr 2025 11:40:58 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Feng Yang <yangfeng@kylinos.cn>
Subject: [PATCH bpf-next] bpf: Remove bpf_get_smp_processor_id_proto
Date: Fri, 18 Apr 2025 11:40:55 +0800
Message-Id: <20250418034055.5757-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wAHp3fKyQFo8gRoAg--.90S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWDWFW8Ww43GrWUWw1rWFg_yoWrurWUpF
	n8Ary3Cr4kta1aq3srJrs2va45A34UZ3y8Ca48G34Y9r4qvr9rt3WUtF4a9FyrZry2k343
	Aa1jqrWYkryIqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UD739UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTg0zeGgBxEjF+AAAsQ
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

From: Feng Yang <yangfeng@kylinos.cn>

All BPF programs either disable CPU preemption or CPU migration,
so the bpf_get_smp_processor_id_proto can be safely removed,
and the bpf_get_raw_smp_processor_id_proto in bpf_base_func_proto works perfectly.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 include/linux/bpf.h      |  1 -
 kernel/bpf/core.c        |  1 -
 kernel/bpf/helpers.c     | 12 ------------
 kernel/trace/bpf_trace.c |  2 --
 net/core/filter.c        |  6 ------
 5 files changed, 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3f0cc89c0622..36e525141556 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3316,7 +3316,6 @@ extern const struct bpf_func_proto bpf_map_peek_elem_proto;
 extern const struct bpf_func_proto bpf_map_lookup_percpu_elem_proto;
 
 extern const struct bpf_func_proto bpf_get_prandom_u32_proto;
-extern const struct bpf_func_proto bpf_get_smp_processor_id_proto;
 extern const struct bpf_func_proto bpf_get_numa_node_id_proto;
 extern const struct bpf_func_proto bpf_tail_call_proto;
 extern const struct bpf_func_proto bpf_ktime_get_ns_proto;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ba6b6118cf50..1ad41a16b86e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2943,7 +2943,6 @@ const struct bpf_func_proto bpf_spin_unlock_proto __weak;
 const struct bpf_func_proto bpf_jiffies64_proto __weak;
 
 const struct bpf_func_proto bpf_get_prandom_u32_proto __weak;
-const struct bpf_func_proto bpf_get_smp_processor_id_proto __weak;
 const struct bpf_func_proto bpf_get_numa_node_id_proto __weak;
 const struct bpf_func_proto bpf_ktime_get_ns_proto __weak;
 const struct bpf_func_proto bpf_ktime_get_boot_ns_proto __weak;
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..2d2bfb2911f8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -149,18 +149,6 @@ const struct bpf_func_proto bpf_get_prandom_u32_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
-BPF_CALL_0(bpf_get_smp_processor_id)
-{
-	return smp_processor_id();
-}
-
-const struct bpf_func_proto bpf_get_smp_processor_id_proto = {
-	.func		= bpf_get_smp_processor_id,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-	.allow_fastcall	= true,
-};
-
 BPF_CALL_0(bpf_get_numa_node_id)
 {
 	return numa_node_id();
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0f5906f43d7c..39360cd6baf1 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1462,8 +1462,6 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_comm_proto;
 	case BPF_FUNC_trace_printk:
 		return bpf_get_trace_printk_proto();
-	case BPF_FUNC_get_smp_processor_id:
-		return &bpf_get_smp_processor_id_proto;
 	case BPF_FUNC_get_numa_node_id:
 		return &bpf_get_numa_node_id_proto;
 	case BPF_FUNC_perf_event_read:
diff --git a/net/core/filter.c b/net/core/filter.c
index bc6828761a47..7f7ec913ddbc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8264,8 +8264,6 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_set_hash_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_skb_event_output_proto;
-	case BPF_FUNC_get_smp_processor_id:
-		return &bpf_get_smp_processor_id_proto;
 	case BPF_FUNC_skb_under_cgroup:
 		return &bpf_skb_under_cgroup_proto;
 	case BPF_FUNC_get_socket_cookie:
@@ -8343,8 +8341,6 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	switch (func_id) {
 	case BPF_FUNC_perf_event_output:
 		return &bpf_xdp_event_output_proto;
-	case BPF_FUNC_get_smp_processor_id:
-		return &bpf_get_smp_processor_id_proto;
 	case BPF_FUNC_csum_diff:
 		return &bpf_csum_diff_proto;
 	case BPF_FUNC_xdp_adjust_head:
@@ -8570,8 +8566,6 @@ lwt_out_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_hash_recalc_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_skb_event_output_proto;
-	case BPF_FUNC_get_smp_processor_id:
-		return &bpf_get_smp_processor_id_proto;
 	case BPF_FUNC_skb_under_cgroup:
 		return &bpf_skb_under_cgroup_proto;
 	default:
-- 
2.39.0.windows.2


