Return-Path: <bpf+bounces-62880-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7348BAFF8AB
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 07:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B3B5630B8
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 05:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9460286D6B;
	Thu, 10 Jul 2025 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hfrQuwvl"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420205383;
	Thu, 10 Jul 2025 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126930; cv=none; b=RAXjFMJx8654T5wXIId4AX2jnj1puFQbkZyBheF1EGryp6rlm/31muQpdtr2nlijsuQaXYP/T8JaHNs7ZgqrPyl1fwEsw1LDwXEOyPjEqD+Z5VkKNe3ZJIjM3vCWmyO7YDozU2w85FYV1aaGKD6UmdGrUt2U5nnHE0HIS99l17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126930; c=relaxed/simple;
	bh=GlRTsNWYMTrAcXnXTGWwFfiMFFeCUzzVnFeqbx0HAzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lLruVrfmdSKcswuL2Dc/p3peSmouf9/JLsdOS2Q6ZkrWb3tcW7w+KnAZs8p7ybNYm0JpRl1BLlOZIvisfVNALgJ4aFHdAXFpPG5soq1YUdNLYIad2mcZHukIayCB0zR+anrPYhE3y4fkTlZ2hqQaA0dfUDv3zApk/oG6U/nMGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hfrQuwvl; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ok
	Omog+xA6ZskFrf7mJLxT2vs7YHH1y9jNOPVQ1DbRU=; b=hfrQuwvlfSGZevpZBB
	M2b5RmvtGGFuO64H2DqqDVLLUBe4XlCOZgtADHgyYvQctTxuSMIAgALe2gogRy65
	hxvwpOVDDxLTgZziu789UyTFNTG20xfRBGv7dBE2NuXwpFafhKe2BVlYFMrKZNVb
	yRVRyckjLVamBdkIIHDmVBUzk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCnddKLVW9o_xi_Dw--.25287S2;
	Thu, 10 Jul 2025 13:54:21 +0800 (CST)
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
	olsajiri@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 bpf-next] bpf: Clean up individual BTF_ID code
Date: Thu, 10 Jul 2025 13:54:19 +0800
Message-Id: <20250710055419.70544-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnddKLVW9o_xi_Dw--.25287S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww15KFy5AF4UKw15ZrWDJwb_yoW7tr1fpF
	W8Z3srCr48tw4YgF1DJF4Uuryag3Z5W3y7Cr4DC3ySkF1DXryDWF1jgw13ZF1a9ryqgr9a
	qr109F1avw1fuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnYFAUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbipRWGeGhvJOiDmgABsd

From: Feng Yang <yangfeng@kylinos.cn>

Use BTF_ID_LIST_SINGLE(a, b, c) instead of
BTF_ID_LIST(a)
BTF_ID(b, c)

Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
Changes in v2:
- Add the missing ones, thanks: jirka.
- Link to v1: https://lore.kernel.org/all/20250709082038.103249-1-yangfeng59949@163.com/
---
 kernel/bpf/btf.c         | 3 +--
 kernel/bpf/link_iter.c   | 3 +--
 kernel/bpf/prog_iter.c   | 3 +--
 kernel/kallsyms.c        | 3 +--
 kernel/trace/bpf_trace.c | 3 +--
 net/ipv6/route.c         | 3 +--
 net/netlink/af_netlink.c | 3 +--
 net/sched/bpf_qdisc.c    | 9 +++------
 8 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2dd13eea7b0e..0aff814cb53a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6200,8 +6200,7 @@ int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_ty
 	return kctx_type_id;
 }
 
-BTF_ID_LIST(bpf_ctx_convert_btf_id)
-BTF_ID(struct, bpf_ctx_convert)
+BTF_ID_LIST_SINGLE(bpf_ctx_convert_btf_id, struct, bpf_ctx_convert)
 
 static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name,
 				  void *data, unsigned int data_size)
diff --git a/kernel/bpf/link_iter.c b/kernel/bpf/link_iter.c
index fec8005a121c..8158e9c1af7b 100644
--- a/kernel/bpf/link_iter.c
+++ b/kernel/bpf/link_iter.c
@@ -78,8 +78,7 @@ static const struct seq_operations bpf_link_seq_ops = {
 	.show	= bpf_link_seq_show,
 };
 
