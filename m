Return-Path: <bpf+bounces-47306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0659C9F755E
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 08:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D3A188ADE6
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307F216E39;
	Thu, 19 Dec 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mw+6XVRm"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038E524F;
	Thu, 19 Dec 2024 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734593081; cv=none; b=uDDAYntznMOllko0Wd/QGhJxXPkKllAr2mR3oABei5UujzMaeaqBX4p3Kj28ivSGBqDLoRUeOVewHak6ydXX+AfIdQOwIJQ8MEGfrOzpCfxfuT4cY4YUX8r7muXD2ujiQr9gVEl9uvVeIf6o5NvB84EZxfjvm0yXjvVohorpgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734593081; c=relaxed/simple;
	bh=MZ56Gk24lso758TZZGrga25F7eajp0AXtFgCuXVL4EY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TTv7kAcChZsJRPj6IB8dRi3RnRlYDNX1jc8fss6VLyxq+0uvdd64L4pcd5GOfjdGUpLkTwT+YtKmJTjkPo9GNFeb9OnyinAEo9IjZzWM3r4DHP9s49ynhAjw/CLKgc6gFt7mf8gdvg+ztwFWsVZdNfUk2r99dDUIm1V496NSNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mw+6XVRm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734593073;
	bh=MZ56Gk24lso758TZZGrga25F7eajp0AXtFgCuXVL4EY=;
	h=From:Date:Subject:To:Cc:From;
	b=mw+6XVRmktGF2ySJzZBhU7eaFhFMdjMWFG1GSKwUMgtsY8mZvf2qcyt7ML1TQ1sWP
	 A6aVq1BNqgg2V+RowPXxq9CzYWLp4vyq8RwG+iTweakVwxg96D7PDsT9A9oHwZZXqT
	 jsaJ2Nw+Ly+KYOQewNrKr3gVYbHKjo6eeu/q9ZPA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 19 Dec 2024 08:24:28 +0100
Subject: [PATCH bpf v2] bpf: fix configuration-dependent BTF function
 references
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241219-bpf-cond-ids-v2-1-8f121cae5374@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACvKY2cC/1WNTQ7CIBCFr9LMWoyDxBZXvYfpQmAqs6ENU6um6
 d0lxI3L9/e9DYQyk8C12SDTysJTKkIfGvDxnh6kOBQN+qQNatTKzaPyUwrFF2Xd6PzFhNC2Dsp
 kzjTyu+JuUJowFDOyLFP+1IsVa/Sjnf9pKypUXYedsda2Gm3/IhYRH5/xmGiBYd/3LxMI4j6yA
 AAA
X-Change-ID: 20241212-bpf-cond-ids-9bfbc64dd77b
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734593072; l=4129;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=MZ56Gk24lso758TZZGrga25F7eajp0AXtFgCuXVL4EY=;
 b=z2K9l+WIlFYVMd0/pvMGRnrWKjzPn6JGxv8baJYB+1odyIhgHX38udxrhThvGNDbBKxQqi0Ep
 MeYjiHT1F5wBnVSg1W6SFfZQKq08NaBytQz5unRjDDoOAFF5xYy/9At
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These BTF functions are not available unconditionally,
only reference them when they are available.

Avoid the following build warnings:

  BTF     .tmp_vmlinux1.btf.o
btf_encoder__tag_kfunc: failed to find kfunc 'bpf_send_signal_task' in BTF
btf_encoder__tag_kfuncs: failed to tag kfunc 'bpf_send_signal_task'
  NM      .tmp_vmlinux1.syms
  KSYMS   .tmp_vmlinux1.kallsyms.S
  AS      .tmp_vmlinux1.kallsyms.o
  LD      .tmp_vmlinux2
  NM      .tmp_vmlinux2.syms
  KSYMS   .tmp_vmlinux2.kallsyms.S
  AS      .tmp_vmlinux2.kallsyms.o
  LD      vmlinux
  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol prog_test_ref_kfunc
WARN: resolve_btfids: unresolved symbol bpf_crypto_ctx
WARN: resolve_btfids: unresolved symbol bpf_send_signal_task
WARN: resolve_btfids: unresolved symbol bpf_modify_return_test_tp
WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Properly use BTF_ID_UNUSED in special_kfunc_list()
- Link to v1: https://lore.kernel.org/r/20241213-bpf-cond-ids-v1-1-881849997219@weissschuh.net
---
 kernel/bpf/helpers.c  |  4 ++++
 kernel/bpf/verifier.c | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 751c150f9e1cd7f56e6a2b68a7ebb4ae89a30d2d..5edf5436a7804816b7dcf1bbef2624d71a985f20 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3089,7 +3089,9 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+#ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task, KF_TRUSTED_ARGS)
+#endif
 BTF_KFUNCS_END(generic_btf_ids)
 
 static const struct btf_kfunc_id_set generic_kfunc_set = {
@@ -3135,7 +3137,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
 BTF_ID_FLAGS(func, bpf_dynptr_size)
 BTF_ID_FLAGS(func, bpf_dynptr_clone)
+#ifdef CONFIG_NET
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
+#endif
 BTF_ID_FLAGS(func, bpf_wq_init)
 BTF_ID_FLAGS(func, bpf_wq_set_callback_impl)
 BTF_ID_FLAGS(func, bpf_wq_start)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77f56674aaa99a0b88ced5100ba57409e255fd29..2704fa4477ee2504897c82f0416aa7d61fb086ed 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5507,7 +5507,9 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
 
 /* Once GCC supports btf_type_tag the following mechanism will be replaced with tag check */
 BTF_SET_START(rcu_protected_types)
+#ifdef CONFIG_NET
 BTF_ID(struct, prog_test_ref_kfunc)
+#endif
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 #endif
@@ -5515,7 +5517,9 @@ BTF_ID(struct, cgroup)
 BTF_ID(struct, bpf_cpumask)
 #endif
 BTF_ID(struct, task_struct)
+#ifdef CONFIG_CRYPTO
 BTF_ID(struct, bpf_crypto_ctx)
+#endif
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
@@ -11486,8 +11490,10 @@ BTF_ID(func, bpf_rdonly_cast)
 BTF_ID(func, bpf_rbtree_remove)
 BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
+#ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
+#endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
@@ -11515,8 +11521,13 @@ BTF_ID(func, bpf_rcu_read_unlock)
 BTF_ID(func, bpf_rbtree_remove)
 BTF_ID(func, bpf_rbtree_add_impl)
 BTF_ID(func, bpf_rbtree_first)
+#ifdef CONFIG_NET
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
+#else
+BTF_ID_UNUSED
+BTF_ID_UNUSED
+#endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)

---
base-commit: d9df5df183eede1041cbd5ff1d776e94757e338b
change-id: 20241212-bpf-cond-ids-9bfbc64dd77b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


