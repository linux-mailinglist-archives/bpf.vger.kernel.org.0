Return-Path: <bpf+bounces-46750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0A39EFFBA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B04D2827FF
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDA01DE8BA;
	Thu, 12 Dec 2024 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Pbpk/0fs"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5DF1D8DFB;
	Thu, 12 Dec 2024 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044441; cv=none; b=jbnXmLzZ1lLsOboWLvmty4545Y6hnFpG7rHC9x1kdm2Roxny7fWtclrLRtHVezpiLcDfmuW69LMTvolV6qub1GhPS30GKvjiyMX2aSVBKG2taACro2ubYMxytvLuctInhBNk88oBs7vzyGu7cFQygZXt2FG/8df/rvsyOEfsMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044441; c=relaxed/simple;
	bh=7QLwXxqiXHK9GxQGN/b7k3jlhS5iyReQ14GxQy93dNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Df+AfC5z7ObOqLDqhnGlz2Qiazlis7znHt+xeAB6hNPoOus/2kIFqaiMcaVV1SoqxzoUTGw+snq3n/V5jUXJbSC3dmAYfPT0dPgTTgKnEkqx3k5kMyHqv/+8CD8cJufw+o4BtY+SflCSvRFhgHM71ne9c2YCM4jVHkt3cIryves=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Pbpk/0fs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734044433;
	bh=7QLwXxqiXHK9GxQGN/b7k3jlhS5iyReQ14GxQy93dNU=;
	h=From:Date:Subject:To:Cc:From;
	b=Pbpk/0fsso5FSs5n/+B28RE7/sErOBu8T/HW8+y+LEoSVyvkUWbP3vFl/clLfVwml
	 M2P8hJDMKvyRc5xGVVAR8/0UnZk8O1kB2Y4icOVBgcrLnpWEXKluVvIa4FgcbZoxI6
	 ui9FonpkzzJK9eqVmY1ia5twoQq7/N9Oj+1tN5Oc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 13 Dec 2024 00:00:30 +0100
Subject: [PATCH bpf] bpf: fix configuration-dependent BTF function
 references
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241213-bpf-cond-ids-v1-1-881849997219@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAA5rW2cC/x2MQQqAIBBFryKzTkiRpK4SLVLHmo2KQgTi3Rtav
 s/7r0PDSthgEx0qPtQoJwY1CfD3mS6UFJhBz9oorbR0JUqfU+C9ydVF5xcTgrUO+FIqRnr/3A5
 swjHGB1slDRhjAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734044433; l=3913;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7QLwXxqiXHK9GxQGN/b7k3jlhS5iyReQ14GxQy93dNU=;
 b=iFMRFxFRZhLYX6ZjIvxGwu4AbMkFGFKKTsmUqyawE6GMp3A9SGg131hRovYSSJzvbQ+RcGmJ9
 42hc61fmHVSCYKFSQTncIRcShBgc5QCCVV6/ZO+dltldHVKJJ1iH41K
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
 kernel/bpf/helpers.c  | 4 ++++
 kernel/bpf/verifier.c | 8 ++++++++
 2 files changed, 12 insertions(+)

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
index 5e541339b2f6d1870561033fd55cca7144db14bc..77bbf58418fee7533bce539c8e005d2342ee1a48 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5526,7 +5526,9 @@ static bool in_rcu_cs(struct bpf_verifier_env *env)
 
 /* Once GCC supports btf_type_tag the following mechanism will be replaced with tag check */
 BTF_SET_START(rcu_protected_types)
+#ifdef CONFIG_NET
 BTF_ID(struct, prog_test_ref_kfunc)
+#endif
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 #endif
@@ -5534,7 +5536,9 @@ BTF_ID(struct, cgroup)
 BTF_ID(struct, bpf_cpumask)
 #endif
 BTF_ID(struct, task_struct)
+#ifdef CONFIG_CRYPTO
 BTF_ID(struct, bpf_crypto_ctx)
+#endif
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
@@ -11529,8 +11533,10 @@ BTF_ID(func, bpf_rdonly_cast)
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
@@ -11558,8 +11564,10 @@ BTF_ID(func, bpf_rcu_read_unlock)
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

---
base-commit: 5d287a7de3c95b78946e71d17d15ec9c87fffe7f
change-id: 20241212-bpf-cond-ids-9bfbc64dd77b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


