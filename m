Return-Path: <bpf+bounces-47447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3409F97D5
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 18:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A5F189E9B7
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC3A22A7F9;
	Fri, 20 Dec 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9Np/iGg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1122A1E9;
	Fri, 20 Dec 2024 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714755; cv=none; b=qi8w9TaNmUgbMkbY5wNZBYNlgFwtWWmBGzhFmFKrRtDnCxQb+DmBqU0ZBAuEzACfZaV64YDXQhnhEA0N+bjwdE71hNUtjvri3cSGfDgEFfZncco/b/5RO1ACzGJOFZHEzhdQlCu18H+x2REm1I5qEq4wLYkhX+Nyc1zZHxWH4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714755; c=relaxed/simple;
	bh=YVehYeJuQa12GBdV0s6MUz58lf0NBaxEd05O12NfJo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRniubKTLdm9qrsT/xeQ/H4B9X1/jf95+k+98qNhfRTKIju56YOLFaj73SvZC3VH/pTltoxW9lmRyr3q5sVUIOHF/NwZdD2Rnm8Zw8YcU364OO7suZivdXDrfCpuKDEMn73gkb1DEvgoZhu7MAx20zhV7XnCeIJQ4c3hZP2AglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9Np/iGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CDFC4CECD;
	Fri, 20 Dec 2024 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714754;
	bh=YVehYeJuQa12GBdV0s6MUz58lf0NBaxEd05O12NfJo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9Np/iGgOYhheWJUgSBi/Ar4DSznL9bA3qH8aqo1iBPNwglWzWBn2uBbCUjZwe1Ol
	 MKcOVWsfCrV6UPjYfbkFT5gJojPe3NxSXz0k0+v27k2QIe3Awjzmqi+HTDQWga5J7l
	 qHMVwTuY3+M5cD56mfiduCpbVOzn9sydQla2dRdu7C2GxM59XltLQWmnWTVdgh7iUk
	 ivyplQjoJWcqPYGd8yJl9WaBU5IyTxGT5OW0fPdo+GJiXDqh2Aqfe+61DNwh3AQMgU
	 1ESZz7/5BXmytvoLJGrd6uzKMN90OZVAkDTlFx67I7KNIyaTNpttPE2ibfGt6ypED8
	 dChpWUlzKKqig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 28/29] bpf: refactor bpf_helper_changes_pkt_data to use helper number
Date: Fri, 20 Dec 2024 12:11:29 -0500
Message-Id: <20241220171130.511389-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit b238e187b4a2d3b54d80aec05a9cab6466b79dde ]

Use BPF helper number instead of function pointer in
bpf_helper_changes_pkt_data(). This would simplify usage of this
function in verifier.c:check_cfg() (in a follow-up patch),
where only helper number is easily available and there is no real need
to lookup helper proto.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20241210041100.1898468-3-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: 1a4607ffba35 ("bpf: consider that tail calls invalidate packet pointers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h |  2 +-
 kernel/bpf/core.c      |  2 +-
 kernel/bpf/verifier.c  |  2 +-
 net/core/filter.c      | 63 +++++++++++++++++++-----------------------
 4 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7d7578a8eac1..5118caf8aa1c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1121,7 +1121,7 @@ bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
-bool bpf_helper_changes_pkt_data(void *func);
+bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
 
 static inline bool bpf_dump_raw_ok(const struct cred *cred)
 {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3af5f42ea791..2b9c8c168a0b 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2940,7 +2940,7 @@ void __weak bpf_jit_compile(struct bpf_prog *prog)
 {
 }
 
-bool __weak bpf_helper_changes_pkt_data(void *func)
+bool __weak bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
 {
 	return false;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b2008076df9c..71575f83860b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10519,7 +10519,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	}
 
 	/* With LD_ABS/IND some JITs save/restore skb from r1. */
-	changes_data = bpf_helper_changes_pkt_data(fn->func);
+	changes_data = bpf_helper_changes_pkt_data(func_id);
 	if (changes_data && fn->arg1_type != ARG_PTR_TO_CTX) {
 		verbose(env, "kernel subsystem misconfigured func %s#%d: r1 != ctx\n",
 			func_id_name(func_id), func_id);
diff --git a/net/core/filter.c b/net/core/filter.c
index 9a459213d283..33125317994e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7909,42 +7909,35 @@ static const struct bpf_func_proto bpf_tcp_raw_check_syncookie_ipv6_proto = {
 
 #endif /* CONFIG_INET */
 
-bool bpf_helper_changes_pkt_data(void *func)
-{
-	if (func == bpf_skb_vlan_push ||
-	    func == bpf_skb_vlan_pop ||
-	    func == bpf_skb_store_bytes ||
-	    func == bpf_skb_change_proto ||
-	    func == bpf_skb_change_head ||
-	    func == sk_skb_change_head ||
-	    func == bpf_skb_change_tail ||
-	    func == sk_skb_change_tail ||
-	    func == bpf_skb_adjust_room ||
-	    func == sk_skb_adjust_room ||
-	    func == bpf_skb_pull_data ||
-	    func == sk_skb_pull_data ||
-	    func == bpf_clone_redirect ||
-	    func == bpf_l3_csum_replace ||
-	    func == bpf_l4_csum_replace ||
-	    func == bpf_xdp_adjust_head ||
-	    func == bpf_xdp_adjust_meta ||
-	    func == bpf_msg_pull_data ||
-	    func == bpf_msg_push_data ||
-	    func == bpf_msg_pop_data ||
-	    func == bpf_xdp_adjust_tail ||
-#if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
-	    func == bpf_lwt_seg6_store_bytes ||
-	    func == bpf_lwt_seg6_adjust_srh ||
-	    func == bpf_lwt_seg6_action ||
-#endif
-#ifdef CONFIG_INET
-	    func == bpf_sock_ops_store_hdr_opt ||
-#endif
-	    func == bpf_lwt_in_push_encap ||
-	    func == bpf_lwt_xmit_push_encap)
+bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
+{
+	switch (func_id) {
+	case BPF_FUNC_clone_redirect:
+	case BPF_FUNC_l3_csum_replace:
+	case BPF_FUNC_l4_csum_replace:
+	case BPF_FUNC_lwt_push_encap:
+	case BPF_FUNC_lwt_seg6_action:
+	case BPF_FUNC_lwt_seg6_adjust_srh:
+	case BPF_FUNC_lwt_seg6_store_bytes:
+	case BPF_FUNC_msg_pop_data:
+	case BPF_FUNC_msg_pull_data:
+	case BPF_FUNC_msg_push_data:
+	case BPF_FUNC_skb_adjust_room:
+	case BPF_FUNC_skb_change_head:
+	case BPF_FUNC_skb_change_proto:
+	case BPF_FUNC_skb_change_tail:
+	case BPF_FUNC_skb_pull_data:
+	case BPF_FUNC_skb_store_bytes:
+	case BPF_FUNC_skb_vlan_pop:
+	case BPF_FUNC_skb_vlan_push:
+	case BPF_FUNC_store_hdr_opt:
+	case BPF_FUNC_xdp_adjust_head:
+	case BPF_FUNC_xdp_adjust_meta:
+	case BPF_FUNC_xdp_adjust_tail:
 		return true;
-
-	return false;
+	default:
+		return false;
+	}
 }
 
 const struct bpf_func_proto bpf_event_output_data_proto __weak;
-- 
2.39.5