-BTF_ID_LIST(btf_bpf_link_id)
-BTF_ID(struct, bpf_link)
+BTF_ID_LIST_SINGLE(btf_bpf_link_id, struct, bpf_link)
 
 static const struct bpf_iter_seq_info bpf_link_seq_info = {
 	.seq_ops		= &bpf_link_seq_ops,
diff --git a/kernel/bpf/prog_iter.c b/kernel/bpf/prog_iter.c
index 53a73c841c13..85d8fcb56fb7 100644
--- a/kernel/bpf/prog_iter.c
+++ b/kernel/bpf/prog_iter.c
@@ -78,8 +78,7 @@ static const struct seq_operations bpf_prog_seq_ops = {
 	.show	= bpf_prog_seq_show,
 };
 
-BTF_ID_LIST(btf_bpf_prog_id)
-BTF_ID(struct, bpf_prog)
+BTF_ID_LIST_SINGLE(btf_bpf_prog_id, struct, bpf_prog)
 
 static const struct bpf_iter_seq_info bpf_prog_seq_info = {
 	.seq_ops		= &bpf_prog_seq_ops,
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 4198f30aac3c..1e7635864124 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -829,8 +829,7 @@ static struct bpf_iter_reg ksym_iter_reg_info = {
 	.seq_info		= &ksym_iter_seq_info,
 };
 
-BTF_ID_LIST(btf_ksym_iter_id)
-BTF_ID(struct, kallsym_iter)
+BTF_ID_LIST_SINGLE(btf_ksym_iter_id, struct, kallsym_iter)
 
 static int __init bpf_ksym_iter_register(void)
 {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e7f97a9a8bbd..c8162dc89dc3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -781,8 +781,7 @@ BPF_CALL_1(bpf_task_pt_regs, struct task_struct *, task)
 	return (unsigned long) task_pt_regs(task);
 }
 
-BTF_ID_LIST(bpf_task_pt_regs_ids)
-BTF_ID(struct, pt_regs)
+BTF_ID_LIST_SINGLE(bpf_task_pt_regs_ids, struct, pt_regs)
 
 const struct bpf_func_proto bpf_task_pt_regs_proto = {
 	.func		= bpf_task_pt_regs,
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 79c8f1acf8a3..0d5464c64965 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6805,8 +6805,7 @@ void __init ip6_route_init_special_entries(void)
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
 DEFINE_BPF_ITER_FUNC(ipv6_route, struct bpf_iter_meta *meta, struct fib6_info *rt)
 
-BTF_ID_LIST(btf_fib6_info_id)
-BTF_ID(struct, fib6_info)
+BTF_ID_LIST_SINGLE(btf_fib6_info_id, struct, fib6_info)
 
 static const struct bpf_iter_seq_info ipv6_route_seq_info = {
 	.seq_ops		= &ipv6_route_seq_ops,
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e8972a857e51..bea064febf80 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2869,8 +2869,7 @@ static const struct rhashtable_params netlink_rhashtable_params = {
 };
 
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_PROC_FS)
-BTF_ID_LIST(btf_netlink_sock_id)
-BTF_ID(struct, netlink_sock)
+BTF_ID_LIST_SINGLE(btf_netlink_sock_id, struct, netlink_sock)
 
 static const struct bpf_iter_seq_info netlink_seq_info = {
 	.seq_ops		= &netlink_seq_ops,
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 7ea8b54b2ab1..adcb618a2bfc 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -130,8 +130,7 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
-BTF_ID_LIST(bpf_qdisc_init_prologue_ids)
-BTF_ID(func, bpf_qdisc_init_prologue)
+BTF_ID_LIST_SINGLE(bpf_qdisc_init_prologue_ids, func, bpf_qdisc_init_prologue)
 
 static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 				  const struct bpf_prog *prog)
@@ -161,8 +160,7 @@ static int bpf_qdisc_gen_prologue(struct bpf_insn *insn_buf, bool direct_write,
 	return insn - insn_buf;
 }
 
-BTF_ID_LIST(bpf_qdisc_reset_destroy_epilogue_ids)
-BTF_ID(func, bpf_qdisc_reset_destroy_epilogue)
+BTF_ID_LIST_SINGLE(bpf_qdisc_reset_destroy_epilogue_ids, func, bpf_qdisc_reset_destroy_epilogue)
 
 static int bpf_qdisc_gen_epilogue(struct bpf_insn *insn_buf, const struct bpf_prog *prog,
 				  s16 ctx_stack_off)
@@ -451,8 +449,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
-BTF_ID_LIST(bpf_sk_buff_dtor_ids)
-BTF_ID(func, bpf_kfree_skb)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb)
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-- 
2.43.0


